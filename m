Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306575;
	b=IIqmU4SjOuePGaB+aU95t0SS+FacWzUYROG35ddpEOfw43Qf1n54uWLrRurmuV1dxrO1
	 oM9Ly1CKEeE/ne6UaLQywr/05SaWpI9PE6ggJNfxQCfX/Vpi+O4h3b935wzx9zIBknWp+
	 SVx4PoCgXkAF4jUdnIOtGpzfic2zsw9gOW86VD7TPrzfzczc+LaEgMthFfAvGAPNcusVk
	 DLJjzkCAicKzoTXKeqRCvNt812HLpvaOWTLQ5zfpefQInKXmOJsJaKfQ36m5FonOIUyrg
	 QB5SFvbsfM+3fwxNhUycvEXFCDhpgMQycCff7VRJvXalMGe221YDGMjs9fPYXmrwZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306575;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
	b=PY9VWeceyU0v0EoBnpHyZsu8mZT8pFCniFvvaGU7GCtVJv+4e/w3U6G+WhQC67SouWFd
	 6rXrZzInn841ataq9XCyvnbz2gV00l3TtD9QoIHo+L9N2jcorrzCWXbDxfiPdzT1eRrAj
	 3qjiVfq6KE8kBUA1+2CAhI2+D+Q8PLKY2mv58+cETDTSm6o6mDkQZ5Z6hJoxSnW1JXURo
	 kVuhXvFJmEPCrmMPhti4VwGHLYPb4indTreFkH6d+75Ja3HIJOLpABLHlBaE3/OJVyO/v
	 8xk/kItVKLvKDeZhBhuQ7sVSQbl5O9FLrnK4mbdrH7kWqeyG3HZ6jy6J7GnA0jqKTiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="bDueU7W/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+g24FZT;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92072606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92072606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bDueU7W/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+g24FZT
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l4q21155019
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=; b=bDueU7W/JI6jwGLN
	ZOUmqB+utVWSdOUpxhz9dOE3rK7LMcX0hOIEsmN0ZZZWhHKqmBxzZZ1CNU0ltor2
	vcu9GQTbEZJXv2h2tm74wzdPrljskM2MecQnyWLKeuL1EwCbhGGp4uUaoMcKfGl0
	sP5eUDR0NNLvJa/VcMgd1RZShikqgwMRIPVjlp/eVFjf84uCnBBvnsnRfcEZ8Zbf
	22rX++tHWmyxU6PShVpwBGow3UggUQycXO5/DZxE7XAJ4fkhwGyS3uEmsDDLIGHj
	wViyKL1KC7+D+ViUb2MMKaiuGSsVyH8/STmrt4Y8EHYR3eriLYQJOq94hZOmNxUD
	oAM5GA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv49p2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:29:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-943e8ff02d0so189645885a.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794306573; x=1794911373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
        b=Q+g24FZTmOYxIIE47+dlBYfIyC0J5BCPWmjo73l8rbJxOD+f9TRASBGPbq0Sy3YLxa
         dSVKMjaxmsF3+u94NHxhTA2ze2gbJaAgytsQfyMJYJKKobVJPP+hNt1jXw1zFxteqXOJ
         NWWgRPMO4EGXkPqkyQTTn/r4q/E+1qvEeecglRgGCQZWq3yhjfkJnnieYCdwBo2/JxoY
         FX5bezTlau+Y2qAEM/19Nw/wuTi1WkAfSIiPEwJegvOnVfdYJfXgphJiOFiOU6/xw7hI
         c1LIuP7EXx4VoDXg183hXpEnW6H8N2ce4eOk9LVRJCubz6FDjcPiljG3ibwUGwF0RbFo
         puRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794306573; x=1794911373;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
        b=RFYvE+xdIlUePybYUUXYwZL0t8F3EnSp0aclk0MxqwjaU7MNPBE2m77s088exCHe20
         2gMmpbbSV2DnTISlLLP1IpJMCkPRes70u+evmaMAFy7JW4UpRAN3mjQUouoI83GWnp8Q
         A5fvVrAw3rtyNFtOQc82wzePJ804OmYP4rlec0b5bcoZ+RsEZgOTz1MukcuwU0ORJSuE
         9OQDOOJFhlqGVIbIzACdvVTqM+PcQUjDvB5ZRNiz6+ZzkWzGlYdSjyZy87hq6KQR2s3b
         aI4XdG517wYfi6J5AkFD+Bzk/dErhsXuY8OxkfqpBXEUFiZQXLrjo0JJ22/OoyL9ly+S
         0etA==
X-Forwarded-Encrypted: i=1; AL+hErFMnFseTWWhDgCCbYRTEhNnFgSTceRBkv5az0ORq1c0BtLkD6YRGwyxktal00n6M+XzNXtqnlY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tPHS89bIVKrn39xheiKzEvh/Af3Cj2Cud47VMufA3bhyLrcEn
	eDCNaIm1SKjjRE6dJKe5eiKKLjYaRd/maGAn3mpcHCndmKJt4YPJcXIJqscQ6JpLu5MtxNI8PGZ
	xijRSfkGMK6wqfrdRVnNs8TD4J4KGLecDlc5rby6DxkX5VgK2HYBNCulc//4=
X-Gm-Gg: AYBFou1Tz7zZpJfoTwZa4ec9mtP6QpBDxehlfbSeqXPDULraRT1LTTTLNas/wAJGSVQ
	QGx+tHf5+FSiC8DnHUjLRr44IW5LdzwdZh0gZ4S25bTX9qRNdhu2NFRdtzJX1gK8T33/sWE5klv
	6snLhbuHxkafRWB7ZJ2BX7veCNvy9r6j5yBfLegqUSuGzJOKt4kylu9wSu+95mCsCcbG/3+2X5e
	XZzfrSdptobByJAJA9V8o3a6Z3kVbIN5YAXclpShPu/9KYhqFBjzAotxQVSYYJvAwj6BAyg0WFF
	bx32J+9W+VXtoI9vuvvuJ20meWfnwLSXyy5YIGI/dluB+tkNPALWQKb3uOH++B5CzzQ5VrnqSJx
	sQBX0PBWz7bJkfSECiXxcb+D3FZltEaFrwFyCMw7CFcDKm2wRYLPr6WAh+mBJHH11dLk8z+k/hD
	yw4MWMILF1ZIig8quDe3G56G10v+i4jE5iXDsKqUB5k/6nCVja2bc2GZ/ZmQ0NDQ==
X-Received: by 2002:a05:620a:4514:b0:93f:211b:a7a with SMTP id af79cd13be357-9479f2c42b0mr351214285a.29.1794306572798;
        Tue, 10 Nov 2026 02:29:32 -0800 (PST)
X-Received: by 2002:a05:620a:4514:b0:93f:211b:a7a with SMTP id af79cd13be357-9479f2c42b0mr351210785a.29.1794306572282;
        Tue, 10 Nov 2026 02:29:32 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0234a5dcsm54994175e9.2.2026.11.10.02.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:29:31 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: fix serdev controller reference leak
Date: Tue, 10 Nov 2026 11:29:29 +0100
Message-ID: <179430656698.56244.5559839363678053917.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MSBTYWx0ZWRfXyfy0agbeYB2b
 HhNkFur3ARc4Z4WMLpW6CHyHV0ZGoZPyhSAXiY12Gjzw/fA1J5j1D65henfFy24WiSQlC1iJNp3
 J7hYtkDUmrkiThXenkOcSToL7mfbYOU=
X-Proofpoint-ORIG-GUID: bvVfNGIAMgCWswrlS1YQWb-reutRfK7H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MSBTYWx0ZWRfXzfpF69C9yMsZ
 CNTuGh/fNYuSnY3jlxaUfcLj+5pRjr3apDywLbNS0yjSFj5O1uTbXS9MlqEJfqL3FJTYk7Msjk0
 NvE76mVNbTA7sFS9dQBL2GYi/cdTzW2XwWE2YY/ZjWi6MEQpufgFquPjzBqj+PVVY8AZLgGxnIb
 CApXpQYoK1Rdkwk+4NWwVQRnNyzQX/uSF2NYFhXIVDwu48a+97Zpet8RSQBlxirJY5RdhuVzTnP
 W0kMbD78dz9+CRM+yZzQ0Xvyyi1JIh2pXAN9j/2du4hS3SfulPjRFgFzy8oe01jF3FMAZRufmcg
 z7s38ORUYas9O1iBYhmFNu98sTauP9y794HviT1iD7pC7x6kcKMWYb8xDLAckDzR5Nu7PWrwXNA
 8m4KosiPFzMWkrAVDGwrqbi0Eh+yfxhxMgf40uSfyXqOaR+5Rn7FZw5DYDBkuPxvMOa1YoUTgrY
 tJdBIARzJOWE0Arg1ew==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af2f20d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=heQ8kAePCfxZzHD31_sA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: bvVfNGIAMgCWswrlS1YQWb-reutRfK7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100041


On Thu, 05 Nov 2026 16:46:45 +0100, Bartosz Golaszewski wrote:
> In pwrseq_pcie_m2_create_serdev_one(), if serdev_ctrl->serdev is NULL but
> pdev is already tracked in ctx->pci_devices, we return early from the
> loop and skip the serdev_controller_put(), leaking the reference.
> 
> Initialize ret to 0 and jump directly to the label that ensures the
> reference is released.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: fix serdev controller reference leak
      https://git.kernel.org/brgl/c/073f01043e79fd76f4fa648e58061c80329a6eef

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
