Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664860;
	b=qhdl7yUEZldEaod/E3GgPM1S9o9D7BsCz54G/4smzreuLhMHF++OEPCtRH1hGsCtGz96
	 Tmse4dyT8kh6KUqvHGTQwCr88zc1Hgv+mUpNxBxxqwkRODt7hoUMJSDJkWFSUcRx/gARd
	 3R7LMPgGipwu1ulk3NQlv0Bxsctsdr5v7fJgASJgx8VqALPyMPTBJWTDE5N7wAD72iReM
	 yXTDi2ARUnPxZ1N5QCcKT3BXOcjRiEWYfTY+djg/bo3DXS1FwYrOIWCrYn0bnOjPITKut
	 rPI7/ypZJJ43n3qMkOS33LEQ/xaRDSy5fGKy3rOTrwdA1m5ivvNx3B74WDRMg9yfVdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664860;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZAd7X9/vJXNgFIS3+YuK/KTO3oVmAseHL1ppDeOuesI=;
	b=U7fNWy+HS6kBcNnLD72ekD60cqMFQ8wK17vzcx06I7fVotM1sl/gr7lc1wlvd8MYUMiP
	 TkdMU4oK5pKC3Ti6rpFUTG9nkqoRou0KvCiMzqSjZo1BiubWfqwKS48BsX80Qs8N2sowh
	 E2KgRtJjwmjPEgxb7yvvE3QKnLXgSHzUV0UwwsSq0JOXun8Ff9kT6GBl13OvrQJinnhnT
	 we0/HKcvvGjp3aiSMHwXOSniiB9xueJYaiEN0U/1djOcMjApTWtt9Wn0Rr+sUE5qxQojT
	 nYsPkSlUPxemnFynAHwVw8e9pbH2DQKj4b85t6GrYu6Tm/4U+kIBR3JdBBFKzlhsZeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxGUBlou;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B8606A329;
	Thu, 22 Oct 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxGUBlou
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A9E1F000C2;
	Thu, 22 Oct 2026 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664859;
	bh=ZAd7X9/vJXNgFIS3+YuK/KTO3oVmAseHL1ppDeOuesI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bxGUBloucVM+lNbKykAaw+ya3sDGs8o0gytT8hhahdNWlvr3VuNZR1/ATpGpSTA1t
	 PhXH22CVY18yOzTaiczHI0E8Wx0YeQjbbi+Mvi606oCvlyzOHVF9Jqce+WvsZ9I9RJ
	 fbBsHBIy0v/UUG393k69EJYNrF/lLAlIdjgQMl6mzknakAQiZnD/MCgW3IG48tsiIb
	 Ds7JfpTempUGRK6B+qWTuanKie0jqif6cy8SmWdOQlTjO8KPshwuCS0eJs/w/cBqC6
	 +MOELABAqbD2Z4e+vJQhBsgRKSKoDD+NT00SD69umf1Y0EI5bhqsW5r2lH9IfGk0Tc
	 6fK4+2//XlxPA==
Subject:
 Re: [PATCH net] tls: check the right open record in TLS_TX_MAX_PAYLOAD_LEN
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, wilfred.mallawa@wdc.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 10:27:38 +0000
Message-ID: <179266485852.3135.2917953974496928848@kernel.org>
In-Reply-To: <20261019222626.745408-1-rjethwani@purestorage.com>
References: <20261019222626.745408-1-rjethwani@purestorage.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The TLS_HW check added to do_tls_setsockopt_tx_payload_len()
  (net/tls/tls_main.c) only rejects the change when…

--

tls: check the right open record in TLS_TX_MAX_PAYLOAD_LEN

This patch changes do_tls_setsockopt_tx_payload_len() to look up the open
record based on ctx->tx_conf. For TLS_HW it now checks
tls_offload_context_tx::open_record, instead of casting priv_ctx_tx to
struct tls_sw_context_tx. The aim is to stop HW offloaded TX from building
records larger than a limit that setsockopt has accepted.

> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index fbb274287aa5..8f11b8629492 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -837,12 +837,23 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
>  					    unsigned int optlen)
>  {
>  	struct tls_context *ctx = tls_get_ctx(sk);
> -	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
>  	u16 value;
>  	bool tls_13 = ctx->prot_info.version == TLS_1_3_VERSION;
>  
> -	if (sw_ctx && sw_ctx->open_rec)
> -		return -EBUSY;
> +	/* Both TX paths size the record they are filling against
> +	 * tx_max_payload_len, so refuse to change it under an open record.
> +	 * priv_ctx_tx is a different struct for each TX configuration.
> +	 */
> +	switch (ctx->tx_conf) {
> +	case TLS_SW:
> +		if (tls_sw_ctx_tx(ctx)->open_rec)
> +			return -EBUSY;
> +		break;
> +	case TLS_HW:
> +		if (tls_offload_ctx_tx(ctx)->open_record)
> +			return -EBUSY;
> +		break;
> +	}

[Severity: Medium]
Can a concurrent HW send still produce records larger than the new limit
after this check passes?

The setsockopt path takes only the socket lock and not ctx->tx_lock:

net/tls/tls_main.c:do_tls_setsockopt() {
    ...
	case TLS_TX_MAX_PAYLOAD_LEN:
		lock_sock(sk);
		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
		release_sock(sk);
    ...
}

On the device side, tls_device_sendmsg() holds tx_lock for the whole
send. However, tls_push_data() reads the limit only once, before its loop:

net/tls/tls_device.c:tls_push_data() {
    ...
	max_open_record_len = tls_ctx->tx_max_payload_len +
			      prot->prepend_size;
	do {
		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
		if (unlikely(rc)) {
			rc = sk_stream_wait_memory(sk, &timeo);
    ...
		copy = min_t(size_t, size, max_open_record_len - record->len);
    ...
		if (done || record->len >= max_open_record_len ||
    ...
}

Inside the loop, the socket lock can be dropped while open_record is NULL.
This can happen in two places:

  tls_push_record()
    offload_ctx->open_record = NULL;
    tls_push_sg()->tcp_sendmsg_locked()->sk_stream_wait_memory()
      sk_wait_event()->release_sock()

and also when tls_do_allocation() fails with no open record and
tls_push_data() calls sk_stream_wait_memory() directly.

If a second thread calls setsockopt(SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN) with a
smaller value during either window, the new TLS_HW check sees open_record
as NULL and the call returns 0. The blocked send then continues to build
records against the old, larger max_open_record_len.

The SW path looks different here. tls_sw_sendmsg_locked() re-reads the
limit after open_rec is allocated on every iteration:

	record_room = tls_ctx->tx_max_payload_len - msg_pl->sg.size;

Given that, is the new comment accurate for TLS_HW? It says "Both TX paths
size the record they are filling against tx_max_payload_len", but the
device path uses a cached copy.

Would it make sense to recompute max_open_record_len from
tls_ctx->tx_max_payload_len each time tls_push_data() starts a new record?
Another option would be to take tx_lock in the TLS_TX_MAX_PAYLOAD_LEN
setsockopt path before lock_sock().

>  
>  	if (sockptr_is_null(optval) || optlen != sizeof(value))
>  		return -EINVAL;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019222626.745408-1-rjethwani%40purestorage.com
