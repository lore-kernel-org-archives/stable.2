Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794119290;
	b=35uzd78DId9HqmP5WWb5khWxysTFnK6Eujygopv06CB0Sp7Wl6Z+ZAy0iXdSdNTZ97XP
	 oGxGGdsjDzBwr0GgoqRuzu3zJicQb5olXcCcP7/1Ul7jyMmR/MmbJMrbP6n0i7RwBmPY6
	 kNjl3QfSnBIV7QyNnwIoUdsTM9z+5OT+YSRS796wGjkW5tUa1pNYJmfg55lDdDrMzZ8bw
	 MgYkpyNWUL2MTi6Er+305Ubs/usamBybTSuvbnR6BCXlHWoIfp5He3PYR6LaFZSvtVMfs
	 xkpedC8I6s/5hVKc8rM5zdf096/GhqvaShd9MqBvJ0D/d8GXX6kKm56b4L5g1QnNzeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794119290;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GmtsPiMSdPb7buBasD1wcQJp98i4wRyriYYk3hWW9rI=;
	b=uVxkIJhOs7nJaOwVocRFK2xZ0omlfBbRiVnJ3CY/q9HtEDHBr5HXSRtxoRtnkFmczZQS
	 +jxV2jrLVjzHfCFF2xSsfnLe7KFtem4ZrYqGNes4z/84lmQQOx5H84YDwJWRwIqp3jz35
	 p9uX8flMP8fn7fXat8dHVo+2LH3awYv5wi89TUMsEuQd8j//RfpbicP3sELbOVv+ynhOE
	 B6yWYoluOrSAfvE5MQZlsGe4TwQ86g8cDOEqoa8XA2zyu7r9DzrnAXsnAPkH97vBGdB8P
	 BoYoKMlYdzLoN7tL/trOxWGG8VYGCTQLxnsUgNbU8U7XANSzVWBsr338nsHpnh/862A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzfLuXBz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F370606A31A;
	Sun,  8 Nov 2026 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JzfLuXBz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC071F0089F;
	Sun,  8 Nov 2026 06:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794119289;
	bh=GmtsPiMSdPb7buBasD1wcQJp98i4wRyriYYk3hWW9rI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JzfLuXBzGOVuceG6d0VXFOme4v93UgmYjElTdAc3KsKgOB0uDmflOWeBhB2SyHf6F
	 KAEAoQRDjMdXdfYjdqKo4YFkTPSiRjocNknVYhJRtw5y7VEBBk0ClBwKPJE7Ihl+1A
	 jGr7gQVZngKujMyfhnbX+L2PpB0L1c5b9ufk6ehAn77gG8EeLIxG7bQiONuGJz1HoX
	 Vt8V7mcdW8x6nQ/e1FdFIZZXCH9zdCD9iPDoYTLYayazFU7aQxDLmDq29UN27ZpNdg
	 mXsHak1kOdoC8X/IgQ5gC7xwlto5w5uDju9mgY+1XmJFi5CjxA3JbH00LetJd/syYz
	 tCGVMwP4sBXSw==
Subject: Re: [PATCH net] gve: bound the device reported rule count in the flow
 rules query
From: netdev-bot+sashiko@kernel.org
To: yhlee@isslab.korea.ac.kr
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, willemb@google.com,
 pkaligineedi@google.com, jeroendb@google.com, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 06:28:08 +0000
Message-ID: <179411928865.994134.15713036918131150201@kernel.org>
In-Reply-To: <20261104061329.1881388-1-yhlee@isslab.korea.ac.kr>
References: <20261104061329.1881388-1-yhlee@isslab.korea.ac.kr>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message gets the pre-patch impact of the
  GVE_FLOW_RULE_QUERY_IDS path wrong.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  gve_adminq_process_rss_query() in…

--

gve: bound the device reported rule count in the flow rules query

This patch makes gve_adminq_process_flow_rules_query() reject a
device-reported num_queried_rules that does not fit in the admin queue
buffer after the descriptor. The check runs before the count is turned
into a memcpy() length. It is applied to both the
GVE_FLOW_RULE_QUERY_RULES and GVE_FLOW_RULE_QUERY_IDS opcodes.

> For GVE_FLOW_RULE_QUERY_IDS the destination is large
> enough, but the descriptor and the rule array share one
> GVE_ADMINQ_BUFFER_SIZE block and the array starts after the descriptor, so
> counts of 1021 to 1024 read past that 4096 byte block.

[Severity: Medium]
Is this description of the pre-patch QUERY_IDS behavior complete? It
seems to hold only for counts up to 1024.

rule_ids_cache is allocated in gve_alloc_flow_rule_caches() as:

    kvcalloc(GVE_FLOW_RULE_IDS_CACHE_SIZE, sizeof(*flow_rules_cache->rule_ids_cache),
             GFP_KERNEL);

GVE_FLOW_RULE_IDS_CACHE_SIZE is GVE_ADMINQ_BUFFER_SIZE divided by the size
of a __be32 location. That makes the cache 1024 entries, or 4096 bytes.

Before this patch, a reply with num_queried_rules = 1025 and
total_length = 4116 passes the total_length check. The memcpy() in
gve_adminq_process_flow_rules_query() then writes 4100 bytes into the
4096-byte rule_ids_cache, and larger counts write further. So the IDS path
looks like it also had a heap write overflow, not only a 4 to 16 byte
over-read.

There is also a wrap case. For num_queried_rules >= 2^30 the u32 multiply
num_queried_rules * 4 wraps, so the memcpy() is small. However,
rule_ids_cache_num is still set to the huge count. gve_get_flow_rule_ids()
then walks past the 1024 entries:

    for (i = 0; i < *cache_num; i++) {
        if (j >= cmd->rule_cnt)
            return -EMSGSIZE;

        rule_locs[j++] = be32_to_cpu(rule_ids_cache[i]);

Those values reach userspace through ETHTOOL_GRXCLSRLALL.

The RULES path can wrap the same way, since 2^29 * 88 is 0 mod 2^32. The
resulting rules_cache_num is then walked through ETHTOOL_GRXCLSRULE. That
command is in the same no-CAP_NET_ADMIN list in net/ethtool/ioctl.c, but
the commit message only mentions ETHTOOL_GRXCLSRLALL.

The new bounds do cover all of these cases. Could the commit message also
mention the write overflow for more than 1024 ids and the multiply wrap on
both paths?

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 8b215fca9c1b6..02c1f398f6e39 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1542,14 +1542,20 @@ static int gve_adminq_process_flow_rules_query(struct gve_priv *priv, u16 query_
>  {
>  	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
>  	u32 num_queried_rules, total_memory_len, rule_info_len;
> +	u32 rule_info_max_len;
>  	void *rule_info;
>  
>  	total_memory_len = be32_to_cpu(descriptor->total_length);
>  	num_queried_rules = be32_to_cpu(descriptor->num_queried_rules);
>  	rule_info = (void *)(descriptor + 1);
> +	rule_info_max_len = GVE_ADMINQ_BUFFER_SIZE - sizeof(*descriptor);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
does gve_adminq_process_rss_query() in gve_adminq.c need the same kind of
bound?

gve_adminq_query_rss_config() also allocates its descriptor from
priv->adminq_pool, whose blocks are GVE_ADMINQ_BUFFER_SIZE bytes. The only
length check compares device-supplied values with each other:

    hash_lut_length = priv->rss_lut_size * sizeof(*rxfh->indir);

    if (sizeof(*descriptor) + priv->rss_key_size + hash_lut_length != total_memory_length) {

gve_enable_supported_features() takes the key and LUT sizes from the
device with no upper bound:

    info->rss_key_size =
        be16_to_cpu(dev_op_rss_config->hash_key_size);
    info->rss_lut_size =
        be16_to_cpu(dev_op_rss_config->hash_lut_size);
    info->cache_rss_config = false;

Nothing then caps the total at GVE_ADMINQ_BUFFER_SIZE - sizeof(*descriptor)
before these reads:

    memcpy(rxfh->key, rss_info_addr, priv->rss_key_size);
    ...
    for (i = 0; i < priv->rss_lut_size; i++)
        rxfh->indir[i] = be32_to_cpu(lut[i]);

hash_lut_length is also a u16. With rss_lut_size = 16384 it truncates to
0, so the check passes against a small total_length while the loop still
reads 64 KiB of LUT.

The ethtool destination buffers are sized from gve_get_rxfh_key_size() and
gve_get_rxfh_indir_size(). Those return the same device values, so they do
not limit the read either.

Because cache_rss_config is false, gve_get_rxfh() always calls
gve_adminq_query_rss_config(). ETHTOOL_GRSSH also does not require
CAP_NET_ADMIN.

Can this copy kernel memory from beyond the 4096-byte DMA block to an
unprivileged user?

>  
>  	switch (query_opcode) {
>  	case GVE_FLOW_RULE_QUERY_RULES:
> +		if (num_queried_rules >
> +		    rule_info_max_len / sizeof(*flow_rules_cache->rules_cache))
> +			return -EINVAL;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104061329.1881388-1-yhlee%40isslab.korea.ac.kr
