Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741586;
	b=BImmJs6eMLMKpsULwTjclYC7Gm3TmX79zp511DGBfNWJza/9DeKOOwAtcWDOXd70RllZ
	 aAgduDqjsppyX6ARcLMxNNP/P/u17in/fBNXvPtEtNAVwbMThpPZjHXUEzCklRuicu0RQ
	 xZhK9G/fMbQKtq69VAv7b/0B6rcgwjkgMMEivYw5+Ei5BqGKY/vpDs8JFReF0PUhg2IqN
	 aZCC6pHcet3sJ+rXQsn10Qkwl5kQdl3TEdGJv9G7scDyZuk08x1jyGgCUYZavuxe3m6o5
	 guOA1f+cArG15dI8i8xBX9IT0FSRVIYxqwDQw/XbYFzq4ZjDkeV3xMk8C8R33vKluDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741586;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XoFFjFtBSwpGahigQ08X9jppIpgnB5pZ1iH8tznVkuo=;
	b=lEe/a0P86Tfpmi9UowpGiSGfuc+CS6kIDn57tbSha+Q8HqfjzOEx+6sumekqHRrA3pVY
	 7PJ+awHSiveRPqrCeXL6Pwvrth36w7aqdgniL07v5TSqaYH/mBoP06WNpA5zQDUbF98OO
	 yGcwCdD0te+aEueoN4mp6i7vqY77zLLtVx/H9VqwBkNfFdSw4gQ1Gr7vYQPeqF6GdW8WE
	 9yrFY4C1Bils4v8WG9lwXQqh39kVv7Uk2UbxnsU673p2J8OEQKukoidDjDZJkSGm6H0+I
	 Ctc+c8T1jZYt685NZePG+0H+JNru9Zr4yCd3E+AZrjx8//ughl0j/cSm0KJj0YkWoSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a3cy43/P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C427606A324;
	Tue,  3 Nov 2026 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3cy43/P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CAA1F00919;
	Tue,  3 Nov 2026 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741586;
	bh=XoFFjFtBSwpGahigQ08X9jppIpgnB5pZ1iH8tznVkuo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a3cy43/PwfIXlyyg+ZoxSm+jZrxZhG2XJhHnaStHtL5tzLhnQCzlQnUixqpGPxfxN
	 8haD4x8uaibKug+LuB2Y8Sf4pjAWAVlT2BeRADE4NBZlEynnjSb0574ru25hj15m+f
	 WkUhMCl0+0Yoyx9FfC4qp/ekB9sPm+CfYSNd0Pmz85KqaNKlvClrrr8dFSAi9y4c57
	 ABxaL7ZedSalzm7PQWreRVpdo8Ae/nhVkjhaKagKfKk4XsMaapNQKBPSjPBZ8IIlCd
	 nM6ZA/Oxc07G3pUtsPRuWtrsm6rYwZNgMUydmi/y9A/Va/tOWez8TxcAEjTLfWZcjV
	 ZPYcYSzzvCWxw==
Subject:
 Re: [PATCH net v5 2/2] selftests: net: add TLS 1.2 hardware offload tests
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, aviadye@mellanox.com,
 borisp@mellanox.com, ilyal@mellanox.com, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 21:33:05 +0000
Message-ID: <179374158513.488856.17891105693447320515@kernel.org>
In-Reply-To: <20261102213011.4191020-2-rjethwani@purestorage.com>
References: <20261102213011.4191020-2-rjethwani@purestorage.com>
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

- [Medium] On offload NICs that only support AES-GCM-128, the
  tls12_aes256 variant of test_tls_offload reports FAIL when it should…

--

selftests: net: add TLS 1.2 hardware offload tests

This adds a two-node kTLS hardware offload selftest. A C helper installs
fixed AES-GCM keys on both ends, and the peer echoes data back to the DUT.
It checks that HW offload is used in each enabled DUT direction, covers
AES-GCM-128/256, IPv4/IPv6 and several payload sizes, and adds handshake
and alert record-type regression cases for the push_pending_record fix.

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 0000000000000..e720ce6547610
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> @@ -0,0 +1,321 @@

[ ... ]

> +def check_tls_support(cfg):
> +    """Require kTLS on both hosts and at least one DUT HW direction."""

[ ... ]

> +    try:
> +        features = cmd(f"ethtool -k {cfg.ifname}").stdout
> +    except CmdExitFailure as e:
> +        raise KsftSkipEx(f"Cannot determine TLS HW offload support: {e}") from e
> +    cfg.tls_hw_directions = {
> +        direction for direction in ('Tx', 'Rx')
> +        if f'tls-hw-{direction.lower()}-offload: on' in features
> +    }
> +    if not cfg.tls_hw_directions:
> +        raise KsftSkipEx("Device has no enabled TLS HW offload direction")

[Severity: Medium]
On NICs whose offload only supports AES-GCM-128, will the tls12_aes256
variant of test_tls_offload() report FAIL instead of SKIP?

cfg.tls_hw_directions comes from the tls-hw-tx-offload and
tls-hw-rx-offload feature flags. Those flags don't depend on the cipher.
run_tls_test() then requires HW in those directions for every cipher.

Several in-tree drivers that advertise these features reject AES-GCM-256
in tls_dev_add():

drivers/net/ethernet/netronome/nfp/crypto/tls.c:nfp_net_cipher_supported() {
	switch (cipher_type) {
	case TLS_CIPHER_AES_GCM_128:
		...
		break;
	default:
		return false;
	}
	...
}

The other drivers do the same:

- fun_ktls_add() in funeth returns -EOPNOTSUPP for any cipher other
  than AES-GCM-128.
- chcr_ktls_save_keys() returns -EINVAL for non-128 ciphers.
- mlx5 only supports AES-256 when MLX5_CAP_TLS(tls_1_2_aes_gcm_256)
  is set.

When tls_dev_add() fails, do_tls_setsockopt_conf() falls back to SW
without returning an error:

net/tls/tls_main.c:do_tls_setsockopt_conf() {
	...
		rc = tls_set_device_offload(sk);
		conf = TLS_HW;
		if (!rc) {
			...
		} else {
			rc = tls_set_sw_offload(sk, 1,
						update ? crypto_info : NULL);
	...
}

The helper's setsockopt() calls succeed and the echo passes. Only
TlsTxSw/TlsRxSw go up. check_path() then fails with "HW offload not
engaged (Device=0, Sw=1)".

The HW_NIC_COUNTERS comment lists nfp, cxgb4 and funeth, so this would
hit hardware the test means to cover.

Could the AES-256 variant skip, or accept SW, when the DUT driver doesn't
offload that cipher?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102213011.4191020-1-rjethwani%40purestorage.com
