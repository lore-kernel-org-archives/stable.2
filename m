Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD333AEF57
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029832; cv=none; b=pgjMRpKI0kjTzUvpbJFLQht8qb2Hytilrw1AKo9kKeSWaF4fbvcbUm0wWMr89JEId1OfK0fyp3NuP8wra1hzxEFOz6To3eaNDxhiGd86HREBF0KHgCb5REHjG0cc6GEecFwSBjsuGMN7zO4x8sKpA15EjCfRpIjfVu87wHPfLWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029832; c=relaxed/simple;
	bh=eEr66d69pRMLa7uye6L6l7GSlIwsxhWoejkxpcsCj7w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PurIbKca7LAeBbp7qrtfTLOPHaHFeDPlj8AI7Bn0q6AHiaZWOiqteP23CMJI4Ab6fNHYcx4X2QWBsUNcBV8BQOAGLhVd3TFVTEXBGdQGTJFyFGdtyCaiUuWiBrsPo/0PF519WTNG+Mgf08IakkbUXW94vrP3v536HvcecGbRT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dYpbk0P4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FeSYmf3G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYpbk0P4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FeSYmf3G"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GaYB4187870
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MtiGDKihwWXaJj+ph8EISAiatJoUykhVq4J6XnBzE/Q=; b=dYpbk0P4OrOxhO21
	WzPEyM7wBniiHqjL7jQPgwTSSMCEJVEMXIBKdmV7Qmw0fYaXekS6bedaq/pbnSWZ
	KJJJLBNYjOSQzahOoBgj6/D31UflfXGo3oXYrrjWFPE19IWZffCtQWtmW5VvjV8y
	84EE7slIhcdO9N0p3hygd090d84SoXzzRT6npNNXYOqq9cOWxhZdNHnzbXuG/Kkt
	GG1L3gsvYQSKcQ0vPhTha7S2Y6oGXLse6tpcTv39zqMb4UjhmHmFW+/OkM+RcWox
	HbFcIvArlpYMIkhzvMHnaWoFjqgDOyVXbsyE0KBRLtMpDEl2Y/DJJdI6iqWreBsC
	hGaYiA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcygtx7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:43:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so873597385a.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789029829; x=1789634629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MtiGDKihwWXaJj+ph8EISAiatJoUykhVq4J6XnBzE/Q=;
        b=FeSYmf3G1l+U8fs3BwvI+Wm0PnYejQdMbpfUhpamJ7bM4DDTjffLhlZBluAQ8IIjRm
         B4pfxvUejUWVLyz2mMUbWOgKWVu+uVVX68X7ajhktYfLlv8QbwVb//oZT0KfD9C0crWc
         qIGZUR/mDMZa6g6C4pWKjVc6eHJeyeqxy0YGFKr3nbfCIMLpOQFyoe2aSZbEArJmi1Ut
         ya/yLMDfPeYfqKF5d7vLH1ss9rT8HKZQevMMUc0r1B/eZFLT2/WIyjga3py3WeK3ZwDU
         Mas90wcw7zeYan5dRSZyjnV4N7bficplemIZhyj0nLcWLnzaYeUHLgwCNyH+BqYoVugN
         8VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789029829; x=1789634629;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MtiGDKihwWXaJj+ph8EISAiatJoUykhVq4J6XnBzE/Q=;
        b=Vg+OXh2JldcmgjbUCCK55dyI26scAmXt4Oqcee43XN8JjC8+mndehgmJCkxv/F7MT8
         X4zieA7ooksnlxjscxPjyq1nx16c1Fvaea2idDbO929UhXvaf1pKlkN/UywNR6rUO1SL
         yRmd99idgJQjdAxHuMDcjgUprG7NOa8sEDxMIgzdOXpUQv7oM3Lg3S85e6i/MkbvtSr2
         BzUZ0xncARRsnzzTx1kgDPOW+yf/upI5snQmWH6XrsVWJHnmF86bOBgdFybPpTiPdB/p
         oG727uQiC0alG93Mq0wQVls8U7tRLLQnPpsmURVQe0KJbIR8BZZarpp+LngVK4xTDW15
         TmMA==
X-Forwarded-Encrypted: i=1; AKwUvBzmmyjMkDu1JKxvt1HSg4OPae2eijZ8PFqWaisJ2m6HwHC+lJdDQVU38okJzTLD6VtXF4GtaXs=@vger.kernel.org
X-Gm-Message-State: AFuF++n3qvlBRfoqp87NgaxYNmZjoSSiNlATngZaaGQq6qGCGk9H8nky
	VDkeMDT2DSXDWmQ6q+dowQBb5pG9JwXFgOiBRendZoYTrcKyQo+KWCR+CIuqp4k7XYEa3LmmKs7
	3fFJ9GM72HwqM6QVzV6BpKDqjPIktFvOaQwPlxkDcg/GPnCN7gdqRDkXmiLk=
X-Gm-Gg: AYBFou2QdjnpFzCeyeALgTLQDg7XSnswZvdBc3hv60ICt17MjyiGBeGWan5Y5dKaMYq
	b+Uo9LvwHQaxmIW+g5FJj89Dknpgj5MnIY8fBtutHOscWSZ4yB2IpSG/SL2LjJMF+dTcQd+VsQF
	ciw4niEQ58Lv4kdAu7lgU5FwB2Ia1yPBtH6GHf2GU3pWkwojn060/gnMSGAigJMwsgfZ1v3Imn3
	tPxt7LOXTF20IgIKG+mndeu7Ezgnk4RaMsQKUvJoI74PADc+MHnmiXp4rbNlgbv41ynKyyGmRw6
	aTE3eDJzEnCZEGCq6UlvGObbVufcOaeqyUdzJ6b0/OSLcjBm5XXm1E377SPxg/Q8ZxV88tWvifn
	alNCM/iJoTExNqRelBESUi4CN5xadbEnVVGgNZYyzURmTehcfoXGg5arhOcM/YupTSwHVaw+w5G
	5wPugiwqMCiSZr833zhxAAWIc5rJhHKnaB4oM9fqMwvgQTjFuk2VniNgoDP+4V1P5v0UE=
X-Received: by 2002:a05:620a:8423:b0:938:fc91:91ce with SMTP id af79cd13be357-9398036365cmr3566661885a.20.1789029829657;
        Thu, 10 Sep 2026 01:43:49 -0700 (PDT)
X-Received: by 2002:a05:620a:8423:b0:938:fc91:91ce with SMTP id af79cd13be357-9398036365cmr3566658685a.20.1789029829086;
        Thu, 10 Sep 2026 01:43:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26204ecdbcsm801689166b.25.2026.09.10.01.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 01:43:48 -0700 (PDT)
Message-ID: <bb913cfc-288b-4ce6-befd-76c774de4d02@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 10:43:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] Input: soc_button_array - fix MS Surface Pro 11
 probe failure
To: Sergey Lebedev <lsa.uz@pm.me>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        stable@vger.kernel.org
References: <20260909093934.29411-1-johannes.goede@oss.qualcomm.com>
 <20260909102521.67488-1-lsa.uz@pm.me>
Content-Language: en-US, nl
In-Reply-To: <20260909102521.67488-1-lsa.uz@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA5NyBTYWx0ZWRfX4Er70gtRLz5q
 A6rfXLs/38vBweS6UsVThXUs5bRO7ijEu1HVaDiJH7oDITCWbH//g8u9EDYslZ72gkqHbCqPFom
 JbkEGDys6Q+jI1QrgHBFic/ZK36RLtbRt8Cyspm9xZdOAVGT1x/Si8T3nrLIr1E/EWd0xMnGIIz
 6PeRLbiFJtmEf+/0nYYmg+9p1UILrqMDLSfkSFoqW3U4EAnslAOGCekq1Mgw+2HkY0QWMfMhxnE
 mQrobuDXTRKhMk945r4xAUx1qomMgqVwAT4Jv6VPf81JA6sPMrR8tPyoTaxwRGeG5Har89HP77j
 HGkjDyzMAFOFzv8gJadoEobosj4cV6O7Fn+fxyxnMZmZPItjRZ8N+dTmanLtfoBrnAwlW/8+gY2
 3H0PXJ/T6ZApbKg/FrI/vmjRSHyFfPCui/XNxTOhU+HTkniH1wst/Ig0LktzK62gz1isbGGrJYR
 acwwxY9QfsUHOCs8+jQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA5NyBTYWx0ZWRfX4wKV7TjrtARe
 SLirc+K6HazphOCX533LBhyEPiHYjIqO4JrEHqvrY77ZH+zSPbOqihvRkwafLw66u+lhTgVi1OE
 +XCFPYI+MQG4f5RWg0NTFGq3mOzXPK0=
X-Proofpoint-ORIG-GUID: xS3bnxDd__RO9IOLL8Lfqz-oFmHWyS5A
X-Authority-Analysis: v=2.4 cv=VONIDNPX c=1 sm=1 tr=0 ts=6aa26dc6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=ruf0KxjLdvrAcJlDzccA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: xS3bnxDd__RO9IOLL8Lfqz-oFmHWyS5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100097

Hi,

On 9-Sep-26 12:25, Sergey Lebedev wrote:
> Hans,
> 
> It fixes it. Sixteen consecutive boots on the Surface Pro 11, every one with
> both gpio-keys devices present and MSHW0040:00 bound. The baseline in my
> report was 13 boots in 40.
> 
>   boots                     16
>   buttons appeared          16
>   first input at            1.242 - 1.377 s
> 
> For comparison the 13 stock successes ran 1.28 - 1.78 s, so no boot here was
> slower than stock managed when it worked, and the spread is tighter. The unit
> that binds this device by hand was disabled for the whole run, so nothing
> masked the result.
> 
> Built on 7.0.0-30, Ubuntu 26.04; both patches apply to that kernel's copy of
> the file as-is, 2/2 at an offset. Ubuntu ships the file unmodified - an
> out-of-tree build of mainline v7.0's source carries the same srcversion as
> Ubuntu's own module - so the tested source differs from stock by your patches
> and nothing else.
> 
> One note for whoever tests this driver next rather than about the patch: on
> this install soc_button_array is in the initramfs under MODULES=most, so
> replacing the module under /lib/modules does nothing until update-initramfs
> runs, and modinfo will report the new one while the old one is loaded. Three
> boots of mine were recorded before I noticed. I checked
> /sys/module/soc_button_array/srcversion on every boot above.
> 
> Patch 2/2 was in the same build and caused no regression, but I am not
> claiming a test for it: the buttons appear here, so this machine's ACPI
> descriptor package is not empty and the new check is never reached. So for
> 1/2 only:
> 
> Tested-by: Sergey Lebedev <lsa.uz@pm.me>

Great, thank you for testing!

Regards,

Hans

