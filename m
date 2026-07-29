Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8254963BB
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339281; cv=none; b=VxPmG2fQSW0XeWEoYe6ZJ1hQtOhzkK0FSqBcA7tUYSlDSYyI6aCDYdDfZRn+Z8mQk+TArwVD3c+onJwOwDGBufMvDkDaFNcTpKtW6CsVj30God8DcpEzcink2dnd6lDgpRNZMBBeJQpUK4pM1hAz/UeWOG5TyVKAb/VzpoMbWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339281; c=relaxed/simple;
	bh=RYySE8QNU+kB6X5dNdCUHKsfX484LzDrUnEbZKeFJ+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nhnqh9pHB7XRPic6gu3XSM0rA7AqzSRWqKIjfDtys3EZU3kqAtX1PVI4bJUFFAiHFo9dD3KL1Og9u6mTmxkvOJ7ZhORn+hlBC2vzpIhN520flauZCZhpggOJJN/5sEcpIWs1kRkuD9rE5hf4FLLuiAeA0Xt/TFSXy81W3tl0qVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VaQbbxrN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mz8BSUan; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UNFUfrP5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hx9S7qIg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VaQbbxrN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mz8BSUan";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UNFUfrP5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hx9S7qIg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDD1A3DF5;
	Wed, 29 Jul 2026 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785339271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFxpVbfeeny1I0S74Yz31lzU4EqRQqdxaIGxBTwuzKc=;
	b=VaQbbxrNoYu38Bmbt44rc8DjimNpc8YPAJ5elLXI8HrpKPbTmSfI0QPxbq92tdBSwGHNe3
	nIK9Z3HGjHBFSWjSwynwwY11OLiCxLV9Mxf9aU7U57mLfuB7KVnMSxHk1Na4uBitcOs9S1
	QuurRKYZxX6X0lFan+xVOqzb0KT9ig4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785339271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFxpVbfeeny1I0S74Yz31lzU4EqRQqdxaIGxBTwuzKc=;
	b=mz8BSUaniIvIr8385LTs684P7kGytRYounzNl/weU0rZV8Wf0jkG6PuL6NlYH8+zms08uF
	Bkq7E540tHgfv1Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785339267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFxpVbfeeny1I0S74Yz31lzU4EqRQqdxaIGxBTwuzKc=;
	b=UNFUfrP5UkYZVn54jwnBI4m5yI/Xq4UItIM8wa23CY1GRC7rpchPgTDgFYgP17vt3cM/y2
	1b/XtjC2cSvpLNiiCGGvxrXrPC0pkF+pbQ7NW+gQi5G4obPZbIgl5SsIIwOUSfBHnGxl/3
	op5Ouwpzbjq3al0od+I5NH9UKdwu1Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785339267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iFxpVbfeeny1I0S74Yz31lzU4EqRQqdxaIGxBTwuzKc=;
	b=Hx9S7qIgKFCQaJCHe7YcQ2C0J1e978BzIPWNeOQhvTpOdCMDPehk4bAsWNlhIyEHW7CHmh
	GKHv3jK2Etd9F0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E79A779A1;
	Wed, 29 Jul 2026 15:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 66DHDoMdamq4dwAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 29 Jul 2026 15:34:27 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Baul Lee <baul.lee@xbow.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org, Baul Lee
 <baul.lee@xbow.com>
Subject: Re: [PATCH] io_uring/net: don't truncate the bundle segment length
 to int
In-Reply-To: <20260729151504.47280-1-baul.lee@xbow.com>
Organization: SUSE
References: <20260729151504.47280-1-baul.lee@xbow.com>
Date: Wed, 29 Jul 2026 11:34:25 -0400
Message-ID: <87qzklhkse.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]

Baul Lee <baul.lee@xbow.com> writes:

> io_bundle_nbufs() works out how many buffers a short bundle transfer
> consumed by walking the mapped iovec and subtracting each segment from the
> transferred length:
>
> 	do {
> 		int this_len = min_t(int, iov[nbufs].iov_len, ret);
>
> 		nbufs++;
> 		ret -= this_len;
> 	} while (ret);
>
> iov_len is a size_t while this_len is an int, so a segment longer than
> INT_MAX comes out negative.  ret then grows instead of shrinking and the
> loop keeps walking, reading past the end of the array it was handed.
>
> The recv bundle path can hand it such a segment.  io_recv_buf_select()
> folds sr->mshot_total_len into arg.max_len, and that field is unsigned and
> taken straight from sqe->optlen:
>
> 	if (sr->flags & IORING_RECV_MSHOT_LIM)
> 		arg.max_len = min_not_zero(arg.max_len, sr->mshot_total_len);
>
> With sqe->len left at 0 nothing else lowers it, so arg.max_len can be
> 0xffffffff.  io_ring_buffers_peek() clamps each buffer against that rather
> than against INT_MAX and records an iov_len above INT_MAX; a short receive
> over that bundle then enters the loop above.
>
> An unprivileged multishot IORING_OP_RECV with IOSQE_BUFFER_SELECT and
> IORING_RECVSEND_BUNDLE, a provided buffer ring registered with
> IOU_PBUF_RING_INC holding two buffers, and two bytes of data is enough to
> reach it.  The two-entry iovec is a 32-byte kmalloc:
>
>   BUG: KASAN: slab-out-of-bounds in io_bundle_nbufs+0x114/0x1a8
>   Read of size 8 at addr ffff0000d39a1b68 by task io_repro/165
>   Call trace:
>    io_bundle_nbufs+0x114/0x1a8
>    io_recv_finish+0x138/0xa38
>    io_recv+0x38c/0x1008
>    io_issue_sqe+0xc4/0x155c
>    io_submit_sqes+0x6d0/0x1fac
>    __arm64_sys_io_uring_enter+0x30c/0x1180
>
>   Allocated by task 165:
>    __kmalloc_noprof+0x1b8/0x444
>    io_ring_buffers_peek+0x57c/0xbb4
>    io_buffers_peek+0x168/0x2a0
>    io_recv+0x598/0x1008
>
>   The buggy address is located 8 bytes to the right of
>   allocated 32-byte region [ffff0000d39a1b40, ffff0000d39a1b60)
>
> Count in size_t.  ret is positive by the time the loop runs, since the
> function returns early for ret <= 0, so widening loses nothing; this_len
> stays bounded by ret, and the mapped length is never less than ret, so the
> walk ends inside the array.
>
> Fixing it here rather than by capping arg.max_len keeps the accounting
> correct for every caller and does not disturb buffer selection: an
> arg.max_len of 0 is a distinct "not set yet" state that
> io_ring_buffers_peek() tests before it applies its own INT_MAX default,
> and pre-filling it changes which bundles get expanded.
>
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
>
> Fixes: a05d1f625c7a ("io_uring/net: support bundles for send")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

-- 
Gabriel Krisman Bertazi
