Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C03E0088
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466053; cv=none; b=uDlwNN9KBgtvb7hAwRM7+NmZiIRDNKRDjB7Wrf1pCgAC6kbmeiOkINcxFF581DJ7djsTWIXALaHb6cYrR7zq9mEpAfH1GgQOis6GrXAS038au8E2NvF2vwT8Ha3olk4Now1y1TBLXPqq+B9H+kkTfI7gm9aGvpZ78sqJXjQ8H6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466053; c=relaxed/simple;
	bh=qNo/P4aBrivxJDbLRAJAe2Mn+KZ5S3c4NlUn7Gz5y48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb7Bk5E0Sf62/om+LMRX8HMb1SrURKJP85vRQZgoFyDboIixrxFeGk4YR6x2EBYAYuNAE8UdNW+Fh3ctwm7a1+iqlV3jMzKH/1Awg7KOKXtf5VZAJJUtfBvPxDeYJmn4jGCBY8pfWN+1ASIp8r1GYqAB9TK1idyoaQzX/aMu8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uNbnnCSG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yi8gbCIK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uNbnnCSG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Yi8gbCIK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uNbnnCSG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yi8gbCIK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uNbnnCSG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Yi8gbCIK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 248C47202A;
	Fri, 26 Jun 2026 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782466049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm9GkPZgMILFXO0HgO0WZxcUbxtpw+aIH3Dw3qsNCSQ=;
	b=uNbnnCSGjX5hpmGMhLswAOlc4+yp2tZrpYPqhVNeKyF3gfeW4dH6VVmW0mVKZGuunzbiDw
	8/wlOJMTIKySeaWvBpGP2Sng7T71rCPsrppRMdKPuXQdCArXqr1qAHwT64xaVit25+3N2B
	R2y0zXHEEVoQoFCD6FfZE40uVdZCtww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782466049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm9GkPZgMILFXO0HgO0WZxcUbxtpw+aIH3Dw3qsNCSQ=;
	b=Yi8gbCIKKgb84pwirQuv5siBaoS1ofZvh9okdEffpJwnKObaQM224qMcZD8LIkrOu/N2++
	NTsoHslAH4S0r+BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uNbnnCSG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yi8gbCIK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782466049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm9GkPZgMILFXO0HgO0WZxcUbxtpw+aIH3Dw3qsNCSQ=;
	b=uNbnnCSGjX5hpmGMhLswAOlc4+yp2tZrpYPqhVNeKyF3gfeW4dH6VVmW0mVKZGuunzbiDw
	8/wlOJMTIKySeaWvBpGP2Sng7T71rCPsrppRMdKPuXQdCArXqr1qAHwT64xaVit25+3N2B
	R2y0zXHEEVoQoFCD6FfZE40uVdZCtww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782466049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm9GkPZgMILFXO0HgO0WZxcUbxtpw+aIH3Dw3qsNCSQ=;
	b=Yi8gbCIKKgb84pwirQuv5siBaoS1ofZvh9okdEffpJwnKObaQM224qMcZD8LIkrOu/N2++
	NTsoHslAH4S0r+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38E2B779A8;
	Fri, 26 Jun 2026 09:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uvl/CgBGPmqDQAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 26 Jun 2026 09:27:28 +0000
Date: Fri, 26 Jun 2026 10:27:26 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: do file ownership checks with the proper mount idmap
Message-ID: <aj45h0NkbToPN_i_@pedro-suse.lan>
References: <20260625153853.913949-1-pfalcato@suse.de>
 <20260625112903.f961fc41a0b0f8dd1f1a9fdd@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625112903.f961fc41a0b0f8dd1f1a9fdd@linux-foundation.org>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,pedro-suse.lan:mid,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 248C47202A
X-Spam-Score: -4.51

On Thu, Jun 25, 2026 at 11:29:03AM -0700, Andrew Morton wrote:
> On Thu, 25 Jun 2026 16:38:53 +0100 Pedro Falcato <pfalcato@suse.de> wrote:
> 
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
> 
> Do our idmap selftests tickle these issues?  If not, is it hard to add?

In theory we could add this to tools/testing/selftests/mount_setattr/mount_setattr_test.c, but
that seems like the wrong place for an mm regression test. And if we add it
somewhere else, we'll have to deal with the bureaucracy of setting up an idmapped
mount (including setting up a filesystem image!). I'm taking suggestions :)

> 
> > I noticed there are a couple of call sites in fs/ that could perhaps be
> > cleaned up with the added helper, but I'm skipping that for now for brevity's
> > sake.
> 
> You could do this as a 2-patch series, because:
> 
> >  include/linux/fs.h | 5 +++++
> >  mm/filemap.c       | 2 +-
> >  mm/madvise.c       | 3 +--
> >  mm/mincore.c       | 3 +--
> >  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> it touches mm/ but ->Christian, please.
> 
> (or I can queue it with Christian's ack, of course)

Understood.


-- 
Pedro
