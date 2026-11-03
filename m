Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692068;
	b=poAc9hMiWG9SMe8pmv5/tBibw4oT5grh0Jatr7nNc/fUQELUZmH5uDVMsyrnhA7dn1Pr
	 S/Vg484hCYN36BCP8jMK8d2RRE/HrFPMb940Dd6WsCJrDAVsS3po3k6xHeVpDske9II5T
	 oc6XcB7ji7ETYIFpCAHQCJu3aYSdpWoGexjQsdIte0iSd4uO+L3GGbQZvN8v8nuPbs0Vj
	 jU/9J6+vCO3i4uah2eAGzrczrj915eZ1hyJvYpCUSgzXWaWCbaVnga5/6S2dRU9eAnZza
	 Trw+oIerPbManxIrPRiDdXVww2moiUwo73xiT1LBlAYjpHu+fUDDO1ov/S/AT6y+7CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692068;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ywb3iIVgvCE4CPowLXS8mRRRlJiLr6YNngOnRe7C5DY=;
	b=mckeIuy40N7HrS7B9GiAk6gR0FosDVkuE5fdbReYxfN5ufKFy6qBsoKUgDjCcg+5s0D0
	 9ZVQaRsWzZmzaXTVjDWabG3amdjqrU1/2Jhg5SE6vMpkVSMyaw5ofTWSLyTnYckwuXsWV
	 IMmnbUyJgvo7TaCdKwuhnhsC/jikuZVdRbib0yZlfCip7OIm93YXs2J/g2I5uMq+8s5/3
	 Dv+Y6Ivm7vHp9tmfvdMlAlmeiDkG65RAUjjeaA6lXVGu8uFIeNnIBt7cj7FCda9VcOFqF
	 1h0/VZkWBoFbWTShZktStXvWf34ADW8svIxjyu2pLHoaIRohTyOF69FPXr26ArgdLSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N0oJYIFC;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049C606A329;
	Tue,  3 Nov 2026 07:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E049C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N0oJYIFC
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31iM5X3334071;
	Tue, 3 Nov 2026 07:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ywb3iI
	VgvCE4CPowLXS8mRRRlJiLr6YNngOnRe7C5DY=; b=N0oJYIFCSF8JpG1TsU804t
	ClzV07I54bK9Etsw/oOwRLgWA/kCWU8dZNMO0oVFgGcM3c/+hxaFw5bX1ugj+GTy
	xqU0bO4Ulzb89//+MJKVGSmiKZlaoECLc9g6enkLla4Awq4DJ4NZZNPg3sb0fJuZ
	ODT8C5F0AkXOPPE4g5AIec0vIHRVdGIM03XE4merk5mQoIZFDqA6Tm42h2e5Agg4
	YvELgISEevrkok/j/OVgAdwxt+y5ddY7C006J6LVVHbKklB2+l/VdWntJoAdiwzJ
	ANg9dabUb1Sbu3y/vxlY12vAnOI7V1K0GsjmkmvqR4lXfXV0F8UNWfX0PUFL7DFQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd4bp6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:47:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37dFQN1799421;
	Tue, 3 Nov 2026 07:47:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hntnq1gf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:47:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A37lLfG9961942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 07:47:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EFC520043;
	Tue,  3 Nov 2026 07:47:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AB3A20040;
	Tue,  3 Nov 2026 07:47:19 +0000 (GMT)
Received: from [9.123.5.65] (unknown [9.123.5.65])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 07:47:18 +0000 (GMT)
Message-ID: <95e84bb2-ce01-4876-b124-1c756df69b10@linux.ibm.com>
Date: Tue, 3 Nov 2026 13:17:18 +0530
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
Subject: Re: [PATCH v5] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
References: <20261102091700.253381-1-gautam@linux.ibm.com>
 <y0bb5vxv.ritesh.list@gmail.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <y0bb5vxv.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Li_tZ5OxQz3SydmraBcipiYPYhGns1Xg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzMCBTYWx0ZWRfX3t7VggVcsU7q
 GkneIvyfvRzxZJ/C4ovNf2L+F6HNKQqqoY19zEba6TpX3IcHMeaXGY5oG5+70Yk8/2l7Ynd911G
 ZKKN84vKSFqWGQzWw/sVBiRFnFvqhEp+d27R0Bzs10L0K3FkbAInr8oH4Mw4Gm0fZYIqz/VQU4e
 AttKoSb1e88j/9/XXr+S4jZo9WXAYPoUU/RG6P4f2p1GyowyLoKvrFheTxFe8FsDfrxD8/c4dD+
 wJsUO6EGa2+SCiLPrnRQCRkX8AHlxEAPMN0BU3dOmgz4MeQDBDbrp7yorQCDahP+0OGPydTXLkG
 LuKQx6pF6PmunaLBdrpz0rvIFWyONeprRA5CdI5v5bBYRjBBhVXOodUp9MLgPjAbNI5LWliVQna
 SueU3eJ254WWRheG0ybHH69CoBdrgvkH6JuHF2bmW2ahUSssx46WgxMaX5eG0v46XqrK/Mq4/WJ
 b+Kvid5MUUS+v/GEP2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzMCBTYWx0ZWRfXzg95JroL+ZG1
 udCWWSx6aEF5ii4tAe+STrDeSRSx77LdU7zvfiJxId4J/WubPj9HsK97hArKJMp87PoSy20livM
 5cpkMF7t55ldbUztl02rkk5ZBIskv+w=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae9918e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=VnNF1IyMAAAA:8 a=_AprYWD3AAAA:8 a=pGLkceISAAAA:8
 a=7Tt6I7ke2-PkhW0PcloA:9 a=QEXdDO2ut3YA:10 a=6M1ixcW_PCWoKiWyFx5v:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-ORIG-GUID: jvdTlFSGtb2PleFbR40VWW8gx4DzFdKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030030

Hi Gautam,

Thanks for the update.

On 02/11/26 4:42 PM, Ritesh Harjani (IBM) wrote:
> Gautam Menghani <gautam@linux.ibm.com> writes:
> 
>> A huge number of spurious interrupts can be seen immediately after a KVM
>> on PowerNV guest boots up in XIVE mode.
>>
>> $ cat /proc/interrupts  | grep SPU
>> SPU:     223705     192439     273526     147623   Spurious interrupts
>>
>> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
>> Handle pending exceptions on guest entry with MSR_EE"). The root cause
>> is that once LPCR_MER bit is set, it is supposed to be reset by
>> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
>> not exit back to the host until the decrementer expires or there is an
>> hcall, etc. This is because KVM on PowerNV guests have support for
>> native XIVE, so they are not dependent on host for interrupt emulation.
>> Due to this behaviour, a huge number of spurious interrupts are seen
>> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
>> vCPU exits to the host.
>>
>> Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
>> available (currently in case of KVM on PowerNV only), as the XIVE hardware
>> can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
>> functionality is not required. This reduces the number of spurious
>> interrupts drastically.
>>
>> Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
>> Cc: stable@vger.kernel.org # 6.8+
>> Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
>> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
>> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
>> ---
>> v5:
>> 1. Drop the redundant check for the presence of the native XIVE
>> device. (Ritesh)
>>
> 
> Thanks Gautam for confirming that.
> 
> The patch looks good to me. Feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Using kvmppc_xive_enabled(vcpu) looks sufficient here since
KVMPPC_IRQ_XIVE specifically represents XIVE native exploitation mode.
It also preserves the required behaviour when switching back to XICS and
when the in-kernel irqchip is not being used.

The earlier case where both BOOK3S_IRQPRIO_EXTERNAL and
xive_interrupt_pending() are set also remains handled by the outer
condition.

Reviewed-by: Narayana Murty N nnmlinux@linux.ibm.com
> 

