Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01144DF76
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784156068; cv=none; b=RWOIR8gfxSJjO+aO2nONHlxgs3lLFw7TZUSNlyI0H/N+v9poLfwpPGnYa2e3fp/LNmDZaQXVh1YDtBb77rByWpqWpAYdOb+tx2fsB8/vUlt4b8Vfi4PBJ+kOaKzrwR032mqH3R8cysSJNTnXG0INXKac0iKpqEhJJREMz9gyRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784156068; c=relaxed/simple;
	bh=t17g0DK/hpZseMV+HjeVJ65aELOdNP7iTPxp4dVpFQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLe8ew/riJY2AsYLVq283vE2U5SyOVLTdbgmiEAyobfPju0ibL0CWC0pb4vBSP00wQI+uwkkVRTToIcPliLgipS4M7njFO/0lEunQX7YiKzR2st8emY72rK/kKEbkCohFh2GFaici7bwH3dbPQG5kVhANjkJBv3LaXZq91g7oqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=VhhShQXA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyUIpm+c; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="VhhShQXA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyUIpm+c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5649D1D000F4;
	Wed, 15 Jul 2026 18:54:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 18:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784156066;
	 x=1784242466; bh=0a+YkQjy7YMepxeL4faOW0HrUO6YbTUPvLV9nR3fHJI=; b=
	VhhShQXAK+eO9Qe9eQycIqv4mTwzoVP7ZpGs5oVd9F9fvc1DP8VR0/Jc76eXqq3+
	li+VjXVugRJGGJDWFywfovAttr76ujsXTQrCTzyC7hcw4JxJWNYjGhvzmK/VzXX3
	TBLHeePwa2fwI6C3Q9IX6XGKyYSML/otT55QEZA+Zn1QEDtiHBfsgvdM3VRPPW96
	78dtbCgjOiRAjWs8RSr9pRvuABAbzCSkfkTJrhLqfAZ93h3cQXsMegdZX0rcqUUm
	V78/jwGiKJPqks1JutYunXczuVW7qagSuw1I52Ma4dciBxeEktLcvGGCuw/T/25z
	vr7LgbH/RtyQ4iw9ZXHCpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784156066; x=
	1784242466; bh=0a+YkQjy7YMepxeL4faOW0HrUO6YbTUPvLV9nR3fHJI=; b=D
	yUIpm+cU08i1VGh9+bOgjYUZFfEC3MaLQqGVsWzLcHcIWEIuUlfJCerA0JqGR0zt
	GCeXsnf/4rfv0IlbnhuVulxqZf2AFs/+kC0gf+k+i1E8tgSV/92xIzUYBHS/R4No
	Mky6qMAxvRTsFLOXXTPUO2ea06ALfCsl6oicurOO1NWMJWAfI5f96BTzOnA1mPTH
	LqPd9VD0uNScz30ry9ITFx4pboiYzk5qG0pM2KmW4qzrVTcinvgh9o/TAsxVCbjd
	lDbh6ZWH71D3mSFBIgeCx2fJAnnc2xEadF9X9VDvfDnzVxxxnhhWgyym+KrpA3aj
	552ReT6sbCA8x5fbVCmEg==
X-ME-Sender: <xms:oQ9YahCw6eaIf0TgpcnGEBRYooIKTlmiqkTvP64RA7-1zPV7MBLb7Q>
    <xme:oQ9YatVkjk23knRahW6i0ZHo_Igti8YkuIy2Zk0gseyQlQuUl4Y8WDPithFD8z8Po
    dlr-txvPP-yFBdeMKdCpzJrss4UKLVj_FwZjTuRgvajUa468CZt>
X-ME-Received: <xmr:oQ9YanCC1UtkHT0YOp3wkumM5mOWwJBsvj1nQdfS_PlOdXmJoCW0bS10bMTlCj__Jm0vNVF6DoD_yFathFLODpeh5RYmePjaaa3aVWMttTLTG0RL0Ng-gfsRE-SZTwg0rBM-9ONoBb0cSyVD_KHu1YCpyw>
X-ME-Proxy-Cause: dmFkZTFbB5TZ5fPv191ED7eB2x72Kmt88XlKP46GxRDYEzpopil5skdtP39bJx3YUn8XYc
    PpRic9PICICwgK8k9n9YcLvuUpukYeeKJX1e9sR4j42/Dg8gSbOl00X3RjQ26WPl+oU3uQ
    6tx01YdP3fYD+8fQF374sgTbKpaywNfxwFzSbgRUxMsMtUCEhvSqgtSoybaUOoBJs1lhqk
    3jZx3VBNiU59Jnk0CO7zRqKD6yDH6Cja2KPUAZJVHAkYa46LbOBuhynfJeZFrNox000jau
    zJdK6X53VohaR6J7XBsQSvQhhUe4UELv0Kc5Ew+z6Yt3+6SgvZdYk6qoNfvQkZD5OYuzIW
    aLrXHO+bBmhLtujCFjyQc3Og0h+VR4TUhEoYRFFsC//Q4We2/HvMb1l0tvqvUHK/OcfeIj
    ZaFe+O8V3UCj37E6mOfYPVsIKplnAKgkeoCN1/bpYqhndWhGusCc0NZ/loVq1nRRUsCE/b
    pNiYDVoTECbLdWoWKXdY7BsVszANLiD+Ah2tf7z4P5fmoRupkni9od/fsLAiAt07eBS2cw
    xS6ohIVr+fqCEJ4mRQMrPHTn794ESri4c7yXKcuXWtWZRCOURp0V4tBVaFU4ahDi/UGyrv
    q/Z2ZEqs+Vjn++NzjCspt4ThMYLpkjyhwLOVEVo/a6Nr6zBEyjjQJLHFyNiQ
X-ME-Proxy: <xmx:oQ9Yao9378rBs4F23Zrub-oLLhSUhUd0M6xv33RLp67y0xZX_lE_gQ>
    <xmx:oQ9YamF1H08JQFtTY5nPIL5CcpFuMgku0R7ALjgkDhGu6MGltmaJtg>
    <xmx:oQ9YauMGc2JdXCVyL4aopBlMftIlRn41sxaI9t9YF2s-4bvfnV-VLQ>
    <xmx:oQ9YaodzgBnCB-aJCYIAc3MwI3lZV8v5dLjRmYM2vTlZL4-9vbzR3A>
    <xmx:og9Yagiyx2V1mDGir6uyPQXKZ9dloFPcZcTLsA4SmbK6SQs8z1Amcq14>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 18:54:24 -0400 (EDT)
Message-ID: <668fa6c6-ffe0-48d1-aed6-f86a7353187b@bsbernd.com>
Date: Thu, 16 Jul 2026 00:54:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] fuse: publish io-uring queues with release
 semantics
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, stable@vger.kernel.org
References: <20260715174305.336261-1-joannelkoong@gmail.com>
 <20260715174305.336261-4-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260715174305.336261-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/26 19:43, Joanne Koong wrote:
> fuse_uring_create_queue() initializes a fuse_ring_queue and then
> publishes the pointer into ring->queues[qid] with WRITE_ONCE() under the
> fch->lock. There are several readers that may concurrently be fetching
> that pointer locklessly and then deferencing it.
> 
> WRITE_ONCE() doesn't ensure ordering of the queue's field
> initialization before the ring->queues[qid] pointer assignment. The
> queue must be published with smp_store_release() so the field
> initialization is guaranteed to happen before.
> 
> Readers in paths where the read may happen concurrently with the store
> need to use READ_ONCE() because any race involving a plain access is
> undefined.
> 
> Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 51f985154aa1..bf9d51f2a508 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -321,9 +321,11 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>  	}
>  
>  	/*
> -	 * write_once and lock as the caller mostly doesn't take the lock at all
> +	 * fch->lock serializes concurrent creators for this qid.
> +	 * smp_store_release() are for the lockless readers who must see a
> +	 * fully initialized queue after &ring->queues[qid] is set
>  	 */
> -	WRITE_ONCE(ring->queues[qid], queue);
> +	smp_store_release(&ring->queues[qid], queue);
>  	spin_unlock(&fch->lock);
>  
>  	return queue;
> @@ -434,7 +436,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
>  	struct fuse_ring_ent *ent;
>  
>  	for (qid = 0; qid < ring->nr_queues; qid++) {
> -		struct fuse_ring_queue *queue = ring->queues[qid];
> +		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
>  
>  		if (!queue)
>  			continue;
> @@ -967,7 +969,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
>  	if (qid >= ring->nr_queues)
>  		return -EINVAL;
>  
> -	queue = ring->queues[qid];
> +	queue = READ_ONCE(ring->queues[qid]);
>  	if (!queue)
>  		return err;
>  	fpq = &queue->fpq;
> @@ -1035,7 +1037,7 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
>  		if (current_qid == qid)
>  			continue;
>  
> -		queue = ring->queues[qid];
> +		queue = READ_ONCE(ring->queues[qid]);
>  		if (!queue) {
>  			ready = false;
>  			break;
> @@ -1191,7 +1193,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>  		return -EINVAL;
>  	}
>  
> -	queue = ring->queues[qid];
> +	queue = READ_ONCE(ring->queues[qid]);
>  	if (!queue) {
>  		queue = fuse_uring_create_queue(ring, qid);
>  		if (!queue)


For consistency, maybe READ_ONCE/WRITE_ONCE in fuse_uring_destruct?
Otherwise,

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
