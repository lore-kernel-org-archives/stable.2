Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.2.82.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794780923;
	b=NSQ1CZFMoWJf05sszSQ8yZS95iBQrBLewZwa9HcAnTZtxM0sa9JYIC+EN4MDvt3rSNpK
	 guiLeT3YR0fPDizBdMfaqhiWwgZ1d6qNGrX4KCbhM51J94irt/bViik6fVlkGvLpXBRPt
	 ZZdGOMb+YMoVxq+Q0Mapu1RIubzThHC8+RLhpTiwU3249N0feovYN4MvK4TPk8Iyhxlvl
	 IZLADQq27PJrztejJ5axWnxDjuiVtKkVryghWL+KUszqKj8JMQKoE38fMKX2W/WfMgL/q
	 4xqxTsAtyyDUwQq6w/KycEuA0Uw1v2TonhcOisSLYRuoEstbzt+p1ekKEYgn/8W6k3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780923;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 References;
	bh=2F2z0ZuZcbyuAjZU7VnocXFK2M42aX34gNp3ecJ79HQ=;
	b=v5BIVlYn1JWe0eLFe2uaqMBgUiiGZwq+d34R6DtqHullntafmceF7/1XU0dm5fg9RygP
	 hgqPMqrSyBQ9C7/8NTrpslWZqtqdwjBLmxU3rysXtd7rGhqUC+Af4zLJA7sH69Odz8b9U
	 gSlTbR5qDrju4CBLLSMT0I7imobmIYdNwWgRJpesg4r5GwVoyihjxU6rDqaqj4jz9gUm4
	 unlO4P+V9x6z1trF16SY0p7vO6DF5fh8X8UUDnshZaQ9tTnvQy9Tykz+ec+qcb241Iaz6
	 6TsMzSu3Mx45/0mmomVgXcGWBbOC2R8gPFlv04am0L25VxqFF0bDlYHJjwGwnqDvTpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.pl;
	spf=pass smtp.mailfrom=yahoo.pl;
	dkim=pass header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=S9cTi6Lh;
	arc=none smtp.remote-ip=34.2.82.16
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com [34.2.82.16])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F6606A333
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 22:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 709F6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=S9cTi6Lh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1794780920; bh=2F2z0ZuZcbyuAjZU7VnocXFK2M42aX34gNp3ecJ79HQ=; h=From:Date:Subject:Content-Type:To:Cc:References:From:Subject:Reply-To:Content-Type; b=S9cTi6LhY2apmj7BjKqKoB6081fiDVvPkhdFmk6IwYe/09zZLaOALZS+Dgd39bOOaURQXTmpUXUNTeGq6AapHsf6rFcejEiMyrOnGlpP3G347uE/xqLWTG7kVIbX8CZcl/m2TugR3VWfHHYQ1e0G7exbuFw/5E9baKIRDRvbpTfL5fjNRNyONjgApKeJJBd428H85pJBkXIGpNvPqmSUrTkx3LG5DkNnz91ZeKR211hJ55XGzsQv2oZPWyC6jXvqVZ++VGlWB6kBnN1GSf6F+Ye2DT4Tno+M1PwRsKKe1BZEuicwof73VUu4zbgrvg1oziaukydIYavc0NXVoGeGpg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794780920; bh=8io4HMmBHjf90ncS3kftgptXmHBAbxhh8oY345FWlNT=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=BgYWuToiTRfg8CGs5ho8lBXG0m6MxIayP55YOLU24JCSnH5KZcEGxc/emTtCNbnIIxTkcbKAe3qSp4LCBai7PAXFjiwwlCrihLx7G8LkcYfVegDz2DBW/ycqvYZRkbAV+BJUR2vYhfXaiMUnQDE4K2UNhg4OnqoopMhBOd/OFoRic3zHXh9WZ/NPpprNRJnUTMH8LBtmLXmlfuAtqz5ouqTWUZNbMXtQ/56Lt5oPRWO3rudL96J5bHBC9IaHSjGw8ZibxYrfXQwBkX/fmfI5XOx0ICypgiQhHiOgDsj8Z3BZXuPfDeyOCTNLitzllj+NWTN1mX0riP6Nc4pKk2pPXw==
X-YMail-OSG: cKdOGDwVM1nsX0eogjTveVDoZYwLm_y6FI.Lo4VvAN2AVen6dCWuS3SKdH8QymF
 HeJz658itmZov0GrRBecn.AnHGSmNhlVPkLpFcVLhDHZp65m0SpLum7F0c8I6VN095Ni6vJA0yvu
 aR13Ze84FTAL8N71GQ2rcTkzY3FR.ywrLd7V5SxvHaMPoaM8r_bF8Ocy8cdLjt3Wcra2YvWY41nN
 Y0i9u6K1puJGacQTAfFBOAw8646rzO.MEiGkEPr85mUrnXyqqVRQgULk1AJFF7bMPM9c4wT_1e3B
 nUVnNAR0g_NZlSemHcWAV1HDRLUpNKMy8.uwby7FpgcmVuRB7jqjWUkHGvUZ7UNDrSljjqYY8jc8
 LYDJyZXqK2xSiEaIRpAxf9ZqSQFCW._7kuXjXI1wrAhA7oLup7M_1r9wD3vZyODwJb5efhm_9qfY
 0_WPdJxsMklP.dgbiwQHyztaGnc7A1GA2GX2rmS73yRiIPRiZV2r923nXBDYRwPcatT2SYMtbHWQ
 N7zm1.F__3c9DGGAz9JmACjUNI2VIb3Ugsl_cJmDVI2GZ5oCVhZrOjlvSOkYPcA7tSjca9zQLmWe
 LcOuTlNd18fUalEYUqcBmwaYTfhBOWna0PbTRkCDB6VWo4eQINDGVezm2JrKrASq0tfJcCloJ829
 7ZayR39ZYVjrll5hGGKl68BINKvC7Iv7UatLzhoyjaNJB3AeKP7QfixrLX4_7rHcExm4PTleGxKw
 vXC03llRSI7HTYrLGpZhVS45_duPX_jr1wtrd3sajsHb4nQXSR1cSKEZBBGBL6P_x8VQiHFdPiAE
 DQeY0oDEgDbuwcQWqrpZEMpKB1_j.aYtNoIf2HKkAy1c1I_dM4uNzuG2M0_AvAoWsJ9JdlzGBvHB
 hoCbZ270BCJ3mS4KhQy3.LpBXg4Fk6qdS.bzvyHxEMEiMtQpeX8qddNMEQFGLX1PBQgCKIQm3vq1
 toB910W0hy_5BuY3AH69x06uPh0JV6FBrbhy0vg0RLhq.h8q4vYjwG8isaL8Mrpwh8CIAHzOB5Bn
 nEH2xcYQ2gxXANdy_jfdbWyaVc1GkMSgAp3co9JJJHoK4E6LH3PxjqeVYMjTJ_d8XkxiXAPG_oMo
 8Idse8deYm181fMvYMo5ust2.FJbJVxd18dDmEahAOLt9mvmYgtEIgaSADih0kIwyVVjJnNUSGZW
 LvKoNECYZO319rDu3YIIV_IE7Q0zY3cRmNvOsKOxMRX5v9_y4u3rRRlELD1C1eD0E4xKLpm8c3CU
 6AgoMdd9IWse3SrmH2PyvmxqbgurRd.mJNSLx.nWnJOYddYQf5Bgn1P50oduQrV_0mzg7MTC05fO
 153eHdM1PiEnaEglv4J_98E_dBDkJmzxlUNQ_OxW5I1S6XVoN.mRj0t7P5LfK3o1bZdx5DqU83T9
 FoCdZQ_g62dmz9M.yIF9alxZvegJLc2X_LCRK0in2aD1C3N4WVRFw.92KTHkzjOUnXAVnsUBZl4H
 SZKmiVSsIxiU0j1_XmQD3AP0rJbMLGJz3uRvixs5gBTtUyaf6yU5epo9HnqhYzRDX_KqQN2SRX.r
 KIzDNSHcxvy9AgdBm0W5p7sELB6lF3ZAza7U9cIGvjZsO_Lj7bShCJJMZUWNpwy44kDxsoHghqM.
 ZjsWLg1_2riOdlWLtkADNqzTnSPUdhVl5MCHrlvi9p1cgpz0eBSn7iXvqepF6WojlLKzV7rK0Axj
 I_b1VOMumhlWN7MNIZoLHjDpZcfLObnD06PsT3G3_JRgpJ_V2YgAfun9wr6DDHWtUfGBUwT69n5z
 5k1sMhrA5FNYYXTNH3mCNrBYND13Rs_fvJsFRXRAHxvj6SCchMevNSkuJPcTXsOj6jJ3t93sOXhh
 JZCYhc97StbFWZI8bC8n8rBnA6TViv_Tk8P20cibLUy4abFCEXHY8qClTTzroImtoGNRhn1lf3QK
 wfvfvV0tGYz8R.C9kKFj3r67Zfir17KzJ9osLThKbAwzxpBBOLeb5M52ArZK3jde8qrjmyxu8pyB
 JFPkDhQ20RVFpKTj93t95wgE-
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 49e5a92c-a159-440c-ab6e-d16bcb01beff
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-104 with HTTP; Sun, 15 Nov 2026 22:15:20 +0000
Received: from dip25.lsn.ir2.yahoo.com ([87.248.99.34])
          by hello (SMTP) with SMTP ID c8d60a975a832e99b8d64eff3def6a17;
          Sun, 15 Nov 2026 22:15:17 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
Date: Sun, 15 Nov 2026 23:15:15 +0100
Subject: [PATCH] dmaengine: bcm2835-dma: Add missing
 of_dma_controller_free()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-bcm2835-dma-of-dma-free-v1-1-d539234bfec5@yahoo.pl>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWXfAiY2XvkrpQuOJnYIXklYK4
 rs31dXhW5x/o4igiHTLNgpYNeo8JcglI/dspwGsfTKZ3JQiYrlzo6kLy/3Y8uyP8QFg+NpWVen
 yRq6U3kuA1+9Rvj9Ox0/3gnv/c7TvPwce4ll7AAAA
X-Change-ID: 20261115-bcm2835-dma-of-dma-free-ef85776c0914
To: Vinod Koul <vkoul@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Frank Li <Frank.Li@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Tomasz Unger <tomasz.unger@yahoo.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794780915; l=3260;
 i=tomasz.unger@yahoo.pl; s=20260311; h=from:subject:message-id;
 bh=jV0a/9DTGW1SPvNbP0Mt26tL8Imf7uBrc5dwl3yGkZM=;
 b=CscCH9wbwWmQedrCZPpnmGMn+DkzApvTh/R9gV9+S6vD7i2g0um3z09nUEFA3pGeMASBZjqbA
 dpj+AHnai5fDlH/VxgdEU7Wo+HF8NFz+66pNTc7PPRNQXcZNozKTnGp
X-Developer-Key: i=tomasz.unger@yahoo.pl; a=ed25519;
 pk=EPPsO91uz/0J2cTQ6ol+dgxYaieEc9dKSXWUb51n46c=
References: <20261115-bcm2835-dma-of-dma-free-v1-1-d539234bfec5.ref@yahoo.pl>

bcm2835_dma_probe() registers the controller with
of_dma_controller_register(), but of_dma_controller_free() is never
called, neither when dma_async_device_register() fails nor in
bcm2835_dma_remove().

The entry stays on the global of_dma_list and keeps a pointer to the
driver data, which is devm-allocated and freed when the device is
unbound. The next DMA channel request for this node is passed to
bcm2835_dma_xlate() with the freed structure and, depending on what
that memory holds by then, either fails or crashes. As the stale entry
is found first, this still happens after the controller has been bound
again.

On a Raspberry Pi 4 Model B, unbinding vc4 and the DMA controller and
then binding vc4 again results in:

  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000018
  Call trace:
   find_candidate+0x64/0x210 (P)
   dma_get_any_slave_channel+0x64/0xd0
   bcm2835_dma_xlate+0x24/0x48
   of_dma_request_slave_channel+0x178/0x2a8
   dma_request_chan+0x20c/0x380
   snd_dmaengine_pcm_register+0xa4/0x2a0 [snd_soc_core]
   devm_snd_dmaengine_pcm_register+0x60/0xc0 [snd_soc_core]
   vc4_hdmi_bind+0x4d4/0x8e8 [vc4]

Free the controller on the probe error path and in remove. In remove,
do it before unregistering the DMA device, so that no channel can be
requested through the node while the device is going away.

The bug was found and the fix drafted with the help of an AI coding
assistant (Claude).

Fixes: 96286b576690 ("dmaengine: Add support for BCM2835")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Verified on a Raspberry Pi 4 Model B: without the patch the sequence
described in the commit message oopses; with it, binding vc4 while the
controller is unbound is deferred and HDMI audio gets its DMA channels
back once the controller is bound again. Both paths (remove and a forced
dma_async_device_register() failure) were also run under KASAN in QEMU
raspi4b: slab-use-after-free in find_candidate() without the patch, no
report with it.
---
 drivers/dma/bcm2835-dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 06d830d36882..cf29d897450e 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -1011,13 +1011,15 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	if (rc) {
 		dev_err(&pdev->dev,
 			"Failed to register slave DMA engine device: %d\n", rc);
-		goto err_no_dma;
+		goto err_of_dma;
 	}
 
 	dev_dbg(&pdev->dev, "Load BCM2835 DMA engine driver\n");
 
 	return 0;
 
+err_of_dma:
+	of_dma_controller_free(pdev->dev.of_node);
 err_no_dma:
 	bcm2835_dma_free(od);
 	return rc;
@@ -1027,6 +1029,7 @@ static void bcm2835_dma_remove(struct platform_device *pdev)
 {
 	struct bcm2835_dmadev *od = platform_get_drvdata(pdev);
 
+	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&od->ddev);
 	bcm2835_dma_free(od);
 }

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261115-bcm2835-dma-of-dma-free-ef85776c0914

Best regards,
--  
Tomasz Unger <tomasz.unger@yahoo.pl>

