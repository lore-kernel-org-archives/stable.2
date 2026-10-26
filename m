Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021004;
	b=H2K8kSVRcB8xKc86zV+N+9QWEyksxr4zdUWBtfyM4tjAOXTUWZZE36LfmmBnN3eZLjkW
	 IH3rYy7evL3GMRVmwzF8EXKs3x5Qmxoh6Kji4Lit2V0eYRo6z7XOkuxwLmAZZsXxu3nNa
	 V73XZR84vayh3PFgINQTR1xziMaHraoOzrZbqi0omCU8RHRypaFts0hihgh7QG3iC9GkF
	 rJF6o+JHmQNmY0nNYYzg5dA47gONF6n1Nzp+quLNEhPgWDHEMxooONeYtULhYQgwkVPtY
	 c4IDNLOI49rV7hGE1W8BL9StNl82Ha3VKcPnyDaRNv+huyjW1hOioHcPyrI76SXwdwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021004;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=54BFzYUW6swCFljasaktNgeI4y2LeWT1KlgHkjBqlXM=;
	b=nj0ZTkumZwBuaaWtdchwZQDp2bME62sjCwSF4CmUW1empwVFneUzz/JNSuCKhFoR0854
	 6I006KTxO0Pdce4DtYqCbxuGJz6tGJ/tHbgKwqnP4i5XJX7q2neOFC63tckV/K6taOpsy
	 PA2B18uKWJ6h9uigQXtfmBhVTVviv2xEHIyCS5vLuQC7cq/dLscrRgEGE2qjBMF9JB2In
	 q2Qt1+JStTEeeDLHEx7dLJQ2tr8ylErIVyERC7TIX8rWlH8sIwM5JwAuucnMJbQDrCD97
	 rcjjwChqkDDcJbPxxZWXdEds+jG1Pta6cRPTvjWUsKY3EiCdHnY6wqiz+OQvBx3yoPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xUTHZBxn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rFNA1ckD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xUTHZBxn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rFNA1ckD;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F840606A31A;
	Mon, 26 Oct 2026 13:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F840606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xUTHZBxn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rFNA1ckD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xUTHZBxn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=rFNA1ckD
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0B091F7A2;
	Mon, 26 Oct 2026 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793021001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54BFzYUW6swCFljasaktNgeI4y2LeWT1KlgHkjBqlXM=;
	b=xUTHZBxn6Fo2g52rorYT5AJWKzV66Id23PhftBav30xkl7j6RiYh69IPrW90yW1RBaBcRA
	g4zduRyUpGY0uxhtNlpauSE01zaC7UwyXK6WhqS7dxLU2kTlG9/JEemDkwNUHGkwp2kjB2
	AHURIxwMFenZE6FTzRb5SogE2S0+BoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793021001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54BFzYUW6swCFljasaktNgeI4y2LeWT1KlgHkjBqlXM=;
	b=rFNA1ckDmi0Lx++fuoLze4EEJUg5M/hJz+fhBtonx3VevMQAHz3F93vSWv0YI5az+v6NB2
	tDvWHLjF2Kk9sxBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793021001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54BFzYUW6swCFljasaktNgeI4y2LeWT1KlgHkjBqlXM=;
	b=xUTHZBxn6Fo2g52rorYT5AJWKzV66Id23PhftBav30xkl7j6RiYh69IPrW90yW1RBaBcRA
	g4zduRyUpGY0uxhtNlpauSE01zaC7UwyXK6WhqS7dxLU2kTlG9/JEemDkwNUHGkwp2kjB2
	AHURIxwMFenZE6FTzRb5SogE2S0+BoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793021001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=54BFzYUW6swCFljasaktNgeI4y2LeWT1KlgHkjBqlXM=;
	b=rFNA1ckDmi0Lx++fuoLze4EEJUg5M/hJz+fhBtonx3VevMQAHz3F93vSWv0YI5az+v6NB2
	tDvWHLjF2Kk9sxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 917C613408;
	Mon, 26 Oct 2026 13:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e6j3DkhU32pqcAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 13:23:20 +0000
Date: Mon, 26 Oct 2026 13:23:18 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, liam@infradead.org, 
	ljs@kernel.org, vbabka@kernel.org, jannh@google.com, usama.anjum@arm.com, 
	avagin@gmail.com, mirq-linux@rere.qmqm.pl, arnd@arndb.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: return -ENOTTY for unknown pagemap
 ioctls
Message-ID: <at9Rqspz6uUpu7H9@pedro-suse.tail5790ac.ts.net>
References: <20261023181300.3366487-1-hengyul@cs.unc.edu>
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
In-Reply-To: <20261023181300.3366487-1-hengyul@cs.unc.edu>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,infradead.org,kernel.org,google.com,arm.com,gmail.com,rere.qmqm.pl,arndb.de,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -13.30

On Fri, Oct 23, 2026 at 02:13:00PM -0400, Hengyu Liang wrote:
> Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
> optionally clear info about PTEs") made do_pagemap_cmd() the ioctl
> handler of /proc/<pid>/pagemap.
> 
> However, do_pagemap_cmd() returns -EINVAL for every command other than
> PAGEMAP_SCAN. Before that commit, pagemap had no ioctl handler, and
> the VFS returned -ENOTTY for these commands. As of now, they fail with
> EINVAL, so tcgetattr() and isatty() on pagemap report EINVAL instead
> of ENOTTY.
> 
> The issue can be reproduced with a simple C program:
> 
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <termios.h>
> 
>     int main(void)
>     {
>             struct termios t;
>             int fd = open("/proc/self/pagemap", O_RDONLY);
> 
>             if (tcgetattr(fd, &t) < 0)
>                     perror("tcgetattr");
>             return 0;
>     }
> 
> Before that commit, the result is:
> 
>     tcgetattr: Inappropriate ioctl for device
> 
> After that commit, the result is:
> 
>     tcgetattr: Invalid argument
> 
> This patch will return -ENOIOCTLCMD for unknown commands, as
> procfs_procmap_ioctl() in the same file does, so that the VFS turns it
> into -ENOTTY.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

I would generally be scared of applying this change, but since this is a
niche API, and there are no other ioctls for it, this should be fine.

-- 
Pedro
