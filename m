Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3D346FA1
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 04:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618521; cv=none; b=kvmONmXVMpUun15nMvmaLrGuh9dug8bAgntrql9QHuYG88FgIAOMRnZgvlov6E63pTFEDSdNjCMVuWNKkuGcWyj6Xp7kHxedjZ44xYDQMCFHn+s1yWjTNeWDF+3MsU2MwtqmKg4QbALdANwj0+efrTHX/NcY3IufkbCLz4dt4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618521; c=relaxed/simple;
	bh=QIxD4nHbHmkHmCUJegigbyxZ2W6eWXC/Sej1MkYrkvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkQspsKkYK1mH7Fy3wfibhzlk73WzG3Oow5nNmUYAEyy8H9SC1PspNxkeXtwNnE4D61jXHIlZQxR741pcz2Sg5BcF73CYg2owg6f8uAYjrDZgUk8Buz62PKOsRomim2ff4gM1M2IwNrnr6u+emg6/jwahROuZ/OVxcPGRpp70rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1Wdb76S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1Wdb76S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A841F00893;
	Thu, 17 Sep 2026 04:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618519;
	bh=+7WxG+xaZScvqHYOujJOAPG36qqbLiTpugQ9nXQjn10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1Wdb76SikQNy/imBXJ9I3pJx5WYqxD+6LJpxQ8meiIewSJckRfnUYB3pmZXULh1R
	 upVwzBBl8r1GeO1oJuDQk1LqwGyn+XuxHVKEA+HkkQZ5LxRgb4mJx+3f9SifOeYHc/
	 4/0f1thk8YwVMHTc1RyUiFzNzEM6r2UuCakmnsDUBXw0LwgPSb95qDYyVeBRqRClKS
	 0vLQllsxzJyPj+XaTxsftUqiXKVmA4jpz++ST5xO02SZNhq7DW9JnW5ry6V/V9btjv
	 MBQOVnqgDTbTiT3G1eoVYoiG8tl1+kw/0bKUmhq+uMDnF69A0kEwjJ+i4U/vx42FuZ
	 k/ALtt1SHutHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: pin DFS superblock in iterator callback
Date: Thu, 17 Sep 2026 00:15:17 -0400
Message-ID: <20260917041517.4183691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091644-blouse-acre-e296@gregkh>
References: <2026091644-blouse-acre-e296@gregkh>
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
index b4199b4085db3..d6542b073add4 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1054,8 +1054,14 @@ static void tcp_super_cb(struct super_block *sb, void *arg)
 
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
@@ -1071,15 +1077,8 @@ static struct super_block *__cifs_get_super(void (*f)(struct super_block *, void
 
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

