Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792871718;
	b=x3C9KFDepty/a2Qq8YVQdej8ZrKlPe2hCwlUehZFSdAgAOrndgLyLf9g3OTmAh9/Lhdy
	 NH32yWwL9P6VoB7a6Mly+YvQWRh6fhX4QdXVhyPRPiENV5Zi9V+EiJCvk7kekItJ5azeK
	 mmrxFbm8rOfbuiTQi6YNwJo6yICXWHxEx8cvUtZrmu7d07nSEqjzZEqnawC1ScZ5smWlp
	 awWrCxJ4tw1f5313NR36NGy/3+vTM9CuGpsTU6N0kgasI7qjvA3rALSj4QkE4AEfuK0lY
	 YPOxAhDC9iB/sHbn+B18ohkfFbV9NaFCoGW8nrCK6IeRIegFBZBN6Ltu63GlW9ydcPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792871718;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VKUjYx4uq7il/yCv58TsN7S0KJRJdGG0UuBrxYVVVKE=;
	b=uFcoahbgQAucK+Z3Qb8A/er9+qMpS/EebxY9SEvWfkpGILToA3S6WnC9mvCOp3DU7keR
	 vK4L2OoAAJvO7CyDYTi2bVgHu13qzmAuvmo8rvtHiXXqZTe1rO5vFHQtg/je+3BqeA1im
	 tFR1nqTn5cgq4C0c0lOAn60Cjk3bIyTi2rimfrQhTjKPel0tOiLV/blx3lSONB7nbdZJX
	 iNeFeF4PyU8o3m4He/N2uXytUZ3tJyxkWH35IIs0OMnShv92CKMtEIUl/c847hQiDjBaf
	 8KSvr8gxBDB6DXPqqGeIDQnlMf0h8VS7JYeWtt1Cz9ROzPeZ5oWIVuLpW4kSzS4ZOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfPKXD62;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B3606A31A;
	Sat, 24 Oct 2026 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfPKXD62
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCEE1F01825;
	Sat, 24 Oct 2026 19:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792871717;
	bh=VKUjYx4uq7il/yCv58TsN7S0KJRJdGG0UuBrxYVVVKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZfPKXD62235Ts2XIMUZw6bWNCKVXbZ2Ro0JH8BYhrufO4SvA0axEAjSQNag2ObNkv
	 63HmkPwbQ6JNORbksEXl4yPGnMiK7MgSwWY/aAv2hqbrJIUn6b4YEGvIHPwNO/ZCoq
	 mzJw9OrPCRfzMdtymKiekT3S1pr/dVJ7b0t1gCHvY0sGYyLwq9td0ZMZbuAx0tXpUc
	 BLH+S1sQnSH4+FkKzN0ycTDvQR112IVYH9CT0vXyoVfvzKeQpvxK6NKIBpNDkj7Vhr
	 dDTfhlJyYPF1v4VcrdzHmICMWwTTA3DZf8EH3mGMRZ201myw1PQm24/TyXHjPRKxAV
	 +4WW8wAN+Ph/Q==
Subject:
 Re: [PATCH net v2 2/2] selftests: net: add TLS 1.2 hardware offload tests
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, aviadye@mellanox.com, ilyal@mellanox.com,
 borisp@mellanox.com, linux-kernel@vger.kernel.org
Date: Sat, 24 Oct 2026 19:55:16 +0000
Message-ID: <179287171668.3134.17927231522917764342@kernel.org>
In-Reply-To: <20261020181147.939575-2-rjethwani@purestorage.com>
References: <20261020181147.939575-2-rjethwani@purestorage.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] test_tls_offload() in
  tools/testing/selftests/drivers/net/hw/tls_hw_offload.py skips the…
- [Medium] main() in tls_hw_offload.py raises KsftSkipEx outside
  ksft_run().
- [Low] The comment on HW_NIC_COUNTERS says '*_packets increment once per
  packet the NIC actually encrypted or decrypted ... so they prove the…

--

selftests: net: add TLS 1.2 hardware offload tests

This adds a two-node kTLS hardware offload selftest. A C helper installs
fixed AES-GCM keys on both endpoints, and a Python harness runs echo
traffic over IPv4/IPv6 with different payload sizes, checking the TLS MIB
and NIC ethtool counters to confirm HW offload in each enabled DUT
direction. It also adds handshake and alert record-type regression cases
for the push_pending_record fix.

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 0000000000000..37f26e21a7b78
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> @@ -0,0 +1,402 @@

[ ... ]

> +# TlsTxDevice/TlsRxDevice in /proc/net/tls_stat only prove tls_dev_add()
> +# accepted the offload:
> +#  - *_packets increment once per packet the NIC actually encrypted or
> +#    decrypted (mlx5 counts gso_segs, not records), so they prove the HW
> +#    crypto path was exercised.

[Severity: Low]
Is this description accurate for the TX side? Documentation/networking/
tls-offload.rst defines the counter as:

  tx_tls_encrypted_packets - number of TX packets passed to the device
  for encryption of their TLS payload.

mlx5 increments it in the driver xmit path while it builds the
descriptor. It does not wait for a hardware completion:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c:mlx5e_ktls_handle_tx_skb() {
    ...
    stats->tls_encrypted_packets += skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
    ...
}

So the ksft_ge() on tx_tls_encrypted_packets in check_hw_crypto() shows
that the driver handed TLS packets to the offload path. It does not show
that the NIC encrypted them. A broken HW encrypt would most likely still
be caught by the peer's TlsDecryptError check or the echo memcmp(). The
gap is only in what this comment and the "NIC reported no HW crypto"
message claim.

Could the comment be reworded to match the documented semantics?

> +#  - *_ctx increment once per tls_dev_add().
> +# Missing NIC crypto counters remain optional.

[ ... ]

> +# Drivers whose tls_dev_add() accepts only AES-GCM-128: nfp
> +# (nfp_net_cipher_supported()), cxgb4 (chcr_ktls), funeth.
> +GCM128_ONLY_DRIVERS = {"nfp", "nfp_netvf", "cxgb4", "funeth"}

[ ... ]

> +def test_tls_offload(cfg, cipher, tls_version, ipver):
> +    """Cipher/version matrix over the HW offload data path."""
> +    # The tls-hw-{tx,rx}-offload feature bits do not advertise cipher
> +    # support, and there is no uAPI to query it. Skip AES-GCM-256 on drivers
> +    # whose tls_dev_add() accepts only AES-GCM-128; keep the HW assertions
> +    # for every other driver/cipher pair.
> +    if tls_version == "1.2" and cipher == "256":
> +        info = cmd(f"ethtool -i {cfg.ifname}", fail=False).stdout
> +        for line in info.splitlines():
> +            name, _, value = line.partition(':')
> +            driver = value.strip()
> +            if name.strip() == 'driver' and driver in GCM128_ONLY_DRIVERS:
> +                raise KsftSkipEx(f"{driver} TLS offload supports only AES-GCM-128")
> +
> +    run_tls_test(cfg, cipher=cipher, tls_version=tls_version, ipver=ipver)

[Severity: Medium]
Can the tls12_aes256 variant report a false failure on mlx5 devices that
lack the AES-GCM-256 capability?

On mlx5, AES-GCM-256 support is a per-device capability bit, not a
property of the driver. mlx5e_is_ktls_device() turns on the tls-hw
offload features when the device reports either tls_1_2_aes_gcm_128 or
tls_1_2_aes_gcm_256. mlx5e_ktls_add() then rejects any cipher the device
lacks:

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h:mlx5e_ktls_type_check() {
    ...
    case TLS_CIPHER_AES_GCM_256:
        if (crypto_info->version == TLS_1_2_VERSION)
            return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
    ...
}

drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c:mlx5e_ktls_add() {
    ...
    if (!mlx5e_ktls_type_check(mdev, crypto_info))
        return -EOPNOTSUPP;
    ...
}

When that happens, do_tls_setsockopt_conf() in net/tls/tls_main.c falls
back to tls_set_sw_offload() and bumps TlsTxSw/TlsRxSw. setsockopt()
still succeeds, so the C helper sees no error.

mlx5_core is not in GCM128_ONLY_DRIVERS, so check_path() with
require_hw=True then fails with "HW offload not engaged", even though the
device is behaving as designed.

Would it be more robust to detect this cipher-specific SW fallback
(Device delta of 0, Sw delta of at least 1, no TlsDecryptError) and raise
KsftSkipEx, rather than relying on a list of driver names?

[ ... ]

> +def main() -> None:
> +    """Set up the DUT/peer environment and run the offload test suites."""
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.bin_local = cfg.test_dir / "tls_hw_offload"
> +        if not cfg.bin_local.exists():
> +            raise KsftSkipEx(f"tls_hw_offload binary not found at {cfg.bin_local}")
> +        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
> +        check_tls_support(cfg)
> +        cfg.cleanup_failed = False
> +
> +        ksft_run([test_tls_offload, test_tls_offload_sizes,
> +                  test_tls_offload_record_type], args=(cfg, ))
> +    ksft_exit()

[Severity: Medium]
Does raising KsftSkipEx here, outside ksft_run(), turn the expected skip
cases into failures?

The missing-binary check raises directly. check_tls_support() also
raises KsftSkipEx when /proc/net/tls_stat is missing on either host, when
ethtool -k fails, or when the DUT has neither tls-hw-tx-offload nor
tls-hw-rx-offload enabled.

KsftSkipEx only becomes a SKIP result inside the per-case loop of
ksft_run():

tools/testing/selftests/net/lib/py/ksft.py:ksft_run() {
    ...
        except KsftSkipEx as e:
            comment = "SKIP " + str(e)
            cnt_key = 'skip'
    ...
}

NetDrvEnvBase.__exit__() only calls self.__del__() and returns None, so
the exception reaches the interpreter. The result is a traceback, exit
status 1 and no KTAP output, and ksft_exit() is never reached.

Most NICs have no kTLS HW offload, and on all of them the kselftest
runner would record this test as FAIL instead of SKIP.

Could these checks move into the test cases? Alternatively, main() could
catch KsftSkipEx and exit with KSFT_SKIP (4).

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020181147.939575-1-rjethwani%40purestorage.com
