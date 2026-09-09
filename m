Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE0472535
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946787; cv=none; b=cEYUvKvJqleG8ldyY6Ksk1ZsOLBEoQnU96xcKI8J1x7SyLQhbAiI7ueEA72i5cDgum6yaZNemPYGvqNPazQAgCGRvSHsRMfXNt4XxiAbfUU44efuV3eQCrLtjbAcDFKGE/5t2D79yYzV9RZYNhlcUVi3OTk5sTQCNAix+k/KShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946787; c=relaxed/simple;
	bh=IrhlDnu6UqVr6ZzUV11lZIiY71/Cbeg6Wqd7x/5D/8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePnyN4G6XBf96akmxrLyz2T8LJYP25/ko9iUiGScHT8SfNPebeKyNs8okGgo9hiJbC2HIZx/14PIRhbV9GePKKdEusyDMGICDqG4/aeJ1oOAjr/PrzuMmfKDm2yrGLPcrErP4eokJGhTJLENw5zTRs2yjqQZ65MCKUvaMosWK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MQdA5dsL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VV2WxLSR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MQdA5dsL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VV2WxLSR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6898dvZt639490
	for <stable@vger.kernel.org>; Wed, 9 Sep 2026 09:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=23pCnDlotWgSDzZtGBECCQKx4TDiJuMFHwx
	4UVLT8O0=; b=MQdA5dsLmyug73OiXCBvXc0RBgK5rXAg8rpfqTXsw14auOEyaFz
	H6h6hGCqukQ0vS87e9LwvRD3uDEaXFh9/zLiNf8ZpFJVlqbq3yDKzucfr791xCzu
	t9Sp1BVVFZFxb2bhcgWqUKrbfbCN3RSrJ7euVgMPmr+4dgG4zklz1gnLTV3U097v
	8S0VohIb50ziU5BJbun6cRi67Otw33JPxRxHlFl5MzhK4csld5N1onavYCaFBm0A
	NTgwfIcFHAKocw2xnQPI7ievmuUC2cV6llAaRBIk6tNtRWGvySsEmQdzhHWr4nc2
	Nf6b2dirBPMLRn3rGOoZMTGtx9eHbip8Urw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxqj9k9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Sep 2026 09:39:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92ec3146553so1305798885a.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788946780; x=1789551580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=23pCnDlotWgSDzZtGBECCQKx4TDiJuMFHwx4UVLT8O0=;
        b=VV2WxLSROfb9DcuO9tB7RzcYxvSTpWgmaTAHaBfmQLMe9z2rLEhBMUiR+31BT4nyJW
         8UI/X1YcAm/Gkskd3/IkDFqWrQm+ztQ+nP7JyDWxKhIdN4oG9Kxvg25rTLETkZvNp1Z1
         PtSX9zo2D6bq4Ov720Mq/laiw28XIdUmDdQXIn/mB0DrJFZKiTJW29jF73RClTiofkrw
         BKLH15vl0KpheJ5mF+WTfMscKEavS3E7Lgr9S7KkrKnewyoQ7Gl8dCthgYVTwvh4NiuL
         mLS423ZkDNEBJvdDUbrJG8Pm1KIaYOvqmwbwW8OmA7JiFkbtyDbwJuZ2l9sPrPwrpVOw
         PifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946780; x=1789551580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=23pCnDlotWgSDzZtGBECCQKx4TDiJuMFHwx4UVLT8O0=;
        b=FEcfFpYw05Vb95PoJvcdsByoXvsVuUUxG25OwW/Dfpp8XLgE5lJTAtRs1BAoHfa1RY
         pntqfm45SClivF+34D+2x1YUwH/QUpfA3TYUGkUaXIV7bWivrulpJaa9cP2LusE8zuq1
         SsrTScpMhcQAwmxwmkEKyAKRDCbmC9mmd2w+yIPM0CIdSJHsu+gtFRRP9ERrTeM5+yXZ
         pDp4oIYkxwY1A72VlaRp2EM/hzALMGXMsquxr91+0P2wNzhXScoNg5PVREEfk5ye5iYv
         joLDjJXF0QRELeUv22SDWHs+Idcqt71xKAKZirlD+i6qWQeTlAvFSIVkmMS9YQ2rra4A
         1dtg==
X-Forwarded-Encrypted: i=1; AKwUvBz/mlE5Ebki0GIdrECaIEeuQ32dtDvkmpF1XJkPvxZVcyDwBuXcNQ//g23/33WxyyT/Jlgm/Yg=@vger.kernel.org
X-Gm-Message-State: AFuF++lwmHl0GTQEqyvJGRup6Qm2c77OD9CXCRw/TNkh+12PVeKrNwvJ
	uvl0k5bjdOY+EYHOiQBiO1TF68iDFpO5TMJTk3rzg9HYKewFIzJZCwIosohFP+pTMx1i/6FYUuq
	euCqcZfETI22Qm0VideljzPiLQX47f3oGOdOrnBON9wICMGBBk9YL2xo81VA=
X-Gm-Gg: AYBFou3tIiJ5vQ0h68FmhyMkfPNp8eSlKXEpPg272aMFjk+LQxJ5POmS58mk58WPxHw
	/C8OoFyXTJIdRGAu3Try1cTF2+2G1J7XPhASjjCsufdLAP9uKJ3mkV7jW+QSh1hWvY83dKE+DPK
	LhcDzLL923Fo0vFRe1KkBdMuiwforGSMVM7CwjokmpYACKl6zBzGj3bb0aySMyfMk/lK7MiVVeK
	awONlRvwaODRyyJjeQbYWQG2PxufpPlynmI2QonSbaP/SAjjxBtEmxBQKBLQkr0Hu2RT++BPwFV
	T5VCtpW+N3MCzzipf47fbe870qU599eE385kqI0U3x65CDSwT+fFumLeMBj3mA4cWuvB9ZLs3Nb
	BA2zDmUpnhL7aWisR/19HwUxoOUAUTLudj5dzaAJsbHQBB7n8TY+C8yA74uq/CgceC1bXaSuiBT
	D8mkEvbZJpc+HUnPI=
X-Received: by 2002:a05:620a:3199:b0:939:7f6c:fdf with SMTP id af79cd13be357-939805e9ed3mr3740283085a.15.1788946779964;
        Wed, 09 Sep 2026 02:39:39 -0700 (PDT)
X-Received: by 2002:a05:620a:3199:b0:939:7f6c:fdf with SMTP id af79cd13be357-939805e9ed3mr3740257885a.15.1788946776288;
        Wed, 09 Sep 2026 02:39:36 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6e19sm6387800a12.10.2026.09.09.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:39:35 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stable@vger.kernel.org, Sergey Lebedev <lsa.uz@pm.me>
Subject: [PATCH v3 1/2] Input: soc_button_array - fix MS Surface Pro 11 probe failure
Date: Wed,  9 Sep 2026 11:39:33 +0200
Message-ID: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: F2MXJqxU8zGtnzuMcs7EDbo9p3NJtVdq
X-Proofpoint-GUID: F2MXJqxU8zGtnzuMcs7EDbo9p3NJtVdq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX/vtp2rKZZUgE
 MoDtlEsB4rJmpIQb5M7IJ7YuuxkRwZhnVLEFx49M2B6GoZvVD7TvM13dZ2EpqaDBVUSjIi3+AU2
 7sNJIwNjrGBq5asiBNk5jo7yZpfqxUc2AAL6b4e8PglkEgMA/S5bunB7aCqR6Hh8lJ+iQY4jyf2
 Z022WQiW185DsNFX6qkZB1go7elHrYdhAnQlF/tp2JbY7BFsTGf/G+Dzg9XMmDepELMXFXi3R8y
 pBehVYYzhsw0BR6pll5Px21foUixWXDUFtZjmE8Nz3H5JOZhQI897sVoNvEdIqqFPVlGx0QZOJO
 6+x26eMfPF6L93KFbj4y2fjw6iWhRniVOwWL2oGfqEeLLkdp99VUCOR6rPs0AWZI9ljifnvYxfw
 BPikcU2dJbHhXEI//G4dJxae1rF09MpGPeSTUKUxFe2OrotUcAx1IKxTiiHytwAK69O6R+b8qVf
 9UXwhv0khmF6gJwusPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNyBTYWx0ZWRfX72KcNA4DNzu7
 ICASekVp2sESzBBZ2PHvvx8UITQX+PpIWGofO0LV6ZMx6Rg1+M+4CSA/Z66Qi9Wbm6+jHyIReAc
 /jv5k8BQnlJouMle/3fNh+6PQ159Fz0=
X-Authority-Analysis: v=2.4 cv=f/p4wuyM c=1 sm=1 tr=0 ts=6aa1295c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wgnLJeN4XU_MoIAHw-4A:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090107

On the MS Surface Pro 11 soc_button_array probing races with the GPIO
driver probing. If soc_button_array wins the race then gpiod_get() returns
EPROBE_DEFER, which should normally take care of retrying later, but
the soc_button_array code deliberately ignores EPROBE_DEFER causing it
to fail its probe() which causes the volume and power buttons to now work.

The ignoring of EPROBE_DEFER is there to deal with a problem specific to
older Bay Trail (BYT) and Cherry Trail (CHT) tablets which often use this
driver. Modify the error handling to only ignore EPROBE_DEFER on BYT and
CHT platforms and propagate EPROBE_DEFER normally on other platforms.

Fixes: bcf059578980 ("Input: soc_button_array - partial revert of support for newer surface devices")
Cc: stable@vger.kernel.org
Reported-by: Sergey Lebedev <lsa.uz@pm.me>
Closes: https://lore.kernel.org/lkml/20260830141355.55898-1-lsa.uz@pm.me/
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
This series has been tested on a Bay Trail tablet which needs the ignore
EPROBE_DEFER on BYT workaround because of a PMIC virtual GPIO.
---
Changes in v3:
- Add Fixes: tag
- Initialize irq to 0 (invalid IRQ) so that the new irq == -EPROBE_DEFER
  check does not potentially check an uninitialized variable (Shashiko)

Changes in v2:
- Also check for irq == -EPROBE_DEFER (Shashiko)
- Drop #ifdef X86-ified soc_intel_is_byt_or_cht() helper,
  linux/platform_data/x86/soc.h already contains non x86 stubs (Shashiko)
---
 drivers/input/misc/soc_button_array.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index b8cad415c62c..264c41f80d2b 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/platform_device.h>
 
 static bool use_low_level_irq;
@@ -160,7 +161,7 @@ soc_button_device_create(struct platform_device *pdev,
 	struct gpio_keys_platform_data *gpio_keys_pdata;
 	const struct dmi_system_id *dmi_id;
 	int invalid_acpi_index = -1;
-	int error, gpio, irq;
+	int error, gpio, irq = 0;
 	int n_buttons = 0;
 
 	for (info = button_info; info->name; info++)
@@ -191,8 +192,9 @@ soc_button_device_create(struct platform_device *pdev,
 		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, &irq);
 		if (error || irq < 0) {
 			/*
-			 * Skip GPIO if not present. Note we deliberately
-			 * ignore -EPROBE_DEFER errors here. On some devices
+			 * Propagate -EPROBE_DEFER, skip button on other errors.
+			 *
+			 * -EPROBE_DEFER is ignored on Bay & Cherry Trail. Here
 			 * Intel is using so called virtual GPIOs which are not
 			 * GPIOs at all but some way for AML code to check some
 			 * random status bits without need a custom opregion.
@@ -201,6 +203,12 @@ soc_button_device_create(struct platform_device *pdev,
 			 * we do not have a driver for these so they will never
 			 * show up, therefore we ignore -EPROBE_DEFER.
 			 */
+			if ((error == -EPROBE_DEFER || irq == -EPROBE_DEFER) &&
+			    !(soc_intel_is_byt() || soc_intel_is_cht())) {
+				error = -EPROBE_DEFER;
+				goto err_free_mem;
+			}
+
 			continue;
 		}
 
-- 
2.55.0

