Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184140;
	b=aIMLkCYkAVAdY9ECSKT3ZFFue4VJaADDTUVxws2BbMKpqrVp4ohZEZOCbxdW4IEclo97
	 W9nQ1bETNhwbV7hCBNktVEB7ucNtGGzRatNzatP4g729Frd/mbdzR59OD/+wyk+yfJWnM
	 cWUxi6ruEhBToYKmJOw4BiJ0mlwnKT1xQ31qODL0Y8o5yiGTroZF8yONByMEsLIA3DH+7
	 w73HAerrieF2aFgeO778UKU8NA6NBVwDz30+gPZ47W6A7eLxFr0MnGi5WSwVmzOML8/dk
	 AeWae8aAHhooAfz3X/J4pEvcv986tXTEAmQyVpnqjjLjKV5FX2vOhbncQGRCsUTQIdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Vx4X2Fvkx/Dd8Nyf178SX35TtePddMWESDoKM0WmL0=;
	b=QEA+7cGRy8TUwbWNq79UtpOp4IHkSNtUb5CTpNlgPu0qMC4ejaDcSc87+LSjlCBTLboL
	 aloIxjDutaw+WTgHMXQbDPT0aLCecydrv3iOOyPtU6206GP4Ny9N9Ztgjkc/fJ6xDfjRL
	 m5VyFFRlpfis7p5GVCA+DJ5gYz36g+k2PjD6/x5qlh6DB42uGoSDv3Z75s41J7f0EPgTc
	 iidFlVA3mZk6eI3Nl2+W/oHjSj+Nt7278odUNONGIFEhsZTlI918WJYrgoOCA9tXZxo3E
	 EWRo3wAZM8e7ZyYLqGU+4cvPqcqt0lZHlo9b45ezv8Nxc7rtpQ+zPNtaU5YQAv+NiuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqAdtutt;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55F606A32C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE55F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqAdtutt
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2eff92780daso6605955ad.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795184139; x=1795788939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Vx4X2Fvkx/Dd8Nyf178SX35TtePddMWESDoKM0WmL0=;
        b=LqAdtutthrVfjfAG1Aw6JaW43x/MsBQNo6gU+adMY/X3UcE94J79IZ5Fjmh3Swe7LT
         PkgItpi3W4YHPdruYROz/d8Xub8rRoIC6pyEieoOwJjR/8+NKOqaPr2zm+LMCGJXXz2j
         b1nYe+Cguqq4PwAR3AwRTmhjFSnTFPmFqjO+35Q9VuWB7UdFWcHq7gzizg1/49a2qEqX
         H1roDDKsNPWlKCODGeLKF3R6EkYwRb9slkUyYRRVfgZKQq3nvdGTh6miifD1d7tEKaD2
         Uhif8THAMjtmECglZ8a4s751mJfQFsezOgeH7ahmp3Wh0L5b6XZ6BPKOGs1CqMCm+IOE
         IHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184139; x=1795788939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Vx4X2Fvkx/Dd8Nyf178SX35TtePddMWESDoKM0WmL0=;
        b=BJuruuDUKPD8/BuXwxNqbvwRmZUcUriGbsueaNShSgO13h0SGdRza26g44o7paCKIw
         cHx8vszkUtT17tOKmWj4+7pOHysiP2o7BEC9jsh3L7/8kq0yVRyyPdJ3k+CMUv1zst6a
         CcDec2hqQHNg+CzXaBP03OebAXpIIj9XbicvtHrCpIgJ2h8A5dNEqUeCRyLX2N6TTDO6
         FFUF81nA6irbhC+j1/iE1cY8Yp97sbPI1qfHE/jun5rxybnH5nnPudYW70/HsieayMkX
         OGoAlettREnCT+R8SzFcDr9aajL6v1YriGyCGbiXEh3aS56MnD/qfkl5Va3990mdpfWr
         bvsg==
X-Forwarded-Encrypted: i=1; AL+hErFsy1nH6jqbnpdj09bxKuw5LzTtOleEEE9Qwbm/ksV5xoqGeZ6+GZkjbvscbHP2vvZsf3/brJE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8Y8xzPa5uyazwEBXZ9cV5VUkj65CepBSRK3z/IkvepCCRd+mK
	vkA9pIlMcMWmL4TUzLlVkjpqSXXcAOf7VQphALxo0rJeKqnvHUJqtKTo
X-Gm-Gg: AZFdTZc/b1f/lKBUpA2fi4uXgYBJ16VqC+DuZ/+EVbQn8idxR18FjyD6cMtJtB7smIP
	8IqGCsG05MwNFIvm3pbdXVvES3nkS9FbJERWpqo5YSXQLbXqprTYa/r7MeDIIpd00d/RK4mWFgI
	LSYHrO6+9rKLqa/+RebIXzYOlKxr1rG5qaLzHrLXzh6o5MzW76ybkx3y5+75oaGeP8cRoyE6CzX
	Tm5MUa5snmXEungwdjgRqsjVUhT1KnWXSi2cdnEYGgX9uXGlGGj9eXKFfWoGE6CoMDNowRnDzp4
	7xBnk0n50dkrwRPxq/ffxcX9A2rti0RAF+RmeCz+o9yWrjyrrVPawwO9PkyZOKd9qGySnBqYcdM
	krgu7s5gtdpQRwCO9oh0M3cR1e5GrmIjSAh2ewEhMZ2YQuOhUcTUairbHbbFdGvYzSJX9T9+xak
	KZhFYAQBiwC8gE7dID/tmgK53LGxrauA51XXmw5opid0P0gSH0rHbv6HhP6DLedPQCp9H2I+5gy
	S696OE9SJHH531Ro3iXKy4tD9isDYM818e9d/2Nd56xVvdR2OhNvVOChfmm0EuB9TY1npfmRrHW
	y/7TSRsvt3eGKbvxTthnmWcBG/6911tXWywmls92FULZJ/Q=
X-Received: by 2002:a17:902:d60e:b0:2e9:7dda:bfc7 with SMTP id d9443c01a7336-2f03f27062fmr30969925ad.66.1795184139137;
        Fri, 20 Nov 2026 06:15:39 -0800 (PST)
Received: from localhost.localdomain ([115.73.20.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1f2csm14852005ad.22.2026.11.20.06.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:15:38 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] soc: ti: wkup_m3_ipc: Use the device's own state in remove()
Date: Fri, 20 Nov 2026 21:11:39 +0700
Message-Id: <20261120141139.55783-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
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

wkup_m3_ipc_remove() tears down the driver through the global
m3_ipc_state pointer. That pointer is only set by the rproc boot thread
once rproc_boot() succeeds, while probe returns success regardless of
the boot result. If the wkup_m3 firmware cannot be loaded, for example
because the driver is built in and probes before the root filesystem
holding am335x-pm-firmware.elf is mounted, m3_ipc_state stays NULL and
unbinding the driver dereferences it.

On a BeagleBone Black (AM335x):

  wkup_m3_ipc 44e11324.wkup_m3_ipc: rproc_boot failed
  # cd /sys/bus/platform/drivers/wkup_m3_ipc
  # echo 44e11324.wkup_m3_ipc > unbind
  Unable to handle kernel NULL pointer dereference at virtual address 00000064 when read
  Internal error: Oops: 5 [#1] SMP ARM
  PC is at wkup_m3_ipc_remove+0xc/0x48
  LR is at device_release_driver_internal+0xbc/0x144
  Call trace:
   wkup_m3_ipc_remove from device_release_driver_internal+0xbc/0x144
   device_release_driver_internal from unbind_store+0x50/0x74
   unbind_store from kernfs_fop_write_iter+0x11c/0x1d4
   kernfs_fop_write_iter from vfs_write+0x2a8/0x3f8
   vfs_write from ksys_write+0x60/0xe0
   ksys_write from ret_fast_syscall+0x0/0x54

The same happens when the mailbox the driver depends on is unbound.

Store the per-device state as driver data in probe and use it in
remove(), so the debugfs entries, the mailbox channel and the rproc
reference taken in probe are released whether or not the M3 was
booted. rproc_shutdown() already returns -EINVAL for a remote processor
that is not running.

Tested on a BeagleBone Black with the firmware not loaded at probe
time: unbinding the driver directly or through the mailbox no longer
oopses, and repeated unbind/bind cycles rebind and boot the M3 again.

Fixes: cdd5de500b2c ("soc: ti: Add wkup_m3_ipc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index eb6074a67ba3..224651955cda 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -695,6 +695,7 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		goto err_put_rproc;
 	}
 
+	platform_set_drvdata(pdev, m3_ipc);
 	wkup_m3_ipc_dbg_init(m3_ipc);
 
 	return 0;
@@ -708,12 +709,14 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 
 static void wkup_m3_ipc_remove(struct platform_device *pdev)
 {
-	wkup_m3_ipc_dbg_destroy(m3_ipc_state);
+	struct wkup_m3_ipc *m3_ipc = platform_get_drvdata(pdev);
 
-	mbox_free_channel(m3_ipc_state->mbox);
+	wkup_m3_ipc_dbg_destroy(m3_ipc);
 
-	rproc_shutdown(m3_ipc_state->rproc);
-	rproc_put(m3_ipc_state->rproc);
+	mbox_free_channel(m3_ipc->mbox);
+
+	rproc_shutdown(m3_ipc->rproc);
+	rproc_put(m3_ipc->rproc);
 
 	m3_ipc_state = NULL;
 }
-- 
2.25.1

