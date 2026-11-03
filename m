Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666421;
	b=XZ2pT4j1sKxQMn0wiSwpzNw/fFXuGZ2GRdta+2WilQfiCliKZGTrIDcriwPc1nPhePka
	 3K3z0gKEez8c+AfWbBw6F+x6H8ZknXXu+Bmo6oMHhnIOKsfLWLyo0aumLQKoMDcU+rLkd
	 99zAzaV/CfgwlpydYjrsKSKPviI5kA7Bsrhwx2as3hl4d2si5lg3wWE6WEUTZawM4of08
	 VQNNZLui0EoTYUTqukUFJ2VFizzx0Q9NyI3YjkUUQEdImc6U0BFiuBql/fjJ41TMfLZk8
	 cXfyPFJCF8fD84MaEpaBlQQLeiIXYsANCpMmXJa1xoBJ0p8pJh7T7JpzChg3EWr9qfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666421;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=v0aMFs+uYU1dRRWuw0ENsVLlEhciR4yXakm5065aNlE=;
	b=j3EV4gCMyrgqC9IaYMekxvNuMLHzgZVAbBxZzE3ZKa2tjLelDvJ6au27HMt25hjfnNNo
	 xQh6RiogX5Kc5KVcUZQXmuP6z+44Y3MHvrfG9D9wnPDiGAUQ0+RzMhQRWAT0s/tnoc0IC
	 P+G3JIomfLXrDWP+L6Baj2NsdARH7Y9XcEOlA040fY+TgSpBIQfv1SM2jn6nzzGotqHxM
	 3uExqGSc/FuUi2gjQMiul/h/drX9rvaULqmHQ9imBOtXqOmmk8MuAUfxWh+8A5vGz0DCw
	 PIwGuO8boSbSgeu9xTemJL2WJusxIjexNTYQVBJHtEudJ/lo/1fFrlgPna9MH92++zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7J2EXsy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEAE606A329;
	Tue,  3 Nov 2026 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7J2EXsy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7C11F00919;
	Tue,  3 Nov 2026 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793666420;
	bh=v0aMFs+uYU1dRRWuw0ENsVLlEhciR4yXakm5065aNlE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=a7J2EXsyHnLmsHC32GrrO6wqnRvmIaD6BL0hS4RJeDO3KpRBh9UhCOOTv867gu/m3
	 d9O2p8n7Ojm8f1G3EELGOI97igfQTEbNQGGQ8j9NIGJ5i+8hjwsBM1hTCSJbyLElz8
	 mif455ZY+9+VUJJSfUh7sr5kvAwLibA7ES1euNqE0xjX27FkuHoRDnayAHYPx35ntz
	 p0piMOIRceyWYSnd8sMFUIxQmjPg8SCIvKaOt1Jxnj5iUEUoFgmGZ2CEtn7HadW+8O
	 nZ93PBS4BC+WOGhwsJ72ODyasaNmxqdrfXuQ3/3b+SHtFs8SufaxzyVI4x4lcZ72dh
	 uuHHfpwPNCpWw==
Subject: Re: [PATCH net v2 4/4] selftests: tc-testing: teql: reject attach
 from another netns
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com,
 thomas.goff@boeing.com
Date: Tue, 03 Nov 2026 00:40:19 +0000
Message-ID: <179366641986.488856.2193313144081673076@kernel.org>
In-Reply-To: <SER-NSBD.v2.r0.20261101171325-4@mojatatu.com>
References: <SER-NSBD.v2.r0.20261101171325-4@mojatatu.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Test 124e ("Try to add teql as a child qdisc",
  tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json) no…

--

selftests: tc-testing: teql: reject attach from another netns

This commit adds tdc case 6a06 to teql.json. The case attaches a root
teql0 qdisc from the nsPlugin test namespace and expects the attach to
be refused, because the teql0 master is registered in init_net.

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> index 0179c57104adb..3df315629d2fc 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> @@ -106,5 +106,32 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY root handle 1:"
>          ]
> +    },
> +    {
> +        "id": "6a06",
> +        "name": "Reject TEQL attach from a different network namespace",
> +        "category": [
> +            "qdisc",
> +            "teql"
> +        ],
> +        "plugins": {
> +            "requires": [
> +                "nsPlugin"
> +            ]
> +        },
> +        "setup": [],
> +        "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 3: teql0",
> +        "expExitCode": "2",

[Severity: Medium]
This case isolates the namespace check. Is the root-only check in
teql_qdisc_init() still tested on its own anywhere?

The commit message says:

    Without a case of its own, a later reordering can make the
    namespace check answer 124e and leave the root check untested.

Case 124e ("Try to add teql as a child qdisc") also requires nsPlugin.
_ipr2_ns_create_cmds() in nsPlugin.py moves $DUMMY into the test netns:

    cmds.append(self._replace_keywords('link set $DUMMY netns {}'.format(ns)))

So the child attach in 124e:

    "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:1 handle 2:1 teql0",
    "expExitCode": "2",

fails both of these checks in net/sched/sch_teql.c:teql_qdisc_init(),
and both return the same errno:

    if (sch->parent != TC_H_ROOT) {
        NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root");
        return -EOPNOTSUPP;
    }

    if (dev_net(dev) != dev_net(m->dev)) {
        NL_SET_ERR_MSG_MOD(extack, "teql master is in a different network namespace");
        return -EOPNOTSUPP;
    }

If the sch->parent != TC_H_ROOT check were removed or broken, the netns
check would still refuse 124e's attach. tc would still exit 2,
matchJSON would still be empty, and 124e would still pass.

After this patch, does any case in teql.json fail if the root-only
check is removed?

One option is a child-attach case that does not use nsPlugin and
creates $DUMMY in init_net, the way 84a0 and 7734 do. Then only the
root check could refuse the attach.

> +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> +        "matchPattern": "qdisc teql0 3: root",
> +        "matchCount": "0",

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SER-NSBD.v2.r0.20261101171325%40mojatatu.com
