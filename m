Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175717;
	b=qonv2xZ0csrnhr7C/uvd4GzxKA+WK/h+6J/N/Qxzb+Lu0PVCmUjuGmO8THFiAg////JG
	 yQSM/WrE1xD+l3ItE/VhfLxXN11nZu0D/T/2ZbKG/f3jivQYG0tyYfr9PaXlzuPsfGNgT
	 zfppCQcf4dyGp8n/5JvevsXup9xmTMpSdenS58V0zjRoNQ2S7wSopDdXKtcme4b81+jTF
	 wD2qvCImPXXpxgWICMYkvlf6jknm/oIkNf6DtzdqFVUu+5n5ZFXZ3zLac0upAo2bboz1y
	 wMbaDI+5N68PALy1fmBPw9OfdZeG4OYEQT8OiI/AlbSh1DagJVMWoqg7hMAkKZl8DhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175717;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GPBOnH/igQQ1Y7Jgrlbm4Ff98jEBOiO/VijMzt7smks=;
	b=cg3bJH1XMQK7KmNdh69UYHWmtt4TqllQchcOZdfUqe+R7DgfkLS8V2B/GMt5o0Jh/Ekb
	 V+9r8RzHg4+YQjbR1rnF3jrqYRlAozW9FuSv+5LirS/gwr2GMYQPVSGeLNvwplA2qLHpk
	 ep3x0hU58w4+WW43DzJ3nKFOz6PujdedE3wRN5KTASs2gckPV9e0dPGf1SyLezOsq8h5T
	 YOTYK2sHCL6AIUZUEh9apdTwUGEXSHL45ZoixrI7RmMugo2/b/E/F5MmCBM6hUaCej5Ub
	 MXNGnidP/SJOYrymACX/++rfYanro1qlxo/cwWx3E56AwQZ3wjORPX1+4siU1WnOw1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDMrfDHf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A55606A339;
	Sun,  8 Nov 2026 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDMrfDHf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193161F008AB;
	Sun,  8 Nov 2026 22:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794175711;
	bh=GPBOnH/igQQ1Y7Jgrlbm4Ff98jEBOiO/VijMzt7smks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cDMrfDHfbts2phpYASsd4ddmmm0OU4/l+LCcjj7L9r6ZVQmLVxmibfkbWfBF5ZYvP
	 k9W2VmgxAkwQNsfPSp90RXArcHh5Z/g3N1NBULkn9wWx5Gu6hTJHY13SNLNRDOgrck
	 nfwLtGNGvwHwPx71aUs7MnhYLdwAF/axXL5CacngFwG4nlL/+Z2eCLSUzE8tXDPOkL
	 Wya6RFV6Y4z04gyjynlr0Qs33ZolV6m6O9wC4jzMwqQbvC1DfQrzuafvU7dMqk/eNB
	 pt1DlawKNztyNdQ1oEoCs+WsG3lMvwyWwwsfHjKO9jjowbZnV3N13JyqcGmczj2AXl
	 vlOabCZgMndow==
Subject: Re: [PATCH net v8 4/4] selftests: net: hsr: verify GRO policy and
 ordered forwarding
From: netdev-bot+sashiko@kernel.org
To: xiexinet@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
Date: Sun, 08 Nov 2026 22:08:29 +0000
Message-ID: <179417570965.994134.712913867770028727@kernel.org>
In-Reply-To: <20261107220544.20-5-xiexinet@gmail.com>
References: <20261107220544.20-5-xiexinet@gmail.com>
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

- [Medium] topo() in
  tools/testing/selftests/net/hsr/hsr_gro_superpacket.py treats a…
- [Low] ordered_wrap() in
  tools/testing/selftests/net/hsr/hsr_gro_superpacket.py checks the…

--

selftests: net: hsr: verify GRO policy and ordered forwarding

This commit adds two HSR/PRP selftests. Each is a shell entry point that
execs a shared Python helper. hsr_gro_superpacket.sh covers the GRO policy
on member ports, refusal of forwarding port types, and TCP over the
interlink and PRP LANs. hsr_ordered_forwarding.sh covers the ordering of
local and interlink data, supervision frames, concurrent producers and the
sequence number wrap.

> diff --git a/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
> new file mode 100755
> index 0000000000000..23feb0ce4df4c
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
> @@ -0,0 +1,1376 @@

[ ... ]

> +def ordered_wrap(lab):
> +    """The interlink sequence number wraps with both lanes intact."""
> +    topology = topo(lab)
> +    caps = ordered_lanes(lab, topology)
> +    sender = ordered_socket(lab, topology["tx"], "100.64.2.1")
> +    probe = ordered_send(lab, sender, 4, 0, 1, 5130)
> +    # This only selects the warmup count; final loss-free captures certify it.
> +    rows = [udp_rows(cap, {5130}) for cap in caps]
> +    require(all(len(lane) == 1 for lane in rows) and
> +            rows[0][0]["seq"] == rows[1][0]["seq"], "wrap probe missing or unequal")

[Severity: Low]

Could this check run before the probe has reached the da/db captures?
The only wait between sending the probe and reading the captures is the
fixed drain at the end of ordered_send(), and it has no completion
condition:

    ordered_send() {
        ...
        lab.observe(0.1)
        return expected
    }

The probe goes from t0 over the veth to dil, through the HSR rx_handler in
NET_RX softirq, and then out on da/db. That softirq usually runs
synchronously inside sendto(). If net_rx_action() runs out of budget, the
remaining work is handed to ksoftirqd.

On a loaded CI VM, can ksoftirqd take longer than 100 ms to get scheduled?
If so, the case would fail with "wrap probe missing or unequal" even though
the kernel behaves correctly.

The other packet checks in the script wait through lab.finish() with a
completion predicate. Would polling lab.observe() until both lanes hold the
probe, bounded by lab.remaining(), close this window?

> +    start = rows[0][0]["seq"]

[ ... ]

> +def topo(lab):
> +    """SAN - interlink - HSR DUT - two LANs - receiver namespaces."""
> +    tx, dut, rx = lab.ns(), lab.ns(), lab.ns()
> +    for ns, dev, peer_ns, peer in ((tx, "t0", dut, "dil"),
> +                                   (dut, "da", rx, "ra"), (dut, "db", rx, "rb")):
> +        lab.veth(ns, dev, peer_ns, peer)
> +        for owner, link in ((ns, dev), (peer_ns, peer)):
> +            lab.ip(owner, "link", "set", "dev", link, "up")
> +    hsr_attach(lab, dut, "hm", "da", "db", "dil")
> +    attributes = link_state(lab, dut, "hm")["linkinfo"]["info_data"]
> +    require(attributes.get("proto") == 0 and attributes.get("version") == 1 and
> +            all(attributes.get(key) == value for key, value in
> +                (("slave1", "da"), ("slave2", "db"), ("interlink", "dil"))),
> +            "HSR topology has unexpected protocol/version")

[Severity: Medium]

What happens here with an iproute2 that does not print the HSR version
attribute?

The kernel has only sent IFLA_HSR_VERSION for non-PRP devices since commit
16a2206354d169 ("net/hsr: add protocol version to fill_info output"), in
hsr_fill_info():

    else if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))

Whether a "version" key shows up in the ip -j -d link show output then
depends on the iproute2 HSR print code. Older iproute2 releases print
slave1, slave2, interlink, seq_nr, supervision and proto, but not version.
In that case attributes.get("version") returns None and require() raises
ValueError.

ValueError is in CASE_ERRORS, so main() reports the case as not ok. It then
marks every later case as failed too:

    for later, (other, _) in enumerate(cases[number:], number + 1):
        print(f"not ok {later} - {other}: stopped after prior failure", flush=True)

In gro mode, "natural TCP interlink" is the first caller of topo(). The six
"PRP LAN" cases after it never call topo(), but they would still be
reported as not ok. In ordered mode all five cases call topo(), so the
whole test would fail.

A missing interlink option in iproute2 is already reported as SKIP through
interlink_unsupported(). Could a missing "version" key get the same
treatment, or simply not be required?

> +    lab.ip(tx, "addr", "add", "100.64.2.1/24", "dev", "t0")

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107220544.20-1-xiexinet%40gmail.com
