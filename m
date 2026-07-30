Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178593F9F2B
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404086; cv=none; b=is622YRwj8iBjGXTQGf7p8Pv+uh0kJqXKAxkH+05w/XrekaFbjReZ6gVImgbNUzR+V+vd9cTsHYJcNnoAN63w63spljSg4UWPpOkOfMtH4cXsh0ExYvvVtd+/Ts/jyKD0f/OnT35PQmeHwUrOs+3wU8XfvwXZ2UqCB5pINm3WYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404086; c=relaxed/simple;
	bh=TORGNVAZwQyKjM7Va8QPlB8jwVUzSqjixSOEbfMPdYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwUAKpprFTvmbdh2UC3LctkRCiquM7QMDuncjKbycnJiWW0iiXj0XOUecmGbXM++FKcjiUJbDCdQ0TD1c9WVCtRlBkB0arE0HC39F2x/kcWHdFkoukll3cEGuvhNep84kGXX63Pde3bEuh3AwdDT1/dqHGh5N78WdXspfCpsWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5t+NRr8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5t+NRr8"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47de008b020so353661f8f.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404083; x=1786008883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCb0db2NHR8nDcgdxqjP9KER1v5yK9SNnuEmMXAsuMA=;
        b=G5t+NRr8TlHjCZ6o3HqrTGD01S8DA9zd8iHjsCZD1yItRKQSwJt/nJcqpEry4Y3FZI
         vByQpDeGDLorTAUbg/EnP3kMFzvvS80Q84FPW3ZmIBU47h923O26yzRpc3CMoa0crN2h
         m61tojDT/0hzQmqHoDQNoIxDSz9X+EgSlVE+VvSgKccBLqn0mPBCkPkviRzK1htxo8D8
         Q75h2SuzpOjYcwGBKaxzpqo+fW8acjA8xWEXcrZeejPr+ack+0kenZddloOyUgHJZEsf
         aX8cyOdBrGs1+4SFu1a6H1Ea5FdO/9IFAHTXL8wOYi/VVxxECIFxuZDod7qr71Pk8aFN
         //Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404083; x=1786008883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qCb0db2NHR8nDcgdxqjP9KER1v5yK9SNnuEmMXAsuMA=;
        b=j8aL16LeIBYzItd5bOgmuG9mhHqNPjQUEGHTXfMAJlWi9saup1X1HrIRDaFRRCcJay
         yHJH3n6IOYunigG6P9nUkV23Y4ZjuzdB5wWMxr9AyEJfZ1xonB1zIddyHu4bAw5XTWiH
         IxTVFVNvLfAjZQr7x0MD2zQK62ndDUl6DdQjm1me5Y34wvxiim6r8pt0V5RGcI9PjgEb
         BZvjG456goNXg51M44eNhNznmxHPpnA8Gfy69JJgyCR8lrOqjgKmijVNRb/hShQgT59Z
         mEdntryYbd6dEyGbkzVDSlT/+pOogzLCcP0jI0pS8wW5KFz5VVZh3eRwX/fc2TWMqhAD
         RPUg==
X-Forwarded-Encrypted: i=1; AHgh+RriNWVr2znFWqa8WANMFginH3M4igjykDlF8m/iRf6M0+ruUNOQYy7KEqvGFf14GY0U/4h8ypo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRqLrEPH8v7zOZelCWT5Ob81AAKwxmQF6K4Jhd7QWitUSdZk7
	xcb9fEP7NrSA44cSXGoodPKwAyClnPrluorKqSRzMqc/twCNVudIVft3
X-Gm-Gg: AR+sD123g7QzCvUfU9MYIuFAghWdqk9zaPoHq8MkyMs5Ug3FBM+7cGaoqQbpI4iaqYD
	Z3Zj5VHrXyitKqzkPzy/uYoQkJw4zoB1RhOS9PwpeSpwmzeCeTmLVDDeIBEHA45aCKSaVMRWx0q
	lUR5kD5+lVDOy1XP96pxIXl/L8Qpm6SEdD6/nZ2KbSW9l4lsAoDV+E9jMaSfkPMtjyiWDB/YN+I
	QH3MnRcu9gxJQ9urVATyqxn8X8VLTruL1iyvYR/Kzmpm8owxsWGkTvFxbSZOmWS3gNLJu5kmG9a
	4fDikaYhmnmWTZTA5mqlM8u4htWSEpQL0MH5/Mln3MF2X5UZWIJIAfQ0foWyFr75d+eJ2MOyA5H
	OztCPdoQ114qGnLpbg2mzzN+p9MRd+5y+lA8kNZPY13zI7JCUY2LfFT2dBmYnP+2Iak1HdxRROo
	QMw7Sn0+/DioV4+Ud8VTckOubX6FoBIGlnczsPN7dKFCurMMSjdWnywHF/Wta3PoylPSdeLMnyb
	hLuBLgkPxMMLN7FxHOhYicvQv5qZK0ocPuKFeKZRMhczHSvGu5y4sKUHQ==
X-Received: by 2002:a05:6000:1865:b0:47f:537b:d5d0 with SMTP id ffacd0b85a97d-47fc8c21006mr1894846f8f.28.1785404083042;
        Thu, 30 Jul 2026 02:34:43 -0700 (PDT)
Received: from valmpani.fritz.box (cgn-195-14-216-95.nc.de. [195.14.216.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d985csm4897793f8f.1.2026.07.30.02.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:34:42 -0700 (PDT)
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Subject: [PATCH 2/2] configfs: unhash the dentry before dropping the item in rmdir
Date: Thu, 30 Jul 2026 11:30:25 +0200
Message-ID: <20260730093435.195441-3-vasilisalmpanis@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

configfs_get_config_item() treats a hashed dentry as proof that
sd->s_element is a live config_item.  configfs_rmdir() breaks that:
simple_rmdir() leaves the dentry hashed, the last reference to the item is
dropped right after, and the dentry is only unhashed by d_delete() once
->rmdir() has returned.  configfs_symlink() resolves its target holding no
lock on it, so get_target() can land in that window:

  BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
   get_target fs/configfs/symlink.c:128 [inline]
   configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185

Unhash in configfs_remove_dir(), while the item is still guaranteed to be
there.  A reference obtained just before that stays harmless, as
create_link() rechecks CONFIGFS_USET_DROPPING, already set by
configfs_detach_prep().  Both configfs_unregister_subsystem() paths
d_drop() after detaching, so this only makes rmdir match them.

Reported-by: syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6b16e3d085833cbf3e25
Fixes: 7063fbf22611 ("[PATCH] configfs: User-driven configuration filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Vasileios Almpanis <vasilisalmpanis@gmail.com>
---
 fs/configfs/dir.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 3c88f13f1ca2..eda80c2a2d38 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -416,6 +416,15 @@ static void configfs_remove_dir(struct dentry *d)
 	if (d_really_is_positive(d)) {
 		if (unlikely(simple_rmdir(d_inode(parent), d)))
 			pr_warn("remove_dir (%pd): attributes remain", d);
+		else
+			/*
+			 * configfs_get_config_item() takes a hashed dentry as
+			 * proof that ->s_element is still alive.  Our caller
+			 * is about to drop the last reference to the item and
+			 * the VFS will not unhash until after we return, so
+			 * unhash it here.
+			 */
+			d_drop(d);
 	}
 
 	pr_debug(" o %pd removing done (%d)\n", d, d_count(d));
-- 
2.47.3

