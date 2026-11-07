Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063019;
	b=3S64vaSbHet1jB/082kGeaI502Udq2Zjm+c1xgyYbWDlmBprJPn21xomLphDy6PoQ21e
	 u2nFig4T6N70H0Ek6TU5elpjPXk+GAIpL2OoyWaCqqSNua3oPDlcOrpQE9ug8eE6b9cGe
	 xmS6PSqEj0A+sFbp7CGxy80M00IUT7huGowRz2WZBmK1EtZL0kuKf7bDPKsGi79e4DNcR
	 pUqPkYBFaJW6/RXpQTN9kM0ayC4OVj1UCkL6Q1RYw+2Jz3CLrLOycSG1Iuw56DTOGjM3j
	 BOyvgYti5yC7CeLnWQvG2xUhnAPi0SqNHFiWga6qSx/tpxJLKGK/Kyun5syNDs4g+LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063019;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1xaaoP/EG1BtJMDCy2mKZ4SODT4vwuwFBsmwd28CmvY=;
	b=wI/HXrgIcans+ZKSGaGE2QSvNe58v+OKQJvNJbBklbcpF3FYAPIXujcDFhToTq0PvYmh
	 Nq9KAKbopAjb97ogu2cTKN/ui7LWkJyvlSKW1iZEToLdmRTHgXJ6MFbYtMmudTf4ZR16K
	 4s5tbA8XdR6h8fbo0hvPe6ctxFnwYm31VgBxN0NsLefaeuUmKaPx0s/6Jw9ydoE8pSuEK
	 upuOklHIpq3vIdDWHx7JipRiuzz3JkDhOQ+RaDUS7sGsU/XYa146/XN+wYuYBaRKxuKT7
	 whPhG4V4Xwokg2/aNhgagHq/CWmJI+DNYFzp9c0iu6ZL+ilzYxfu8H9yGOZROqsQTJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtROPTc3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70336606D81F;
	Sat,  7 Nov 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtROPTc3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC3B1F008A1;
	Sat,  7 Nov 2026 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063019;
	bh=1xaaoP/EG1BtJMDCy2mKZ4SODT4vwuwFBsmwd28CmvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZtROPTc3VvVBjBBGFVuqEVgmoZxKAKdVEpq7p6GeaJYPuVQD2WoXu2i66gKMirEDJ
	 Dh544hMztf7YD10m0SmAmCJvobW50BebIQlHYh7Ui7lsy9brqt9Lfa5qDmEc0c6gm6
	 PsmSrUhoVlq2NiPUywFu+J6f9IbENnEGuWixlYRe+fDEq0xJQYminKqOkbfXiY/Qgc
	 uLz70sVXaZkx12L+44qg8pyfvu9IlpBm7ph9UpGtmkEwQpUiQa+pspRCv/AEo986kT
	 /e3sQiy0RhUk5zFF1stbB+C8G9VXg7ldbopEvbPLaDJXhOf4YGnWhJM+uSP+O7aZa7
	 NZED9D3KZ0c3A==
Subject: Re: [PATCH net v3 2/4] net/sched: act_ife: require a full Ethernet
 header on egress
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com,
 thomas.goff@boeing.com
Date: Sat, 07 Nov 2026 14:50:18 +0000
Message-ID: <179406301809.994134.18083601714109684155@kernel.org>
In-Reply-To: <SER-NSBD.v3.r0.20261103064310-2@mojatatu.com>
References: <SER-NSBD.v3.r0.20261103064310-2@mojatatu.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit is titled "require a full Ethernet header on
  egress".
- [Low] The commit message says "A short egress skb is now dropped
  instead of being encoded." The patch actually drops every egress skb…

--

net/sched: act_ife: require a full Ethernet header on egress

On egress, tcf_ife_is_eth_skb() now requires pskb_may_pull(skb, ETH_HLEN)
to succeed. Without that check, ife_encode() could copy ETH_HLEN bytes from
past the linear data of a short skb. The ingress mac_len check is unchanged.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821164031.32824-1-victor%40mojatatu.com
Link: https://sashiko.dev/#/patchset/20260821164031.32824-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20261022144736.61227-1-shawnq1@163.com/

> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 6b23a3965121e..5a527da005661 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -878,13 +878,16 @@ static int tcf_ife_encode(struct sk_buff *skb, const struct tc_action *a,
>   * is an Ethernet header because the skb could've been redirected with mirred
>   * from a non-Ethernet device.
>   */
> -static bool tcf_ife_is_eth_skb(const struct sk_buff *skb)
> +static bool tcf_ife_is_eth_skb(struct sk_buff *skb)
>  {
>  	if (skb->dev->type != ARPHRD_ETHER &&
>  	    skb->dev->type != ARPHRD_LOOPBACK)
>  		return false;
>  
> -	return !skb_at_tc_ingress(skb) || skb->mac_len == ETH_HLEN;
> +	if (skb_at_tc_ingress(skb))
> +		return skb->mac_len == ETH_HLEN;
> +
> +	return pskb_may_pull(skb, ETH_HLEN);

[Severity: Medium]
The subject says "require a full Ethernet header on egress". The commit
message also says tcf_ife_is_eth_skb() "returns true even when the skb has
no Ethernet header".

Does the new egress branch check that the skb has an Ethernet header, or
only that ETH_HLEN bytes are in the linear area?

Take the reproducer setup from the commit message and send an IP packet of
14 bytes or more instead of a short one:

tun_get_user() (IFF_TUN)
    skb_reset_network_header(skb);       /* mac_len is 0 */
tcf_mirred_to_dev()
    mac_len = at_ingress ? skb->mac_len : skb_network_offset(skb);
    skb_push_rcsum(skb_to_send, mac_len); /* pushes 0 bytes */
lo egress: tcf_ife_act()
    tcf_ife_is_eth_skb()
        pskb_may_pull(skb, ETH_HLEN)      /* succeeds */
    tcf_ife_encode()->ife_encode()
        iethh = (struct ethhdr *) skb->data;
        __skb_push(skb, total_push);
        memcpy(skb->data, iethh, ETH_HLEN);

At this point skb->data still points at the IP header. The first 14 IP
header bytes are copied as the inner "original" Ethernet header. They also
end up in the outer h_dest/h_source unless eth_dst/eth_src are configured.

The over-read past the linear data is fixed, and these bytes are packet
data the sender controls, not kernel memory. This behaviour for L3 skbs of
14 bytes or more was already there after commit 5b483f7791b0. Still, a
non-Ethernet frame can be encoded on egress as if it had an Ethernet
header, which is what the subject and issue statement say this patch
prevents.

The comment above the function also still reads as a pure check:

    IFE encapsulates the original Ethernet header and, on decode, expects
    to find one, so it can only ever work on skbs that carry one.

It does not say that the egress branch only checks linear length, or that
the call can now pull and so modify the skb.

Should the subject, issue statement and function comment say that egress
only checks linear length? Or should the egress branch also check that the
L2 header really is Ethernet?

[Severity: Low]
The commit message says "A short egress skb is now dropped instead of
being encoded." Is that the only behaviour change?

tcf_ife_act() calls tcf_ife_is_eth_skb() before choosing between encode
and decode. So a short egress skb is now dropped even when tcf_ife_encode()
would never have encoded it.

ife_get_sz() returns 0 when no metadata is present. One example is
ife_check_meta_u32() with no skb->mark and no configured value. In that
case tcf_ife_encode() returned before touching skb->data:

net/sched/act_ife.c:tcf_ife_encode() {
    ...
	if (!metalen) {		/* no metadata to send */
		...
		qstats_cpu_overlimit_inc(ife->common.cpu_qstats);
		return action;
	}
    ...
}

These sub-ETH_HLEN frames used to pass with the configured action and were
counted as overlimits. Now tcf_ife_act() drops them with TC_ACT_SHOT and
counts them as drops.

Could the commit message mention this change in behaviour and statistics?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v3.r0.20261103064310%40mojatatu.com
