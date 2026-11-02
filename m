Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620144;
	b=Y+/I2WzqGCwMlzI6dr4hIX6nhCtCwT6kXmAaBFMxdygJc/hcnP0NB1uw7w6B/8HozYU5
	 82qCkh5CgfgEF1Dz+cN6RAOMymEf1u7+9qFb5mhYUBCTbLkrvm1m0su8BjX/ClmRnoNz2
	 fHOrSO7hyD+v5M+gJFi189pcONbvCeRdSQ4f2fUuI8vbNZCBFArVMGNYVW8TmDg+uxYis
	 O6ul+B7GBbkkPOEhrVKqmtJnCjA/HdMYEPXX42UYlA1ZULwz4GgPh2AIiAqnt1UdN9SQ7
	 k3VUypQfUcnaR7M6cifhCtNjx2nUmKTce5108zweLKpmZU4aXqBIaMujmfHvXe7gIfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620144;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4mhjs5YiwohXXKlFzT3X2wnGvKV4qOEdncy1Sbc0n2k=;
	b=HC6AiOBWLc8kuaGRM0qNRFnglVGfHsZAqpI+qkp0JZH6iCsLJtycH9zdAaGGKS3dN5XT
	 FQNnVD5P2a46MuI0LsOyJJHMHihTWM2fMy+KM8bdh6AdtTuMUzDAfWk15SsYzucHN031s
	 oad3PWReg96X6gaFcyMJh5IUTrmSiptUr95gXO3eUF6mkxcIen6ux8GaKnHeATyje3b4R
	 igoYQ+5w2Z79u0gay/cfCinLnXKjbPj630oKc2xLywreoPevNEfHBoMOWAsVmqsPk5OlW
	 0UpGUm9ObEa1hmQVdu26MDZT0//XQU9jeZK5Dfw+jbDVsKJkX3rya13RyDF8Rxht6jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="RtCLC0/X";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Z3AkL8/z";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA706606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA706606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RtCLC0/X;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z3AkL8/z
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A3Bl260569
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 11:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4mhjs5YiwohXXKlFzT3X2w
	nGvKV4qOEdncy1Sbc0n2k=; b=RtCLC0/XXANm8zGgprXI3f3T37+VgrKFe5r46H
	2ljNLkoK2gazwDz7NG4AxsRSq0qth/tadAd4VDsMojwF2pGSEUNKi9wNX3hhGRlO
	yCNISqG4tjDTkry06+9GHllYka1MBnhc2Z/Kg2sXl330PxZx0QCmUB0f0SBNKIkl
	dFqhKQrm3GqGFBcrJMheFJx6PskKYLsq0gCymF6MS/+/Yc2qpsPErNsWmaVfvbMS
	yKX6Ur3QsNaNjAdqW9jrufv1R55hkFZBEjzALI5VDh9QYFShvR7lOLvNoXcFRyVK
	PXchsimmg9hLnqm2ZHsBtfmty7dCie4HQ14+KZ63xjIJk/Kg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvrkgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:49:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so589661085a.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793620142; x=1794224942; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4mhjs5YiwohXXKlFzT3X2wnGvKV4qOEdncy1Sbc0n2k=;
        b=Z3AkL8/zzrUU8kYkrZYylUCn/QgmTsbJtl9Aq6Fgujcd/k6TzRX3xhPZpbvkn15iGy
         sYl5/D6WsNYrqYL71KLHjVhUL4NHGJ3AcdEuxos1bjcd5vihFev9TjmzwG8oZWJqfwU9
         uP156tnvh9j0HiYhwHzffFTQ1VzHFIm6aTIt//LKWxRydy9LS0NaFVJEpTUlnqd8620+
         hQh94n35X9ERPZIwQpZeJiAaKfMkVJe8wl5lNjymQX+mriDoQEod6QeL+VWtt2ZoUHQX
         juTk1hgbo3aQGjL2MSm9OWcP8EaSt4L3hSa/a8gYIIu2GPnoUexw0p6Fz9HPkfIh6u6B
         0NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793620142; x=1794224942;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4mhjs5YiwohXXKlFzT3X2wnGvKV4qOEdncy1Sbc0n2k=;
        b=ah9v0L6ngVcVPYNdUvk2UtJH9yvAZjZS48nzhWRIyrU5Hdk0VN1KR3cEYvBZNyTaT1
         Kr402zH6DjDbJ2yK9l0y/EPJvYj3UqklgrX2HX536iCeblGNrxJpkF0o5PzsuMz6bGZe
         qgZNpE7ctUow2/4F7N9Ee5vk9RT4LmnOqjwHd4FGMfXEB36ZGD/EVRG3yPc9+n/pKmve
         mIE/NJmR1Iit1weL9JDpqAPjhPLsCX/G3PfYYiFRfwbZamrbZxaW3wCAQUFBPusdlcOJ
         FdIS4xDzto+pyH7Ao0eWWx2pXLNSCIb/MZVp9SUdqoLVQDPP7kjqRZm6Jk7DSz8vpeV4
         7wyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvWPtkH5BRjGS6EwF+EQuvN9yBdIDR1Vnq74/6et4ONfYhvGlJc5li0Q14UylWuD/w8WE4zSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiL54b/Hlra3RpeunTb917/6+tUN8PFbGYC9hpYJCF16/9DfQo
	rOWy8soX1QwpigdX/JOJ5gSeqkR4hQiEgUCrrLwR+9IMG0tMlXP8pIaU9YmNqvo5yTyI8YVaq8P
	agl1FGADeyE4RrvKoC0IbURUYZU/MwuiDAu7eUf6vPJLtYEPJny4aptiE5u0=
X-Gm-Gg: AYBFou0SUoMMRkbFiXwCgsd76Vo+5FNt9O0Rfz3sMImo0XPj5nNG/EtYBaCFfGr2z/t
	QygNLv1gBYac7ye73bkzn+FkywcQ7HpN2Xzs/Q87HyavNOB0VS5bF829NbyoY3rIL0Qlx0jPZAg
	a/13GgTp9ZGjIEgI9SyTjnumJxhIv1n4LcvBXa86fP9XQKEQHDmzQExT0UuCICfasgdyuPynVM8
	NKzBiL+urQPEFyy4OL8qja0ddLajwBClIAlN+nxdVY1s69FuP2X6XH4UtmNvA7eAKEYYtQkK7yv
	xpR1qKWf7CrnwHUHDKrYg9kNLC3VBdb2ApR9yMFetIwUPIzlzt7EuXPcr0E1/sw64lNsAKrZUyi
	Dg+H86DeOC9hhexlVzseYYjXf6AGsVzjMTYlYDJCKAGzSuU1FLEVAgru/bA==
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id af79cd13be357-944217bd696mr1528699085a.47.1793620141936;
        Mon, 02 Nov 2026 03:49:01 -0800 (PST)
X-Received: by 2002:a05:620a:f04:b0:93e:6f65:de63 with SMTP id af79cd13be357-944217bd696mr1528693785a.47.1793620141284;
        Mon, 02 Nov 2026 03:49:01 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b725b8sm19766031f8f.20.2026.11.02.03.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:49:00 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH 0/3] clk: imx: imx8qxp-lpcg: Fix the clock-indices parsing
Date: Mon, 02 Nov 2026 13:48:48 +0200
Message-Id: <20261102-imx8qxp-lpcg-duplicate-clock-indices-v1-0-1c3fc3fe727c@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAKB46GoC/yXNQQ7CIBBA0as0s3YSwKQhXsW4KMO0jiJFaBuSp
 ncXdfk2/+9QOAsXuHQ7ZN6kyBwb9KkDug9xYhTfDEaZXmtlUF7VvmvCkGhCv6YgNCyMFGZ6okQ
 vxAWtsaMbmM+9U9BSKfMo9be53v4uq3swLd82HMcHLhc/CYgAAAA=
X-Change-ID: 20261102-imx8qxp-lpcg-duplicate-clock-indices-828fbaee36b0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=/6v7L1X5u5rSAsDoUAMgtN8tzVeu21cN089Cbw+fzqA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6HinAXy6mtSVoB7DruBwJu7hXFE/BDIQ891NF
 u9vdP09TiaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCauh4pwAKCRAbX0TJAJUV
 Vl6OEADNhE7z40I+qslePVWHxtl/AdsZugFLn4PuEOrHRPvc+jIF58nAojAp6nEX+iPYc4HxcrD
 TS+2DK803oF/hvsPqM4EZiU3bQjccKgVC/q37aLailgAC5+/MqUjAa6hvi2hAuKKwr1HNGDJjdR
 BiBOjNEWR0ThVntnnyDAGIfPloFr2/GFXq7MHVcWLe2H6T882hRefFWdTCDuSo4D2qOMFRFMTBA
 wqVerxYDZeTrROZhsC1JgQ8FEkKoAQ0qzzyRx47Gyu1TN7k+Zj30ckCjT0G9gz0YcVzY1IdFyeu
 WeGlSxfatmjQmVqZuIn1hL3LZD3FgSfhlASpoF3RzDpM5ihGWyxK70ReQkVWwnjOFa2Jy+Ygc10
 +/6/k4I0XHsz1tiexy2vycLxkTQTrctIHVyKDTyB+pBofHmW6uGHyKBTmuXKwODdn9TilDFrOhU
 bQvcegjwXTgp7s0thfBj2skwqHBdrw8xLEOUhoYMf+8+5PYtOSZ1YBD5lceTyF/pjHMhHP5tCa5
 9INk8Z+n+4vTm3e/2OnVsJzG1BU3knO5Cn7Ejn49R3GWm2uZ/MOr4FljAbh1D0Im08bXcxN5UrY
 ZNOFF3Ak3PnXe+OlnJvcwzl89/GtpWH/OmSzwwtW3VsQD56FgwlmPscy+r8mjLoc6ob9076XF4J
 9u15AQqkp77QMZw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae878af cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=H-1XAVmeZCqmBwV_hRMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 6rxYd-tSVuW4ZTcWV3MG_eeXU9Mdhfu1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX4zdNIlc8lfS0
 AxR4dfGtxShWcacn3TloFARUe8bIyaIY4CbH6uqur3vAa27kOCgS5jFHDNoV0AsMWo0kw4Dm//D
 HPE7udNeo2AUiw6PwSpPA3OQQHtcMog=
X-Proofpoint-ORIG-GUID: 6rxYd-tSVuW4ZTcWV3MG_eeXU9Mdhfu1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX0GFjDj2hbg+U
 Je/vOc1abZ2yi2i74G+xkT62P+aR4qSKmR0QsR75NoIrfSb1TOp4MM63RDDI87qSJlF0lPJtoLM
 NnfYoJNDmOyeBdwzpwodldOac/bNfLmExRxEPJLndceAAtr4BipmzobIg0FTpXX+osnZaJBquDp
 G6QDu300AxvgY0ufy0Q2Yd272BJ5ifQDe0VZEdc/ceT+7OpzlssARr3FWmKUYm5HZ+V1Ih/e/w7
 pewAV8gj1ZmYAWGnDscuXxFi/oy36ApZhFbzi0Yini0KiEnC0O/5m1MNV/VoH1Q1IZVNU8pFpvT
 Hu/8JDqaXV65UK7NUb1fBMsKZsMC/TQmkExZ5CtuynsMzCajVzpX8oDviPrFGUAC0R4uZqPJfhS
 tWH1mFZFyQV1JoBI1R6tLG6syrw64KfcWzgkdvhUB53l9jEPPYeMaxPi8ZPrW9fgGrU/Nlq8K/Q
 CTftykvfnbHwuhSBuBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046

imx_lpcg_parse_clks_from_dt() trusts the clock-indices property of the
LPCG node. Duplicate entries leak a clock and make the error path
unregister another one twice, and more entries than an LPCG has clock
outputs overflow the on-stack arrays the property and the related
clock names are read into. The first two patches reject both. The last
one makes a failure to read the parent names return an error code
instead of the number of clocks.

Prepared with help from an LLM-based assistant.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Abel Vesa (3):
      clk: imx: imx8qxp-lpcg: Reject duplicate clock indices
      clk: imx: imx8qxp-lpcg: Fix stack overflow with too many clock indices
      clk: imx: imx8qxp-lpcg: Return an error if the parent names cannot be read

 drivers/clk/imx/clk-imx8qxp-lpcg.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-imx8qxp-lpcg-duplicate-clock-indices-828fbaee36b0

Best regards,
--  

Abel

