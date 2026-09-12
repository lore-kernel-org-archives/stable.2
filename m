Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D30492525;
	Sat, 12 Sep 2026 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245390; cv=none; b=eP7+1fUqMn0nqYOlCXl6T10LX1gVVO+OsZ0VMvyos5Qyvch8uuJOehpD6IOUW2aWrnlKZIIAJK/mO4bsdjmTMI77fzoAD/vLvRJVBIPyeVd7tQN4/oHNUlZdMF4cwBkRBXnbWpkzIc2a2y04eNmytnV731wZNsPyL4mygLt3Mlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245390; c=relaxed/simple;
	bh=jn9vX+q58BrI+9ioEcXtx3rSiX9KFO2u0GRr8qeaUrY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRojIeZ/xbQ9xoMAQ5swZjRa6azneo6pnRgKkl8d1cURx/pnLd5qekLc7ZGEYGH+xfiDoNnjBvxXcetUnZXzEqB6FeeASmJo6qULCDniGabnfmYEbGUAh5FDw25SK9X3QY0ZLxAM+PKhpdK6E8q5XxNcn2M+NIMdmqcE0HPA2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSo/QTgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSo/QTgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EB31F000FF;
	Sat, 12 Sep 2026 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245386;
	bh=vBtCT1cEpxXIQveby/xZxccmBUQ0gx20Lk8uxT2bWdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GSo/QTgvDot3uKE2881MBnPz4OV6poe3E/3p7vvF3YWV1/2IU8Rmj33RDj5cInt3W
	 9IMI19Ie08XdBqKpnrkdGhc4tGpe1k6aKJRy36TvSmt9YvILUg6PleQZK63fn5dvzB
	 QgN/JtGPUzwoYJmV7SYoKnjq3sOsNUIvWsi7yZdo6amAyVp6JygGyvjevhkUuNV2fY
	 dQrEUv+xLYekpXM+WNWJpHkAhpMTGAr0X4a81ssZB3QEWbVG6kCcnZwXUNxeLZS6qe
	 xParvFPqb2kc0ZmoBVpkeK9dqWEO13V/Q05rOy9ofh+hE8Z4UCJ6nTq7NY5AXJTJ+/
	 aiiqvOZlSgDfA==
Subject: Re: [PATCH net 2/2] selftests/tc-testing: add hhf hh_limit cap tests
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vtlam@google.com, stable@vger.kernel.org, victor@mojatatu.com,
 hybris@mojatatu.ai, sashiko-bot@kernel.org
Date: Sat, 12 Sep 2026 20:36:24 +0000
Message-ID: <178924538491.3125.17360124122407490999@kernel.org>
In-Reply-To: <QDISC-B855.v1.20260911153152@mojatatu.com.2>
References: <QDISC-B855.v1.20260911153152@mojatatu.com.2>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The three change-path rejection tests (e3cc, f681, 147f)
  assert a witness value that is identical to the kernel default, so…
- [Low] Commit message overstates the add-path coverage of the new test
  file.

--

selftests/tc-testing: add hhf hh_limit cap tests

Adds tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf_flows_limit.json
with six cases exercising the TCA_HHF_HH_FLOWS_LIMIT policy bound on the hhf
qdisc, covering rejected out-of-range values, the accepted boundary value
2048, and an add-time value of 500.

A couple of questions about the coverage claims and the assertions.

> Cover the new TCA_HHF_HH_FLOWS_LIMIT bound: values above 2*HH_FLOWS_CNT
> (4294967295, 65536, 2049) are rejected with the configured limit left
> untouched on both the change and the add path, the boundary value 2048 is
> accepted (installed at 100 first so the boundary change is load-bearing),
> and an add-time hh_limit 500 is preserved instead of being clobbered by
> the default.

[Severity: Low]
Does the file really cover all three values "on both the change and the add
path"?

In hhf_flows_limit.json the values 4294967295, 65536 and 2049 appear only in
cmdUnderTest lines that use "qdisc change" (tests e3cc, f681 and 147f).

The only invalid add-path case is ca99, and it uses 4294967295 only:

    "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root hhf hh_limit 4294967295",
    "expExitCode": "2",
    "verifyCmd": "$TC qdisc show dev $DUMMY",
    "matchPattern": "qdisc hhf 1: root",
    "matchCount": "0",

Also, ca99 asserts that no qdisc exists at all, so there is no "configured
limit left untouched" property being checked on the add path.

Could the changelog describe the actual matrix, or could add-path cases for
65536 and 2049 be added?

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf_flows_limit.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf_flows_limit.json
> new file mode 100644
> index 0000000000000..44538b9266b65
> --- /dev/null
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/hhf_flows_limit.json
> @@ -0,0 +1,128 @@
> +[
> +    {
> +        "id": "e3cc",
> +        "name": "HHF hh_limit rejects value above 2*HH_FLOWS_CNT cap (4294967295)",

[ ... ]

> +        "setup": [
> +            "$TC qdisc add dev $DUMMY handle 1: root hhf"
> +        ],
> +        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root hhf hh_limit 4294967295",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> +        "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*hh_limit 2048",
> +        "matchCount": "1",

[Severity: Medium]
Can this assertion distinguish "limit left untouched" from "limit reset or
clamped to the cap"?

The setup adds hhf without hh_limit, so hhf_init() leaves the default in
place:

net/sched/sch_hhf.c:hhf_init() {
	...
	/* Cap max active HHs at twice len of hh_flows table. */
	q->hh_flows_limit = 2 * HH_FLOWS_CNT;
	...
}

With HH_FLOWS_CNT 1024 that default is 2048, which is also the policy bound
used for the attribute:

	[TCA_HHF_HH_FLOWS_LIMIT] = NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS_CNT),

So the matched witness "hh_limit 2048" is the same string that hhf_dump()
would print if a future implementation validated late and wrote or clamped
q->hh_flows_limit to 2048 before returning the error. Only expExitCode 2 is
actually pinned down here.

The same applies to f681 (hh_limit 65536) and 147f (hh_limit 2049) below,
which use the identical defaulted setup and the identical "hh_limit 2048"
matchPattern.

Would installing a distinct in-range value in setup, e.g.
"$TC qdisc add dev $DUMMY handle 1: root hhf hh_limit 100" and then matching
"hh_limit 100" after the rejected change, make these three assertions
load-bearing? Test 223d further down already uses exactly that technique:

> +        "setup": [
> +            "$TC qdisc add dev $DUMMY handle 1: root hhf hh_limit 100"
> +        ],
> +        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root hhf hh_limit 2048",

[ ... ]

> +    {
> +        "id": "f681",
> +        "name": "HHF hh_limit rejects 65536 (above 2*HH_FLOWS_CNT cap)",

[ ... ]

> +        "setup": [
> +            "$TC qdisc add dev $DUMMY handle 1: root hhf"
> +        ],
> +        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root hhf hh_limit 65536",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> +        "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*hh_limit 2048",
> +        "matchCount": "1",

[ ... ]

> +    {
> +        "id": "147f",
> +        "name": "HHF hh_limit rejects first value above cap (2049)",

[ ... ]

> +        "setup": [
> +            "$TC qdisc add dev $DUMMY handle 1: root hhf"
> +        ],
> +        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: root hhf hh_limit 2049",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> +        "matchPattern": "qdisc hhf 1: root refcnt [0-9]+.*hh_limit 2048",
> +        "matchCount": "1",

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-B855.v1.20260911153152%40mojatatu.com
