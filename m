Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6413C09F5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794884; cv=none; b=RUaHoUv6kmVIylrgRAY3zcOmZd8Lao23nEum4ecIVeHxx9BIOB44pj9wM0uqL4xFUWSKlpqq6VDPobk5SdhQMYUhBrEIAd9ijtcSIRDKGqHsO8KTcPWZ5bVpW0lMawbAjyGbEmvgfttFNygPo8LmoKoRDjb9AjiTPtqL17YLJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794884; c=relaxed/simple;
	bh=O1VulZiqhPliYjqJTayGsllCN3ESElOn0lYwgHt/x18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJHXYie4h5PZ5a8Ywaat5WDmEVSlwP9r+ARq2gg4n9O6ogQf/yHLADCd+H4rXLUQoD9SsJAJUlDSSV/c1ZkD6htcx512PMC56Fs02GU5NK+hlkIec59YDEfWKsGWd2x5X3nm6lLomPsnVlKRNJNbDlzuSdNMR6FrDNUj+5h38LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9ZYwdm7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9ZYwdm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441101F0089F;
	Wed, 30 Sep 2026 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790794864;
	bh=2TeEPDz9+WyLBNvTDV99rUIOJcvx4iI8Hro4FbDQ8YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h9ZYwdm74ufrNM3q+K4ibhvTDu44AD0pPcuqmF1nJvMjxqpp5lY8H+SAU7nlelvsh
	 QaHygmYIq0TG5xDpfkif1G3wtN6Zd6c3o5Q5mDNYPQ4IlwOrzOOuGGN5S6I1n+Ltou
	 hrx3hj3jO097ag9jn2guyBZ+gbe6FZQNWDRoomv2sVoOZIG1Jb2hBMzpxlfPmkEk17
	 //Z+m/6g0XUY7/HkwWKK5MUqyTzIQM6Z6bxOoBMbU/xzD0gp80PjznGoUmCQuca9K0
	 mn64VltqiiHq2+D6TftpsAdt49tE6rRrLePCi+KXuRRiaJ2gPVnAS3GMmrQTokHcyv
	 /QT7F8edRSnLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adarsh Das <adarshdas950@gmail.com>,
	syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] smb: client: delete compound mids on send failure before unlock
Date: Wed, 30 Sep 2026 15:01:00 -0400
Message-ID: <20260930190100.383713-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930190100.383713-1-sashal@kernel.org>
References: <2026092927-uproar-implement-c4b4@gregkh>
 <20260930190100.383713-1-sashal@kernel.org>
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
index 7b882bafc5a5e..1b0d965e2dcae 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1180,6 +1180,10 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
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

