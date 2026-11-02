Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642548;
	b=nk6HOi3Xhxxm1r1ujtxCw8JfgwmTt9DxrZrj5mEm93XXQsVT82ranvy9aIVjZ/f6bWd0
	 oBgPkV/JAdpCbMAtTwEEiYWfaCvgX/HVjJggHbQ5iTJD7TktAxTXRmrLfeoa2bSzzdJuZ
	 roTLQiRqq9E1iWoSVzw9f+Jtz46OpL6rbTfmEQUsGPbqJDhpFYlbTFzHTj39pA4Ia4wnH
	 +y7J3vLVuoazibCUOv9sKUATksLMxdQNnmFbEof80mzmG9St0nbY2kwu1jZwags9VB2Yt
	 qkQ3MJKKY5/B6ott08h3q58O04rA2gP34UQJJFuNLwdrxD4ClTEYWzfU0bid0Acz7Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642548;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Mo9e6zZ7DM0/oaEehTSm0CvIfdfjeAIAz6cCjHE3fzY=;
	b=Gi3GRMq4UX5dZ/Ggat8HN/Hj2TwwpPe93XCvhkM/M45urf2y87+ga+kNjkMPJovYIBAq
	 IrpULRXZToI6VkoMbeZrtaMk4YjjaTNlPt2srWJcSf7ody/w3I+KmKQd2L35w6xcxUeN4
	 cZg78MBjPsi055iwIHxLhVXeYBKuVc4tLVAU8nFFwUvMQGK91MiHMWATc6ebmVbP1k7+b
	 eVpZ3lq8t6cZy3GC7PuEzGA2oxRAtXYx2BBt1+8n9yPsJvsB3kWlNYZndtSsQ1gRzbcfn
	 zYgZyMUgGKeBY3h5IB93fukOUDscTq5WN/LD16QmzV6X//3o/2TnWMo5F1994D7WLzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQCVDwlk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCD606A324;
	Mon,  2 Nov 2026 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQCVDwlk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E41F00A16;
	Mon,  2 Nov 2026 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642547;
	bh=Mo9e6zZ7DM0/oaEehTSm0CvIfdfjeAIAz6cCjHE3fzY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bQCVDwlk9TKmXmdDLqAtHKQyLbbnjuD4fRKkqkROq9eHHK4+xGX25nw2EkZqiZ/ii
	 OmVdRGpNCeHDtTruH79ewwnzF/3ZYYU6Oei7XXhUY4eRO6tWwLPiohQGhjDT5d5OVU
	 KZC8WaEYhjB0O+OD96hauUxIxdF82EQJ9qhDXQWW2tlsXIeI55XHZ4nqsYsHFx3oNm
	 Qp8lziR+uP/HIMH+PBxDIIzZkDUW53CmCLET8PjrhYyZVG3s1oPkqbDxPP9VqaOkiw
	 DRDkZ4f9gTFhj6T/dqV7gxv/4UJ8QuoIA4XNodV0t7J4AXUWx/ZtETwcLTnkjMigYp
	 TJJrEhDHoTskQ==
Subject:
 Re: [PATCH net v4 2/2] selftests: net: add TLS 1.2 hardware offload tests
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ilyal@mellanox.com, borisp@mellanox.com,
 aviadye@mellanox.com, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 18:02:26 +0000
Message-ID: <179364254636.3131.4069372250703759332@kernel.org>
In-Reply-To: <20261029172302.2944955-2-rjethwani@purestorage.com>
References: <20261029172302.2944955-2-rjethwani@purestorage.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The tls12_aes256 variant of test_tls_offload
  (tls_hw_offload.py:280) requires HW offload in every DUT direction…
- [Low] Two comments say both helpers' stdout pipes are only drained
  after the helper exits: run_tls_test() in tls_hw_offload.py ("Both…
- [Low] When 'Rx' is in tls_hw_directions, check_hw_crypto() asserts that
  rx_tls_decrypted_packets grew by at least 1, but nothing makes the…

--

selftests: net: add TLS 1.2 hardware offload tests

This adds a two-node kTLS hardware offload selftest. A C helper installs
fixed AES-GCM keys on both ends; the DUT runs the client and the peer
echoes the data back. The test checks the TLS MIB counters and the NIC's
ethtool -S TLS counters to confirm HW offload was used in each enabled
DUT direction, and it adds handshake and alert record-type regression
cases.

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 0000000000000..78fa764a6ef3f
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> @@ -0,0 +1,321 @@

[ ... ]

> +def check_hw_crypto(cfg, nic_before, nic_after, hw_directions):
> +    """Check DUT NIC offload-path packet counts and initial key installs."""
> +    for direction in hw_directions:
> +        names = HW_NIC_COUNTERS[direction]
> +
> +        key = names['crypto']
> +        if key in nic_after:
> +            got = stat_diff(nic_before, nic_after, key)
> +            ksft_ge(got, 1,
> +                    comment=f"DUT {direction}: NIC reported no TLS "
> +                            f"offload packets ({key}={got})")

[Severity: Low]
When Rx is in hw_directions, can rx_tls_decrypted_packets stay at 0 after
a short run, even with working hardware?

Nothing waits for the device RX context to become active before the
peer's echoes arrive. On mlx5, mlx5e_ktls_add_rx() bumps rx_tls_ctx
synchronously and returns after post_rx_param_wqes(). The steering rule
that sends the flow to the TLS TIR is installed later, from a workqueue:

mlx5e_ktls_handle_ctx_completion()
  queue_work(rule->priv->tls->rx_wq, &rule->work)
    accel_rule_handle_work()
      mlx5e_accel_fs_add_sk()

Until that rule is in place, records are decrypted in SW. TlsRxDevice
still grows, but mlx5e_ktls_handle_rx_skb() only bumps the counter on
the HW-decrypted path:

	case CQE_TLS_OFFLOAD_DECRYPTED:
		skb->decrypted = 1;
		stats->tls_decrypted_packets++;

If the rule lands mid-stream, a resync is also needed before HW
decryption starts.

client_connect_tls() starts sending as soon as TLS_RX is installed, and
cfg.wait_hw_stats_settle() only runs after the traffic has finished.
Could the small_buf variant (100 round trips of 512 bytes) finish
entirely inside that window and report a false failure?

This depends on firmware command and workqueue latency, and the commit
message reports passing runs on ConnectX-6 Dx, so it may only show up as
an occasional flake.

[ ... ]

> +    # Both helpers run with their stdout captured in a pipe that is only
> +    # drained once they exit, so the helper keeps its per-connection output
> +    # small (see the note on verbose in tls_hw_offload.c); do not pass -V.

[Severity: Low]
Is this comment accurate for the local client?

Only the remote server is started with bkg(), so its ssh pipe is not
read until bkg.__exit__() calls process().

The client runs in the foreground via cmd(client_cmd). In the non-background
case cmd.__init__() calls self.process() right away. _process_terminate()
then uses self.proc.communicate(timeout=timeout), which drains stdout and
stderr while it waits for the child to exit.

The comment on verbose in tls_hw_offload.c makes the same claim:

  /* Per-iteration progress output (-V). Off by default: the
   * harness captures stdout in a pipe that is not drained until the helper
   * exits, ...

The -V restriction still makes sense for the server. Should both comments
say that only the background server's pipe goes undrained?

> +    #
> +    # Both helpers exit on their own within HELPER_TIMEOUT_S (see
> +    # tls_hw_offload.c), so nothing outlives the variant even on failure.
> +    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
> +        wait_port_listen(port, host=cfg.remote)
> +        cmd(client_cmd)

[ ... ]

> +@ksft_variants([
> +    KsftNamedVariant("tls12_aes128", "128", "1.2", "4"),
> +    KsftNamedVariant("tls12_aes256", "256", "1.2", "4"),

[Severity: Medium]
Can the tls12_aes256 variant fail on hardware and a kernel that are both
working correctly?

check_tls_support() only looks for "tls-hw-tx-offload: on" and
"tls-hw-rx-offload: on" in ethtool -k. Those flags don't say which
ciphers the device accepts, and several in-tree drivers only handle
AES-GCM-128:

  nfp: nfp_net_cipher_supported() returns false for anything except
  TLS_CIPHER_AES_GCM_128, so nfp_net_tls_add() returns -EOPNOTSUPP

  chcr: chcr_ktls_save_keys() only handles TLS_CIPHER_AES_GCM_128

  funeth: fun_ktls_add() returns -EOPNOTSUPP for anything except 128

  mlx5: mlx5e_ktls_type_check() checks a separate firmware capability
  for 256:

	case TLS_CIPHER_AES_GCM_256:
		if (crypto_info->version == TLS_1_2_VERSION)
			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);

When the driver declines, do_tls_setsockopt_conf() falls back to SW
without reporting an error:

net/tls/tls_main.c:do_tls_setsockopt_conf() {
    ...
		rc = tls_set_device_offload(sk);
		conf = TLS_HW;
		if (!rc) {
			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
		} else {
			rc = tls_set_sw_offload(sk, 1,
						update ? crypto_info : NULL);
    ...
				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
    ...
}

check_path() then requires ksft_ge(dev, 1) for that direction and fails
with "DUT Tx: HW offload not engaged (Device=0, Sw=1)".

Would it make sense to skip this variant when the DUT falls back to SW
for this cipher, rather than reporting a failure?

> +    KsftNamedVariant("tls12_aes128_ip6", "128", "1.2", "6"),
> +])
> +def test_tls_offload(cfg, cipher, tls_version, ipver):

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029172302.2944955-1-rjethwani%40purestorage.com
