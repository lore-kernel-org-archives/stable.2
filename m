Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F492DF126;
	Wed,  8 Jul 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542096; cv=none; b=DDUReG1RYrMkqpcvcY6hq9es2YTSp0UIHJB4hcYq34uzfEsoFg8ICTUvK2DP6yxzPJ/qC/Ak1u4EAE+d1lKrMAM0aiaetAUa2cLhcJPPEoGScu8/BEmGMO9duVOwA3P9KO0YifTfudi4D+P5OYDl2/yeDy3Iiw7PjBLtThRpalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542096; c=relaxed/simple;
	bh=pBZX2MXgPrP+DizSzhrsxz0yUe1s+W6iOyX7A8TS3Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYjeNaXRfTJ/5k54dQ1p4JKd7cZ34t8sA0n/tA5H2qDbOgzaDgWdziPtUmtc/jfgLRi4YDbHGjtFtWtHOgbjZJKBsHVqkIZX1dH/hVXlgsu5TLKukKwDH01BzlgufTNDPSy41YQpID3VXsogpksrxvpjx/S6wALs5rx0xva/pNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Im1xIQ19; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FAy+AMOB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Im1xIQ19";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FAy+AMOB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 61FEF1D000EE;
	Wed,  8 Jul 2026 16:21:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 08 Jul 2026 16:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783542094;
	 x=1783628494; bh=gmwD3lVeqNYGwo8TjC5oUUDspO+jU5k/ynq2bcdx0/E=; b=
	Im1xIQ19ElNNBfuqxC2zKu/ivUB+fguXrgM9qgojRk2BjV4SoZDWnOiD1AQCuFsM
	RQ4+bRiEb6SI+rcqEbly6YaPolalSG0okaUGoa0b+tKXZCbYqU2Sm7ONU1Fka8+k
	072QgVNIRBIb3F8b2fftFCCG3oKBEL23MFncg+efgYBO0BTzkYpPFPoC1R/H9eH3
	Z1pTm9FIbRhurF5GJV4dLEwSbPcu4XPBace8cfHUbQTtDR7pw1KigIEaKNyluHaP
	tpXUSMmoTISOmjK9y8zwDTbWaSJTDPGuWiKkz6jhIUHgMSJ8CblhA3MhohYg0cbp
	WxiuDm7tHGfn1NP9LgxWuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783542094; x=
	1783628494; bh=gmwD3lVeqNYGwo8TjC5oUUDspO+jU5k/ynq2bcdx0/E=; b=F
	Ay+AMOBxS4IIqDwlVq23bxVzs8Tn2WamaJ48AvUNNxb9KF4dcDF4UVfl78dXd1uq
	sJ/UgaHYArNCdLH8Rd253RvE6Ze/VH0GkyaDp43hUZ/F+rqrkdMus57BigUvv0LX
	7/RA3djbM7cwbbcysE/8fWE+rGU0WZ7ifNVNpjSZfr9JgKoOjrKe6FaSDHKyqYLM
	PweC0ir10Dj8a8Vd/j0EKce+z6PFOjvroVUdRSnND4nvt6Siyv9Fb+EkTJt6sURG
	IRbh3G/5MlA2QfJYNEL7/6+WAT1TK+jjFHCtKRADhecHKLL+1djgcG+vQB3BP1BI
	OWFZXPgoZ61vumKoNI1bQ==
X-ME-Sender: <xms:TbFOarW1lme6emsLZZh07ShOZ9jNbQfspMLltDAy4R2i_L2tuikA1Q>
    <xme:TbFOarvNRiZ_WZsbn2sybftTQDEvv-fdVRAHxh_IcbnoFUwuVgxUFLhtzQtba_UR0
    CPP-PZbHNj4zi7-BT0ufBqxX-et2ibi8eFosdEzrq0ipheh>
X-ME-Received: <xmr:TbFOam6o-ISOBhFUzK5bn6F8pgDUnQW0bWlesy0Yd1m0B0eJDcfnG8RkuOuRGPhdRmOobwZYurnWmpGlXj5n8ny5tAH_-8TI-ihQtIH6qxJWdchtiw>
X-ME-Proxy-Cause: dmFkZTF9JJwOluGC1DgqUsN2FBoy2mOwV5+xb4JTtrQg7Pvli1ZpkpnakqJHAVJwFgPvP+
    A2pDXpnnqQI36vslXxzTcXaBFFBlQnzBtFjuj71d+LUQi0lC0kSMzPN4DbKtPCgkREu0lG
    YzAAr7f8S0mj90egTUJLAbjCP0e72z6Fey8vDR0uYkYEomzvyaD2mkUJQosgyoCVvcy1wv
    iDAw6CglUp3VyQ8a40yvmIQzL1QNjzcHGmfwYAjZtyBFWst+fvBvVsdEzSyY5rQEsyTRLp
    J6+P9oeEB6S8wr4unPC+iHdLuDixcWsIi1ub6zKR5nxxhzpWp7t1T1ArqNWyiHm8QJDBsq
    Ud5/jYrN748/LOYwVKJneBBYOo8CBU30UiztMCxwI4LPUk7bn9BiXNl6QWy6o6yxcBWmCP
    mT99Ufir3t9K+sAjcMAcP8VOTqCBYQpy6L58+jlwunWiRSTugh+1ceigZCr6j1gwzoYYP7
    iZlLt/TaOhBSpDHmly5PET1gjUO7g1sKR0RhT1bdaDJXbbQumwYIUhjgqREvUXylvDng84
    hyRjh4QuK69GtmH9Fggkjdo7E4HQKb773lbBLb1LrGh5QI9UI1wK3+ma5LPTJCw6YQv5I7
    3G2deOwrj5seqavRG81sJWHG7XG35pGoK/03gM9Z8X0/l7565kkjdFsPzKNQ
X-ME-Proxy: <xmx:TbFOamQJBQEBqeiICfRTIva0gZCWZtLNMHT6BBdDp0prw0KeXXGoiQ>
    <xmx:TbFOahv5tNJa189UgLToHdj5btJ3D1EynqtJJVn5mjBws0lrBZ2UvA>
    <xmx:TbFOag_yLcPKQL-TkBXuSGXd8PXv-CfDbL3CXGyDtPoW3DMtAGZMPQ>
    <xmx:TbFOaiyVxyLonqcp-oViF81LMSeXOrSdyT9Be2QnJeLeBHweFPe3Wg>
    <xmx:TrFOatVLopgBVhjlbS7rXvs4Hixb5rJnR872PB-mJL4tjwBqedG2D2ZW>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 16:21:31 -0400 (EDT)
Message-ID: <1227637e-c9b6-4bcb-ba91-dfe896e5c310@bsbernd.com>
Date: Wed, 8 Jul 2026 22:21:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: copy request headers via a stack buffer for
 io-uring
To: Xiang Mei <xmei5@asu.edu>, Joanne Koong <joannelkoong@gmail.com>,
 djwong@kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: stable@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 Luis Henriques <luis@igalia.com>, Weiming Shi <bestswngs@gmail.com>
References: <20260707184417.3682270-1-xmei5@asu.edu>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260707184417.3682270-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/26 20:44, Xiang Mei wrote:
> The fuse-io-uring transport copies req->in.h out to the ring in
> fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> Both headers live inside the fuse_request slab object, whose cache
> (fuse_req_cachep) is created without a usercopy whitelist, so copying
> them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> panics:
> 
>   usercopy: Kernel memory exposure attempt detected from SLUB object
>   'fuse_request' (offset 56, size 40)!
>   kernel BUG at mm/usercopy.c:102!
>   RIP: 0010:usercopy_abort+0x6c/0x80
>   Call Trace:
>    __check_heap_object
>    __check_object_size
>    copy_header_to_ring          fs/fuse/dev_uring.c:618
>    fuse_uring_prepare_send
>    fuse_uring_send_in_task
>    ...
>    __do_sys_io_uring_enter
>    entry_SYSCALL_64_after_hwframe
> 
> Bounce both headers through an on-stack copy so the usercopy touches
> stack memory, not the slab object.
> 
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
> v2: add: Cc stable and Reviewed-by tags
> 
>  fs/fuse/dev_uring.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 77c8cec43d9c..0814681eb04b 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -744,6 +744,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
>  {
>  	struct fuse_ring_queue *queue = ent->queue;
>  	struct fuse_ring *ring = queue->ring;
> +	struct fuse_in_header in_header;
>  	int err;
>  
>  	err = -EIO;
> @@ -765,8 +766,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
>  	}
>  
>  	/* copy fuse_in_header */
> -	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
> -				   sizeof(req->in.h));
> +	in_header = req->in.h;
> +	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_header,
> +				   sizeof(in_header));
>  }
>  
>  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
> @@ -871,11 +873,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
>  			      unsigned int issue_flags)
>  {
>  	struct fuse_ring *ring = ent->queue->ring;
> +	struct fuse_out_header out_header;
>  	ssize_t err = -EFAULT;
>  
> -	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
> -				  sizeof(req->out.h)))
> +	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &out_header,
> +				  sizeof(out_header)))
>  		goto out;
> +	req->out.h = out_header;
>  
>  	err = fuse_uring_out_header_has_err(&req->out.h, req);
>  	if (err) {

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
