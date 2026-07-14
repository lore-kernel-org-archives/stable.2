Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6F3DA5CC
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784012032; cv=none; b=skJO9jqxvZbIYcsUBOl4+myX9jN8zOuQjplbxeJFoYAVQqsjFwiupZBARGmtAiOJA3aRshVrbAukk9kM8KCHDwWkVoM0/Z1DP/OOIB3q54nSJU3C77YxQTZ3WFZkS+tTFRSk7IkwxoBDLZmiEF5M7F06PVjN4cb2d5S2yNTHnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784012032; c=relaxed/simple;
	bh=AO2GKLxoJTgpQfU1vWe3+H8/TP6Z5a4pNwhackVaAA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B51TP7vmwxTLnyFJ9P9D1XTXF6d7umELPi+6gZo00LEn1FjcXhu/Zt4NWvBXa72g6tE9lllrpxL6rJkXCULd5ZTlaSv+RB0kcYHWYE8tQcYarSo2gI6NB+lbTiyh397aHkaTY5cwgIrXESEdaw1sjE+e69G1hzuuuvadmYwvXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIi5d5nD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIi5d5nD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38511175ad3so3171594a91.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 23:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784012030; x=1784616830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBDDx+WXyO2HmFvYUM/Py6bFxHFJnp362DYMS0SOtOA=;
        b=HIi5d5nDz+h9OTayqRDg7KZ7UFmnDftn3PChHwV/CmBqEjHif6EvJrzsrTIStHL1m9
         UYO+4LJupU+qXAeAU3/eyltLxUBEbrs2NpCC3a84djXXtfIgZQYtW+a8yarQFY5dZ90B
         5caNKyLOD+KoM7OFVunsOUQtO6pGGKiLWdc7vU6L54vXQY+OLQtSQLWv7TKNgkOydBY0
         z3oRJwTxX5R0Q4HkVESCe5qlS/KibFrv3hOIW8ZqRkShm2CVJg2gYjn3CKKJzelktuTe
         gUiu1bfkM3oM6SPN6NDwRTfDOaiyWoagkHqPS1RHOoE9/CDL9PGkzrKV8zVKlF1BO3fX
         pbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784012030; x=1784616830;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VBDDx+WXyO2HmFvYUM/Py6bFxHFJnp362DYMS0SOtOA=;
        b=QAqKRVo+Qv032urQCCNf4W7/sie5iN0xFjrLt/KFPJgl/8alXbcRFT/hNCKwc0m6fx
         MVnk5pS74BAawy/IgU0Mg4PkhKzHBn44Cntl7E2vFyKqxCNg38upKzIj4nQT7dnKnpex
         TMPe8IhMi6j439cXUGlZN+KGgdsVeForXYYxzVgaLygYmBcronGesMNWDcTBq55SjM0j
         ql1/Mx2CHumPc1bS4X3i0fjQUNmmczoxfDuSDZC96DyTOmmTmW611VelKsXs50lgHRfX
         bJoPev6qfjgH3j8xvawAUaXyuzYN1ffo8XgtdjyqNt5tG/uVEoOluIQfQ9gptCPS8afL
         6Zvg==
X-Forwarded-Encrypted: i=1; AHgh+Rr69PHAGO6YFfbjVmqhJ5tQ5cT98Tc3tUPiP7VeFR5xUvI86xoLFal3o6HVoKnKhRKxIF2DYFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNp4NmQnBNPTAa3tmTFxFT7etQJIGjZ+HTQuDb1L/pMREgsYaT
	4DmrKASY1Tx3T1jHeOQ2649cYaQ5ygzDSpxEawvGmhmTYzKl4Dz8lFky
X-Gm-Gg: AfdE7cnf5SpI30jKL0e8COuoyM6qtduF9WR3u/tJ2H6wtG3SZ3opwTRZzNpf6A2BtMd
	mF+Yy+bOg44knSCv2bfU74es72bdWwgQLnbYjnX5Zf5LNCT6jJ2/N4wPhvoLoAQYM7udFjzJ1sS
	KMtqeiiTkvT/JAkp/CIBCksGCokHz2JblUUwsMRWPSENK1xW/FcUYlpPvkT8CTEdbIKyguZJYy2
	PR2N1RPgbgXSG0hdV1/mt+ZVnPXWbFH3BEbymwajNsXM3vwp0K4zlYFmqjd0FyGIgu6O7eG0fLz
	3JBKXM2Fqi46jv5f10xvSRi68xWhnbtQkppoAJQ81H3cFazmhfh2BRID0kGjmaYzKcZUHcunndE
	dN/hzTMo9NannNVhvyBeUm7XWuXT0jSdkA4APISre+NrFv+Fmli17+OP5kizcUmynIhOlGUO4fI
	xTVgQf4NwelUc5tlXj+CTh81bBm3M9NeqT
X-Received: by 2002:a17:90b:4a:b0:388:cf45:d72c with SMTP id 98e67ed59e1d1-38e1aedd604mr1302508a91.15.1784012030007;
        Mon, 13 Jul 2026 23:53:50 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38d352b0f37sm2616758a91.1.2026.07.13.23.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:53:49 -0700 (PDT)
Message-ID: <7bb69013-c6f1-4dee-bb9c-c576c7b765d7@gmail.com>
Date: Tue, 14 Jul 2026 14:53:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] jbd2: bound shrinker scans by examined checkpoint
 buffers
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, jack@suse.com,
 tytso@mit.edu, stable@vger.kernel.org
References: <20260713102229.1598812-1-max.kellermann@ionos.com>
 <20260713102229.1598812-3-max.kellermann@ionos.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260713102229.1598812-3-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/13/2026 6:22 PM, Max Kellermann wrote:
> The jbd2 shrinker currently accounts only checkpoint buffers that it
> successfully releases against nr_to_scan.  Busy buffers therefore do not
> consume the scan budget.
> 
> If a checkpoint transaction contains mostly busy buffers, the shrinker
> can scan its entire checkpoint list while holding journal->j_list_lock.
> Large checkpoint lists can result in excessive lock hold times and leave
> other CPUs spinning on j_list_lock, causing soft lockups or RCU stalls.
> 
> Pass nr_to_scan into journal_shrink_one_cp_list() and decrement it for
> every buffer examined, including busy buffers.  Pass NULL from checkpoint
> cleanup paths so their existing full-list behavior is preserved.
> 
> This restores the scan-budget semantics that existed before
> journal_shrink_one_cp_list() was changed to always scan a complete
> checkpoint list.
> 
> Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

This makes the semantic of nr_to_scan more clear.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/jbd2/checkpoint.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 5266017565ac..513273712010 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -358,15 +358,16 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>   /*
>    * journal_shrink_one_cp_list
>    *
> - * Find all the written-back checkpoint buffers in the given list
> - * and try to release them. If the whole transaction is released, set
> - * the 'released' parameter. Return the number of released checkpointed
> - * buffers.
> + * Find written-back checkpoint buffers in the given list and try to release
> + * them. If 'nr_to_scan' is set, scan at most that many buffers. If the whole
> + * transaction is released, set the 'released' parameter. Return the number of
> + * released checkpointed buffers.
>    *
>    * Called with j_list_lock held.
>    */
>   static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>   						enum jbd2_shrink_type type,
> +						unsigned long *nr_to_scan,
>   						bool *released)
>   {
>   	struct journal_head *last_jh;
> @@ -375,13 +376,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>   	int ret;
>   
>   	*released = false;
> -	if (!jh)
> +	if (!jh || (nr_to_scan && !*nr_to_scan))
>   		return 0;
>   
>   	last_jh = jh->b_cpprev;
>   	do {
>   		jh = next_jh;
>   		next_jh = jh->b_cpnext;
> +		if (nr_to_scan)
> +			(*nr_to_scan)--;
>   
>   		if (type == JBD2_SHRINK_DESTROY) {
>   			ret = __jbd2_journal_remove_checkpoint(jh);
> @@ -403,7 +406,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>   next:
>   		if (need_resched())
>   			break;
> -	} while (jh != last_jh);
> +	} while (jh != last_jh && (!nr_to_scan || *nr_to_scan));
>   
>   	return nr_freed;
>   }
> @@ -425,7 +428,6 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>   	tid_t first_tid = 0, last_tid = 0, next_tid = 0;
>   	tid_t tid = 0;
>   	unsigned long nr_freed = 0;
> -	unsigned long freed;
>   	bool first_set = false;
>   
>   again:
> @@ -458,10 +460,9 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>   		next_transaction = transaction->t_cpnext;
>   		tid = transaction->t_tid;
>   
> -		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> -						   JBD2_SHRINK_BUSY_SKIP, &released);
> -		nr_freed += freed;
> -		(*nr_to_scan) -= min(*nr_to_scan, freed);
> +		nr_freed += journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> +						       JBD2_SHRINK_BUSY_SKIP,
> +						       nr_to_scan, &released);
>   		if (*nr_to_scan == 0)
>   			break;
>   		if (need_resched() || spin_needbreak(&journal->j_list_lock))
> @@ -517,7 +518,7 @@ void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
>   		transaction = next_transaction;
>   		next_transaction = transaction->t_cpnext;
>   		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
> -					   type, &released);
> +					   type, NULL, &released);
>   		/*
>   		 * This function only frees up some memory if possible so we
>   		 * dont have an obligation to finish processing. Bail out if

