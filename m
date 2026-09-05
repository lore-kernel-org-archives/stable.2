Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B137F32C;
	Sat,  5 Sep 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570610; cv=none; b=C6RK7eyYd2suiRapEctU6gGHEqksNZhudi9zQFDNuW4Dzg5F8wC4PiLFZenbIxtuxYz+GCx4z1rHqZtTeKK3iOkcX3DmHbBpIYLnYS3hnSNjNSEmvyWRTryAO0RDGsuIK+EBTz1Ur5skSMZJRzeIbzrGet8J3+cL9j+PRK4fGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570610; c=relaxed/simple;
	bh=eUruOtOTneF7ou4f43Fl9QPjrMNnsUsOdXcgarR+4v0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZZXK5O61kBv3fk72sYisBLBOlrmmPPWFavgnonXlGD9QH7JA2iJmFAoEEzwUHBfglc+y80p7V3p6y64n4oyldPirpnpZPNu7aNaEsjc8QU9WIaQqZuuPeBsUTx9Vvlhnqz1fs3VeweK3SM4pEjZhdR9Icfw2A5Ud+fID2Emu2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEtNbaZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEtNbaZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50A01F00A3F;
	Sat,  5 Sep 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570608;
	bh=9ZBNFpaM61+9vTWcA+kKgXWw6S4w2OopXe2TAysmpHk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kEtNbaZ+6+pigzGUh4xQkncRg5sH0Vhb3WCdK2De3aO21t1CxU1y+tDeFntuHtfYK
	 LBDy0ZDzQtiU6TW8j/9tC65UNd70nbgTM1z+ldeha7nOne7gyVAVaaW1Q55DFp2NiZ
	 1dFatAdXm25xJ12svZiA76RryS0/d7+daj1Hv6mpgat0YVaS60+N3UkPcGAYa3ROY5
	 aEdx3n8PbDKakHSZfg4nBZjjvR4t7iOy3JnXr0VgI7FSThg/W0NjeXT0fOAL47Nmq6
	 dhHLct8bZi3Sb5MM2GQBzfER/OVtqlgc7o9c6IckANIdFT6Ql96O7okrVs0M9AWHTC
	 A4AEJWW8rROwQ==
Subject: Re: [PATCH net v2 3/3] selftests: tc-testing: add tx_queue_len cap
 regression tests
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, xiyou.wangcong@gmail.com,
 shuah@kernel.org, vega@nebusec.ai, victor@mojatatu.com
Date: Sat, 05 Sep 2026 01:10:07 +0000
Message-ID: <178857060731.219967.9527303857857135943@kernel.org>
In-Reply-To: <QDISC-2899.v2.20260901233641@mojatatu.com.3>
References: <QDISC-2899.v2.20260901233641@mojatatu.com.3>
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

- [Medium] The three new negative-creation cases (57ab, e777, 31ac) in
  tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json…
- [Low] The commit message's veth topology/teardown explanation does not
  match test b567 (pfifo_fast.json:283-312).

--

selftests: tc-testing: add tx_queue_len cap regression tests

This adds nine tdc cases to the pfifo_fast suite covering the S16_MAX
tx_queue_len cap: netlink set/create boundary pairs, two sysfs writes, and
two veth peer-nest cases. A couple of questions on the new verify stages
and on the namespace description in the changelog.

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
> index 30da27fe8806..a6e25e76ecb1 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
> @@ -105,5 +105,209 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY handle 1: root"
>          ]
> +    },

[ ... dbe3, b50e, 40f8, 4b6e, b90d snipped ... ]

> +    {
> +        "id": "57ab",
> +        "name": "Reject creating device with tx_queue_len above S16_MAX (32768)",
[ ... ]
> +        "cmdUnderTest": "$IP link add dev $DUMMY txqueuelen 32768 type dummy",
> +        "expExitCode": "2",
> +        "verifyCmd": "$IP -o link show",
> +        "matchPattern": "^[0-9]+: $DUMMY",
> +        "matchCount": "0",
> +        "teardown": []
> +    },

[Severity: Medium]
Can this matchPattern ever match anything?  tdc expands NAMES keywords only
in commands: exec_cmd() runs replace_keywords() on the command string, and
nsPlugin's SubPlugin._replace_keywords() is likewise applied to commands
only.  The verify stage compiles the pattern verbatim:

tools/testing/selftests/tc-testing/tdc.py:run_one_test() {
    ...
        match_pattern = re.compile(
            str(tidx["matchPattern"]), re.DOTALL | re.MULTILINE)
        match_index = re.findall(match_pattern, procout)
        if len(match_index) != int(tidx["matchCount"]):
    ...
}

So "$DUMMY" is not substituted, and in a Python regex the "$" is a
zero-width end-of-line assertion, meaning "^[0-9]+: $DUMMY" requires the
literal text "DUMMY" to appear after an end-of-line position.  findall()
then always returns [], and matchCount "0" is satisfied unconditionally -
including on a kernel that happily created the oversized-qlen device.

The same pattern appears in e777 ("^[0-9]+: $DUMMY") and in 31ac
("^[0-9]+: $DEV1"), so all three negative-creation cases are checked by
expExitCode alone.

That seems to conflict with this part of the changelog:

    The three negative-creation verifies assert device absence
    ("ip -o link show" must not contain the device), not merely absence
    of a qlen pattern - the device does not exist when creation fails, so
    the exit code carries the signal and the verify adds content.

A grep for a "$VAR" inside "matchPattern" across
tools/testing/selftests/tc-testing/tc-tests hits only these three new
lines, so it does not look like an existing idiom either.

Would moving the absence check into verifyCmd (where substitution does
happen, e.g. "$IP -o link show dev $DUMMY"), or using a literal device name
in the pattern, work better here?  Alternatively tdc.py could be extended
to expand NAMES in matchPattern.

> +    {
> +        "id": "e777",
> +        "name": "Reject creating device with oversized tx_queue_len (500000)",
[ ... ]
> +        "cmdUnderTest": "$IP link add dev $DUMMY txqueuelen 500000 type dummy",
> +        "expExitCode": "2",
> +        "verifyCmd": "$IP -o link show",
> +        "matchPattern": "^[0-9]+: $DUMMY",
> +        "matchCount": "0",
> +        "teardown": []
> +    },
> +    {
> +        "id": "31ac",
> +        "name": "Reject veth peer nest tx_queue_len above S16_MAX at create",
[ ... ]
> +        "cmdUnderTest": "$IP link add dev $DEV1 type veth peer name $DEV0 txqueuelen 500000",
> +        "expExitCode": "2",
> +        "verifyCmd": "$IP -o link show",
> +        "matchPattern": "^[0-9]+: $DEV1",
> +        "matchCount": "0",
> +        "teardown": []
> +    },
> +    {
> +        "id": "b567",
> +        "name": "Accept veth peer nest tx_queue_len within S16_MAX",
[ ... ]
> +        "setup": [
> +            [
> +                "$IP link del dev $DEV1",
> +                0,
> +                1
> +            ]
> +        ],
> +        "cmdUnderTest": "$IP link add dev $DEV1 txqueuelen 100 type veth peer name $DEV0 txqueuelen 200",
> +        "expExitCode": "0",
> +        "verifyCmd": "$IP link show",
> +        "matchPattern": "qlen (100|200)$",
> +        "matchCount": "2",
> +        "teardown": [
> +            [
> +                "$IP link del dev $DEV0",
> +                0,
> +                1
> +            ]
> +        ]
>      }
>  ]

[Severity: Low]
Is the namespace description in the changelog accurate for b567?  The
message says:

    Test commands run inside the netns, but nsPlugin creates the veth
    peer in the root namespace, so the teardown deletes the in-ns end
    only; deleting the peer via the pair is implicit.

and the changelog notes:

    drop the no-op "$IP link del dev $DEV0" teardown (peer lives in
    the root namespace; deleting $DEV1 removes the pair)

The plugin-created pair does span namespaces:

tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py:_nl_ns_create() {
    ...
    ip.link('add', ifname=dev1, kind='veth',
            peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
    ...
}

But b567's setup deletes $DEV1 first, which removes that original pair
including the root-namespace $DEV0, and its cmdUnderTest recreates both
ends.  That command runs inside the test netns:

tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py:adjust_command() {
    ...
    if stage == 'setup' or stage == 'execute' or stage == 'verify' or stage == 'teardown':
        cmdlist.insert(0, self.args.NAMES['NS'])
        cmdlist.insert(0, 'exec')
        cmdlist.insert(0, 'netns')
        cmdlist.insert(0, self.args.NAMES['IP'])
    ...
}

so both new ends live in the test namespace, and b567's teardown is
"$IP link del dev $DEV0" - the very command the changelog says was dropped
as a no-op, deleting the in-ns peer rather than $DEV1.  Functionally this
still tears the pair down; could the message be adjusted to match what the
test actually sets up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-2899.v2.20260901233641%40mojatatu.com
