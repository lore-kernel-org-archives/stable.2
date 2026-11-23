Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466372;
	b=aRKiI/OTnQo7ug1IYc2ZVLdrCNJPKwlkeSY2Qes0zrxBSrIyY6p6k2fmKTZrskIS/0bb
	 drQRV5tNS/rXkJ+/8HqoLg7Wt/5pmZweZ65oMtnxf3kINcwgcgj8fF+pFkcx1CO7rgoVp
	 QY2Qk7X3ZwRcXOYf2L75+0pHA2IGYWTISiTI/Ve5qWHa5Nz/Wd+iwIcOPYVAepZc01Zl3
	 9BAs3noM0uxDRHG8GEmsTai6RPvjBZZUjFqJ1mWzZF37MXvFrlmBvF0NYZ7T9jI0PpKUr
	 2yNW0zTwJYpxCX0gmg+QKq+Rf+DLpkMGS4x1aAaZcXaJkVonYr2l3fA06lF4/Gjsh3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466372;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DK0uBeCOhfalff4B9V7doNlqC8iX//OaC2p5/50PXGI=;
	b=WXXZCdZqPKk1ARRHCRpOOTstKIEijcCCcAm7ev2K6X8fgqo2POKbFEp4BGiT3AjJyajw
	 3sQS1wLRgtNi1vlIfR9pIR9ipnDLMstc5G5PGGQGBHtMKLI6mm6emOCRKfeCVOO8dtbB8
	 Qg9BNXFmKc/0hIk/Ams3I4azyQXbNcCevWz/JBX3ZmwLDUpDU/ncmwWa9WTib1VNfJ1S0
	 SUKN5CSMXFNq4nIihJE6qD6aBsJUFlvVCj20V3lCbX9l7H4ye+k7lT6AzTgGGQCrvxYB/
	 qUvp3Lr2S4S99XAnk2hB7m28jh3xmuCuefOipHMaokmqVQK4O1mNSd/m7+TcXQDWUDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c62Ag414;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7B606A333;
	Mon, 23 Nov 2026 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c62Ag414
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C776C1F000CF;
	Mon, 23 Nov 2026 20:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795466371;
	bh=DK0uBeCOhfalff4B9V7doNlqC8iX//OaC2p5/50PXGI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c62Ag414NS+X/+ciEiY51qD/zNbX6q6j0wFhAtiS3jf1iHMSaZvdHUnZtS68b0y1m
	 onLKZgyneB6BhOr0mkk6np/KmN+gxv2mRIC+BD8ACwhAQKhHv0Zpax1/d6FS7g/9si
	 MQM3ve/zTUyGCfTZSD2fro7TsWWu+tREF/adob2kpRieZr/+1Nm9xofkeZv6j74WeC
	 TktvUuUHXACOezOKuVR6xFrOilS6S2PD8NO0eBO7cE+qSYKFTn5aSHFKj1ZxQquMKb
	 MXcBOC7Z5jgTK1S1cJVPDk6XQKa0ACskE8YnAtHRrQduzel/oXBEXc0DzKTrWx5M31
	 E5BEnYELRJ6GA==
Subject:
 Re: [PATCH net v2 3/3] selftests: net: add TLS offload over bond tests
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tariqt@nvidia.com,
 alice.kernel@fastmail.im
Date: Mon, 23 Nov 2026 20:39:30 +0000
Message-ID: <179546637039.3135.9772671834943336374@kernel.org>
In-Reply-To: <20261119191341.4089157-3-rjethwani@purestorage.com>
References: <20261119191341.4089157-3-rjethwani@purestorage.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/drivers/net/hw/tls_hw_offload.py,
  bounce_idle() (lines 458-462) runs `ip link set dev <slave> down`,…
- [Medium] test_tls_offload_bond_bounce takes the slave NIC
  administratively down and up (bounce_idle()/bounce_inflight() at…
- [Low] The -T help line in print_usage()
  (tools/testing/selftests/drivers/net/hw/tls_hw_offload.c:769) reads…
- [Low] selftests: net: setup_bond() runs before IPv4 check in bond
  offload tests

--

selftests: net: add TLS offload over bond tests

This adds kTLS HW offload tests that run the echo test over a single-slave
balance-xor bond. It also adds tests that bounce the slave under an open
offloaded socket, in idle and inflight variants. The C helper gains -P to
pause the client halfway and -T to widen its I/O timeouts and SIGALRM
lifetime.

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> index 5b3887f32b689..0be321866a978 100644
> --- a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c

[ ... ]

> @@ -751,6 +765,9 @@ static void print_usage(const char *prog)
>  	printf("  -c <cipher>   Cipher: 128 or 256 (default: 128)\n");
>  	printf("  -n <N>        Send/echo iterations (default: 100)\n");
>  	printf("  -t <type>     Record type test: 21=alert, 22=handshake\n");
> +	printf("  -P            Pause halfway (client): ksft_ready(), ksft_wait()\n");
> +	printf("  -T <sec>      Send/recv timeout and lifetime bound (default: %d)\n",
> +	       IO_TIMEOUT_S);

[Severity: Low]
This isn't a bug, but does this help text match what -T does?

Without -T, the SIGALRM lifetime is HELPER_TIMEOUT_S (15), not 8. With
-T N, main() sets:

	helper_timeout_s = 2 * io_timeout_s + 15;

and passes that to alarm(). So <sec> sets the send/recv timeout, and the
lifetime bound is derived from it rather than equal to it.

[ ... ]

> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> index e720ce6547610..345d5fd9a5e95 100755
> --- a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

[ ... ]

> @@ -305,6 +358,145 @@ def test_tls_offload_record_type(cfg, record_type):

[ ... ]

> +    ip(f"link add {BOND_IFNAME} address {mac} mtu {mtu} type bond "
> +       "mode balance-xor xmit_hash_policy layer3+4 miimon 100")

[ ... ]

> +    wait_carrier(cfg.ifname)
> +    wait_carrier(BOND_IFNAME)
> +
> +    for peer in filter(None, cfg.remote_addr_v.values()):
> +        wait_reachable(BOND_IFNAME, peer)

[ ... ]

> +def bounce_idle(cfg):
> +    """Bounce the slave while the socket is idle, then resume the echo."""
> +    ip(f"link set dev {cfg.ifname} down")
> +    ip(f"link set dev {cfg.ifname} up")
> +    wait_carrier(BOND_IFNAME)

[Severity: Medium]
Can wait_carrier(BOND_IFNAME) return here before the slave is actually
back?

For a slave going down or up, bond_slave_netdev_event() only refreshes the
slave array. It does not change the master's carrier:

drivers/net/bonding/bond_main.c:bond_slave_netdev_event() {
    ...
	case NETDEV_DOWN:
		...
		if (bond_mode_can_use_xmit_hash(bond))
			bond_update_slave_arr(bond, NULL);
		break;
    ...
}

For a running balance-xor bond, bond_set_carrier() is only reached through
bond_mii_monitor()->bond_miimon_commit(). That runs every 100ms here
(miimon 100), and it is deferred again whenever rtnl_trylock() fails while
the ip commands hold RTNL.

So /sys/class/net/tlsbond0/carrier can still read the 1 from before the
bounce. In that case the wait returns at once, while the NIC is still
retraining.

The resumed records would then reach a slave with no carrier and go out
on retransmit. That is the inflight scenario, so the idle variant may not
reliably cover the "slave back before the client resumes" case.

setup_bond() waits on wait_carrier(cfg.ifname), then on the bond carrier,
then on wait_reachable() for each peer. Should bounce_idle() use the same
sequence?

[ ... ]

> +@ksft_variants([
> +    KsftNamedVariant("idle", bounce_idle),
> +    KsftNamedVariant("inflight", bounce_inflight),
> +])
> +@ksft_disruptive
> +def test_tls_offload_bond_bounce(cfg, bounce):

[ ... ]

> +    require_tls_setup(cfg)
> +    setup_bond(cfg)
> +    run_tls_test(cfg, pause=bounce)

[Severity: Low]
Does setup_bond() run too early for an IPv6-only environment?

run_tls_test() is called here with the default ipver="4", and it only
checks cfg.require_ipver(ipver) after setup_bond() has returned.

On a NetDrvEpEnv with only IPv6 addresses, setup_bond() still does all
of its work first. It moves the global addresses to tlsbond0, takes
cfg.ifname down, enslaves it, and waits for carrier and for ping
reachability of the IPv6 peer.

Only then does run_tls_test() raise KsftSkipEx. The deferred cleanup
then deletes the bond, and restore_nic() brings the NIC up again,
which flaps the link a second time.

test_tls_offload_bond_bounce() has the same ordering. So each of the
four bond variants retrains the NIC twice only to report a skip.

Would it make sense to call cfg.require_ipver("4") before setup_bond()
in both tests? Alternatively, setup_bond() could take the ipver the
case is going to run with.

[Severity: Medium]
Could the NIC packet count check fail in both bounce variants on drivers
that keep their TLS stats in per-queue state?

The slave is taken down and up between the nic_before and nic_after
snapshots in run_tls_test(), which runs the driver's ndo_stop/ndo_open.
check_hw_crypto() then requires:

            got = stat_diff(nic_before, nic_after, key)
            ksft_ge(got, 1,
                    comment=f"DUT {direction}: NIC reported no TLS "
                            f"offload packets ({key}={got})")

On funeth, which the HW_NIC_COUNTERS comment lists, fun_get_ethtool_stats()
builds tx_tls_encrypted_packets by summing the live fp->txqs[i]->stats.

funeth_close()->fun_down() with FUN_QSTATE_DESTROYED frees the TX queues in
fun_free_rings(). funeth_open() then allocates new zeroed queues through
kzalloc_node() in fun_txq_create_sw(). The counter therefore restarts at 0
after the bounce.

NETDEV_DOWN also moves the socket to the TX SW fallback through
tls_device_down(), so nothing goes through the HW path after resume.
nic_before is also around 0, because setup_bond() has just recreated the
queues.

As a result, got ends up 0, and the case reports "NIC reported no TLS
offload packets" even with a correct kernel fix.

tx_tls_ctx (fp->tx_tls_add) survives close/open, so only the packet count
check seems to be affected. The bounce cases were only tested on mlx5,
which keeps its counters across close/open.

Should the bounce cases relax or skip the packet count check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119191341.4089157-1-rjethwani%40purestorage.com
