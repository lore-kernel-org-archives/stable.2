Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DF379C2A;
	Wed,  8 Jul 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783538545; cv=none; b=vCAuXJ97FS75VbaAD7akabofGOiXxQS2Sq6d92MvdgK7Nut2sjqzKCJcKB1XRat8f7FQFpQM05dKHvsBxGxZmNPU07aHuuBxctAcpG1E5C59Je7oT2jd9YOfHCU5uyOI4JFpQ/6MkmYjac8EIxEKi7qBcz/4yFvPagnmvBCxWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783538545; c=relaxed/simple;
	bh=odhxthjOjIqoBALDZzJ8rCV7WZeI16bKTVxgOvnJT5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Og/fccI8P5MCzqx8C4NJsm+Bgt1AsHNyKdymr0siSaDwkGxcMwCzk3AvoTwmrwdj/QNhKgWXRktTlwo96QCj9582rhNNyBQ91d/Un062hk8ouWtJPd4gDxESxCtT9X787v0y5uZKSpdDHN4oPgAv5GWzor8a6nfmizUolyOCJUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=W7pCne7L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XTTKKBSL; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="W7pCne7L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XTTKKBSL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4118A7A00AF;
	Wed,  8 Jul 2026 15:22:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 15:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783538542;
	 x=1783624942; bh=US3p9SG6e82G8+49sRdp72ZaEvKWTPm3F6EwQ8szNv4=; b=
	W7pCne7Lo5ljL5hZxDeH3a3J4mVaSmkjpeTlObpL0txandyJFYDKBdOcSRim6DP8
	OTY7BC4yaRY8xeUd8WKL7VMHYKE92ZznMIYjBlpIjpWgp8M0tF4vof7tWvnitCz4
	EkNW9DoG6kLhyp9sbFwreARGEnnqFEamSe+8EBQPl4IiykhiDyJB/4NpsreNvvwI
	Y3r0wxMs/RieOYf9fkRfjFEjTbQPIFr43PGtyW2fh3vdffJsK6Cab4KZ3SBT+38n
	aSCbq7/jd1UQUmP/wNBEVkfAaCWk+nSc+0K6/m01RquPG8sSEh2SbI39I1Ni5jNd
	CqnJRtSG8BPIZ/uHn1hKIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783538542; x=
	1783624942; bh=US3p9SG6e82G8+49sRdp72ZaEvKWTPm3F6EwQ8szNv4=; b=X
	TTKKBSLW0NmtYNUwOVnBqgN+ADxinUtus/jVN12lWj3WbI8yOTklYwDzq4NsIuwL
	Ecu3AdWSSj6cViwtzOfegiZF6aFXUujG/qgUZwG6BTB0zOdp0X6mCrS9FgMUcPnm
	SwZ2bDty/JRiwqb2J2mCFmx4/oHL+RDRS2VCWE2Xq61m5kz1tuuVIaELPf5AfB1W
	mxfURMHQTeBZl1+DxCc4wvx5ENTnTosLsIZ6MMihkaYfApdYUh0M/VABI9YHqAIW
	uviodaxIC5rqcZMtkUvy31B5kXYJ2iU+/fV0B1aczULZgjfDa7xkaxYgs7cq95Ld
	tagd1Gg4r/j8fTqZUX0bQ==
X-ME-Sender: <xms:baNOapgtuXNVNC7gqmylRRrO0VM16O7GmKVNWnRIpprVEr9c0WnOIA>
    <xme:baNOamLL7acYiHZYwctT9J3rM_lvsxb81g3xzOzi708OgYz6auuC8ldVrWQlbL16M
    ujy3epPY2I4h3NHre4Hz8hMBNOTzCEccVvThTL2xoTw1cz8GeRYuw>
X-ME-Received: <xmr:baNOaomy6miukbHpI46i600xl_bYzu1ezy2_ZwvdscCzWXhcYw3wQjHJH4PX74m_c1e__Ir0squi5jaBDx-vjXC72Nts0X-hlHdAGFOrdhobEv6b4Q>
X-ME-Proxy-Cause: dmFkZTEmsvvV9HHPTRQmQtXf4LOzDzuy7kAH2GiwuvzrL55iQdAksxn3EotBwQ4iR77KAQ
    xdgNkHHc8UjUAlTJ4y/FmDlI8umM3cmcUhe//hhM9W9SIa3hJjsBSzKv0H7U42SEAvMkO+
    AaVJijuO7PA8PETxfHCCKj3OEpuUy+cHkdwcqOjYAq8CjFLJ9QxCHpWs2+x0kmt7eY0TGA
    OX/9LXZadETzf+XGW6Sc14U/+vBHkehqSXgR8gDf7O5JBOMlQTu3da3KDDz2nTuht7EWod
    FnsupqthhKRxNL2yvOZcD5ozdiJoZo5gXn0Jo8SAWwcBXUVg4jyHgaIxYkWskDC2BXJgM0
    NulTQ1qI5uh9f5cbiJc40PCHFSEftyGa/3Hl4GU2OMr+BtriEXP5eOSjOgCx3L4mMazA2p
    FX/0Ip0Wj+j6GipW0NUd8WkbvdaCNFEtArEr9PhGtRWqypCcmMx9TQzvTv69VxNmBeAg44
    AZGLSQuWMkR7+ps5yAJctn/94S4PoVwGrh34+mjKri0sT3X18mCgOw9731EaHaJA6QceZA
    MenlhOb308JAi1o3bBedHPhXC92SQs/PQ8quTUTRIo8mMQk4dMAVK7i0OmdNVaBn8iyD0A
    3PdV9mBT9X3gYG8a6iyP8q5MgUiPya4jqN58kvhd2j3qq895IsNR6ngpiDAw
X-ME-Proxy: <xmx:baNOauOYCz_3BcW_0mhId1RxU_M3Tk4EuLrSjeVorZHuWT0OGmX8rQ>
    <xmx:baNOai4sgIvhkAYG2b9uPK_UQbgqz0W7VJY4IlCb4GKqsHSgtWQa8w>
    <xmx:baNOaibDGZE2rHpi8pwmmr8JWbPv-mkDQpbXoF9OWK_k1LKLkwOhaQ>
    <xmx:baNOavdFPmH_62_K9QuEo1AVp3qsPlYy4YjxUWqgW6Xw0Y5sqbYr6Q>
    <xmx:bqNOakHr1OPBpI7qvbv9JQG8u3Bm_2CLnlH-8t8MYbCbUy8a9sJ0A_Fn>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 15:22:20 -0400 (EDT)
Message-ID: <cf0574fc-03d8-4b0b-b1f4-bbca59e31686@bsbernd.com>
Date: Wed, 8 Jul 2026 21:22:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: reject oversized payload_sz in
 fuse_uring_copy_from_ring()
To: Xiang Mei <xmei5@asu.edu>, Joanne Koong <joannelkoong@gmail.com>,
 djwong@kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: stable@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 Luis Henriques <luis@igalia.com>, Weiming Shi <bestswngs@gmail.com>
References: <20260707184417.3682270-1-xmei5@asu.edu>
 <20260707184417.3682270-2-xmei5@asu.edu>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260707184417.3682270-2-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Xiang,

On 7/7/26 20:44, Xiang Mei wrote:
> fuse_uring_copy_from_ring() imports the payload buffer with length
> ring->max_payload_sz but passes the server-controlled payload_sz to
> fuse_copy_out_args() unchecked.  A larger payload_sz drains the iterator
> to exhaustion and fuse_copy_fill() hits BUG_ON(!err), panicking the
> kernel.  Reject replies whose payload_sz exceeds the imported buffer.
> 
>   kernel BUG at fs/fuse/dev.c:1053!
>   RIP: 0010:fuse_copy_fill+0x6c6/0x7e0
>   Call Trace:
>    fuse_copy_args
>    fuse_uring_copy_from_ring     fs/fuse/dev_uring.c:686
>    fuse_uring_cmd
>    io_uring_cmd
>    __io_issue_sqe
>    io_submit_sqes
>    __do_sys_io_uring_enter
>    entry_SYSCALL_64_after_hwframe
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
>  fs/fuse/dev_uring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 0814681eb04b..f6127c230dd9 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  	if (err)
>  		return err;
>  
> +	if (ring_in_out.payload_sz > ring->max_payload_sz)
> +		return -EINVAL;
> +
>  	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &iter);
>  	if (err)
>  		return err;

Good catch and sorry for lare review! Hrmm, it just gives me a bit headache,
because idea for max_payload_size in fuse_uring_create() that it prevents 
exactly that.

After tracing through the code, I think we have two cases where max_payload calculation
in fuse_uring_create() is not enough for xattr and ioctl

For xattr we have an additional in addition to the patch above - it sends unchecked
against max_pages and  fuse_dev_do_read() has an additional op code protection
that I had missed

       /* If request is too large, reply with an error and restart the read */                                                                                         
        if (nbytes < reqsize) {                                                                                                                                         
                req->out.h.error = -EIO;                                                                                                                                
                /* SETXATTR is special, since it may contain too large data */                                                                                          
                if (args->opcode == FUSE_SETXATTR)                                                                                                                      
                        req->out.h.error = -E2BIG;                                                                                                                      
                fuse_request_end(req);                                                                                                                                  
                goto restart;                                                                                                                                           
        }                                                                                                                                                               



And I think with the current patch is incomplete and missing something like this

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 77c8cec43d9c..449b84ac24e7 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -725,6 +725,14 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
                num_args--;
        }
 
+       /*
+        * A FUSE_SETXATTR value may exceed the ring buffer; match
+        * fuse_dev_do_read() instead of overrunning the payload iterator.
+        */
+       if (fuse_len_args(num_args, (struct fuse_arg *)in_args) >
+           ring->max_payload_sz)
+               return args->opcode == FUSE_SETXATTR ? -E2BIG : -EIO;
+
        /* copy the payload */
        err = fuse_copy_args(&cs, num_args, args->in_pages,
                             (struct fuse_arg *)in_args, 0);



And a generic patch, but that has the potential to break existing userspace is

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 449b84ac24e7..d25d7922bbdd 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -251,7 +251,14 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
                goto out_err;
 
        max_payload_size = max(FUSE_MIN_READ_BUFFER, fch->max_write);
-       max_payload_size = max(max_payload_size, fch->max_pages * PAGE_SIZE);
+       /*
+        * A max_pages-sized paged reply may be preceded by a fixed op reply
+        * header (e.g. FUSE_IOCTL); reserve a page of header room generically.
+        */
+       max_payload_size = max(max_payload_size,
+                              fch->max_pages * PAGE_SIZE + PAGE_SIZE);
+       /* getxattr/listxattr values are bounded only by XATTR_SIZE_MAX */
+       max_payload_size = max(max_payload_size, (size_t)XATTR_SIZE_MAX);
 
        spin_lock(&fch->lock);
        if (!fch->connected) {


Question is how we could add it in, maybe with a feature flag?


Thanks,
Bernd
