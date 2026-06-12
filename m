Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6342346AD5;
	Fri, 12 Jun 2026 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279286; cv=none; b=Np5ck5ep44rDWJodp01oE3ERnwxBerjmsTh+mG4X9aV7uTerpcBDptcP1030OI8AtnRWqBVzs/Qs92NN91rurWZb/23wEKylIdIcir+P3VUDHZ/7o/PqNNM/sYBbtGaTCsOd8E0RLj2b4lt7GI53RToNrWYsybJMe9t3fXRO8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279286; c=relaxed/simple;
	bh=6K8FSuxGS7DzQXw94cc4A6qXFrcvNSm//A+mQ5cQP2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaMnWtxL7OmV/vktnVHCAKjQk7LjS5b5l/lm7PRPCY3xm0RIGb5aNm/MNZAH890lHptAIghlaCPIF7X168+MJw6EKEY3jJ9AP0FMy2RiaBOGZ1p+Jy8m0dXz36OyRAW1K4Znl2znRkcI4g5GOmmYWMAd6MhKpCE+xGF+nRsgFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IOYvMA/w; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IOYvMA/w"
Message-ID: <e4389390-754e-4bae-9037-94e59b909167@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781279282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Fh+vjUZKoL1EKjRYhR5JmBkOdTqGqdFV3r0ymMPHps=;
	b=IOYvMA/wTuMYX5DHV9xO+WNpVgu+c5HymjLCJ87RpjAV3CV2WSgBqjA17EkhiLtAF9tTYN
	k7SciId1OIeZuLnRrLMWD/Y084uFZdDho/QwoOncz8wdKZvnZV3nwmhoDDaVaXJ4GfDS1M
	9zYa3oyFR+60wz5ME0EmJg1TVx9Nzzk=
Date: Fri, 12 Jun 2026 16:47:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] block: invalidate cached plug timestamp after task
 switch
To: Peter Zijlstra <peterz@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, bsegall@google.com,
 dietmar.eggemann@arm.com, juri.lelli@redhat.com, kprateek.nayak@amd.com,
 linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
 rostedt@goodmis.org, vincent.guittot@linaro.org, vschneid@redhat.com,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20260612094042.3350401-1-usama.arif@linux.dev>
 <20260612094520.GA42921@noisy.programming.kicks-ass.net>
 <789fd34a-d051-4f98-bd66-e3d99ec2dbb1@linux.dev>
 <20260612154022.GC42921@noisy.programming.kicks-ass.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260612154022.GC42921@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/06/2026 16:40, Peter Zijlstra wrote:
> On Fri, Jun 12, 2026 at 11:02:58AM +0100, Usama Arif wrote:
>>
>>
>> On 12/06/2026 10:45, Peter Zijlstra wrote:
>>> On Fri, Jun 12, 2026 at 02:40:42AM -0700, Usama Arif wrote:
>>>
>>>> +static __always_inline void blk_plug_invalidate_ts(void)
>>>>  {
>>>> +	if (unlikely(current->flags & PF_BLOCK_TS)) {
>>>> +		struct blk_plug *plug = current->plug;
>>>>  
>>>> +		if (plug)
>>>> +			plug->cur_ktime = 0;
>>>> +		current->flags &= ~PF_BLOCK_TS;
>>>> +	}
>>>>  }
>>>
>>> If you can guarantee PF_BLOCK_TS is only ever set when current->plug,
>>> this can be reduced further.
>>
>> Thanks for the reviews!
>>
>> The invariant holds at set time (the only set in blk_time_get_ns() is
>> gated by if (!plug)) and through the only legitimate plug clear in
>> blk_finish_plug() (which goes through __blk_flush_plug() that clears
>> PF_BLOCK_TS first).
>>
>> However, copy_process() sets p->plug = NULL for the child but doesn't
>> strip PF_BLOCK_TS from the inherited flags.
>>
>> I think the if(plug) is a good defensive check, but can also do the below
>> if you prefer?
> 
> I think that's worth the extra few lines.

ah sorry didnt understand you completely, by extra lines do you mean keep
the if(plug) or get rid of it and clear the flag in fork?

I though more about it and I think its much nicer to get rid of the if(plug)
and clear the flag in fork.
