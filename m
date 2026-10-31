Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793415883;
	b=E2OvNPpoQIv6buxVsaSlj3akMrb5MBdZ+6CTmOq5eYhg728012+GjBt5oiv5GiQGTkbv
	 0OkzacMhf7qhjVG1Ydtbj4oxFwKoWSNbZVNjnm2eJRtvlOEhD4LP26qiVhOaqqF4Sa4tn
	 TYYBVNmm8KITGjh4g5RR9IY5tsei3pQB/4D4D6CFDMWYJYElJY3QxfJK4JftOgVl2ML/5
	 JFklW0eRcaL3U4FPlddyXpknZMziWR6HomiUQNKdpV5ZnnahZ5fV5eDOoFYe98ZQYASyn
	 jqy27Efb2AazgcVPrUHCUbtRXAwmYheqao+CUM5IM8N4sY1oFMI8MoqqmdXAKt+pwSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415883;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Qq9Gi8fc45uDTXZknavwNPXPkhG36IHpOfWVmgAJTO8=;
	b=twMP+sELIBEWzBC1h4Kg1bghCQMxYD/HAjeg6jr4sZ0jaKQeEQsEj/UJhuDUsYrH+WYh
	 Gg6AZfXQS2i0vLeD6lItQhC60HOoBqn/u0q7TPGju2yzHv/VaBIdbXcjBsFQ1RMLdlEDs
	 6nsKHiFCPbYtPhmHRfyLZkhEUuO8S/OeW+hWXopwO9N8hksg3CsU9zfRRPSH6opeG1k4A
	 s7k5m7mLqlniJXaoQfk5TY7r0HFeRDglvzmHwamGhTvLa8CMuXmRqf4ckAg4nmCiftSiK
	 SHXOJaxaP2FGnKxLBsrX/1yOwRH8Yl0vxxafUlfCZtJofgjGye6mD4dnQL5kLK4uUzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CRahfFA6;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818D606A31C;
	Sat, 31 Oct 2026 03:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5818D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CRahfFA6
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69V2jh6p645601;
	Sat, 31 Oct 2026 03:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qq9Gi8
	fc45uDTXZknavwNPXPkhG36IHpOfWVmgAJTO8=; b=CRahfFA6vUO+wZN1OD8QNo
	caO8ELhRo6MpUzT8redfIzOpD5xgT7MLeEOA/PRcDZYEegATYfTWvARW87F55ZBq
	fXKFo6mBZTGT89bDqCuiJVAsa5CWsmq3H4a/EWRwc87ZkIBmLh/vboSVeYWt3BKb
	sqoeEvbGMmn/QhnZevGaQ0fEBZneGeHUiIJOLdi/LvyifcTDcp1gC5Ds/8M7ICeL
	3Zri3jDNuqsh40HxmubJdJlBq9jxKNiDA0HAci9RvF1esKXSNeiuoOqNwepc9mve
	8PauJI4bcRG12SGq5jyJ14OKv8WPA++IayMSyOIthRVswIETz5p/EcmFf3fEdwcg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u300un-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 31 Oct 2026 03:04:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69V1KB5g1279175;
	Sat, 31 Oct 2026 03:04:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm8qpe9c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 31 Oct 2026 03:04:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69V34Mnb40567104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Oct 2026 03:04:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D6020040;
	Sat, 31 Oct 2026 03:04:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8095320043;
	Sat, 31 Oct 2026 03:04:19 +0000 (GMT)
Received: from [9.39.24.57] (unknown [9.39.24.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 31 Oct 2026 03:04:19 +0000 (GMT)
Message-ID: <1b0fa006-67fb-4da0-a670-257ad4c4fefa@linux.ibm.com>
Date: Sat, 31 Oct 2026 08:34:18 +0530
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
Subject: Re: [PATCH v1 1/1] KVM: PPC: Book3S: Protect TCE IOMMU table walks
 with RCU
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexey Kardashevskiy
 <aik@ozlabs.ru>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
 <5wyjwakz.ritesh.list@gmail.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <5wyjwakz.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6ae55abb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=As-yhAXl9qAxOirNzYsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: v05eA2QtmBvTZ-XActU_C27U97sAgfHL
X-Proofpoint-GUID: qQkmYWEwTqSXffaXvGu_wHBzkSOkboQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAxMCBTYWx0ZWRfX9gfSZjZTjtyE
 JDav9Keko68lSETS0n0rJ0VGv/0CszVrLhjDy5M1aUfOkhPJtEtBNolYptzHWmUV0SuosaLkaE+
 pqWwBNsCLeWRtRt/cVbupBru7Mv13M2rYLmyIdqJHD3rVpRH54KkBcHqyKX0KXD3o1PhQuWX5j4
 EwE8l7aRy1+t/XS3NxMEPNKFg04dyU2rPEMTbGGFDeVjrhYkfQCuupcE0kMWMPX7akqUVnllB3g
 h7xsKSsJclHRGmuZyRGrEzobO+2EgcgJtrzqI0rv3MS3ndIJnDyMxOVNZjj6XCv/PqLpW8VPxAY
 82FtcMnEy64eXmEblSxQ+hHxMrld++roofItI4UEYr5lXED65KoA7EUxhV0JnrDb3COrVv0TVAs
 12Ip6i2tTfry91ITPcZ90Of3rirunBi5al6TAvUWatBfzjgWUQoMA4BQ/AcFjs76m3OHFR+mDsD
 0hbLgnbjZK4UWyAUMmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAxMCBTYWx0ZWRfXyBzqx5U/9GlE
 k/vlfUifmTXf9V72nMAaD/WheLjzcZk8fClXOBEZVRd7UbNK8mTXkf6IlQogr3bPdQuWLr3g8hS
 UPMdiN8DzdVgHj6m5GVkIYqmPBWm6eI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310010

Hi Ritesh,

Thanks for the review.

On 30/10/26 7:32 PM, Ritesh Harjani (IBM) wrote:
> Hi Narayana,
> 
> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
> 
>> Commit cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode
>> handlers") moved the TCE hcalls from real mode to preemptible virtual
>> mode.
>>
>> The stt->iommu_tables list is RCU managed. Entries are added with
>> list_add_rcu(), removed with list_del_rcu(), and released after an RCU
>> grace period with call_rcu().
>>
>> However, kvmppc_h_put_tce(), kvmppc_h_put_tce_indirect(), and
>> kvmppc_h_stuff_tce() traverse iommu_tables using
>> list_for_each_entry_lockless() without an RCU read-side critical
>> section.
>>
>> A concurrent IOMMU table detach can therefore remove an entry while a
>> TCE hcall is traversing or using it, without the traversal preventing
>> the entry from being reclaimed.
>>
>> Use list_for_each_entry_rcu() under rcu_read_lock() for these walks so
>> that an entry removed concurrently is not reclaimed until the reader
>> has completed.
>>
>> Fixes: cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode handlers")
> 
> I am not sure if this is the right fix. On doing git blame, I see the
> following patch introduced this:
> 
> 121f80ba ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO") - Alexey Kardashevskiy
> 
Regarding the Fixes: tag, thanks for pointing this out. I will re-check 
the history around 121f80ba ("KVM: PPC: VFIO: Add in-kernel acceleration 
for VFIO") and update the commit message/Fixes tag accordingly, since 
that appears to be where the lockless iommu_tables traversal was 
originally introduced rather than cad32d9d42e8.
> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/kvm/book3s_64_vio.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> 
> Sashiko pointed out few more bugs around this path:
> 
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] kvm: ppc: UAF of spapr_tce_table due to missing rcu_read_lock()
> - [High] kvmppc_clear_tce: pinned memory leak on partial IOMMU map failure
> 
> So, even though these looks to be pre-existing bugs - do you think we
> can address them in a single patch series itself? This will reduce your
> testing/validation as well?
> Also since we are anyway fixing RCU specific bugs in patch-1, so I think
> we can also fix rcu handling for stt as well?
> 
> Do you mind working on v2 and addressing Sashiko review comments please?
Yes, I will address the Sashiko findings in the next version. I will 
include the stt lifetime/RCU handling along with the existing 
stt->iommu_tables RCU fix, and handle the partial IOMMU map 
failure/pinned-memory leak as part of the same series.

I'll rework this as v2 addressing these points.
> 
> -ritesh
> 
> 

