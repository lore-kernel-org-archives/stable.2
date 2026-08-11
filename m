Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B534A3BF
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445026; cv=pass; b=o/e2+NbVEyDSqM/weI76siZWfMdTQj+geluWhYcVpkEMX8n8JIArYCmy5wl2M8KQ3k7rzHE9569h4Xlm9c0scG081Kqmoc37R27DkqhMT+i0qXCSAyjT+8NFwbUf92fnRxnB3IeOzkcJn1fC7zDLqz1ZVLnfFIGMwJvDSjBLfuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445026; c=relaxed/simple;
	bh=1Oc64gMDjytZEdqM1LZNVQuclN2jmmuxKaJUiRRW3Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON5Vaescg0LxrqxtUn5CN8hJz8gEwWBd3J05nGgnof6M11GpzaTSZsTkanscHtmJjwekzAd1ozcHb9Av/QO3ak5lbu+GdLeMgib3q+MlycXzrxV08mK6Nm9OavIb58ZecI16y8TcipncV2EfhLfQPvcT5XVrm+O6Dp7Xr+8nSQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mz8bpy7S; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mz8bpy7S"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2dcede83so3764353b3a.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786445025; cv=none;
        d=google.com; s=arc-20260327;
        b=jkFBEZZkK/hdwjZfSO/nJ+hv6+oK9qpupCt1wguoCETNZNQQd9cpKCRJay2ZmrIDYv
         uot8qnnQnEiVdPO0Ppd58/b6ymgwzWpwGeDLqMrYLplSbcbDHUxoJA8fR1Mzn36oE6M6
         13oRSod5L49ZAnoUDXBrWZT2A0+nKWR3bN5J/upyiFAFhCm9Dt5Q/r2/f9l9W/rpCj49
         ibwQ4lIPWISMY2AHjTyAFgCUMVa15u4gvXkNZLxxAg497ZZ8Wjy3A3FlMeEIDTZQRF5u
         CSTqrSsP4gPx5FEYADVxmEWN5neXv2u5/oJyBcsYug9VfuD0fWCpuoqY4ZyRZwV8ld7R
         THog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jtu1Ubp/zj233v+Jp8kdhsOBzGvcYsZCYr6r+QiZAfE=;
        fh=ZC7nyE6lrVAUsuVXvFHY5y+MchwjUT0IGLn4qCvtOdk=;
        b=Zax6jW4uN5PmdLRY8Ec5dEEpB24pullCKJZes3kJz0U62DBAXDZ+cd6BwSdY3H3pJQ
         Wko2RE8slv4H/N2QXPkcIZ1gPjdI/Oq4TDtE3szqwfJ1Cxn3IYvjxE4F575HrEJ4poCf
         7Wqq6SrRcvsb2NaKoGOtteHB+E3GkE/YCS4HqkYYutbAjJ8Sr4QQmbiRDCn9nuElxE9t
         Dn3WI5ooNdYr5NDmoB234qjJHT51eM+GdGtXjplqNkebcvbwOc4WpgYEpZmA6nctDYvz
         ND8EhnCNyEo3DDwGUnL44svu7XjRDDIKhSAToduF3gGukTLAZoCYnR2HVG9smzejUybA
         FGFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786445025; x=1787049825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jtu1Ubp/zj233v+Jp8kdhsOBzGvcYsZCYr6r+QiZAfE=;
        b=mz8bpy7SQ/BawkPlsDftz+2e1doFV35K+D+Vc2MiDjWCSLqR2dfIT/IWlbvozBxblb
         Q/MSMkKZcmGpYOWCTG8kYilRNXYfKRYhGf8k2/2rlnbly+reXVERdR1fNwPxKduiVjJg
         XsiIayyn4lBlmiG0hXSxmdaXtJERTVZLI1H9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786445025; x=1787049825;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jtu1Ubp/zj233v+Jp8kdhsOBzGvcYsZCYr6r+QiZAfE=;
        b=pWKzVJ0kMvnqrjYKDiAcdkQqJhWkwNMrinjVKtHXvXwyeZVG+90HjAtNucl3d/OcK/
         Kv7xzwPlSvqTcsybp6fr9BnxoxhYPriaU+T2sUaEEuouyJ3upRnKBX++IP8KCvDvr/5g
         WJ+e5aVkFQXqaOmL1jc5qSs4jAh+M9rjPtwxNnBwFTYQapIrr4/tDhFSDxRqAd6M3ayy
         9bYyL2WHHJ/EwFMgpqrCxcsHpdWtd/hziywcJAYE39et/v1uMETfJBKWrtWufdIyq0LY
         QPfA5kvnmKhnDxKwmsAY6a7TpYiJde7gI1MMouKGFTyC94NEpavbjkCSEWhyHnctIXdO
         y0gg==
X-Forwarded-Encrypted: i=1; AHgh+Rqv/9QH003SNeWRo9h7KcfEYElGh8SvAjouqPq2wmPd+ajU1uPRKg3EnsMc3U1IsOXmpbwcwtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvrA6L3RTy0SPlcalGctV17lG7ju4UAChZDbXvLLURv8mvUas
	aVqcQ7v1iNa1HupW0A8fTcm7GRIpPY49eHU4bsNvCtslECvjKWTVVLiLDpt/E4EFoIZEMTpxf4D
	jaF2lWgcKYnu4NsoEh0EVk01XG8LihGE4+xoE8Kk0
X-Gm-Gg: AR+sD13f2mFvAzZpO4Lldr09KxrHIQbcTe4QRaeCYEWZ576E+UIwBqKbFIWrFz+kvCZ
	vGo9aIOZmv0YcTb24o/m5ZAMnD6tw2d4E7rak3Spz5XRO2rRIK3XfbJE9i865Q4//HUNIrrHnBN
	VDzjRpsHiRDTlI4HZROlmJ2Ch6o2zQAOyr4UDy2s/a3N5rT/j5gmvQ/VZTt0HZ2F3Utg4JrqKiE
	yNNHIwNkj5HzAPgYmxx7G6ch8KA1wjqg/OxySa0fxDcpgKIZdsRNuwHnaM79PyRPNuUT/KCCOXp
	j6vrSSArI851/6Sk/3hD7vbfJf76dEyPPLTJnq49ReVAbQ4YGMLtlN3A
X-Received: by 2002:a05:6a00:6ca7:b0:848:50a5:a70b with SMTP id
 d2e1a72fcca58-84fa8835fa0mr2386611b3a.21.1786445024406; Tue, 11 Aug 2026
 03:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809090928.868186-1-jhs@mojatatu.com> <20260810164536.6ecf043d@kernel.org>
In-Reply-To: <20260810164536.6ecf043d@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Aug 2026 06:43:32 -0400
X-Gm-Features: AUfX_mxBhfFT9uL0lPa7nUNDw1KGFEjh2WkLkpdbKzuwbsC0f1NhAk7n4JjYmS4
Message-ID: <CAM0EoMmQi03B+t8MyUsXp6-QOcOWRJvbji2etp9jjV1gU5V=XQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on a->goto_chain
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  9 Aug 2026 05:09:28 -0400 Jamal Hadi Salim wrote:
> > tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
> > rcu_access_pointer(a->goto_chain) and then calling
> > tcf_action_goto_chain_exec(), which does a second, independent
> > rcu_dereference_bh(a->goto_chain) read and immediately dereferences
> > chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the ga=
ct
> > replace path) can clear a->goto_chain between the two reads, so the sec=
ond
> > read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.
>
> FWIW *shiko suggests another tweak but looks orthogonal, LMK if you
> disagree:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809090928.868186=
-1-jhs@mojatatu.com
>
> (the patch is "too fresh" for me to apply right now anyway)

The concern is valid but pre-existing and orthogonal to this patch
(and a lot less severe than the posted fix)
I had this discussion with Paolo: When the sashikos raise a concern on
"pre-existing" issues, what should be the reaction?
In general the conclusion was to follow up later if worth it; however,
sometimes we need to make a judgement call - if the pointed to issue
is serious (and yes, the AI bots are now reading what Sashikos are
saying  and constructing bug reports) then a v2 is needed.
In this case, I was planning to follow up. I will start more actively
looking at sashiko reports and analyzing if worth a followup or a v2.
I dont know how to do these pw signals, but in case i see it as "needs
v2" it won't be worth waiting for one of you guys to comment.

Do we need a written policy somewhere?

cheers,
jamal
