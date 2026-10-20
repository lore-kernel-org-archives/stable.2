Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528793;
	b=fjvtfnlKKR92BsV7WVD4EomT3SM2ZQYFMdWhUhZRduzNwCbCsGvZJ7GS7Dm+gljbgtcx
	 pC9UhyJ4eWX85whmaDDCarIJWV3dHVLkjM6rYTquOD2U6EY28BNFBm90YhzhMZQNuBtP3
	 wuEpk8fB58ov6ESUJs7+ma3GS+fPl61gpLtP97wvJwM00f2hvgIXrCDSmnfZlkgLVPgnu
	 nZFV5b6lC/+vVJ2XpwEUkigdUmqobr+oM0f1U1Yq0mulpuIgFTNw/ROPgvhwKXLlmL98n
	 xmMYU8mgnfVSNQ51Kn4O6OhrMITFTX8hRwQ/9JvINVRDm3psXpaFCEZuuPaLYJYz+dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=69ZsWlJYKqcYYqFI8rMOizWSH2P8Ln8H/nLJiISKOi8=;
	b=BIGCsbbMfd2XI3ehWEZvR+YD4EF8LSZaXiglqg6Yv4xE9QFbXMOdO0FYB367RAm9kOa6
	 oBoo6oiKr0/HgOgDmmCSmUrZmtJ50EawegNE0u588zxaaJ7A7PV8hSV7yZ6e+3vKcK0D8
	 lHpe0o4bvpGsAlHyOmV2ykhJ72OIg5v4KyR609c5U4nt52QFxP2BK0nPyIoT2++fZHcTP
	 NHb6yRIep+AA7wzQmpa4PENXaTj/+KoGEnntay0ei9xoldbyaoJt43iXO4OjrhfWTRsQ8
	 9kEvsNXNCrASDaow2kMMubcez2mPDiSjkflJl92AhCIbpyqmpaMtK3W0ESi/OwATsxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZuXLBJj4;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B2606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 326B2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZuXLBJj4
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so19765e9.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792528791; x=1793133591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=69ZsWlJYKqcYYqFI8rMOizWSH2P8Ln8H/nLJiISKOi8=;
        b=ZuXLBJj46sgMBE9x8Gk6ifw6twa5jmlOsicpDnX4Av6p/OAg1Djc1Cwkqo8rE0t2Qh
         H++gYz0eyNkuK/ORdEUtey8C/fWfjw2QdZ5uzeLEGVQarM8A/JLh6A4/ORdUj1GfkaQ9
         bg5XZtpzzXKqA5tQj4qOHE18O0PedfnhhfzPdssVvRioJa8pZ+HBeaYTEPU+IYoUs0je
         WM2i4WRHjPHv17vmr13Y2KjIrPzLAx1b7BRT8fBns/c9UcyLhUP6Z52VAxQVAYj0QdZ6
         w7KrTJV+V2b2ShFC6jPAPpoD30u+uj+xo3fKxkYsvDhm/5ofdakfjntqfeBZqo0oKhaX
         9VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528791; x=1793133591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69ZsWlJYKqcYYqFI8rMOizWSH2P8Ln8H/nLJiISKOi8=;
        b=k5u3WaKn1vZh9KixFgzevCmuUfE7l6AJbVPh0o5FsqYk1Lj84CgkB2fIdx54RzU52m
         l9TyBTXRzVPwU2dckRDFdmMQSFO4Z2Pn+edRFoWdElNNTg9TYLvF4kxQzTQVtnlvXyp3
         47CG0IxQf8xkc6aUqJphqH58XLU0o29X9IucIPED+R850G+CAmAlIogRbVC008PW1r8s
         +QBHeOV1vtW4UizEpUb8yRWVGl7qzF6vDdyTBu92Rin7DWKwHKVWC8FzEk9kUJZo+s2v
         XrkUyMV9EWD3zdGDtwC6dPXuPhzdr6gsH2F1gW5D3TnnKeB98pcwmjmQlIZHmicS3nvZ
         kS2A==
X-Forwarded-Encrypted: i=1; AKwUvBxjkm6OpbDtkxcyj2Qy73YdEjKrgUm27CjYdJSJ0TI1K5zHt3EiJcK4y2DbOGTu2K2+vvsv5Kc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIow+vWja17mlZR9keGiN4aON2m8thiZ7gk9onABuj1ht2pLb4D
	AWAFXV0TN+vfL7gCB5vMi0uSqXpQB29sQy8ZBfFEtof0VjTk0TNPLu+w
X-Gm-Gg: AYBFou0Qp6hBBbpJmcJo9O5aqxLTc3mS7aqkUzvXqxJCAZW22yAfWF7Isx2216EIQyT
	SkRopBanCPl0+fRJSmwp9UowKfzLre5CEZcvnh6I1OvcGxwQTygcTwFi+JezwejEtIZDac+qJ3s
	wDEBAPgYcCvibZhoKlFxaQj0Kdb8lsrIjcZfZcpNDTkFyC0SHG8JWpnkUxqV2bZ9QJ7wN/I4qp7
	k5wH19ERfNtzSVl+Gx/hpZP48lHQAAKaMeKMDFIPu6EFgHyKMz3GHMSbK35Ikk5unFjd6bVOuH3
	XvSoEWNpjQTZbH5Y5DzS/a0y0vPKrFJ0ko+2rjaRxOJ2KpKpKZsBqwnwGtm9mQQFrzszu7XBzf6
	Wwoi3DIBYAMUbLYMD+7vnBgOmvmtRs3BJElRo/8w7n10i8fE0b8/pFN9TGiBYQFE/d1ad9ytNM/
	PpptGkhQJueNmADZNYoJZHCtRuWY+n+FvkgySC/hDr16xWwsSsk8ygsoH4vUbEo3Jfbm+J3HqN7
	w==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a1dbdf1a18mr238063555e9.2.1792528791378;
        Tue, 20 Oct 2026 13:39:51 -0700 (PDT)
Received: from vitor-21h1cto1ww ([2001:8a0:c4c6:f00:691:6627:6830:68b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d324f8sm90720295e9.6.2026.10.20.13.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:39:50 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v1] wifi: brcmfmac: skip bus_reset cancel when the work was never initialized
Date: Tue, 20 Oct 2026 21:39:13 +0100
Message-ID: <20261020203916.381637-2-ivitro@gmail.com>
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

From: Vitor Soares <vitor.soares@toradex.com>

When the firmware request fails, brcmf_pcie_setup() releases its own
driver, which runs brcmf_pcie_remove() -> brcmf_bus_cancel_reset_work().
At that point brcmf_alloc() has set bus_if->drvr, but brcmf_attach() has
not run, so drvr->bus_reset was never INIT_WORK()ed. cancel_work_sync()
on the zeroed work then trips WARN_ON(!work->func) in __flush_work():

  brcmfmac 0000:01:00.0: Direct firmware load for brcm/brcmfmac43752-pcie.bin failed with error -2
  brcmfmac 0000:01:00.0: brcmf_pcie_setup: Dongle setup failed
  ieee80211 phy0: brcmf_fw_crashed: Firmware has halted or crashed
  WARNING: kernel/workqueue.c:4409 at __flush_work+0x318/0x338, CPU#0: kworker/0:1/10
  Workqueue: events request_firmware_work_func
  Call trace:
   __flush_work+0x318/0x338 (P)
   cancel_work_sync+0x6c/0x90
   brcmf_bus_cancel_reset_work+0x3c/0x54 [brcmfmac]
   brcmf_pcie_remove+0x5c/0x124 [brcmfmac]
   pci_device_remove+0x44/0xd8
   device_remove+0x4c/0x80
   device_release_driver_internal+0x1d0/0x22c
   device_release_driver+0x18/0x24
   brcmf_pcie_setup+0x58/0xc94 [brcmfmac]
   brcmf_fw_request_done+0x14c/0x198 [brcmfmac]
   request_firmware_work_func+0x5c/0xe8

brcmf_bus_schedule_reset() already gates on bus_reset.func for this
reason. Apply the same check on the cancel side.

Reproduced on a BCM43752 PCIe module with the firmware file absent.
With this change the same failure path completes without the warning.

Fixes: 43b25879f004 ("wifi: brcmfmac: drain bus_reset work on device removal")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 92ec269f43b2..a3d662348711 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1186,7 +1186,7 @@ void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
 {
 	mutex_lock(&bus_if->bus_reset_lock);
 	bus_if->removing = true;
-	if (bus_if->drvr)
+	if (bus_if->drvr && bus_if->drvr->bus_reset.func)
 		cancel_work_sync(&bus_if->drvr->bus_reset);
 	mutex_unlock(&bus_if->bus_reset_lock);
 }
-- 
2.53.0

