Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25CB3F4DF3
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 03:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950355; cv=none; b=j+A+bA243LbyM/sPY0w12dsdGslFP9ws7b0d2dq0IMSXQMGIExLwBEPAv4hXl5Uh8xv72nLJ2SX5w2QKUfzU/NkCHF3Ys3A89scIo0Rg81GodKfXZW9ceoonkKGyi3yPtR7XJWMJq1+Ao9FV+EqIHaOzBOMAlCNckA8217CJuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950355; c=relaxed/simple;
	bh=UHe31DZB0nVpQKek8RtayuPW7SrG61Ae4OAKhFVXocs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Kkst8N65LfI62LEQQictILrRBsF6oEpYcegcU8RgqD0EglF9Pi3/ofZ7HPekdQ5Xxir3ZTJSlIQyQHBGM+292dGROW8qNQbId8U3kHdgfZvx4PiZ0xSWsbeQhYUto6TcNmTUfvjbQVvBEO93oBBLcmHYyh90WzpysKH56uVh240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISy/JFHa; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISy/JFHa"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ae8607e8afso25523187b3.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791950353; x=1792555153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WkMUe/NsYTM0ez+xe3tw/2n8+K1FB1iD4W4PefzB3ik=;
        b=ISy/JFHabc3VHYlQWREj9rlzFSTwum64aJK5yMDNgPbQc3PNbTPWy32+G9zhKEkcGb
         CLFsBMYuj4YF6g+XKBkFFfDngibR3YTG7VcN9w/KaQ7Xnk4QUYn1dRm/HRVnaLPwbD/s
         i8awDCpRuMY0dMym4PDMB2xBTrwyaRs+rpUgY5u2iKPsjCIayIIonZiSIT516jp6b9vr
         /sdbakXLLN8kkCHcKec+v438t1NTByGx66m6yXjFnA9is1wY9eNJ2Nk6gDP4IKIjCKTD
         5qFvR1KMkpfjJVtu1wUv5TvITYy99ABsGyEZPJYZ/EZrH06qoEnrBJnNDYZ0INJ6ncc3
         qfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791950353; x=1792555153;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkMUe/NsYTM0ez+xe3tw/2n8+K1FB1iD4W4PefzB3ik=;
        b=e6WAVk5KBTguhFQp0kfiy8nZhSYc1OUq/aRLFFXqdi0kGOXo1UwGwTh8GMhNSz37PR
         bv+zflE6M1S/RDQjpO/B+9IWBPgw1e/GOd7qWl0BUagZ2NrSlfWJofpC3abrRT3n/ob0
         opnMtOlHoYKx1ZGOnRthsTVYbuslygIEoaJjNo7m5JPNOgUGNo7k4c9vihqB7ERA198h
         jQNm+pZizl51/QIt3Y/AGxQYBGaQwz2qytLbfPe3fM0U1QKXFrALcBILYshqVVvVA4Dg
         KQYgF9Mxo21QI3ytU0/f32/srNbPZea70TiMS79x+C3jhJAubb7gcekOjx+UoLa7C9e1
         +52Q==
X-Forwarded-Encrypted: i=1; AKwUvByCU4RgC4td7ru3G3zhiTR4Rr3t9kOKgrYaYbbnNnO/3Zfu0io5vmLH7hzcQp6g5EcBCz0i9ko=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe6rFM48eBdNu3yIK6hnSAj9YDgsZQ8n7nCoJdvRKX+nonuX+s
	04hoCIXyD9oEaLSIotDgTpHXfrkUXNMZzeHwUwZXd4744uTyOyVZkuUQ
X-Gm-Gg: AYBFou2W62MDsINLgfZZ/YJqZBqFfZ18G/+p2MjZ5rWnjqpIG7zQzoiS+JufyU6ZRqb
	QAden6dDdvVoTQhdCcxfIzctAw/lgbo7K6gs3AdhxiFf/VCVAa0tZfF2/l0+GqiuuYwwp+gEJWV
	Eefu4lmpaa8nzv/oSKFt8GjqL0f9RE1TKumv25zxeDKCNfyzQD/tXlJ2Fp87cKK+aHxzq5UHjP/
	6hel+UnHzqVqxo9dLj7LzWZ5zIUwmqTeTgrCT2QOzteif2qI6SWVDt3pEcFscOWegkaTaTBFADy
	jCYCF7aqy+FDiuz2AEDWkrlB71NBShhZC1cpYz5VjOirvRH4SPtzKUJYAgNo1B9oR+PHffa3QSy
	2nri+lsq2Y6tm607i4rcHneFbll/KzkSjuKBg601ECs/0zP+6qefklyBwfoHvYzGdK6FI6t1BQs
	41VzPdS5c7eYkaCTub3gd2m54TUeLxHEQC3qorpbxsFUJEHCXKP4tZogqs8+oeeFrkF1L08750d
	1A0or2V+OhWj4BJmgW738zr4zPlUfCxLOJZRPmoEXw7mbHeub8xIK5XrGdJmVPUMQpmomqT5I3U
	lw/zxqyzAJQZMPvCNyrg1BII/VFrPyEGJqBVTQ==
X-Received: by 2002:a05:690c:854:b0:8ab:44a4:6362 with SMTP id 00721157ae682-8b07ebf6791mr32329597b3.4.1791950352647;
        Tue, 13 Oct 2026 20:59:12 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0a9d8e52csm23584347b3.11.2026.10.13.20.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 20:59:11 -0700 (PDT)
Date: Tue, 13 Oct 2026 23:59:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 harshit.m.mogalapalli@oracle.com
Cc: maheshb@google.com, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, 
 error27@gmail.com, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3587ccd7685e2@gmail.com>
In-Reply-To: <179152553052.434549.7841966987517379353@kernel.org>
References: <20261005054224.4154727-1-harshit.m.mogalapalli@oracle.com>
 <179152553052.434549.7841966987517379353@kernel.org>
Subject: Re: [PATCH] tun: fix skb length underflow in NAPI frags path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [High] This fix is incomplete.
> =

> Pre-existing issues:
> - [High] tun_napi_alloc_frags() builds fragments from `iter_iov(it) + i=
`
>   and the raw `iov->iov_len` (drivers/net/tun.c:1505-1506).
> - [Low] In tun_get_user(), the `if (msg_control)` block
>   (drivers/net/tun.c:1837-1849) still computes copylen/linear and walks=
=E2=80=A6
> =

> --
> =

> tun: fix skb length underflow in NAPI frags path
> =

> This patch moves the clearing of zerocopy for the IFF_NAPI_FRAGS path i=
n
> tun_get_user() so it happens before copylen is computed. The NAPI frags=

> allocation is then sized for the complete iterator instead of the zeroc=
opy
> linear prefix. This avoids a skb->data_len underflow and a BUG() in
> __skb_pull().
> =

> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 5a302709a68aa..1124b8b33664e 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1848,6 +1848,10 @@ static ssize_t tun_get_user(struct tun_struct =
*tun, struct tun_file *tfile,
> >  			zerocopy =3D true;
> >  	}
> >  =

> > +	/* The NAPI frags path copies the complete iterator. */
> > +	if (frags)
> > +		zerocopy =3D false;
> > +
> =

> [Severity: Low]
> This isn't a bug introduced by this patch, but with this override in
> place, the msg_control block just above in tun_get_user() has no useful=

> effect when frags is set:
> =

> drivers/net/tun.c:tun_get_user() {
>     ...
> 	if (msg_control) {
> 		struct iov_iter i =3D *from;
> =

> 		/* There are 256 bytes to be copied in skb, so there is
> 		 * enough room for skb expand head in case it is used.
> 		 * The rest of the buffer is mapped from userspace.
> 		 */
> 		copylen =3D min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
> 		linear =3D copylen;
> 		iov_iter_advance(&i, copylen);
> 		if (iov_iter_npages(&i, INT_MAX) <=3D MAX_SKB_FRAGS)
> 			zerocopy =3D true;
> 	}
>     ...
> }
> =

> For frags, the !zerocopy branch overwrites copylen and linear, and the
> result of the iov_iter_npages() walk is discarded.
> =

> The comment doesn't describe the frags path either. It also says 256
> bytes, but GOODCOPY_LEN is defined as 128.
> =

> Would gating the block with msg_control && !frags make the code and the=

> comment agree, and also skip the extra iov_iter_npages() walk?

This is nice suggestion.

> =

> >  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)=
) {
> >  		/* For the packet that is not easy to be processed
> >  		 * (e.g gso or jumbo packet), we will do it at after
> > @@ -1868,11 +1872,6 @@ static ssize_t tun_get_user(struct tun_struct =
*tun, struct tun_file *tfile,
> >  		if (frags) {
> >  			mutex_lock(&tfile->napi_mutex);
> >  			skb =3D tun_napi_alloc_frags(tfile, copylen, from);
> =

> [Severity: High]
> Does this fully close the underflow described in the commit message?
> =

> copylen is an int, but len is a size_t taken from iov_iter_count(). The=

> frags path now always goes through this assignment:
> =

> drivers/net/tun.c:tun_get_user() {
>     ...
> 		if (!zerocopy) {
> 			copylen =3D len;
> 			linear =3D min(hdr_len, good_linear);
> 		}
>     ...
> }
> =

> tun_napi_alloc_frags() checks the truncated value against ETH_MAX_MTU. =
It
> then takes linear from the first segment, which is not truncated:
> =

> drivers/net/tun.c:tun_napi_alloc_frags() {
>     ...
> 	linear =3D iov_iter_single_seg_count(it);
> 	err =3D __skb_grow(skb, linear);
> 	if (err)
> 		goto free;
> =

> 	skb->len =3D len;
> 	skb->data_len =3D len - linear;
>     ...
> }
> =

> So when len is over 4 GiB, the first segment can still be larger than t=
he

This is not a normal length. Not sure whether it is feasible (quite
plausible), but would warrant a separate patch, not included here.

> allocation length.
> =

> vhost-net appears able to deliver such an iterator to an IFF_NAPI_FRAGS=

> TAP backend. init_iov_iter() adds the guest descriptor lengths into a
> size_t, and get_tx_bufs() only rejects a length of 0. The default copy
> mode then calls handle_tx_copy()->tun_sendmsg()->tun_get_user() with
> msg_control =3D NULL.
> =

> For example, this needs a guest memslot of at least 4 GiB. The guest
> builds a chain whose first iovec is about 0xfffffff3 bytes after the
> vnet header, followed by a 272 byte iovec. That gives len =3D 0x1000001=
03
> and copylen =3D 259:
> =

> - __skb_grow() with diff =3D 0xfffffff3 passes a negative ntail to
>   pskb_expand_head(), so it makes a small allocation instead of failing=

> - skb->len =3D 259 and skb->data_len =3D 272
> - skb_copy_datagram_from_iter() and pskb_may_pull(ETH_HLEN) both succee=
d
> - eth_type_trans()->__skb_pull() sees skb->len < skb->data_len and
>   calls BUG()
> =

> Copy mode already reached copylen =3D len before this patch. With this
> change, the msg_control case reaches it too.
> =

> Would it make sense to pass the size_t len directly to
> tun_napi_alloc_frags(), or to reject lengths that don't fit in an int
> before narrowing?
> =

> [Severity: High]
> This is a pre-existing issue, but tun_napi_alloc_frags(), which this fi=
x
> relies on, assumes the iterator is ITER_IOVEC. It also doesn't clamp th=
e
> last fragment to the remaining count:
> =

> drivers/net/tun.c:tun_napi_alloc_frags() {
>     ...
> 	for (i =3D 1; i < it->nr_segs; i++) {
> 		const struct iovec *iov =3D iter_iov(it) + i;
> 		size_t fragsz =3D iov->iov_len;
>     ...
> }
> =

> io_uring IORING_OP_WRITE_FIXED on a tun fd reaches tun_get_user() throu=
gh

If this is a bug only reachable by io_uring x napi_frags, we should
just disable the combination of these two.

napi_frags was added as a way to test insertion of packets with
specific segment layout. No need to be able to do that from io_uring.

> tun_chr_write_iter() with an ITER_BVEC iterator. io_import_fixed() sets=

> the count to len, but the last bvec keeps its full bv_len:
> =

> io_uring/rsrc.c:io_import_fixed() {
>     ...
> 	nr_segs =3D (offset + len + bvec->bv_offset + folio_mask) >> imu->foli=
o_shift;
> 	iov_iter_bvec(iter, ddir, bvec, nr_segs, len);
>     ...
> }
> =

> In this case iter_iov() returns the bio_vec array cast to struct iovec.=

> On 64-bit little-endian, iov_len reads as bv_len | (u64)bv_offset << 32=
.
> For page-aligned bvecs that is just bv_len.
> =

> Take a 5000 byte write from a page-aligned registered buffer. linear is=

> about 4084 and data_len is about 904, but the second fragment is given =
a
> size of 4096. skb_copy_datagram_from_iter() writes only 904 bytes into =
it.
> =

> Can this leave about 3192 bytes of uninitialized netdev_alloc_frag()
> memory inside the fragment? The fragment sizes would then add up to mor=
e
> than skb->data_len.
> =

> If so, anything that later walks the frags by skb_frag_size() could exp=
ose
> that memory.
> =

> [ ... ]
> =

> -- =

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20261005054224.4154727-1-harshit.m.mogalapalli%40oracle.com


