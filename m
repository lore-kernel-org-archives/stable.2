Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043837;
	b=ThTlFbaVa8EWa6AXnovJKvElX0A06r3ZyylFN1dtykQSod3O5aLLkWN2ThVv2C1kJaDf
	 HIzbE8VKZRxpDCiBhk1lYxXmv4FtYNNoS/fFRwhoHL3LiKei7rJffdyOnoZ2ZSw3YvuBO
	 5SWhgcCaI7VcaFWWLEiSYhLKTZYdvy6XsFaloaZGQhL98YY2Z6wdQ5T5jRYYfzzPgrC7r
	 kxT2Fhk/1a5YuDgpCIcllAEDk0gFKskR+0yO/xct37XLBFAF52+QUogMKVGuhN5fGppre
	 FmtGFs0O1/kpcKXGu/uSKaoi7QtCV6aW41mwFyzoKSQ41UAAlcDlU/BNLycRzi45R4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LEAjNOwH4Kcy8RVVcIOdEYwr0+gz4oIBgqohPtwFWa8=;
	b=lrF6r47ZJgILQRfYjktj2pZJDYaKbaL+mFKuOcwxeASCstGCEQJqod1eNbhcPLzaAd5x
	 XRvhxf2jgE5XD/1y2pvs4ME5PZveO/hiee6ZcvmD2MBPRUEJA4LM6cSxttocAHbVRAHLF
	 N15A7QS/WvgShMKxYzBhaU/WSoxFejCJUlYiiKjcJuNAP5KHGGr0EjGbn5/7OAtiLdXst
	 DkitsZP3s53grrZOT5DEQYlDjqhiLGE0tWhzIpVeEd2S9jI414yVcWQo7q32buI1FslIG
	 IB4KwIMY/ujWJVZk1E8O1Q8lDIOvcw6u5WajciJMERw6ulEwXqrXvBfUV8cOHahMviA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9IChAkO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E8606A330;
	Wed, 18 Nov 2026 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9IChAkO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795043836;
	b=Tazk3KRzq+HFLozGWGx8cI7+M6qDCDnN7G9GOsW+y4AZem7aaMgDXjIM5khT6xufGMG/
	 wAHbeidfZVP8FBIIlwjspcirWIh9NLiX3zbf6oNuDmbYupfUYuOwSipk7IK3N96XFHsuL
	 MAgK8LcChVGuiEXQkip0/DG/++QnzOgS9lcUun92H1KunzwHhhIf0jXfpbjlf1yLmiaE4
	 2N2SzRjCg1A0BnPd4X5HDoFuTHTUTM5umjTWTVqid/eX3FxOD8eptjcmhbE5Az+Iluru3
	 KgKdoJW2ZMwtG+NXnV7XF/dU0tCusR/Y27f0MwLly7WbRlpKZ7joldZWhS7r2CtwEYA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795043836;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LEAjNOwH4Kcy8RVVcIOdEYwr0+gz4oIBgqohPtwFWa8=;
	b=oMsx2MhcPhSD63dNN5YeRgp3hqgVRkI2wb3X6ythv+7Vc/gf5b2SXSQ82rp/MO58diPo
	 obOzc29eug8Z+NKtfoc3imwDojFRR6zk7s/47Jxa0Hj8PVRc+WCp+tisLREYVjUpbQS5M
	 GrTuvbh6XSQeQpavq6G+v9VPfUlvCZAJHq7lXzontrCcktXg1OpP626KoRY+yG6/IdoH1
	 pb2H0XGUMf7Ljj5PYbxkTS2o2XR4vtb/irAvYN2vZv8yl8lbyWwShupj096eeX3z/TcJ1
	 PyY9Nl+SUyz81XklCpMAU0j0Aqq79GerwSMnhR89Ez5w9/SSkE4xknSilmVetveLmRA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B1CFA1F000C4;
	Wed, 18 Nov 2026 23:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043836;
	bh=LEAjNOwH4Kcy8RVVcIOdEYwr0+gz4oIBgqohPtwFWa8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=e9IChAkOb/Eb3PI6ajoH4aCuorXjjSAESo1/GxS6UI+3H1xL3N6e6Dhb4hMTqoikW
	 9XpTgPsVNnoo/FsLUD/JvqN3he4qe8aauAPVzwAl3ethSKxXCyMbulK5P+pZmAMLRC
	 c3/EWCKr5vLtfDWAyPQEAIDJNlTr3h559qz/cMYC+Jm6WaCDYZqJ9UBEDkHUFqN6xv
	 0MKkc5nF9EiB0LzxMH/XK2ZaDA5G+GvXVMGj8ibn10pWb/2JiIv2lrZ/THTRDyDPIe
	 COdY1UqwqmY6g1VJ2AkVVV3BXtX1HeYUMzp8KmRfT5EbjvoIDx2b6sJCm6J7vG/IC8
	 x2VDPQY4UEwVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 30F654B014;
	Wed, 18 Nov 2026 23:17:15 +0000 (UTC)
From: =?utf-8?q?Alexandru_Andrie=C8=99_via_B4_Relay?= <devnull+alex.andries.aa.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 00:16:50 +0100
Subject: [PATCH 1/3] power: supply: qcom_battmgr: set mAh unit for SM8350
 and SM8550
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
Message-Id: <20261119-upstream-qcom-battmgr-fixes-v1-v1-1-ca83700c08c1@gmail.com>
References: <20261119-upstream-qcom-battmgr-fixes-v1-v1-0-ca83700c08c1@gmail.com>
In-Reply-To: <20261119-upstream-qcom-battmgr-fixes-v1-v1-0-ca83700c08c1@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org, 
 =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795043834; l=1477;
 i=alex.andries.aa@gmail.com; s=20261118; h=from:subject:message-id;
 bh=57hCL/wfpzvCW6AYmx0LBjTyYxD1cG6DUfZHuao/KPI=;
 b=3rYahb7KNQtzhxSpXJCb5betOKRj2XiHodoeXFNeAMkJlH4PyOOnE589g+bvcd1Dtp3z25MwE
 Q+DDg/2arIpB8Q6btPmnlA8MlzCs2IDZ14RZIcQdGufHeFGfThyql6X
X-Developer-Key: i=alex.andries.aa@gmail.com; a=ed25519;
 pk=kNAqgavfB7uUd1mA8o8TszhGxzyqBwY71PGO/oK4v84=
X-Endpoint-Received: by B4 Relay for alex.andries.aa@gmail.com/20261118
 with auth_id=1564
X-Original-From: =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
Reply-To: alex.andries.aa@gmail.com
Content-Transfer-Encoding: 8bit

From: Alexandru Andrieș <alex.andries.aa@gmail.com>

battmgr->unit is only populated by BATTMGR_BAT_INFO on SC8280XP and
X1E80100, remaining QCOM_BATTMGR_UNIT_mWh (0) on SM8350 and SM8550 where
firmware reports BATT_CHG_FULL and BATT_CHG_FULL_DESIGN in uAh via
BATTMGR_BAT_PROPERTY_GET. Consequently, charge_full and
charge_full_design always return -ENODATA, preventing UPower from
computing battery energy and health.

Set battmgr->unit to QCOM_BATTMGR_UNIT_mAh when probing SM8350 and
SM8550.

Tested on a Xiaomi MIX 4 (SM8350): charge_full (4256000) and
charge_full_design (4360000) are now reported. SM8550 shares the same
property path and was not tested.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Andrieș <alex.andries.aa@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 58e238e6fb2a..c07e2db8f242 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1717,6 +1717,8 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
 					     "failed to register wireless charing power supply\n");
 	} else {
+		battmgr->unit = QCOM_BATTMGR_UNIT_mAh;
+
 		if (battmgr->variant == QCOM_BATTMGR_SM8550)
 			psy_desc = &sm8550_bat_psy_desc;
 		else

-- 
2.56.1


