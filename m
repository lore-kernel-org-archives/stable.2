Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979A200110;
	Tue,  6 Oct 2026 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255710; cv=none; b=ejlqQauPmTR4XvoYg0mHFQhtwg0EVDXadomSGdV2QjuxleUuaRNsEFVNkrAk2vCBcfFHJirw18YDu9NU3RUkLvb13YRiOVEOc6CFQZBP2yfzgraHmA5Nn7Qdd57rHYCGH6vxae2CkY4iOCyWGqj4hmSdzrjWeDKHFcNiQgfC6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255710; c=relaxed/simple;
	bh=m5SyOHIJyMwFHb8xT4+gt6YEqPnkqGNLeNi4h3h8SoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ESm8FMrYh5Nb/zMzWFF5d8z3hbEkx3HbE1yxhrRZi/6SwC6U1q0bQuM19lN4qXUTdpsFnuTqE2YTK16xawmuHduKV1mwmeDnCZ8qime90jZJPB75ZKuTsWnLgA4OOHUkb8UYX7JkXvuD3nXAbSpnnczOvF0LvmEJJCvtxMF2FTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nPE0VVHH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nPE0VVHH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695Haejv3660244;
	Tue, 6 Oct 2026 03:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3tHCZi
	0tNdUGxWfesBbWABUFMFRLzDxwYBg9AIa/Ec0=; b=nPE0VVHH+E0I+PE8ASqXLv
	H9hbiVJXqpzFIfgw2X9Iw/PHJEyGm594qVueleo4dHeKkf6kz5oh1lxxFgO4aCvB
	6eZ3CbhmZWGREfLb706sRDTKJ1G4f6GEuwetBc2qLD7ocjKq5eOFuf97OtGyLi3C
	h5ZBrmAH6jmzFe6BAlDboCWaYP9yzwjcazvetDctENv5WArkajgZo/tIHb+82iSB
	FkLnTCBJI4UjIsbAPDEsAJbwCg83rKxemNhPyO5VXc9HOs7HCTqxrAeb4aJ+ydyQ
	570L6jhOyZRXkN++JabuAKT1wElXFc0kB30Idseuf3TSaLmLdxOZ52bWmAxs2oTQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrdmg2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 03:01:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695LpI3k3280960;
	Tue, 6 Oct 2026 03:01:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgr37s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 03:01:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69631QTc42402184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 03:01:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0958220040;
	Tue,  6 Oct 2026 03:01:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 597352004B;
	Tue,  6 Oct 2026 03:01:22 +0000 (GMT)
Received: from [9.124.213.110] (unknown [9.124.213.110])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 03:01:22 +0000 (GMT)
Message-ID: <ad91f624-ea6f-441f-995e-14fd4fd30ebe@linux.ibm.com>
Date: Tue, 6 Oct 2026 08:31:21 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around
 virtual-mode HPTE bit-lock users
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
References: <20260930173750.56759-1-amachhiw@linux.ibm.com>
 <20260930173750.56759-3-amachhiw@linux.ibm.com>
 <fb954b17-c3b9-49f0-a7d4-8e0f7fc0e404@linux.ibm.com>
 <20261005234024.20213ac7-78-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261005234024.20213ac7-78-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAxMCBTYWx0ZWRfXzIrFcDKLio3b
 BtZ3WnKhtuvm4VaRvPi6Wie5XaRznTT0C4ZrSYmlw1BjODD35oz20abNC73QeQWl1IBs/CWJMnk
 5b0YZPPYStB/RzoQ8VwlZWtQOSb0RWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAxMCBTYWx0ZWRfX7p5qNES/zKzv
 auvGdkZCWOjqQCSx34p89Er0CvI62GP34su8OZu2VPgudAljoZq9sqeiVYPIZxJ3AbYM8MrReAJ
 yJJp16O9X7Rzf7lcoIHbPU2Q9da3TbDu0qfEINzCm3TdMFB6Tsj4pP3DK/xTpdeufvBdxBIdTen
 8HponTRZ7OMfaNH5MW8at3yjVNt4rkmrhJql4KllBziT9vgQjL7cnKhte7heobTQ7BucybLMUtU
 JcPwTyDxnCmstPqd41G3M70OFyR/3ngHSzlKRmAzu0+ke9G/COTEflkymfaPmQ7ND2sqlBmbtLy
 8DmytLwXu8US63695zTOLUB0JraY2LrKjWvBVtRR7MynX5AIS/65CxDvL3lG4/3lTSSxkVz3r54
 OFEwlLK942v/3mkF5WOCU6xGzVo1kZz67bA/TqaBdGFqOB2ywtCQYImF4QxCk/72+DoASp7c8G+
 BBmtKXBnlYZwXCld5PA==
X-Proofpoint-GUID: 3OSaq9WWDPw38Y2gOSJIk5gwPyhZqYCz
X-Proofpoint-ORIG-GUID: qeSoUgWU6eepVwJoT9V5pStS7Vlo_yhX
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac4648b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=anADAJyGIn8O9P3fJOYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060010



On 10/5/26 11:57 PM, Amit Machhiwal wrote:
> Hi Shrikanth,
> 
> Thanks for the review.  Please find my responses inline below.
> 

>> I don't like this sprinkling of preempt disable/enable.
>> Is there not a way to embedd this in try_lock_hpte/unlock_hpte?
> 
> I understand the scattering of preempt_disable()/preempt_enable() looks ugly.
> But there are two blockers for that approach:
> 
> 1. The real-mode hcall dispatch table (hcall_real_table in
>     book3s_hv_rmhandlers.S) calls kvmppc_h_enter(), kvmppc_h_remove(),
>     kvmppc_h_bulk_remove() and others in book3s_hv_rm_mmu.c, which all call
>     try_lock_hpte() from real mode.  Adding preempt_disable() inside
>     try_lock_hpte() would affect those real-mode callers, which brings us to your
>     second point.
> 

Fair enough.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

