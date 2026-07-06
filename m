Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4843C7B8
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341901; cv=none; b=e8HbnXQ52k2fLN80LHrcVpu7XF3uqywBI2QuklvMEgBDTWfIZYeU/VudJikZMATe1nrXuT+pUrUU8oycFK4bZbvY62oxWBjceaqjyiZKWifenc2LPXioKiyqkFtJBlvmx3cC8nN2S9vmsChY6Iq5f1iUPNSMIfdaAc6sE3VtXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341901; c=relaxed/simple;
	bh=aDGbbnz+wzV3twb5feb+QvbOP0I73Nzbv6atplL3wzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWSr9kIRTnxJBTmXUY8vgfv1JrlRvALIiuTsTnVUscrr9qyc3sFcJB8kpCJD3Md2wxjaifeosVoueGbiD7M69AhRMsQ8z9/8mR9rbOgSB6Eo2cFFmHjFErTIN2/Koq9n5RlmzCVPbAdw4rCM0IuvEr6z1peTeicurzagAQX60Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dx4jTolU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvYDjmJj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dx4jTolU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvYDjmJj"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxFnf387079
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 12:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=; b=dx4jTolUOG0UpNFm
	MhBn5F9xncEGRrD1T/WbYOIOs3i3znC4K9HgDJ61gDB6xdRp65m00l5wnZldKlsq
	UGKJyHYuRgj2rx1yWFj98+JVTvIWD8D1tW2a7NNrmZD+Omhoi2ZzFx+iTqY3BhlR
	bQmeEoKzIflfUDGPi2qT41yIeKOQOyGQ69C+JZVj7HLmBDYemJKOwPFP4nMySxMW
	pNU+tFMx9q2xdwoKZI//juImwOVohKqTD7WpP3Iz5UKAc32CYWiU4tF5Z6Zs3Ifh
	Us2AaUOVjlI4TsxDMCWcZKl7cPWFLrvNrmcTpAowAidmXbdRF8YY19EhLdn7H4iX
	z+F4rA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0mfk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 12:44:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92d1cae5939so296049185a.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341894; x=1783946694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=;
        b=kvYDjmJjaxgDJXkwx3qIUtuUa9aXBkG6JTXP+e7bKqXYe9hkbB5iM1cD3+pT7dm5p9
         hMC7AMc6w/aOs4n3vzMcccnOZElVSISAB28/FrmypPopDEmLZfkVBiWkFXfFS6vGjQ4p
         b7gPQ48UrXiySJrStfr7wLyuva4ggVpXLAvhKJLehbW/WNFGbHtHnYp55UArQrjdeFQX
         DMgDHR3ze8Hcq6aFq3aiXqr4IGOfCQlVZN5HGJjmGE14X/24ieU2nuTlYZcIpUiwhZZX
         mIk3D7t0BG3+g69xtKrGV6bwuR3zkdKrjIgcMybnJ9ePJJzDampu6VvaE0Kw+bWhOHo6
         791w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341894; x=1783946694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=;
        b=i4E0QVmG4WRQlfhIUOHMeKq4V2EUBFECn8/w0P0ghigbeNz/Hp+TdQu1pUX0bSk6M5
         TF6Vd1kcdrocTtUSvIe4Bp1mrfI7pcJ2C+yaKrVqNf6aCQzd7hcY3GrRGwSkTe0vFQT4
         fsrHf5+2SchrjzUcbyxEw08xfTvZdYwGJUSitjWckWNows/WR1MlKyXQXDRLeHT9Neg5
         CuO9G6lQSFZlDzQJbx348X8/gG2XdZ4NsO2FsMfeXW1C99X1MxtrbLbrqjN3JSSRgCNY
         Mne/0pV7RErcY+mbpdfeOZ/W4iYMXZJmpYKrU7rPW4tRdxysCg6phg/XvmYAINZ4kisA
         FqTw==
X-Forwarded-Encrypted: i=1; AHgh+RpvXBtQ01rzHA2fumrEwU6fR7oCGPDcvsrOXSo81xHfblXxa+Kkt789rS1dJIKSGp92LxsrKz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/piXuHU5lisBUCmUK5rNHRjrij/4v5ZUgpD0wjm7ra7CJIHdT
	72TzMQMbdbv9iY/DrA8rluzBaeL3vj1NLU+t2XF+71zqIL5fKJTBgov+B0qMn1aaciZMKp3SVBX
	6+L9MdU390/LwMhOi47xEw9XTyGgyTrhxHl8Itu9ypcVfcdNRrI5jlkgSBlU=
X-Gm-Gg: AfdE7cmud9eYzdVaeYdT7domp22MuKxFC9M9YvjMyqolVYd3fkBL9TvFz9LEDLS1YEQ
	1pB38RMkslL3NwavdTZ50DQSR9OrywZyWxtZVJtahDWEocFEtDTCXCsW54guI4XcK4he8FVLQI6
	LKfEqOl4nU/R/LhK6JPhXGKwmTD2vmBRhhsFYw19LOUGTdT1cFXtnYZvI7Efu1Nr1USHfgCFQEP
	cjQ7j+0ZIwMzuAEgY+6BN+2KhTPuahHjmwJJS3HPuVp0JKsYPggdFZtm+WMrXdC/XyzNjS2O7LW
	/SRt32EKcXjt1cMoR3og+RG54k9V51BDIQ1OcT11oD2VtdB8+JM2X6OYs1k3TWXuUFOmFBKEKxl
	g8T75SMXi9ivWJoJuxJ/NuGfb1SAFCHokx98ijocP
X-Received: by 2002:a05:620a:2b90:b0:92b:67e6:8ab5 with SMTP id af79cd13be357-92ebb5a355cmr48467885a.63.1783341893754;
        Mon, 06 Jul 2026 05:44:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2b90:b0:92b:67e6:8ab5 with SMTP id af79cd13be357-92ebb5a355cmr48456285a.63.1783341892757;
        Mon, 06 Jul 2026 05:44:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:44:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:13 +0200
Subject: [PATCH v3 01/20] powerpc/powermac: fix OF node refcount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-1-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aDGbbnz+wzV3twb5feb+QvbOP0I73Nzbv6atplL3wzc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MtHvr7AjECn8mAtK9ST5QYxQLH8uISzpy7v
 3pFnQl8r+GJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujLQAKCRAFnS7L/zaE
 ww39EACYQC5v8jyh4RLJSmX9+Q2699EIwQw+LmnX2JTHZ37xaKZXSio5WtzBHutNcZGaaogpFoW
 WKEriZZ/dcQFmhZ/Q14nI9ShukRdTjBSVb6URMZkC1nyYuTj0FK0Sz2ESh9uqDHtN1HEUUv43ap
 cFmOY2eE+QXR8J6C5ZBAhBLzsJ9Ho77iM0WbapO+IFoLyWbJF/U41qJeW3ZaDdaFuDjoJdCbnNX
 gMHxWiSQ2aBucXdIz6hl4TU2MG7RWtc9WdKn3gzGFtuJESiaQzDHNAWeBjPRgvXNbcClk4qW2Rs
 FeY8+K5ONOw43nUF4+Tafg7FLvTlNoIHcbDtV7PSYq3pCNj+Z+hruIi8sXud/6W9vYKvPexKYG9
 5kWYO1Gd0GLkI5D4vudHVM74Gzan4Z0qMnQqPsUY3w57ZVVptL+DJDoOPoFTu9yy3tngTcrLrPK
 ZYgBxuAbV9NLePon1E9TCA8u0rQNn5//N6zpmGXBMEBeOBAU5yqkaPPANddk1al+fGPFzWtNGyk
 OP8WpDK8KBzFhXFC+cIDyJWlPptoS7D9Tcv3k6AoN1yq3qRx8ZSAQ6elAkAJ7Oed1RGDyMUTECX
 3wb+Lar7gwItQ0ahNLdLu95tpxenqJRi+oF6ATIp1WJ3NzZhbRCqA4YKV7ztDBsgCxH6Dpk8aa8
 Y07Wc/MmeOsDD3Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX2Vn+5tBNOu/o
 9+y+MHxNfOZtLmyuWl1N3aCUNjL12AX34lf2Omc6UOWTGYI9eIDMVgIKefjtaWoH2BIeZ1esCTo
 bwl7l8Tmxo4E74NLJDAfMfunhtsq8mZ3qUCziJJwPhKxCNaP0XF1nxbXTjzFg5mtpOHAVoqGBT7
 xvTuOnDY/5t0MB83OIqc7erd/uD7fgG32xQQiLLb66Owy4v0iCjpefqOTUTUcawQvf5DlweX0Fv
 bI3wxKAo+U12H1qvoU1YwB73RhmEmE+wbOn2hfAR+mT/F4X1mVy3D1epgDl/D7AjVmyz6aHoYJp
 q2i7UuJZ9EAPw/xSbFXfoWgt+xahE7bEiTEm+gwQNrJcPsBAfnXbIc8l7bWuISJ3HUOgWY5kvN5
 pHdJTTCsG1QNu7oDt4OF5dAFY+a8vZCLSolCeUNHsVzgSylcSK/PITeWKGIGLbMHWz9LoanogR0
 4SsjxLdvDkufz89rw0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXxfkd6dj7I4Wr
 gds/EmN1+RkmFdvZMX/2o/rD/vGRNepJBUMhuyQgrIeZKSXc5q3DPG+qEwL4O/24UcuR9LQoViA
 lmgR6mWTJCK+RnNosw1h+JuoP7csV0Q=
X-Proofpoint-GUID: nUk9kh8-6GjrRLdlnPVoFFDYcKoPPKJ5
X-Proofpoint-ORIG-GUID: nUk9kh8-6GjrRLdlnPVoFFDYcKoPPKJ5
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4ba346 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index da72a30ab8657e6dc7e6f3437af612155783d8f9..973f58771d9636605ed5d3e91b45008543b584d3 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = bus->busnode;
+		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3

