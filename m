Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C534676F
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 01:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116878; cv=none; b=UqwYWmzC/VtyyJSx/v64fFbVn86UQDiqDtAfbH4LiZQyGnYYzS/HUgd7JjqFP45OHYJuJF9P3mfbcLKmmTEBgt2GzvAkvyy2ieKWJsq9brlFr6YzFxMhw+W9kZwIb8/lsKhrwJWh+ntRtY75FmUxc4TT/y0wdpIDhyMZznEb6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116878; c=relaxed/simple;
	bh=AVsuJJQRTTWoyOJkTSi6fUKZFteb6ITubarU8DpDMps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enB3oQ3/LIQ7K+R1cOU0PlgwAzeFifFeFAamweyEWDyhzAwoREjp6Nocn4di4w/UkMdhkJrWdMF3LBq45CYT+j2LX4C/1Et8WXJE/tKi2KbUqHWQX/VZRJ2rHFqkO5Oxhie8q1bOd8/tWSYSIH1dds8ygDmnSqBtQDMSHEIW/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjuZaRBu; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjuZaRBu"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c2a818fc4so14690701cf.2
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 18:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785116876; x=1785721676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VSqmJSe12HqDp26C3dw3gZtstJOdYyHd5Hf+ohShs7o=;
        b=TjuZaRBuWsTSZDd6LYUBMIpVpjNpnd6zTAqOA5T3UJjkqYIO9524K0741hhEW6aK7F
         pnVJqHJrpgO99cjFOdMCx0DEHMcWmS8dRptuXvTSjDV8pgmVTp95TTJ/hqqiGEhk83zp
         s5bABNdRTUlasmZ1CISct27u80dzq83AFg3wnPuLZGhoXRFs4UsMqgsWI7VKiB5ZeJcI
         joxIvnrp5ik4PmItocdIkAKKoaouIL8qaWFVL3fCPsh4wPCd9x9KXaVEBCH/hMCrEBUu
         RxxlmE1rEEvMEkzcgJ7hxbmbKs151lozoFfY2146XfcugnYsTFn0tLgnmv7GMLjclgrF
         tfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785116876; x=1785721676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSqmJSe12HqDp26C3dw3gZtstJOdYyHd5Hf+ohShs7o=;
        b=ZrkZ08pUhuA2xxRoR2ba/mGJ+c7aI/VrVNwSiFJx9CUAsjSqytvz+f7vKuedRcNdhC
         1V7OmqdXoJZnLXj/uK3dL58S7NSpDmqFgTdNGUhX0RJnAQEDUvLAOodpdKNp8740vVti
         DFz6GfwxIIDKzfgbRc+WbT8ohOpOLzYLUdgv98tuV6uPeQPNZCYpzNOSZVVEP0qQ510O
         GStBIgpv8Ey4ZY0nagOo20pYSQ9SLZylXyqMDa2HoC2K/WCQoX/nFIgCoca+Ril/88EX
         VFaYEfzcPd4ECUWeochQagLX4xgoIq6dl3qGLQKefZe/Z8cck8QVzGG2vkRa0uWgqod8
         S0SA==
X-Forwarded-Encrypted: i=1; AHgh+RqtxeX/aisrknJFrv8smk3kmzIJa09mKkebf+iLQHrjv7YbbN5ALRDBgTTe7sXHEbMjwbpUiYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqpFJi7yRf/wUFCwP6zRoJEg1nWpBtadN2HNg/LGR5/ihag6G
	GxMmXN4SwZy1onW3OXRLaqtYOuopLUrbHjQL7FX1s5Hghqkyk4kicsse
X-Gm-Gg: AR+sD12d5n02bhgkq0v5QRZFewZ8lv1fCck0tjVgyBBlIz72PGDfsEJg9jUx47IHlaE
	6fzZYNcJJkSYF4TEJoTU3MJ6cMpKGVb0lpdculswks9D8X5XZDLBbayZ8LxPqiWb/kI+CrZGaKC
	gKt1uzmo9sSe52gTTgSfSwLLtgqB3A/M1QusvoR7wknjXs1aEz/AF0M43FCIEZ7psX4MIfjf3Q2
	/1MZof7QRwhSaZsHauTKgvPkbQhmZXPy/gY0ja021qWg7PC8jukoGCFAlh9QQQeMsISfn351xUF
	UwM6CVB/v6Ec2n2tYpbKAP2SlKKAdgAFncg+EP50epRM9ECJl4NXiHafMPElWF6Itav5MQdBtm0
	vYfqdERjjwZ6kij6napiIWrkJPT36EsB8MYzo4NzmsCSOIZfwd3q10ejjnOk5LVPBKnJPybm6hJ
	5rCqHvkf36dTL3LVYTlA==
X-Received: by 2002:ac8:5941:0:b0:51c:a8:51cd with SMTP id d75a77b69052e-529a8314aa2mr63874141cf.1.1785116876145;
        Sun, 26 Jul 2026 18:47:56 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a2989b24sm44064281cf.15.2026.07.26.18.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:47:55 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: use the mount idmap for the owner checks in the SET_LAYOUT ioctls
Date: Mon, 27 Jul 2026 09:47:44 +0800
Message-ID: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ceph_ioctl_set_layout() and ceph_ioctl_set_layout_policy() call
inode_owner_or_capable() with &nop_mnt_idmap instead of the idmap of the
mount the ioctl was issued on.

CephFS supports idmapped mounts (FS_ALLOW_IDMAP), so on such a mount this
compares the caller's fsuid against the unmapped on-disk owner rather than
the mapped owner: the actual owner can be wrongly denied with -EACCES and
an unrelated caller wrongly allowed.  Both functions already have the
struct file, so use file_mnt_idmap(file) instead.

Fixes: cee38bbf5556 ("ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/ceph/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index de07f19b0caa..12cb50e0a166 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -72,7 +72,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	struct ceph_ioctl_layout nl;
 	int err;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EACCES;
 
 	if (copy_from_user(&l, arg, sizeof(l)))
@@ -145,7 +145,7 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	int err;
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
 		return -EACCES;
 
 	/* copy and validate */
-- 
2.43.0

