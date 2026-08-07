Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C634C6D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063305; cv=none; b=AT1grl8EbRAZJjGyGEryzIj9g+rooIb65ZHINTT9C18GVX5OT4X6EluvGRVVpfXRUMP3NZvrq13g7MVSjv9K9fGeMReI9xau/OqDukIGCy1vHVO4S1ogT4+zEfr+T6QPv+lmOjta1sG/hyW81PWr93xCvRTE9IroM4RmeQMnl9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063305; c=relaxed/simple;
	bh=ZL9+sQZHP4asdqRDP1EZKwR4QQUfjUwzOHzZncI0HUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdUOBW90A8fwOy5oqVJksV1snEk96MGYUWOLGbboxMLh+uk0QT9cBkPfiEwyZHHyyYCi4Adl6gbjfOOK8jWHjcVAkkao+GCvMyA6hoQ8OQ4rEaqtaC1hW/R7fntj5LeVKe7dE9KXOiJ4p0/MpKaHsP3zXrQm4Qag1qQpCL4T4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ape0tNYu; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ape0tNYu"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b159850b16so2706588e87.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 17:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786063302; x=1786668102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jg9t6USd7aCBm3DCerjF5PDOcPoho7Pj+WkMHzrBY40=;
        b=Ape0tNYuKCjFJKx+9LCTzZC54swhSWC02VWN44NKQTZWWSJcfp5h0/RkFtqgN5mNF+
         igfBpqMC8fEBWtfe4oEQvSHLT5TuV0163iO0JiREJIHfB+wu/mjJh3DpQFN9WUQEkyGH
         VSQdNPJEb8NPD5PC0qjihYUyu44BmCqWXHMNUV2QBNpZ4up0QzQbx4URKEL9PC+kJWsj
         VVHS2vwcFL11zPq3Hr6E5pVryWvdn2J3pjznnuvW/GyLjbB4mqE7UhK5gD3FE2JYLcrn
         LJcIi3zuMtMlhLU51bWM7gVN9mA3n/1dy6mIRsQE3IHgnzFAzlTBgTgm5NHEqERcyWqI
         3vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063302; x=1786668102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jg9t6USd7aCBm3DCerjF5PDOcPoho7Pj+WkMHzrBY40=;
        b=I2LApipFq6ZeRKFC0DZBOuTYjtrLvs3A4QEsSpHnPtn4NgTbZQoihSYFNu+uCy9i0U
         I/5iYGKa4j1nTFIrRsjNE+dx9l20HeRyXc8ThEWAs+a5NfELVXHB01g+Qj5nWYuKdZsa
         b8hpi0omSnL9PTQhMx8exGCtk7wqFagqSIHhw3uPSHM0To+1VZBkDCi8Acr/O3vjp9Ph
         bSghMqRJnEdk9nMkuqVtsJ7vIBXecv786Dk4zAYhrEw27G0UWIbcMgkqYUrPo5//Ipbn
         EeiIvvwZ1cWgGEwy5QHqmcVV1RJ8jw5zrz2QQPrLwCGm/G5avwF/VuKLEAHq/8FV3gpC
         yvMg==
X-Forwarded-Encrypted: i=1; AHgh+RrDpCeJzugOWVcR0+n9XmvEGLwAQqs0ZP/E6uFrWw0Kj5FSCDrewFWjKoBrVMmy40ZNYdpHEqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2gbC1lrJBbE+nLy5RyfoLQDa+oCt9Ty84tndwhRqLstzju4vu
	hCfqytbf5lOX1gxvkUZ9CDTx1JFdaf9avLFnkJ02ea9f8Yw/NdpM7wAz0kDu+nI=
X-Gm-Gg: AR+sD11esp5iC5TIPazg4xj5kL5Ha0VLjlTIuqxBqTDYS2RCxn0UIjZzPDXK9+7CqDW
	9Kt8Z6JN74wqWgXK8sifuuRSduhO2+Q8J2hs4ma/nvnbyxElXdSvVkt7E7IPMvzxCw9+ZlFVC54
	tO13kLqMSd/nQA1TOk+P4Fx0eZENk/c3H+OpXsagpIVkkPHLIvhY+vK+6q347G+6yfUqB/M4r4z
	OSA/3aSCTRSHKZ507ANJvGuCQguKP3udmNPDArmDkgFty0+Qd8cuq84vOF3xmPI48ZeB9+g0fPU
	2MT09l+1EBFAZrxuPV0KcEizKji7XChcT2dhg8C3RVuKhv095fq0uOgmGNBqn+t2ZVhx7DVbRjp
	3oAacPn1uKiTuiNeRvZx8ExH5YFI+DaD6oBIPiSkx1ac9LBbqFH6C2Xm7JMqkv2wAGPnnaVhsOd
	5ZB0SNG1wtTnWmLHwU6Nb8XJ6Wu9ZDLPu32ita/v8qpdmFiLd6JOo=
X-Received: by 2002:ac2:5dcf:0:b0:5ae:bb19:1864 with SMTP id 2adb3069b0e04-5b2f4b90286mr1828052e87.21.1786063301532;
        Thu, 06 Aug 2026 17:41:41 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f2b86sm189232e87.66.2026.08.06.17.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:41:41 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated list:AIROHA ETHERNET DRIVER),
	linux-mediatek@lists.infradead.org (moderated list:AIROHA ETHERNET DRIVER),
	netdev@vger.kernel.org (open list:AIROHA ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: airoha: npu: load the firmware without the sysfs fallback
Date: Fri,  7 Aug 2026 03:41:08 +0100
Message-ID: <20260807024125.434055-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

airoha_npu_load_firmware() maps a missing firmware file to -EPROBE_DEFER
so that the NPU can be brought up once the rootfs carrying /lib/firmware
has been mounted. That mapping holds only as long as request_firmware()
reports -ENOENT.

It does not when the sysfs fallback is in play. With
CONFIG_FW_LOADER_USER_HELPER_FALLBACK set, or with the fallback armed at
runtime through /proc/sys/kernel/firmware_config/force_sysfs_fallback,
request_firmware() hands the request to a userspace helper, waits out the
full loading_timeout and returns -ETIMEDOUT. The -ENOENT test no longer
matches, dev_err_probe() turns the result into a hard failure, and the
NPU is left unbound after stalling the boot for 60 seconds:

  airoha-npu 1e900000.npu: Direct firmware load for airoha/en7581_npu_rv32.bin failed with error -2
  airoha-npu 1e900000.npu: Falling back to sysfs fallback for: airoha/en7581_npu_rv32.bin
  airoha-npu 1e900000.npu: error -ETIMEDOUT: failed to run npu firmware
  airoha-npu 1e900000.npu: probe with driver airoha-npu failed with error -110

Clearing FW_LOADER_USER_HELPER in the configuration is not a dependable
guard against this, because unrelated drivers select it. On the affected
build the symbol was turned back on by LEDS_LP55XX_COMMON, even though
the platform had explicitly disabled it.

request_firmware_direct() sets FW_OPT_NOFALLBACK_SYSFS, so a missing file
is reported as -ENOENT whatever the firmware loader is configured to do,
and the deferred probe path works as it was meant to.

Measured on a Nokia XG-040G-MD with FW_LOADER_USER_HELPER=y and
FW_LOADER_USER_HELPER_FALLBACK=y, on two images from the same tree
differing only by this patch: without it the probe fails with
-ETIMEDOUT after 64.5s and the NPU stays unbound, with it the NPU
reports its firmware version at 3.7s. The fallback is compiled in and
forced in both cases; the patch does not disable it, it only keeps the
driver from falling into it.

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Cc: stable@vger.kernel.org
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed95..ca33e615a 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -202,7 +202,7 @@ static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, fw_name, dev);
+	ret = request_firmware_direct(&fw, fw_name, dev);
 	if (ret)
 		return ret == -ENOENT ? -EPROBE_DEFER : ret;
 
-- 
2.55.0

