Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089762;
	b=jtLxgpZAtRR3V8uVnjuge/Lz41kDAMmWHxbp8uJ9isbCPWPftVMtmwCkpQ8zuG/hz+xL
	 VtLGPBtKHrsFl5sVCYWtyvX4+Vj2Hpfk7IyMaffUTghT+dlURj/EIE3oOttqR6UwxH4yj
	 eTvbIOKxTPQsxY6WNRDF1ZUKfewubffWASLFvrIZ7ugzbO/R4ApX8U3tzGBRjuqWz6uQd
	 VHEccnFHxxa/dyxl/cYUSXkfFFE/eI5OLF33yAGVl7ucwOqAt7GS//LU7WtRNrLA9kgNN
	 p52N+34QRPiA0OzSoNXeU4XL7BmjfSPEbuqCUmi9OPJKdZuxrWCmzEQt3PpeUfz+WGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o4tz06DzCLHV+ZlaAK8efvWKy5+EgQA7F7usPbcqp/o=;
	b=SBRNDYbSJN1tZlIt+e4KzCrxKrqBgzRin4k3qhAq1AD54RrgkxeD8EjfBUqEGHqO2jq6
	 p6tqLjIVWSRzAFDAiyK9WRllR5hEkwVVeQ9pa+YaIbMVmL0HJZAg7gQH0tC6Y4sqAJV4x
	 1hn8tGPg04IG6rAb57sTPApeWKT/TufnlAPZJncdlT9pxyI9e1qeJvVAq8pmcH3hJgFT6
	 Jm5z/vD514UarmEYora7+C/W8bugZ0507kkQwxAJdERdim18RmxNpVlupuqUdJ9lVnQ1r
	 a37ygwoisHoOd+s+99WP9m5frd9N/PouqAwDPOO84SqMk+c/6ZelkpMsQebztDIX7yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=b6B1HkjM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF00606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF00606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=b6B1HkjM
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a594d313a3so22530b3a.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 14:16:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794089761; cv=none;
        d=google.com; s=arc-20260327;
        b=kbteM0Zv3cbcagkE8LrjI2U9KNF5vt9AzIt2WG8BHSMcMiXi8vveyLCorW7P/mvoPs
         Ai9Vwm/M3eUxQYT96Ekrz0lMvYh4ChB2K6promDEpoCDU0sklwlHNKldO1VR8gKa0GLE
         jniNCJrshwa6FeAjNN1I+uIQdSZ4nLndMnfUig5WXyh/37xuQK/HenD3oXfAUYfo7XMB
         0TwN818OGaFoNuu1NgzkZNadS37j9ygWrBKvCitpA7EDF1cKhMizzhEdHzVW8uxQyOhf
         gixoJuG4+md9bFvZpQD+EmlS/Cp+5wvX0oFuqKh6PD3ZsjziO0W5w31ixTM/Y1uwBzav
         JGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o4tz06DzCLHV+ZlaAK8efvWKy5+EgQA7F7usPbcqp/o=;
        fh=zw/sTASzbQfFQeeBshh3Lfwo3TrrSGYVWC/VpF8eUPE=;
        b=XyV5EamFP5A3Et2yqrdWFgxOkdsPyz0+B3MxYpxVa9Vpvk77frUJ23X7ykFOMLnUut
         GKOjdPb0pdzPeFT+pj8xZURuarPee35wq60ZxM8zF4QckCh47O1exh46W5u5cfRvb73w
         DvrTQGxLLBl3WUvhpeShTxL10qnq1IskDT/rIDRwe+4zM1qQGkb2zEWM9LHV+odH/Zu2
         LLsqsMQH5w+ujFgOJ32BzX4cLvmS0O78FdxuOrp8JqJqx6+rsZ8vo98Ab7da6/ksi7sU
         UqNz8pOi+sHiyEyUyXjjjeG5bmp1jcxC8AsW4kivffSQt8ATpLLJruaQ10ebQIo8wmHS
         brjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794089761; x=1794694561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4tz06DzCLHV+ZlaAK8efvWKy5+EgQA7F7usPbcqp/o=;
        b=b6B1HkjMie2eGJo3x8MJmf60WsxZxJJdti4ZsqUx0TMMxyZ79rdu3kQQc6rFk0D5sa
         ZsqXWWEVjbso/gRYe/uPyC2uwx4/Bhz6ACkkSiO7TYzk26LofQnI8avHKILhdp1oM6I+
         j6DoiWo90zQi9A6fJOjmq47PZja6MkjlMn3/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794089761; x=1794694561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4tz06DzCLHV+ZlaAK8efvWKy5+EgQA7F7usPbcqp/o=;
        b=jdX1gc1PtJQ7CbW19LXOpW7I/G+eYNp4ei+LLAsIlhcl7mw147a1b8rUUxtPoVFKqx
         hg/Eit7m1n8ClRF53mXnSNrR7Gc29/2xp95RDiKnR5CTgK2dOVR538pD3KQQIHEdM55+
         woc152aqtGk89CXYYM8G2Lzp7vDnofG0uGqqeLszzxCfBgglfhGOiUr00YcoqamS0Kuo
         4j2hSr4/zy4hHVDBn8yuHEcpC76Z3SWH+f9Pi/l1nU0aQNKCfpM4cMKfQ8dMXy0FSLl8
         gumUmnX0S8R9phFJf7TCR/scqDAbNIPEu/Vs2g6/XcnEhUG0lwprYR9R+K6RJqT3NxKp
         nTXg==
X-Forwarded-Encrypted: i=1; AL+hErE1VqS26rZLudElwu7+6qnLpw1EY+Yek4hrloT/3RJAanMhE1t2dnS9KpMxT2puz/hkxflnywg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6rOroBqiMv7/euA9itdCr247yBkJvb2x+RrejuLZ1Cr/8t75m
	6TLVPr530iBYKmXw8d0hJz7jb0Q78nFPzS2pSJkJnLNsQXV0qDk/MXLM1LSQPi1sgpvdXi1m/CZ
	JJdVEjjNdHjSX7S+I2p8c+EuMenVUZVKutw145xSz
X-Gm-Gg: AYBFou3RUDPd3JeVfSfrJuTjxnFL+H+97EmN6VN4Topya39kVuItyEcE8cG91JTNWDj
	FOsAxgkYeHIG216FwhdzMO/4m9sIY5TG/rcdKFuYRRY0XJmgJQCJU2UK3k8eXAZBDIL8EVrxAIJ
	JHHtBIs5uJZh4wSvx3JK/eLEJ79lJR/1+hCwCvKvLPrGQcxVEII695MALYAy2axL1JSnUos1bTv
	FS0iyJKqkqUgoUzkXqtxZNEBa94JQ847+UWAtNeruBptombfFAxomv/nEz7Vl4FDAxmuKgjI3rA
	InYOSDWVVS2kZdWwcBwMtC6Y40NIfg6LsXXNozJqxB9j4SaPmBSwhAuL6N6PinJQT+EwPVanj4F
	qimfJeeSfDbFzyq3fHuy1caP8YHGXUbM7ZAacXG54o1IlTSnhfbt1urmlrsphCj9dzEfdU0ss17
	rz/WbGoPQzFK7NRG0=
X-Received: by 2002:a05:6a00:3d4d:b0:8b1:3137:d78b with SMTP id
 d2e1a72fcca58-8b67082f822mr37510b3a.48.1794089761173; Sat, 07 Nov 2026
 14:16:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v3.r0.20261103064310-4@mojatatu.com> <179406302081.994134.2324214805948881495@kernel.org>
In-Reply-To: <179406302081.994134.2324214805948881495@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Nov 2026 17:15:49 -0500
X-Gm-Features: AclHuK-EImvDmozLrSXa89DezzPdIm_N3VnO1x4Pj8HHQtC5v1kgy6BRB_djrq0
Message-ID: <CAM0EoMnjMoHQ2kU01naxDT0L3JXx61uKa7XBEWSQTJ9DaUa0_w@mail.gmail.com>
Subject: Re: [PATCH net v3 4/4] selftests: tc-testing: teql: cover each attach
 rejection on its own
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 9:50=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The commit body describes the patch as a change relative to an
>   unmerged v2 posting, not as a change to the tree.
> - [Low] Both rejection cases check only that tc exits with 2 and that no
>   matching qdisc is dumped.
>

Again cosmetics - so far no reason to resend.
6a06 is added by this commit, not by a previous posting, if i resend i
would reword to state that.
The module point cannot cause a pass here - it would fail several other tes=
ts..


cheers,
jamal
> --
>
> selftests: tc-testing: teql: cover each attach rejection on its own
>
> This commit moves tdc case 124e out of the nsPlugin test namespace and
> into init_net with its own dummy device. Only the root-only check in
> teql_qdisc_init() can then refuse it. It also adds case 6a06, which
> attaches teql0 at root from the test namespace, so that only the
> namespace check can refuse that one.
>
> Link: https://lore.kernel.org/netdev/179366641863.488856.1736857159146600=
0274@kernel.org/
> Link: https://lore.kernel.org/netdev/179366641986.488856.2193313144081673=
076@kernel.org/
>
> > It no longer proves that a child attach is
> > refused as such, and the case added in the previous posting covers the
> > namespace check alone.
>
> [ ... ]
>
> > Attach a root qdisc from the test namespace in the second case, so that
> > only the namespace check can refuse that one.
>
> [Severity: Low]
> This isn't a bug, but these sentences read as if a namespace rejection
> case is already in the tree. Is that the case?
>
> Case 6a06 ("Reject TEQL attach from a different network namespace") is
> added in full by this commit. The parent commit, "net/sched: sch_teql:
> reject qdiscs from another network namespace", changes nothing under
> tools/testing/selftests/tc-testing/.
>
> The only place that says a new case is added is the v1 -> v2 and
> v2 -> v3 changelog. That text sits below the "---", so it is dropped
> when the patch is applied.
>
> Could the body say outright that this commit adds new coverage for the
> namespace rejection and moves 124e into init_net?
>
> > diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.js=
on b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> > index 0179c57104adb..ab5d0881c0070 100644
> > --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
> > +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json
>
> [ ... ]
>
> > @@ -104,7 +100,35 @@
> >          "verifyCmd": "$TC -s -j qdisc ls dev $DUMMY parent 1:1",
> >          "matchJSON": [],
> >          "teardown": [
> > -            "$TC qdisc del dev $DUMMY root handle 1:"
> > +            "$TC qdisc del dev $DUMMY root handle 1:",
> > +            "$IP link del dev $DUMMY"
> > +        ]
> > +    },
> > +    {
> > +        "id": "6a06",
> > +        "name": "Reject TEQL attach from a different network namespace=
",
>
> [ ... ]
>
> > +        "setup": [],
> > +        "cmdUnderTest": "$TC qdisc add dev $DUMMY root handle 3: teql0=
",
> > +        "expExitCode": "2",
> > +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> > +        "matchPattern": "qdisc teql0 3: root",
> > +        "matchCount": "0",
>
> [Severity: Low]
> Can this case pass even when the namespace check is not what refused
> the attach?
>
> tc exits with 2 for any netlink error. The verify step only checks that
> no teql0 qdisc shows up in the dump. Case 124e has the same weakness:
> it checks only expExitCode "2" and matchJSON [].
>
> In teql_qdisc_init(), both rejections return the same errno. Only the
> extack text tells them apart:
>
> net/sched/sch_teql.c:teql_qdisc_init() {
>     ...
>         if (sch->parent !=3D TC_H_ROOT) {
>                 NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root=
");
>                 return -EOPNOTSUPP;
>         }
>
>         if (dev_net(dev) !=3D dev_net(m->dev)) {
>                 NL_SET_ERR_MSG_MOD(extack, "teql master is in a different=
 network namespace");
>                 return -EOPNOTSUPP;
>         }
>     ...
> }
>
> The tc-testing config sets CONFIG_NET_SCH_TEQL=3Dm. Unlike the other
> sch_* modules, sch_teql.c has no MODULE_ALIAS_NET_SCH(). So the
> alias-based request_module() never autoloads it, and the lookup fails:
>
> net/sched/sch_api.c:qdisc_create() {
>     ...
>         ops =3D qdisc_lookup_ops(kind);
>         if (!ops) {
>                 err =3D -ENOENT;
>                 NL_SET_ERR_MSG(extack, "Specified qdisc kind is unknown")=
;
>                 goto err_out;
>         }
>     ...
> }
>
> When that happens, tc still exits with 2 and nothing named teql0
> appears. Both 6a06 and 124e then pass, whether or not the kernel has
> either check. That includes a kernel without the namespace fix.
>
> The module is loaded only by try_modprobe() in tdc.sh. That function
> just prints "skipping" when modprobe fails. Running tdc.py directly,
> for example with -e 6a06 or -c teql, never loads it.
>
> The commit message says "only the root-only check can refuse it" and
> "only the namespace check can refuse that one". That only holds when
> sch_teql is loaded.
>
> Would it make sense for each case to match the specific extack
> message? Another option is to fail when the teql0 kind is unavailable.
>
> The positive teql cases would fail in the same setup, so the suite as a
> whole would still show that something is wrong.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/SER-NSBD.v3.r0.20261103064310%40mojatatu.com
