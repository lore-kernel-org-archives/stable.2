Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86510B672
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759267; cv=none; b=LtKLFhNxEdmfkmJ79f/FegpianyDVlIW/LSGJKXLgj8MwLSCEy9MsJuFKShh6pEmh8ki4DHhUaw6kJddNqQof9TF27x7wr+TmW4ytDWEG56i1WK2xnz/HvH7YDzv5racmkDtOcXdQc1KUfJcU0x18353/jaaOi/Ipy17ZbIkzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759267; c=relaxed/simple;
	bh=f2IeBydYflBbokmTRr0G1FOW2R46iKxBxZ8HYd/3pEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caSOHII0Xt9aX7wVY7NLpnpXVWNa2vjFlUTudaeSRS4St+/4medCWAaw8YktzOwdKfTRz1RGWbrcdg3Jy7j70uiD9VQvBz2XMGpIUoyUp1tBYXOo7gduLKqVNWZUpa2tZhggrp8R93GzBepGjNiF2T9DJPQ1E4r1ou8cnln1YOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+sItBUn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZG8CCAi3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ni8tPixJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXABiAQ7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+sItBUn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZG8CCAi3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ni8tPixJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXABiAQ7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80F957F055;
	Mon,  3 Aug 2026 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785759258;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	b=G+sItBUnZfL/t7m+fkzWkSLgiRs+xLefF+6mKwvFpald7lX1+J++eS+fW4SFnJovhpugLk
	zTDLkC4UsYWg/A2sI5Gv+ZkabAlSIu+ODSWqbZ1jFq7CTABdSekwL9dMbg5MORgm5qzeKR
	/1zONYNJRYj+L7MWI9juxfBrZC2+6XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785759258;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	b=ZG8CCAi3py4NlkvxWa/uuQOcnHRk8GKh+89q2h6xLQD0xbXTV+BAMoO0WyZdpEDJm5BGj0
	ZdDn5wCO0VpoSkCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785759254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	b=Ni8tPixJstUs1eh1QB4aasYEoGGCpUK5EyIDy/6JFiTmtr3BJ3+CDd6tW/jxDlEErhSTLf
	fkTS8zLYSKN1Ego2vvLiXpm9V567SreDLeGSta58A9NyjnQTEGDKoRs1l6YIENiV54O/yK
	4BnCZDywLvoa2eDAMC339BPG9iOqLkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785759254;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+JcgPuwnr3lLGSKtX/fgYC1e8dUAx9CFcV0O+8Cxws=;
	b=bXABiAQ7lkJwIoFcC3bHFKrs83+yNiV2qiiSE99WYBzREbw4op1Sxe8wFYKS1B8ZWPa6U9
	lKyLNL3mX8k5vMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B7FD779A1;
	Mon,  3 Aug 2026 12:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zZ0gFhaGcGp1PQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Aug 2026 12:14:14 +0000
Date: Mon, 3 Aug 2026 14:14:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] tty: remove the ipwireless driver
Message-ID: <20260803121409.GA867448@suse.cz>
Reply-To: dsterba@suse.cz
References: <20260803091938.259944-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803091938.259944-1-qingfang.deng@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email,linux.dev:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,linuxfoundation.org,lunn.ch,linux-m68k.org,stu.xidian.edu.cn,orcam.me.uk,vger.kernel.org,lists.ozlabs.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email,suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Mon, Aug 03, 2026 at 05:19:18PM +0800, Qingfang Deng wrote:
> The last mentions of this driver on local Linux and telco support forums
> date back to 2011. This does not prove that no users remain, but the
> likelihood is too low to justify continuing to carry the driver in the
> kernel.
> 
> The maintainer agreed that the driver should be removed and noted that it
> is simple enough to build as an external module if a user resurfaces [1].
> 
> Remove the driver along with its Kconfig, defconfig, build and MAINTAINERS
> entries.
> 
> [1] https://lore.kernel.org/linux-serial/20260218152330.GI26902@suse.cz/
> 
> Assisted-by: Codex:GPT-5.6
> Cc: stable@vger.kernel.org

This is not for stable trees.

> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Reviewed-by: David Sterba <dsterba@suse.com>
Acked-by: David Sterba <dsterba@suse.com>

