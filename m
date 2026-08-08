Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE64B04B4
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204136; cv=none; b=DUEWQFM3UyHvyqqg+FLgQavw+4xxA2IIKmWFcU6dK24cJvq5Q+uUI4D4sBIrzY0ZObJZjWqT75L4pgwVLxLEA1Dtb5EItSB5fPabOGO/ffKHzbAMBfzK3/EzvQ20x2wDn8qQ+oz1tHVhDCTpKU3tWIR9SBrtNyo6AC2sKoT7/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204136; c=relaxed/simple;
	bh=8Pmup/oxauyx4yWEUEyYU3U+JQ/JKlzMeITYc+OLqfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/9qEhUeATIlEsld/y6tj2WfvNX/VgRGe0xQqzxyU41/hVhj4wQa/7DT4j1745VPgoXi5yQaOJ935PxIwYWtibil/MpcMxb2fo0Gnrh8Q1Ax7XTLIs/gOuplJ8WVdKL/G4aUWbK1TtpsqdJKu0+HLLRGo1pgTRFsVCEM/bt+m/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3uZhjPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3uZhjPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D7B1F000E9;
	Sat,  8 Aug 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786204134;
	bh=d/6tDp7zNyaxN6ALJS3mnZf1gY2b9GGt8VBEh/Ujw+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S3uZhjPY+HJAnDTVHY9GOOMSkRTLGfZwZrTPZB7KgEeo926aT8Zqq9Iqq5kfmp1y/
	 Naj35BCg+ZNdS7jPJCacgbZOTc/nfkgjMF16xvgrZAxAMQGp0/rYS10uu8CT0EFZ5k
	 76YrB1jMtSGMb7DvtMxz+XfQ/s3OEb7CS9lDR9opv/SAOdRAcZ3Gw5bsxYwD+Bp3Om
	 z6P4CDJ2moFD5cjb1HJa9QEiHxqzhlwhIo53UFh6CI8oGEIc15NEhQNZxY8dKBQYvP
	 viIMMB8/BAa0CESuJWLPPr3Ykn0mY3hp3S/m2E+2CPPSKzK9VXOKgDiIgLur3IrBoM
	 hVgB57RE32D+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/6] super: remove pointless s_root checks
Date: Sat,  8 Aug 2026 11:48:47 -0400
Message-ID: <20260808154852.370323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072927-mom-flyover-909f@gregkh>
References: <2026072927-mom-flyover-909f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit af7551cf13cf7fb1d4f939db4f1f24c00550ed57 ]

The locking guarantees that the superblock is alive and sb->s_root is
still set. Remove the pointless check.

Link: https://lore.kernel.org/r/20250329-work-freeze-v2-1-a47af37ecc3d@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 749d7aa0377a ("super: fix emergency thaw deadlock on frozen block devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index c9c7223bc2a2e..5aabfcab4fc7d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -930,8 +930,7 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 
 		locked = super_lock_shared(sb);
 		if (locked) {
-			if (sb->s_root)
-				f(sb, arg);
+			f(sb, arg);
 			super_unlock_shared(sb);
 		}
 
@@ -967,11 +966,8 @@ void iterate_supers_type(struct file_system_type *type,
 		spin_unlock(&sb_lock);
 
 		locked = super_lock_shared(sb);
-		if (locked) {
-			if (sb->s_root)
-				f(sb, arg);
-			super_unlock_shared(sb);
-		}
+		if (locked)
+			f(sb, arg);
 
 		spin_lock(&sb_lock);
 		if (p)
@@ -991,18 +987,15 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 
 	spin_lock(&sb_lock);
 	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (sb->s_dev ==  dev) {
+		if (sb->s_dev == dev) {
 			bool locked;
 
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			/* still alive? */
 			locked = super_lock(sb, excl);
-			if (locked) {
-				if (sb->s_root)
-					return sb;
-				super_unlock(sb, excl);
-			}
+			if (locked)
+				return sb; /* caller will drop */
 			/* nope, got unmounted */
 			spin_lock(&sb_lock);
 			__put_super(sb);
-- 
2.53.0

