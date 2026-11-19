Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.2.82.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120714;
	b=HbCAYzjDro5cl6brp9Cb5Rth3zDh+V8q88YOuvRVg9yvcZC1xU3Hr5g+XEppm0W/2LL1
	 sS/9rXOkce9sMjdyTceNTespvXUl1obtc5Ji/GkKgOuTbblCnuePSusKock8Jeyj/RXvW
	 2TqNDs73dw09Lk4EJ4eiKTBzUhbkjasVSpuSV4vnM6S84RA8DrBDtXejYQZyTzAz0mGKo
	 wFeC/iPibaRjfo0ZhPCuFnPjubMBOjMLODtxmgGr8g5a5u714w0vHjWj0iElJps054txe
	 lk3MF69g6+jf5YozjQx/GayTAP4YEMAl5HHWXDfb1ZBNdpqP+Y2jPCzyqgDdKhgoPuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120714;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=ls12ewtahYys3BgXs1i5K4jfY5UsBzb56tMFJsHUcT8=;
	b=P9UKoCmxvxQXuhwfpi7a+CtYGm2AIlSgg2ssedqf/ztu4NVxhcIC229A+Rpup8upA5ip
	 8kBldUKyPXregHgqv39JDlJ1qnD18yaCnQjy3gMqqBFxfbUh5DppbsgvCvVAywL8l3tKD
	 IqfI4E061cfnLPY4J6VQOIjH4FjEbjp+YfPPSKmzwTCKk1ysth/rWbOWJeUKKuzCXkoq+
	 +w020+0s1KwHW1CmkO9jlHZYUmx1ADIceHJxqeqTtpQcP1gBfx3h69MFongvmaSUP+5ob
	 lZgfkmSaI8WnJqLTuCVEHeSCxgT3ePkqWLAz5Zh6o61B/1DHx+6/1wNj5GJlKTH/m2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.pl;
	spf=pass smtp.mailfrom=yahoo.pl;
	dkim=pass header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=OUzChRI4;
	arc=none smtp.remote-ip=34.2.82.16
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com [34.2.82.16])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5EE606A911
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 20:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5EE606A911
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.a=rsa-sha256 header.s=s2048 header.b=OUzChRI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1795120711; bh=ls12ewtahYys3BgXs1i5K4jfY5UsBzb56tMFJsHUcT8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:Subject:Reply-To:Content-Type; b=OUzChRI4DyBXuCYN/2I6N4f5pQa65bpk0VKQwJrvwWkRmWrE1nmZwLMFEW4COWobBLGLX5nRzAF14mlwM7E0QeqDojSUYniILpsyU2C4COyEKuaIfm/ueHBlZvJl303H72uwyy2CLi+kHi0SdlgBKkV6MK8S4zm1UiI0S2JsoyjQZEc4BccljNQTtpxJyHRCJ+qV52mIh/ecrbeTO3fa+kXtjW6ZWESJB+6jJa4a76nyM+NNlb5u8ho+JvSrFe1snSi3rmtoMYIlWxWNTwk62iWhGhVlICmxFAoB0I0kUQAvFQQ4pW/rRw1e7PFQZK9jujxLZrAD/T8L9lYCB4pwTQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795120711; bh=6pUe0tO7lSoHJezBiuuWKD7pgGPjsueue3ohJIooHw+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=S2Bgl2dqDIRcIaCaVOzB3KFq3eTAWf/eJN03Nun0wTCpQV2pEwn+gI53yYPIYc9OiygtXaHYkGQaOp8l5kT+am6+qGRLRy4zjiEDK6JuXlK30cCfcGWC3yHlNeS44juQ7Gjko3qHeoO44FrWsxBz0eVfnUOD/SR+xa33B5R58gPo8k05jgcRYiXWQ/lruvbLsv4J0TtlrN6eeQE5OnYViZP0xhSwZ2ibyEZGz0bKlWMGZtcFc0zFDnkKDKHczqSbB7lJyBQCKbrtDe8VVcIulNeX/9TO0/mL3NZGg50PYiTAWok8jhWPeQB3bPaP/cFciDr4xMfjEMQISDP5Y5xa0Q==
X-YMail-OSG: rB3NTKsVM1lvXQTaMHCMZtjB8Lq_AdSDccRXBpVBKJdto.PPdF1YQMs2RaYwwsc
 6sNSZaESsiFHNbty1nvub.Ea547Xa1REYq.yBSOxgMQEASqYrgyQ0LqO_FYAOBdUKK6AUntyRqsa
 7fS7gWNA4vS2M3OhYN5bBGWDs.bjsTkRsXapkhVs.AZQw2rupPnpDRXH_uVzn8j1ddXMOitTK907
 FVDVIkltFPhbplikwW4pHzqYnR3KIJL_.QQast.sprZJ4PVxuLKfKiusVD2VUEQhM6j08zOEzeAe
 uc6jcU_KKZ_1NumDIbZ5M9v5l2T2DLGq.M8ACmY4PXVEsUk2dGC3hdERdNpwlT6NejARbBF.Zca1
 5ibMbFooR5koNRHDUdFCopCAAqesJ1YdQDlKSbt73MbznOYVtrb2MoonUgNIXTxY2F8FZiWftd7x
 VOVNCkoAzJcuJCbVGcUrVgv1NGFrr_jhG9gtda2A3KkJLm2uY4nzo707nue_k53h_UmMLcKRR7Vs
 BXUnwwJz4X9rX792emnpKPIeTwiIRPu8S2d4pyOPpj58UIhCPD5Da7DSavAv0oSAJYC3ATu2ShQA
 JhAPVy6SltZah0baRPOTAXOru65QIhCcQECfb9Kexxpozfx2M3BrxRHx6IDcsMFaeKGdHts8mX6p
 e9W16NSJaTf93CSoXEl8lNOaHA4uw_UpHOm_bF0XRFrN63C7ooXk3xhuffAcXmraUtixs7YFdEzU
 SSmgWKtTWAnStb70AqPnK4McltCxslfuc5eJlZk2i1qj8BzsXhwq04udny5U3hSJY04PlmRDJfKP
 8vUNsox9HmPjMXXaw.vcO2B7ac81k6RYodhVv9YJ3Cr9q7CftCfplwqeaZ8npUtuqMzHlFerHxJJ
 SBc6TX95TdZr8d4xQKOzjwLoXg3pu0i_rBkaf7XYH_0qa5_O4HKajty5r4BsV7dLjs9om2Ocj7Ts
 69yDhlSUo6J1RG_P_HWsTkEV5mKKbOaF4MAIFAglWQUARnRgtfpl60OFXSupbjEddrVrPCFCmqju
 XwsCh5KjCrIt85btQGul5RfLRMTXAeDRkiYCFUP6VQxZ65v5PnQymU3Bt9BYq3phAQ_M_zQgUJ0K
 Gpa5CrcfKm2782Wlc3e6ftbbWbNLsgJp1jRjWAH_d7P.dJ4khID0GXsCpnFICNdnWOW2iNkHD.6y
 4sGSRzv_6ZAA2jWKggmAd9.K80kdjpg6liHepRkS0eEftrLIuHRuIEKlIDhC4i0jo_xLwEDBC2WQ
 9.mCcAi3MQ_RWIja9npl5McY.TcohjpgJcHygWd10ngkkbzCpyQuaEyOl1N_7oNNSCzNRP2ei4rQ
 s5kxa4q0UjArOgwV7OSA0RAoknV4_xLfekbBNuVxmfQ_8LWybK7uclfczfh85_N80N7ueWlBQCqr
 4fm647ztWngyQfUhhCKfLyEinN4kYCHSxNEDLbdyuV_7XNIBfjN6oBVKbEx6Tv_OsJhqTVdkLdHk
 N5zF49oFfRy4rSr_LJxM4p0DtSK9KQ0qRABvQZb6Wursi8d_SooHiMdcUVud9v.IQMsl0B9x3pR_
 BrO520YQg7SbrM54o_ug.Ft3Cz62n7h_kdSKsXScjMaIc4zceHYl.6TP_HqFo804rAqm4v8w2wh8
 X9Eu4k_CK.Acf9A.Bvb12GYq0ZVme9o2EuIRx9cOuJoW9KQPevB3jIeK53nKWjN8HPp_z8YYDV4N
 H8FJE6tLNQe1SwPw5XXxfSicpYNpv5V.TONX8MhuYwqYwzNhtoe5qBL3gtt8cIS_8hSQlg1GSVPT
 JdHYzZhpnuSXS6S2E83UGtVOx9WvqjtUjMJSLsGVPGGNXbXRQQmRcJXNqEig_ZiT5YmpNDxBXtfo
 EPxFvQuHKBUyr9sInRl.U3VPrLm1hYXhOu1ChGlyY_SuoN2NkfDqzux8X5gcYgiHOqpFgvLSmmRm
 fVPpvBwNJwOCg5sEtzCuhfRcR3MrG1VtGgCveAYyomeavMYuNcKL4EkXG2OwOr6vua99mxemDqP.
 9YmXwDeLqp0ZHtLNfLu4zohmaXiwac24rZZmxgNJnNWzbnPGF
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 6240ea9e-c2d8-4f5d-9117-4dc5138b176e
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-101 with HTTP; Thu, 19 Nov 2026 20:38:31 +0000
Received: from dip160.lsn.ir2.yahoo.com ([87.248.99.169])
          by hello (SMTP) with SMTP ID 899fb1d7cdfdb5134d8b21ee8fa17d65;
          Thu, 19 Nov 2026 20:38:28 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Tomasz Unger <tomasz.unger@yahoo.pl>,
	Frank Li <Frank.Li@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	dmaengine@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: bcm2835-dma: Add missing of_dma_controller_free()
Date: Thu, 19 Nov 2026 21:38:25 +0100
Message-ID: <20261119-bcm2835-dma-of-dma-free-v2-1-ebde4846d206@yahoo.pl>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119-bcm2835-dma-of-dma-free-v2-0-ebde4846d206@yahoo.pl>
References: <20261119-bcm2835-dma-of-dma-free-v2-0-ebde4846d206@yahoo.pl>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795120634; l=2640; i=tomasz.unger@yahoo.pl; s=20260311; h=from:subject:message-id; bh=r54SCDH096Sq3Qy3Zo0S70bcX0NWETfM5biEJT1w4Mo=; b=0uZV/zAhJ6Ds9dajZVw4cxsGMcv4KWpk+NpClNwwzyolMekaeU4BZ7yGIiW/dKZxaoPHA1mgT 12YQ3HQLz2XDVy2DFeHWQ4wvyzPcpZTd6jSViPzdPM/NqyJNJMlDQC/
X-Developer-Key: i=tomasz.unger@yahoo.pl; a=ed25519; pk=EPPsO91uz/0J2cTQ6ol+dgxYaieEc9dKSXWUb51n46c=
Content-Transfer-Encoding: 8bit

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

-- 
2.56.1

