Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A35326927
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229384; cv=none; b=pNGRj2mDSlCoH7ESNnjQXGzPI3DoI6juZvcs9bGRH6/xpfJtby+iftuzR8cNCtUBVNeY+MCuq7+iETedTqxWnMUHAwugl0n/oX3ZwhFy6qYcgGQJ5FaivS+y2bA/4Qh4nxMqMb/AAPqcBA/UKu/zgq2YHVKHs8wtuP7MAi6ZTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229384; c=relaxed/simple;
	bh=iKxf5flFKBV19jyinhFCfT0EdHAoCCxA/Z0YqlhbNmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km33iTUgZ+V4HtVO7XnxJ9y/GgQoBJPMQWdtQAIexd8FBes1Uef8ClcDdxrwqIcEurdu63B9flHtlHcaPX5g6X70Y4yfz9gtKTZqRTNB5eLx+Qj5V7aQViout11VAlW3k2ELwBYSUL3nRD99k33Se//5IuK0B6N5r2ZDZbkNC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wYb8resh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2fmHCJd2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YtuIeJiX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qCzd+wAK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wYb8resh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2fmHCJd2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YtuIeJiX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qCzd+wAK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8DCB7BFED;
	Tue, 28 Jul 2026 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785229375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiBhapS4yd3JBk3wJMMLnPaSViFMEz/i6gX+eA+O2Vw=;
	b=wYb8reshhb4u0odztJ4Ng+smZ5J/g0IrHOApYodJP5HrMPW3BPbXz66qTehSjGLKS5TPMW
	IufzoIzv3NhZofGV8MrrD6vVVY0XE9PJDgJaaxH/EI957SzxW6GXDJpA0cmesNZk3+bvXh
	jfpO1OI/R71BOdq6tm1KxaVwcOdAxTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785229375;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiBhapS4yd3JBk3wJMMLnPaSViFMEz/i6gX+eA+O2Vw=;
	b=2fmHCJd2idKLYwAG+LkZgqszy4AFjM4N5MUlg7YvQJguxz/QLAaz7wrsfD2ra0aK7EgmGu
	KL65yyCf1wAPVuDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785229371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiBhapS4yd3JBk3wJMMLnPaSViFMEz/i6gX+eA+O2Vw=;
	b=YtuIeJiXTMplrLFSdAxB66MlqasaLVnU1LDXcuVat/qqWUTXIbj02psFQaGNvhoiILuMv/
	lmfU1TUpshjZDU9yES5Ib//lY6CLu+v3FOsibGfxv2mAvX02t94bYdvUjN8PlXiXfxIPTt
	p96Euc/+3XFdZWZKJlcxHtJ/mrG95yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785229371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiBhapS4yd3JBk3wJMMLnPaSViFMEz/i6gX+eA+O2Vw=;
	b=qCzd+wAKRqGnVNA1kDTbGrTP60YRDlO94dCbG1lOIlVEkDB0FNtXMblzA/P4RmwE2USyE6
	RfP08vH81oxFEeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C269F779B3;
	Tue, 28 Jul 2026 09:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8zFPKzpwaGrJVAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 28 Jul 2026 09:02:50 +0000
Date: Tue, 28 Jul 2026 10:02:49 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: do file ownership checks with the proper mount idmap
Message-ID: <amhoqhLlYROZXOLh@pedro-suse.lan>
References: <20260625153853.913949-1-pfalcato@suse.de>
 <20260728-kreieren-innehalten-anbot-d92ce2dd10bd@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-kreieren-innehalten-anbot-d92ce2dd10bd@brauner>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Tue, Jul 28, 2026 at 09:52:26AM +0200, Christian Brauner wrote:
> > Ever since idmapped mounts were introduced, inode ownership checks
> > (for side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were
> > done against the nop_mnt_idmap, which completely ignores the file's mount's
> > idmap. This results in odd edgecases like:
> > 
> > 1) mount/bind-mount with an idmap userA:userB:1
> > 2) userB runs an owner_or_capable() check on file that is owned by userA
> > on-disk/in-memory, but owned by userB after idmap translation
> > 3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied
> > 
> > In the case of mincore/madvise MADV_PAGEOUT, this is usually benign, because
> > file_permission(file, MAY_WRITE) will probably succeed, as it uses the proper
> > idmap internally, but it does not need to be the case on e.g a 0444 file
> > where even the owner itself doesn't have permissions to write to it.
> > 
> > Since this is clearly not trivial to get right, introduce a
> > file_owner_or_capable() that can carry the correct semantics, and switch
> > the various users in mm to it.
> > 
> > The issue was found by manual code inspection & an off-list discussion with
> > Jan Kara.
> > 
> > Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> Did that go in?

Yes, this is e187bc02f8fa4226d62814592cf064ee4557c470 in v7.2-rc3.

-- 
Pedro
