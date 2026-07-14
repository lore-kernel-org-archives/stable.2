Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3A3EE1F2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021707; cv=none; b=szGA5b54fQyQUv9cPvWpJAg72UAF2WP8OBIxDrWUsSsjSD6yWYgIB/9IFhOjfHALx/BOP0els32cO9f8ugQEbJRCuclObXgfsPvda2KOiinfk7UJQaocFPO74m3lNQ+Dkxz9BCHT5a4G+NxbFGJrs6ueACxhu2+PJ8aGTKDlX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021707; c=relaxed/simple;
	bh=XM92JNOSdj3ojRIKBMMYaaElVGPDddS9HZgAe+hXh1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3PS51kpCNfLPjw3hi/bAhRxqXzWLrSkSlwjqkNzVVqM8WGlrptZFltw5BeXPdXEEMQjDf9mhNxCMQkc3Pw2CkfltqDYIjg54ta50YeMeVlsOY7B5l50WkwlYnTAMmvNcPDxq14Qys+vcAaOiF2SaA26Z4NTA2L5jnXL8fyDuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jbdJEVsw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jbdJEVsw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636A32F;
	Tue, 14 Jul 2026 02:35:01 -0700 (PDT)
Received: from [10.1.34.162] (e121487-lin.cambridge.arm.com [10.1.34.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4913D3F93E;
	Tue, 14 Jul 2026 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784021705; bh=XM92JNOSdj3ojRIKBMMYaaElVGPDddS9HZgAe+hXh1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jbdJEVswRCgfjDqjKMQ1tBdBT4UJGWKOK2gb5TGJuXBdmxH+vQqs4p9eU1jMpIvp/
	 uyETnuUvAq37LE0JEh0f2TruzitCqNNHjvQ76zflxgRBInYYODrMV9otjKMFxe7LZb
	 WcVDVfpUhwqP+Q7qaUTpVaGTKx2SjzVLYdcBeIOY=
Message-ID: <8ffe2df2-90c2-45a1-ace2-185ef1f4e011@arm.com>
Date: Tue, 14 Jul 2026 10:35:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/36] arm64: hibernate: mask DAIF before restoring
 hibernated kernel
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
 catalin.marinas@arm.com, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
 stable@vger.kernel.org
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
 <20260709121333.23507-4-vladimir.murzin@arm.com>
 <68e740e3-5fa6-4ab7-92f1-3f570fc07801@huawei.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <68e740e3-5fa6-4ab7-92f1-3f570fc07801@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 04:00, Jinjie Ruan wrote:
>> @ -465,9 +466,21 @@ int __nocfi swsusp_arch_resume(void)
>>  	if (el2_reset_needed())
>>  		__hyp_set_vectors(el2_vectors);
>>  
>> +	/*
>> +	 * It is necessary to mask all DAIF exceptions here as:
>> +	 *
>> +	 * - The copy of swsusp_arch_suspend_exit() in the hibernation
>> +	 *   text cannot handle taking any exceptions.
>> +	 *
>> +	 * - The suspended kernel masked all DAIF exceptions in
>> +	 *   swsusp_arch_resume(), and expects to be re-entered in the
>> +	 *   same state : with all DAIF exceptions masked.
>> +	 */
>> +	flags = local_daif_save();
>>  	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
>>  		       resume_hdr.reenter_kernel, restore_pblist,
>>  		       resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
> hibernate_exit() is a noreturn function, the following
> local_daif_restore() will not be called.

Agree. I'll fix that in the next iteration.

Cheers
Vladimir

