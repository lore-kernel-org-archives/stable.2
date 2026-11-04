Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773233;
	b=4UweDqh7RPR92csae9jFs2bQn7X6TrPNkPEcrKYGLZ8/2sI3Fhid7WJ1TFd7yK5pI5Xq
	 tK2LujxEF5Y+tJ9Zb6vtWgGhy3nVBhXu58TOM6H27pRh9A+UactQRo36DNbLfOd/N0H3d
	 Wry03No6CDjE5GIi4dw+oEIIaEbobGKr76fQ4JfVfmWkd3P2XleYMo9Gi0Q8BhydGhwLu
	 7TPdF/2pNaFK2axC6oevICC2kluWbxAcVWTpEZsid7Gf1vZklMJBtgodr7b4rs9vNunJb
	 om9Ml0hSX20un0M5GTKL4HxvnQRH71haMwtAKtMIjwKZushrQgp8jxnCBQn/vDQ6JPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773233;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=yCUMZJvO8CRzC82SQ90FmLyGmbeH8CQ8+jskgLdH76c=;
	b=L8MzCsiAmqJ/8HkMzT0V6r6rq/o3/1posRJBmCZA0+wzgi4W99IWxYOvSiL/0aECns1W
	 8dbF1UFEsx5vawi0L7f0f95IXDWoOkQAf2ho4isqKZL/9PMzQ1shgrltaaDy9oVXmE/FQ
	 cWEL+EZiq2sWuz5HVKo21lzMng3f0pZcC0vp3//nYpUDpRpVagzx4bbfxNfvwMQUgcIZ1
	 169usixPx7zL43iEigCLLJBu2C+l0BrzBoK/LkofLDE47XKupKAIo+CnFEiTi9Aptj+CV
	 F9TukCjkFEepQ2RZT+gT3xHXoE20ImcHPQJXH/ou/v7yhu9fwEG9/pi/gTYjgFn4MfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGT2zxWr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b+i8hnoF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGT2zxWr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b+i8hnoF;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968A606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 06:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4968A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGT2zxWr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b+i8hnoF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eGT2zxWr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b+i8hnoF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82D1A1F393;
	Wed,  4 Nov 2026 06:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793773231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCUMZJvO8CRzC82SQ90FmLyGmbeH8CQ8+jskgLdH76c=;
	b=eGT2zxWryhdK8o2hAOoMeQ2wsts9/QiWZemDzPnfhf6HVBRAroUIrwQLQf+TIGcT5cmPc5
	K2nBvlnMrs2XCCDmr+KXxOs7SBUX0C2G8HMjQQk6o7H9kENAjUwrrtO+EUMmGWq2C03pm4
	L/1e8etOTWXqW3gn8nK6oFYt7chqBYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793773231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCUMZJvO8CRzC82SQ90FmLyGmbeH8CQ8+jskgLdH76c=;
	b=b+i8hnoFhEhKnTvkA718FWnPoO2rl4HlDz0FlmkTa3J/Sw6BFo43u8SsQQAqyweBDzkPGz
	2saR0YGIy8o9LHDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793773231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCUMZJvO8CRzC82SQ90FmLyGmbeH8CQ8+jskgLdH76c=;
	b=eGT2zxWryhdK8o2hAOoMeQ2wsts9/QiWZemDzPnfhf6HVBRAroUIrwQLQf+TIGcT5cmPc5
	K2nBvlnMrs2XCCDmr+KXxOs7SBUX0C2G8HMjQQk6o7H9kENAjUwrrtO+EUMmGWq2C03pm4
	L/1e8etOTWXqW3gn8nK6oFYt7chqBYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793773231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCUMZJvO8CRzC82SQ90FmLyGmbeH8CQ8+jskgLdH76c=;
	b=b+i8hnoFhEhKnTvkA718FWnPoO2rl4HlDz0FlmkTa3J/Sw6BFo43u8SsQQAqyweBDzkPGz
	2saR0YGIy8o9LHDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16CB2134F0;
	Wed,  4 Nov 2026 06:20:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tiHSNa7O6mrZcwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Wed, 04 Nov 2026 06:20:31 +0000
Date: Wed, 4 Nov 2026 07:20:24 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH stable] EDAC/mc: Really fix error path ordering in
 edac_mc_alloc()
Message-ID: <20261104072024.24f77132@endymion>
In-Reply-To: <20261103210951.GAaupNn1kEIZMr4GVt@fat_crate.local>
References: <20261103170439.2f918d14@endymion>
	<20261103210951.GAaupNn1kEIZMr4GVt@fat_crate.local>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.50; x86_64-suse-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,alien8.de:email];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

On Tue, 3 Nov 2026 13:09:51 -0800, Borislav Petkov wrote:
> On Tue, Nov 03, 2026 at 05:04:39PM +0100, Jean Delvare wrote:
> > The backport of 51520e03e70d ("EDAC/mc: Fix error path ordering in
> > edac_mc_alloc()") to stable kernel branches is incomplete due to a
> > different memory allocation scheme. In v6.19 and earlier, the device
> > initialization must be moved further up so that all jumps to the
> > error label are covered.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: stable@kernel.org # v6.19-  
> 
> looks about right:
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thanks for the review.

> > I believe that CVE-2026-31689 is not properly fixed in kernels v6.19 and
> > older as of today, and the patch below shall address that. Affected
> > branches still under maintenance would be v6.18, v6.12, v6.6 and v6.1.
> > v6.19 is equally affected but no longer maintained.  
> 
> Have you audited all those other trees, whether backporting it there is
> correct?

Yes I did.
-- 
Jean Delvare
SUSE L3 Support
