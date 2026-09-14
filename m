Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC7357D0C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401649; cv=pass; b=G2Mo9+w/9SIBO/bkinZJSvTGEKOgJvGHXA7JKp7sIyIGwk/e4/Je404Mmu76ERICbYqKuJDQ2EXzjQZ6+g1pl+MrDwcfeSC58IWXIfMinP5qvf7iaDuyHNosz3dHv8mdA1wrzhDI0n/8SgjUUfnmEH4HgvflwYE4RmUEqdyItYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401649; c=relaxed/simple;
	bh=AUHhF/E2fQxhW/g6jyemlRTJNX6eDQwBBKIp7y9MRJ0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4R7/X3qHE7xd95/8/xGVoRsmzCMYgvMDKZ3+zXw5+83lkhKj6oZ0xCPJ6RZlZV6KnzUX8zOU4kXTJ0KMWnj60IYEIp6/pnaYMOB9yU8ihKbREVlf2LaT2Dbx/4eH49KlbRKABom4ZS6mUYOE5iUNRs8LW3q7WzXUSfSmtFGUOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIHey0xC; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIHey0xC"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-857ff9fef54so26479597b3.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789401645; cv=none;
        d=google.com; s=arc-20260327;
        b=F13mM6dd/DfjBv3VuCI09KfN02wtTsExfoEP23vqX1lzcfid5mGZNWSY7eC6zuYb+V
         9i24XJE9B3CztolVFEs02YFX3+1x+Gl/TLJRxc7UHO0kuHvhwvBgEg+GidupJ4sucaKi
         e1llv6iCG34oPagpItiVfAA0fY5vetl63/PW+BNNdCFjasnOjBHySDe8NGGyJUvhoM3U
         k4OnCAdJopRmmwQbR+NbvNRY+4ar8M2zlxjWTrJX7+fg96pbwDK20DU6d/m6yJCaJkTk
         /A2k5fo6+L0Y23W8QVvYWZLcjM4w+P/qEHlKzRxGJ+v/WGKIECU4VzVdsuPtxyEl2Swp
         mVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vnhKlSBSQOh8ZFl8Jf+/YlwJHlkv+MXRYwatR7ezOHY=;
        fh=QtHC99rKSZh8QZluQVT40D9eXxFEqsgw37dbRi96BfY=;
        b=MsV1/r7B59NZo8mS/a8+CUrsVBH3mXy2k3X5WFnfrfpsq+0pwAla865Kc1W8zBsJBd
         J9ytiq3la+pK8vzq1cG5PRQq/cdUlebCx2MyNuH8kjx+h1/TCQBI4I2zi5HH5IOPvl/X
         gnMh72nn6I77wHLUFH8a/xP67QoUpyCvlTNuegZOUsJsRqBEVrIx0S4GuBkk2aVge2KV
         m+4gcKqxwOlHsN/BWxTj1BGqOXGGpvwhKD9V9/Dm7tsqUQ7Dwc0Gl8ZbhyAg0TTjqUxk
         Jagy54lyd+9aLvyUfpYxISVxKy2nf/y5HTXhwMnZsDRwyI7PMSHMriUbDyptuCDEtLkY
         Z+ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789401645; x=1790006445; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vnhKlSBSQOh8ZFl8Jf+/YlwJHlkv+MXRYwatR7ezOHY=;
        b=dIHey0xCG9zCD3Fud294ousPBx1CBm69N2UfmH9aQOT5X1fUX1LBLCMZVv9eBNwv9T
         f3PR33NmX3XkjmSK2xtWfsjSn7eKCTbJYZ70h3v+N4hVGauDZ27t39w5h2QfPOjK8Z6l
         WzFIbyH6iVBUJACXdL5RcTI4TplrDEIoS4JIaXKB9+uHdJUGqUxjzLaE8PfqL3543jXg
         EJEatK+38VLzpY5yGUmGH7+yVmJff9/WnIpm6K1mmD2h7YsusMq2j6umCEnJFAoA0v/j
         4hHVt/LQhf9yHXc1FyPsDUCZ2CY5ktNxRsUOP8TjvO/X0C+vV7jHDLSMW2Hz8spEY+lR
         AHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401645; x=1790006445;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnhKlSBSQOh8ZFl8Jf+/YlwJHlkv+MXRYwatR7ezOHY=;
        b=P6sDxj4DdSQBoTPapOvyM+AD0ljgmXtDDcLT4j8HcuTK/Uay0CjnwVWO4GGpK7JSub
         bPY/Enigs4pDyBFkxiUqrTmYXJvGoHO88BP+GWnhGxT2sPk1KyCajcfgYEQNZ2w2U4B+
         ooLKO1Mov7RA4yF6Iqbj7X3ac8CoKwUkn3ElNmnBVTVX9Xe1TtVTz4uT7nuQbP2V0xB0
         gu1m4K/tOuuuSzAY2XkgY027ADufI4loMUhSRm7VAJ5j2woKmgy+LsmyoQABSiobsi89
         EoMqpDBa0nXMTDEMcRkuhkylHL9SlLx+jlGywjwS5NiXFvVzCD3N+TPjpRbyOplwNtG1
         k73g==
X-Forwarded-Encrypted: i=1; AKwUvBym+oDMrxvpS48MyjvSz2AdS5hd93jQ/d5/j1k5DBhfHzrtbrTpkgt8Zbo+qHOBIGBWFXZb4HI=@vger.kernel.org
X-Gm-Message-State: AFuF++llEFNol/NEyBpyErOzPRg0NsMwel/Ne0m7+vhPvL+bIlgfFSi6
	o4ssstlE+mliL00Rxbrq4SrWR1ddwKxrNYy6aVFdM8oqTMGxlTxujpY8xMokz1PxAZ0Dfr2J41b
	PgLOZq9KSKJTQAHzy5kOib4Vp8zs7O/yKaw7D6w0B
X-Gm-Gg: AYBFou0JdsgQfChQ/JCFDYeH2iNN0/lGi0IX9j4GT6hvhwCHs8S7lVWmWRlvblFXWfU
	wwJKWHEBHW3r2YjOR4+bWSKWBeHHNRxXnmHsxvDfflzpf6X/PZLJTMi9aPfNy4zOSpPUr/l8CdR
	HQ++UEwFn7f5vml5va9XbKM1MVw7+1jwIGtay2fH0vLb2aYuzGY5bXJJLklFIzO8+V1mQrxXjtD
	FzcvImeuh/u6fDUdot9Ei+Vrh0h61K5bJxOB/zsfZ154rYt+0Xwcab6O4lU68wTRGC4buNCYkcC
	pIQN72rUmJckOGqRt34vuLCrNB7+JbRq6YBqiLtysSWRGrzkKJkUIWp35y4NA3wnLf+mIESvYUt
	RvktJsKjGYw3aDr+3N/no
X-Received: by 2002:a05:690c:7483:b0:85b:946f:129e with SMTP id
 00721157ae682-88d21832f4cmr13001707b3.33.1789401644112; Mon, 14 Sep 2026
 09:00:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 09:00:43 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Sep 2026 09:00:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260911143726.3689114-1-joshua.hahnjy@gmail.com>
References: <20260911143726.3689114-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 09:00:43 -0700
X-Gm-Features: AcwNN1VDnqeI0nANt9JGLFAAqZR4p_p34VigeOi4yaGir0FMb_J4_8lM3yPMIDM
Message-ID: <CAEvNRgHsJKS5gszvJRpoJ2YHn3A3n_V4F_zgpFQMPdVcRvKffQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm: hugetlb: Fix out_put_pages subpool reserve calculation
To: Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Hongxiang Lou <louhongxiang@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, fvdl@google.com, jthoughton@google.com, 
	rientjes@google.com, vannapurve@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

>
> [...snip...]
>
>> @@ -6821,26 +6823,21 @@ long hugetlb_reserve_pages(struct inode *inode,
>>  	}
>>  	return chg;
>>
>> -out_put_pages:
>> -	spool_resv = chg - gbl_reserve;
>> -	if (spool_resv) {
>> -		/* put sub pool's reservation back, chg - gbl_reserve */
>> -		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
>> -		/*
>> -		 * subpool's reserved pages can not be put back due to race,
>> -		 * return to hstate.
>> -		 */
>> -		hugetlb_acct_memory(h, -gbl_resv);
>> -	}
>> -	/* Restore used_hpages for pages that failed global reservation */
>> -	if (gbl_reserve && spool) {
>> -		unsigned long flags;
>> + out_put_pages:
>
> I'm not sure if this section warrants these two comment blocks anymore.
> The logic is quite straightforward now that we don't have to worry about
> managing the global / subpool reservations separately and rather just
> simply do the subtraction to account the memory.
>
>> +	/*
>> +	 * Return all that was requested from the subpool, let subpool
>> +	 * tell us the new number of reservations that need to be
>> +	 * returned to the global pool.
>> +	 */

I think this could be removed if you think it's obvious enough.

>> +	gbl_resv_put = hugepage_subpool_put_pages(spool, chg);
>> +	/*
>> +	 * There may be a difference between the number of
>> +	 * reservations to consume and the number to restore now if
>> +	 * there are multiple threads interacting with the subpool -
>> +	 * restore the difference.
>> +	 */

However, this other thing about threads racing needs to be emphasized
imo. Both subpool and hstate tracking are global. I believe pretty much
anything that updates global state based on local variables only in 1
thread is going to mess up the global state.

>> +	hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);
>>
>> -		spin_lock_irqsave(&spool->lock, flags);
>> -		if (spool->max_hpages != -1)
>> -			spool->used_hpages -= gbl_reserve;
>> -		unlock_or_release_subpool(spool, flags);
>> -	}
>>  out_uncharge_cgroup:
>>  	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
>>  					    chg * pages_per_huge_page(h), h_cg);
>>
>> --
>> 2.55.0.1007.g17ff1f9808-goog
