Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523850;
	b=v6pPWxEa4QQ4mIPVQwBvRp4r15PuhLbsQXz2xBWi8KOyKsqA02cNh8b0JBphutXuN7je
	 KdOhn+k5CZJ0Ti4edRI03yqoDXl9NNXP277nhQ9bXobFviFUecUoc9lm29b+wF6JDI1nI
	 H6SVPMdu3S1s1Akon9l3z5NXBtp/PIuxmvPatVVCuL0+WACYwAE7GLUo1TSXFL/KHOfcF
	 ZlXQzbmFCteUVh0vFfTX99agvP6pV0DPoc3TZ+NuFDRRRTDYo4L+J6YOneKKvNIS7lWOl
	 q50RCF/6V6tQE0654wTUPphU+DZmb+n89HaA3xCCICASYxmAnynqf9vgLqeRf4vxchg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523850;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-Id:In-Reply-To:
	 References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ff3sLRxeUDMugyE2S/4/TFkGvIfGSSqcHfHI+ezBKqU=;
	b=R7Y7jLzhJy1hUgF/Wn3FTPZG268qjgItGUVNeU2QAakOY2X1iRckgG5LSYUBIv8vbVzJ
	 EtEQFxdQsAvJ2NWBugWEqdP96l0XbN2aFxjLlkX0GraiE7v4xZOrR5xqlXGxx2wLTjXsy
	 SFe7kOo8IoNz3fYGsjaaf4jwpeeEO9nTyzmtbIJymvCB9YpMHcufTx7OqO0AG7Xef13fN
	 hMQrkPvp5FPz0UeY4y6hk0GKi49jTtsRx3u/xUu9YvUZW6niCYl0+944eZHNmRoglWSP1
	 6i2rVpPkWETW1HKtkWkJstoksPnsK8My/gEr1EK8WoDe+3VhRUtIG0raIJE65nq28wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xv4ST6Na;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495DE606A31A;
	Tue, 20 Oct 2026 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=xv4ST6Na
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997771F000C9;
	Tue, 20 Oct 2026 19:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792523850;
	bh=ff3sLRxeUDMugyE2S/4/TFkGvIfGSSqcHfHI+ezBKqU=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=xv4ST6Nag88oAYWpyv551AfI9zpUzNZnCzAOte4Fkk0QN5SR5UiGfBs7y3poGsY8x
	 50jXMk07bN5t6PwTsisiPC8i1e6w9OB5APuv4+cElGui3enOywnmjiNnwDZSsMELqd
	 64dYGIszYbjodDfFuyo+OVUC+sexvxnBkeP93Bs4=
Date: Tue, 20 Oct 2026 12:17:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: viro@zeniv.linux.org.uk, tz2294@columbia.edu, stable@vger.kernel.org,
 l1za0.sec@gmail.com, kbusch@kernel.org, hch@lst.de, hare@kernel.org,
 4ncienth@gmail.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [patch 1/1] iov_iter: validate extracted segment for bvec
 alignment
Message-Id: <20261020121729.20f67583f23babed12f998ee@linux-foundation.org>
In-Reply-To: <20261020184333.19AAA1F01573@smtp.kernel.org>
References: <20261020184333.19AAA1F01573@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 11:43:32 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> From: Daehyeon Ko <4ncienth@gmail.com>
> Subject: iov_iter: validate extracted segment for bvec alignment
> Date: Thu, 15 Oct 2026 15:19:07 +0900
> 
> iov_iter_extract_bvecs() validates iter_iov_addr() and iter_iov_len()
> before iov_iter_extract_pages() selects the first nonempty segment and
> limits it by iter->count.  The checks can therefore cover a different
> range after a leading empty segment or iov_iter_truncate().
> 
> An unprivileged O_DIRECT preadv() reproduced the empty-segment case: an
> aligned empty segment followed by a misaligned one completed 4096 bytes
> instead of returning -EINVAL.  A truncated iterator has the same mismatch
> when its full segment length is aligned but its remaining count is not.
> 
> The worst effect I have confirmed is an alignment-contract bypass.  An
> unprivileged O_DIRECT preadv() produced bvecs with offset/length pairs
> (1, 4095) and (0, 1).  The bio reached brd_submit_bio(), and the read
> completed 4096 bytes instead of failing with -EINVAL.
> 
> I have not demonstrated harmful behavior on real DMA hardware.  For a
> normal blk-mq target, blk_mq_submit_bio() calls
> __bio_split_to_limits(), where bio_split_io_at() rejects the misaligned
> bvec before queue_rq().  Virtio-blk and loop both returned -EINVAL in
> my controls.
> 
> So a bio-based driver can receive a bvec which violates its advertised
> dma_alignment, but any further effect is driver-specific.  I have not
> reproduced memory corruption or a crash on real hardware.
> 
> Bound the normal fast-path length by iter->count.  Keep
> first_iovec_segment() for leading empty segments so validation covers the
> remaining portion of the segment available for extraction.

I guess I should have added

Tested-by: Andrew Morton <akpm@linux-foundation.org>	#writev() only


I tested this against the ext4 writev() KASAN reproducer.  The
unpatched kernel triggered a slab out-of-bounds read and returned 1015
bytes.  With the patch applied, writev() returned the expected 1025
bytes without a KASAN report.  But I didn't test the preadv() path.


