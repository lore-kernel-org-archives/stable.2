Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029742;
	b=jB0lwnw0Edg0Quh6zYB8TNJoe46MWEOD0J6QYA+f6l5nsr3Rcm4YvbUn/VnluW2GB4gr
	 i4O3Mm8vuzdgV39KOBS/8i1kTcOUwedr+erXFe3fbcNUB3uQsCwTKbNoTEmuiYlZVClsA
	 8NLU4RhK/zArTXNUHd2pJVxlVICc5d8u7U5sCITeAuwTFVkLA/twjqrW/Z38Ok2Z3zsoX
	 ExvxW2ByAgjLMA88HvaSlv5iEBjl4+cQAOw0tQh4+ewRxInlNfr47Jj/RuFcTPmeD92zp
	 ovdwcJxNKAzaBxkH+jkabh7+M4OVocRsr4xC66SH8wDxarVaPocVKNeOMtu4ge8D25w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029742;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=KlF69bY/nHZrbLTGbrUEwXS/fyT5+90IouYwTF+tbKY=;
	b=MQ77kOof4Kd3XT1kl3cc5TU3v//sdGq7c5Tz59Rs+3ATAZ17vItXsVNuzDUmPiIFK/UH
	 4x4L2StcRkCRezyqZwFRCngZqSuM76+spfABtr8wOhK8XyfQ+xTxg+pLq2hMg13RCSY0U
	 9ZiPOA3N65HAbC1FxXyysSfmb82F5KJBq1t9/Izy8R/CySw46J8T4/fppHPlaXKL8wFkx
	 1lOnF6hCyZn/xgPObUoKvwyrAhgaSbOAP5hV3mcF7fVvoQLv2/sqJJ0mai8VAQGRJCr6l
	 wSFIPqjhvjxpVYmlEA1ZAFhumnS8C6T3l0I0COxVt6KQfj7pcmjKDnNLCXyk0seIAjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=krmv0XT6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SRMCjd4a;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HLZOSbie;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=i8OyxSiO;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0389606A31F;
	Mon, 26 Oct 2026 15:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0389606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=krmv0XT6;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SRMCjd4a;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HLZOSbie;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=i8OyxSiO
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E01AE2227B;
	Mon, 26 Oct 2026 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793029740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlF69bY/nHZrbLTGbrUEwXS/fyT5+90IouYwTF+tbKY=;
	b=krmv0XT6wBZeSaSckvD2LLgRpMbhqBlmxXMtsiX1U7wAZKxmhDV0khHauaRPR0vNgbCAJo
	Rn/fuxNbdcNezMAW6lTsiAh3blGGuUzgSm0+IHRDIQYKeoAEXpHdWDMpmLZ6gcRObeSBhs
	QjWyuaCgs4p9elzs10hc37c10xAiiNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793029740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlF69bY/nHZrbLTGbrUEwXS/fyT5+90IouYwTF+tbKY=;
	b=SRMCjd4aLgS6Y2HNS0yfrFrkDLWRRyTIsW0oIluh7yhwN9JqJp+MptlFj2jLMuiSBq1TqV
	smjLzLcwalHdUvCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793029738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlF69bY/nHZrbLTGbrUEwXS/fyT5+90IouYwTF+tbKY=;
	b=HLZOSbie8dHXdZ6uOMN60r1MBKv30Rz41SKSY5q+GRTzSRDhOHbK5wpgpB06zRgyNV11rt
	8UiKSogqQ7g8SrM/XZnNKNgKk/V8g1uyk1nSEYDIIvyMo2J+upYyqGT2GTC2Q8+QXYg/l/
	aYXyl5SbG9FD/yY32CnQT8xv0vH/Gkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793029738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlF69bY/nHZrbLTGbrUEwXS/fyT5+90IouYwTF+tbKY=;
	b=i8OyxSiOdnmseqEyYZtum+5yGSziChO5J/OdLd2C5pKlJYqPXydnxgt3Mn7tKPkgMuTj32
	getWLnpB0miLjdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B604B13408;
	Mon, 26 Oct 2026 15:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FLKQJGp232oqDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 15:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3FDFEA1419; Mon, 26 Oct 2026 16:48:58 +0100 (CET)
Date: Mon, 26 Oct 2026 16:48:58 +0100
From: Jan Kara <jack@suse.cz>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>, willy@infradead.org, jack@suse.cz, 
	hughd@google.com, baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
Message-ID: <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>
References: <20261025164619.89992-1-dennylin0707@gmail.com>
 <at9xXRhD2xZhszEj@thinkstation>
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
In-Reply-To: <at9xXRhD2xZhszEj@thinkstation>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,suse.cz,google.com,linux.alibaba.com,linux-foundation.org,linux.intel.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Mon 26-10-26 15:34:08, Kiryl Shutsemau wrote:
> On Sun, Oct 25, 2026 at 04:46:19PM +0000, Hungyu Lin wrote:
> > shmem_write_end() advances i_size to pos + copied even when copied is
> > zero. A buffered write past EOF can therefore extend a tmpfs file
> > without writing any data.
> 
> + willy, jack, fsdevel.
> 
> This doesn't seem to be tmpfs-specific, right? I see the same with ext4.
> 
> simple_write_end() and generic_write_end() check pos + copied the same
> way, so filesystems that use them through generic_perform_write() are
> affected too.
> 
> It makes me think maybe generic_perform_write() is the right place to
> fix it. Hm?

Well, that would be nice. But how'd you like to do that? i_size update is
the responsibility of ->write_end and we have to call ->write_end if copied
== 0 so that is undoes what ->write_begin has prepared.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
