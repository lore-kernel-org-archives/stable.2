Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD73822AB
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608591; cv=none; b=TnaBzwyNWC7ujDn6OWUFuZiziYEzuEH99TsqJeombq7IVPuup33E39vhWMmRu1TdBZZzh/XeHui9mscMm3U9kvhC36IY3tyC/nMhjMnQCIY2Za5PQ204uEU9vdEBonl0R2tfw9vBBa9fc5az1mdFzW9CXs15ngOUTFG4P7SJVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608591; c=relaxed/simple;
	bh=QIdn8hL4nNiB3KOvBHHXDb8b4ie6vF8pOo18PmyPmZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HdroKjLE+Rb6dphajZ62iwPpjmFmwFlzy4JP1t8doQyOQCIH9MAMZdM6ogqAFqwG+DyC/Mqjx8jc7kKXRO0DJyfb+GyBcD9Le06IZ93KKj7Ze376n+pWHksFlrjFiqfLIoVbbb1rqmxYciHYSXENx8Lq/SUwpbN6SDa7nNmEykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fPA5pYyN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U/pf0gHP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fPA5pYyN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U/pf0gHP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Dw3L81972344
	for <stable@vger.kernel.org>; Thu, 9 Jul 2026 14:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPc0PsftVnE7aCxsCXlTpMZErMgufUZdgPI6m9JGZCI=; b=fPA5pYyNklZM25Fp
	wQRw1vQ0Y4G7neZm1mAQtuYkmTCrEFluWcYezLBnR+TXuXWz3sjBKjuC4iHIOSFo
	NVP1NoPzoyAIXCMFiQ3FI3CiZ5PjTdcKFzKoY5ZrzYBBXXOP14Ic4URYMCnN+YGY
	oQkkumOApJ8fiviySsicS9g7torJMBXCK8a8fJYXCUV+oAhVtF/6A9hCLMxXHgnY
	zs2sAXq7TJy5zJZmS8f99dOz1Vau7xrJo5D0OxdCHK/Y1MW7Mn0KT76zBSRAEiNn
	GhAVVaPLKeopbJo6t7UX+dvkcE5iO3uWJMaIm/Z0tOrYGwjjXH1SeF5eR32KtlK3
	l5Ro9w==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvv9f7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:49:49 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e6a82224bso16811137b3.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783608588; x=1784213388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPc0PsftVnE7aCxsCXlTpMZErMgufUZdgPI6m9JGZCI=;
        b=U/pf0gHP+x/RXU9j8IHJJcbp+pX8dB7OmZ0P1n7qGgAye2JT7tfDG1OiC2Dn0wygUz
         qicoVxzzSyZTdZfi94V9g2Af5S368z6X4q+mm3iTBF4ek44hblR0iCNIV+xXs+4dznhS
         BOTeFVIDbjgCmXJjXpmmXbfGF0ck49OijSq4Et3J5rum16FqweUY/Dj9BzNol/rli/UC
         6legJCRU85qbC5id06x23cjZucSis39lES9etFRR6b+jhIWcVtzdwf0UJWWf/HOyDDMp
         XIssr30KhfeghQj0XCbseamRB2O2w1inwyiAx11nw3ebvJJ7sgkFCvAu7SN9JXzMQ7c/
         1g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608588; x=1784213388;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPc0PsftVnE7aCxsCXlTpMZErMgufUZdgPI6m9JGZCI=;
        b=XvQ6J6rKwuDYSCa9QEWEcJjjyNl5zdjt7jQEhUX6VoIVUOS9VevLaxj9gI6fT6jiHk
         /MGQ8iyrGC1DgQuQx7xwM8x98Q+PGCjSrFaDUJU21Bcd6hhqoWaonvBfsn/CZaOmvu+C
         ka6lpYsJIlS/uXfnfbJngUl0jQnVTJVMg5SKnBYgNM+dVJ/fofmn/fy9CoQzhKGjfl3r
         OdFMSV5zzP8s+NzovxcMdsTmiEzFndCTch1QqlZJNt1/XhZSOepCOIymOwTZX2Ra0Kuu
         6DljYoQcvG6V1R44RJbCOmjGtzZGC9QCwj39qSn9vBNSKBHmfrqk1MpBSFLc+jRCmFv8
         tbCw==
X-Forwarded-Encrypted: i=1; AHgh+RqFdMXh698OuhM53ZWQtwRco1VZa/wxTnOw41ncogiCOHXNsVFREOttk8YQSTJFbqRI4MFjNvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oFcW6LHZQYj2LsAYARC4l5z1sASQjVwKWnr3LC7IWVEWujJT
	H0qpUIG/El6uG/kvVUZjQ9mfH1BkoI/YvA+kFr3OJN6OKOHt0r41uLrMLj4h6co/QQZ5X6YTsXF
	u6I4L/ck/nDs4TM1nSd0mQC7VgA+ueuEvgT+S/4+DdvepHppc/0zS6PRvguo=
X-Gm-Gg: AfdE7cleKFhFCqG/s2FaKif5OaIi1W3msMI5Vl6lX6t50j+RkM5sHfdRUf1zPkkcNg+
	228ZpdxTmDUqHxN00NfP1bXMCmrbMy64LBV3DB+lpz2Y/ILGE+3Hmmnp6OYMXjEXJ8xw+KpgCl6
	XiMizDqxcdv9uVV+sQYYwyV6tcZGA3RzsAWf1j7P7JlTE3vb2ZxQbge+BNJAu1uMABRngRCTy+v
	phShMH3vHZZ6auRYVX07DeObXNwh0XR2j3oyA8GBs4VXUgK1a0K3IW6eeM3E0vaCoT4QU5JcVAe
	2hw7pRAQNFD30b7WZf9XEGqsnLNVUBHtG+87USC4Fs7p4TOB0bcF/wD6v0nGQsq+ogdyn2ahOaH
	IVhM1axAbW+ruX0wRa6QZljmXMCtDk2trgak8HizGhZObGC3+kNuPxl0lWfJdOS9Ynw==
X-Received: by 2002:a05:690c:6c07:b0:80d:15a3:7b1c with SMTP id 00721157ae682-81dbc049eacmr66480137b3.4.1783608588545;
        Thu, 09 Jul 2026 07:49:48 -0700 (PDT)
X-Received: by 2002:a05:690c:6c07:b0:80d:15a3:7b1c with SMTP id 00721157ae682-81dbc049eacmr66479907b3.4.1783608588060;
        Thu, 09 Jul 2026 07:49:48 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e7795988dsm4989277b3.26.2026.07.09.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260609092528.220547-1-vulab@iscas.ac.cn>
References: <20260609092528.220547-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] wifi: ath11k: fix refcount leak in
 ath11k_ahb_fw_resources_init()
Message-Id: <178360858649.1031194.15594754786646144074.b4-ty@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 07:49:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXxzP5l+D6EQJU
 IP1Pp53waiSkZOk2gdGqK7I6Cmm4NskG8xC9KkJ/3UCM60K8yY4OYD2Q8/4pAEOK8MfwNqtXAe1
 FCn2xMIVRsloGBLGAnTgI3j55Wc/aec=
X-Proofpoint-GUID: GGWG--9cp2Xl8LsAXTzp1ApowIakebEF
X-Proofpoint-ORIG-GUID: GGWG--9cp2Xl8LsAXTzp1ApowIakebEF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX0v2P78CFfpx8
 ySDVrN1E4lPPZfk25ezHYZoUQzRcjkR3oPLWFbL3BxRMrE4HhJCTqWQ/gsGNaj4A65FrLL1qgyy
 c23r/d4ACh+NgmR/r8Kf7R755laECfT65bGQ435ghTn2nrXRoL4vJNPKU0Xe4jcRDg6OZU1orh+
 Q9E6PrIfeDJg03DI5Qpu092h6DR0Jf0axLV7eEDQb5g3IOjyhsPdFzLg4/y00HsXqDnmbHMteOl
 HniDM1RI2Y9dQKrMQtiwOPRH33AtFjcQOoh8k3Rf7vi7FhK12WHPM5Z+qbiYHBIkeOhfwkxSPVg
 uOePpLL6veaqCUdNQnqQbPhWyPDOV0gqWv/J1Ek92iuQw73zL/d7KBlE4npC6Nh5LG+q4aWhAUz
 9RcsXlStqgCdRNL41iMs1UFSOCeXQUky0L0bhwUTtSrggibXvoRHnkZFDylqUfYSrDBJFo/7Ldm
 oWGytgetQTgL03xqeew==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4fb50d cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=4uP_mf1xeMm0amWCCpcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090146


On Tue, 09 Jun 2026 09:25:28 +0000, Wentao Liang wrote:
> of_get_child_by_name() returns a node pointer with refcount
> incremented, but the error path when ath11k_ahb_setup_msa_resources()
> fails does not release it.  Add the missing of_node_put() to avoid
> leaking the reference.
> 
> 

Applied, thanks!

[1/1] wifi: ath11k: fix refcount leak in ath11k_ahb_fw_resources_init()
      commit: 0e120ee0822b7cc650bd7b29682a34e137cec10d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

