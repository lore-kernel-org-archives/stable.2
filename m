Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E246F4AB
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786047; cv=none; b=tdxpwl5d5kMhOSMTGQZEriud8aRagZ0gkFNq4Q+4dXCLjlFX0rGiKx1RA+3loVvBj3Jw6563Vof4GnpYRX90c7XdJawe2/wezOf8XsvSM03paEJP1Yz0XIsXEtQl0cVKKVyTHoFrq/ZmHUaonSo9psvra2FkzH/py9synE/31E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786047; c=relaxed/simple;
	bh=yyFXmjX5xn4LHf0Cfw4ccz4CCqq/j5rE2bpo1iUGClo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qch+Xrj0RQRG1EgGqiWQ+CTkd96baRwLC+TCbztKE/KJ+JvAw3QkqOROrNAew7wztxMvaPR3ctuOe1n9u/eAhh81Uo9iAq2rznKVOawyZZy/p0+SEmT/fhN5wIx0bAW/YjVWtx7oIBn2TmtDy7dA5w4Jii803yJoqOWWngtoY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MtLu5hYd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LAGy5AM3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MtLu5hYd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LAGy5AM3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687An9OP004092
	for <stable@vger.kernel.org>; Mon, 7 Sep 2026 13:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vnsP6hjeAwNYcPMBk8GfKispcvJsO1pbP/Kx9Lnz6c4=; b=MtLu5hYdHHBHD+Yc
	/wh4ApHi4GUAzU93qQZULgTnpk9hXgd1DZyqn0mqhJm+sQYmZKdSCAfJQklQBDKs
	Myuh+dH5Oz9LEipTM6rBykD+UsQtibUrvuPcdyguabknHBGifHG1ysEr/nezcvdT
	CgZ5lCIS4fPyi+g/fklNX8eOfLdl5DufSLk64ps4SG8hdg5MPbwM6VVZYsa56IXs
	KrhdGzaXMjJi1I3GV4vKhiJjWVUgGz07rKXdRbH9ttIPSfUNO7FPrK2OQOCXTGWv
	J2UVljv91S5iybpSz0IegQdwPEqqqrupQc6I4XPIg/L3GdeVfLi0PHehi2agOiDa
	dlJCFQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg139u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 07 Sep 2026 13:00:34 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97e99aaaa6fso174801241.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788786034; x=1789390834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnsP6hjeAwNYcPMBk8GfKispcvJsO1pbP/Kx9Lnz6c4=;
        b=LAGy5AM3Me+5p+s4sqtaWlXqxujgKeNmr9DyCOCyVicrxWYrkMi/1mVEZGwGdIUwSz
         yYSySHg+/eFLcvPJJfoCHqGXoxlIFgPH3VAdajy6TfcPgIa9OWvJFiP60FjCJj6LBgF7
         9VaP2VNSXCJo/czP3O7ExQyO/aokn43pniIa6S8bOZjaWJRGa3WzS7urGhZSRR/LoDGO
         q+zu7+Imjqbv1Fljf/lsqMYikVunyQn3AQfp+sUxqqDydLDTvij+GTxkt4j/RlgDI86s
         I18bGLn5E+iuHzzqY8kG3r0SXGEbz8mIw0pfrz/rwFDTt9YS2944r+5lG3yziKNCO1bo
         z2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786034; x=1789390834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnsP6hjeAwNYcPMBk8GfKispcvJsO1pbP/Kx9Lnz6c4=;
        b=AsW7xwHXivIOhixOuyurZX3TiBAH3CR6vhj0NMoQWD9H5orAc5oNLJRlpexGPE8lnH
         GUZa4FIf63lWEsK48OHstvl2pp2DBWT1HIBzONt20MfdgxMCzfXoUk7AKbrkQ7+g7PMM
         BTH332YTkvlLOxsYDUYHAgIZq/7on6zvNEGU0vYoGiupq3Cf9sesbvixH4AyrsGRUYw+
         4Cvq7NwHirtlkle2nyTmZTFUo8Y+jQXFIwu/udytd8PSYui23a7HHVef0Uj+8dUI73Al
         MWiAxs4oGaemjEvClyoMktdygSmuUouiI+m7HgoH56YyO6SX+SsWtTj8x5cWcNhppSo6
         22CQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOTqTEEtZLiWzprQx8HChIj2iAWb/YPuRdG404Bn1fn1Q/V/6/2RhcudbegaWq48oMpigdark=@vger.kernel.org
X-Gm-Message-State: AFuF++lYGbk/TDVT9wKJfkofW2UroieBKaCJLOBQ/RCfA2m54b6hEm/v
	k4qJsu1WY6lJTXX1TJfe3mYrY3WcUJa9MzF2bRo7M5g51+Gll51F6darW4sZEBw2wVrCLzfGYqN
	blVdzGsZMUBU548rZ/GI65Ohw+Cv9w6IiduwVID7+O19DenB0nON5SkdFcWE=
X-Gm-Gg: AYBFou0YzgdG+pWi/7wWvESGCKe4UVznCeLVFRnq7D+Xw3C5iCBTsR1WVlle86gj/R2
	qkkzBYgd+OL3ZE5axv79PqHJs6KnjjSsrpruSsEwxDoCO7JPekl9PZ8F6pHYKQCfNLMh4bsLDh8
	96ctw93znE7K6pp0g5vmfRLHipX9L1KGgIGc5RTygr0NUh/Fqr7NyXa/YuYh9Hx3zZ4scySrJCy
	AwjuGHMJY1JkPyU8TDvRYkhF1/rtyuZd2rvY3kFjCdkG9Ve++TQd7msjfg8+Mg0sgW2lzRWMtfy
	+CPjc7vC5PpRvvD/OPWXEwaWoExlmMMdPcVD8jY+o4wxVzgp8VqRdCsDUp/UhPjSx0yGu3huuiy
	BXGPYBP3hJxsdeOAEqt4pdCg=
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id ada2fe7eead31-78a4a483c93mr6602132137.0.1788786033580;
        Mon, 07 Sep 2026 06:00:33 -0700 (PDT)
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id ada2fe7eead31-78a4a483c93mr6602074137.0.1788786032993;
        Mon, 07 Sep 2026 06:00:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:00:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:15 +0200
Subject: [PATCH v2 1/7] drm/msm/hdmi_phy: Cleanup after
 msm_hdmi_phy_resource_enable() failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-1-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yyFXmjX5xn4LHf0Cfw4ccz4CCqq/j5rE2bpo1iUGClo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVklronCnP9I21nHkLe4UhlAuAhPrNlcB+Ld
 wfUHRDx96iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61ZAAKCRDBN2bmhouD
 1z8CEACWoKnaQY4soxW93YzD/YdKVaoCi4vf+eBJPUfeyh7K82OTTkysJ8cMtu/TQ+2HDBY/LNa
 DS1U3plaMTfKY1pTYWAEoE/3RS2mdncjoMDqXX6Qrcwwhv1KP6uOdn2ZO3qtrs8GxFiku4Lj4u5
 i3HY61pkGWkQLEQBhSGGcZbEALxnfchvx962Zz506VqDHTo7OxzS/DrG5icMcKFYgkPPLpUVbs9
 thZ8aRUKGXq+Kb0ER8sGiORDA6dcw3XL7MGcGwUDBDst/UNx1AEzeKfDaWTi6Vq02jFMSC2b9cz
 QD+Q81zprx3jlALkNZ60CGDWViwpZanrdZx8H2dUOUL6h2ymrSF9QFCoG7ycbro+ux+JE/Nn08Z
 tcbIofFFJauZcRazikXJBWdTfn6UOoFO4NMp3Swd+uQxscSvbfG45+WzCUSrAA2CyNNOJn/fXeF
 H44NRdjsqMnqUaPvX9tcmkO1A163kbbMK1yNfhp5NRk86ab1IXvH44dvGTMXbki4EAM8kzH2rpO
 tRjzW2p3M1TXIo3eUmjgY2BuYT0lRkUr/8j47MN7N0t8HBxXTPpX/YSxdYti8VUpBGLPw/gieOh
 D4VEdeMwkl5PCk2aJuo0baVABpwFFdemjhOtpVMJc5yoohP5nmP8rNIZxJoN7nXVTN0+WQcIBfe
 XpFkgulvgPJrpHQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfXy6zpkWo6cg1j
 QtC5iC/WygQ7mrXOqdIQXfRWTqmO9GtuFWkcSIDgoYbbAsLXZzXA2gy67j2MhVaKLd5AsfJMoRY
 ipN5TbYPZOeV1JZyAeiY77+VtBLYtHklhBWOPXw6EwMWFW4nnhA6/nwgQY6lajr6R+Lm1GMxSOh
 KLiw/5ULPd51ZML/0NIMcJLMfsI7EWuuHc+L2RRoCVSgXkUvleSNf7bPuRUwaW76oMyBbmBi/3W
 57w9urpfuka0K+miXISeEjFM5zqt0ow2k0kMob23TtNP2DHB0wWto5o5hTZIuCA8vTOJVLE9nm+
 DPwIjdPhvOHNVwquNUPS4NaNJwci0lBFr4gFDbz2dv8rUSH9newrKuh46KvK6TWzTzGmqngB72z
 suIZvLTewSBXqVcN8JtLZm09N0hViWJtzr+rkU3cMrhP6T5jXaJojEqYXX9BM+CHiBNowzq9yJ8
 dUl51c8aCvtZzh81rUg==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9eb572 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fGoX3SELrpdlimCKowgA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: B7CQbaYPZdop0kc-r9KoJc9skLrVGpFb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX8cXfH7q0es8R
 XG8gioLcR/4v6fpNyF0DvxctYFuheg/9xPiJhynv4TB1oUUO1hsrlw/TSIQBYSRk5U9bHKiBiYg
 VA0L+RAXZiUkJBMQ2FAali3qLiTvONo=
X-Proofpoint-GUID: B7CQbaYPZdop0kc-r9KoJc9skLrVGpFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070143

If msm_hdmi_phy_resource_enable() fails, e.g. when enabling regulators,
it should reverse the state of things already changed.
msm_hdmi_phy_resource_enable() is used also in probe path, thus such
failure, which could be simple deferred probe, would leave these
resources permanently enabled for the rest of the runtime.

Cc: <stable@vger.kernel.org>
Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index eb1088755cb3..fd675f537f2b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -67,16 +67,26 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to enable regulators: (%d)\n", ret);
-		return ret;
+		goto err_pm_put;
 	}
 
 	for (i = 0; i < cfg->num_clks; i++) {
 		ret = clk_prepare_enable(phy->clks[i]);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev, "failed to enable clock: %s (%d)\n",
 				cfg->clk_names[i], ret);
+			goto err_clk_unprepare;
+		}
 	}
 
+	return 0;
+
+err_clk_unprepare:
+	for (; i > 0; i--)
+		clk_disable_unprepare(phy->clks[i - 1]);
+err_pm_put:
+	pm_runtime_put_sync(dev);
+
 	return ret;
 }
 

-- 
2.53.0

