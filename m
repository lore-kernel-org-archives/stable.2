Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8551EDF1
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911276; cv=none; b=nlegIbF/uRqZhLLEoFMsgtDqcTFvDYqEC+vx2lJtUYVnjTPhx4MdX9mX8/7NWC+hjgBEOoe/rKaKWC9jC4hYc5wCukSgrkhEptFkoBp6Zfw4CxpFcSq6VNFqKV/w4rcr3s7RzF2hILCdE69K4I90o9HHCCVpZWyO3wcTlTvbTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911276; c=relaxed/simple;
	bh=rTuBmNyR0XGlPFPwSHO2WH1nLAjzRa3ub5EVcsQW5aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY7eQz0uUcDvw/4Vskl7M79102UUlAXyS+aP0eM3fAZYcoQQzekjzxtHBrLYA2LKDWzmQFr0D3TC9kUQY1OKAH3leai1tcYvJMBoch4UB1KnkY/f0Fa7r6JQwQjWvpHfvP9WZFsdPupTZtT/GfD/GRGr3PGC4p90uuhvgDOk5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzVk6HIw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzVk6HIw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1af482519so7095995e9.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791911273; x=1792516073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gdq9VK8+Wh/mRy8KAkG8P/JTclrVTJdKPo9KBX5A3pI=;
        b=dzVk6HIw0T3/iAzjQ3p8uI1GP9o167LUyDuHnnxwurcPbc+pxX3L/WW0QpN4XDgfQf
         evJKp+bcxa1rSHfs9fOLxh940q4GNrsZIa/XfYb5NvV+RRDIq2Q3UZCiFHM0HKnWeAgH
         73IJ6UgEnx4XuhoRe3fvu3NObnpuCbzfNDqFsI/qw8qfI5fEq4Teq103MK2GNYBLhof1
         jyK09JiJhKepNmZUZr08ZSuMvzvbl/MJ+CZugtXAzP+InRfFKtruAUuu9PQ1+HTCTwHX
         DC0KFpHWdoyNlnkRxs1jxveOg2d05HNqftqTPX0CX7Jj+sDohXT8A3ia+G6SLbOLK9wE
         2kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791911273; x=1792516073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gdq9VK8+Wh/mRy8KAkG8P/JTclrVTJdKPo9KBX5A3pI=;
        b=Ce8I63XKpHT4P8LVO9nOOPT8rF5ubVfrlfP9cxWtrNq/N0aa5WE4joTHy0xoR8NEZE
         3HYKpwGJ1r534Mm4lmlRIV0oZJeN+HYJSGk8vK9TOOx9n8uJW34baqmzcHdq2xAHdQnp
         NE36cQnU4Zpp9Afa4yDRDFF0lNfKlsqUoIlWEXiiG8BMxlY1mgDwC8wFdojBtwbec5TW
         8euX/ABf//V5+8wVe21RAUBhkOrAGPfgemTzUgRoEHTMXDUMV9/xUtzvvMh0L/N1UsUa
         dNuHRHPN7UGzpo/1+UbvoHo2iQBRnZcHT6JnWrbACKbJizBnDOMvGYwr10zGZseJd79D
         GjAQ==
X-Forwarded-Encrypted: i=1; AKwUvByZWYxKquh5SE8KqXG8a9uEaadenUc6tOABaEum+/5/z1VSk9pSC55v/MwE/aK90ElPMcrGBZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQvXeuH37hXwONDrkU+IchqNPKEGP5e+H5/GqMxnEfJQitYeWK
	FB2bAmVWI64LVCWaFhNgPe0U7+bQD5mVF9SWAxtVs69RZr6GcXNSQUYH
X-Gm-Gg: AYBFou2ZyfCpmwzXVMYa6rs3wiB/VsS3qUqvdnlRLpwaFkvk0f7CZGg/qSxDiPTHnMm
	A8H2bAZLdeNUvUPzAF7+xwYHWbjCNmzzeX9DXsu9uj3LvPI2tpmMmVDtfUl5ifnCcT1axGujQaq
	/QHwlpWa3v5Gafu+Vby74Q+Ba6LdejW/Ao4hm3CFP8n0qig+FtmxgRQJrUvgAaVI7CMOMTkoV6p
	wfFaM/cl8cC9r0Eu+6CZoc4I6O/nrnooZ2Vi/9VIPv+PtRp7hEdwpTCqXKI47QA8hMhP0gCEL/+
	+aNKg0utNqLSCklOjBaFhsVetRPDD1vt6s+XQ75jUVci1XGPtCrZdiJ02X89aYZdu3p/R+Ww8gF
	62r6AiTiUcaCD2v8Cwx3gyjm0N/MI0OipKSiRXFfx8t8++s/e2DjDefxR2teb1otAY13wcXU1X5
	WQ5QDmgB2KP9aGWQqxBq/YE0pw1erkceivvpuLZkjlZEZGB7wKgnqEhuZyLt5lS2fTrg==
X-Received: by 2002:a05:600c:3512:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a18e4913c3mr228195185e9.8.1791911272543;
        Tue, 13 Oct 2026 10:07:52 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf1358asm379560935e9.4.2026.10.13.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:07:51 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Andrey Misiurov <andrey.misyrov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xen/gntdev: fix deadlock between map ioctl and mmap
Date: Tue, 13 Oct 2026 19:07:45 +0200
Message-ID: <20261013170745.583279-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 45ca1afe2fd1 ("xen/gntdev: fix error handling in ioctl") moved
copy_to_user() in gntdev_ioctl_map_grant_ref() under priv->lock. A
fault in copy_to_user() takes mmap_lock, while gntdev_mmap() is called
with mmap_lock held and takes priv->lock:

  ioctl thread                        mmap thread
  mutex_lock(&priv->lock)
                                      mmap_write_lock(mm)
                                      gntdev_mmap()
                                        mutex_lock(&priv->lock)
  copy_to_user() faults
    mmap_read_lock(mm)

Reproduced on Debian 6.12.111 in a Xen guest, with the ioctl argument
on a MAP_PRIVATE file page that has not been written yet. sysrq-w:

  task:repro state:D stack:0 pid:4479 tgid:4477 ppid:1 flags:0x00000000
   rwsem_down_read_slowpath+0x25c/0x480
   down_read_killable+0x48/0xc0
   lock_mm_and_find_vma+0x96/0x250
   do_user_addr_fault+0x12d/0x620
   exc_page_fault+0x7e/0x180
   asm_exc_page_fault+0x26/0x30
   _copy_to_user+0x36/0x50
   gntdev_ioctl+0x3b9/0xa00 [xen_gntdev]
   __x64_sys_ioctl+0x97/0xc0
  task:repro state:D stack:0 pid:4480 tgid:4477 ppid:1 flags:0x00000000
   __mutex_lock.constprop.0+0x41b/0x720
   gntdev_mmap+0x4d/0x330 [xen_gntdev]
   __mmap_region+0x697/0xb10
   mmap_region+0x78/0xa0
   do_mmap+0x45d/0x630
   vm_mmap_pgoff+0xf8/0x1c0

Drop priv->lock before copy_to_user() again. On failure, re-take it
and remove the map by index, as IOCTL_GNTDEV_UNMAP_GRANT_REF does,
since another thread may have unmapped it meanwhile.

Fixes: 45ca1afe2fd1 ("xen/gntdev: fix error handling in ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
 drivers/xen/gntdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index b71f5ba..1ad0220 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -670,15 +670,19 @@ static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
 	mutex_lock(&priv->lock);
 	gntdev_add_map(priv, map);
 	op.index = map->index << PAGE_SHIFT;
+	mutex_unlock(&priv->lock);
 
 	if (copy_to_user(u, &op, sizeof(op)) != 0) {
-		list_del(&map->next);
+		mutex_lock(&priv->lock);
+		map = gntdev_find_map_index(priv, op.index >> PAGE_SHIFT,
+					    op.count);
+		if (map)
+			list_del(&map->next);
 		mutex_unlock(&priv->lock);
 		gntdev_put_map(priv, map);
 		return -EFAULT;
 	}
 
-	mutex_unlock(&priv->lock);
 	return 0;
 }
 

base-commit: 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4
-- 
2.43.7

