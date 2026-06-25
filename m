Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76D1E7C18;
	Thu, 25 Jun 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396294; cv=none; b=k1MLiApVg9eoEK6Xw3mJZVswoeK6EnWr+WE9bbHt26cpwv97TOYyOgZ98BIOkjYfAXc17KR/e37dvsft0aI+dLle/33AM03Xq8fqGAqrlequ+RuOnMikWxneYhLlogfMm3PGw3kcTU7Q95R+3bmhtJJPZCICZ4NyZBnPQLyrKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396294; c=relaxed/simple;
	bh=w0yEOz2JJpNuyjZIJk7GjiLbS1xpAwH6tjZ+arjFomc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=caWMpB+Gm9Vhkqr5n36IkaMz4M94Mrnjq2Df7yJC+tr+/n7fQrzmbFhXF57E0mpJqdjOBZh27rUKDryqRkfmdI27UOapchBpM15OiJgazaSvq14MuTFg0wr9ssyRMzyRq24dnVhWNmXaFkC8qMqz/wBOsqQX2ghS4wUxbuMfVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+Z4/X3Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+Z4/X3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C671F000E9;
	Thu, 25 Jun 2026 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396292;
	bh=wdT6rQDcVONIEoFXNeng4/FokBuEy+7WhKmADDSqROo=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=A+Z4/X3ZkTXwHL2KPfDvTlJUbufQkmMwThCEDCLKrzc3my9+ilEo+HFAP9h5NDNF0
	 0S3Nh2wp79xolvwCYaOpzujaRryGSzaNISLyfWmgdZPDS8Woyq3fpTNlisSvI0A5c3
	 rKfOqcEqVnOPUoLKeDv3gaMHpErRWUCcotvofJamT2y1GK1wHcT6SB2lch8K6jJnAk
	 nlN6/PFRgTpFMhzrdrQ2edIZ017BzsILGckn/iK6KkwcMbn5vzUsNLHLWdWQBunfaB
	 CMx7snobTTvmHzETssL5ZexLzKMy3ASVay/8yT99jTb7sAcNjImmOcDnIymTZqimXM
	 KfU3lQ2jaRQOw==
Message-ID: <db3168f1-91a4-4871-a68a-cdd42b1c6ea4@kernel.org>
Date: Thu, 25 Jun 2026 16:04:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and
 later processors
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
 <56dfa6bf-1eb0-4e27-974b-03f963c5eed1@kernel.org>
 <20260616115521.79ad9699-39-amachhiw@linux.ibm.com>
 <20260625184146.6de49c63-67-amachhiw@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260625184146.6de49c63-67-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/06/2026 à 15:14, Amit Machhiwal a écrit :
> Hi Christophe,
> 
> <snip>
> 
>>>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
>>>> index 3af6c06af02f..e5853daa6a48 100644
>>>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>>>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>>>> @@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
>>>>    	if (isa >= ISA_V3_1) {
>>>>    		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
>>>>    		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
>>>> +
>>>> +		/*
>>>> +		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
>>>> +		 * Power11 and later processors. While ISA v3.1 is supported
>>>> +		 * by Power10+, this flag specifically indicates Power11+
>>>> +		 * for code that needs to distinguish between P10 and P11.
>>>> +		 */
>>>> +		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)
>>>
>>> Are we sure this test will always be correct ?
>>>
>>> For instance PVR_PA6T is higher than PVR_POWER11 allthough it is not ISA 3.1
>>>
>>> Wouldn't is be cleaner and safer to just do:
>>>
>>> 	PVR_VER(mfspr(SPRN_PVR)) == PVR_POWER11
>>
>> You're absolutely right to point out the PVR ordering concern. But PA6T
>> cannot actually reach this path because we're already gated by:
>>
>>    if (isa >= ISA_V3_1)
>>
>> and PA6T does not implement ISA v3.1.
>>
>> My rationale for using `>= PVR_POWER11` is that `CPU_FTR_P11_PVR` is
>> intended to be included for Power11 and later processors, not just
>> Power11 itself, as it identifies a CPU feature. Using `== PVR_POWER11`
>> would mean we'd need to revisit this code for every future generation.
>>
>> This approach is consistent with existing kernel code. For example, in
>> arch/powerpc/perf/hv-gpci.c:
>>
>>    /* sysinfo interface files are only available for power10 and above platforms */
>>    if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER10)
>>        add_sysinfo_interface_files();
>>
>> Also, I couldn't find any current users of `PVR_PA6T` or `PVR_BE` in the
>> kernel tree, so there doesn't appear to be a present-day ISA v3.1+
>> example where the comparison would misidentify a processor.
>>
>> Please let me know your further thoughts on this.
> 
> Just checking in — did my previous response address your concern, or do
> you have further comments?

That ok, no more comments.


Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>


