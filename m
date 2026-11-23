Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412068;
	b=BEu5aWAhfxLQ/PwBgc/t/Z4eFUj8KAnmeeYizXivyJBO5t7qDTscYwNETbzrH3rqm0/s
	 fIB0zHc9MoC9sO9KbuCWwQV3BpDEUli6WTGETFZ1qLzSPAO1vCTQnoNR8BkeEr9DJ0pd7
	 UD/bCzYJcp6Qdq7omJ1cy+UFSyawafQ3wl0SJLfn+UJ/fRLu3M6R7lk6eFAWCsyvSxl7q
	 7KAPe68BPhDAE0cI7Ox/C/2PQs8xJMiWr0X+Wfc50xqjVGWLkm/UMVmqJ5ay8OiFR8VIy
	 3b7OyVK2dQhif8ihHlN/55m04o+iOcP+/bPLRmzwJgix2Kq9F7qzQ9n7jktTx9/LI7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TL6UwEo4t7VzBEu1IbZXOdiAUAUzzK5wSbC1wgdlVr0=;
	b=ECumjfrCVMh5tFg/UgRcZeXgZBU2N7vPEEqSWUn3/H5YSwW7QUAf+E0wBRX5hlPlzx0U
	 0nZI1eJbq9LxqlG6GM9f9VtvyYEK5iHEzlqn4smMCf8r32Oa59SrA7suZQHLxBfMxmPUh
	 FuO1xvs3YvaCHWgHn0Oj1sqipQr8mMlltjjDu0JInrPKe1Jdcwmkw4iD8BlHU6HYpLaZy
	 ept5WT9l799FBmOaWSxDn9/+I3YW2XBp+P0kM4LzFm/QJlYFTKet0EZ7Kjt6D/49HxAKl
	 MqA3yx8t3sePYMHEinue3oFFyJURhzwzXa7hbTFalFmk0K0EhaKkoc5Qg32e3mvqGjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bkh3Clqf;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039C606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8039C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bkh3Clqf
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so17492225e9.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795412067; x=1796016867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TL6UwEo4t7VzBEu1IbZXOdiAUAUzzK5wSbC1wgdlVr0=;
        b=Bkh3ClqfZW8YDFCp8x3h+qrByx9HiwGPmEHmKo5SOE/0SSUKA9gYOTUs7I4/IU92+Z
         tqFW0FZZ8SXDMGb9YQJK+rIqAsfImVCwYeIQDyMkHOC8bPr/sqgSFCApXNyf+3b6hboB
         fuCo7Ptp4EnspSR10dDuabgkfAM7fCEF8Yd5NDtmNdDp2rtqSrVu8pTAPMkBaMu79HbK
         gL+r1IhRgmrVwy5Eafk8URJH28nmAnOSHYo60/JbvUWbfVx5yU0BepF/cgwmH0F6p6sp
         wTMFX1UStr9g6gn9y7Mhvd0NmO5kmvG0PtIB9vsq//OB6SklOTc03UeGwbchLuI6NeRz
         j2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412067; x=1796016867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TL6UwEo4t7VzBEu1IbZXOdiAUAUzzK5wSbC1wgdlVr0=;
        b=j1DRr3vFYzhACUWNrI6dSA3DmbVD/iCqEetCqR6xxmSyUjFwShJWo9U/0YILZTaaya
         +eWIuc+Jb8M09fvVi17tZuaZ7PAmGAevnSDX9SHwk5aVSnwmrKTwHm5a6Wos14Z7bDrl
         mNFFW1pkWk9EUA0ZZLYMzJWZnYltjmENZuA9xxX53q7nm8hgPrnrnMb3Fog/zw0uvYBu
         pfWJd3c9wkzmU6U20oqkPgefoCFUV6qxpaguVC13JZXVPNIDyJg+eRinjNbXt1/FJmLe
         lYmSmr3ArJ8ZqQrSbiBxY8py8JVeuf9voGNn9ueF7iNJeu+yuqayjU9S71MuRcfSW/UO
         FFlQ==
X-Forwarded-Encrypted: i=1; AL+hErFY96ghqFRi5GWvmvYHYWFw3+Azr+hmYJ9MGCgVeah98I32orXiGKy//6+ehc4+uZe/c8TgoGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zVLFJGtcKS3Y3ADUOZyPU8/Hl5JFkI0zfoCGS2RTs0cOGuNjK
	VSXEMH22btv0zDwbSDtBth3IpmrprVKNPv5p+z4jlNPwjAFbJkIAYFd+nrD2z/t9bWY=
X-Gm-Gg: AZFdTZcFCCY1pGE01Gfmhjau728ReQeYidZdvn0tck1kAz/Vc9KNwz1W4IeBejEcA9Y
	zGK9Nhp5jbrh/1Jk44edaazEF3kgHAqNYrol2ka0KApftztTpF1dwCuvVfeppL0Y8LEwZGDsvPt
	qQf6UmPda7njUUC3CQEFHFYGJwIrpZZWvbGJ47+F/p+CSUqGzPuPBaxIHay2ja5jjTfYfTCBqKx
	6Ylkh/WB/PXSzBiI1SjIYg1cht/GsjJKV4Ic8MNyoKkmHDoLgd3NPiJhHWvcvnItjzcxyOesuMW
	4dAC8J79f6BY8VKJ1fX6ChapcpLL+jB4g2KEri9naQ1C14Y7IBFi4LPNuFAt0hwcr3IdKjVJt9Q
	cflr4d1YYOUeC7Ys9ie2kQ2RdIUGm6l9Ng0xwkcFd3xkKHUpfv8C6LTmfQKv+qSu5YksIziGZYO
	kI4baqXVwVVWfr92pWi+cxlOO9YtWo6t+enByPv1OHS7KJGlbXnBBhkOieodqMa53CFNmaKJLdm
	zidinM63wToph7JtiFNLA+p09kXT95k0HByPAzQ/bCl+lkAtNEbmj8MV6+Ty+Oat1iBBLkfP58K
	su4rMMOAX9tkWomfio+hSXecI90KEkAXpFitxYfbv7bX0+NQNWRWXcQ=
X-Received: by 2002:a05:600c:1d83:b0:4bb:687c:4fbe with SMTP id 5b1f17b1804b1-4bb88805c26mr190080905e9.8.1795412066659;
        Sun, 22 Nov 2026 21:34:26 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([37.111.157.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm273173265e9.4.2026.11.22.21.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:34:26 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+9c3df8acb6283d0cf12d@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH] jfs: validate inode link counts before decrementing in rmdir, unlink, and rename
Date: Mon, 23 Nov 2026 10:34:09 +0500
Message-ID: <20261123053409.53956-1-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
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

syzbot reported a WARN_ON(inode->i_nlink == 0) in drop_nlink() called
from jfs_rmdir() when removing subdirectories from a corrupted JFS
directory with an undercounted on-disk di_nlink:

  inode->i_nlink == 0
  WARNING: fs/inode.c:408 at drop_nlink+0xc5/0x110 fs/inode.c:408
  Call Trace:
   inode_dec_link_count include/linux/fs.h:2276 [inline]
   jfs_rmdir+0x416/0x850 fs/jfs/namei.c:395
   vfs_rmdir+0x3e9/0x700 fs/namei.c:5533

In JFS, every valid directory containing at least one subdirectory has
i_nlink >= 3 (its own entry, '.', and the child's '..'), and every valid
empty directory has i_nlink == 2.  If a corrupted on-disk directory has
an undercounted di_nlink, jfs_rmdir() decrements dip->i_nlink down to
0 and then underflows it on the next rmdir, triggering the drop_nlink()
warning and wrapping i_nlink to 0xffffffff.

The same link-count underflow can occur in jfs_unlink() if ip->i_nlink
is already 0, and in jfs_rename() when moving or overwriting a
directory (old_dir->i_nlink < 3 or target directory new_ip->i_nlink != 2)
or overwriting a non-directory with new_ip->i_nlink == 0.

Validate the expected link counts before starting a transaction in
jfs_rmdir(), jfs_unlink(), and jfs_rename(), reporting filesystem
corruption via jfs_error() and returning -EIO.

Tested locally in QEMU (x86_64, KASAN+UBSAN) using syzbot's C
reproducer and a corner-case suite covering corrupt rmdir (nlink=1, 2),
corrupt rename (parent nlink=1, target dir nlink=1), and valid rmdir
and directory-overwrite rename operations: triggered the exact
drop_nlink() warning before the patch, and returned -EIO cleanly with
zero warnings or regressions after the patch.

Reported-by: syzbot+9c3df8acb6283d0cf12d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c3df8acb6283d0cf12d
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
 fs/jfs/namei.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 8ab2e952c..5a06fd8c4 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -357,6 +357,14 @@ static int jfs_rmdir(struct inode *dip, struct dentry *dentry)
 		goto out;
 	}
 
+	if (dip->i_nlink < 3) {
+		jfs_error(dip->i_sb,
+			  "corrupt parent directory link count (%u)\n",
+			  dip->i_nlink);
+		rc = -EIO;
+		goto out;
+	}
+
 	if ((rc = get_UCSname(&dname, dentry))) {
 		goto out;
 	}
@@ -483,6 +491,12 @@ static int jfs_unlink(struct inode *dip, struct dentry *dentry)
 	if (rc)
 		goto out;
 
+	if (!ip->i_nlink) {
+		jfs_error(ip->i_sb, "corrupt inode link count (0)\n");
+		rc = -EIO;
+		goto out;
+	}
+
 	if ((rc = get_UCSname(&dname, dentry)))
 		goto out;
 
@@ -1135,13 +1149,33 @@ static int jfs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	if (S_ISDIR(old_ip->i_mode)) {
+		if ((new_ip || old_dir != new_dir) && old_dir->i_nlink < 3) {
+			jfs_error(old_dir->i_sb,
+				  "corrupt parent directory link count (%u)\n",
+				  old_dir->i_nlink);
+			rc = -EIO;
+			goto out3;
+		}
 		if (new_ip) {
 			if (!dtEmpty(new_ip)) {
 				rc = -ENOTEMPTY;
 				goto out3;
 			}
+			if (new_ip->i_nlink != 2) {
+				jfs_error(new_ip->i_sb,
+					  "corrupt target directory link count (%u)\n",
+					  new_ip->i_nlink);
+				rc = -EIO;
+				goto out3;
+			}
 		}
 	} else if (new_ip) {
+		if (!new_ip->i_nlink) {
+			jfs_error(new_ip->i_sb,
+				  "corrupt target inode link count (0)\n");
+			rc = -EIO;
+			goto out3;
+		}
 		IWRITE_LOCK(new_ip, RDWRLOCK_NORMAL);
 		/* Init inode for quota operations. */
 		rc = dquot_initialize(new_ip);
-- 
2.53.0

