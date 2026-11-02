Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620146;
	b=eB9UMOcEtvk+teX9pOhbrvfb4xErJWu7BdzPA8vCySAuCHbqpAG11l+FUSP32dp7R73y
	 3pn8Ql1xiNLDK4UWAuK34gTMAGT7dYcflbXDtoyfLWP+uOWc8ezE0+7r0J2EyFBDf5zrs
	 HexYHgxWW4o5KE6sSJD+ki69tKU0/95u/l1ZD0XbTPl5MkNXr149b9TakJUHf4gJLeiii
	 qERpZG7hWvVYXU3W9nt0D2ljJRzfY4LSXyVZo+SCR7/8fmHistDzfLP5ubBXL9xPs+4X0
	 cA+V6v/UMKaDyHmPFELpsXKa3xT/Ef/HwFm9KnIZAkyGZMn2F+39D7ymYEAL50Rn7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620146;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Oh19af8VgHztOuXDPlz5lWKaaYDLQ4xFxBnWETVNsOQ=;
	b=MkqBSeteIJq1/wdX666879jblYLxoFvJZvvN3PNhdYdL9qfw9Np9JI8+NYYBk0tFSLwp
	 iNaZUAp9KxkuKMzpljTiU/AvcXXcULd/snvI5wbHjFZCGZLbBHPXD4U+uwopASc9AIKTx
	 kRk3reAMe/lU7rLqCC7d6TB3jm55xt6AWrp+objSptfg/u2EG/zc5MXFgqReO4wz1b1Uo
	 fKcM1tB1/uU8+SQ40zpRdFKLw4JlMR4OhF2dn4hd2XDiqdONdtLotVPI7zFr2Fs2Akljd
	 Br8JqFV5oUmt7e8K+C0WNEdDfJXTZyePlBcpcDuhRXEdaYKyNF9Ou+te8ty/Ge1WRJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UIATvmLO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wzl8Kh2z;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0519606A32D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0519606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UIATvmLO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wzl8Kh2z
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A9Ui3403350
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 11:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oh19af8VgHztOuXDPlz5lWKaaYDLQ4xFxBnWETVNsOQ=; b=UIATvmLOWQpaXQVN
	oGiCbTvXKK5nFoQAnD/bxxWjxPEGIR7w875WteIQuZvgNtw/JOlZYYncbPsW2Cwb
	lGZHvoRzoK3qpEQ4Mv1OwSlZ1XnVQmWrPR73PIKJj+obSGw8TOGFcVT6JITmth4y
	4CWEy1X4f43m6WzQiJl5SIq9nd6C3Wvol1vpwMMDrj/YR4hv62wC1vegav/DTmn/
	m2LmkEO7EkS/W2LSS0G7n6wlHmoB9kr4f8u1skbtrLHszBfSpKXrTWfsz9dEtDPA
	T7XqraNVmTpc0hmPpoZnOJXztQLNXONYiUBA4Mw0yVm9oz/Uy81MXI/TdFi5cI6h
	BN65Cg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfe8x7v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:49:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb71b1443so606127985a.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793620144; x=1794224944; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oh19af8VgHztOuXDPlz5lWKaaYDLQ4xFxBnWETVNsOQ=;
        b=Wzl8Kh2zfhAXpthsWdJ21rDDhz/L+jL0r6sEnr93shwUEr9Dhoavpi73d2ERli/t6R
         0VKhez+7AIYXTuYlwCduN2U7B1sRKBuv6JH56kvIl8Stu4dLg/3mCue8My6ukNEhr9BC
         S6hHj7YEna8aLLEDYAa32YbM9Z15245YZw8QSYGoaZjX4XnaYQGnDVw+13EYi3vE1ccd
         AwBd8CE6IkRnQGzkQk0LykJNhrlqmxbzyhTsBA4z58qgZxkVuJQMBgCFehRL/SumhLQ0
         qi374NJSF8I0lAySY6xh/2+m/umLgnW+x47KwwZ4WPR5kOHMIKtTygd83Rrt6ldrcB88
         NvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793620144; x=1794224944;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oh19af8VgHztOuXDPlz5lWKaaYDLQ4xFxBnWETVNsOQ=;
        b=yl2jt7ZQMdzRf56yz2De3QPJewBdYSLdS9k4+RcikGshPMJII6PgqLOhyICrhXujqh
         epsUnCrhZ6ZVPFKcAGLjz00Sv6mgLlwubYExgB0TNOL0bvN2ZlUNIWabNJSmQIR3t5TL
         hfOOiPfpRzKtlquTNbuEaWJjmoRM0TJ6zC/7OaDbaHyRQqfEGsejztQcNL8lsmZlWoWz
         vcB47MpmskLVaUKqKRvf1Yw6cZ8nzmXt33kkQfnKzJ5lv0rAs4BnaDG8EbWguA3oZP08
         lJWhvJhBu2kRVQr5p2S7wAbsfI+f9XSyyA933N2vBF7uTaHKcmVZqV7dxWp7dHbaGVXM
         1teA==
X-Forwarded-Encrypted: i=1; AKwUvByc+LtVVUArC7p1Y0OtABGCBqecDSzxlbxzfgpTeW5mckcoszGAho2an6Be+s8aJIVq7TGyhps=@vger.kernel.org
X-Gm-Message-State: AFq9FYLG1IPfcvJQKjUshDTiUMNKe2AyC227LxxrJ54YP9xGegjVZTNc
	PH4kvgWCDkg+3lJ8hWwpMeCn2akv38/qwbvLIN7zDpt9MSgTEXfwd/KrzCRopCpQ31pfRtBBo2w
	1I2B9ZecLEAE0WvhIs6RpbZh53z28mVlJoDmFHrpYkIHOXKEoiYJT64kMurw=
X-Gm-Gg: AYBFou1p4TXZnsD/WDPj8amSFvDfNqPaHnWQCf8FtyfFqKOAxPwqIMEcD//3ocFhz5L
	SXDlwCWYxjsXjEMyoeKOOcVWjcRb9p4y+ZUxAXYyN0XJaVGiL0OiToeuvS0pDLrY/CPywu81aFZ
	FdFF7j+xwNd6+4mms4QGv001jS7WI/3ZKbiTvfraWQ9BZ3ccdq8yysqUFr2LanNzREodjmOPLDs
	YUdAN1oijZlIsXuohjdibjlMy9wlC9WD53DT/+OBPQT9tbF8P8GGPeF4b+ET0NJa8tPAYLewrqy
	RgMYc9z59+Q1z23nRQ2hViFraXosBpS9UXMWNMsfwEzvyoH7p/CcCt4EOhqi+alkhcyEzjsUaQj
	oBGeByCF+QXQNjuvH5lNBP0oxbEfPVn9h53vI9aESywUbqCG+P2G1JLSNyw==
X-Received: by 2002:a05:620a:4448:b0:93c:8544:6adb with SMTP id af79cd13be357-944217452fbmr1624819985a.22.1793620143829;
        Mon, 02 Nov 2026 03:49:03 -0800 (PST)
X-Received: by 2002:a05:620a:4448:b0:93c:8544:6adb with SMTP id af79cd13be357-944217452fbmr1624815485a.22.1793620143115;
        Mon, 02 Nov 2026 03:49:03 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b725b8sm19766031f8f.20.2026.11.02.03.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:49:02 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 13:48:49 +0200
Subject: [PATCH 1/3] clk: imx: imx8qxp-lpcg: Reject duplicate clock indices
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
Message-Id: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-1-1c3fc3fe727c@oss.qualcomm.com>
References: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-0-1c3fc3fe727c@oss.qualcomm.com>
In-Reply-To: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-0-1c3fc3fe727c@oss.qualcomm.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=RZEyaaRYv13ION5f4rFj0UmX8ETzVTuM6plCBDtwyOc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6HioIWI3xswy035/XchzkLlv/zm+EO8le5/XT
 q7Qq8mSYTWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCauh4qAAKCRAbX0TJAJUV
 VsgOD/928SW+qLHLOl65n0GZb9QrujQ7Zureyizl9t0OefVjcjP21mykAsMGIeEoSniHqjhS3dh
 9o8386WaJvvhd5U4wyUjSbUPpzcavUDc6slJx1/60PP/YryK/qVjGlcFleMuT6imAr+3sb6Rphw
 3SnbFJGW21xR3VXYtqQZ2BvRYfWLuMdJM2czD/JayDvIdZgAd8oW0oA5+6OL0Q+FLmUSWP/ZNq2
 yiiDwCdGdw5ci7oMkyYGevi4TMJMdnyI6nEFlHH5dV92XqMAdqO7KbiVhEMcbsBnDpOLJqk00KU
 xAkz8nXjgFIxauRSkC1X58XKqbRpl9MUp0BNLVqlL3PVU6yl/ehyQ7ptdPuBMHhWpbpfs1k5thP
 mO+dUTSE72BWuFEr0HW2/4lgDOEcVH+WU6+8g3YtLoqr4jsW88SBIXOxhZcIMdk6RBTsTYD81VL
 MyHijeMbiIZ64URrco3dciJk4VgOdzdgQLAZvvK+y2AHKxCeY/r97P4xdYMOXfvFj/up7SzEdLC
 YhtYHzUZIDSSezYOuK/ona9sODz/Fpj0+sX7TyfX4JbX0vFQ3e6hA2Mw+irtKf3H8g7zcToyhYw
 FR1YL9p3sHJDCAVx1oUFGzn8LceOnKcKpwD0hEKSB2eHAnBC9zAGHD2PqzQjCS+DxsWx21KMGmn
 aw7oXRdJ0mjQR3w==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae878b1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=eKaI5DNhNXE6fe47w8EA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfXzhFAv+psdEp1
 ZAsrmHDvgpwPZNu8tTsTCKIyvzlabdjeoeY/dKD+eKvp/XxMZN3dBBgrvNvipxFbZhvId5CukgK
 k3LEEtFuBYhWYCnI8rvIptbFqX8TQ7GqwHc6PdaRC52bzXZpNZ11tFErWbCEITfdJxFhRxl9PHO
 6qTrbI3Vey0Y/XB5XnIfbhbxKrVu666t6y3jlMD4crN6XevQ0fOv9Ufz+Y75zSTeah+fn2NG5Ui
 bMN/RdMO5HrrP2fNcM6xCDyEKMSMaxJ8QyydelrGCnKHpdEp53y3VuP1uOQv0hIvS2+7hu0TLKK
 HAUUI1DIWvK0x9JCB3DgmK8dtXGzoIhAgMc8GUd4ZL3HgIBTIG67Ay4J0yBlj0LXO2QueDe6vC5
 pKrCbgcntsVLYfzBuL6oh6gRb+qP0Or4JJ5XkS3Y74yHgbEiPXWSSh6KHU29e8zpI70hBLozlr9
 pb3GFpQ5ydxPVcA9J6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfXxTWvWCP7aO1J
 kjYI62KdkMsvg8em3NASoKMLwk7wC1BNgeQ6MNLNOtGKgcb1xhRyoNSeS3vbXcYfy7uxi8yM5se
 Efdnh4QmtYyJp2HBMMyUMHcIWKX5DEw=
X-Proofpoint-ORIG-GUID: 56wn4yWGi04sLJJQ2Zq1tw5BK98qh2qk
X-Proofpoint-GUID: 56wn4yWGi04sLJJQ2Zq1tw5BK98qh2qk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046

imx_lpcg_parse_clks_from_dt() stores each clock it registers in
clk_hws[bit_offset / 4], as every clock output of an LPCG owns a 4-bit
field. Nothing checks that the clock-indices property names each field
only once, though. If two entries fall into the same field, the second
registration overwrites the first one in clk_hws[], leaking it, and if
a later step fails, the error path computes the same index for both
entries and unregisters the second clock twice.

Reject a bit offset whose field already has a clock registered.

Fixes: d5f1e6a2bb61 ("clk: imx: imx8qxp-lpcg: add parsing clocks from device tree")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-07b8d98e-feb9-4c88-afb6-3b5e0b05dc00
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index f0cf6cf91899..e57e7bc074a9 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -251,6 +251,19 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_device *pdev,
 			goto unreg;
 		}
 
+		/*
+		 * Each clock output owns a 4-bit field, so two bit offsets in
+		 * the same field would describe the same clock. Registering it
+		 * twice would leak the first registration, and the error path
+		 * would then unregister the second one twice.
+		 */
+		if (clk_hws[idx]) {
+			dev_warn(&pdev->dev, "duplicate bit offset of clock %d\n",
+				 i);
+			ret = -EINVAL;
+			goto unreg;
+		}
+
 		clk_hws[idx] = imx_clk_lpcg_scu_dev(&pdev->dev, output_names[i],
 						    parent_names[i], 0, base,
 						    bit_offset[i], false);

-- 
2.54.0

