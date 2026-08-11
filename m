Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939964508F8
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465053; cv=none; b=TahYQDfIF6kbY2qTLlMxkkdb+TuypvuYlrW6PnYgmReHJDIcSl7Y+JWiEg0ou/vxqvmegYI04bWy5MbF7Nr56hN5cc6kpbLjd/hYpKSJ04ChcCsWLR3UjhfEA58RXIq+Nxr0TI5g8Ezw7FTHDlB0P8KxSLtILvWsB/HIg/T98Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465053; c=relaxed/simple;
	bh=l7X01W75BXIMq/p9WF0sa2ISd+eXzcuOI9vcK+JjQzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNgJAXRe+/GFtPa+XGGfmN04bb83eKgVyVYKnMN4QxkFx4PRNc3fCg+yjxq3ym3UDUmi3v+3sJJa/yA//KoAYl//MifSYlC1IOA5uoDPB4VPkc1wdMXtezSvXLFc1S2oB670dcRZ6Rd9FKYN5/pfoZ/4EfBF3PSWjziep4oPzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG5jTsFh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG5jTsFh"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso768331fa.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465050; x=1787069850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RR2VgYwZjBupSt8VlBAmyBBmTAH9MTVFGE/w24WyCi4=;
        b=DG5jTsFhn5gCnsjqmWWQPDj0toDaspqSzdeKoqTegTsSKgK8ay73Z0gpFghI3fDICC
         n3YCrFMD8O9sVIXfqMow5QYCjsFQwblGqo7YsnzsKqSkjSR5HGFH4/hShAjcrEWFjhKd
         5ZfWts+flqB2o2oZD93UW2ATObLyGUAj8bkuA+F+k0D30cVPYFG5nfRCkQ1naRFOXFhw
         aq/neU7mTG2gh7jr+nUblMCiVUS/zPaF8DAEhYu2gEsNwRQgLbkYtkz3a4+GyGqZyY0g
         t9rQr5KN4X9asOmx97jBCOWgH0YL3XrlGjgCYIIDA5XNyt+Wpiq7qMxsJMzcfeYAX1vN
         mlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465050; x=1787069850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RR2VgYwZjBupSt8VlBAmyBBmTAH9MTVFGE/w24WyCi4=;
        b=f6UvRNwZXCisJil7lBGvw3K/5F9Yqc5UkGl/T9u1w+Mp3+lJVYC/lGXPnXO/tP1wPj
         yLwEO7l6by9f76iqf2WKTl4vIrHo3dcQ9fM4sqqF/cMaN/ptskWVQbHaOCuc56JB8YbU
         Q0bXPcrSo2oDwGCKXbxHrnal1i0B0f76NdFTNPAoUqflBP6XU49h4np1NCAr4lMVGeq9
         HLqgym0sR1dHdBW/cuS9E9bdi3p6EjVKa2gwEc5yib3iE4UgflaMt0NIJCJNlCjW8C19
         qREM6ierGkewKrLf9EZPKoG7YxJr/otc/JA49PkW78SkBmvItQpcXcd36zEJQLOFyqKB
         kjVg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0fQ4r1k8MI5lFA52M1cp2y/OmTX1tktJAAKC4xXy3zTsb0Cx69gd8Ns3YuOgtc3C0r8vNVGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTiSUANlbGdIFiB+H6FM/6VXg6OVqZRIC3xtaRFmgRistCKWX
	gGCEdayysWpzswcTll60XiqUE9psTG3RAHCbmxFKKuWb/HNoOzH4IlnTd3VbxX4=
X-Gm-Gg: AR+sD11exjGviEYk40EQ7xKT3nBBsc+vLmG+1lxQoPHcuKrvPm89QsLpyEMncke7pif
	bVPU9a2LJSblE0McXAwKT0+N//ooAEJIVv/T75sWiwEIW8I79boMJJ3X0YUxo1+Qv9vETVF+YR1
	CkaGpo5dfpTCVqYVHXWEeBMFWpR1qiu1Om2fJ9uTaBZI5MQQ4uADE3qG52Zd3kzuRFmTuahU//6
	Wyb5IdPTt/pg0n8vyUjqnFqVTf2Vs/MtVqQ/9ga5N1LlycuyQ3Slih7hAEsCjhZygCt2sLTBX/I
	y1z4ud+u7+xv1PSHDksgYJWrSRSHDP/qRPXemu2PDbwfB9ER5nWVQohkJCMHykG1gcIgsgrK5+J
	WoQ18fw51ie3T85al7OhTGFQ4Apyv+BWiDNTD+sawz/71qt7Yy01HedhNedFOQbtc2Cp2qKTY0r
	xWqcZvTcnpLhFwJ8064jsAA9tw2J5TW2Kpff8oHxC0OHCfiij/gH0=
X-Received: by 2002:a2e:b8d6:0:b0:39e:fff5:7cdc with SMTP id 38308e7fff4ca-3a0f8d24244mr5889591fa.18.1786465049259;
        Tue, 11 Aug 2026 09:17:29 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a0fa5bc458sm3575781fa.27.2026.08.11.09.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:17:28 -0700 (PDT)
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
Subject: [PATCH net v2] net: airoha: npu: load the firmware without the sysfs fallback
Date: Tue, 11 Aug 2026 19:16:59 +0100
Message-ID: <20260811181717.19339-1-sochnev.v.74@gmail.com>
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

Use request_firmware_direct() instead. It sets FW_OPT_NOFALLBACK_SYSFS,
so a missing file is reported as -ENOENT whatever the firmware loader is
configured to do, and the deferred probe path works as intended.

Two consequences are worth stating plainly.

The helper is not merely bypassed for the boot-before-rootfs case.
fw_run_sysfs_fallback() returns early on FW_OPT_NOFALLBACK_SYSFS, so this
driver's firmware requests can no longer be served by a usermode helper
at all, including on a system where that is the only delivery route;
having no second firmware source, the driver would defer forever there.
That is a deliberate trade-off: the -ENOENT to -EPROBE_DEFER mapping was
written to wait for a filesystem, and the sysfs helper interface has had
no in-tree consumer since udev dropped firmware loading.

request_firmware_direct() also sets FW_OPT_NO_WARN, which drops the only
message naming the file that failed to load. Report it from the driver
instead, so the name lands in the deferred probe reason and shows up in
the "deferred probe pending" line emitted at
driver_deferred_probe_timeout. The generic report in airoha_npu_probe()
goes away with it, since it would otherwise overwrite that reason with a
message naming nothing; of the paths it covered, devm_ioremap_resource()
reports itself and the malformed firmware-name property now does too.

Measured on a Nokia XG-040G-MD with FW_LOADER_USER_HELPER=y and
FW_LOADER_USER_HELPER_FALLBACK=y forced on, two images from the same
tree differing only by this patch:

  without:  fallback at 2.477s -> -ETIMEDOUT at 64.555s -> probe failed
            with -110, preinit at 69.6s, NPU unbound
  with:     no fallback, NPU fw version 1456.62 at 3.665s, preinit at
            7.6s

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Cc: stable@vger.kernel.org
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
v2:
 - Keep the file name in the diagnostics. request_firmware_direct() also
   sets FW_OPT_NO_WARN, which dropped the only message naming the file;
   report it from airoha_npu_load_firmware() through dev_err_probe() so
   the name lands in the deferred probe reason. Drop the generic report
   in airoha_npu_probe(), which would overwrite that reason, and give
   the malformed firmware-name path a message of its own.
 - Say in the changelog that the usermode helper path is disabled for
   this driver's requests rather than merely bypassed, and why that
   trade-off is acceptable.
 - Both points raised in review of v1:
   https://lore.kernel.org/netdev/20260807024125.434055-1-sochnev.v.74@gmail.com/

 drivers/net/ethernet/airoha/airoha_npu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed95..de75376db 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -202,9 +202,10 @@ static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, fw_name, dev);
+	ret = request_firmware_direct(&fw, fw_name, dev);
 	if (ret)
-		return ret == -ENOENT ? -EPROBE_DEFER : ret;
+		return dev_err_probe(dev, ret == -ENOENT ? -EPROBE_DEFER : ret,
+				     "failed to load %s\n", fw_name);
 
 	if (fw->size > fw_max_size) {
 		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
@@ -230,7 +231,8 @@ airoha_npu_load_firmware_from_dts(struct device *dev, void __iomem *addr,
 	ret = of_property_read_string_array(dev->of_node, "firmware-name",
 					    fw_names, ARRAY_SIZE(fw_names));
 	if (ret != ARRAY_SIZE(fw_names))
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid firmware-name property\n");
 
 	ret = airoha_npu_load_firmware(dev, addr, fw_names[0],
 				       NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
@@ -772,7 +774,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 
 	err = airoha_npu_run_firmware(dev, base, &res);
 	if (err)
-		return dev_err_probe(dev, err, "failed to run npu firmware\n");
+		return err;
 
 	regmap_write(npu->regmap, REG_CR_NPU_MIB(10),
 		     res.start + NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
-- 
2.55.0

