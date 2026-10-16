Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716D2E62B7
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118129; cv=none; b=dZarIj6iGpXn7ruxP87/jQUqKnJyd51nedL4b3DRFBzefRhrzEdIUWORLhPDXO11Z9jtznXV1SYVgfESSlu+z+YG0yJUlmFuIagUNcIVdb3UFP6bIMrc7pG04ub2/pmWX7f7ge3JpuuHa8e4AooFHwr/bWtEi+89vVLrYKZQ558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118129; c=relaxed/simple;
	bh=e1pzx7iHT7y8LGbTJDidgYeAv6c7Ezsr9NaS2X13/Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4OfgkTJ7JEyhgY+adQq7287cUrJPncIafQn6g4Itm5+3/SXeOc8mOgOoAZmXZDUbeoYsa9h/dK0NWnNynzuH7UBp4V4oeazukAYAhTMgdzqldFAbgrTuEPQngPXOS0We6h+BvPGFZrnzxSZk5KSsxKR46zBTjy7NjU6xggfWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ran/TBc7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ran/TBc7"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e63522076so435411485a.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118127; x=1792722927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=03vOOfrUqgo7xXSCXx3l+3vM9t3JyBBNR2eJKIpJADU=;
        b=Ran/TBc7w0EreJsOKePA0YDoZ4yloK8JIOPdSX2pgPqfg7dHVAgAj+6FCmMD+fW/Tq
         I+gz9rSf6Wx+hm9TkbNttGdjnjCDZsn4GhqUNgF68gpor1t1o1mrRxZ60teSTtMx4a+H
         Wq7wzX7KGm2opY/mSIP38Rcqg4c2VTR7FZg8S7Dr8P9xgy7xDjeZWID4Wd620Ip0oe7B
         F7T0mDuaN/y8L+ju/m9S+TSi7TaBjnirLmWJ/inwhujmlUqMPnBB199T47E/rFWXpT44
         yVVilqbyEDYDbVoN6rAdTRbIGt3OPtyu/T4r0uBzOCXwdB/eTpNKokDMnVBcd6Ol40O4
         Jf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118127; x=1792722927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03vOOfrUqgo7xXSCXx3l+3vM9t3JyBBNR2eJKIpJADU=;
        b=hLzO6bYmwPudzUMR6hg2k33muuQvaRZ0TFYZNO1wCn1aS+vylzzfb9RgvBBNuu+345
         g1jZpRVLcUCiO7QFMMiG/EYesZmUh5yDbcKhXfncY8Ed2PyNKSRj3Bx+zobfJvc4T2Z+
         0WOWefzEuWwj7r8/wURQuXyqXnUDHYyrFl+auYnr/DFGhOc/VuRGufGezJg9JALn5ywt
         w1mOeIw4KKyaM/cezZeHohFKT+ng3Z/rCrmHYF5/9R7itaAj+rSNEjInyksEtAE5262A
         fNLydgwNi+ArIf7vmDXH+OP/qnkC/rQqcv0GonhsBnhikaPNIMpzQZBP6hfr3q8EFZGv
         Ohpg==
X-Forwarded-Encrypted: i=1; AKwUvBxxWaL2deuMipHI3vIm5GHwT5fiFxJx+XGgvJG6Gka6E0xwkkMLq1KtXfCE2s97oNJjtSNT2DI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJi22rgJYzYu3yIlpCaBDvWfvFGH7FaPuav3YKzklYcA/kV9Bkz
	eSX3W/pVzOsEwrBTzN71BQdGcM1vJwYEMSuWlUD9zQ6NZGaTO/YBRCJ4
X-Gm-Gg: AYBFou2Ks591U60Rlk3zBnHHOUtCviXFPkNEW5BdxtMXAD8d4dxkzY+XVfwO9BPA25X
	S00fkkQteqUNpDL6l/iDMJi7aWVh2gvFE+Q6iDv/yKBFdKSUH5DHUYV9Cl5nJRjcvpMjo4uQg+h
	WpWuoLcWqRL8U5wKP+G6fkN4f7Mm2m0fLNhWDYz6wq74ip01JWPMVZNfKccn6SGfGMRyTX+CrgT
	fzVyfDdudWk8mxZqepROwo1nfXOSwUW9uFKG2pi6wT/NAFuGya0Ku2P8k2fqJA/LqrBRk5ZfeNd
	Og8j/g43jUffBJ029wmxVcGMOMXTxCWmiAbNuuYlSzDTaGX8fs+/IauDNw/wtC2xleIHdsEhAZx
	E4dmoxMxZehPt5zYF+USJr1WQfjma3THT+g87Z+JPgT77oHB78dembfzWlnZfmkDz48Ap5wdvN7
	lz+CPdfz4N4LLoV4YxuwmQYLqva2/YG4rHcVzsD97NhiF91SvDsxtoMcWGiFryJkTbEFwiygcVw
	3S7W9CH2UtugU/4dUAyVw==
X-Received: by 2002:a05:620a:6412:b0:93e:56c0:bea9 with SMTP id af79cd13be357-93ebd1e0039mr3550692085a.21.1792118127587;
        Thu, 15 Oct 2026 19:35:27 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1b765dcesm52558885a.30.2026.10.15.19.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:35:26 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] virtio-mem: only mark the device ready in kdump mode with vmcore support
Date: Thu, 15 Oct 2026 22:35:09 -0400
Message-ID: <20261016023521.747447-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_mem_init_kdump() marks the device DRIVER_OK before it checks for
CONFIG_PROC_VMCORE.  Without vmcore support it then fails with -EBUSY,
and virtio_mem_probe() deletes the virtqueue on that error path without
resetting the device first, so the device is left believing the driver
is ready while its queue points at memory that has been freed.

Before commit a9403425b3cf ("virtio-mem: mark device ready before
registering callbacks in kdump mode"), virtio_mem_probe() called
virtio_device_ready() only after virtio_mem_init() had succeeded, so this
path never exposed a ready device.

Move virtio_device_ready() into the CONFIG_PROC_VMCORE branch, right
before the vmcore callbacks that need it are registered, so the -EBUSY
path never sets DRIVER_OK.

Fixes: a9403425b3cf ("virtio-mem: mark device ready before registering callbacks in kdump mode")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/virtio/virtio_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e18dd736f2ec..b28d2da7d5b6 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2817,9 +2817,9 @@ static int virtio_mem_vmcore_get_device_ram(struct vmcore_cb *cb,
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
 {
+#ifdef CONFIG_PROC_VMCORE
 	/* We must be prepared to receive a callback immediately. */
 	virtio_device_ready(vm->vdev);
-#ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
 #ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
-- 
2.43.0

