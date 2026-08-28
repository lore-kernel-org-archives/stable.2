Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBB369219;
	Fri, 28 Aug 2026 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787909367; cv=none; b=chR9LYJSy69TpFc2FwhcRv0Llew9ETl5Pk+8hg+lLyseAJBWa+H9BlLFOeIifXH/GJtkQv0/QgXyl1uU+rxVKgj8D7vNt+Otpe3S+7Phbg9Wf1iaH2IBAty1i6lgSxdBMzrqUjl7HhwRsEc4gIbwhl4AS0Qv7KryK74+3Rt0fqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787909367; c=relaxed/simple;
	bh=HHkwkiwmaSwe+F4+FNu97EuRlPh/mU/Pup7ivSO29+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhuCsBQ6VZn0y4cC34erDCU9/aGX6gANiRgSDkm5q0PXK0tmng7riDaPO8ME5tbFcgZeWTv1xJUagmhDDli1qx5L6bGDeJkMnxaEYEyZqweF48NogiOivJQvFnCFoPzHEk+7E3R2BXJWPIT4h9GCwAUU8WSjORXCykkVXO8P71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O4FYA4Rb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O+F89elZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gk+e5jRH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1koz1/ze; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O4FYA4Rb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O+F89elZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gk+e5jRH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1koz1/ze"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9EA21FB62;
	Fri, 28 Aug 2026 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787909359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0+yG+1bN20RSdMl6UCMwOfEUTtxXoxF8Axb3Ve+/jI=;
	b=O4FYA4RbVJixP2zJBddcAkrp/ewWu0qU4f/QLJkPIQfOIBoMfb2Nvhk8gtN8I63OBy/nP5
	r345r02e7XaPDd8y8a9V7R9FXn/EnTQO83eF7Mqkiu2RLmDVgmcfG+WRRhma6Jl3d6xtRp
	Hq6m2EIE4lWrIPzxhrgchXpVsYm9y+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787909359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0+yG+1bN20RSdMl6UCMwOfEUTtxXoxF8Axb3Ve+/jI=;
	b=O+F89elZiROAeuOGjX1wcKvutymEHMqY15NgQsCKisaoAg+QuapHtyAuJljMpCtcKxrE13
	67RaqiR4o2/qP/Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787909355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0+yG+1bN20RSdMl6UCMwOfEUTtxXoxF8Axb3Ve+/jI=;
	b=gk+e5jRHYxvSE0b9WE+tGn2kFt5rvxTZt7ByFcTJGa9p/Dk3Ovf3KMyc+xiPYLwJpUndPx
	9vzqd0QAZLbfitdzUvyrs3lxBtI22goXDS8hyksHyt51PE3JBTWopUXFCw7N6MDDU9Hqlo
	h3g/hucmLmtkK6F3lC9k+0jUkwwmj0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787909355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0+yG+1bN20RSdMl6UCMwOfEUTtxXoxF8Axb3Ve+/jI=;
	b=1koz1/zeBsS2C4mZty+80W9OUVX9cI5asaX8nmkWjTc8uQsAjl6YehNx2xyRxlKwWIcj8E
	jsRB706U2x5nlvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCF3813515;
	Fri, 28 Aug 2026 09:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vc+nMupUkWoEeQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 28 Aug 2026 09:29:14 +0000
Date: Fri, 28 Aug 2026 10:29:13 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Li Xinhai <lixinhai.lxh@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
Message-ID: <apFUzpx6zwAjhvC2@pedro-suse.lan>
References: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[f12658786a4153df5113];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,kernel.org,google.com,gmail.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,pedro-suse.lan:mid]
X-Spam-Flag: NO

On Tue, Aug 25, 2026 at 08:55:26AM +0100, Lorenzo Stoakes (ARM) wrote:
> Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can reset
> a faulted VMA into an unfaulted one.
> 
> It does so after the page tables have been moved to the copied VMA with
> MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfaulted
> as the page tables it had are no longer present.
> 
> However, in doing so, it violates the invariant that the anonymous page
> offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.
> 
> This is because a VMA may have been faulted in, mremap()'d (causing a delta
> between its page offset and vma->vm_start >> PAGE_SHIFT), and then
> mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.
> 
> This condition is a violation of a fundamental assumption in mm, but now
> also triggers an assert in assert_sane_pgoff() which explicitly checks for
> this condition.
> 
> Correct it by resetting the VMA's page offset at the point of completing
> the MREMAP_DONTUNMAP operation.
> 
> Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a87853b.ae6ddae5.3da009.0023.GAE@google.com/
> Fixes: 1583aa278f5f ("mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>


-- 
Pedro
