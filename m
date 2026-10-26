Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018977;
	b=Bq7ISidi9/zxvV0Ft50j3YXIFrX5DfiIufGzwB1uGhIFvOR7/S3iLQZzhPB80hMvWpA1
	 LmiYb+Bc7lF+e77S/ygvlcS1yQDIK7ELM8B+SIitdF98GSgUaS/0HfO81KmJ9Y42YXLuL
	 Nl03NNTBy3afybHSDaBeectP6r2IImnlLZkzY/48rZwcW8MRIi53fTyvpH8rbWMHxKdI2
	 iCACiq0k7u/7Js6AHVU7Zn6ZYMcLotc1oPe6Sc+id5sW/O5MXMmyzkziCJTBkLr7cKGAB
	 /cZj7W+czGbGNrXo170eSlJmYk/mKuBO5rOA1tXKhaQt316JE5Km1kAtmIPq6dQZmQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018977;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=afZGfCekX7UpYo8D5sYQDVlkG6MmuiaVKNxybV7UkSE=;
	b=UfaIWnnSdb2rqQFlv0eEDUkzjH5balFkvpa01qPyJ/NCLzbgb1KO0/RiDIse0WqEFG6W
	 RqjSPYQBDF2DIgF5Iu42vqldpCoNYHHq4ger7wJKgKfUNjRj7rDjbw/w84ROmHbOS7NrV
	 fJMGYbjuI+jTgR08IhFP1NwoxeDUDbqWOpDsUJ7qaYOBUQkA9MzkkxZQO6X/KC1+HfbDf
	 4tTFPVZ8QJUK3LtzVE9POPf9J0YI3KVNw8kN6E25QKnwfs5Z1fOlEyf3Ns7c+yYqbC9cc
	 F4lP1yEn9YmB0Ba1bF2DUMImptf+YKTlAyYxIe2xELnNiPfWa0BKDbPAPPAIx9T4J8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wUFRGu+T;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9YoYJgJT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QuuBnnDu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qGFZuMKR;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7EA606A31D;
	Mon, 26 Oct 2026 12:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F7EA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wUFRGu+T;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9YoYJgJT;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QuuBnnDu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qGFZuMKR
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 30C2F1F393;
	Mon, 26 Oct 2026 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793018975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afZGfCekX7UpYo8D5sYQDVlkG6MmuiaVKNxybV7UkSE=;
	b=wUFRGu+T7ZG1KLWrWTEi1iqlAMO8cOnCo/vns6t0g/XH4cywRhW19Wu/iOgTV5sLs8tVCU
	9NopHFKoCBGlkuYt2t++A87UOvqoIyUDjBFopCWxN7SQTIWQedFZW00uYe2Q/bbkKy7syn
	O0mrAagysF+M3JNTZJk/gYbyNL5A9+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793018975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afZGfCekX7UpYo8D5sYQDVlkG6MmuiaVKNxybV7UkSE=;
	b=9YoYJgJTLi01TIwUPENmL7JIUaWTs/kVTxy/HUSDYU4Ro78f0q8eYgMQZYU4UDbGu8Fcck
	8Rpmme2dqi2Y5sDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793018974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afZGfCekX7UpYo8D5sYQDVlkG6MmuiaVKNxybV7UkSE=;
	b=QuuBnnDuCAKNGbkKz3wvOEQ7Wx1d6Gn69LyR+kxzV73Mce9lPwCRTZJRrsy2ew4pH0rNNo
	N1yqxjcbBTB0L5ogtOdY1YE6+gKOinW/nnjsmnv/ciOMhOqEAqZUw07/LnoRMNHehUvU7l
	unZ8SMKCR3DhVHQAKsUObo9KEY/MfX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793018974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afZGfCekX7UpYo8D5sYQDVlkG6MmuiaVKNxybV7UkSE=;
	b=qGFZuMKRVbI1lalLA/w28T0RpFPpYwec0rWBlWVGUXpRFYB0AEepiV6m7vhtvVGG2vjn05
	Dc1pCf9OeJEMaTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DABEE13319;
	Mon, 26 Oct 2026 12:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a5SyJ1xM32rFTAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 12:49:32 +0000
Date: Mon, 26 Oct 2026 12:49:30 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
	Colin Cross <ccross@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: do not unintentionally overwrite atomic VMA flags
Message-ID: <at9MLiqTg7jLSp8k@pedro-suse.tail5790ac.ts.net>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
 <20261023-fix-vma-atomic-v1-1-8ff4fae1fc85@kernel.org>
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
In-Reply-To: <20261023-fix-vma-atomic-v1-1-8ff4fae1fc85@kernel.org>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Oct 23, 2026 at 02:47:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> madvise, mlock and mprotect take a copy of a VMA's flags holding only the
> VMA read lock, later writing it back under the write lock (in
> madvise_update_vma(), mlock_fixup(), mlock_vma_pages_range() and
> mprotect_fixup()).
> 
> This was done on the assumption that VMA flags cannot change with a read
> lock held.
> 
> However this changed in commit 2ab7f1bbafc9 ("mm/madvise: allow guard page
> install/remove under VMA lock"), which allowed VM_ATOMIC_SET_ALLOWED
> flags (currently only VMA_MAYBE_GUARD_BIT) to be written concurrently under
> a VMA read lock.
> 
> The actual write itself is safe as this is done under the VMA write lock
> at which point no further concurrent writes can occur, however at this
> point the stale flags mean that these callers can unintentionally overwrite
> atomic flags incorrectly.
> 
> The consequences of this are significant - a missing VMA_MAYBE_GUARD_BIT
> could result in page tables not being copied on fork (the vma_needs_copy()
> check can return false) or being overwritten on file-backed THP
> collapse (the file_backed_vma_is_retractable() can return true).
> 
> Resolve the issue by always taking care to retain existing atomic flags
> when overwriting VMA flags, replacing the inconsistently named
> vma_flags_reset_once() with vma_overwrite_flags() to do so, and always
> invoking it when flags are overwritten like this.
> 
> Reads are a problem too - madvise, mlock and mprotect all compare VMA flags
> without a VMA write lock held via vma_flags_same_pair().
> 
> This has more serious impact, as concurrent changes to atomic VMA flags can
> cause two sets of VMA flags to be wrongly considered different.

I really wish we had a new field for atomic flags :/

> 
> For mprotect and madvise this causes a useless split, but mlock is impacted
> more seriously as it can result in mm->locked_vm underflow.
> 
> Fix this by updating vma_flags_same_pair() to disregard
> VM_ATOMIC_SET_ALLOWED VMAs - VMA equality is the same as VMA mergeability,
> and atomic VMA flags are disregarded when comparing VMA flags for merge -
> so this is justified semantically.
> 
> Additionally, remove the redundant vma_flags_same_mask() and the unused
> vma_flags_same() as part of the change, and replace VM_ATOMIC_SET_ALLOWED
> with VMA_ATOMIC_SET_ALLOWED, using the new VMA flag API.
> 
> Finally, update userland VMA tests to reflect the changes.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Fixes: 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove under VMA lock")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Anyway, LGTM

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
