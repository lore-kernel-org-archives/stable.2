Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025727;
	b=u75YpLUnB+pzMHm/fsLfKvb+vs5UJqAyfh7S87W3CUIBgyVMJJV35WiesnND0aJuw1VP
	 gRTL9LY2N8gxt1KXpUePFLu/QuL69GReDIKZ0SnaGg7PUjyZnBOv7mqvmlnPbh1fX61Ko
	 uSAiCbRJUIjcbimTVjSHa437VSsyIAEwKc/GkUNx3R2OfKCb/ChfkNUVIvXGp60Dx0MkE
	 8LAV4+C0BO8joU3cMnL7ZvUZ+VmmW8Z4JrFAW5lRuWG4035gr5I/x8MYXSmyDV/Z9adh1
	 CrpFcc9hAoS3R1aqE9UR/v/6TIcVHnJw1Mq8JWNZIUEiLcC1k39GDXwjk5fD1JS+AQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025727;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=sVmxi9G3P4SUdw7es16Dz291BqgE7cTnIFEDumgKpt0=;
	b=XVqt8CI7N5HOa/HO9Y4lIDTzx1DSsy5/K9KXTCzNlI9AeEvsj87vR4B3NAXb1dIiekyN
	 6JjKkpniPheNF6yHNlEsFSi9j882Sm7GlxDIoWVf0Tu9L46exiZGVc4vi0s64mIMawgnP
	 On0MhqVcGQyA/qq0gMlaSblQa2lh/IlWQyf8KSxZPFbzgktq/5dDOo2LaiJxJwGr0F7CC
	 dIBy5LfFGIaSyb6NToAdQuNEQzcJOaSRSiufSMLapnLrw4Q8ScBwa+sahLMYB3fqe9myN
	 0Wi3JnP3U+cJUyw+iHtdjfwrfXqf/o5xwYKGjmg8Gl3jrFOoxLv3aTDeAqK/mIW0NXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkKLIzbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F00606A31F;
	Mon, 26 Oct 2026 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkKLIzbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019FB1F01825;
	Mon, 26 Oct 2026 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025726;
	bh=sVmxi9G3P4SUdw7es16Dz291BqgE7cTnIFEDumgKpt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nkKLIzbOpUK72ZDkrA7asz2g0qX6g54gLI11w498h0LAwdNdbWbU4WyidF54SJFLi
	 iM+ShMKFz2Gfa0NrCb62teKCaxETXiaV79Mi+7/yy/9mwDT+8tZFqfyJPwm2Nx2rHA
	 ewH4jUBRH0Xp2oIWxAKQEFXTjH7O1fkbmHYTlrNFtBRmF/MdOgkiQJCdNcJw1PqsQE
	 gvPGlzFG5SD6I5n8yx9JFI7NBjZT+CBBG4klAjBV3vuOIJ8ZhMJyfZl40Hk0HYhMI8
	 1KM+kO9U4P8cqqpZzB7PRbJ+C0dc21OU2beux6icZ6M84SEGTYQFQ8Myu8+xIkrY7A
	 ABdNKCctCp+WA==
Date: Mon, 26 Oct 2026 20:11:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Joonhoe Kim <26rote@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, christopher.lew@oss.qualcomm.com, 
	deepak.singh@oss.qualcomm.com, pranav.phansalkar@oss.qualcomm.com, andersson@kernel.org, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: qrtr: announce local services again once our
 HELLO is sent
Message-ID: <at9mFUv1flg-6aMB@debian>
References: <20261022163116.1042-1-26rote@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022163116.1042-1-26rote@gmail.com>

On Fri, Oct 23, 2026 at 01:31:16AM +0900, Joonhoe Kim wrote:
> Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
> register"), qrtr_node_enqueue() drops every packet but HELLO with
> -EAGAIN until our HELLO has gone out to the node. When the remote's
> HELLO arrives first, the NEW_SERVER replies from the name service are
> dropped, and so are the broadcasts for services registered before our
> HELLO goes out. Nothing announces these services again, so the remote
> never learns about them.
> 
> On Kaanapali the modem sends its HELLO before it accepts ours. With
> rmtfs started first, the modem never learns about rmtfs and its
> watchdog resets the SoC about 40 s later.
> 
> Remember that the remote has sent a HELLO. Once our HELLO has been
> sent to such a node, pass a HELLO from it to the local name service
> again, so that it announces the services it has at that point.
> 
> The flag is not cleared when qrtr_endpoint_hello() restarts the
> handshake on resume, so a HELLO that the remote sent before then is
> not lost. The cost is that the remote gets the same NEW_SERVER
> announcements twice when its HELLO arrives before ours goes out but
> the name service handles it after, and on every resume.
> 
> Fixes: 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint register")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>

This version looks good to me, although I left a few comments inline.

> ---
> Changes in v2:
> - Replay the remote's HELLO to the name service from the core once our
>   HELLO is out, instead of retrying in announce_servers(). Replaying
>   the announcements once hello_sent is set was suggested in the Sashiko
>   review of v1. This is also not the delayed work in the name service
>   that I mentioned to Mani: that would still miss the broadcasts
>   dropped before our HELLO. Nothing sleeps in the name service worker
>   and there is no time limit.
> - v1: https://lore.kernel.org/all/20261016124600.31-1-26rote@gmail.com/
> 
> Tested on a Lenovo Legion Tab Y700 Gen 5 (out-of-tree board support)
> with rmtfs started before the modem: the modem's HELLO is still handled
> before ours is out ("failed to announce new service"), the replayed
> HELLO follows right after, rmtfs gets the modem_fs1/2 opens, and the
> modem stays up.
> 
>  net/qrtr/af_qrtr.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
> index e7b364742..508a2dd2d 100644
> --- a/net/qrtr/af_qrtr.c
> +++ b/net/qrtr/af_qrtr.c
> @@ -122,6 +122,7 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
>   * @qrtr_tx_flow: xarray of qrtr_tx_flow, keyed by node << 32 | port
>   * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
>   * @hello_sent: hello packet send successful
> + * @hello_rcvd: remote has sent a hello packet
>   * @rx_queue: receive queue
>   * @item: list item for broadcast list
>   * @say_hello: delayed work for sending hello packet
> @@ -136,6 +137,7 @@ struct qrtr_node {
>  	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
>  
>  	bool hello_sent;
> +	bool hello_rcvd;
>  
>  	struct sk_buff_head rx_queue;
>  	struct list_head item;
> @@ -541,6 +543,11 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
>  		qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
>  	}
>  
> +	if (cb->type == QRTR_TYPE_HELLO) {
> +		/* Pairs with smp_load_acquire() in qrtr_hello_work() */
> +		smp_store_release(&node->hello_rcvd, true);

smp_store_{release/acquire}() accessors are only needed if there is an ordering
requirement. But I don't see that exist with this 'hello_rcvd' bool flag.
Wouldn't {READ/WRITE}_ONCE() suffice?

> +	}
> +
>  	if (cb->type == QRTR_TYPE_RESUME_TX) {
>  		qrtr_tx_resume(node, skb);
>  	} else {
> @@ -619,7 +626,20 @@ static void qrtr_hello_work(struct work_struct *work)
>  	pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
>  	from.sq_node = qrtr_local_nid;
>  	to.sq_node = node->nid;
> -	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to);
> +	if (qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to))
> +		goto out;
> +
> +	/* Pairs with smp_store_release() in qrtr_endpoint_post() */
> +	if (!smp_load_acquire(&node->hello_rcvd))
> +		goto out;
> +
> +	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
> +	if (skb) {
> +		pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
> +		to.sq_node = READ_ONCE(node->nid);

There is no READ_ONCE() in the earlier read. So please justify why you added it.

> +		qrtr_local_enqueue(NULL, skb, QRTR_TYPE_HELLO, &to, &from);

What happens to the return value?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
