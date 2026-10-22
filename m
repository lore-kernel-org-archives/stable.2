Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659498;
	b=FTkrCvIeYZ6RPJC/qRoXEky1KELuQiS1NSH/iPrnk5X9sibWXEIyVkPz4aoLAnl90BaN
	 s9DJs8WP7LCDZOpZEcp2gA/uDzIY/jygRcur0Vq0Mm80+QhvXE5WKxfkl+2pgaEbZSGQ+
	 gnbWwXwwkoZFLUtUSouHn5P8sEhKnPl+iakv4N1LS4DLEDqeLGzWk0WTE0ctvpQ8FtQTk
	 Bga98yG+ZCUrOPqumt1vrQAhWLqOZ5ncrgnJL1cQczwJR3DbdDkLIEYTU0ZXEgxrnxZKF
	 klrn14/Owg+s41KCXXyVOtuK6l9eUtKXccRF09ApWKRf64Q+V40v7cQS/8zJWYpLbAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659498;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0PgmRG5zgD8CvnXk8EtW3AgReOwJIYBKgnTHlR8v6VU=;
	b=uq5MGD5O2BYk6TU9gj6ffNsqbGc6lMdoe0MmCy6bjNcJpecCen+qoFZEwRF/VoLBEV4N
	 GPVwOlN1UCiBuHHQ9bikwtv/khapB/X/Tn1QKjotTmgJ4bIPUrbxeIb8v0ERhTPIm4Gk3
	 bURjYqFmcHd7fXVhY3wgDty1GQF9j7W63UVHsHeOIOLtbyTM1FAHkzFMx1EfGH3p0IC+n
	 Pb1/+RTjDouGEbVCIKcZwHoW3oEnY6OHkWFYzhwpJMH/61VTbvfDIbb/Snxkrp0dmaHFB
	 3WcMXQcBlh/+ITzebJeSpIZIOBNlVnz+A0N4H21LRhx+06DKbExCns+USaPfjYcV6YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jsVE8zcI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HlR0A0fO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0D606A323
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC0D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jsVE8zcI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HlR0A0fO
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M706882172512
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0PgmRG5zgD8CvnXk8EtW3AgReOwJIYBKgnTHlR8v6VU=; b=jsVE8zcI+fke8xtP
	AGMzS/nLog4N9L8TppW315PZf4yVv3yfK4WpPVff2VUUv+Vn3V+oTHhtGCerGpoE
	f9YyFdt1vxxe+ouO/GHq1Q9/lHI0ZVr47JUtC+GTXNoreVL2x2wi5awuPAgEwSa6
	qXfDzZ1pG2/H+bi/AnZb031e76p/l2lXDjF+ZT6bhDOnNrevOOt005A2J80i95dQ
	cZ5dRiNYYvJD96Qc2xPgELqpQ0PMMZegD4x44ASG7WTlfBud7FpZBEPiFxU3nIYp
	LSrQc3HP4wOFa3tVYHE38p5z7bw8x7JcW8zhgQqoXbqrW3GD1e5nD/Q3QmhxbdrH
	Ng9HMQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahj52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:58:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2373e9b4so186285185a.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792659496; x=1793264296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PgmRG5zgD8CvnXk8EtW3AgReOwJIYBKgnTHlR8v6VU=;
        b=HlR0A0fOda//8wAag+5uEGvhf6faER9hInT3V73whhLVU1v0wOzQ3r9MuU1S91DBJJ
         PmkYCErku9Zk4qLU+rcj0QyQqm1dOt59VFrQDQ/n7PhUQ5+L2shHmOaBLFUllZmeCII/
         NC0OzC3fY48ggUB9IXOuBM+f4n6kCQ8ZrUV8P5QnXTGHFE9M/++04k0WyWWW0UCSL1S4
         lEc6qDQjITpSNeeltrLqkm3azpljp8VJidk+Oc7xOs0xNnTtO3kvbcEYqHpGuneVyhII
         6bEEC8OxzXKpL2SEkXMvGTsoLLI7gxx3AI3bm/xK8VuXLU44CvSTr65w6FTUV9vEqcHO
         9nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659496; x=1793264296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PgmRG5zgD8CvnXk8EtW3AgReOwJIYBKgnTHlR8v6VU=;
        b=HiiRFsUL8mic1Uhw/lw3S7fH2rcPqdS4ydby4Elrf7TIEOyneneWSdIAajEiH4Mns0
         EYt/2W/JMqI7kNNtulQOVnv8F8vPGvgRmHrxIeSjQ480JMslgEBv95zfttFKjDBi5cO6
         BmRt6POV88+BFrJJkUA6Qvkl6aamK0sbLg+ueLOW5EbK2ts6JLI8RlPuvzwFjTCQuaNp
         lJC7+hFUDE7cPSRlXTNbwkeu90qCkTun7NStOuuTOOslpy4kc6dwY1HowUi5KpSCOp5x
         Zh+hg3XXhtooMkO3Id36aNzWLZkYL/mvNhOz+zzmgdo9mqwuPkuNPQk9vAneeDBVCztI
         KB4w==
X-Forwarded-Encrypted: i=1; AKwUvBzMdYoaG6BZDlPkrqsc1hTrk37kNqkt4Y/qz5Ic0UkZtF5DRGAzl3UlW8Af4O5gqDyWDDZf4zQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJq005QujU1cT1Ovq1HeH9UWsplnN+wEKr3K5lecqmBRybayNR6
	zRTvFrvfE6yuEHD5ngjbU3E2z0yUvB9PfPv6Mpo4PQXLN6vEGS342uJ395LMG2MjviGr/varx4E
	9o6e4bjLwn5Iu35T4jqJxebi9MbLPi33BEAi2qeNCp2pH9xWlKaFQHUCUs/g=
X-Gm-Gg: AYBFou0vKp9ciw470pOaHb2nUyQuj7MPNtiumG2wKKKDkBeAbHi0WVXnMrvCzn3IHnC
	LS65nyagKbl9P3bC94chthip5q53FkiRN0hUNcVA1A6zMSLHQoFWuGjWlwr+mpD17p8mQdxAHTS
	47oUFQipyC6exjL6OEazyhSTmW+hpvJGapc8hMhcvLY/Gz4/YWI7sg0flyJ7mMtVq9LNEdhXc2h
	ibMDIL3ltG34xK4RKHvoDTqzIbPQDMmzhMR+zAzv8c7wt9Hz/4ivoZe61hznviBznpgIAyA5c6+
	VPenWu6EvGx1OLy4astFxHDdARSYyXSAUzanNuV3+wNu41Nh4SMKc0/1j0r1+Ql6+h87iHg5kRT
	aF1TZkDPuvJJmyBSXqpYczqvRFPoJ
X-Received: by 2002:a05:620a:6410:b0:93c:c2f4:9182 with SMTP id af79cd13be357-93f57f66009mr872004385a.20.1792659495974;
        Thu, 22 Oct 2026 01:58:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6410:b0:93c:c2f4:9182 with SMTP id af79cd13be357-93f57f66009mr872002585a.20.1792659495503;
        Thu, 22 Oct 2026 01:58:15 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b28f70sm61625525e9.4.2026.10.22.01.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:58:14 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:58:00 +0200
Subject: [PATCH v11 2/2] Revert "crypto: qce - Mark QCE as BROKEN"
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
Message-Id: <20261022-qce-fixes-broken-label-v11-2-0d33c34fd0c3@oss.qualcomm.com>
References: <20261022-qce-fixes-broken-label-v11-0-0d33c34fd0c3@oss.qualcomm.com>
In-Reply-To: <20261022-qce-fixes-broken-label-v11-0-0d33c34fd0c3@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Birk Skyum <birk.skyum@pm.me>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3620;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=lcYKx5PHTS9y7X7qBQ5d8cuijJO8c8zYjjKHfQc3vNA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2dAhmptlaoat7oiLg/6ol82V7USxsh+/lLc8Z
 X07B0BeF4uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatnQIQAKCRAFnS7L/zaE
 w9kLD/9Yfb48Ar8hhOmNvaf4Glb/uNcJDnptVhvU10P9yDGMc1ZNdIv0tuqhlVDUXbhcyZlDJkN
 UNGU57+96+7hSzAx2m5hVC8ZKKP1LmKjqBSlwVVaZ9vCLGrhmCc/eO1h1r/JV9eBYrzl/TiTXjj
 QagN9AACbUcgvn45Rsd009YLKGabZoSBQ0j4cGescYA3Mqv9w0RTCe/Drcg5uuTHxKp/KNparBq
 ABgeDfhBtPIHYK8Kv+vTVT6ISI19mg3/z/mePdltsf312LTOgAeeMaoKgNnP9R2AyZqHNzVi2n2
 QY7j6VxNIlZlSYFNi21ZyoIP/75OH+ahEyeOO13zWWjd8VCZ1upLEh7P2jrvj0/UD8DmAsBv1cH
 gE//7YZSE85FGRIwxmm6mXA2yDkyDD51PdXPBct/eaSvfhuzBKmhA6BGnUxEnaJU0mZ73roqZoO
 2CWlAhMfsExy7OyufmEqwv1cSUA49/0YRdZeVEPJHHnnjb0fgi5jyWRdgh/T/XIedokRJY5zF2A
 ga4/uix7hUdYVAR6LgDN1bSwFSINg6D13n7Ry718U+Zg+qAN136rw/B9z2n2HWnu9dmHoGoq2M9
 gboZc7CynC++IyLQ4VphDwJjItxmPAMhnsJ/5DXcAQ5X5V9qii/Mw496+xWlG02dHVz6po+47bR
 G1rxtcHnt3afpQg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: CvK6KNhXAVnG0GoXa4p8plCEOmmoTaMA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNSBTYWx0ZWRfX4IY+2LJ0ZjvB
 VjCH6uE7eRbFx13LXyEY/02wmyESeOvUlusOd8evgeo1IiBJelU4oKzaAHGwfG4RraOZ3i9FdL5
 CXkpHLiTcrFGpnlKHSgAOAnz+Bn/nyc=
X-Proofpoint-ORIG-GUID: CvK6KNhXAVnG0GoXa4p8plCEOmmoTaMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNSBTYWx0ZWRfX1/alkVsoPMyV
 SnSx14qlrjtlW8VEC0FUsfAC0XPRH6jwFjzjSbDibHRtOm2ZZU4gqQil4Y23dInfUMWGyNONAUh
 PHjal/P0OsaebGL264Bn+e+gsrpdrw6DQN5pRqMqZlQxB3wbJ1MgyzELWAf3U7/w9Hi3WjeXHaQ
 VbBWg2yVse4DG3bLeqUK9e7imIEmHshAu2LVFA1+Hb9Mq+0bfgEH+4tq4KcPFNFp+FPNKYGMR3x
 bBjgEiUc5gpfa12x+WiBdkZXzwwM8OiiGyugK7HxyEo/x+jyAcNPvhMmpZwGE7qsZlulbjAwObK
 OeZIr3IE+xL03mP6XqtsBOCpgHtDX10mfDRq86DX9tcRgZNOBQny3/OmVCNmC70pX3HKk+Jwd+y
 wP3/sKhxD8KvW5rgvW3AYdQYWAYvZ2nZu61qx6gOwEcjACDTDOHdFRhBDx96YCnKdUuW1XWepaj
 q/wY7Tl9WaLfplCgyMA==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ad9d029 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=W_IakApU47TVE70GsD8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220035

The self-tests for this driver have been fixed. The crypto algorithms
are only registered if the user explicitly requests it with the provided
module parameter defaulting to false. There's no reason to further keep
it unbuildable with the BROKEN label so revert commit df373d39c6f0
("crypto: qce - Mark QCE as BROKEN").

While at it: update the Kconfig description by saying this is an
"offloader" and not an "accelerator".

Cc: stable@vger.kernel.org
Fixes: df373d39c6f0 ("crypto: qce - Mark QCE as BROKEN")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Tested-by: Birk Skyum <birk.skyum@pm.me> # X1E80100, Lenovo Yoga Slim 7x
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/configs/multi_v7_defconfig |  1 +
 arch/arm64/configs/defconfig        |  1 +
 drivers/crypto/Kconfig              | 22 +++++++++++++---------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f9b8dbf9318c9d4947e56ef0159311634bf0c1ee..2d6292f8cab39596b540084fbd8b30f4c25cd4ff 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1323,6 +1323,7 @@ CONFIG_CRYPTO_DEV_ATMEL_AES=m
 CONFIG_CRYPTO_DEV_ATMEL_TDES=m
 CONFIG_CRYPTO_DEV_ATMEL_SHA=m
 CONFIG_CRYPTO_DEV_MARVELL_CESA=m
+CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_ROCKCHIP=m
 CONFIG_CRYPTO_DEV_STM32_HASH=m
 CONFIG_CRYPTO_DEV_STM32_CRYP=m
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6ec8d3a69c98e0da38465010d11166bb0e058f4a..e80927f87ff26fe3f51db6409f509fb99ad614a0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1949,6 +1949,7 @@ CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
 CONFIG_CRYPTO_DEV_SUN8I_CE=m
 CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
+CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_TEGRA=m
 CONFIG_CRYPTO_DEV_ZYNQMP_AES=m
 CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=m
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0189dfdcbbe11098ead0ea194293422a31d8fe65..adcbe15851899917fb3039efe89a77c8fe712bf1 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -527,17 +527,21 @@ source "drivers/crypto/marvell/Kconfig"
 source "drivers/crypto/intel/Kconfig"
 
 config CRYPTO_DEV_QCE
-	tristate "Qualcomm crypto engine accelerator"
-	depends on (BROKEN && ARCH_QCOM) || COMPILE_TEST
+	tristate "Qualcomm crypto engine offloader"
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  This driver supports Qualcomm crypto engine accelerator
-	  hardware. To compile this driver as a module, choose M here. The
-	  module will be called qcrypto.
-
-	  This driver does not have exclusive access to the
-	  hardware, causing races with the secure world.  It
-	  is also slower than the CPU.
+	  This driver supports Qualcomm crypto engine offloader hardware. To
+	  compile this driver as a module, choose M here. The module will be
+	  called qcrypto.
+
+	  NOTE: With qcrypto.do_register_algos module parameter set to true,
+	  this driver does not have exclusive access to the hardware, and may
+	  cause races with the secure world. It is also *slower* than the
+	  CPU for the same algorithms. By default it will not register crypto
+	  algorithms and only scale down the interconnect bandwidth and disable
+	  the relevant clocks. Use qcrypto.do_register_algos=1 at your own
+	  risk!
 
 config CRYPTO_DEV_QCE_SKCIPHER
 	bool

-- 
2.47.3

