Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C851E42D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789655; cv=none; b=N+EQRebGVzpE1eUDTIibkrpdBXFQBOoQnVdg/mVMZ0ghnbHHK5WyF00NRkthI+hofGSwYPVlJLAXTEt69NPPe2q6x+wVA4gBCQ8h5o6HmZRft8SqXEPkSMJa0h8/fKV8xP3ElHUDjPwaw9yqFSrpW66CRD7eZkfE2fl957OsJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789655; c=relaxed/simple;
	bh=KS8/dPRStT7Gh4//gR6jHVn6fGbv/4fkSpSAc6YtPrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIuG54q0zF6gdXF/L60UVUg7ePp7Pw7xXpwi00nWv+iX/ZZK2KuYhPk+33ozCzlzCA5Vs7k8mT6WefdhHkdIq6yrjdpE4AAXvW/wSSphIQ74gm+q91pcXhaFgcuxwIJwN4xq5SseWIpLHggIjnZqU042ZjZ4hy0AGQXlvs+Xyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Reoon2sM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Reoon2sM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A70E1F00899;
	Wed, 30 Sep 2026 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789653;
	bh=NOmHZWT4ZbhlebJ+PJgvPY9CYqucjg9hwm/TpO0biq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Reoon2sMrC8LGQEVGyGDusInOD3NL8P3/QkdsMZOEvr+RkUFkWRNWirKDUjFUKfFU
	 veVWRwQF3Hly33bUClAwWJDFUAchcyvVIKaFhLdCZ0lZ2uk6vmBLrIaEMGC+WxSJZu
	 w56Me6Mx93dpquA+G790lIIXQBbR/nXJcGDNoUGv24kYHOWz66iuJ6NbbhnqfZJgEw
	 qv6PLGfef2YJ6plPtEQ2Fj1Kr0NB0N0NYShZP+HsUUvm6zBopLxxoUtboWz5VlQiFC
	 q6wGr7Euu48qjrEq2yXgKQ+Zq1khfJb43+OPzNG54Blrx+PvQj/fn1VSkwToHRN4Od
	 Q50qakIaCpBqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adarsh Das <adarshdas950@gmail.com>,
	syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] smb: client: delete compound mids on send failure before unlock
Date: Wed, 30 Sep 2026 13:34:09 -0400
Message-ID: <20260930173409.3642584-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173409.3642584-1-sashal@kernel.org>
References: <2026092926-hedging-absolve-77a2@gregkh>
 <20260930173409.3642584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adarsh Das <adarshdas950@gmail.com>

[ Upstream commit 8f6f8a48399f82f4a83f7b9f25b9707e0062a4f9 ]

When sending a compound request fails, smb_send_rqst() kicks off a
reconnect. compound_send_recv() still has those mids on pending_mid_q,
but it unlocks the server without removing them first.

During reconnect, cifs_abort_connection() walks pending_mid_q and runs
each mid callback. With no response yet, those callbacks return credits
and drop in_flight. Then compound_send_recv()'s send-error path returns
the same credits again. in_flight ends up decremented twice and
smb2_add_credits() WARNs.

syzbot hits this during SMB2_negotiate when the socket send fails.

cifs_call_async() already calls delete_mid() before unlock on send
failure. Do the same for compound chains and set cancelled_mid[] so the
out: path does not delete them again.

Fixes: ee258d79159a ("CIFS: Move credit processing to mid callbacks for SMB3")
Reported-by: syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6a727d22.40259c87.584f4.04ce.GAE@google.com
Tested-by: syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 4fedc4a845435..b501beb898ff8 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -963,6 +963,10 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	if (rc < 0) {
 		revert_current_mid(server, num_rqst);
 		server->sequence_number -= 2;
+		for (i = 0; i < num_rqst; i++) {
+			delete_mid(server, mid[i]);
+			cancelled_mid[i] = true;
+		}
 	}
 
 	cifs_server_unlock(server);
-- 
2.53.0

