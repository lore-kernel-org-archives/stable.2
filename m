Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E393A1A22
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024182; cv=none; b=mGWD4x4Okh6XHgLgLl0cC/q7eD4ddPJ8IZuT/vA1nJ/NJAIGQVTIFP28/7QJeqrXoan5nxj/+xMF8bReC4gBYevY5hzC8Yh39LnIZTaSGAYRsERqO4wLwEHe7u1WdQsYw974kK0CH6YYtxoIy0VtaIS5k5tc8BTsUzw9EP1Muf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024182; c=relaxed/simple;
	bh=Dw2V5zR1I0JKoUdMWL/NJmcV9Sv7IPT66KG1neSesNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKKFGQ8TnditQ07hGcTTb4GW8TCwir8HQzjrdPFhsSjwLR4N+jnr8L4NrSAKAydH+UfXJiuzESxXH+h974YiPpJA4IT90M+EyiZeqp7Igbjc+BPrUU0HYJpzrfHiCCbjitjmO29KeSm2uV7Mva5BblKRgpXtt4f3qvIHoT9EtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWwGxfsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWwGxfsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF901F00A3A;
	Thu,  6 Aug 2026 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024181;
	bh=18tnNSeXxO4Zwqer7FN/OssiAs8DhE4KwvmciYbyeM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWwGxfsPEDzvp8ECPamaBuk8CTK/N9WKHmGOqWbKI1ve35MzU2fyz55t9byTyaNG1
	 7IsC2os3QRY4I8ZYkJNkE1RI0AWcGC5Mas3EhQT66Co8ArBwYSZ8FhfePuLzKjQ7gX
	 lSMsTV+hXUXnqgZBcbYapfci8WvO+8DC5dVNQVsLc4V2tWzWc1+EukzHSQUD4dF7K4
	 0cQb/akbRcPqp0HaqRgZqJbvaulJmZRhqvoUinScmI/DE7Xkpvl2Xx0lIvZnonpfAt
	 5lVj0tS0YamVZ5M+ww4wgOZyyqY5GdaU2ZKhqDu6bTlOoDB7L2bQbTivJzUR3El00y
	 xksgfUu5MteWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: LiangCheng Wang <zaq14760@gmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Date: Thu,  6 Aug 2026 09:49:37 -0400
Message-ID: <20260806134937.599576-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806134937.599576-1-sashal@kernel.org>
References: <2026072949-jawline-chastise-9c85@gregkh>
 <20260806134937.599576-1-sashal@kernel.org>
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
index 73a084401a0c2..2335d7e2b3023 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -906,6 +906,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		return ret;
 	}
 	switch (sdiodev->func2->device) {
+	case SDIO_DEVICE_ID_BROADCOM_43752:
 	case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 		f2_blksz = SDIO_4373_FUNC2_BLOCKSIZE;
 		break;
-- 
2.53.0

