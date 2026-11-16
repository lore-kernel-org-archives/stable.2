Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846449;
	b=KelDVbuzHshosJLzFO9JkgyBL9lrJ9zH2Yn9xk2E6tsho3d/IL3IOoebfL1rKHjnJgoE
	 lr9h+fnxMaZMrn2FSr+UAx9Tub9EAu/0y0b5DnwK1d1EiZBJEg2Q9ACCXHOTMZMY5YQ1I
	 9F6sb9wk4RR85evZ1NZQWuZtgWWQbqQD6DbYVABHbPUB5HEpcRQyalv1tJfoT77M292o0
	 hcQ2phlCcPYBAdhMTC5WBef9+kmocoBQReo8fxTI5ldDT8SDFVQ7xebzcZIyURR7UbiLh
	 RKY03TiwTr+gbfrRBwL2y6WS3/5RAZ/h6aLr1kfABOCxww8bh0J3r96bauD6iG70ScA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846449;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nV9c2MLNlihsCA7BTpRORTeWE46Uw4LSE6nUB+YU+40=;
	b=JgVedYGJiiPiKI5qzZeDeCtOieLg+If04nh92ReQpGCtPEH1JBe3OaH4bdfzQUbquw6l
	 ilMBRluNHoVxJkpOhRGVUrMUjS8z7Imf3Feakj0E3I8Go2O3ROXPHUrnv7R54ClrS/2YG
	 VcEHUPa4af3MnHv5OAGRUwyKxKKCUbIh6k/HTOoXqTicwgOVkokNa53HS66MhMTGN6B92
	 v6XMI06nLRkehC94MNd3bVq0BEx973KspYYESIrVmOwm8yYxrZ1mNHevg8NRjcBG5QngC
	 cA4xpHXujvF6cVKPCtXZ10E7EmqOZ06h1Yj9mLcu1MVA5HdU3IQDU8aQEt9itGMtn/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvdLpzCv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB4606A32C;
	Mon, 16 Nov 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvdLpzCv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530861F000D0;
	Mon, 16 Nov 2026 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794846448;
	bh=nV9c2MLNlihsCA7BTpRORTeWE46Uw4LSE6nUB+YU+40=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EvdLpzCvDmBIPhUdLLEYg/bg/X09XK9EzfDBSHVn6+fs1+9GupPKWuockBAB/U11/
	 rXZ7Xw2eVeUa/QZ8lcKySQShRZgO5zA7Gopx3Y9Ws9KukNTgUklisww4m3STxOg57f
	 F/ouZZg6ycw8Sw7KvtJrJgnWRZEAPjrgpmxQSI9sdeYpr+aytHp+C+dCVOTBEicR4Q
	 ej0laSiZVDd8thLnM4G4AdXsHlzzqRKDjRre32y8xVEemlvsiXxVyuF5iXWB6i5ddJ
	 dwdlIONRiJvpVQsdgWXi1G9MJxHSMVy/35MQMSnRHqUtIcQbiBFlYpm0lwgkHVe1d2
	 kK6YvMYwy6WQg==
Subject: Re: [PATCH net v9 4/4] selftests: net: hsr: verify GRO policy and
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
Date: Mon, 16 Nov 2026 16:27:26 +0000
Message-ID: <179484644688.3136.15525954898173827248@kernel.org>
In-Reply-To: <20261112153333.20-5-xiexinet@gmail.com>
References: <20261112153333.20-5-xiexinet@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tcp_prp(), the check for 'no tag/RCT on local delivery' can
  never fail.
- [Low] The commit message overstates what the second refusal group in
  port_types() checks…
- [Low] In tcp_prp(), a Skip raised by verify_stream() bypasses the PRP
  reply checks.
- [Low] Lab.close() closes every owned socket (lines 367-368) before it
  joins the producer threads (lines 369-373).

--

selftests: net: hsr: verify GRO policy and ordered forwarding

This adds two HSR/PRP selftests, hsr_gro_superpacket.sh and
hsr_ordered_forwarding.sh. Both exec one shared Python helper. The gro
mode checks the member GRO policy, the refusal of unsupported port
types, and byte-exact TCP forwarding over an HSR interlink and over PRP
LANs. The ordered mode checks sequence ordering of local, interlink,
supervision and concurrent traffic, including a sequence wrap.

> diff --git a/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
> new file mode 100755
> index 0000000000000..3548ee0adfae3
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
> @@ -0,0 +1,1456 @@

[ ... ]

> +    def close(self):
> +        """Stop threads, close sockets and delete owned namespaces."""
> +        self.stop.set()
> +        end, errors = time.monotonic() + 20, []
> +        for sock in self.sockets:
> +            sock.close()
> +        for thread in self.threads:
> +            if thread.ident is not None:
> +                thread.join(max(0, end - time.monotonic()))
> +            if thread.is_alive():
> +                errors.append("sender thread did not stop")

[Severity: Low]
This isn't a bug, but the docstring says "Stop threads, close sockets".
Lab.close() closes the sockets before it joins the producer threads
started by ordered_concurrent().

If a producer is still running here, its sendto() on the closed socket
gets EBADF. Its except (OSError, ValueError, RuntimeError) clause
catches that. The 1 second timeout from ordered_socket() and the
lab.stop check limit how long it can run. The main thread opens no new
fds until the join returns, so fd reuse does not look possible.

Would joining the threads before closing the sockets match the docstring
order?

[ ... ]

> +    # A refused second port leaves the first port as it was.
> +    for dev in ("w", "g"):
> +        local_pair(lab, ns, dev)
> +    set_gro(lab, ns, "p", "on")
> +    set_gro(lab, ns, "g", "on")
> +    first, second = link_state(lab, ns, "p"), []

[ ... ]

> +    for kind, dev, error in second:
> +        label = f"{kind} as slave2"
> +        result = lab.ip(ns, "link", "add", "name", "hsr0", "type", "hsr",
> +                        "slave1", "p", "slave2", dev, "version", "1", check=False)
> +        require(result.returncode != 0 and error in result.stderr,
> +                f"{label}: missing refusal message: {result.stderr.strip()}")
> +        require(lab.ip(ns, "link", "show", "dev", "hsr0", check=False).returncode,
> +                label + ": HSR device left behind")
> +        after = link_state(lab, ns, "p")
> +        require("master" not in after and after["promiscuity"] == first["promiscuity"],
> +                f"{label}: first port p changed by the refused attach")
> +        gro_state(lab, ns, "p", "on", label + ": first port p")
> +        refused.append(label)

[Severity: Low]
Does this second refusal group in port_types() check what the commit
message describes? The message says:

    ... and of a VRF port without leaving an upper link or a promiscuity
    reference on any port ...

and:

    ... a device refused at attach keeps its request.

Only p is snapshotted here (first = link_state(lab, ns, "p")), and only
p is compared after each refused attach. The refused VRF port w and the
macvlan mvg have no baseline. Their promiscuity is never compared, and
the GRO state of mvg is never read back.

The first refusal group snapshots every candidate device in before and
checks each one again, so the two groups do not match. A leaked
promiscuity reference on w or mvg would still pass this case.

Should w and mvg also go into the before/after comparison?

[ ... ]

> +def tcp_prp(lab, row):
> +    """TCP GSO from a SAN on one PRP LAN is delivered locally, segmented."""

[ ... ]

> +    lab.cmd(tx, "ethtool", "-K", lower, "tso", "on", "gso", "on")
> +    caps = [lab.capture(tx, lower, pkttype=4), lab.capture(dut, "pm", pkttype=0)]

[Severity: Medium]
Can the check for no tag/RCT on local delivery ever fail for this
capture?

The pm capture is opened with the default prp=False. decode() only
recognises a PRP RCT when prp is set:

    elif prp and end >= off + 6 and raw[-2:] == b"\x88\xfb":

So every frame captured on pm decodes with tag=False and
encoding="plain". The TCP payload ends at the IPv4 total length, so 6
trailing RCT bytes are silently ignored.

verify_stream(..., local=True) then calls:

    wire_rows(captures[1].rows, port, stack, tagged=False)

and this check in wire_rows() is always true here:

    require(row["tag"] == tagged, "flow tag/RCT missing or unexpected")

The size limit does not catch it either. A 1514 byte segment plus a 6
byte RCT is exactly 1520, which passes
row["size"] <= 1520 + 4 * len(stack).

Suppose the PRP master delivered frames locally with the RCT still
attached. The IP stack would trim the trailer and TCP would still
complete, so this case would pass. The commit message says "Tags/RCT,
sequence numbers and VLAN stacks are checked".

Would opening the pm capture with prp=True make this check effective?

> +    ingress = lab.capture(dut, "d" + side.lower(), prp=True)
> +    lanes = [lab.capture(dut, dev, pkttype=4, prp=True) for dev in ("da", "db")]
> +    payload, reply = tcp_transfer(lab, tx, dut, sender, "10.68.0.2", "10.68.0.1", 5201)
> +    lab.finish(fin_seen(caps + lanes + [ingress], 5201))
> +    verify_stream(caps, 5201, payload, stack, local=True, inband=inband, ingress=ingress)

[Severity: Low]
What happens to the PRP reply checks below when verify_stream() raises
Skip? verify_stream() ends with:

    if not aggregate:
        raise Skip("no sender GSO aggregate observed")

The comment above it says this gap is reported only "after transfer and
all other checks". In tcp_prp(), though, the reply checks run only after
verify_stream() returns: exactly once per LAN, RCT present, LAN id
10 + index, encoding "prp", identical copies. Nothing here catches
Skip, so main() prints "ok N - ... # SKIP".

When the sender capture shows no payload larger than 1500 bytes, a
missing, duplicated or wrongly tagged PRP reply would be reported as
SKIP, not FAIL. This seems to contradict "its reply must appear once on
each LAN" in the commit message.

Could the Skip be held back until the reply checks in tcp_prp() have
run?

> +    copies = []
> +    for index, cap in enumerate(lanes):
> +        cap.validate()
> +        rows = [frame for frame in cap.rows if frame["ports"] and
> +                frame["ports"][0] == 5201 and frame["payload"]]
> +        require(len(rows) == 1 and rows[0]["payload"] == reply,
> +                "PRP reply not exactly once per LAN")

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112153333.20-1-xiexinet%40gmail.com
