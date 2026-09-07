Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8977455188;
	Mon,  7 Sep 2026 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774736; cv=none; b=ZG1V/t8ZbYM6GgwwFSXPVgVQ7UHYfaCgZZ4F+wMtMXLPBiq0LsRhzMzrYBEEM4/ZgvmjIz/O0WY+dCyLE4dISfSRZIShPOmrTGVyNmN02mmxbwutRa3X5AghrO7L+IVga8Z3+p9qFalAdjq+0dlgFAxv0rb1KRkB8AUE2egmucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774736; c=relaxed/simple;
	bh=1J43Z5p2j17qR+iNKUyDptc6cvK3RmhcLZAg7kCMElU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN0t0yTOHefshMu/6RHodolnvcAKW/hLFShU+09g1UpsEQv6C9uHzmbFjgWRqxOV0KHLs9Mc+mjtxlKwxHXw/s9zK4NrhFaRAWVf9Gb9UE83YbABjQlFyM5bi+9BLbASYwQzesBt8HOkM32+Ss/yoOi3F77z1F9sLDqPSdg1LZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dE3PFJPZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=evckSjsS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NbQGgxrx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1h27ebbK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dE3PFJPZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="evckSjsS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NbQGgxrx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1h27ebbK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A71E41F74B;
	Mon,  7 Sep 2026 09:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788774717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lrwr41K2Av2Kuzp3keYp7cIHw72jszLX9DJXo1qTJ+s=;
	b=dE3PFJPZWRBPE3E4+rmps6dicaRZa2lCogXhIAPARvhDr6vvx9qYbxmlSQjsnHfXNen+k9
	5jcmJNUQgEpcf/GRp/OUHCDGv/s2RwAJb9RLv5g8y28PVln/B67+9+tv9bvPSNtXQLRIp4
	auJpXhHpf9JXfP+UwDoG3pnUYEsRvEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788774717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lrwr41K2Av2Kuzp3keYp7cIHw72jszLX9DJXo1qTJ+s=;
	b=evckSjsSFhYc+ha+a3TasKEfS0/LQCR+139IpylcHE6VnVcJPNJjmlXsOvY9O3DuwYYjaA
	CTIgKmbtMXby6CCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NbQGgxrx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1h27ebbK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788774713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lrwr41K2Av2Kuzp3keYp7cIHw72jszLX9DJXo1qTJ+s=;
	b=NbQGgxrx4+NYiF3BWZ485svl9z6Ee1XZLb/1OpRgnur5eDPsRpMyj4gNviEj+/kc+QPDCL
	ODIOJEQYohutKHlDEki5eB59AHMB6I33iDeolOCdVGGUuCKnZ8AIIImspU26tZvI8+B/Aa
	87/kQFxM5cCda+/c9MYTphsxXUmchIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788774713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lrwr41K2Av2Kuzp3keYp7cIHw72jszLX9DJXo1qTJ+s=;
	b=1h27ebbKa5K3TTcSGv2wM/I+9Ex8ihbl44C997NEjxlviuolS4UO8fGXYe8BefaiWwHQWs
	IQkWQKViMr4m1xAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D0AF13432;
	Mon,  7 Sep 2026 09:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3FX5BTiJnmpiFAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 07 Sep 2026 09:51:52 +0000
Date: Mon, 7 Sep 2026 10:51:50 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, akpm@linux-foundation.org, david@kernel.org, hpa@zytor.com, 
	rmclure@linux.ibm.com, andrew+kernel@donnellan.id.au, pasha.tatashin@soleen.com, 
	kas@kernel.org, tj@kernel.org, rppt@kernel.org, rick.p.edgecombe@intel.com, 
	yu-cheng.yu@intel.com, orsonpeters@gmail.com, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Message-ID: <ap6IYeTM8PMinxo-@pedro-suse.tail5790ac.ts.net>
References: <20260903031608.1194238-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903031608.1194238-1-vernon2gm@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A71E41F74B
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linux-foundation.org,zytor.com,linux.ibm.com,donnellan.id.au,soleen.com,intel.com,gmail.com,vger.kernel.org,kvack.org,kylinos.cn];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.01

On Thu, Sep 03, 2026 at 11:16:08AM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> pmd_modify() masks the old value with (_HPAGE_CHG_MASK & ~_PAGE_DIRTY),
> silently discarding the hardware dirty bit.  The subsequent
> pmd_mksaveddirty() call is supposed to transfer _PAGE_DIRTY into
> _PAGE_SAVED_DIRTY when write-protecting, but the dirty bit was already
> stripped from the value, so there is nothing left to transfer.
> 
> Contrast with pte_modify(), which keeps _PAGE_DIRTY_BITS in its mask,
> and pud_modify(), which keeps _HPAGE_CHG_MASK untouched: pmd_modify()
> is the odd one out.  Any pmd_modify() on a writable, dirty PMD loses
> the dirty state.
> 
> One visible consequence is data loss with MADV_FREE on PMD-mapped THP:
> 
>     memset(buf, 0x5A, size);          // PMD-mapped THP, PMD dirty
>     madvise(buf, size, MADV_FREE);    // PMD cleaned but left writable,
>                                       // folio marked lazyfree
>     memset(buf, 0x5A, size);          // hardware sets _PAGE_DIRTY again
>     mprotect(buf, size, PROT_READ);   // pmd_modify() drops the dirty bit
>     mprotect(buf, size, PROT_READ|PROT_WRITE);
>     // ... memory pressure ...
> 
> Reclaim (e.g. under memcg pressure) then finds the lazyfree folio with
> no dirty bit set anywhere and frees it in
> __discard_anon_folio_pmd_locked(), even though the data was rewritten
> after MADV_FREE; subsequent reads fault in fresh zero pages.  NUMA
> hinting alone can trigger the same loss, as do_huge_pmd_numa_page()
> restores the PMD through pmd_modify() as well.
> 
> PMD-mapped file THPs are affected too: mprotect()/NUMA hinting dropping
> the dirty bit means rewritten data is never written back.
> 
> Fix it by keeping _PAGE_DIRTY in the preserved mask, exactly like
> pte_modify() and pud_modify() do.  The existing
> pmd_mksaveddirty()/pmd_clear_saveddirty() pair then performs the
> hardware-dirty <-> saved-dirty transition based on the write bit,
> preserving the shadow-stack encoding rules.
> 
> Closes: https://lore.kernel.org/r/CAJxLxMUGu1-L+O_nAONOwOXnS=cNbNApCWqdthRjd76LThtSPg@mail.gmail.com/
> Fixes: bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>

FYI we just had a customer case for our downstream kernel for this exact same
issue. This fixed it beautifully (I'm wondering if polars started doing
something interesting lately, that nobody else does, and that's why...).

Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
