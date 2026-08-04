Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E123D88EC
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848123; cv=none; b=a1X+hpn3nJxnEJ8Lj0LorSJMaDiliI3Wh0Y60eGyYGld6Aq9U8nCTYD8/stUCJhh1EC7Ziw/wqb4Z35R2MNuyzVRQJ/abSHkvbaEFyrnPUKyve5LP1z8FGLLphW60BKpYuUWD5DQ8Vg4DP9jfqV7k5cynXb2fzRrT/jXVS+ozoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848123; c=relaxed/simple;
	bh=zCZZePGb0WoyS18toDDsnewWPzKP+uLwNrc5sJH4l5w=;
	h=Cc:References:From:Subject:Date:Content-Type:Message-Id:
	 Mime-Version:To:In-Reply-To; b=pClba8MQxy5EVDpnokdHzF9Djf25hdllgJ3RWrhFymNFqof6FrU84gw73adItfpBwqy4NEiukRs4lLe6QjlEB05cu8rabnYkvCYUXP4VHfUjRzOwbI/LTqNtEsT7opDE2FrNQESpPcdVr4ztGQxK7v+7IoxR9qePbMmqyXejUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GA7+9fwr; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GA7+9fwr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785848116; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rwqeOfz4nMAWC52VIPRe5Z4fyDbUmW2QxMJZ/Ka4LeY=;
 b=GA7+9fwrUnJg2kpPOE7xTI82yvd73CDCdiDlLVCBfnoKt8FU+mnEGYwVKS0kWtdUR1Vitd
 1W/rT+BKDqwTZVzykJjGbhr5ppYXD7sonPT8OBXEL/h434aaupP8rkEzyVUVpfLfwB1CIr
 L0vQKXX6RN7JFb2Q2eea4rwH2W+vkd0ZL6wxG+ulDRNB1irN511+VwM481QF9L/LeBf6p+
 7goyDWCVyzuN9j9roX6COx0li4LevBa7PdiHTGMJeoxtGf8qMWAxxq3ZLPjVkv3uYPD6aX
 RSGVgBXiv/Wf0Oi1JSZQ8iaLNM6Y8VOuGTFFKMymuUniFRn0XXRQwA598WebgA==
Cc: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>, 
	<sshegde@linux.ibm.com>, <jgross@suse.com>, <wangyang.guo@intel.com>, 
	<seanjc@google.com>, <pasha.tatashin@oracle.com>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260804071128.31022-1-libo.gcs85@bytedance.com> <20260804072240.GK687043@noisy.programming.kicks-ass.net>
X-Original-From: Bo Li <libo.gcs85@bytedance.com>
From: "Bo Li" <libo.gcs85@bytedance.com>
Subject: Re: [PATCH] x86/tsc: Fix misplaced seqcount_latch_init() in cyc2ns_init_secondary_cpus()
Date: Tue, 4 Aug 2026 20:54:53 +0800
Content-Type: text/plain; charset=UTF-8
Message-Id: <e8ee32c4-9b2d-468d-b829-847e6e65ab58@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a71e132+63819b+vger.kernel.org+libo.gcs85@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "Peter Zijlstra" <peterz@infradead.org>
In-Reply-To: <20260804072240.GK687043@noisy.programming.kicks-ass.net>
User-Agent: Mozilla Thunderbird

On 8/4/26 3:22 PM, Peter Zijlstra wrote:
> On Tue, Aug 04, 2026 at 03:11:28PM +0800, Bo Li wrote:
>> In cyc2ns_init_secondary_cpus(), seqcount_latch_init(&c2n->seq) is
>> called _before_ c2n is advanced to the next CPU via per_cpu_ptr().
>> As a result:
>>
>>   1. On the first iteration, c2n still points at the BSP's struct, so
>>      the BSP's seqcount_latch is re-initialized. cyc2ns_init_boot_cpu()
>>      already did this correctly, so it happens to work by accident
>>      because no concurrent readers are live at __init time.
>>
>>   2. On subsequent iterations, seqcount_latch_init() initializes the
>>      previous CPU's seqcount (because c2n was advanced by the prior
>>      per_cpu_ptr()), so all CPUs except the last one in the for_each
>>      loop happen to get initialized. The last secondary CPU's seqcount
>>      is left uninitialized.
>>
>> Move seqcount_latch_init() _after_ c2n is pointed at the target CPU's
>> struct, so each secondary CPU's seqcount is correctly initialized.
>>
>> Fixes: e2a9ca29b5ed ("x86/tsc: Initialize cyc2ns when tsc frequency is determined")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
>> ---
>>   arch/x86/kernel/tsc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> index ce10ae4b298b..84fb80492b01 100644
>> --- a/arch/x86/kernel/tsc.c
>> +++ b/arch/x86/kernel/tsc.c
>> @@ -223,8 +223,8 @@ static void __init cyc2ns_init_secondary_cpus(void)
>>   
>>   	for_each_possible_cpu(cpu) {
>>   		if (cpu != this_cpu) {
>> -			seqcount_latch_init(&c2n->seq);
>>   			c2n = per_cpu_ptr(&cyc2ns, cpu);
>> +			seqcount_latch_init(&c2n->seq);
>>   			c2n->data[0] = data[0];
>>   			c2n->data[1] = data[1];
>>   		}
> 
> No, this looks wrong. Note that per the 'cpu != this_cpu' there are only
> N-1 invocations. One CPU will not be initialized. Further note the name
> of this function, and the name of the function above it.
> 

Agreed - the loop is N-1 and deliberately skips this_cpu, which is
initialized by cyc2ns_init_boot_cpu(). That CPU is not my concern.
Sorry, my changelog was unclear. The issue is an off-by-one in the
existing code: seqcount_latch_init(&c2n->seq) runs before c2n is
advanced to the target CPU, so each iteration initializes the seqcount
of the previous c2n rather than the current one:

	c2n = this_cpu_ptr(&cyc2ns);		/* c2n -> boot cpu */
	for_each_possible_cpu(cpu) {
		if (cpu != this_cpu) {
			seqcount_latch_init(&c2n->seq);   /* inits the previous c2n */
			c2n = per_cpu_ptr(&cyc2ns, cpu);  /* only now advanced */
			...
		}
	}

Concretely, with this_cpu=0 and possible cpus {0,1,2,3}:
	cpu=1: inits cpu0 (boot, already done by cyc2ns_init_boot_cpu())
	cpu=2: inits cpu1
	cpu=3: inits cpu2
	=> cpu3, the last secondary, is never initialized, while boot is
	   redundantly re-initialized.

Moving seqcount_latch_init() after per_cpu_ptr() makes each secondary
initialize its own seqcount.
