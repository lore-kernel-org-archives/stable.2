Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.40.203.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742431;
	b=405ISGwJLP5vyuqLybqhKPD2A7ICWxoK9Diss7cHpPGrqjHkEiQvMoLcD7TOgaoHqN52
	 ctr62OksWcNHRrXpz8+1+QMT09Rw7uuv+p56RI08MtJxQKm8r8mi4fJ/wiKqCYnvUrdBW
	 3k3kymi6QuDAYixOCjgCWrs1ooMELtzfr7xQjGZijSzR7hH9bGoP+um3ZO9KlItI4UBth
	 Lpl8jRQShPQ3fsi0tWvXSScssBUG2Nb4LxJUCBGiQMtDjevPPMiAZIknoHDk0To6fYuyJ
	 NxO2m793tQ0EmJLt4hv7oG2P6WcIvl0qlt8bmvDoLt5qt57sPFfb4OnGTKXUN91ghDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742431;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 Sender;
	bh=6ewGmAlFYwsNDKvJWEZID5X9+tdMRDfrjURgzdEaZTs=;
	b=hB3yHfjVBlPO9k6U3+29yUw3uDvh9bPFBRSSgE1Rclys8c2yiPZaUqOIVivAp7ClZFwH
	 nA72ujpxL/XN7G7UepYXGDFiRv/HRKbCsNXLde+ypzt2H7wiDB7BcKssxkwR2p8qPuZPE
	 2zCwQkJfSvbbABc9nJka6wLMDONbeBEZiK8fqjXxGw7bqZQCFO+N6pE3ONRBciSJhodKt
	 erkHt5Y6kvwvEAwTjohqotmswfrhrevaLVGrO3IWWB62aouGGgdXDfnN2mz5elHnQaXEq
	 ZO4MUMOP/cw47nKInWkF3e0goMmTEJiKs21S3/whP1AV+nbvKcGInAhGwgpATm/Jz9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codethink.co.uk;
	spf=pass smtp.mailfrom=codethink.co.uk;
	dkim=pass header.d=codethink.co.uk header.i=@codethink.co.uk header.a=rsa-sha256 header.s=imap4-20230908 header.b=aLp7+vXu;
	arc=none smtp.remote-ip=188.40.203.114
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C628606A320;
	Fri, 23 Oct 2026 08:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C628606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codethink.co.uk header.i=@codethink.co.uk header.a=rsa-sha256 header.s=imap4-20230908 header.b=aLp7+vXu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=6ewGmAlFYwsNDKvJWEZID5X9+tdMRDfrjURgzdEaZTs=; b=aLp7+vXuIfkGnsz9
	StFobNKifmcZc13DIr1yqvsHN11UaNjXGlCY9384GSy3nYOqxvqN/R/OrLNBWTxW7rQVRxGahj3cu
	cPg2qLDtF3aQBPsOHAld6+dFggk/dW5vOz8Dhmp125oFH3BDUZdAn61EYMlNb4lUVfDKQPWfjg4DJ
	oFTheX5fBhkoVg/bHgfrbo2xaxeoFs98VCkNtZAxXyQ7Rms3nEuP1IsZvXsDBr9EJf/V2j+OFzIGa
	iHBpc/tx2dD+wtUeUsy6Wx6hVHFD+lA0Qy/VaaYN13xsNb+LdJxfOQwfSHi9qrxMaPpf7oaacpmbL
	eweJmgWtHtjUZLDPhg==;
Received: from [167.98.27.226] (helo=[10.35.224.5])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1xKABh-00CJU2-RC; Fri, 23 Oct 2026 08:59:41 +0100
Message-ID: <4382d639-62ba-40ea-88f5-ff5242b79ebf@codethink.co.uk>
Date: Fri, 23 Oct 2026 08:59:39 +0100
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
Subject: Re: [PATCH] riscv: Fix SR_SUM leakage across context switches
To: Andy Chiu <tchiu@tenstorrent.com>, Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 zong.li@sifive.com, wangruikang@iscas.ac.cn, debug@rivosinc.com,
 qirui.001@bytedance.com, guoziyi114@gmail.com, samuel.holland@sifive.com,
 cyrilbur@tenstorrent.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261022083212.84721-1-cuiyunhui@bytedance.com>
 <atqL1ScMLUg2bM_E@Tao-Chiu's-Mac>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <atqL1ScMLUg2bM_E@Tao-Chiu's-Mac>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 22/10/2026 23:19, Andy Chiu wrote:
> Hi Yunhui,
> 
> On Thu, Oct 22, 2026 at 04:32:12PM +0800, Yunhui Cui wrote:
>> __switch_to() saves the sstatus value of prev and restores the SR_SUM bit
>> of next with csrs. However, csrs only sets bits. If prev has SR_SUM set
>> and next has SR_SUM clear in its saved state, the old SR_SUM bit remains
>> set in sstatus.
>>
>> This lets next run with user memory access enabled even though its saved
>> SR_SUM state is clear.
>>
>> Use csrrc to save the sstatus value of prev and clear SR_SUM from the
>> live CSR before restoring the saved SR_SUM state of next. This keeps
>> prev's SR_SUM state intact, while preventing it from leaking to next.
> 
> Do you have a way to trigger this bug on existing code or is it the cae
> where the bug could happen but we never experienced it in real life?

The original case for dealing with this was due to the user-access
macros occasionally embedding calls into the area where the SR_SUM
was set, allowing pre-emption there. We did try and fix this and as
far as I knew then it was mostly fixed by re-ordering the uaccess
macros.

> If I understand correctly, this can only happen when the user access
> routing volutarily makes a schedule() call mid-flight, or a code fogets
> to turn off SR_SUM right after an user access and has a live SR_SUM when
> calling schedule some time after. Both case should be a bug as SR_SUM
> shouldn't live in the kernel code that is not doing user access.

I'm not sure how much code does a SR_SUM enable a few different accesses
and then SR_SUM disable, but IIRC there is a possibility to do this.

> A trap-introduced context switch would interrupt a code that have SR_SUM
> set. However, since the bit is cleared at every exception entry, the
> context switch code would not see a live SR_SUM. Seeing the bit set in
> this case means something is not turning SR_SUM off properly.
> 
> I aggree that this is the better way to handle SR_SUM in a context switch
> but attaching a call trace or stating that "We have not caught this in
> real world due to ..." in the commit message would be appreciated.
> 
> Cheers,
> Andy
> 
>>
>> Fixes: 788aa64c01f1 ("riscv: save the SR_SUM status over switches")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> ---
>>   arch/riscv/kernel/entry.S | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 61b7a77166971..628b85e3915a7 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -443,15 +443,15 @@ SYM_FUNC_START(__switch_to)
>>   	REG_S s10, TASK_THREAD_S10_RA(a3)
>>   	REG_S s11, TASK_THREAD_S11_RA(a3)
>>   
>> -	/* save the user space access flag */
>> -	csrr  s0, CSR_STATUS
>> +	/* Save and clear the user space access flag. */
>> +	li    s1, SR_SUM
>> +	csrrc s0, CSR_STATUS, s1
>>   	REG_S s0, TASK_THREAD_SUM_RA(a3)
>>   
>>   	/* Save the kernel shadow call stack pointer */
>>   	scs_save_current
>>   	/* Restore context from next->thread */
>>   	REG_L s0,  TASK_THREAD_SUM_RA(a4)
>> -	li    s1,  SR_SUM
>>   	and   s0,  s0, s1
>>   	csrs  CSR_STATUS, s0
>>   	REG_L ra,  TASK_THREAD_RA_RA(a4)
>> -- 
>> 2.39.5
>>
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
