Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE6494827
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533514; cv=none; b=urhtmnE3hUMAZ/nqhhRA/113/fXYXVkBx1i9zjjjYsbny/hVwCRiu6xmT9TtqQVYU1+H3ClJ9Pgp+7x+W42UIt77OFIaSPs4urx0ZR9xt88/qXT/IO0zM4jJmkMvjEcgqiBpngIZUapFm/FbndY/2+z/6wX91RS3r4OIarFugug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533514; c=relaxed/simple;
	bh=6IXEn9io4jhhi35jnInkyOCmx79vnsl9EgePJUzHTRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM85AoWKBZGvQAe8GATk0fHjWOruJo3LuCg7wFmifEZjnMOD97/+xgtJtlzsJ/3ngSEckVBtD8spjm4pIkvDhlUdJyAkcPKpsVADcWnfT/pyc+bMzQhvBX3+7hQix4bcJTqJWqqFdNVnW2BVZcx2Ddx/ch1rtX+7juWY5tkhAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GCogJsH2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eANovxaN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GCogJsH2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eANovxaN"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HXp11089758
	for <stable@vger.kernel.org>; Fri, 9 Oct 2026 08:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pOMaeRRKUrXuh1tFBxR1Fs/IvAupGTrOWfaFKNrQMJk=; b=GCogJsH2WLEZ3gf7
	7h9wRYz3J0SDKdw9/2oVf/epv0mHnN0QR7gWAZ+4xiK32zHjBB3fDIsQaiGpzTlj
	hNtEIx2sqaL/5PDb6vUrHZk0hB3mGystxTxXF2lBh9SUHofWUVK583xEmx9ROktI
	LS0zq+0lrcQd9EfuOigI5AmO6v97yAlHPoWWqdpLJPd4oNa7yg3a9SfX4fu5lkG4
	yUkMLSBBtVWXfwkf1XFUkl4P7nhaTxrAhF4GAHHRyMpiDldrEkbHNNEmZ2DDGZ3q
	4yAfN9RK8i++0aGltT0/klmquKWbq1zk+Pq0QU8yt3ZEQK7xUYO5IXOiUSGraUnT
	xU3lVA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvawtw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Oct 2026 08:11:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb6391e89so1217087985a.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791533507; x=1792138307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pOMaeRRKUrXuh1tFBxR1Fs/IvAupGTrOWfaFKNrQMJk=;
        b=eANovxaNV8D40sAYmDyV7YlsAT31iB+jydxc8AHbL1OtkDKs9/guPqAilL1X0H6MhH
         SqEaTcIxf0YiCTFXuucKE6ClvB6f+YVAYyR3RSddkVL0VC6WO7SpTc0n1zhONLt4Cl7o
         7OwXSfH3/PqJPXoOfiUNDhpuaSqEFHthIuzJ8NQM7dd0h1tjdgcftjzZsxFxjv3+P1H2
         yg3f/Db5LM+GCN8kXM65qVfsVgEkzYCvLZpgbboVDIOdxfSGetqLiqvJe7U04K51/OCY
         IGb1wgJS3FozAyOLdHCzkY27gNJHGxVkKEClfE7fTed+G7pxErlN0BTQL77ERe6caQS0
         /24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791533507; x=1792138307;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOMaeRRKUrXuh1tFBxR1Fs/IvAupGTrOWfaFKNrQMJk=;
        b=kGUmMCRNrrYv82HfLAY3oGdcFCDxYd6HfHSOQsnPcocOX+FMYjZ4aDMkTSxLpbFsWF
         FTOZQZ4tcU2z7i9OynZ6iiH+gYalx5SrHWhzdsYZsKPvkTg6t+064WspUS7j4alFY5xd
         h0OiwFXAZHcsnHZYPhTJhQcfTr9/j3WDnP5t9l2pP5z3cr4Vf3lkzbT+NoGvApjA/44f
         F072+0NSDV8UJsMFaS6V9xwX1eMlrRwTZafdvWOnbbwIXkwfzHUDQ8tSLg9yjZNSk6kh
         eFHWd5HKaHUC17PSgsLvp7pwP3tfFVikuDk5mZLdiuWp6zW9wyjlqxPk/W20wlb8dEzW
         uKpA==
X-Forwarded-Encrypted: i=1; AKwUvBwzIOJY7sRlrBEnqh1CBkQOhlYouXL5lqwXzyaiS1bRwV3X7qWoJrBQsfM8nUhz19qAKX0FnVc=@vger.kernel.org
X-Gm-Message-State: AFuF++lMuXwKfo3dK53+PQynZYjcGch0QbZBz9xUQnNldsaz5erc0z13
	DuH/hlaqsaRL2gI5kRHD8r+yqJuSQ8bPPLi8MfsbvaMeBBH7uYtgpCRWAPwUeoFmlO4yRh8ef6A
	8VGce3u+icoCX+lFQrTPUsWfECcqq2LTNuI/u8/5hteN8yXLK/CvxWySPiYE=
X-Gm-Gg: AYBFou3zUf0t8KKvWxae+QicUJxKOsZDWkmP4mQrCCpkbjA83R0OwRaSrpEI6cMQOHt
	VVQPj6Eyv2C0BJakAHtzPWbfxjcpwr0ha4LurCZlgZyY5qAsCYHEL48HW8D+NjRdz3UBcUuBSyN
	2pShfjXRRsKldrX6kld/IwLTWnL4mMtE5tnxnpCYtmd542Au1dBe3ynYgdjJ7li6rKKxlqSRchV
	7/3GKlmBP3ejdL1TCIwBWf6B5Q5TcJJsfKmiBqryPwch1tR+bCqmwI7PJ8aWmkbPSjAZakaWPvO
	5bFHNmQi1y7psSkvVGo4m+X/D61BJIiA3xpSSoP6CAvnqJwHbl8L5Ws1XEYDTkevKpdnUbV4xn+
	kD3tqhhv14e7T6Vp5uf4eg6XuECo=
X-Received: by 2002:a05:620a:4115:b0:93e:6c02:d181 with SMTP id af79cd13be357-93ebd1e23aamr162091685a.14.1791533507114;
        Fri, 09 Oct 2026 01:11:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4115:b0:93e:6c02:d181 with SMTP id af79cd13be357-93ebd1e23aamr162088785a.14.1791533506490;
        Fri, 09 Oct 2026 01:11:46 -0700 (PDT)
Received: from hackbox.tail37bb1b.ts.net ([188.27.161.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm65404655e9.8.2026.10.09.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:11:45 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Frank.Li@nxp.com, Wentao Liang <vulab@iscas.ac.cn>
Cc: abelvesa@kernel.org, bmasney@redhat.com, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: imx: Fix clock reference leak in imx_obtain_fixed_clock_hw()
Date: Fri,  9 Oct 2026 11:11:35 +0300
Message-ID: <179153345648.1914323.15178647656208865959.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260915055631.1730231-1-vulab@iscas.ac.cn>
References: <20260915055631.1730231-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: l1f5rIdpqrK9aP8igQq-5faTWvdDpsoJ
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8a1c3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7W_6zTuqtRk8UThwdy0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX3esT5F4EtRvq
 rnOQON7em2PQFmpvkgwCoXVCMeojgebb5I/XRN4B8BXsDbhPWazyoHkME1j5U1JVLk41ZjtZDG7
 nX5lHb98hEUAVB/KNffqguC3Bs3zrhgBAoLWoA+8B2egNl3SOL8fbeR4P+v3KmeDqgZlXNCA5wG
 y0AIc7bK5RnLrlIwtU/yf+LkANkjSuUPBUQYtifgef+8fRLuLjfjERxln0oLNGdYxNeJj6N8Wzc
 3f29ciioUcFPb9Ke5FlTxrRj8FzZ/dUNj5BVzUMxq/Gow1qoHHg2k5eWYD++0AGtqixgIk8Bl/F
 vqu9fD3vX9mtw9SVVUQmx9Ys2n1/r+tS7q9N1W8kHZaGsJw/Kk4gPP3Oz9gyElwwl0NTBeefDcp
 LDqj7BF2jgOqL/gpFaZWkjF58JmY8LGBBe+yOvfRy+5knxVWaqZ9ZrE3bi7TFxxOmAYGI/cOnw2
 Dg76S0FflU5p2pgkFIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX3rW3BjlenLcy
 XQVjkmA7eKob0s3frnlbRIrqCgrzsxBK1qKvone99Wpikc1McX7mxl0A7lUhzkL+/DDBojr4/sI
 SGyT9BjFOmo9Hto7N3dsMFMNBj7NqnY=
X-Proofpoint-GUID: l1f5rIdpqrK9aP8igQq-5faTWvdDpsoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090032


On Tue, 15 Sep 2026 05:56:31 +0000, Wentao Liang wrote:
> imx_obtain_fixed_clock_hw() obtains the clock through
> imx_obtain_fixed_clock_from_dt(), which creates a consumer reference
> via of_clk_get_from_provider(). The reference is discarded right after
> __clk_get_hw() returns the hardware pointer, leaking it.
> 
> Keep the imx_clk_fixed() fallback unchanged and drop the DT-obtained
> consumer reference with clk_put() once the hardware pointer has been
> extracted.
> 
> [...]

Applied, thanks!

[1/1] clk: imx: Fix clock reference leak in imx_obtain_fixed_clock_hw()
      commit: 52d4d1b26a5bc64de95099d0a3dd8b90dba1f3a3

Best regards,
-- 
Abel Vesa <abel.vesa@oss.qualcomm.com>
