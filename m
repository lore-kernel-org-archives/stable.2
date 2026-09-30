Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974474D797D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804553; cv=none; b=dKtEoiDfMhsPvV9ADHG54qpz7xt0aH2A4anh5uCcvhcJaX0fvAWh46lbJWwAcKFy5DQqW+bz25IBVx3PiA1+tyU4AWraOTaWOpzPNzjvI3j0Ctybe5PBhaFQD/UP35Ua7etHOOUqYCZUOllZiYDI9vA4ucczQfE8+6S/GVpBiEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804553; c=relaxed/simple;
	bh=sf640d9Tm5s99oqS2UJ0EOZFaMw+ZsY7ZmIosztLVME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/bQl3WalYQS/3W/R4tCOJzUu54OayqwgvHO352PTtK362rOmub/nIXqyaXSkf2V0nBaf83VNWP3WITGL9c81VVqp/YRfJYbo0hU7SnsyIK8dn0ezUmw/EJCdSzCmHwbUyD/kcGNlAchQfMPXl8zN0qwTNg9YmN3azdgVK0EEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUpzYHBH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUpzYHBH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC131F000FF;
	Wed, 30 Sep 2026 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804552;
	bh=uDTvjrLOoF+xQHfOdJuX9LUJcl1TjZSLIU9p1A98P5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OUpzYHBHnbl+C9Of1wwf6xqZPYMaabz5g8UH3XK9Jx3BGRlHJCRipQBSTnkJoHzvu
	 A3u4WtZPJoflWt2zFWo37MqsKVCeqJrv+M0kMjvZEerDQM4WuCHWv6gAaifhiE8ww/
	 7AHZUrGmbl0YncHC3oenfBA1ohgd8/LwlNPk8+HdQtjR00zWLYPUZaln2zHtbKUfrG
	 M30Zs1tZbmnpNg0XJcMWcGQv/TSl5JV+NKiG0g96k8y+PEvCGw0CKEvFffgnNDdcB6
	 G4UfkvhWFwJxMlz9sUIRy0Gu7Ge3TK/De3m8xQM/NFi36Aejax9gOlhOM2SXfM60TA
	 PWsdKS9J5fW6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adarsh Das <adarshdas950@gmail.com>,
	syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] smb: client: delete compound mids on send failure before unlock
Date: Wed, 30 Sep 2026 17:42:27 -0400
Message-ID: <20260930214227.3484209-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930214227.3484209-1-sashal@kernel.org>
References: <2026092900-threefold-unblessed-1235@gregkh>
 <20260930214227.3484209-1-sashal@kernel.org>
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
 fs/cifs/transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 8b4fbacb91fb9..f4f31fc0d6917 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -1156,6 +1156,10 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	if (rc < 0) {
 		revert_current_mid(server, num_rqst);
 		server->sequence_number -= 2;
+		for (i = 0; i < num_rqst; i++) {
+			delete_mid(server, mid[i]);
+			cancelled_mid[i] = true;
+		}
 	}
 
 	mutex_unlock(&server->srv_mutex);
-- 
2.53.0

