Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABDF3793A2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041733; cv=none; b=NmCKWQ1QeRBwFKZLrF1lWmqwm3cXoHfhQn5Vi2cTChcNgNQ8e0fJDJCsXnrD1OAaDTEO/GFTQTh0feJBYAApOitEWGNxaCbE+TJMOvJGG+2/uOZo5Rr/BzReR8F0P3QzRSJde6JKW4OCb4Smf/T5tkguqwiO1bVWFbP0Y6zjzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041733; c=relaxed/simple;
	bh=AKiV9iZVylDV79x2kYTe7UsE3qC9YFCCMMXdKKuvKw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA5iMrg9NCCq/+byp1/tjRlyyzoL3QDSND2BPZZRIRi7agi1b59EiXB2Iz8dQ4Nz1QBf/H64AKZX7F8VStCypuvPOJpwAFIa9DPWoccEnCM/mSL62VOhfy3hogu43NbiD8Ld2nT2UoTsTHEeFSHCdqxyuj4uOW9kA95Q13WM5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKda1tGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKda1tGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7D81F00A3A;
	Thu,  6 Aug 2026 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041732;
	bh=Nepbpu5gvgLoFG7H/lIrZJ7cgSz/icdF56eXSJedwaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKda1tGrq1eKSNVQln4N/rEuCZ3ap2xynITyef0yRsWUGGuOLCj0mRsuH//G5d97V
	 bo5psXsqtDNvAg4npKyy9z2NCBx1rmnMAp7kPMXQxrRIhfw1n/rQ6Nw8HN+Mz7kgLI
	 /uooh9C0WlXGVLDbrFOwig8rzZVr7GtBCIxmGvHrf8+pC7QKxSF2DWcDIiIyrfw+to
	 j/JmYAtmbxXxc8U4Pq6x9VkQfy9K7ZLqh2kNMte9xazbnnm1ZKJlhHSh94GDBoceBU
	 USH+EPTvf5J0He3ccS+4yjeTDo1l6pbou4uCRo7aJr6CNmrX90/9vuH5t748LV9nR2
	 FdRnNPp+mr+Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: LiangCheng Wang <zaq14760@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Date: Thu,  6 Aug 2026 14:42:09 -0400
Message-ID: <20260806184209.1445690-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806184209.1445690-1-sashal@kernel.org>
References: <2026072950-reanalyze-suffrage-96ff@gregkh>
 <20260806184209.1445690-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: LiangCheng Wang <zaq14760@gmail.com>

[ Upstream commit 29ab31f3f27157648f2f7e6d5e1fd9792fdf0614 ]

The BCM43752 is not reliable with the default 512-byte SDIO function 2
block size: on an i.MX8MP board with an AMPAK AP6275S module at
SDR104 / 200 MHz, an iperf TX stress test kills WLAN within seconds:

  mmc_submit_one: CMD53 sg block write failed -84
  brcmf_sdio_dpc: failed backplane access over SDIO, halting operation

Commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
set up the 43752 like the 4373 for the F2 watermark but missed the F2
block size, which the 4373 limits to 256 bytes. The vendor driver
(bcmdhd) also programs a 256-byte F2 block size for this chip and runs
the same hardware without errors.

Group the 43752 with the 4373, matching the F2 watermark handling.
With this change a 10-minute bidirectional iperf3 soak completes with
zero SDIO errors at ~270 Mbit/s in each direction.

Backporting note: kernels before v6.18 name this id
SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, so on those trees the case
label added by this patch must be adjusted to that name. Cherry-picking
the rename commit 74e2ef72bd4b ("wifi: brcmfmac: fix 43752 SDIO FWVID
incorrectly labelled as Cypress (CYW)") first is not a clean
alternative: on trees before v6.17 its context collides with the 43751
additions, and trees before v6.2 lack the FWVID framework it touches.

Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
Cc: stable@vger.kernel.org # see patch description, needs adjustments for <= 6.17
Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260715-b43752-f2-blksz-v2-1-f9be49856050@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 58b2c7d0f7ed2..14369189736e2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -914,6 +914,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		goto out;
 	}
 	switch (sdiodev->func2->device) {
+	case SDIO_DEVICE_ID_BROADCOM_43752:
 	case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 		f2_blksz = SDIO_4373_FUNC2_BLOCKSIZE;
 		break;
-- 
2.53.0

