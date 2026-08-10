Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AB37C10A
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405107; cv=pass; b=pxdhGsc6PN03yDffRTgIdnnuySZ3C9Ut+07mq2wcNvVs3pNKJ/h0LhUZsXn7PX2oXStMEo9a+zV8WdqLT50+YEnyg/hiKpd+Tkd3BN8OQDHYaCpDik+kQDRdhUOVW+sq0DAWcp+FRzSVObjyx/hR/2W7XrQOLp64gGxmr5ZcXMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405107; c=relaxed/simple;
	bh=ySUZD1MU8HSAeliu7NtEMdF+A1JeUiTt8XsoErOsdUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyB11GpfmXmj0xQ1Q/kZj8klbh6fc/8CmT+BOSggWtQT/C+4l9PHps0x3OdMRZezZmQdsBQt5i7h4hTAr+ZIjbe5jN6ifLM8Zg/Yp5RmcGdmcBaWEzIBkWPe8gfNccKz+G6yz3snfYBGkhqHb/a8ipPEPryoC5aj9TPEmpNERPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YARckK17; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YARckK17"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c3fabe908eso69249e0c.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786405105; cv=none;
        d=google.com; s=arc-20260327;
        b=S3DBl/ehw5o1fBHDWScfB/QxgAlRAP6BkkjJoVPmEwsuGAFzxi82bX+dnoh7+wxaDt
         SlVmD7d8b7rBy7NbVJfCUM+SY8Uzvqtd4B39kbvRDeNyA3jNgLAtZ7tOCAncag3Acs05
         zmkOoGOcIHBdSXRE/plc75L4o5PUHX8uzm90UxqlV0bKkRCv0cjXJwi/bUwML0CYKp7i
         Ggaxwxwj6wZIgYKZjtFv6bK1tzH0YcaMDJx7ES9wTK42CwFofbLpHGzYhhmgynFsDDn4
         O0UlyzSh5gDbmMgSW02tNrtMjxztfzChHTJ6tClfZg16i8j5/ceg2Yy3f2olrFQ/osf7
         jFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ySUZD1MU8HSAeliu7NtEMdF+A1JeUiTt8XsoErOsdUE=;
        fh=B2oPJthJjnWT76LRIZK2PHVQenEqsXSJ3R8pI4RpQmM=;
        b=MIvGNmvVpjQRyOMh60LzOkwb0cjR/kN35AJETKzVeTHk6ArLg41TKlZQKVGNrhhrD8
         QcU3kJ8wl56cT/BjIHSQWkKxp81hyUOuOqUKIuI73v+Pjb7weaRWEapX0tOPxpwHd954
         7PFw2dUUldoV8SEpSa3nFBCWUWYzmIUl+McNwXCIxO10IEV1mN5187UBd6cNFhmiBmCj
         UdL3uXVSRsfTtBgSL4Dt9Fqx6pj9aw66M7upBFJN+rQA4RqF6hpQRlZX6pHmgcOFarGK
         bacsOEU/afZOpbUP//L64DUd9JT2rW9KzsCveOdU89t9IEKRjarECHJascROpgI8n+Qi
         t4Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786405105; x=1787009905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ySUZD1MU8HSAeliu7NtEMdF+A1JeUiTt8XsoErOsdUE=;
        b=YARckK17fuX8oAp38X+Xzi944NoTRU9eeGotJ1W0eJT0Nehit+nCgi2gXUCO6LxCYh
         B+sdWS/5jQK7C/DUZD2RBV2O+l1JauXChBy2gvdFvIPjs3cDvoEfDo3xKELhsxYiyh3G
         1Cvoo/WItQfeZ6u0DswgOl7zQl3ZlThID1GWepWbTjCp5WdLbVuiHxTnEDz/L8zTZKVD
         IR2gi3Xfz5q6zKSVyTiMrwTvbgsef9miYWdcBLZ27eQ6Klm05RCY8teH+hoCsmCLnDRW
         JB2NToKi4NYGXQweuRWOrC6gr0bpxVjm+XhKncW6T50BjYCi2g4IAFQHG1IwMdXtNaCp
         286g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786405105; x=1787009905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ySUZD1MU8HSAeliu7NtEMdF+A1JeUiTt8XsoErOsdUE=;
        b=h1RjJmvy3CROIvUibl9Ya+aw0QB6AJZkTxJqjwyXP3bUQjGdgk4cHhoSnhfq/rYHIQ
         ffrhdUGmaQPV3fPTB06lEewWt4SpF5TX0Zpk8P8yYU3ySpuXkBgs7199rLROIH1zbzDW
         CBNNXtW6QrnXUBPji3AQRMSdWHPILkhgqnxHiMS4a+paObm+3Pbuv3SPKbwgirKLy/s0
         8R7R9vrWvoqtsWLwwrtXJARvmGlH19taCWUh+GgiZAi1xIX4/QRXDZ6QL3bwn7bjRHae
         nraLaq3D4R7EtNP38OB+Gw3tK8t4OeJgJOKmvdy7CPVCL4nMXaqB9+vtogrTEpubBr6n
         b0uQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxuY51J6wNW+tLPpAAnsBuc36iWqo83ak+yQpJTLGfraZj/oLtjiIJ7u3CEdJwZWdjvARfTk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxj2+HiZq0IN0+46MjjY5EEyP9fRnSJgFPMLiYW88EbER5xIi+
	EEqJOU3G5w9tOxdZD//vAoGbkg0qq1YjQTd5ocytPQGCo72hnSlnRpWqHhIeTOoYramviwIJOLj
	OVoY6jw/I12Gn2av2Al077lLt9s48gLmocWDJVmU=
X-Gm-Gg: AR+sD13o/1GsJhkckArFngJ2/ENMGmH31QIkZehX34ORKDtRtoWTfM8Gks4ufqzp4Nq
	AgiLRxfFupmwX/Bt2zHPNO4kgbpychb/7ddxqWJ5yKsXUqn8LjTUKv/Qksl4ToLbjsJoQogr6g1
	0ah7rLzpCBgpdSp/fDc7o97qkrCbHvypmWc7SjPn3WA2KecusE1mvNy4GUbatpFHDsQ/kVkfMbK
	w4tyCHj7QFCSsSoIbClVhcxdB4HPxlvT9bn6IwiQxpyRq9Tq3CfbaUsaxZ2x+pqXQVeE5GyC97B
	M1MUoohnAg0NCIkCV2Jn+iXKjKsjoGt8vqfHTs/28UxSy6v6mtifCHGuBDAieShW17PWaJPdpRY
	yr7b28AWVurgbBxt35YETwKFgO7+mBR5RpXjK6MoxUNjJ481kM+QONsJUSvzn5+3V2HeVUt5Xkb
	Qwp2I0Fm7O
X-Received: by 2002:a05:6102:2926:b0:747:4d96:dbb5 with SMTP id
 ada2fe7eead31-760e8b29c2amr9949833137.12.1786405104700; Mon, 10 Aug 2026
 16:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324100126.3502-1-willymontaz@gmail.com> <20260415211149.2658910-1-jstultz@google.com>
 <anksxhdkYBfcpJmN@linux.dev> <20260810073830.GC1642880@noisy.programming.kicks-ass.net>
 <anpfJp_tuKDuePJM@linux.dev>
In-Reply-To: <anpfJp_tuKDuePJM@linux.dev>
From: John Stultz <jstultz@google.com>
Date: Mon, 10 Aug 2026 16:38:12 -0700
X-Gm-Features: AUfX_mx5irUOUIux26U1depQ0ac0NzNGqqyP9MugYw6ATi_RYrU6r-0HU3Bg0FQ
Message-ID: <CANDhNCpuhucTAnG7fcX=Ts-nz32QPyRHbh1QYkt=JZ1QXEv_Dw@mail.gmail.com>
Subject: Re: [PATCH 6.18] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix
 EEVDF entity placement bug causing scheduling lag")
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Janne Huttunen <janne.huttunen@nokia.com>, 
	Zicheng Qu <quzicheng@huawei.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	William Montaz <willymontaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 4:32=E2=80=AFPM Jose Fernandez (Anthropic)
<jose.fernandez@linux.dev> wrote:
>
> On Mon, Aug 10, 2026 at 09:38:30AM +0200, Peter Zijlstra wrote:
> > Yeah, this should be fine without 4823725d9d1d.
>
> One heads up, our review tooling caught this after I sent the
> Tested-by. The revert was written after commit 80390ead2080
> ("sched/fair: Separate se->vlag from se->vprot") took vlag and vprot
> out of their union, and 6.18 still has the union. Without that split
> first, the rel_vprot path in the new reweight_entity() scales vlag
> twice and curr's vruntime comes out wrong.

Indeed! I was looking earlier today as I had some foggy memory of an
issue the backport caused in our android17-6.18 tree, but couldn't
find it right off!

Since we were KABI frozen in the android tree, we used the following
patch to work around it: https://r.android.com/4103883

But then reverted that and cherry-picked 80390ead2080 ("UPSTREAM:
sched/fair: Separate se->vlag from se->vprot") for the KABI thaw.

Thanks for noticing and reminding me of this!

thanks
-john
