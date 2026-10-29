Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278864;
	b=N94yHCEYI6/zJmiLeZUGby2E8mx0R1vmDtP5tv3he4XHhV4MqowpkhRrwjpt06X4TDin
	 Nu4CzynPzG5xTpTGIhDm4nNAeQgba21NHoS9ApACiD8KYZQp6vrwLddKyXzL2dZO9yMDD
	 +Spm1NbxeddO3FI04cTyrZyEsmnt7yyEPs1iSQtFIrZA6uVZRfA5P5yk2VqJNYSUVMyC+
	 k0QxbsGTFtRbqxQqFO+ZyUjFpEZlXZeSbm7C7ZJlFAAr/pcgoNRPUCCI+kUCtrv/+RiMq
	 mdmjx1CzKrFzIWwQBFfKYxKQ+T7lS1vtq6kPEGqeMYmOztiGdnUKImqu4SX1rsgU2Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pqAIggo/SjoAGnKs8jyczcI2Ycl4/WyDK4uIxzW2XA0=;
	b=Blioe4Mubn2OBAb0LMdqO0T+JJbRW62YZxZulWSFs2ya4iZNyYeqv+C5Vh92kugvOIKN
	 xg+fhke1LcEQmD5yGE/h7dhIOr3dlIx7IsXJmnUw0Nx08fgDZNZHI0GqvTZQUaaKC2BPH
	 SO+X0NTR5C1hrvK50e2usT+3HZPhN+aOB3RXzLukx44zIBd5aQDZS0SvOIADAms0Ug9wG
	 s43YnJ2b/s74V7UUF/8N3Mc4++oIbpw2mFs6yUmRfxkFzvrGRQW1Eo32z0kieetPzXyk9
	 WgA6A2kVGc/3kIY7ulUnWppd3VAn8VmS9nHtaOVfVUMAG7AXDg0hrr1lKhpbQ/uX3Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qsl+kL3q;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260160A2610
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B260160A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qsl+kL3q
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1173003b3a.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793278863; x=1793883663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pqAIggo/SjoAGnKs8jyczcI2Ycl4/WyDK4uIxzW2XA0=;
        b=Qsl+kL3q8L45e98ETndHKZz15pZIvpRiin4sqLdWC+Ifb5HgzaFfwJP6r87ZGkrC1C
         vq7uUP3Criz/zcp0CKJArxhRZdpD2BE2ZrZHaUUmXa/Y+UmPze9A6eb8WLGLsWeS/BCo
         EOEMulabXdbVMzeVNEIhlEx1HB0xYFoe9JeIObHIXPY7rZkP+ARiLGoxOfwCdayUExoS
         Ivv+TACeCBti0Fz6Krtu+PFcto5HFXb2JLyxrajdMlDx0tYT67aIB5QLjVMlLEY9xqPO
         0QGOdLMWVxonDKerJCZgrB5vtIrR/eC9w+9etW0jprBsb50EReIhIHoqY5saVP44QMSo
         am3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278863; x=1793883663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pqAIggo/SjoAGnKs8jyczcI2Ycl4/WyDK4uIxzW2XA0=;
        b=li43u3KdU8WgiKUBHpP0E0Ga7lPXturnQN0hVeVTtPlfe4AqqxBGTk2aAIsvtE40W8
         +AHhJRL0QWEs9pepuqZphyipU2eAS2PfDrgUEMTh2FrypPPole/UKkDDlhWNm1lnvS/y
         fmQn7O8y7V+ac9M8Suj32Cc+TgdJJ0lrayokGAjOgFdbLBLYmvY0yyDRKuFpdTxDXq15
         fsoj1x+BIqZlB9d4FKtNSMZQCMt1P4UK4HvSD8HSNKkrqLHzC+940mz0lyVHGhY6M1c4
         ZfsSpy2MRonKKl/pv97nCYj8G3mUkL9Y0h4cyPAkrLV7TJ6uL4/sPq/Yt2rsrImdynxN
         7FWA==
X-Forwarded-Encrypted: i=1; AKwUvBxpXdDsZtnsPwJwLGRXoPMSb1EeVIq9GmsF4bOqkEHHTLTxPPJvuRWSV2WTsxoo78m+TGPw08Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv2blX1ncoLl+5WNxYk5s60fNjv/w43wwBujWedYS/hbPC6+2s
	1i8QyDPmF12OUVMWBGIRNZ8hk7uNhSCN3l+9R0AjjN6wFeKmV5zFeb69r9SXawuqwjY=
X-Gm-Gg: AYBFou1yHfcC14mJghRqeuS7nMR3XXFlIn6cdCfbWaIVdFmDtnxDaHUSSRXfGosGMll
	g5G/bQQxxuBogNiq6bXiLvKb6P9xeZRLGrt6Jy4Xx0G+nwjRrOFh4sVnhdQnF8YSLXZ14xHar0E
	OloON2tAs/SGQl6jTAAWfECu24G/1yhnD/qVdlFyF4mL3j3opTOHvJ2RHdvm9jQC5/fY3Q6CmQs
	h+29BbRxZ6C4GLJljNkfSvQs5i5roJ06TkHcM8JGE64yNxDuUS0BQ8S91QtLKWwM7x3I5KgeSEM
	M1QEpI04V7kb4NgByesZ+vwOOz4DaLB/bdj+fu4djq4hN3R8Fl8HphlFEu+xOcFl2Z5un7dvPq5
	gZNzEzIi988bzRbUY+bObrpAWTHPhj5SE+eYUoaiaJS6WgrpiyMoSYYpNYA9o8eR5v2IwhcUPh7
	zPsnnd6btRi25I/k4pkIK+NdX8Yp5icEYXYtDLnqraert00M4Yu4bajpCSMfGl3m3Yfn6agNpfL
	otgiCWmf6Y+dKES7PgGZ1sghYwUbHH606DfmBOvxfezpbOYI/YH8Y54vpe3teZe33HzR6GD+QvM
	OGBu2ik70ZKkbld336Opur62KhoCLIkq8+6OsG29A8xkRsW0eeX27pIN/vtCwUSsGd/Blh4qgpk
	cs6uTZzJaFj4=
X-Received: by 2002:a05:6a00:3918:b0:89f:c71e:abb3 with SMTP id d2e1a72fcca58-8a6e80ba876mr4394429b3a.50.1793278862696;
        Thu, 29 Oct 2026 06:01:02 -0700 (PDT)
Received: from localhost.localdomain ([2400:d802:dd7:8000:180b:d22a:69f7:ac40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662d96asm2290764b3a.26.2026.10.29.06.01.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 06:01:02 -0700 (PDT)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] remoteproc: core: Do not put the device when device_add() fails
Date: Thu, 29 Oct 2026 21:00:37 +0800
Message-ID: <20261029130037.5505-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
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

When device_add() fails, rproc_add() calls put_device() and then
removes the character device.  The reference it drops is the one
rproc_alloc() took with device_initialize(), which belongs to the
caller: after a failed rproc_add(), every driver frees the rproc,
either with rproc_free() or through devm_rproc_alloc(), and both drop
that reference again.

So the rproc is freed inside rproc_add(): by the put_device() itself,
or, with CONFIG_REMOTEPROC_CDEV, by the cdev_del() that follows, when
the character device drops its reference on the parent device.  The
caller then uses the freed rproc and puts it a second time.

With one allocation failure injected into device_add() (failslab
restricted to rproc_add) while st_fdma probes, KASAN reports:

  BUG: KASAN: slab-use-after-free in slim_clk_disable+0x38/0xf4 [st_slim_rproc]
  Read of size 8 by task insmod/69
  Call trace:
   slim_clk_disable
   st_slim_rproc_alloc
   st_fdma_probe
  Freed by task 69:
   kfree
   rproc_type_release
   device_release
   kobject_put
   cdev_default_release
   kobject_put
   cdev_del
   rproc_char_device_remove
   rproc_add
   st_slim_rproc_alloc

followed by use-after-free reports in kobject_put() and
refcount_warn_saturate() from the rproc_free() in
st_slim_rproc_alloc().

Remove the put_device(): the caller's rproc_free() drops the reference
and releases the rproc, as it does for the other failures in
rproc_add().

The problem was found with kbound, a static analysis prototype that
checks whether callers rely on an object after a callee returns a value
for which the callee may have released it, on v7.2.12; it is present
in rproc-next.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings.  Run-tested on QEMU's arm64 virt machine (TCG) with KASAN,
using a device tree node for an ST FDMA with a SLIM core, so that
st_fdma_probe() reaches rproc_add() without the hardware (no clocks,
MMIO windows only mapped), and failing each allocation in rproc_add()
in turn with failslab: before this patch every failure in device_add()
(9 of 9) gives the reports above; with it nothing is reported, and the
rproc is released once, by rproc_free().  Not tested on remoteproc
hardware.

Fixes: 7dbdb8bd7c02 ("remoteproc: core: Cleanup device in case of failure")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 kbound
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---
 drivers/remoteproc/remoteproc_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index b88bf179507d..e4f44a3c8b4d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2309,10 +2309,8 @@ int rproc_add(struct rproc *rproc)
 		return ret;
 
 	ret = device_add(dev);
-	if (ret < 0) {
-		put_device(dev);
+	if (ret < 0)
 		goto rproc_remove_cdev;
-	}
 
 	dev_info(dev, "%s is available\n", rproc->name);
 

base-commit: 82d0bbd67c42a44f0e18b0b7b0da0f3ace0c9527
-- 
2.53.0

