Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BB440803D;
	Fri,  9 Oct 2026 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525533; cv=none; b=P9ynftD1BfcQY6PmTG60VlALrnigGW2tobK7Vm9KGu2qptp3eInykhb1NzO5w4THmQUseRUrQDp+2CCJGi33sSq/KvDx4GctgsBICgyToLgiHqcZpIjKrBApkdkZ2AtGIgUUKZaYfuAsDwE7W+lyLfyyJ0QT2mD9j60wWenbl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525533; c=relaxed/simple;
	bh=KjK8ntwPO6bSpyBoSTYcmLXAZ1NuFeJD6b1g7yEq6OI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUz3Mv+a1aJ/bru2IzVipFAkyG89sP5QM+ysigZr6ZzqoOKGH4NJMqjA4AUroLi4BG0+3YB2niHChpxY5g3iGS346cfoxLQG0FRJlIXqhovxTADzal7b7ggMs/UaHxVtoeCz2hwZXzZo6lsAfoqAwT/kabz/2zdWQw6Wi9POh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAR/z1zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAR/z1zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05B11F0089B;
	Fri,  9 Oct 2026 05:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791525531;
	bh=XMDi6LSC4gfBO0GBDHQ2H3dSPEu1MrCd8/4Fxy8VdP0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iAR/z1zrXms15Snodx9FlR52rB+oiG7RyMp0E+VlIceeH8btwWxixgfoo6mwSawkL
	 oQA59cu6+hktQd96RyGOirYUwwP02R8lmKzYCFSTWuGgYai+EJ9rqmtZULWMMTXoQw
	 TWtZ1oL/S5M1yJN5R10A8k0YjE1TH5VUf6fDHPoCb+sfxLrblWSUr5aLGY0XJVyzmd
	 U81soclsoIjLrb7h4p8PbojWSWBcxAuUEcRrNrtE0LBWf8qC3pxQV4YOHRLwRh0Lp4
	 s3aRVW4uT/fOdvSWbNtUa5HssKHPC/xQ5pl1100qAPdesJMOTOE2eVWJcNr1DlXa9k
	 TTdoanUNvBeYA==
Subject: Re: [PATCH] tun: fix skb length underflow in NAPI frags path
From: netdev-bot+sashiko@kernel.org
To: harshit.m.mogalapalli@oracle.com
Cc: maheshb@google.com, willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, peterpenkov96@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, error27@gmail.com, stable@vger.kernel.org
Date: Fri, 09 Oct 2026 05:58:50 +0000
Message-ID: <179152553052.434549.7841966987517379353@kernel.org>
In-Reply-To: <20261005054224.4154727-1-harshit.m.mogalapalli@oracle.com>
References: <20261005054224.4154727-1-harshit.m.mogalapalli@oracle.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This fix is incomplete.

Pre-existing issues:
- [High] tun_napi_alloc_frags() builds fragments from `iter_iov(it) + i`
  and the raw `iov->iov_len` (drivers/net/tun.c:1505-1506).
- [Low] In tun_get_user(), the `if (msg_control)` block
  (drivers/net/tun.c:1837-1849) still computes copylen/linear and walks…

--

tun: fix skb length underflow in NAPI frags path

This patch moves the clearing of zerocopy for the IFF_NAPI_FRAGS path in
tun_get_user() so it happens before copylen is computed. The NAPI frags
allocation is then sized for the complete iterator instead of the zerocopy
linear prefix. This avoids a skb->data_len underflow and a BUG() in
__skb_pull().

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5a302709a68aa..1124b8b33664e 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1848,6 +1848,10 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* The NAPI frags path copies the complete iterator. */
> +	if (frags)
> +		zerocopy = false;
> +

[Severity: Low]
This isn't a bug introduced by this patch, but with this override in
place, the msg_control block just above in tun_get_user() has no useful
effect when frags is set:

drivers/net/tun.c:tun_get_user() {
    ...
	if (msg_control) {
		struct iov_iter i = *from;

		/* There are 256 bytes to be copied in skb, so there is
		 * enough room for skb expand head in case it is used.
		 * The rest of the buffer is mapped from userspace.
		 */
		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
		linear = copylen;
		iov_iter_advance(&i, copylen);
		if (iov_iter_npages(&i, INT_MAX) <= MAX_SKB_FRAGS)
			zerocopy = true;
	}
    ...
}

For frags, the !zerocopy branch overwrites copylen and linear, and the
result of the iov_iter_npages() walk is discarded.

The comment doesn't describe the frags path either. It also says 256
bytes, but GOODCOPY_LEN is defined as 128.

Would gating the block with msg_control && !frags make the code and the
comment agree, and also skip the extra iov_iter_npages() walk?

>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
>  		/* For the packet that is not easy to be processed
>  		 * (e.g gso or jumbo packet), we will do it at after
> @@ -1868,11 +1872,6 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		if (frags) {
>  			mutex_lock(&tfile->napi_mutex);
>  			skb = tun_napi_alloc_frags(tfile, copylen, from);

[Severity: High]
Does this fully close the underflow described in the commit message?

copylen is an int, but len is a size_t taken from iov_iter_count(). The
frags path now always goes through this assignment:

drivers/net/tun.c:tun_get_user() {
    ...
		if (!zerocopy) {
			copylen = len;
			linear = min(hdr_len, good_linear);
		}
    ...
}

tun_napi_alloc_frags() checks the truncated value against ETH_MAX_MTU. It
then takes linear from the first segment, which is not truncated:

drivers/net/tun.c:tun_napi_alloc_frags() {
    ...
	linear = iov_iter_single_seg_count(it);
	err = __skb_grow(skb, linear);
	if (err)
		goto free;

	skb->len = len;
	skb->data_len = len - linear;
    ...
}

So when len is over 4 GiB, the first segment can still be larger than the
allocation length.

vhost-net appears able to deliver such an iterator to an IFF_NAPI_FRAGS
TAP backend. init_iov_iter() adds the guest descriptor lengths into a
size_t, and get_tx_bufs() only rejects a length of 0. The default copy
mode then calls handle_tx_copy()->tun_sendmsg()->tun_get_user() with
msg_control = NULL.

For example, this needs a guest memslot of at least 4 GiB. The guest
builds a chain whose first iovec is about 0xfffffff3 bytes after the
vnet header, followed by a 272 byte iovec. That gives len = 0x100000103
and copylen = 259:

- __skb_grow() with diff = 0xfffffff3 passes a negative ntail to
  pskb_expand_head(), so it makes a small allocation instead of failing
- skb->len = 259 and skb->data_len = 272
- skb_copy_datagram_from_iter() and pskb_may_pull(ETH_HLEN) both succeed
- eth_type_trans()->__skb_pull() sees skb->len < skb->data_len and
  calls BUG()

Copy mode already reached copylen = len before this patch. With this
change, the msg_control case reaches it too.

Would it make sense to pass the size_t len directly to
tun_napi_alloc_frags(), or to reject lengths that don't fit in an int
before narrowing?

[Severity: High]
This is a pre-existing issue, but tun_napi_alloc_frags(), which this fix
relies on, assumes the iterator is ITER_IOVEC. It also doesn't clamp the
last fragment to the remaining count:

drivers/net/tun.c:tun_napi_alloc_frags() {
    ...
	for (i = 1; i < it->nr_segs; i++) {
		const struct iovec *iov = iter_iov(it) + i;
		size_t fragsz = iov->iov_len;
    ...
}

io_uring IORING_OP_WRITE_FIXED on a tun fd reaches tun_get_user() through
tun_chr_write_iter() with an ITER_BVEC iterator. io_import_fixed() sets
the count to len, but the last bvec keeps its full bv_len:

io_uring/rsrc.c:io_import_fixed() {
    ...
	nr_segs = (offset + len + bvec->bv_offset + folio_mask) >> imu->folio_shift;
	iov_iter_bvec(iter, ddir, bvec, nr_segs, len);
    ...
}

In this case iter_iov() returns the bio_vec array cast to struct iovec.
On 64-bit little-endian, iov_len reads as bv_len | (u64)bv_offset << 32.
For page-aligned bvecs that is just bv_len.

Take a 5000 byte write from a page-aligned registered buffer. linear is
about 4084 and data_len is about 904, but the second fragment is given a
size of 4096. skb_copy_datagram_from_iter() writes only 904 bytes into it.

Can this leave about 3192 bytes of uninitialized netdev_alloc_frag()
memory inside the fragment? The fragment sizes would then add up to more
than skb->data_len.

If so, anything that later walks the frags by skb_frag_size() could expose
that memory.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005054224.4154727-1-harshit.m.mogalapalli%40oracle.com
