Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792939617;
	b=HA1HoFk0YM4ZKe3YZTmA9zyxe4+tFP5hhOhp0gGHCcar/BF7QLd6ABtecQQL0hTedum/
	 fCYV4+XEzfa9kAHXi3Di/mogtCs2kuRE6IgewrDsr1RM38MRDCGqHLB+xhUJLQMRvSAIB
	 7VgnT1rzdNuAr3mBJxDiDhLTj/ChcG35hc7vm1MzGxK7i47Rnh7OLUIvH40BR7ONxc1i/
	 UgFXRdpiZ/x42rff5406Lqtg+/PJOrT6UB2unqWPIacmMB7/z0va/HPQpPZWotdteOD/h
	 TQdGtSu9KlbHDr2b+VJW2OOqyMEvJi7OFfVK+Qus07GIA7WI5SeZ2ra+Hxyorqiqgaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792939617;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=I23DkGVOflePUgIeC7zqOu6ppEEHHOzNPKpwzOeKZew=;
	b=2W5pCcaPIZuUN+ys2XpvOO90/CEfGHFMDxgITetsyNRBVULNtBo4pLcmHpaJs6NDeTC+
	 ZMn4cYYpo50QRGFmf2T+T5h5Zzv6dacY7VbY478fUjSBi13h2gJC9jczONyY9DKucURqZ
	 aHGVXKGAReeahWyHUJLIvhh2O1Kz0rhRkPIdkNzNxSkzTLYX0sfjMgUAvivGnqyyqjCkK
	 j+3AJzFg91lLKvNoTwxZAPR4ZS7jM07Pmo7dEx9xgEWscfs/UWgoXVEuK5iS7FZDFg6Uf
	 5DUWb+XW3fWSgRr2NVTQfww6K50XbiqsA0Iao45SbXyObqrvUAf0Hnog7Lk3IpCHOHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKsaozXl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B779606A31A;
	Sun, 25 Oct 2026 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKsaozXl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608941F01825;
	Sun, 25 Oct 2026 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792939617;
	bh=I23DkGVOflePUgIeC7zqOu6ppEEHHOzNPKpwzOeKZew=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EKsaozXleQIh2PE5Z9wXQdvFzj+z1B0jpk7JX35Jzs5v83cjCu6C1tXfuRu/Z/xH+
	 Z0B9+ORW2RSyJPaN8KOLhDc3rYwGQoZcD48OwG2IV4fu4ruNsvGKYE1iWTqo4S5Wt5
	 8yiwq06HsC+3YWHXOTa/GG/moznmzg/DIQeSNEVQopu3HZpMBrWd/dqoJWGYwJwk7U
	 36C1BCgbGnAxFv5CUmm9ssLQu820QOWiODgaMoQv1za+LgdeYEgjQTnAhKeokKIGRk
	 9xkJBptBTEYeprbpFxYS7+cWgMXF8k+zd1ECQPJTEtkJZo2FtDYv5YAxQYvXamUPJW
	 KP/ovgmMZV1Uw==
Subject: Re: [PATCH net v2 2/2] selftests/bpf: cover AF_XDP multi-buffer TX
 software checksum
From: netdev-bot+sashiko@kernel.org
To: testwrzwrz@gmail.com
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 kerneljasonxing@gmail.com, sdf@fomichev.me, hawk@kernel.org,
 stable@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sun, 25 Oct 2026 14:46:55 +0000
Message-ID: <179293961591.3134.5478895656850588086@kernel.org>
In-Reply-To: <20261024141157.59301-3-testwrzwrz@gmail.com>
References: <20261024141157.59301-3-testwrzwrz@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] generate_packet() in
  tools/testing/selftests/bpf/prog_tests/xdp_metadata.c fills the…

Pre-existing issues:
- [Medium] The freplace check in test_xdp_metadata() never retries.

--

selftests/bpf: cover AF_XDP multi-buffer TX software checksum

This commit extends test_xdp_metadata to send a UDP packet once as a
single TX descriptor and once split across two descriptors with
XDP_PKT_CONTD. The existing metadata and checksum checks run for both.
It adds a bind_flags argument to open_xsk(), a split_len argument to
generate_packet() and a num argument to complete_tx().

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 5c31054ad4a4c..1cf70fb800fba 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c

[ ... ]

> @@ -133,36 +135,36 @@ static void close_xsk(struct xsk *xsk)

[ ... ]

> -	eth = data;
> +	memset(pkt, 0, sizeof(pkt));
> +	eth = (void *)pkt;
>  	iph = (void *)(eth + 1);
>  	udph = (void *)(iph + 1);
>  
> -	memcpy(eth->h_dest, "\x00\x00\x00\x00\x00\x02", ETH_ALEN);
> -	memcpy(eth->h_source, "\x00\x00\x00\x00\x00\x01", ETH_ALEN);
> +	memcpy(eth->h_dest, RX_MAC, ETH_ALEN);
> +	memcpy(eth->h_source, TX_MAC, ETH_ALEN);

[Severity: Medium]
Should RX_MAC and TX_MAC be copied here? In this file they are text
strings meant for the ip link commands:

#define TX_MAC "00:00:00:00:00:01"
#define RX_MAC "00:00:00:00:00:02"

With ETH_ALEN as the length, memcpy() copies the first six ASCII
characters, "00:00:". Both h_dest and h_source then become
30:30:3a:30:30:3a.

The old binary literals matched the addresses set on veTX and veRX. Now
every AF_XDP frame that generate_packet() builds has a destination MAC
that doesn't match veRX. That covers the single-descriptor packet, the
new multi-buffer packet and the freplace packet. Won't eth_type_trans()
on the receive side mark these frames PACKET_OTHERHOST?

The test still passes because rx() in progs/xdp_metadata.c only filters
on the UDP destination port:

	if (udp->dest != bpf_htons(8080))
		return XDP_PASS;

Was this change meant to be part of a patch that only adds the
multi-buffer case? Keeping the "\x00\x00\x00\x00\x00\x02" and
"\x00\x00\x00\x00\x00\x01" literals would avoid the problem.

>  	eth->h_proto = htons(ETH_P_IP);

[ ... ]

> @@ -518,7 +564,7 @@ void test_xdp_metadata(void)
>  		goto out;
>  
>  	/* Send packet to trigger . */
> -	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT), 0,
> +	if (!ASSERT_GE(generate_packet(&tx_xsk, AF_XDP_CONSUMER_PORT, 0), 0,
>  		       "generate freplace packet"))
>  		goto out;

[Severity: Medium]
This isn't a bug introduced by this patch, but the polling loop after
this send in test_xdp_metadata() never seems to run:

	int retries = 10;
	...
	while (!retries--) {
		if (bpf_obj2->bss->called)
			break;
		usleep(10);
	}
	ASSERT_GT(bpf_obj2->bss->called, 0, "not called");

On the first check retries is 10, so !retries-- is false and the loop
body is skipped. The assertion then runs right after sendto() and the
netns switch.

freplace_rx() increments called from the veth NAPI receive path, which
runs in NET_RX softirq. If that softirq is deferred to ksoftirqd, can
this assertion fail without a single retry?

Should the condition be retries-- > 0 instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261024141157.59301-1-testwrzwrz%40gmail.com
