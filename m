Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F04B829D;
	Sat, 10 Oct 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791663604; cv=none; b=urBa3KY8B85qNh9WUkp5k6Sz6AUFk9Kl3GzSxo+qwBCyhDjnkTowiMdfubDn041m45DCun2nZYde59ABPMK0jw67zVWUDT/XlKw26kHKTkzx5r7yC0yn2fY/zbfjnRNmMLQ90CmnQWBYrcCXEeQj9n9qkwozl30lv5K61MDkFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791663604; c=relaxed/simple;
	bh=Z/6ubOrsgmyDs+XfISfkYbiIMeposhb279CaMqsajIY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6Z0FYkZUv7xQQNrPPAE28ETYOEOezVKcyxbELFAma6KCpg2wibcEZmabHwe0JRZbXzrqWzYx+y3clDNBjm736lY0Dl4f008iXtGjsd6Kd9q96imun6emFFb7EHJoWjmPJnJrbPPFMcciuUcLnhy//bcaupLNO/hERaTZtfjCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El8FGC6w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El8FGC6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443911F000FF;
	Sat, 10 Oct 2026 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791663599;
	bh=6BuO4Orqatq6zxR9Kahkzms9EIKqEDxm8BKhbhVieTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=El8FGC6w8GFvtVvfbecjpP355aU2RRv1Mi1vmoQiX/5t4BaafcHCSP9YJWfMsvsKZ
	 JA7bETnP5I488gHSzrIZtwJ5Sd92zrPHK42bULprW3dW2APKzrqpGL/J7nBVPIKPNc
	 i1MGdpdthXN3QmEA6K+P2kyIGO+MwziqbuGdq7T1hOSZ89AkbqNfs+m8Qk9oYUw6Yz
	 hndtMazGkCDADGspajyDHmL1M6wDhP7ff1PhFMC30jVSZxPpLY7X7jLJnWn0EWaYXQ
	 IWeBntLfTHRg1w69eUiMLAFBh5KyxWgkw6DP41Cn2VooyWoueix3Vt7oIsMQ7aMsBg
	 M4aSGluMvpI3A==
Subject: Re: [PATCH net v7 4/4] selftests: net: hsr: verify GRO policy and
 ordered forwarding
From: netdev-bot+sashiko@kernel.org
To: xiexinet@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com
Date: Sat, 10 Oct 2026 20:19:57 +0000
Message-ID: <179166359775.434549.12356274501362124625@kernel.org>
In-Reply-To: <20261009201324.17-5-xiexinet@gmail.com>
References: <20261009201324.17-5-xiexinet@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 7 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new 'busy-handler rollback' case (rollback_macvlan() in
  hsr_gro_superpacket.py) needs a macvlan device, but…
- [Medium] set_gro() accepts a rejected GRO request only when ethtool's
  stdout is exactly "Actual changes:\nrx-gro: off [requested on]\n" and…
- [Medium] decode() treats any non-HSR frame whose last two bytes are
  0x88fb as PRP (`elif end >= off + 6 and raw[-2:] == b"\x88\xfb":`) and…
- [Medium] Capture.__init__ creates the AF_PACKET socket with protocol
  htons(ETH_P_ALL) (line 120), then calls setsockopt twice, and only…
- [Medium] SIGINT/SIGTERM are handled by interrupt(), which raises
  InterruptedError in the main thread at the next bytecode boundary.
- [Medium] Lab.finish() decides transmission is complete after 100 ms
  with no captured frame (`if empty and time.monotonic() - quiet >= 0.1:…
- [Medium] Lab.finish() removes the capture hooks one capture at a time
  (`for cap in active: ... cap.socket.bind(("lo", 0))`).
- [Low] Lab.finish() takes every capture in self.captures that is not yet
  complete, so a case that raises Skip after creating captures but…
- [Low] hsr_gro_superpacket.py contains about 1088 lines of its own
  framework: a hand-written TAP emitter, ctypes setns() namespace entry,…
- [Low] In ordered_concurrent(), if a producer fails before reaching the
  barrier (for example, os.sched_setaffinity() raises), its except block…

--

selftests: net: hsr: verify GRO policy and ordered forwarding

This adds a Python helper with two shell entry points. It tests HSR/PRP
member GRO handling across attach, detach and failed attachment, the
master's GSO type mask, and TCP/UDP GSO segmentation through HSR and PRP.
It also uses AF_PACKET captures on every lane to check ordered forwarding
of local, interlink, supervision and concurrent traffic, plus sequence
number wrap.

[ ... ]

> diff --git a/tools/testing/selftests/net/hsr/config b/tools/testing/selftests/net/hsr/config
> index 205cc4d3d64bd..724fbe3a6eab7 100644
> --- a/tools/testing/selftests/net/hsr/config
> +++ b/tools/testing/selftests/net/hsr/config
> @@ -2,5 +2,6 @@ CONFIG_BRIDGE=y
>  CONFIG_HSR=y
>  CONFIG_IPV6=y
>  CONFIG_NET_SCH_NETEM=m
> +CONFIG_PACKET=y
>  CONFIG_VETH=y
>  CONFIG_VLAN_8021Q=m

[Severity: Medium]
Should CONFIG_MACVLAN be added here too?

The busy-handler rollback case in rollback_macvlan() creates a macvlan on
top of m:

    result = lab.ip(ns, "link", "add", "link", "m", "name", "mv",
                    "type", "macvlan", "mode", "bridge", check=False)

On a kernel built from this fragment, that command fails with "Unknown
device type", and rollback_macvlan() turns the failure into a SKIP:

    if "unknown device type" in error or "operation not supported" in error:
        raise Skip("macvlan device kind unavailable: " + result.stderr.strip())

No other case reaches the -EBUSY path in hsr_portdev_setup(), where
netdev_rx_handler_register() fails because macvlan already owns the
rx_handler. CI kernels built from net/hsr/config would lose that coverage
and still report success.

> diff --git a/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
> new file mode 100755
> index 0000000000000..d39bf1af291f8
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.py
> @@ -0,0 +1,1088 @@

[ ... ]

> +def decode(raw, ancillary=()):

[ ... ]

> +    end = len(raw)
> +    if proto == 0x892f:
> +        require(off + 6 <= end, "short HSR tag")
> +        field, seq, proto = struct.unpack_from("!HHH", raw, off)
> +        row.update(seq=seq, path=field >> 12, tag=True, encoding="hsr")
> +        expected = len(raw) - 14 - (4 if raw[12:14] == b"\x81\x00" else 0)
> +        require(field & 0xfff == expected, "HSR LSDU size differs")
> +        off += 6
> +    elif end >= off + 6 and raw[-2:] == b"\x88\xfb":
> +        seq, field, suffix = struct.unpack_from("!HHH", raw, end - 6)
> +        expected = len(raw) - 14 - (4 if raw[12:14] == b"\x81\x00" else 0)
> +        require(field & 0xfff == expected, "PRP LSDU size differs")
> +        row.update(seq=seq, path=field >> 12, tag=True, encoding="prp")
> +        end -= 6

[Severity: Medium]
Can an ordinary untagged frame that happens to end in 88:fb fail the whole
run here?

decode() treats any non-HSR frame whose last two bytes are 0x88fb as PRP,
and an LSDU mismatch then raises an error. The kernel handles a mismatched
LSDU size by falling back to a plain frame, in prp_fill_frame_info():

    if (rct &&
        prp_check_lsdu_size(skb, rct, frame->is_supervision)) {
        ...
        return 0;
    }
    return HSR_FRAME_PLAIN;

Capture.drain() calls decode() on every frame that matches pkttype. That
includes captures on non-PRP links such as dil, t0 and m/mv.

A pure TCP ACK ends in the low 16 bits of TSecr. An IPv6 NS/RS/MLD frame
can end in the last two bytes of a random interface MAC. In either case
drain() raises ValueError, the case fails, and every later case is
reported as not ok.

Would it be better to treat an LSDU mismatch as a plain frame, as the
kernel does?

[ ... ]

> +class Capture:
> +    def __init__(self, lab, ns, dev, pkttype=None):
> +        self.lab, self.rows, self.seen = lab, [], 0
> +        self.ns, self.dev, self.packets = ns, dev, None
> +        self.pkttype, self.name = pkttype, ns + "/" + dev
> +        self.complete, self.drops, self.truncated = False, None, 0
> +        self.last_seen = time.monotonic()
> +        self.socket = lab.sock(ns, socket.AF_PACKET, socket.SOCK_RAW, socket.htons(3))
> +        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 8 * 1024 * 1024)
> +        self.socket.setsockopt(263, 8, 1)
> +        self.socket.bind((dev, 0))

[Severity: Medium]
Can frames from other interfaces end up in this capture?

Creating the socket with htons(ETH_P_ALL) registers the hook right away in
packet_create(), with no device restriction:

    if (proto) {
        po->prot_hook.type = proto;
        __register_prot_hook(sk);
    }

Frames that arrive on any device in the namespace before bind((dev, 0))
stay in the socket queue. Capture.drain() checks only addr[2] (pkttype)
and never addr[0] (ifname):

    if self.pkttype is None or addr[2] == self.pkttype:
        self.rows.append(decode(raw, anc))

For example, while ordered_lanes() is creating the db capture, a
supervision or ND frame sent on da can be recorded as db traffic.
verify_supervision() then fails with "wrong supervision tag kind/path", a
protocol_order() error, or "data/supervision LAN order differs".

Would either of these avoid it: creating the socket with protocol 0 and
passing ETH_P_ALL to bind(), or filtering on addr[0] in drain()?

[ ... ]

> +class Lab:
> +    def __init__(self, deadline):

[ ... ]

> +    def ns(self, label):
> +        name = "hsrp4-%s-%d" % (self.token, len(self.names))

[Severity: Low]
This isn't a bug, but this file carries its own test framework: a
hand-written TAP emitter, namespace entry through ctypes setns(), a
manager for namespace/socket/capture lifetimes, and ip/ethtool wrappers.

tools/testing/selftests/net/lib/py already provides ksft_run, NetNS,
NetNSEnter, defer, ip, ethtool and cmd. Could this use net/lib/py
instead? The custom layer has no per-case teardown, which leads to the
cross-case coupling in Lab.finish() noted below.

Some of the code is unused. Lab.ns() ignores label, and tcp_transfer()
never uses its captures argument.

[ ... ]

> +    @contextmanager
> +    def enter(self, ns):
> +        descriptor = os.open("/var/run/netns/" + ns, os.O_RDONLY)
> +        try:
> +            self.setns(descriptor)
> +            yield
> +        finally:
> +            try:
> +                self.setns(self.original)
> +            except BaseException:
> +                self.restore_failed = True
> +                raise
> +            finally:
> +                os.close(descriptor)

[Severity: Medium]
Can a SIGINT or SIGTERM here leak every namespace the test owns?

interrupt() raises InterruptedError at the next bytecode boundary. If that
happens during or just after self.setns(self.original), restore_failed is
set even though the libc setns() call already succeeded.

Lab.close() then skips every ip netns del and never retries the restore:

    if self.restore_failed:
        errors.append("namespace restoration failed; no namespace commands attempted")

All hsrp4-* namespaces are left behind, along with their veths and HSR
devices.

main()'s finally block has a similar window:

    finally:
        for sig in (signal.SIGINT, signal.SIGTERM):
            signal.signal(sig, signal.SIG_IGN)
        try:
            lab.close()

The handlers are switched one at a time. A second signal that arrives
before both are ignored raises InterruptedError inside the finally block,
and lab.close() never runs.

The commit message says:

    INT/TERM release owned resources and preserve failures.

Would blocking the signals with signal.pthread_sigmask() around these
sections make that statement hold?

[ ... ]

> +    def finish(self):
> +        active = [cap for cap in self.captures if not cap.complete]

[Severity: Low]
This collects every incomplete capture from the whole run, not only those
of the current case. If a case raised Skip after creating captures but
before calling finish(), the next case's finish() would run the cutoff and
validate() on them.

As far as I can tell, the only such path today is the Skip in
ordered_data():

    except OSError as error:
        if error.errno in (errno.ENOPROTOOPT, errno.EOPNOTSUPP):
            raise Skip("UDP GSO unavailable") from error

udp_lib_setsockopt() cannot return those errnos for UDP_SEGMENT:

    case UDP_SEGMENT:
        if (val < 0 || val > USHRT_MAX)
            return -EINVAL;
        WRITE_ONCE(up->gso_size, val);

So the path can't be reached in the current tree. Would it still be safer
to limit captures to the case that created them?

> +        end = min(self.deadline, time.monotonic() + 2)
> +        quiet = time.monotonic()
> +        while time.monotonic() < end:
> +            self.observe(0.01)
> +            empty = True
> +            for cap in active:
> +                count, drained = cap.drain()
> +                if count or not drained:
> +                    empty = False
> +            quiet = max([quiet] + [cap.last_seen for cap in active])
> +            if empty and time.monotonic() - quiet >= 0.1:
> +                break

[Severity: Medium]
Is 100 ms with no captured frame enough to conclude that the kernel has
finished transmitting?

In this tree, contended master TX, interlink RX and supervision frames are
queued and drained by a BH work item. In net/hsr/hsr_forward_queue.c,
hsr_queue_owned_release() does:

    queue_work(system_bh_wq, &hsr->fwd_work);

hsr_queue_work() requeues itself when its budget runs out.

Suppose that worker is delayed by more than about 100 ms after the last
captured frame, for example under load on PREEMPT_RT. The remaining
frames then go out after the hooks have been moved to lo, and verify_udp()
fails with "UDP payload/ID set differs". ordered_send() also allows only
lab.observe(0.1) before returning.

The packets == seen + drops check only shows that the socket queue was
drained. Could finish() instead wait until every expected payload has
been seen on both lanes, with the deadline as the upper bound?

> +        else:
> +            raise ValueError("capture failed to drain within fixed deadline")

[ ... ]

> +        for cap in active:
> +            require(time.monotonic() < end, "capture cutoff/drain deadline expired")
> +            require(cap.dev != "lo", "capture already uses the cutoff device")
> +            cap.socket.bind(("lo", 0))
> +            require(cap.socket.getsockopt(socket.SOL_SOCKET, socket.SO_ERROR) == errno.ENETDOWN,
> +                    cap.name + ": capture cutoff did not report ENETDOWN")

[Severity: Medium]
Can the da and db captures stop at different points in the stream?

The hooks are removed one capture at a time. Each bind() of a running
socket goes through packet_do_bind()->__unregister_prot_hook(sk, true),
which calls synchronize_net().

In ordered_supervision(), the HSR master and interlink are still up when
finish() runs:

    lab.observe(10)
    lab.finish()

hsr_announce() and hsr_proxy_announce() keep sending supervision frames
during the cutoff. A frame sent after the da hook is removed, but before
the db hook is removed, is captured only on db.

Both captures pass their completeness checks, but verify_supervision()
fails:

    require(observed[0] == observed[1], "supervision LAN copies differ")
    require(all_frames[0] == all_frames[1], "data/supervision LAN order differs")

Would it help to stop the supervision senders before the cutoff, or to
compare only the prefix that both lanes have in common?

[ ... ]

> +def set_gro(lab, ns, dev, wanted, active=None):
> +    result = lab.cmd(ns, "ethtool", "-K", dev, "gro", wanted, check=False)
> +    forced = (active == "off" and wanted == "on" and result.returncode == 1
> +              and result.stdout == "Actual changes:\nrx-gro: off [requested on]\n"
> +              and result.stderr == "Could not change any device features\n")
> +    require(result.returncode == 0 or forced,
> +            "%s: GRO setter rc%d %s" % (dev, result.returncode, result.stderr.strip()))

[Severity: Medium]
Does this depend on the exact output format of ethtool?

A rejected request is accepted only when stdout and stderr match these
strings byte for byte. The code right below already reads back the actual
state with lab.features() and checks it against active.

forced becomes false if an ethtool build reports the change differently,
for example:

- the ioctl fallback, which uses legacy names such as
  generic-receive-offload
- an extra line for a dependent feature

policy() goes through this path on every iteration:

    for wanted in ("on", "off", last):
        set_gro(lab, ns, "m", wanted, active="off")

When it fails here, every remaining gro-mode case is reported as not ok.

Could this rely on the read-back state, and check only the return code
here?

[ ... ]

> +    def producer(index):
> +        try:
> +            # Socket namespace binding was completed before threads existed.
> +            os.sched_setaffinity(0, {cpus[index]})
> +            barrier.wait(timeout=2)

[ ... ]

> +        except Exception as error:
> +            errors.append(error)
> +            stop.set()
> +            barrier.abort()
> +
> +    threads = [threading.Thread(target=producer, args=(index,))
> +               for index in range(2)]
> +    unfinished = []
> +    try:
> +        for thread in threads:
> +            lab.threads.append(thread)
> +            thread.start()
> +        barrier.wait(timeout=2)

[ ... ]

> +    if errors:
> +        raise errors[0]

[Severity: Low]
What happens when a producer fails before reaching the barrier, for
example in os.sched_setaffinity()?

The producer calls barrier.abort(), and the main thread's barrier.wait()
raises threading.BrokenBarrierError. That exception propagates through the
finally block, so the recorded producer error is never raised.

main() then prints "not ok N - two-functional-producers: " with an empty
message, and the real cause is lost.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009201324.17-1-xiexinet%40gmail.com
