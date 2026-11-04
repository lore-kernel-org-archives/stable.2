Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818297;
	b=OwQtsr8ymmPKtrOG3KuU/U6a0WueIBB2IwR+NsBg9xMdVDBPdDcA1Foyewyfk+f/ADwr
	 7Pim8pcA2s/fHP2gUuueYUbj9pEYoiTq6GS9Sg1A3igpiqJUNhvbCAaixoPs7kwiC+7f6
	 32ugbPBqQY9c0Xf3mG2w1mBJRPw7QhqtdvSUBaGgWAW6HOnmy1ZtxtaZT37fE54dQ6zU5
	 5q5kXiDefzgUnqzY3qLiak1Guv3CzmWPP+838e1kCGHUDJADUqLfjt7YDWubdduKf1PDh
	 Lxz3gM+YkLgk4dkBTQHnr4x7zjPUzHeq7bF7Szk/7UXfdKjKbqt2BUgq9/DnSzj1q9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mrr2SsBpmVWLOIEOT48PyurnC8zgreuJ7g0fGQKuitk=;
	b=X0KTGz/1QkuN87gqFOccUkxaeYVEGV2ooHbcxzEJv3ie/p1swYUbymSQMafuP9dfPEVL
	 +Rd+0t7o3fcPDQnqQ7q0Mhx6CgjWv1kGeogruNE6gdnGg6fgKWrNZd6Co2cee4TnuTCpl
	 lXuiuTUs+ci0poOy7NSWYqq1oGgn39DHiahct/gs/vLyhWV46tyyXKikhAXj//6SBUsx5
	 vvXQ6dzCdUNwNzmETJ9p8DerTmkXvfs2QPtS5ww8D9tQgE/oCQk3IO2iKvwHX2duHzk7U
	 Z4E07uaXcZUbLylutLN5f7hBNPD3fO8V0ko7qF7wl1tLqPEOzcO7Jqea7o4XEH/E1sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADtGWJte;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7F606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5B7F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ADtGWJte
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490c1d337d8so347778f8f.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818295; x=1794423095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mrr2SsBpmVWLOIEOT48PyurnC8zgreuJ7g0fGQKuitk=;
        b=ADtGWJteQDh2VteElVOy14wb2gFHPj3Mm9n8h3zsZWRf8CWRjkRjONjOovYUtYFXD3
         Z7TebCe5RyRIrUY5mkugRCGMAU4o+hgmtIarAHORPJUfdOtJIz2r1A9qkzqO/VqIrYw2
         eGprSue4r7uiNBOk4oPBP9+pzVJGEyRit4WvLdC0/Hs/a72YVrXtjBPUCAb1Rmg3mTFr
         CPV84Vg9KbwgUm90m6uGSLVXCTMuyjLZGT+fFRHNMH/FvX1eMnQ0SoH9+z6gquOVBUMS
         CVVdFOc0poBJc5iyGZHgBkoFvlvckdoo1cD7ai0GNyg/FKycjvVZJQDiSx6LgdF+7sN2
         zm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818295; x=1794423095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mrr2SsBpmVWLOIEOT48PyurnC8zgreuJ7g0fGQKuitk=;
        b=oAJv67etD2I8LHNPWZT9ha+FGrKe6OBiRQtOJoafNQuaDZJf+huuSzO6VKPn5Qzd/k
         mdvXeHbv/R/+EtH2FPpFz3Rzrdi3vFNc8YI4mX/ojs0v3f+q6RC3IPV1pYFww/eGRFTs
         VK0x3LWMyyexQkkPKo0/wxbFzP+q8uXnPhZb3FuLsPkEl4ttoQ6wMASh8b914/TKmuVE
         MUC4OSOgxP1cT3gXdTOQoo4p3f2A/LwNpDRiZCKC4/AihhttBgJxa2XAQARBAOVuNxZ4
         Msy0vfdFikkjfLRxVKfB1CScfaWp/qybPcLGOQrUrsRlSIY/bjusgLYmKnecwO2TNf3r
         RSAA==
X-Forwarded-Encrypted: i=1; AKwUvBxNa9V4DkQIVrnJlbQWZSo9SqlwTZqYVIMgqTg2KvMMApGQPJ3cJZ1bRX6+m8cB8mvxjzYMnhk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kxlYGhztsUG+ExNgfrILfmVEk/07+kKOYgJ57KnqFTzDpN7PJ
	n9Fnh0CcfjowxDNj+X/ap3ur7hFjCWv9HRxfohZkoCDF7OdCqa6kJuOW
X-Gm-Gg: AYBFou0mqHwC7DtSr9yfYt2vSftn9n65BFgphDh71bKPNHUDdThq1LdHivSe6AKxH4W
	XAqPLo5aax37eudROGQI+ZI5o6NUWGdB+uGLFQhEboEdd6M71suHtYeWHmUCeBYVL4+7JFe/utd
	sjGdGtBElhZLuag0wLaquEY2jEyO8Dw0g0r8H/04lXk1XZOaVYDKFQhWmIp7hOgZxzGEv6pb1iY
	C42pUtOMpiQi/z16U/wXvS/GCEGiGTwdYblsYoAUJpgsdKTPsUBf2I2JafuFtUQTQHpsFILQ+Yu
	FdalMj11Vveq2cDI9oDzNNysogs+9PtZQPrSfe6eWQCn9bx2hO5EVCY+Tbr4lCfL5CpMpk+Tziw
	iQpJpUf9w+FGBV7PmXq8WhHuZPDqRL0/JU7O9HqqnDX1jJQJHFT1w/kosmGuymJWVuMY+KUp61C
	Hq83kT8vt1iHYn2bwCguxQ9zB7lCbJ3PRTOZLxeLB4Dfdm/KuykKQ+NXrtFOt9LVhxbuIHXIZu0
	bFnAheL22nTBUyqsvEOib9c+Vyushm4vdnye5hIkrYJEwKJ1EBP8zme0LwaFU2LHkXvmZSUD3ta
	GOxZl0eVCFXm1hFJYy5YM6gkF3k/L/EYSInz4Nlv2MHJ9Pa6s+ZcsZ6IpPfpffL55tZ4gR2GJgD
	VMq2deeP+mMvL
X-Received: by 2002:a05:6000:4a07:b0:48e:68d5:81a6 with SMTP id ffacd0b85a97d-48e6e4f53fbmr42068564f8f.34.1793818294901;
        Wed, 04 Nov 2026 10:51:34 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea180e7csm5380394f8f.5.2026.11.04.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:51:34 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 6.1] ovl: set OVL_WHITEOUTS before publishing the upper dir
Date: Wed,  4 Nov 2026 19:51:31 +0100
Message-ID: <20261104185133.3630642-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

commit cbec8610ec5aaf35df50094ff639febc23f20773 upstream.

Listing a directory while it is copied up causes a use-after-free of
the readdir cache.

A merge directory must never be iterated as a real upper directory:
that mode frees the cache in OVL_I(inode)->cache without looking at
its refcount, while files opened in merged mode still use it.
ovl_copy_up_workdir() publishes the upper dentry before it sets
OVL_WHITEOUTS, and ovl_dir_open() samples both without a lock, so an
open between the two stores finds the upper directory and takes it
for a real one.

With a delay between the two stores, an unprivileged process that
listed a directory during its copy-up saw only "." and "..", and its
next getdents freed the readdir cache of another descriptor.

Fix this by setting OVL_WHITEOUTS before ovl_inode_update(), so that
ovl_dir_reset() agrees with ovl_dir_open(), and by testing
OVL_TYPE_MERGE() of the path type in ovl_dir_open(), so that an open
that observes the upper dentry never iterates a merge dir as a real
dir, regardless of the order in which it observes the flag.

Fixes: b79e05aaa166 ("ovl: no direct iteration for dir with origin xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: test OVL_TYPE_MERGE() instead of smp_rmb() in ovl_dir_open()]
Link: https://lore.kernel.org/linux-unionfs/CAOQ4uxh-1J2OBjnDVbrrrjy1puSOW0kABvghN85ih6dtKUBTyA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
[ backport: context: the store is followed by the unlock: label, and the
  replaced line calls ovl_dir_is_real(file->f_path.dentry) ]

 fs/overlayfs/copy_up.c | 2 +-
 fs/overlayfs/readdir.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -717,8 +717,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
 	inode = d_inode(c->dentry);
-	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+	ovl_inode_update(inode, temp);
 unlock:
 	unlock_rename(c->workdir, c->destdir);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -942,7 +942,8 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 		return PTR_ERR(realfile);
 	}
 	od->realfile = realfile;
-	od->is_real = ovl_dir_is_real(file->f_path.dentry);
+	od->is_real = !OVL_TYPE_MERGE(type) &&
+		      !ovl_test_flag(OVL_WHITEOUTS, inode);
 	od->is_upper = OVL_TYPE_UPPER(type);
 	file->private_data = od;
 
-- 
backport
