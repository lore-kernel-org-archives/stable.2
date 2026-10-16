Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE249739B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155078; cv=pass; b=W4zKftuhneLhsybi7s2rvwsRooO6OK562X3M0bkfnMSPHSr9hyd/ninQbGBtIPMYKu77rB/GKVUuUgtBBRsdgVRX5TGnCK3u9G4U7xitzgQ+VIn1ZyX/AbS4maF6286RwN4drOh5t451n3/t4ktMwz/YIUgsCiZ7C+Gz6AW1TMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155078; c=relaxed/simple;
	bh=NhOW2dh4m8kfq9MbFov+5iQ04Dt9NX8wqPTkeJTUa+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiOhwdFqIxxqudzXbVMhMkakMFBfPt9MlVXLSRa6681w1fz+t6GBo0pkOiw/FEZaUMx3X81hfjyCwXUd0v4lTn+qRQET8Z3IH9CJUmPI+WjeuwY1XocM5ZhvSj/0sPO/vu9hEXckoh//B2ucQM3J6JWu5/FP6/On1DXUW1dJArs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDsZerex; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDsZerex"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso8292a12.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792155075; cv=none;
        d=google.com; s=arc-20260327;
        b=V4zfpYW0kYhXrKtDj5BtPzhhioArNveviuOyDmmHXTGIx9msz+7sb7E9HK176WDvkb
         UBSjjCIWZvLMy/+cGiy8xIg5Xj0qqHbELV10/tQy8SJGWix7sn8FwzPvErcYQg19txSI
         QtBiv5FEeSpvDbUjc5utxv7A7z1N8g4M5h0VRZWw2iYWk2nZpe1995KxNa+UKi8f5RxR
         8hB50jShDn3xGGu0lYF80iEGW37VDJtKVGodl9ByYoFBOqJ75c80PGXJhA3cJVDLAUzS
         B+ZmUaxV9TE/Ajrt1plQBVDr/MYdtbvjaazb8OTFl5ZFSNVpWqeq4ofADTRmPaOP87eJ
         Ilag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CIregvBSP9juxzobcyMQ+rByYbCLFuXclbRVa9ESVqs=;
        fh=yQmPC9gzel+azZwyoXUbf/1F3cvoIc8vxdLnQ/0wVjc=;
        b=q1YVNeWFOITsOQLDrkRqBKdgudXD0X4vSTouQtHY78P/K/gfH8JMOMcoFrjfShuFbY
         YxgTgddPkaZqoPu0WhDISMLFFkz2eZiQpU/uImc16ELlAvfi3Xv6Nq4uFRIoGyNqPtGX
         xeODdsLKrZSRSq6m/SjtJArQ+kfwYbBeyFj8iG70ewg5JWKSTUsCiEr+TEjBckME1fTS
         +knArkiukjXjTsaaDXRg+F/jhz1d/Ce1VBpNxy/Eo6n4Za6Rw9vdclEw8LXSjuoobqRT
         d9XswHTw1jqd9j6GoeyiDSBaj+Oz2tHR1nmu/fDFNAe5XRCClfzhjwQz5bL2xKx93EtL
         Ya2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792155075; x=1792759875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CIregvBSP9juxzobcyMQ+rByYbCLFuXclbRVa9ESVqs=;
        b=rDsZerexR6sYpZzJizFUW5S66B+yb7F1zpyipD11lJyMpP6nTFCyNJS0DQt528R79s
         YX59o+BYcSPRJz/UpEP6UxaLcqrBl1edQycGhyjE0ss8eaHvnzRByaVKJHGNVRrAOb1O
         jyl1QWD7gxIJ9W0tC7Nc4u8sBiFo5C15E51StGL76kLlbII84hjesCAvvlKBdDqbFGsm
         yHPu4AXUT4T7dZhsDoZU0KUSHTsd7pf2u9E19rSh4NIH0M0GCrGXfc8cOdoggYepXTqU
         WfBT4ZUHFWkNrewmzqe1f8h7U29yjbiE5y24/7hvp24wBNGiNEJXb7scH1EYfROdhx3H
         ZwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155075; x=1792759875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CIregvBSP9juxzobcyMQ+rByYbCLFuXclbRVa9ESVqs=;
        b=zNkFZ5uqtCNQchNVIXRuc6T7cL/IJRIvYcqMZ8m79PNfM4b8QKql1dKMqKtQU6zNki
         PEmFuGLDWhgslpEgaRWT46wOdtr+m7riKGSF8WQYsZSyC+oNebjRxmmfImKVvmll3JFA
         JhDXyvRw1dG06gNdw47IuVI2HpT/hdfEPW+9Q5i3xeKGKOioRdcfe5XGd3dODkBYnQQL
         cK7WstXz6HdPZNuWbtcAiShuVLFBVRCnYzPMTEashJskKTjnrV1h5LzZcqqASM/IpSme
         lpZN6G3DH2Dg39x7Dc4sWowJMX2d6O3ZBKOIpa7+IgzT3W3J0WE/t4GkFmLNrQo7pE34
         FbEA==
X-Forwarded-Encrypted: i=1; AKwUvBxH2nBeESksSl6z5YYPj9HC9FIKC+he4LtzZctfvVEpZw6j/nw9F/Z+raE8YkAxgB8UTAnEWBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvWjss4Kf5/P0cooZVKoj4n70bquD0VAlgJTWTp5LJ1ogGxQWa
	aVkVBCgmWVK+6eAGGLZOQqq3c2N5MBDpQZIy1lKlDKQfO50qmylYHkY/k0OODOmDUlUhGqi4bJX
	vpoEebko8XpycWRTkAsfU4h6PAQy3dSTgImCXVkmv
X-Gm-Gg: AYBFou1r6FR3vjV+679lVbmmt3iz4eqiB2DOoo/XanB9kZP+lp8trNNEEBndzXokJGy
	xKvqmmx0W1L9WcRMbLZEdZBvZvrR7I3VFgomDzvPl9y99xh4D2enmA4O2LrcCQF++ecVgByFFQ8
	KpbaXd/l9U8A1OcU3WX5zcscYa/lHnw19jPpdWe+U/WewBrp19K4UvgDC4V6HQ0jzp1jQFj5RKM
	VhkGC8m8mLDoNbrZDTTNNWNstqlCRRVy3JLzCAltY9eYJNn1mSqdx+6TbIXwKyjStNMbyeQLOhw
	wpSNtzhPyhWRfC1lKep23nNMnC5dIP4ZnIerGcm8RehhcYQ6tDpEXA==
X-Received: by 2002:a05:6402:1512:b0:6b1:bbbf:25b4 with SMTP id
 4fb4d7f45d1cf-6b3896bb8e1mr55897a12.6.1792155074206; Fri, 16 Oct 2026
 05:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
In-Reply-To: <20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 16 Oct 2026 05:51:02 -0700
X-Gm-Features: AclHuK-iMNhhxZAcYE0H3a3QC5Uul0gFiT_mer94jWWIdH2TOqEIhyDt2MtD6oI
Message-ID: <CAHS8izMCh6UzOz8B8O6Mc=MGtCbxLQN9+V8aiA1nGHY6P4xs9w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: skbuff: make skb_copy_and_csum_bits() report
 unreadable frags
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:02=E2=80=AFAM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> skb_copy_and_csum_bits() has no way to fail.  When it reaches
> unreadable frags it zero-fills the rest of the buffer and returns 0,
> and since commit ab9414ed70bd ("net: skbuff: don't leave stale bytes in
> skb_copy_and_csum_bits()") that 0 is the correct checksum for what's in
> the buffer.  Its callers can't tell the copy didn't happen.
>
> That matters in the !sg && !csum branch of skb_segment().  A devmem TCP
> skb keeps its whole payload in unreadable frags, so every segment ends
> up with a payload of zeroes, tcp_gso_segment() writes a valid TCP
> checksum over it, and the peer accepts the zeroes as stream data.  This
> is reachable when both SG and TX checksum offload are turned off on a
> device used for devmem TX: sk_setup_caps() still gives TCP SG and
> HW_CSUM, so the dmabuf send is accepted, validate_xmit_unreadable_skb()
> lets the skb through for a NETMEM_TX_NO_DMA device or a matching
> binding, and software GSO segments it with neither feature.  Before
> that commit the segments carried uninitialized memory with a checksum
> that almost never matched.
>
> Make skb_copy_and_csum_bits() return 0 or -EFAULT and hand the checksum
> back through a pointer, and make it __must_check so a new caller can't
> ignore the failure.  Each caller takes the error path it already has
> for a failed copy:
>
>  - skb_segment() fails the segmentation, as the csum branch already
>    does when skb_copy_bits() fails.
>  - icmp_glue_bits() and icmpv6_getfrag() return the error, so the ICMP
>    error isn't sent.
>  - __ip_append_data() and __ip6_append_data() drop the new skb and
>    return -EFAULT, as they do when getfrag fails.
>  - vnet_skb_shape() fails the same way it does when its skb_copy_bits()
>    call fails.
>  - xdr_skb_read_bits() returns 0 without consuming anything, as it does
>    when skb_copy_bits() fails, so desc.count stays non-zero and
>    csum_partial_copy_to_xdr() fails.  csum_partial_copy_to_xdr() used
>    to checksum the bytes it hadn't copied before checking desc.count.
>    desc.offset and desc.count always add up to skb->len, so that only
>    ran when it was about to fail anyway, and on an unreadable skb
>    skb_checksum() would WARN.  Drop it.
>  - skb_copy_and_csum_dev() can't return an error, so it leaves the
>    checksum alone and the frame goes out with a bad one.  Its callers
>    are drivers that never see unreadable skbs anyway.
>
> The zero-fill stays, so a caller that does send the buffer still
> doesn't leak anything.
>
> This was found by the Sashiko AI review of that commit, and
> Mina suggested reporting the error from the helper rather than checking
> for unreadable frags in skb_segment().
>
> Fixes: ab9414ed70bd ("net: skbuff: don't leave stale bytes in skb_copy_an=
d_csum_bits()")
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Link: https://lore.kernel.org/all/179148235783.434549.1432237422747783281=
7@kernel.org/
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Patch LGTM, but net + stable + fixes is very overkill for me. This is
a very minor issue and only results in some devmem packets maybe
having a bad csum and get dropped. I would suggest fixing in net-next
(and I know the bot will complain it's a fix that's going to net-next,
but in this case, ignore).

If you send to net-next, plaese add:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
