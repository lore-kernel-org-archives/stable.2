Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063022;
	b=y0sAvv01Ll69l7JBLqF0wiSWp4MfEXjJXD2KMTume4UyHQUsw3bfy2jZ+Rb/vMfTQhdK
	 Qqd9MO8Np+yLkkJRqfwEDfy2mYo+A3XcAfNGYP9Z5wKjxBGlTTr3gQCeY7zZ45wSK2dUM
	 GgDmK4rVET05MOtq7+EB5/0hjHCOTLbFl70CLUEQ50ystQ8TUC+oRNMv0txqfriFUPzej
	 CrttRCpFysJnHxlT/Ne3eRgx60mfjABUi3ezjOhHGGguo1e8I4dp9NNZM+BTTi5dp7ccE
	 TbfYNxffaIBbODgn9cBCzNJKvqq5O0fHrDhojNetIc3RissrXz2V5tEDmii9KnPKokg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063022;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=L7gONvuWJ1W5fc4Gent1f5TjdAlfCccrrNFVcwKBXuA=;
	b=E1tYWLzc78n7XZS9JA7wuYlBbQ3FfXr/VSjV8zBuuRfAZ3ObNYhbDgaQbdE0AUDFDvrX
	 vlxY9rANv5hXgi/vsQfbDZp/0oOBz97xYlmsTW1ku/7katKzFTy5p9cy70n78RvrAfQHK
	 ugsDoFyj1orpANKGbNeSdjB/C9R8W0I0GeukTBlE++esnhMkVO1JC5k+Cfzl94DEB00R3
	 AZcVmPNGkUUvPnXid6D3BYu90M/dSohASYbUTKSDgtuD/jdQ77dkLSZo1C3IYdr5ezvq8
	 vR62mb73CD0jW8TFkhCSCnenDXJGU7n7HOdn1m7ZlzQu6qG8Lmj9mf53PcU8AkQvoHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObWXVGcr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C0606EE8C;
	Sat,  7 Nov 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObWXVGcr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418131F008A2;
	Sat,  7 Nov 2026 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063021;
	bh=L7gONvuWJ1W5fc4Gent1f5TjdAlfCccrrNFVcwKBXuA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ObWXVGcr5qE1JMbstc2J1Rixv3VQdgTf7VqXZ1BhNqdKm8pltuYbsLmh534QhgTq6
	 OYvzRWhbm3T/cTdqwoNjnnvBV5PS12StI7GdLR9gv+2uCqMTp2FdUxuVPbHOF4FyTh
	 nt0el9iAz0NzTnFA1TiBVu9yrHP7uAQ6bUozy/DxpcT8Ko4plfxZmllEEM1xnyMXRt
	 HVkTGyU1DL1FDPL2ZlUpTXEEVrBDfNVKVO/k/02Sw3ereq0zGRXAsKz0iuzTTyw1f5
	 cRhBeEyERwoD6vX85NXPriLE5O1fKFqcST079qiZ376zlvQaL/+80DAhwu6pBDebQp
	 CFSa5cLFaFyRw==
Subject: Re: [PATCH net v3 4/4] selftests: tc-testing: teql: cover each attach
 rejection on its own
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com,
 thomas.goff@boeing.com
Date: Sat, 07 Nov 2026 14:50:20 +0000
Message-ID: <179406302081.994134.2324214805948881495@kernel.org>
In-Reply-To: <SER-NSBD.v3.r0.20261103064310-4@mojatatu.com>
References: <SER-NSBD.v3.r0.20261103064310-4@mojatatu.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit body describes the patch as a change relative to an
  unmerged v2 posting, not as a change to the tree.
- [Low] Both rejection cases check only that tc exits with 2 and that no
  matching qdisc is dumped.

--

selftests: tc-testing: teql: cover each attach rejection on its own

This commit moves tdc case 124e out of the nsPlugin test namespace and
into init_net with its own dummy device. Only the root-only check in
teql_qdisc_init() can then refuse it. It also adds case 6a06, which
attaches teql0 at root from the test namespace, so that only the
namespace check can refuse that one.

Link: https://lore.kernel.org/netdev/179366641863.488856.17368571591466000274@kernel.org/
Link: https://lore.kernel.org/netdev/179366641986.488856.2193313144081673076@kernel.org/

> It no longer proves that a child attach is
> refused as such, and the case added in the previous posting covers the
> namespace check alone.

[ ... ]

> Attach a root qdisc from the test namespace in the second case, so that
> only the namespace check can refuse that one.

[Severity: Low]
This isn't a bug, but these sentences read as if a namespace rejection
case is already in the tree. Is that the case?

Case 6a06 ("Reject TEQL attach from a different network namespace") is
added in full by this commit. The parent commit, "net/sched: sch_teql:
reject qdiscs from another network namespace", changes nothing under
tools/testing/selftests/tc-testing/.

The only place that says a new case is added is the v1 -> v2 and
v2 -> v3 changelog. That text sits below the "---", so it is dropped
when the patch is applied.

Could the body say outright that this commit adds new coverage for the
namespace rejection and moves 124e into init_net?

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> index 0179c57104adb..ab5d0881c0070 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json

[ ... ]

> @@ -104,7 +100,35 @@
>          "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
>          "matchJSON": [],
>          "teardown": [
> -            "$TC qdisc del dev $DUMMY root handle 1:"
> +            "$TC qdisc del dev $DUMMY root handle 1:",
> +            "$IP link del dev $DUMMY"
> +        ]
> +    },
> +    {
> +        "id": "6a06",
> +        "name": "Reject TEQL attach from a different network namespace",

[ ... ]

> +        "setup": [],
> +        "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 3: teql0",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> +        "matchPattern": "qdisc teql0 3: root",
> +        "matchCount": "0",

[Severity: Low]
Can this case pass even when the namespace check is not what refused
the attach?

tc exits with 2 for any netlink error. The verify step only checks that
no teql0 qdisc shows up in the dump. Case 124e has the same weakness:
it checks only expExitCode "2" and matchJSON [].

In teql_qdisc_init(), both rejections return the same errno. Only the
extack text tells them apart:

net/sched/sch_teql.c:teql_qdisc_init() {
    ...
	if (sch->parent != TC_H_ROOT) {
		NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root");
		return -EOPNOTSUPP;
	}

	if (dev_net(dev) != dev_net(m->dev)) {
		NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
		return -EOPNOTSUPP;
	}
    ...
}

The tc-testing config sets CONFIG_NET_SCH_TEQL=m. Unlike the other
sch_* modules, sch_teql.c has no MODULE_ALIAS_NET_SCH(). So the
alias-based request_module() never autoloads it, and the lookup fails:

net/sched/sch_api.c:qdisc_create() {
    ...
	ops = qdisc_lookup_ops(kind);
	if (!ops) {
		err = -ENOENT;
		NL_SET_ERR_MSG(extack, "Specified qdisc kind is unknown");
		goto err_out;
	}
    ...
}

When that happens, tc still exits with 2 and nothing named teql0
appears. Both 6a06 and 124e then pass, whether or not the kernel has
either check. That includes a kernel without the namespace fix.

The module is loaded only by try_modprobe() in tdc.sh. That function
just prints "skipping" when modprobe fails. Running tdc.py directly,
for example with -e 6a06 or -c teql, never loads it.

The commit message says "only the root-only check can refuse it" and
"only the namespace check can refuse that one". That only holds when
sch_teql is loaded.

Would it make sense for each case to match the specific extack
message? Another option is to fail when the teql0 kind is unavailable.

The positive teql cases would fail in the same setup, so the suite as a
whole would still show that something is wrong.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v3.r0.20261103064310%40mojatatu.com
