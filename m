Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA63BE146
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901979; cv=none; b=h+lwEyG78spx4Z/BpBrfXwJOtaPwqwdDrzuf9e49vMhkIGBcQmnKhZi+DNwqH5/6L4hyKymzulEBjVxtBR+DmSbAyX9fpzALyKHvS3tGpY7Oc4J/k10lbpA2eS+OxDz6df8bWZNDNxK70VCP7ZihljZs87kr0RFKHL8b5i0XJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901979; c=relaxed/simple;
	bh=TmAh72WunTRezRbuN4uX4RHDmNG5bPGK1ufM+tMyQa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff8a7awP9UglcbIvOiUQZQCadf4Hs+LO4D698rgToBZyHIcevZgmE+pqRtg18JH9YlKY3u0wvvldLxtek5+KxXSFqJvZiuPx3DYJgSDG7J3NJadU/zzBqsIyxTvip+c1xPW5O63Z8eucI6pzauhevnaGeqrYyvUnssl52djUCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cUPtyhO/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bSii004Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cUPtyhO/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bSii004Q"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S66caY1605864
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dAITjkSOrEOV7EuH9mGQKxaE
	r0g07tCJSfcjthjNWPI=; b=cUPtyhO/ze/fwQaNB/7EAkgHRah4JqjZbFZPIVl5
	mj/fRAFfyMzGGpttkF6BUO2sCn+y27U5BxveKnFm7YTKfEhHVQhuUI4wQbdM5NfM
	YNN3lmeArEofX89wAYgAw/ADMc1dw7JvfO/TWVPkFTgG3KsbjFBF9htsXuQFEELc
	wt1Qssf7KDfhAKqxVsxJE4/hVELzLahT2udBuy9zieqrpKvXwcdfzkZVGO382v1M
	gM9RkABB9DTPTTtHIFZKZXs7gyoTEtSLis0uy1/8PnCGad73EC1uPhzKmjsxczGl
	qBczwtkqBQg2Tg6QJFzF74LdFdZgW5vNI3f7tHHxWjXYsA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42r8fh3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:26:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so8567315ad.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787901975; x=1788506775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dAITjkSOrEOV7EuH9mGQKxaEr0g07tCJSfcjthjNWPI=;
        b=bSii004Q7TdC/XC9JIx4bfl4/9L7/CpdwxhLu8JSARbeHxGUPLgA4W4OS62nJl+M4b
         bt/s0U15ShsAghOkpiQOUt0M16Z2HmQEO85GzX/xhCA/G9waWwSog9tOOWeXrRBXKIxT
         ebanLXGchIL3oZkLUWXwPO87MAogPL4ad4XivLPYqRSZlvChDDJW7Y6UWZzrR6VCX3Fq
         9zNfvq2DfldrPRegvtNqQhMm79T1XrnyUQnVwL7cL+D4KTHs0XCv9Ifqk4VxiZlybJqF
         t6YuRa196iz3JTeDL2HT1zKR96V6SOxzC7S9UTzThEg7i/5fA0i2OVOh8FsWxmldXNiZ
         pN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787901975; x=1788506775;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dAITjkSOrEOV7EuH9mGQKxaEr0g07tCJSfcjthjNWPI=;
        b=XpzEXk3eAUOcQYvytv11vnT9ST34jj1nrZYYLIR3v6wKVwY+tGfbv3ZdqL28WZEta/
         YMKRnX+2jfdQb13ZF4qOHPWDX/fmBJlkxSiHJuSJr+q95ERKwuYPuRos/IPOlH0C3COI
         lQj4OOt/6ReWMbYTk9k5JbWyptF8YP/49ih4hZx3aa0lfC72yoKFLiGm7htS6zdP3gKq
         R7UG/ju3AxUmppv+7DXTcRK4AfLdow/dQgI+BFtdQHnbO48WDyLAnjXvvbyFS1DeNxkh
         r6/0iOJ29GN7k8V5Lr3058WGNREOiV/XC21U2JMUvDfOT0bHAgawW+gp1Bgm4cAg05dQ
         lZZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrkv9MK1rn73BKZWGY5Ci3gYSkD2G2u3sZ+GJsA5E3LeAW1xc2iZBV6mNKLT/oGFhPGD91PBQY=@vger.kernel.org
X-Gm-Message-State: AFuF++lyDI3+gCsN3G2Jpg4V5d3UwWjEkPUIZaGXEBPxGcBL6M4NZqAK
	E4TFgo1+284Gj5c5o5+h0J2Vl38moqDTY6cuS2glyG5esTxObo5INgTzRQLUE6+gKvqk3FQVcj6
	aV/Da7zo0PeH4xr/1OM/FS505W1rJBszDEz5ozOOtiUhROQZrOVPYYmwp8sDRtF0UwDTjLg==
X-Gm-Gg: AR+sD10jGEEA+kvOk/RnsZ8ViAhFEidmWsZnx6n8oi3AW9Xb9UcoT7BpnlM7HeKiR90
	ahYMUAU6p6D1eUQ000GN99HQenoRnzB5+7A0KcPlD5BocW/Y9/UDST9YlS6rRIkzyDgCZDWxUZX
	y87DPl+O7xM9upLU5gKB875CY4WBwUpjCF1VT4b7EwP4Sht2k29zTlFZNguZIDy6yD2AodY/zoa
	WeDWncTLNl8q6OBHPGiE4ShVchNYnoYAnbmwC4txwE03l/vEo9mJrJhF0Mkhs+cYJuyq2oGdZs3
	Ptnwm7fXv9Am30pF6IsE0kokiSPHRSHT1PqH+a7TML/SsMgmT+K+3jYXj/d87lbwvv1kCmM8GeK
	Xa0GPje8Wq8HBzec/9aW07yPLQ0YKIQXwLwqOEz0WAxs=
X-Received: by 2002:a17:903:3803:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2d74df0328amr106088295ad.12.1787901974650;
        Fri, 28 Aug 2026 00:26:14 -0700 (PDT)
X-Received: by 2002:a17:903:3803:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2d74df0328amr106087345ad.12.1787901974076;
        Fri, 28 Aug 2026 00:26:14 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f8095bcsm2951686eec.12.2026.08.28.00.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:26:13 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:26:08 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: nord: Split QUP1 SE2/SE3 into lane-pair
 functions
Message-ID: <apE4EKNN4KZ_QzY4@QCOM-aGQu4IUr3Y>
References: <20260819152356.904023-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819152356.904023-1-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-GUID: azdywWpwWJR9wLs6qxRHxf8EjtELG4Tv
X-Proofpoint-ORIG-GUID: azdywWpwWJR9wLs6qxRHxf8EjtELG4Tv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA2MiBTYWx0ZWRfX29XuHHU19t3W
 ZID3GgLvfPn5iToc0C5uIAplLZRfPD/PB5XbZiso2v2gWNk7ZecVqb5HiDSUJl9oClMT2/XHvN0
 AsHcnGtnPGghHGKjCvrbrwbEisp0Sba6s3hHof/G3GCKjxIR5/xI/7PvGHbdveDpOIgw3siLqcn
 eDqSCzDcGoU3dMz2mMNkk/ZRMCa1+5hVd4NjRgGDC72StBe/uxYQxAPmQIygLRbFFEVXKLpJVbI
 G28JYh7muWxrPkk4lvUr3XzV95iMA4FkZjXZDm7JoGwmoSDuLyJAlXeHOLhOfs85lRxLmxG0sDl
 v34U+tJqC3qCJtGQwiKjuDrfIQQkuGo0CRzLNpYshoxXgqA9l1ck5MbllmWkgo4uq1QMbq2Tbwd
 2DY+kSvlIk7TozO74ZCC1WWb9Vg6bYgRa7lK8bQSetuPWqWPg4EcIaFVD4Ht4uS4AyEBg4pb4wr
 VRHPmjjHqKeduj02qMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA2MiBTYWx0ZWRfX2SrmfMvkf9ao
 WwTEcFGmA9FcqfyAC/4PJQjkXJIS/SRxMl1+Lm9hDf4+51xdgMruLy4mQ7RW5eGb3bFDuPcHBRt
 Ais5pnoig0OutOz3HWYn0JA05ILhfMM=
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=6a913817 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2HO_7AbmPCLmE9qJQqQA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280062

On Wed, Aug 19, 2026 at 11:23:56PM +0800, Shawn Guo wrote:
> QUP1 SE2 and SE3 pack all four of their lanes pair-wise onto only two
> pins each: lanes 0/1 (I2C SDA/SCL) at mux value 2 and lanes 2/3 (UART
> TX/RX) at mux value 1, on gpio127/gpio128 and gpio129/gpio130
> respectively.
> 
> Both mux values were named "qup1_se2" (respectively "qup1_se3"), so the
> two distinct lane pairs became indistinguishable. msm_pinmux_set_mux()
> stops at the first entry matching the requested function, which means
> mux value 1 was always selected and the I2C lanes could never be muxed
> out. In practice i2c9 and i2c10 got the UART lanes and did not work,
> while uart9 and uart10 happened to be muxed correctly.
> 
> Give each lane pair its own function, following the _01/_23 naming
> already used for the same hardware arrangement by the shikra, eliza,
> hawi and maili TLMM drivers. Both functions still cover the full pin
> pair, so a single pinctrl state per protocol remains sufficient.
> 
> Drop gpio129/gpio130 from the SE2 group list, since those pins
> belong to SE3 and were never reachable through the SE2 function.
> 
> Also rename QUP1 SE2/SE3 functions in the binding doc accordingly.
> 
> While at it, add missing QUP3 SE0 functions qup3_se0_mira and
> qup3_se0_mirb to the binding doc.

Just spot that "gpio" is also missing from function enum list in
the binding. Will send v2.

Shawn

> 
> Fixes: c24dd0826f06 ("pinctrl: qcom: add the TLMM driver for the Nord platforms")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
