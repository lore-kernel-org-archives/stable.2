Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616115;
	b=rZh1igvc53Rnsu8SN3yFoaRJUb1+rNX/dtw18AjxSQ+0MwVGfOpT+DGQBouqlIFo+0s3
	 YmiqfyDkvRY9yZ3cnf0EKWj7QU4Bk52MMhu48feko0mrljjkRLwVNx7juhuHtAnDuqb94
	 DF23GQFIkX9BJhXVvKQ7p6+niDuHMny0RTb/HWVUT/d4zErAhN14UOxpYnF4CTNvDN1CB
	 RpmLbDNlVJyacNxkVBmIXXXC1Lsem/Rj5gmmVI9f6S776irxIWGyYsi9VdHXQLkVxFqDx
	 ElQUYIOMKCByxx/+mvITQbrKB1sdfcuDMEBTFOOfvE7o/8ShUeg1yVdHfeen8DSpS/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616115;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3zCBmA88hpRkhrtX5/EeZJChNGSTM3Tk4F9CZNL8GqQ=;
	b=BCmZMdEK147L0Hq2RLWrqiHSiDmPn+FuOwo74XhQ6ZswW6/Tvvz3E/t1r0oFjMIOdVzd
	 s+++rtTyI35H36c/rGLxk+ZA+1ijUBopuwbxqreilcYNuexgEAmv6aItSdvACU5XcMMB9
	 1Ou3iySBVMneU++pAibBz3Il9/Q+/54AErqGqFii1c8MG0r35q9D2KEv6T3/MTI2Jzkn2
	 phYeqTCTiMwVf0R7ddgJ25VOUscum86E5MhyZZYIGCKnCPr7C35JBR/Ksd+F8TtGmmer6
	 vNLwwVmOPBCjDYvN6BT0UYSXWyGhLefsnLA4/thlhGVOr/dTIuxfW5dOV3+00BSCjsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnwOttN4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F89606A32D;
	Wed, 25 Nov 2026 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnwOttN4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F87A1F000E1;
	Wed, 25 Nov 2026 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616115;
	bh=3zCBmA88hpRkhrtX5/EeZJChNGSTM3Tk4F9CZNL8GqQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BnwOttN4Y1xHMkRB80Oav20e8M36qjaLQeodvuoNcfME/G9Ggw4ecH47yxkljUFIo
	 ymF/WW9b9ckd/16wOlh7zlUFQ13/Z1qgfmF47FMZUlJaqjg8PRDqQUBuJfigK/hdyz
	 67MvsMwRfuKcyCQE/HfhCZ4kxwpSpHU3l0qOeGfTNCIAk2Ks8AgNj8bzIHDTbjnpeL
	 jTd0dsc7y/EGOE43ab5EoV0OO9BcTi/1IdVzYqzKG6ljE+km1Blv+iNeugkMFjy7Ui
	 vwPtHHIKQyzUNWeY+C9GLlIOjJZ8znYucJrrtfJR6dozlbmlDBzKvuhSi0Q2+/xKYj
	 JzvZ+/oYQMQTg==
Subject: Re: [PATCH net v4 3/3] selftests: tc-testing: act_gate: cover the new
 cycle time and interval limits
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, alexei.starovoitov@gmail.com, victor@mojatatu.com,
 Po.Liu@nxp.com, stable@vger.kernel.org,
 syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com, shawnq1@163.com
Date: Wed, 25 Nov 2026 14:15:14 +0000
Message-ID: <179561611414.3135.147725315288144189@kernel.org>
In-Reply-To: <ACT-WEXM.v4.r0.20261124074514-3@mojatatu.com>
References: <ACT-WEXM.v4.r0.20261124074514-3@mojatatu.com>
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

- [Medium] The four new negative tests in tools/testing/selftests/tc-
  testing/tc-tests/actions/gate.json (2c35, 92b8, 8265 and 5c47) re-run…
- [Medium] Tests 92b8 and 8265 in gate.json pass the decimal string
  9223372036854775808 (2^63) as base-time and cycle-time, and expect the…
- [Low] The boundary tests 7d1f and 9f10 in gate.json add a gate action
  with base-time and cycle-time 9223372036854775807 (KTIME_MAX).

--

selftests: tc-testing: act_gate: cover the new cycle time and interval limits

This adds seven tdc test cases for the gate action. They cover the new
KTIME_MAX bound on base-time and cycle-time and the 10 us minimum schedule
entry interval. The negative cases re-run the failing command and match the
error text that tc prints.

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/gate.json b/tools/testing/selftests/tc-testing/tc-tests/actions/gate.json
> index db645c22ad7be..1c910e07c41c9 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/actions/gate.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/actions/gate.json
> @@ -347,5 +347,194 @@

[ ... ]

> +    {
> +        "id": "2c35",
> +        "name": "Reject gate action with a schedule entry below the minimum interval",

[ ... ]

> +        "cmdUnderTest": "$TC action add action gate sched-entry close 9999ns index 100",
> +        "expExitCode": "255",
> +        "verifyCmd": "$TC action add action gate sched-entry close 9999ns index 100 2>&1",
> +        "matchPattern": "RTNETLINK answers: Invalid argument",

[Severity: Medium]
Will this pattern match when tc is built with libmnl?

On this path, fill_gate_entry() in net/sched/act_gate.c sets an extack
message before it fails:

    NL_SET_ERR_MSG_FMT(extack, "Entry interval must be at least %u ns",
                       GATE_MIN_INTERVAL_NSEC);
    return -EINVAL;

The extack pointer is passed down unchanged:

    tc_ctl_action()->tcf_action_add()->tcf_action_init()->
        tcf_action_init_1()->tcf_gate_init()

A tc linked against libmnl prints "Error: Entry interval must be at least
10000 ns." and does not print the "RTNETLINK answers: ..." line. The
matchPattern would then find zero matches, but matchCount requires one.

The same applies to 92b8, 8265 and 5c47. Those values fail the
NLA_POLICY_FULL_RANGE(NLA_U64, &gate_time_range) check in gate_policy
during nla_parse_nested() in tcf_gate_init(). That check sets the "integer
out of range" extack, so tc prints "Error: integer out of range."
instead.

tools/testing/selftests/net/bpf_offload.py already expects tc to print the
"Error: ..." form, and warns "libmnl missing?" when it is absent.

With a tc built without libmnl the patterns do match. But the strerror text
matches any -EINVAL or -ERANGE, so it can't show that the 10 us floor or
the KTIME_MAX bound caused the refusal.

The commit message says:

    tc does not pass the action path's extended acknowledgment back to the
    caller, so the negative cases re-run the failing command and match the
    kernel's own error text instead of relying on the exit code alone.

Is this accurate? The text matched here is iproute2's strerror output, and
the kernel does deliver the extack on this path.

Would it work better to match the kernel strings ("Entry interval must be
at least 10000 ns", "integer out of range"), or to use a regex that accepts
both output forms?

[ ... ]

> +    {
> +        "id": "92b8",
> +        "name": "Reject gate action with a base time above S64_MAX",

[ ... ]

> +        "cmdUnderTest": "$TC action add action gate base-time 9223372036854775808 sched-entry close 10000ns index 200",

[Severity: Medium]
Does 2^63 reach the kernel as 0x8000000000000000 on every architecture?

In iproute2, get_s64() fails with ERANGE for this string, so tc falls back
to get_time64(). That function parses the string with strtod() and assigns
the double to an __s64. Converting 2^63 to int64 is undefined in C.

On x86-64, cvttsd2si gives 0x8000000000000000, which is above KTIME_MAX,
so the kernel refuses it.

On arm64 (FCVTZS), and likewise on riscv, powerpc and s390, the conversion
saturates to 0x7fffffffffffffff, which is exactly KTIME_MAX.

The bound in gate_time_range in net/sched/act_gate.c is inclusive:

    static const struct netlink_range_validation gate_time_range = {
        .min = 0,
        .max = KTIME_MAX,
    };

Tests 7d1f and 9f10 rely on KTIME_MAX being accepted. On those
architectures, cmdUnderTest would exit 0 instead of 255. verifyCmd would
then fail with EEXIST, not with the out of range error.

The cycle-time value in 8265 has the same problem. 5c47 covers the
base-time bound deterministically with -1. 8265 is the only refusal test
for the cycle-time upper bound, so on non-x86 hosts that bound would go
untested.

The preceding commit, "net/sched: act_gate: bound the cycle time and start
time arithmetic", already notes that iproute2 rewrites out of range values
through strtod().

Could 92b8 and 8265 fail on a correct kernel on arm64?

[ ... ]

> +    {
> +        "id": "7d1f",
> +        "name": "Add gate action with the maximum base time",

[ ... ]

> +        "cmdUnderTest": "$TC action add action gate base-time 9223372036854775807 sched-entry close 10000ns index 201",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC action get action gate index 201",
> +        "matchPattern": "index 201",

[Severity: Low]
This isn't a bug, but should this check the stored base-time rather than
only the index? The same question applies to "index 301" in 9f10.

Other tests in this file check the read-back value, for example "base-time
200s" in 7189, "cycle-time 200s" in a721 and "base-time 400s" in 3719.

As written, 7d1f and 9f10 would still pass if the kernel clamped, zeroed or
replaced the value. For example, tcf_gate_init() replaces a cycle-time of
0 with the cycle derived from the entries.

The commit message says:

    An entry interval of exactly 10000 ns installs and reads back with the
    interval it was given, and so do a base time and a cycle time of exactly
    KTIME_MAX.

It also claims coverage of "both ends of the cycle time range". Only the
upper bound is tested. An explicit cycle-time 0, which the preceding commit
keeps valid as "derive from entries", is not covered.

Similarly, c873 matches "interval 10us". tc prints intervals with %.3g
scaling, so any stored interval from 10000 to about 10049 ns gives the
same text. The test can't confirm that exactly 10000 ns was stored.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ACT-WEXM.v4.r0.20261124074514%40mojatatu.com
