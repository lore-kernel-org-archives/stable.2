Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673D32E128;
	Mon,  5 Oct 2026 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180589; cv=none; b=I5i5uG0AiOjQdEUgXz2JIHfwmRguwCFjerrR5/wkGzi79MnpA3WP+jRmBR/VVHYItHgfSlHk9BDss8tBk4VnNo2YpQpYi+m2gG8RQLf/SMNVMudiG4y86AoVF/pbeDlop7/jSbwKT6aFsngs9nk55oHifn+WHY6RG+w5RHTkzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180589; c=relaxed/simple;
	bh=DdYtC2idGqrXoP58FxPkiOC3c/hKm551aqQAaJQcVvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+1o0jbzr56Ff0/S944nTmrnnPNuiDZr/sRcg826TGShspL/boPY0Ub31t5+U5cxWTlGehIIz8yy1QKyqRxIswtG+1U6yxMM3rjfkdPOFKVYMCD5RyLuYX4pHTuCm6aJ/WZMo11z+S7UauGbfqFSV+AaW/Wy4G2mrD6ooccnEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ry9geKI6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=//qhazbQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SJbVbon5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B8Z8v9rg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ry9geKI6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="//qhazbQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SJbVbon5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B8Z8v9rg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA62A21E86;
	Mon,  5 Oct 2026 06:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791180580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/ejuC82x28bAndFLSItnOGKHqAeicBTwXUq8uK5v1Q=;
	b=ry9geKI6pF6M9QVELgUcIpqEQ1VAuj2yrQmleMftMLPZATU/dwl0qyKb7B8r0bOjnkqvf0
	L8x5kSRDo/CjphWS/wnmUarWkywSKnrJINMOaPu2WnmR3/WQwPc8AbGNytuZ0OIM2t5RfQ
	+0jLOqGdTDbZwjaTtXKifrQXReOReE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791180580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/ejuC82x28bAndFLSItnOGKHqAeicBTwXUq8uK5v1Q=;
	b=//qhazbQCMNmF5Go41k/pRzufO5Rjb3yi/U7HM5ED0wRsmGLuKk9aF6Ll8GiIpM2Nil3Km
	DVonZWNtJdEiSqCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SJbVbon5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B8Z8v9rg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791180576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/ejuC82x28bAndFLSItnOGKHqAeicBTwXUq8uK5v1Q=;
	b=SJbVbon5JV5mnQRgQ0jGovGLeXzEt4BOwiYjz6efFIVmmOQkAr0PEjfUM/7P0ASQNPcgfD
	9GBwCkzf84o8MK42Ov2jVfGvsI/LBoB9onMzzRqsp7PQVNCPlC1W/bTb7O+rQEcrba+DED
	NtdXomhXQ7CZLLvurEp0yRa8A6JgdEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791180576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/ejuC82x28bAndFLSItnOGKHqAeicBTwXUq8uK5v1Q=;
	b=B8Z8v9rgicrwKF/cCc2/ox4K/Z+vy5h9dn8QcYR2drEnQhtfKAe5ccHZQeLXeVWBocQRFw
	SnTv6tpReDGIOpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43831132D3;
	Mon,  5 Oct 2026 06:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z2cGASA/w2oBDwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 05 Oct 2026 06:09:36 +0000
Date: Mon, 5 Oct 2026 08:09:30 +0200
From: Pedro Falcato <pfalcato@suse.de>
To: Lance Yang <lance.yang@linux.dev>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	riel@surriel.com, linux-kernel@vger.kernel.org, qi.zheng@linux.dev, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, brendan.jackman@linux.dev, 
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali.Shukla@amd.com, mingo@kernel.org, stable@vger.kernel.org, toshi.kani@hpe.com, 
	david@kernel.org, mikhail.v.gavrilov@gmail.com
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
Message-ID: <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
References: <20261005052302.43042-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005052302.43042-1-lance.yang@linux.dev>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email,pedro-suse.tail5790ac.ts.net:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,infradead.org,redhat.com,alien8.de,zytor.com,surriel.com,vger.kernel.org,linux.dev,gmail.com,amd.com,meta.com,kvack.org,linux-foundation.org,google.com,outlook.com,citrix.com,hpe.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLziudqfrzo6b7hzgpxksh1d9i)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.tail5790ac.ts.net:mid,linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BA62A21E86
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon, Oct 05, 2026 at 01:23:02PM +0800, Lance Yang wrote:
> pud_free_pmd_page() uses a single-address invalidation to flush the
> paging-structure caches before freeing the page tables. With AMD TCE
> enabled, this only invalidates upper-level entries associated with the
> target address. Cached PMD entries for other addresses in the PUD range can
> still reference the PTE pages being freed.
> 
> The AMD manual quoted in the commit enabling TCE says these instructions
> remove
> 
>   "only those upper-level entries that lead to the target PTE in the page
>   table hierarchy, leaving unrelated upper-level entries intact."
> 
> Even with all PTEs cleared, speculative page walks can cache present PMD
> entries after the earlier TLB purge.
> 
> Use a full TLB flush before freeing the page tables on CPUs with TCE. Keep
> the single-address invalidation otherwise.
> 
> Fixes: 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

I'm not sure this is correct. The PUD is clear. We invalidate the TLB, which
invalidates the translation caches for that walk. invlpg will notice the PUD
isn't present. I don't see a case where it can ever not clear the rest
of the translation caches for all leaves. And, in fact, by that point the CPU
can (does?) probably formally treat the PUD as the leaf.

Did you repro any bug related to this? The functionality is perhaps
underspecified in the AMD manual.

-- 
Pedro
