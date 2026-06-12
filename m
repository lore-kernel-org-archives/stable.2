Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC636655C
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258595; cv=none; b=MuU6tRUMyILGFQeaV8Q9Dq+yBGTfvs4/wvoQRwWGnKCQAp3BGFi2uNweDvZVFkzi4jyRberowEt94Pvt71JJr4XWScVCjbZJRGRsjFXNPrZ318SCEV3+hM8vlRbjdGr+wfX4OqlUZEbhaR4LuSdYMDeyx6r8e4zW/YzVJKS496g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258595; c=relaxed/simple;
	bh=0yrafDVcULGuJ+p32++9h3XBfV2fGveLtQVYUeAl/hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9XIgxDRR5bVMbP5gL5NilkFrAQjWWQfbyOJrgg24iCzG4bLKf1Etn3Dlr9nfzA7rFpJ1FOg5QfxqdTcz2dcEoeumjp1H2/wSCkqCnKjq+T/7BLO6+1ib1lCIs6dR4VsC9LWCu4Dc9qkulH2SCdNenwjAvW0d156E5ZjRGprIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PrBmkzdM; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PrBmkzdM"
Message-ID: <789fd34a-d051-4f98-bd66-e3d99ec2dbb1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781258581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Poeb9yf4WL1lYck6yIFXdvkqTfewiVeXZlw+VpIeehc=;
	b=PrBmkzdMeTnAHXnPxV/v/J3cOg80ufxPytqgJ5eLgK1zJiZ4EGyTEwt2A4zLRfYy4G1v7l
	nmNNEiwR8zxtPZifegX5s1qzMNJaracP1273ncJHrfFjmX7L56tI+bHj/P9HE6A+/Juv4G
	qF+Q2FaiCh1yP+muN9vcny6Hj50JFgE=
Date: Fri, 12 Jun 2026 11:02:58 +0100
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260612094520.GA42921@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/06/2026 10:45, Peter Zijlstra wrote:
> On Fri, Jun 12, 2026 at 02:40:42AM -0700, Usama Arif wrote:
> 
>> +static __always_inline void blk_plug_invalidate_ts(void)
>>  {
>> +	if (unlikely(current->flags & PF_BLOCK_TS)) {
>> +		struct blk_plug *plug = current->plug;
>>  
>> +		if (plug)
>> +			plug->cur_ktime = 0;
>> +		current->flags &= ~PF_BLOCK_TS;
>> +	}
>>  }
> 
> If you can guarantee PF_BLOCK_TS is only ever set when current->plug,
> this can be reduced further.

Thanks for the reviews!

The invariant holds at set time (the only set in blk_time_get_ns() is
gated by if (!plug)) and through the only legitimate plug clear in
blk_finish_plug() (which goes through __blk_flush_plug() that clears
PF_BLOCK_TS first).

However, copy_process() sets p->plug = NULL for the child but doesn't
strip PF_BLOCK_TS from the inherited flags.

I think the if(plug) is a good defensive check, but can also do the below
if you prefer?

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1c1fd31ce187..c285a4d9837d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1219,10 +1219,7 @@ static inline void blk_flush_plug(struct blk_plug *plug, bool async)
 static __always_inline void blk_plug_invalidate_ts(void)
 {
        if (unlikely(current->flags & PF_BLOCK_TS)) {
-               struct blk_plug *plug = current->plug;
-
-               if (plug)
-                       plug->cur_ktime = 0;
+               current->plug->cur_ktime = 0;
                current->flags &= ~PF_BLOCK_TS;
        }
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 892a95214c54..9a062149e0d8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2167,7 +2167,8 @@ __latent_entropy struct task_struct *copy_process(
                goto bad_fork_cleanup_count;
 
        delayacct_tsk_init(p);  /* Must remain after dup_task_struct() */
-       p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
+       p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY |
+                     PF_BLOCK_TS);
        p->flags |= PF_FORKNOEXEC;
        INIT_LIST_HEAD(&p->children);
        INIT_LIST_HEAD(&p->sibling);
