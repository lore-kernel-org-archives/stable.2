Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52B334692
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113397; cv=none; b=CeiV0ggPwJDeYBfi3PAODYKlBNKIjbq5onbLKlzCMKDiFEc0TQb4VGScw3vO/y0YfSWe5ZnUIg7zl9ICTfubKMVKogy1Y1cDlcIN46BabmM+yFisvpDJ0r1bl4Apm2dgdHqxrZB7Wp173Al0xQGwFmQzvM+GnSOd56+WBHpwKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113397; c=relaxed/simple;
	bh=mkjSaBNlozbOinNvp2aFAUyG+xq5hemqxlmqqF7w+S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKyjV0YNxRnKNHfOTNXudDl87Qv5WqZmIDpLujTLeSmWK6rb3If1Btx/wD0oA0lzOgFi7xDdVt43kUwq8S96q9rVVvtT/XpZk+zxp/FPKLP8oe6PLAHuJCVH1fDrkXTiohhSR16wmU/kVWIggMmO/Vt/eP+Jkih6ub2PKefcZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zp9S4ker; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DU86yZ9i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zp9S4ker; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DU86yZ9i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zp9S4ker";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DU86yZ9i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zp9S4ker";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DU86yZ9i"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DC773E2C;
	Wed, 15 Jul 2026 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784113394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/w0/JofSGuJID6gCR3ETcE1l/O+Ym8fL3mervCh8EY=;
	b=zp9S4keryKvPSeo6DUINoZiYwFq/YXNK91O7BUc94CKyUaHs54bPkEIeNGlEdMWt51WpGt
	upkGJ3Vii8D8g1m2E5jrijlbLqewYO2M29/vnyDySzbN30ieZv8VWTrrwWtgomvrV2Ru+b
	Zp+iuUH9YSnECBdlyCt21KkXPkV1K+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784113394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/w0/JofSGuJID6gCR3ETcE1l/O+Ym8fL3mervCh8EY=;
	b=DU86yZ9iikGFjQnG2BvTDTZqu9ae/Nrwml7rvrJ5f1gjjqLgaMZOljkqFv8Yg6EtZZ3S0I
	04jRuyg7ww8dBECQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784113394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/w0/JofSGuJID6gCR3ETcE1l/O+Ym8fL3mervCh8EY=;
	b=zp9S4keryKvPSeo6DUINoZiYwFq/YXNK91O7BUc94CKyUaHs54bPkEIeNGlEdMWt51WpGt
	upkGJ3Vii8D8g1m2E5jrijlbLqewYO2M29/vnyDySzbN30ieZv8VWTrrwWtgomvrV2Ru+b
	Zp+iuUH9YSnECBdlyCt21KkXPkV1K+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784113394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/w0/JofSGuJID6gCR3ETcE1l/O+Ym8fL3mervCh8EY=;
	b=DU86yZ9iikGFjQnG2BvTDTZqu9ae/Nrwml7rvrJ5f1gjjqLgaMZOljkqFv8Yg6EtZZ3S0I
	04jRuyg7ww8dBECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D47F779AD;
	Wed, 15 Jul 2026 11:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qy1EO/BoV2oOfQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 15 Jul 2026 11:03:12 +0000
Date: Wed, 15 Jul 2026 12:03:11 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Gregg Leventhal <gleventhal@janestreet.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
	Eric Hagberg <ehagberg@janestreet.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when
 collapsing
Message-ID: <aldo3HN27b5PoQyz@pedro-suse.lan>
References: <20260702165409.164568-1-pfalcato@suse.de>
 <akhYu66GmjyM8l6a@casper.infradead.org>
 <CAFN_u7HkJry=iFLbZ2vjzv5C=HnrptHfFJBLOqRq2m4LyhqV_w@mail.gmail.com>
 <ak5g9h3FuVn3bZ1G@pedro-suse>
 <CAFN_u7ExSnVo=QQBuZvRJkLR3rHo8qN96rDKYu+KNiSjk0FCHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFN_u7ExSnVo=QQBuZvRJkLR3rHo8qN96rDKYu+KNiSjk0FCHQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 
X-Spam-Score: -4.30

On Thu, Jul 09, 2026 at 08:52:47AM -0400, Gregg Leventhal wrote:
> Ack thanks for the update and all of your help with this!

You're welcome!

> Obrigado pra vc (Meu esposa e Brasileira e achei que vc estava
> Portugues da sua nome/sobrenome)!

Hah :D

> 
> On Wed, Jul 8, 2026 at 10:40 AM Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > On Wed, Jul 08, 2026 at 10:05:43AM -0400, Gregg Leventhal wrote:
> > > Hi there, just checking on the next steps here.
> > >
> > > @Pedro Falcato Are you currently working on this patch (mentioned
> > > above, re: holding invalidate lock), or are we perhaps stalled on
> > > something?
> >
> > I was waiting for some actual tags from people, but given the comments and
> > no tags, I'll respin a v2 before sending to Greg KH.
> >
> > --
> > Pedro

-- 
Pedro
