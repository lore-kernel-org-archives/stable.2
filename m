Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0133BBFA1
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617768; cv=none; b=cEoBvD3/AqatIpxSTSY7vB4evvUrtXj/ZZqKaeXxiNL7Okp2nDdhlp7GQC9M04yiw2Oo7W+k1h29U3m+LNXoRM9Wqz+Fn57LSb4zfTpQUTz6nXUYWYfREpENFP/74CkeqgtmHMQDXzUQRdDKaNeXJSW1SHf0z8sY0QSczLOmFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617768; c=relaxed/simple;
	bh=2afOKN0omQh6usp9zXUcdY1fVWgzEwNFPtSC6PXfoGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YisVHBsmx21bpNlxXKHXUAlUQrvJwIdGb3Y8TU43BeEEcLSENioolCijFT5Jk/VBLufzBEclWxEUJttbsWj81oKsvUakBbdYiEZMKnT07yi+7bVvDTGPsWfyXk39v6BGa7zMFIGUrEj5FRCYoz2jksKpi9NP53+HHzUuZIvndSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI8ZziYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI8ZziYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0A71F00893;
	Thu, 17 Sep 2026 04:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617767;
	bh=wi4hfW5XoPU1+hFHuCgUSiVuN0hujc6ELesBRjTz4Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nI8ZziYHk0Qm6Hn+ZbWyeSGyvoGkX4Qb0PTPakhRGnWR7ewiTXA+bgRnMKLzSTIVx
	 YYDIvm+nxg9e+vnFHxDt9LWUqcn8ygTYg/CU5cfStdh8zVCLP45Savk3k8WVOA0a+K
	 A+18/l5gK3rV7ghNLiP4jm5NOaOCE9b6cMag9j1YzLtaMXobviqtEC0V6hdQv7rDTo
	 ddI9BHVooDPBv0CM5Bvd8GrB/gAbsD6aptKJf5T4EAGXNxu+tKvpUiN6woNrktbnWy
	 q4RL2C3rkgVLyfmdMIZy/lImTyE3Ca+K1TVdtbe4CEAj7fQoD8Aus868QpMQJ5LcAf
	 yWyZCK2pMYjqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: pin DFS superblock in iterator callback
Date: Thu, 17 Sep 2026 00:02:44 -0400
Message-ID: <20260917040244.4138555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091644-acid-unclasp-cda8@gregkh>
References: <2026091644-acid-unclasp-cda8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit d806d5a85dcbe2a0f181b2f0f9f61ddfbefa1818 ]

tcon_super_cb() stores a raw superblock pointer, but __cifs_get_super()
takes its active reference only after iterate_supers_type() has dropped
s_umount and its passive reference. Concurrent DFS automount expiry can
therefore free the superblock before cifs_sb_active() uses it.

A deterministic KASAN test reproduces the race as:

  BUG: KASAN: slab-use-after-free in cifs_sb_active+0x77/0x80

The same test passes with this change applied.

Take the active reference in the callback while iterate_supers_type()
still holds s_umount shared. cifs_put_tcp_super() remains the matching
release.

Fixes: bacd704a95ad ("cifs: handle prefix paths in reconnect")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ Adapted tcon_super_cb() changes to the older tcp_super_cb() callback and its server-only matching logic. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/misc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index cb7fb2c4ea71f..df0111d95e1c8 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1226,8 +1226,14 @@ static void tcp_super_cb(struct super_block *sb, void *arg)
 
 	cifs_sb = CIFS_SB(sb);
 	tcon = cifs_sb_master_tcon(cifs_sb);
-	if (tcon->ses->server == server)
+	if (tcon->ses->server == server) {
+		/*
+		 * Take the active reference while iterate_supers_type() still
+		 * holds s_umount shared.
+		 */
+		cifs_sb_active(sb);
 		sd->sb = sb;
+	}
 }
 
 static struct super_block *__cifs_get_super(void (*f)(struct super_block *, void *),
@@ -1243,15 +1249,8 @@ static struct super_block *__cifs_get_super(void (*f)(struct super_block *, void
 
 	for (; *fs_type; fs_type++) {
 		iterate_supers_type(*fs_type, f, &sd);
-		if (sd.sb) {
-			/*
-			 * Grab an active reference in order to prevent automounts (DFS links)
-			 * of expiring and then freeing up our cifs superblock pointer while
-			 * we're doing failover.
-			 */
-			cifs_sb_active(sd.sb);
+		if (sd.sb)
 			return sd.sb;
-		}
 	}
 	return ERR_PTR(-EINVAL);
 }
-- 
2.53.0

