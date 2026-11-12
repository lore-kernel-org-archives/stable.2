Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482505;
	b=vutuLT08S5rISoT7fuySzxIHYLKgYJocE3Rdd5GEwrAHaUwwTcpFNC3W40noVqDjT0h8
	 FcaeapwzJBHhR/Xb0YAPG5Fu8cmHIUHpWcIRHkbbOIsobjabeBGfJzyQablik1oXzqBfb
	 pKa+kdTLOBp7SNcEhgFjZSgNiLp7dIwUrvsPRcAP4nTey+xVRXtsDUE7sqFs8T3ABs4Uu
	 khgmBn5eG+/6Ft1817cZtuHHVBnGu/EPadKJNnQFXWjHP7m6p65K7rYwal+eZsqwLnTIZ
	 EJcaQum8hXefypztuTVHVoSDvnHW2HX6IH3cQR/scIIwZu23TssPL4GEHu1crRKAs3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482505;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=b68hR85FMy64ZLKPI+SkETJKcoWTtrleDFFCwxd3C7E=;
	b=KOLReikNhv2tPhVpuKFyY+bRaHrtRp7k8buRDdr6a5EG1AUaL3Mx/KDipEjMzrNj4Hl5
	 Cji5CGAW5bdscN2T6YwbOkr5qVfYCG/cfR/1ZA4tFGSxIgMPyXiwctTCaxkHuNl+va7BP
	 cJz9hdZ9/622ZWxHu823iBx8ESAG+zeoTLlGLSRyXdANMIv6dRwWW63aZbB/rMaA3nKsQ
	 dAp3WNRQbkjysnhzEab3lCN4cllntoK7e3L5VgKVcqy6r18N7dwgAehvFSqU9lrxLbDMq
	 BgFVth+dPZiW3gzhOHBfcdd+stL+xOCVpZ4VZG/T40DG1x6CAHPAN11TWXquSU9X8eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f8PKmcO3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Qc8cqb2R;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f8PKmcO3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Qc8cqb2R;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68859606F407;
	Thu, 12 Nov 2026 11:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68859606F407
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f8PKmcO3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Qc8cqb2R;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=f8PKmcO3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Qc8cqb2R
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83E481F74D;
	Thu, 12 Nov 2026 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794482502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b68hR85FMy64ZLKPI+SkETJKcoWTtrleDFFCwxd3C7E=;
	b=f8PKmcO3THEm97E0clNHriq4Z64U95UVpQJKVzAHSFQsf2uA8U5cIRr+Kz2zuNFySoOqlP
	3/9gmJ7WZkgL7nmxglnkqVcbIcqwyepaDSFJL9+m2XXYD4mn0Yp/i1+4uEaZ+yUYK3bBAO
	Z/Zk+ThUwR6EC8Xo9kGfRh86noaXH6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794482502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b68hR85FMy64ZLKPI+SkETJKcoWTtrleDFFCwxd3C7E=;
	b=Qc8cqb2RCIXsDmnVlLXr1Rg/oe9HO72E9kGX41HXI6G+yK09O6MWVLkmK8wuduiymKcucb
	szOlGWoh9SGsTfDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f8PKmcO3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qc8cqb2R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794482502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b68hR85FMy64ZLKPI+SkETJKcoWTtrleDFFCwxd3C7E=;
	b=f8PKmcO3THEm97E0clNHriq4Z64U95UVpQJKVzAHSFQsf2uA8U5cIRr+Kz2zuNFySoOqlP
	3/9gmJ7WZkgL7nmxglnkqVcbIcqwyepaDSFJL9+m2XXYD4mn0Yp/i1+4uEaZ+yUYK3bBAO
	Z/Zk+ThUwR6EC8Xo9kGfRh86noaXH6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794482502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b68hR85FMy64ZLKPI+SkETJKcoWTtrleDFFCwxd3C7E=;
	b=Qc8cqb2RCIXsDmnVlLXr1Rg/oe9HO72E9kGX41HXI6G+yK09O6MWVLkmK8wuduiymKcucb
	szOlGWoh9SGsTfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D635A134A0;
	Thu, 12 Nov 2026 11:21:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fxoaJEOh9WodfQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 12 Nov 2026 11:21:39 +0000
Date: Thu, 12 Nov 2026 11:21:38 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avWgulaWoKBfIFlo@pedro-suse.tail5790ac.ts.net>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,google.com,suse.com,linux.dev,linux-foundation.org,suse.cz,gmail.com,cmpxchg.org,nvidia.com,intel.com,sk.com,gourry.net,linux.alibaba.com,tencent.com,redhat.com,linux.intel.com,gentwo.org,nxp.com,fb.com,kvack.org,vger.kernel.org,alien8.de];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLziudqfrzo6b7hzgpxksh1d9i)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 83E481F74D

On Wed, Nov 11, 2026 at 06:13:15PM +0000, Lorenzo Stoakes (ARM) wrote:
> The OOM killer can quickly trigger again after having selected a
> victim. That victim might not have freed its memory yet, but its mm will
> be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> 
> This can cause the OOM killer to kill an innocent process when the first
> might have freed enough memory to relieve the memory pressure.
> 
> Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> 
> Note that the task which calls mmput() might not be the victim - if it
> took a reference on the mm (e.g. ptrace), it may hold the last reference
> and release it when it calls mmput().
> 
> Therefore we cannot rely on current to tell whether the mm belongs to an
> OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
> unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
> mark_oom_victim() sets on the victim's mm, and check that.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Looks good, thank you!

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

> ---
>  include/linux/mm_types.h | 2 ++
>  include/linux/oom.h      | 9 +++++++++
>  mm/mmap.c                | 9 ++++++++-
>  mm/oom_kill.c            | 4 +++-
>  4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ed35d258d2e..09e63ff12b04 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2030,6 +2030,8 @@ enum {
>  #define MMF_TOPDOWN		31	/* mm searches top down by default */
>  #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
>  
> +#define MMF_OOM_VICTIM		32	/* mm is the oom victim */
> +
>  #define MMF_INIT_LEGACY_MASK	(MMF_DUMP_FILTER_MASK |\
>  				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
>  				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 00da05d227e6..a9390cb70541 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -76,6 +76,15 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
>  	return tsk->signal->oom_mm;
>  }
>  
> +/*
> + * Use this helper if tsk->mm != mm and the victim mm needs a special
> + * handling. This is guaranteed to stay true after once set.
> + */
> +static inline bool mm_is_oom_victim(struct mm_struct *mm)
> +{
> +	return mm_flags_test(MMF_OOM_VICTIM, mm);
> +}
> +
>  /*
>   * Checks whether a page fault on the given mm is still reliable.
>   * This is no longer true if the oom reaper started to reap the
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7618e72766a5..4cb18b217048 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, &unmap);
> +
> +	/*
> +	 * Free the memory before marking MMF_OOM_SKIP so a re-triggered OOM
> +	 * killer will only skip this mm if it's already freed all it can.
> +	 */
> +	if (mm_is_oom_victim(mm))
> +		tlb_flush_mmu(&tlb);

I see there's a different tlb_flush_mmu() call below (in the actual function).
Is tlb_flush_mmu() idempotent?

-- 
Pedro
