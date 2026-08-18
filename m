Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98A46D0A8
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062017; cv=none; b=kLfeh4qC0T7RJgBPmtv1b4GyFumUdhh3VbtQUn9bgdtby4B73KV2QYGVHNfArnIzk9mb/xuXdIgCRHWE6rh1mxE1KCXcNzCK5yECLckWr6ViB/s9dy2E5BtymPyMFRm4Gu9pS28MRt6UMzU/DggZqlqrWYd4qwMTg6IZ0tqmIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062017; c=relaxed/simple;
	bh=AAbgpFY5r/LU/xzhw0yGjYLVDj4UYudmnK/D6EbXBOk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rsUJGf7S/jCOSwWS0UtFUAkFKMUtafndWu66gv1bJBtBw2sDgzFkVXBG7cHc0ASrI6qzOZdEjPkJbuGQZkQloyBuBdOIO14YvgCXj+Ic3Si21F+WIhJyZCX8NrWPnNTiKs7Xgr/Exa6+X9VkX1G9KHEe9WQemcbNynl2t++rKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs0GK55k; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs0GK55k"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ff017d420so14403657b3.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787062014; x=1787666814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2JBJpmYrJhiOXDvgTeethJ3HxlqBnurUVEqBxP7Z28U=;
        b=Cs0GK55kVfI6I94sUCeuDha6CAoGQdvdYanJQP/N7SZ1ACOpM7VRANWOUSyhfDtDXI
         oB1QfDjo/R3MnRVH9p6ZgeSWxk3uOEapvAP6DNvB6JaNFt/Ev89l4AEF/4QtE87sFd/D
         HRcD5NiNNRISXyyNBooPBdaq2NKRTzni+zrMzuaXUPTb1rCgc3U0UikPfuW43VlSFRhv
         ADVq5zSOED6QuGbsnNnYVAk5BnWawVHgEPFKLqwuF+ZlziY28YwjElmFmnIaWF1Z1uPr
         u3H+5BzItQUsN4oaPidmyH7LTeG1E6vlHSr3wHhfQBI2pbU+Mz7a76d7c5Cg7dtIlQL9
         QmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787062014; x=1787666814;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2JBJpmYrJhiOXDvgTeethJ3HxlqBnurUVEqBxP7Z28U=;
        b=AxrfJXjaGxMX9Uk2Y0D8ELrhW9LVh5Fdoxj1a16WuhykiLmPlAJ94iwugK1l/f/kna
         tuHU9GMCU/LvDVAyu2VM7SjDDA2FP7ON1phb9ZzGr1H9cIBesdRS6XdX3FrUK8mtaSyn
         zyrol7dmm5aPql0DsMTKGfkZwg5O2OM7wYIuQSCMhIprEh6Zbw7JX/AMS4pj/AsLJKTa
         NoDr0VLl81243UG3HxekcROdrOm9PPN4hU2zS1xvAdqs7/tuEe9zkoPzYHjwLrTJLPOZ
         aDxNG4ICTvpZVnCTuKp+ZCdvFfLhFFxlvoGIVpXMgKSJv6zwEAu7WfIv3Wyp8H3Uegap
         AJ/A==
X-Forwarded-Encrypted: i=1; AHgh+RrUa4S/IXJeLOYA27ejevGVnwp2gcMqgJXoaHIEwPn5XRuizyyGvlirUhrmdMGXzubuhIVJg4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjtv95jY3Arm41Pk+I+Dvp1ZXYFQqwD3RBc9aAaVMDpMxGTrRH
	N27Em6RbUuAlFqHRYdeLAtM+M2pF3WaUGNPNyc01PjN8NCvbXkuMPZE4
X-Gm-Gg: AR+sD10tf/866nn4Ug2JD6849EyvRi2hHTjTGu0AXiSANesILVCO3GR8NQ9QiAUDkfL
	Q9ZcqgpcUs9IVi8VKlqxf/l+1GGfJFsnd1RIwkXR+WyhnYGLH4SZ2oMfght7EfGKZ9Uz7bgKUvr
	Xo11CoTT9hvnHUGEmUkE4DmQZh2qNfbh1exG0zVdItaSYLM/2QY7Av1lj4x+OWZvzQRHra20XnI
	ir8lhvOApTDGFOQSTsjYVBHLAusOp9r+o7DhsUYjcqehjTEzD57S2VS45MKy9/zTg1OTZ3JgZma
	xXKYB7NZMAhRA83S8v7T8pSSL1EjgG4VqmtsGtlVhNKsgCX0wZZHMuEwIgyB4IDYDeMz2/ZcuRm
	USKozzWvvu1j6SwT6Y19bWDozhXVkF3BmQlAUvFg3lS1+C6qoeuWIHdppAf5mYabtpX4TxfWl0/
	DTUmsDhfPL+OPIu/7Ug18EKI8HTeb1Ca6eomeYhz348xKOeMzQlNSI0CxREZuX1pVp8e/yNam9o
	gmLIir+WF8cRks67lqwZJsUR5KpXYhj87tS8dbnQw==
X-Received: by 2002:a05:690c:e1da:10b0:81e:d001:e0ca with SMTP id 00721157ae682-841a35a3dadmr21536817b3.17.1787062014093;
        Tue, 18 Aug 2026 07:06:54 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84068077eb4sm21486147b3.10.2026.08.18.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 07:06:52 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:06:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kyle Zeng <kylebot@openai.com>, 
 netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Muhammad_Hazley_SAMSUDIN_from.TP@tech.gov.sg, 
 Kyle Zeng <kylebot@openai.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.30254a97eb38@gmail.com>
In-Reply-To: <20260816235646.76500-1-kylebot@openai.com>
References: <20260816235646.76500-1-kylebot@openai.com>
Subject: Re: [PATCH net v2] net/packet: defer vmalloc TX_RING free until skbs
 finish
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kyle Zeng wrote:
> AF_PACKET TX_RING skbs keep a raw pointer to their ring frame. The skb
> page references preserve page-backed ring blocks after pg_vec is freed,
> but they do not preserve a vmalloc mapping.

Claude shows an interesting case where this page-backed statement does
not hold: if the entire skb is linear. Not for this patch, but a
similar case.
 
> tpacket_destruct_skb() currently drops the pending reference before
> writing the timestamp and TP_STATUS_AVAILABLE to the frame. Move the
> decrement after those stores. The smp_wmb() in __packet_set_status()
> orders the frame stores before the decrement.
> 
> Also recheck pending TX frames under pg_vec_lock before non-closing
> ring replacement, so a racing send cannot add a pending skb between
> the initial check and the ring swap.
> 
> Ring allocation can produce a mixture of page-backed and vmalloc-backed
> blocks. Allocate deferred-work storage during TX ring setup when the
> first vmalloc-backed block is encountered, and keep its pointer in the
> pg_vec allocation header. If allocation fails, return -ENOMEM from ring
> setup. On socket close, a non-NULL pointer identifies a vmalloc-backed
> vector without a scan. If TX skbs remain, defer the whole vector to
> system_long_wq.
> 
> After pg_vec is detached, a late destructor can skip the pending
> decrement. Use socket write-memory accounting as the deferred lifetime
> gate instead: an skb remains charged through its final sock_wfree(),
> after all ring-frame accesses. The delayed work retains a socket
> reference and reschedules itself until no TX skbs remain.
> 
> Move pending_refcnt release to packet_sock_destruct() so late skb
> destructors and deferred cleanup can safely use it after
> packet_release(). Page-backed teardown remains synchronous, and no lock
> is added to the TX completion hot path.

This one patch combines multiple fixes. If and only if a respin is
needed, it may be good to break it up to help understanding.

> Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/netdev/20260721015824.45829-1-kylebot@openai.com/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Assisted-by: Codex:gpt-5.6-sol

> +struct packet_pg_vec {
> +	struct packet_pg_vec_free *deferred;
> +	unsigned int order;
> +	unsigned int len;
> +	struct pgv pg_vec[] __counted_by(len);
> +};
> +
> +struct packet_pg_vec_free {
> +	struct delayed_work work;
> +	struct sock *sk;
> +	struct packet_pg_vec *vec;
> +};

> @@ -4382,7 +4399,46 @@ static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
> +static void packet_free_pg_vec_work(struct work_struct *work)
> +{
> +	struct packet_pg_vec_free *deferred;
> +	struct packet_pg_vec *vec;
> +	struct sock *sk;
> +
> +	deferred = container_of_const(to_delayed_work(work),
> +				      struct packet_pg_vec_free, work);
> +	vec = deferred->vec;
> +	sk = deferred->sk;
> +	if (sk_wmem_alloc_get(sk)) {
> +		queue_delayed_work(system_long_wq, &deferred->work, 1);

Can this keep requeueing itself? Claude suggests using pending ring
count as gate.

> +static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
> +				unsigned int order, unsigned int len)
> +{
> +	struct packet_pg_vec_free *deferred;
> +	struct packet_pg_vec *vec;
> +
> +	vec = container_of_const(pg_vec, struct packet_pg_vec, pg_vec[0]);
> +	deferred = vec->deferred;
> +	if (!deferred || !sk_wmem_alloc_get(sk)) {
> +		free_pg_vec(pg_vec, order, len);
> +		return;
> +	}
> +
> +	/* A detached ring's pending count can miss late skb destructors. */
> +	deferred->sk = sk;
> +	sock_hold(sk);
> +	queue_delayed_work(system_long_wq, &deferred->work, 0);
>  }
>  
>  static char *alloc_one_pg_vec_page(unsigned long order)
> @@ -4410,20 +4466,35 @@ static char *alloc_one_pg_vec_page(unsigned long order)
>  	return NULL;
>  }
>  
> -static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order)
> +static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring)
>  {
>  	unsigned int block_nr = req->tp_block_nr;
> +	struct packet_pg_vec *vec;
>  	struct pgv *pg_vec;
>  	int i;
>  
> -	pg_vec = kzalloc_objs(struct pgv, block_nr, GFP_KERNEL | __GFP_NOWARN);
> -	if (unlikely(!pg_vec))
> -		goto out;
> +	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
> +	if (unlikely(!vec))
> +		return NULL;
> +	vec->order = order;
> +	vec->len = block_nr;
> +	pg_vec = vec->pg_vec;
>  
>  	for (i = 0; i < block_nr; i++) {
>  		pg_vec[i].buffer = alloc_one_pg_vec_page(order);
>  		if (unlikely(!pg_vec[i].buffer))
>  			goto out_free_pgvec;
> +
> +		if (tx_ring && !vec->deferred &&
> +		    is_vmalloc_addr(pg_vec[i].buffer)) {
> +			vec->deferred = kzalloc_obj(*vec->deferred,
> +						    GFP_KERNEL | __GFP_NOWARN);
> +			if (!vec->deferred)
> +				goto out_free_pgvec;
> +			vec->deferred->vec = vec;

The nested structures are fairly complex.

Would it make sense to avoid the separate packet_pg_vec_free, fold
that into packet_pg_vec and use a different field to identify
whether vmalloc backed pages are used. Maybe sk, or even a new
boolean field has_vmalloc, for readability



