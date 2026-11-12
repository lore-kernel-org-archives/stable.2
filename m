Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504961;
	b=EVo10u+Op88cIkl8xvCy9xYy2E5lVutEGNlI/gHzilqFpmqJxuw+QHl6mIBixG0XDpa/
	 s1agtx+g66nEfNPuEhvEIku4ka2bveKD/UTSiKRe83ScY4KzdKNQETcLmODXWE5p5JQye
	 sqiZQCn4zunOuc7uNqXwGfKsw+dSNS1g/TI/K8J3sG+AAXSz6SLyDW+rxWkiGbqQNXBJY
	 WuV2cK51TroPNWI5akcIAzVDmiMqjNCY42sEHUsTDUEdYWWNj5nMLzVuGBrriMieSV0eP
	 pDIXdF9D5NDGgkPs5Gguf0n+vGg2SRmfaYN4aijCHvcZHhq54B/fwHuJNJ+vlS3JvVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504961;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6ARaiH+yGSXvs7RhHMO/6X6meS5Td6KQMs8Pk2FRdGA=;
	b=jxJlkfNVJsmyLmZtak1pISR2rDtFGkPOE1+d2xAWLDb5cGJrF9fomgK93+UiVKJUPi1P
	 Q3EpD2DDxKKMNQ6X9hU8Cw/UlGepbbRSuvCxWFO6RNsubkUbIKl5+5nmvzV9kJ5XOc7fZ
	 lXnU8ZQTwzNjvEYfHy5epMfpasWljAmvp3yueE9nx4hWqGSBYt1XG4WKENBBSuf1iKt5F
	 uN13OXo5DbZTBA6b4ihtcX91CbQq0WyEPsQ5Kuia3HKHLgf7qHxGoTW1wILdOi3t4ArQ0
	 bv9qCBmsEc8enaFUAkQAzcgbd4/3Xjhco4zJmHyC7rjRNdzprhyWtskJflVRAkC33zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8x8FN7h;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="L+/jICeR";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D2606A885
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65D2606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8x8FN7h;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L+/jICeR
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACFZVuF1736587
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ARaiH+yGSXvs7RhHMO/6X6meS5Td6KQMs8Pk2FRdGA=; b=h8x8FN7hs1uMIwVF
	+4AkQgWyIJ2znC9hkPebS6CeL84FHDaNTvqZL/eQDWOYki7lVSOKMQ2/N7W0B4Zf
	Pc8nzwI3n5PEKjCvc/azXf6GpW9VdJJJbQzQDKs0Qt1iB0EsPw3UjdXMsMtxMiks
	BU3/9BFcGNqhPx0MkRVpj6N81ShoHMOYodq9pWhykGCTnZ+f0nqNmQBsoc+jP7Lz
	obe2qlBuWNpP+Zu8mdFd+f4CuuWjP674XWh+WQG4JdBM8nJ577D7mSOcYBKYj9fd
	5LXH5g9O6Zymk+onVOseAyr/+P3seu7hWEALu+b89zTxbCPmyhHQgz0FzpoOoGmR
	8APpNg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc2n2b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:35:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36de26cb4b3so102381eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794504959; x=1795109759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ARaiH+yGSXvs7RhHMO/6X6meS5Td6KQMs8Pk2FRdGA=;
        b=L+/jICeR+mXVzVUtNwFCJFuc8DWRO1/4P8T8SM0qnvpPvClb5DsYJPesg0rWFxCrjm
         DxDRBjEEErrTcRRyShCZq0b2rS72KPDS9ywGvtLDRRk7efmnAqkrmdZgdGKlTm92RpFM
         ChJrk5lshD9GY1vpty39qgZwENtWAzkgME7emWo1kzzyss3z+jPEUY3eSYkBKoRcBt0F
         OjPoIPP0Mv7yaY7l3eUFGTMqFhQpR7GWy660QLc2lJJphlZvO8/Bqq2kGN77o2eb10Bq
         vYo8h4g5KhAGiRc8dMyNj2Iq+Vy49p3BRBZl2unzg2DvV38vHeqygaHlDSLsomBkNr0w
         HQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504959; x=1795109759;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ARaiH+yGSXvs7RhHMO/6X6meS5Td6KQMs8Pk2FRdGA=;
        b=AHzCzyx9ZgKSav7TbhfZxmC898LxgugvEDi8gYyJACl0+Xd4PiwipWEYYomyKRb2cv
         6MihI5ydolhaa1L0HeWZ6Lda+3W2ljA+ozmc/aX/WmzIe+Or/hGzx8esTY8qhPwSNjo7
         3pfX16k/A+f60o2cyqNYi3l9tdw6d5JudRRQq21YKjOBX36bQqegk1TvDNUW4hwzskST
         lnIjYE4f03eTuEqklRyyl+ev7OwJ9EIG/yQ5Z9gVE/P7AL+//63NDne1Q7MJrQQ0a7m2
         JkwxtW2hKwux2Ey10zI8tHy6fVUgGGULp+jHq42FSkTeYxLgWQu1w3/UClbWgZUufAYm
         A8Hg==
X-Forwarded-Encrypted: i=1; AL+hErErsfOpBIKqNz0i1B8tekcF6N2krM9Rp0F1l30GFhLOCuu/ORhDMvppYKnDo4qfZND/AebWCzk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XtfMFRoDJWZseduJOfJ7o1hIH6kKOWWV5Zx5F2+GOTfCMQTs1
	ZJr5vXmyra029Lpoou/6TAF7x90WoRM0+ao7N6s2F4x3+qol3WGSDGzZe03yu1/6RIqU3a4PhKR
	Iz2PbizzGMwUygNje/DzJsCXCaA/EXWfCPvQoYIcl0G5kfFkpVwVmf9ugL0w=
X-Gm-Gg: AYBFou3jlNb6CdrksBhUN+U950QLZ6rL0Vra0O+tX5GQy3Eode5ZhJ8ieC6WWSE7vBV
	m8EUhqzxkbhZMXmcNkYPfyZug6848ARhIpmRagfHR5U4FwTOG+MD26f2fQCdXh4n2JdD5mKnaje
	Rsphs44p7+Qhex8x/hdL0hAc77dF+SRAqH7+dBiU4dVdtD7w0lyowvrBTlBgAwLTqBeh701Y/+I
	yHaiTzWpc9KZra/dmPkk9KHMDoyhEhbVCeWaDJs70UY7iaezoleRqH0MQEsePav+LWicwTdqJHv
	zZUj4tODSO/M4c4sIlrVT7WnTnKohU6E075+uGOGkD5BETAPVnR9z2Nr4pHn7X9DmOIy352pAyf
	e4znedvvreg2KtgtaFAVQgRt6lbgUcYx9HTm5L5znC6tyc9GgYTljSy+/amu4lWBMlgKromB9WE
	LGS5FXKsV87cAAPFVbJUTlwCg=
X-Received: by 2002:a05:693c:4007:b0:369:f420:8679 with SMTP id 5a478bee46e88-37687211c14mr6500562eec.38.1794504958622;
        Thu, 12 Nov 2026 09:35:58 -0800 (PST)
X-Received: by 2002:a05:693c:4007:b0:369:f420:8679 with SMTP id 5a478bee46e88-37687211c14mr6500537eec.38.1794504957717;
        Thu, 12 Nov 2026 09:35:57 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955e0d966sm44496eec.15.2026.11.12.09.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:35:56 -0800 (PST)
Message-ID: <410eef90-a692-46a1-869a-cbd121c3981f@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 10:35:54 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/ivpu: Defer recovery until probe completes
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
        Daksh Sahni <swizzguy76@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>, dawid.osuchowski@linux.intel.com,
        stable@vger.kernel.org
References: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jcofCka8SB7gZTuer9gkivoj9nQ6JXrz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfXwUoCMk/dcJaM
 K6cf/0+fEmNq6vPIaWTCWJ0lAbU/CzvtTxMatScKl//rvlEa4SBKi0E/9zkr/DsrOF1vtZhsUt+
 F/MToAt3rtngFmR/zapJeu9dvyi7UD8=
X-Proofpoint-GUID: jcofCka8SB7gZTuer9gkivoj9nQ6JXrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfX0Cwmb2oHLPYv
 FPcZU5j+74oyyLehfVRfhwrNiAjZP93Fwjx1JC/nxwaVCz6d3ZImR6EBa81Sa9JA1QjicP5aU6V
 ezvVWo/CoWdsrS5yE8cy/xawQ5dQ/SqobcplrS1VGJvG2lwq+BSusItDPR7Wq3ojri4taKXm4Ok
 jZbr88u8G2mdGd0ixrvdPhCnziPWJL98IaF1A6et3psYU6+k4apCcX9RKvavnuWKz8+ut/LekEL
 mEPBCYc7rHz8YGZWZBCyJ1CCJ3BECTkOviiEhZj1VKy9ll2jea8WC5sG6rEvCmAwUZTfkxAo5O1
 piwZhCkx6dZayyMVbgq+lV2gEc6w+y5wVaNfeoeCfGAfRs04O8BvqSOtmIW81kBYsVuhyL40K0p
 3efoSgwaYJU7RKF45VA7ZzFYIQbsUKKhvqX00jGhEVkjPJVu1cYmJFYJznJ7l6IUyE6YA1LjNSy
 Rtn/a0oBynK6FwjLYHA==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af5f8ff cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=Z2QDNxsNg4WANq0UR4wA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120070

On 11/10/2026 5:15 AM, Karol Wachowski wrote:
> An error IRQ that fires after ivpu_boot() enables interrupts queues
> recovery_work during probe. If probe then fails, the device is torn
> down while the work runs, and the work faults on the unmapped BARs:
> 
>    BUG: unable to handle page fault for address: ffffcfc6680200f4
>    Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
>    RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
>    Call Trace:
>     ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
>     ivpu_boot+0x9e/0x270 [intel_vpu]
>     ivpu_resume+0xa4/0xd0 [intel_vpu]
>     ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
>     ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]
> 
> If probe succeeds, the recovery runs concurrently with the rest of
> probe, and its pm_runtime_disable() discards the initial autosuspend
> request, leaving the NPU active until first use. Any recovery that
> starts while the NPU is idle loses the pending autosuspend the same way.
> 
> Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable().
> A trigger during probe still runs diagnostics and masks interrupts, and
> ivpu_pm_enable() runs the deferred recovery before the initial
> autosuspend request. A trigger racing with ivpu_pm_enable() can cause
> a second, harmless recovery. Request autosuspend at the end of
> ivpu_pm_reset_complete() so the NPU suspends again after every reset.
> 
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Cc: stable@vger.kernel.org
> Reported-by: Daksh Sahni <swizzguy76@gmail.com>
> Closes: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
