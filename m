Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704398;
	b=Zwb2yK3Sd2bRkEJsW393QeKSN/zw2h+Zzn4LW55GHyidfE7FnJMw5ZixZRiicOLsdpid
	 MaD0gPVTEhcpotsoRro1/RXjggHRmdGYDxiQjm37+18HO4L/O5p7+HvBTE7uyaU0jUQ1H
	 blf6aPngZCNHj1G7QtTy+lcDUMdXl4PDZFnNyKCG3Nxd/KEDkH6RnWoVhYNWpaRj7ynOy
	 5TiLoKcgs/JCkKGFJrlVTU3tAevv+stePuNSdoucSRe9R4IdkUfYIc9Plyf0lvXeR0D/D
	 calBkWlmAGteI6vnozXEUdAGliedD200CImjuCGNw9ksdnbtWDLzdstMtkHz0PRrE+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704398;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wFLdnzViVQExQFveC2QeccdnDcgniYhvPZabrU5FjTw=;
	b=ZnokNyJKBpZ+c67P9VRjI/YLQbuFW75AWLhMMkLKdOXci62XVGR6k9CF1qEXnGIyWXcK
	 TgtZdp+cogpNC2MgfIdh+fuPg48yPU0Ywhgp05GqhsciE0/oKGLTGwsPX0ogB1EDgMIZb
	 h3d33z9qzIjwX+Y3CGlGHpq7jCnFqLhPTgnS1uqjxFZKGZCVfToW5RltR1DsFagLRaJ3z
	 UPfSz2SQjc3IGrfEyWVj4CY76jOplIXAK9Xng2FD1Zd+O6n+rQXiR3dPwP57LjnsD3/fy
	 AXkMQe94whWwC1O/IjTUU9LjB59PvPrnVkDfZ+aeWxD96YTiv2VAmMx3UAz96zbsgZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J1c4C159;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AZ9nBuI8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D3606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 952D3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J1c4C159;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AZ9nBuI8
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQEVEFE3143476
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wFLdnzViVQExQFveC2QeccdnDcgniYhvPZabrU5FjTw=; b=J1c4C159zdogg8z7
	itHe1ocGpwoXxtZHGRjFWNIjM4YW/cpOUUQckuH8dpzWcJCmkTp6LcUlbpni27y+
	Xr0YIaIDRbzbFhlYhw0Yo0/oCJMJdCcHYZbAZTwSt9+DrgY7mZll3OO68ea/ZD9x
	c3iPoukVK4L8rah4qyQaA5TT/XM+fERmQ/8YSdAef9uQkpJtljflK/lcnX0Vq92k
	kk036Op8cj450bYrx9XfTNgitnnFmJtYoFiyWZ06msYsNuTQj1rcT5KCZjwKkgqf
	15uI1PpGSfhYKvqyHH8uBuoFaHhBueHQWNBAwu7879foAn/5CRRg47VlVVsJ5wmH
	FPG8og==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahvu8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:46:36 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b501e92b97so66468267b3.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795704396; x=1796309196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wFLdnzViVQExQFveC2QeccdnDcgniYhvPZabrU5FjTw=;
        b=AZ9nBuI8JDkxCrRiiWRj7e0Mact1tWbaV8VwqfYPF67E7Efd+4JRZm//DUKUjlfZCj
         lDJ2FmSKttL2LvP6hKQPrxUVm1XMtM23X2rk6feJqlYxVCfMTCb8Jxl9UUIp+8NAlSrO
         gT+E+8bkWS9ZLAaw1w+68Brsak2d3z36tydL9aNt2K799JE9HNazrHCSzVxVAt9cqA4V
         te9EKmQ+X1b0FOmjQNRlf+7d7PEEAVbdSIoVJvph6dp7pt3TmspYfQwAcjc3FbT4GO5h
         4LPDpWutfa1XSKjYKEFvxYep/1DcYtEsvXkrA7ijp3InEDgteyK8ydjZIHYLEZCEBXQX
         H54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704396; x=1796309196;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFLdnzViVQExQFveC2QeccdnDcgniYhvPZabrU5FjTw=;
        b=MXcChvVkhK/CJyVy24hDKOh7CnXNyHjgFgkqAF8h94Q0FvnfPmM6Xmqi7RZ+TfmSci
         ZKqeT+IbHlg/f8j7rsbkbm2KHihBGIGojHtf23UfNp5z1ZN0yMoN6vMjl76/6TEdp2Kt
         fPYQekUzhX61/YufLoo3isZCL0SuOKIGK93heUaLPyhuHES+w8z1JGBt8ou2rAk9K5Nb
         kxcaemIjAuXK9MpZpmydQEGA1Iegu+MPa7j5RVlygq6K4te62A1K5WC0SBohjk/Zhi0I
         EiZZcTWr3rKXihA6NhAO3sXJcC6U9e57MdXv+bu0Rei9PancV9PvFyP/NllYafzfvS8o
         cWdQ==
X-Forwarded-Encrypted: i=1; AL+hErGFKbhQKc5ggDQ0Naz+iBBhBEve+ba0l7zysKFPABO1EA4aJALSBC41iaIuHvnz0mU60N5qwB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5JyBpndJDW3c99DneJ8wTCeMTj1/nBCg87E01GQBmzTuvTlUV
	YttghprNvC49aQyzs/LY9H683498qZDCaaI3dAk8RQc0Sg7W9BbjM4HGVBdO7jyMSyInESVIEQ3
	PFZhHYzY+8FnH+LSAP4avf6rlvIgl45+NIw/8ZkjQ/tSivRlmqPh4/dTGTqA=
X-Gm-Gg: AZFdTZcH6tynq6AcQ/vB6u5Pfq2w/Wi0Evd1/mK+4Qs191fk7cRMiDZuvw8Awi/5PPC
	YX2xtIJksi5umG4/g5nYWx+pbJfhoyxzuds8z7C/x4xToAjFE+yCJGB6FRW8py2tAEH1PanqP3t
	nkCsUZGnIgyjMdBtJ2jsPcFF2m707++l5EDia+sRRa0fQGRh3x2K8p4qUx3ncG4ESLjh6Q/BGZO
	gAVX4j69Oc1agYn3jBrW7l7SXsbPXECjtXJVk8Tw26jBgg9NMty0v88c9iDvCKdgshUQwCnniM0
	BFjjWh55Smpkt5oAQvUJTTcRb+4UCqT3LzMQB+TNFC1/UM5Orgzo6K5Cpyii9ZCSHCD+5F0ot43
	0lNjjKKXtIyhbSSY1FBULtK+zWspvGuNQ2j0qsYczyorfA6LH/gfiZ5CnZiyPFrCxxIr8hXmFB+
	8rZ4f4xQNGwZekRLOVUi0U+YC3WKQwFFidKt6Lw//HrYRrZYS2SVpV4G+h52iW4g==
X-Received: by 2002:a05:690c:10:b0:8b4:c3e4:9c4f with SMTP id 00721157ae682-8b5204356c5mr76922217b3.30.1795704395691;
        Thu, 26 Nov 2026 06:46:35 -0800 (PST)
X-Received: by 2002:a05:690c:10:b0:8b4:c3e4:9c4f with SMTP id 00721157ae682-8b5204356c5mr76921927b3.30.1795704395086;
        Thu, 26 Nov 2026 06:46:35 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm33618249f8f.35.2026.11.26.06.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:46:34 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linux-gpio@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Alexandre Courbot <acourbot@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] gpio: mvebu: fix Armada XP per-CPU mask register save/restore
Date: Thu, 26 Nov 2026 15:46:32 +0100
Message-ID: <179570439030.25582.7595361557378134716.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126001323.583722-1-rosenp@gmail.com>
References: <20261126001323.583722-1-rosenp@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rFiLUtYtZN5XS9On9Fz-o0sSzAW4BZWy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfXxUxfo+DOQiYo
 gWex7NMCc5UdnC5mX0/yKOs5YSITGITyYXuxPJHuCkJ0yqW/I2J9CoscI7ilrzNVQqEy2ngN+QO
 pEbhoYuvSa/Q2XIkz1fGCjevIjfNqes=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NyBTYWx0ZWRfXwMl1n5K1eHB8
 PiKRVP8EZ4gq5P3EPP79q92PS3sQsVc4oxqGBsVB+EAY+OG3G916ww320i+8uFXgsoKO7KVCJOz
 7Hv/K9oDM/jniLycduaGcsPFa/AdZUZRB2PlJMC4cNOgBdTHSTuGdSSS8KJMnjm2nXZJkwPcz++
 cInnqwLlGO0Vf2GO97v+jFGYaGk1JBU9wtxbHjn3m37Wmo+/yA57QfwXLhMqs05eN7hwpBkZW4O
 RzatUtDqlpYqCgEUrST0+9Uu0cWlUkyu6aMcOARp3bTvEBFICqPHeNHKeA6rzsDCBFjt3zFQ5LM
 oSGMyheUkVrDepH2sxlsMUsO9E7dJrQYF1MUwNCy1WuVFotP79ny996V/5p5AU0x5uJvemKNgSU
 gmfXhIzaiDIMZDf6ydcqAO7s9/1F0+2RPpAKygDmVFmmn1SdVwPJkMvVbhlSC4fyvsqVeqMUIou
 q776BB8kIGtlIoNrMDQ==
X-Proofpoint-ORIG-GUID: rFiLUtYtZN5XS9On9Fz-o0sSzAW4BZWy
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b08464c cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=l9ZZRpswVw4obxJKafQA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260057


On Wed, 25 Nov 2026 16:13:23 -0800, Rosen Penev wrote:
> The Armada XP variant keeps the per-CPU edge/level mask registers in a
> second I/O window (percpu_regs) rather than in the main GPIO window.
> The suspend and resume paths however read and wrote them through
> mvchip->regs with the per-CPU offsets, which hits unrelated registers
> in the main window (including the global GPIO_EDGE_MASK /
> GPIO_LEVEL_MASK registers) instead. The per-CPU mask state was
> therefore never saved or restored, so interrupts the kernel had
> unmasked could stay masked after resume, while the main window was
> written with per-CPU mask values.
> 
> [...]

Applied, thanks!

[1/1] gpio: mvebu: fix Armada XP per-CPU mask register save/restore
      https://git.kernel.org/brgl/c/d8e27d04274746093f8d5a4e909efd9885262166

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
