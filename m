Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564825DB1A;
	Fri, 10 Jul 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691357; cv=none; b=txBN/EFYEc6JZx8IFrg3Nc6P5BkqGswCYqh9Q/GdzvWQXtL+yQ7xZAqd/iZLeObWxLV1QM7somP3HfJRPM1kiBdEOFtLMed5N/cLu1h66NC+/LUlKIaEYVR9j7GoDFMb/LUBGuRCgKJ/ERF/OOKwJOI66JAXE8NM7o97f+SVQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691357; c=relaxed/simple;
	bh=Z05OLJEB22TK9VRWOreArFil14x3dUWnZjYtYZzIuAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mopz95ZpoxY8tC1U9r4SLQKGGZo7UyFBhMY0Ungf0fTkKKKK5qKEEdlIucVkJO1oLcjWir1qLMUDB6aXCFaW8S/6RFjDgzQKHOCWyTY4CPaJ/SdKm5TiWumbr2wW9K7nPmj3ZYsc1ycKvfi7RMk/iP6+72i6PN6UdYn7O0L0Ejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpdJeF+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpdJeF+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FE11F000E9;
	Fri, 10 Jul 2026 13:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691356;
	bh=JAtX8AhNJx6QPGTAuQ0ZGdruw/eZPEaNb1FV9Ob5Src=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpdJeF+QbdQeoWjcOvuIzetth87eF9V6cQEOjv+sFxU6BXR5G3nWYVBcRZ19xxFnq
	 m3MGtURS7GoGylsQs0RGydM1Ur9KhlBRSt2zZBo1Mpudr41I1YQaPZFnX7UCulqmyF
	 SGmgGn3kHhiyg8T6ekTrkgsnch23wodENV5Ytjj2qIpJJ8oSkQlne968lqkrg2toCI
	 5WlPOGjVqNlZdFtR1zfGTCjbNtGhotUIR4S3wNy0z/syGAm5goGRVUbhvFYHg4yNLd
	 mvmob9aL6YjhmzAiwgKi4xxfg6dqfqCLyVgt2h7Ehro5Na5fMbMfjFaLZYeOtSRiJS
	 RgZ4U9s0WpY+Q==
From: Simon Horman <horms@kernel.org>
To: doruk@0sec.ai
Cc: Simon Horman <horms@kernel.org>,
	david@ixit.cz,
	oe-linux-nfc@lists.linux.dev,
	david.laight.linux@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: bound the remaining LLCP TLV parsers to their buffers
Date: Fri, 10 Jul 2026 14:48:50 +0100
Message-ID: <20260710134850.1615092-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705115607.60844-1-doruk@0sec.ai>
References: <20260705115607.60844-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
nfc: llcp: bound the remaining LLCP TLV parsers to their buffers

The commit adds pointer-based bounds to nfc_llcp_parse_gb_tlv(),
nfc_llcp_parse_connection_tlv() and nfc_llcp_connect_sn(), replacing
the previous u8 offset walk which could wrap and produce an unbounded
TLV loop. It cites the size_t underflow of "skb->len - LLCP_HEADER_SIZE"
as one of the failure modes it wants to close.

> diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
> index 291f26facbf3..1a0a2f4aca70 100644
> --- a/net/nfc/llcp_commands.c
> +++ b/net/nfc/llcp_commands.c

[ ... ]

> @@ -243,17 +246,21 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
>  				  const u8 *tlv_array, u16 tlv_array_len)
>  {
>  	const u8 *tlv = tlv_array;
> -	u8 type, length, offset = 0;
> +	const u8 *tlv_end = tlv_array + tlv_array_len;
> +	u8 type, length;
>  
>  	pr_debug("TLV array length %d\n", tlv_array_len);
>  
>  	if (sock == NULL)
>  		return -ENOTCONN;
>  
> -	while (offset < tlv_array_len) {
> +	while (tlv + 2 < tlv_end) {
>  		type = tlv[0];
>  		length = tlv[1];
>  
> +		if (tlv + 2 + length > tlv_end)
> +			break;
> +

[High]
Is the size_t underflow the commit message mentions actually addressed
for nfc_llcp_parse_connection_tlv()?

The two callers, nfc_llcp_recv_connect() and nfc_llcp_recv_cc() in
net/nfc/llcp_core.c, still compute the length at the call site as
skb->len - LLCP_HEADER_SIZE and hand it to the parser:

    nfc_llcp_parse_connection_tlv(new_sock, &skb->data[LLCP_HEADER_SIZE],
                                  skb->len - LLCP_HEADER_SIZE);

and

    nfc_llcp_parse_connection_tlv(llcp_sock, &skb->data[LLCP_HEADER_SIZE],
                                  skb->len - LLCP_HEADER_SIZE);

If skb->len is 0 or 1, that subtraction (size_t at the call site,
truncated to the u16 tlv_array_len parameter) becomes 0xFFFE or 0xFFFF.

Inside the parser, that value now feeds:

    const u8 *tlv_end = tlv_array + tlv_array_len;

    while (tlv + 2 < tlv_end) {
            ...
            if (tlv + 2 + length > tlv_end)
                    break;

so tlv_end points roughly 64 KiB past &skb->data[LLCP_HEADER_SIZE] and
neither the loop condition nor the per-TLV check catches the walk
leaving the skb.

The commit message calls this out as one of the motivations:

    "Dropping the u8 offset also removes the wrap, and for very short
    connect frames this avoids the size_t underflow of
    'skb->len - LLCP_HEADER_SIZE'."

That mitigation is applied inside nfc_llcp_connect_sn() by using
skb_tail_pointer(skb) directly, but the equivalent change is not made
for the connection TLV path. nfc_llcp_rx_skb() has no minimum-length
guard, so a received CONNECT or CC PDU with skb->len < LLCP_HEADER_SIZE
still reaches these callers.

Would it make sense to either guard skb->len >= LLCP_HEADER_SIZE
before the two call sites, or take the same skb_tail_pointer() based
approach used in nfc_llcp_connect_sn() so the parser derives its bound
from the skb rather than from an untrusted subtraction?

> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index dc65c719f35f..5e1881199238 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -849,13 +849,16 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
>  static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
>  {
>  	u8 type, length;
> -	const u8 *tlv = &skb->data[2];
> -	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
> +	const u8 *tlv = &skb->data[LLCP_HEADER_SIZE];
> +	const u8 *tlv_end = skb_tail_pointer(skb);
>  
> -	while (offset < tlv_array_len) {
> +	while (tlv + 2 < tlv_end) {
