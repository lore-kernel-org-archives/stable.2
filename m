Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFA5505C8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879497; cv=none; b=Yt4uyxfyOxboMSq09/PIZflad45cssMfinE3cjA0vwmDy+jMeaa4BazXjDHd+F65nJkmPclrVDnkiyv703a/54F5Tf8lYnvnvUur2cviv+a0PrIId09sEwmlBB7leyGh8Qm1OONv1oXMIPCXLmR0U8e2NrTn/JrEfVk1cpiPRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879497; c=relaxed/simple;
	bh=jjMtp5SqAas4zIIzp6l5IEc/YbwGv5zChtMnC787rmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T+CGXVDK6xlxB9Xj/0FEcOrQ40HpwSaR0txsZpbbI4ECB9IFkDHmfSTa0qH8BMBv6p2/U9vXv6G5z7hkA8rdAQvua8bLRYJbl89eBYOHwwEyoD4KobpsXPdC4kMjemg5zbZY53dtXYbAAl5tOBkugxbcNZI4jZ65tt5AgebnWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kTCIk8j3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YP4Sb+Ld; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kTCIk8j3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YP4Sb+Ld"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688EjJga3627573
	for <stable@vger.kernel.org>; Tue, 8 Sep 2026 14:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1B1oa6NldI29ome8JkAuhcCrVCMdRvD2y8volZucecU=; b=kTCIk8j3aHSmnyqY
	9b9gAQZQARWVR3bSRn/kfttx9qeVk826CqCyiJd6aRp1CZxK//jlGlUhPXPPIy2A
	aaiiqRq/66s/ABM+d/LJjRY5eyqbmvwns0JFx6u0RUhMxE45AFN06bhLhWzxo22M
	mVLWczys72gHIPS793OZ+o4ATDbtATe+mSW1aB5GcgP5QZ/QGXumCoLMAKcFau2F
	2kf/ks5UlsmIbBiISLBy33wz8b80JHwLe9FtVYGxTshU9RX2DuSqaapuTmFcn2hf
	PYKZLnfB54w6+Z3ljGEg+wx0pThcjPftNaGb7B+emkgfjsIl3ToB5sYGMZowR8BU
	oL66XA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcv7j7qt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 08 Sep 2026 14:57:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93903622880so923539085a.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788879479; x=1789484279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1B1oa6NldI29ome8JkAuhcCrVCMdRvD2y8volZucecU=;
        b=YP4Sb+LdFUXo6gzKB1Wg+l6/u13ncd0fSaakuFS/uM1DMDnpRpGaw/lU5zzrIJ5RlZ
         S46dePPNJCxgDDC7BIWCCN9M/gCbtD7P5tcgCw5XVGEXdMFyzR23JUiA3FaFG4ctUJ0w
         LBaFbogFfa+8gAheXCkLmnczs6M2A28ir/VlQ2gLpa3EeGteS2kM31YQGYQSRTQ4ofcc
         oEKLtLIClYCNHQM7okhZ2mOTczuWhY/SsxjQAmd3wk31NfIZSV/KZjAAg8wgXh8Ujgv1
         q18EZa9Z3RhLpzO7DMLTzzijY0HX4Lmp7G+Cx5XDh+h0F62ssus3RT39Pgve3aRJ12Bs
         enlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788879479; x=1789484279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1B1oa6NldI29ome8JkAuhcCrVCMdRvD2y8volZucecU=;
        b=GkRa8WmJPQDuLpcBnE6iIHaR6XAeanh+eoVTGmkVGY//8JePKWRVBWkNf43Vfm5jT+
         OZ9468ypQ1sRCqt4SZOECEeYvA7ZCBi98I9Z/LRloWNeSdTLO06aF9xdm/8nVbHNBCkI
         NNeAbyAvNblrMigYfOhKK7HSv5ungA4dXYj6OYLDMMdTJhcNKXfLDNP7YxEjtv4EoV6R
         3H/TM4p4Gsy8wMk39ujSCc/6/tNsYvK4DaAHCrazurBAiB9KHfuVTLQFqT9iPcxZAnNC
         kp9f5eFaHDZBRcOevJl3ej8xcIo9CNn4r4NPjTMd8YPJ0B6QVygkGs4dbfWMSxW+SviQ
         pLUA==
X-Forwarded-Encrypted: i=1; AKwUvBwilUaKdKS0QvKazEg0vd7S0YqgYTjb7OpxcyP9wbptklBdsgfNB1G/beVJg16bAKftrahqCgw=@vger.kernel.org
X-Gm-Message-State: AFuF++nCVTsBYe5D5S0OZHQKr5Wi6vLR7DFgSwFg+npO781RlVN33geV
	E8WZMaMn98bPfeRG4MnHeJXKXH4/sG65Nx/vgYL5HVGu++GHuUrerP5Yu1hdTr+xPRmA0aC+YFF
	EnFnIPKvz89mdknQwOWhK5vsas5iujc4ss9/jpulcsp2OJ5uxUoa/1ZVitR8=
X-Gm-Gg: AYBFou1wmuI5aY5x9gvCW19uvtgKcg2nrvgP+o7k8vTrdLo7XMclkBtDOuv2HjS5E9w
	Xuho0Pa1akWX+yGD9IhXtOQbO3069OnuaDyGkhYg06hfx3C5m9GT2gnkcePWWaMgR7RC96PPjeG
	4nymbxGqoveBniiTHOp6ND+3Ho5eSV6gzI4DHpvNbo6rXHrC9Yuj4AfFFBHDOJlUF5FVgYJbYKM
	zKgW+89Gp2sbU1jhRUMP47Gr5FMXN4WJhjbu0Ju0hWx7MQQYfQrsr2q9Y1X0p4vXnIcgXBvwS7o
	AR4BjbaA/Idh2JefDEjmvAF6vOuE+0m7vLN7lu+ZWLlFGbtOTeULk3dHhw57IteOP7hEFHvU+pH
	kU77DLxtaM/wdwf9HGIoJ2hr22Muc
X-Received: by 2002:a05:620a:1a20:b0:939:72cb:baee with SMTP id af79cd13be357-93972cbbc65mr2826565385a.37.1788879478635;
        Tue, 08 Sep 2026 07:57:58 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:939:72cb:baee with SMTP id af79cd13be357-93972cbbc65mr2826558885a.37.1788879478118;
        Tue, 08 Sep 2026 07:57:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:79a2:f118:df09:fe51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm25191276f8f.37.2026.09.08.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:57:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 16:57:20 +0200
Subject: [PATCH net-next v14 01/10] net: phy: aquantia: fix system
 interface type not updated in forced mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-qcom-sa8255p-emac-v14-1-ec212b747a7d@oss.qualcomm.com>
References: <20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com>
In-Reply-To: <20260908-qcom-sa8255p-emac-v14-0-ec212b747a7d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jjMtp5SqAas4zIIzp6l5IEc/YbwGv5zChtMnC787rmU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoCJmPqi3DXcwZqfQ9RcuBKffaeQOMu23z59wG
 LbX6KLmIzSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqAiZgAKCRAFnS7L/zaE
 w1eOD/920zuLA7hi4Qy2IBRHuh66/6fGvU4CJZXZ8ZD4vI93p4NDs9EDRQ2eK5JZND/M39YL/eh
 52J1KMNflNj2rwdO9wtNiwHM8YO6NzJZZlpUa7Ak0jx20M07KgXAKYNawKRHhswKAmt3gb8Sv0U
 7R2lyCi5bWTavJEKJLgNvmjrfEnQWTW86v2Qe12MS6XLkR0c7km8NpFwNMTRxMnxHTDgYNFwP2/
 lznNBSoSePeij/ML6f9oklu10rRg9FOzx+41xkEE2odLqbSjDCVGlgIOBX0oJQo+RXjakYifphY
 sGn+nbC+Y0cJXEFw+YPWaN4TO8N7EZjKgatj0E/AX5y5S0CGtri1J31C8NxIAlYMjV1buvk+m49
 qfUC1djmfabNtSorBXWHn6eIotETAu7110pwW1SXS8sJEZqYSaM+UHB6N+CEshJFHnSrEVXaT/2
 x3/y1w97VKXb0+Uev2Wg+1Y7ZmG8lYpdBpbSo4D/ZwbxN92vpw2leV1EfoEopMdH5pVNVUEWzby
 50E9cOb6Xut9TWCp47vnDqWbHrGxpYV+SIhgiE8LQjji3khnrOkZ8Ew8fUysP7pgCSfo9+8xS5d
 APT5j7JXhq/tpsKe9Ow2mrNTveRI7gaS19Aug2BWjajK9kK4xY3fNdUsZfMg4w1pP1+U86iGb2u
 Hwcchsr19M05kMA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6aa02277 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mooR1oPkU_hlknJbmfEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2MCBTYWx0ZWRfXxNYVAF4O2T63
 l885yfwvKtfv/KP0kZbT/Ob1TAR1JIsOV0LU1kwGl3zgDBlCvMCw3fBWjQBqObtUnFWOPqxZr0Y
 hHXyFcRWs34fOax4RwZlw+lH6Fy5dWo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2MCBTYWx0ZWRfX5NXfQpjam128
 eTECuKP0WvHj8j8rmxZuyFb3H5LOGHnymC8V/+JXCfyssTeBHv/7rHuSDYtKzoDYjWBuaiNWsh2
 DWRdiAqIMFrPKeTcZ1Ukd4gfgeyGzJB0Tsyq8XabNSNRh0Gz61EKqQQNCfkCUWgyllrAKlnrotU
 hPVp/ZMY/HTqUaDnBTx76qMWhK5n9fI85NP9GEA+YOQvhquOBfqCYv/oyjoDwIWu2SX9w4t0EpO
 LJf9Gy2STF/lRom0C3bIaswC3ZwxIz6g5FqEEispIZ2fi3FByu1UFTZVRC5ShBwlmT/UyKhtElQ
 svAkXYD6HT6+qHv4FOl66ycSHJ1+b2qkma+J3bFqMYf7vfjpyvO7h9W0SgFw1STXqxASljg5zRq
 1kfwqbiNj2YL+EmkibUeLFIVQ2Q5kqMyvI5aNE29StPZkJiLqvuBMKb7rfHjmzBBrCTVNzgpuGR
 n4rpfhTHG56ck8t692w==
X-Proofpoint-ORIG-GUID: b7Uj6npTjF3ttW923GP-U-ysZNEoe6TE
X-Proofpoint-GUID: b7Uj6npTjF3ttW923GP-U-ysZNEoe6TE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080160

aqr_gen1_read_status() decodes the MDIO_PHYXS_VEND_IF_STATUS register
to determine which SerDes interface the PHY is currently using on its
system side and stores the result in phydev->interface. phylink relies
on this value to configure the MAC.

The autoneg == AUTONEG_DISABLE check is not correct:
MDIO_PHYXS_VEND_IF_STATUS is set by the PHY firmware based on the
negotiated link speed, not based on whether autoneg was used to reach
it. When the link comes up at 1G in forced mode, the register correctly
reads SGMII, but the early return prevents phydev->interface from being
updated. It stays at whatever value it held before (typically 2500BASE-X
from the initial autoneg run), so phylink configures the MAC for the
wrong interface and the link cannot come up.

Remove the autoneg guard so that the system interface type is always
decoded when the link is up.

Cc: stable@vger.kernel.org
Fixes: 110a2432c520 ("net: phy: aquantia: add downshift support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc233879ae1fb2a97758b3df9600ce5..b720e4e9028cc20823297e8bbd239121aeafa09f 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -544,7 +544,7 @@ static int aqr_gen1_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
+	if (!phydev->link)
 		return 0;
 
 	/* The status register is not immediately correct on line side link up.

-- 
2.47.3

