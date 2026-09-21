Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07EC47FAFB;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987586; cv=none; b=L1Y29wfM73jQy+1IE7Z9SLsEA0Gi6mnnymI3BaOvDmbmTYSsxiquKJ0lEQmDW/WrwsuLzmjcSPMhVYwAJCpZWINcWFDiB+1eBrP4Rg545rSKxt4uzLGSDZF+75tLakb1WdI1tYacZr58+e+uveKU7atCx8EpeiXqDbPH5jbrQrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987586; c=relaxed/simple;
	bh=xN+UJbgsVFesEQgRsqdbzmzNFifNC0e3F6BbeYRcHRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwBLdAoryJllGRu6nky6INoaJ3djHJdOE/H9SBysGO/v3pT9/3engNq9fEVaUC/2J1zS0XrlJYlvzHz7IunwtIzbwX/GvgknXUCymHKPA27y2/nGYyF7tVz2aL02CGc0EH1z12TvlCIrS/WjwC4QYAatDtVjXAh32MxfIBtKh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQIBwaew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQIBwaew"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C924C2BCB8;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789987585;
	bh=xN+UJbgsVFesEQgRsqdbzmzNFifNC0e3F6BbeYRcHRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QQIBwaewbfGLu24MQDGBZJhuZI5r+ZZksRv/HLEWMfxUbtTOTptCi14jk5NcXEDtW
	 VaeT+UWY7g6uVDkncKZVEagOaSVLejPjp1vMuL8JSZ3NxmCl4i7Mw6/ik5JhUwsQJ4
	 hSYShHiiLu1XhZRCejmaj57ca+bV5muUL5Ri0uJFlYQO+AK/+9jLpgi/L652zPJJPf
	 /v9HoegRKO2L6Ylqw0tag6wE8BFUcSgP77DeXbYA9UZYDZEwNnPje8WqcIHTQrf12+
	 anlPN8OPeghs4vdmxCe8nJ3UR0MUA8OfrKkaaVp6w6kU3029g90Atu/kKqkVmrlaD9
	 0WBf8j4XqPjFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B728C982E1;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 21 Sep 2026 12:46:22 +0200
Subject: [PATCH v4 1/4] backlight: qcom-wled: Fix NULL pointer dereference
 in wled_remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
In-Reply-To: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=+dZaRJRtQ4v3SzBsEJavUDVtILbeFcbE2ljB22hvcJI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqsQr/4lkhyZPqySJGz8AbmEdnqgIJmewQv2Vg8
 UJPRD7QvBSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarEK/wAKCRBgAj/E00kg
 cqdgEACW4JkRf6Isv9QBPQ23EC6GzduH57OWTfvtjLxLPCjceEaSPsrzUHJT9Oy2U5NYJwlZ8Ih
 LbTJS2rNlynQzdPCbqcJEIIwu5KUKLVPJykGUsxclL6gdFXEhcdec7YLRrKMyY6TqxkW6v/cHXQ
 R4EMHQ9SMCh49+sJE7LdtcZ+y+Z0hqL0XXZuaaXYbj2crc39hI4uxtbuf4gNzIAZm6UW/uDEWma
 2fojatxwgf+iXwVUxRyisb70+zwk/L4yR0JHZIUb3+F0+HqwAHbRA2aqMq5stkwWFH1STmscsua
 /h0FdqK2MtuoFJYpc/sAtq5Okn09o5lqBqqvJQSoHpgjt61KKsBGXMPrUm9LSjmNooroaTeurDB
 UvJCK3mElpGpDxK5tzkRofhdYjBvfONap1EEYAE3M1Ww3HVqiFECjLj0XtwPR9BGuykdezorZ84
 JzCiFjK85ZPU/SduLIumAcsodjnP7py6jwoKN6o4lYfZM3i6z7NIzckd7s1mNyV2y7N1jg3BLru
 oJKifmcvVRtdOYwAuigCfxdAeetAvoV4rZL1EuvQyhac1cgkDjwyDKMBbdKf/M8SIxdv+c56Js0
 b4gfr9vDcu10RMj0wGw0D42DlblpaR9lF0KEIj9fhuZK2m7DSW1D7okZK2DlmJA6eCF+soNV54o
 w9bufxI8ObtEL4A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

wled_probe() doesn't set the driver data for the platform device.
As a result, platform_get_drvdata() in wled_remove() will return NULL,
and the first dereference of it crashes on unbind.

Set the platform device driver data in wled_probe().

Cc: stable@vger.kernel.org
Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/video/backlight/qcom-wled.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 650dd95f06ef5..2281007bdd459 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1675,16 +1675,17 @@ static int wled_probe(struct platform_device *pdev)
 	}
 
 	wled = devm_kzalloc(&pdev->dev, sizeof(*wled), GFP_KERNEL);
 	if (!wled)
 		return -ENOMEM;
 
 	wled->regmap = regmap;
 	wled->dev = &pdev->dev;
+	platform_set_drvdata(pdev, wled);
 
 	wled->version = (uintptr_t)of_device_get_match_data(&pdev->dev);
 	if (!wled->version) {
 		dev_err(&pdev->dev, "Unknown device version\n");
 		return -ENODEV;
 	}
 
 	mutex_init(&wled->lock);

-- 
2.55.0


