Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793292473;
	b=V7cktY7QROIhG8Ps0ckFLwGkEkJDagJaPx5sTY75/kZr8oj5AXLJdfCFmC5rIcIR6jsJ
	 tez7jZv/7k8UTHvfpKSFjPsMdWTy8FLlxpRA3BdDnr7QMdg3vhQV+fF6fezG1QDnr4Vwj
	 J/rzzlNLhjjSXjjFIuLX1sPjLMsKRnFf6KZSszkzLDzZVhujGjMP5mVZ4awr9dofZW8lB
	 2+cn709xdJPF6J2jdaT8GTHLxkrh5YoQ+23y8AxI41k/5sE5ckWeiV1UPBQ5DULDp66i6
	 l7ckuAUMKMTwJDXcLRcDmVwVlcOLPYoeMIUXnnxNgiVOTrnc7vubO72ubSb3UkwwaBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Wsa/p8DFgC7lEBUBlf/AbqoCERuv8Vl8amjCmWqotBs=;
	b=NU1s8WxkbViVnHok6qD2kmAcBKQ31N8sZ2SnOQ80kP2dcouGUqfNkHkyid90m/fjRKaU
	 81hGMHmlVMQ/3FJVyGFQ/8iuEM9AVASREHjlcoDhdPPCZ2psHhMu2x1XU5i/Drbit/vh7
	 ZlL+d0kWfUnCXLJWE5f4wR1aE33i1sxFVK5J9XnOR0oV1SQbwOv60NB2XM7jJ3eMU08ar
	 N2GwHykO+YG0HytrTbRO7/Qee293C0qUm/6PCWQbozDmpVeJP8mkoEviw6kodvjVXACT+
	 Xi7hplst3vb42VoB1zuQrikwWJV2mui5uRcGNwbtw1X/NSpUlTqPHHnKJbG2R0ykK5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zsxb8QNM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC2606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DAC2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zsxb8QNM
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3303488eec.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793292472; cv=none;
        d=google.com; s=arc-20260327;
        b=mL6S9zh45IHkNhoAl1+u06tJCKEiTv9+CIRX67Fcr5L7nUPo4dqeCehU1JjRJqm1q2
         Zh46dXoQYIkD3z4QENBUXqNxZnvMu9v6thqqBGY2vOyst17p0MdsP8meFK6H+RhxXSW4
         HSCH4yLfbbKQeEy1yMDJ+ezibzJ2IPNAQqVmwjydcdkgfy8aMmTJKcCcOMFOA1S0hwqG
         Tc64AdaEalCx+/ixQPukPShjSvqqtRSP6CIuDDxgqewGxBf8QWbLC3v2vmDuAoR0O8ei
         DxdQoB/YWJwNFcdCzdu/JZtNsipGcoAiqYmR8AXclErXg+fDlR/CHW6KHSrQnipBF4+f
         +NXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wsa/p8DFgC7lEBUBlf/AbqoCERuv8Vl8amjCmWqotBs=;
        fh=Hc3Z0kF6ZMOON9fDTj3MksYBUfmsQ5FXOOPdLod41OE=;
        b=Ybnj0Hc4H4/MjAog+TFCoKGFwn92iY4YyJXmIJupjEaiGHlAT22OskyxByqWXNfT1H
         QpDJipB1JQOTAlO2OGUOgGyl5oM/4ZTiwlQMrGqFydOU05Csgf+fI8Il6ZJlnCWdEn5X
         9RziIfcBNfEeCfgWbuckaoUS0VqPeLzYWrSeBBYZ8qAuJSm+Ab8PapfvpX6miI4KHozK
         WxZHOzFHaxyPSItpHTu0/6i+vTO9LH1OXMf+ukYXHLzKnCmS/gCjNPc3QoBGK4VzYqfG
         uG5E4Nme0PKRe6iTFwHNwLtoek98vCjYWOTQUl2RMZWtxbPfoge2p+PcMZLa16jjLtJU
         x5kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292472; x=1793897272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wsa/p8DFgC7lEBUBlf/AbqoCERuv8Vl8amjCmWqotBs=;
        b=Zsxb8QNMRF7TbZyVVzF7poTES6Uf4Mv5RAyYyFpBKODDngzB10A7xejT3tAxguFeNI
         0J7i3odSR1ZZhTqMgAGoI7M9Qafico1lRSDXvuVO1uPrri83kPCtvF/Ra5MsLyGQ8PZx
         uUzKJ93blfRoILI8X5WHty1tZFeBsDb09p6wrermm94tSC+lElC/BdYbff178ZM0hfdd
         NcV1NVNyy/Os9liOfD1sbfch5D670W4lEeWIxuVCe3hqOPboj2iWHGUEtIGAqhHI+uQT
         xHOIVSUFi5/ny/bKPcNN8Y7waCaeQgDFEuFnGsgYUtz7Zwlf1024la9jhUS2cbDs6o3X
         puXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292472; x=1793897272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wsa/p8DFgC7lEBUBlf/AbqoCERuv8Vl8amjCmWqotBs=;
        b=fy1izRByXDS1zPtk/TRgKMhANOFZ/F2J5XZUY+g6RluZqszy8+4Wf2XH4zhk+iynQj
         wkrJr3ztbgHqqY6jVasrm3/BjIIZFARnh/HCi7DMZfDEEjlAT407Ftj9lZrk3vnjt4p8
         ULLhZ/ck9lW34Fs7HfuKcs4V2XxycB4etIN6r+DRgIn+X2rtNTUNRQmibTajx51YOEdf
         zizjJKfRGwmSUIKPwy2iw0koGujqgH7qD0feQAv/LhZCG8v/DkZTsBt0tREQEldelMqP
         gvsovsZyNCc5/dYW4aBVFiXmJbJKOiDLbPR0YiW4Y8AuMPKI0JLk7isIWddEHiVQo6Qg
         7pQw==
X-Forwarded-Encrypted: i=1; AKwUvByr02G0SdlMKLI0xrzM0A0MEJv03SgtveIgRe/9Wqm+3azDzBg9MXuo2S4hotxKk59ncBH4UA0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKL8NHcz4O6At1eO9bu+WU2AJ06ggO1N8SOhLMwyycW32ySZPW4
	tBhPkyEXqJ0PQAmOCkVWOicF98sX9F+Yn6s1ZMlEqyOOQ2oPYZutRwnUhOSdaHyKqPLL3mLUDkT
	tnb3Cy8yA6SiCSltxsnuvOMgRY6AIMGw=
X-Gm-Gg: AYBFou3qxwhxonSyPIhUZfBVnUTxU98fnJpRbrOg8Pkrk63agYuZtyACfc0u8TD0kCW
	8E6oyTj18VeBr4mFskwwRO2+6KH5p5/Dc2iKjQkTBTYIZ+vcCme24tQ2whDQ0Ceploz0YGb4SvC
	E9/GxQwEHnttB5Z9dLWGE6zqnrtxQQMV6o8nUoJg1JMzHBTUyCy2aUZbECKCqM7koexORmq4J9c
	GkvDVT8eWtj4HKtiFeZZqynLrFhLukgC4qlJd6puZhxzOXVgxpfiShm+iXXSM1xkqYW9ZxL0A9k
	tbtPqSiqU3nLhY87NJRMvPDptSH2wbfjzZgrmWGglr9w185zevGEiU+CJqseF6iyrinJuBgIlTq
	qHMPSqc5P/ANClHf+EfcRihmyvCBwe7gIesBgiQXbNbMl6eIR2ega0RKZL/sAX6n3nQBB
X-Received: by 2002:a05:7301:b09:b0:360:d4c5:7243 with SMTP id
 5a478bee46e88-36a2002d2cfmr7315065eec.11.1793292472441; Thu, 29 Oct 2026
 09:47:52 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029163516.2476127-1-hj351016@gmail.com> <179329193445.3327.7941488029152521409@kernel.org>
In-Reply-To: <179329193445.3327.7941488029152521409@kernel.org>
From: khj <hj351016@gmail.com>
Date: Fri, 30 Oct 2026 01:47:40 +0900
X-Gm-Features: AclHuK9K2vGmM-fNk5B8yoexTttxMSeGYWaivwlu1Nvp0CqoGWr9xKVGgD1Q_5U
Message-ID: <CAGr5VtPUE-gdEGDAnjuGvz1Pj1ROtKTavPYEPZFJXwtngVVEeA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: em_ipt: reject hook values >= NF_INET_NUMHOOKS
To: netdev-bot+sinfo@kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks. The issue was found by static analysis: a small checker that flags
values read from netlink attributes (nla_get_u8/u16/u32) that are then used
as a shift count without a range check. em_ipt's TCA_EM_IPT_HOOK was flagge=
d
because it has no nla_policy bound and only the "policy" match validates th=
e
hook, while the "addrtype" match does not. I then confirmed it at runtime
with UBSAN using the reproducer described in the commit message (a basic
classifier with an em_ipt "addrtype" ematch and TCA_EM_IPT_HOOK =3D 32).

Thanks,
Hyunjung Ko

2026=EB=85=84 10=EC=9B=94 30=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:38, =
<netdev-bot+sinfo@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
