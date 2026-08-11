Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC33B0AD6;
	Tue, 11 Aug 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462329; cv=none; b=MDoTFkJQktOPmPn4FsHzGdbQJwur3uVOedMRmOnK5ohpIrL5b8DviLl7HnQCm9KqWgiVgSuwnKZ0Le5V2zfcmKkPukYc4i+OS6j5MtdCxeIEA5jcrR5Ln3JKszV5SHxnHt2fKymrqHM7HVWAKxUU9pbhq4L4avX7afgX4VT3nhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462329; c=relaxed/simple;
	bh=W6fSy8G8L1U2PQct4KEFXdz9bO6foOzFsDSTa+e8acw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2167620uzW/wysPPTblJRbrWquUY4TZpvQQ5qKtT7VPUpc2i+rR6mWIPwbFEauf87lGwmYvzbxrdbgxjNXfRd68etPADua+rbffO37TythfTowRzhJGKm60qUIkHszjDeJU3n2W/vFRoWSwKbxfn0V8PT6Ihp0//i/N2adP/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6bD/caR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6bD/caR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8E91F00A3F;
	Tue, 11 Aug 2026 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462327;
	bh=0MO+BBQBTeCb/kSe47kBTKP0O/6cq9xKFbyVoptjN/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V6bD/caRF+sfLzpNgVbAnzatbhL5uzD2eTsm5wN/4X62NyxJw5QsozT5bIUilgBVt
	 8PXVnIy7XO/3UUXBabeKtbq9rHzD1jjA2tF2SQu0OFi4F4sJlRgjrhllcXXuPA6wKT
	 kIh1P/Pi06I8EVNxRBoHN6MNJR6g602yAUipn8xUm4UUdrDtFQaUyKIdbGo6Xr0G72
	 5rIIgSlfO0Fuv3IrGZaKOJiNHxnl9gz90LkJF4VVynWHfYSi96eudCq6lC+/W9+KA0
	 xsogAHerm//suHFh4RuxZnceMbwH+A45KsBVCYvdQJyzOzpYsLyNiEiY1r0ZuBjuUD
	 ON6ChPHqjL/7A==
Date: Tue, 11 Aug 2026 08:32:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, Victor
 Nogueira <victor@mojatatu.com>, Davide Caratti <dcaratti@redhat.com>, Jiri
 Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net] net/sched: act_api: fix TOCTOU NULL deref on
 a->goto_chain
Message-ID: <20260811083206.1511f344@kernel.org>
In-Reply-To: <CAM0EoMmQi03B+t8MyUsXp6-QOcOWRJvbji2etp9jjV1gU5V=XQ@mail.gmail.com>
References: <20260809090928.868186-1-jhs@mojatatu.com>
	<20260810164536.6ecf043d@kernel.org>
	<CAM0EoMmQi03B+t8MyUsXp6-QOcOWRJvbji2etp9jjV1gU5V=XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Aug 2026 06:43:32 -0400 Jamal Hadi Salim wrote:
> On Mon, Aug 10, 2026 at 7:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sun,  9 Aug 2026 05:09:28 -0400 Jamal Hadi Salim wrote: =20
> > > tcf_action_exec() handles TC_ACT_GOTO_CHAIN by first checking
> > > rcu_access_pointer(a->goto_chain) and then calling
> > > tcf_action_goto_chain_exec(), which does a second, independent
> > > rcu_dereference_bh(a->goto_chain) read and immediately dereferences
> > > chain->filter_chain. A concurrent tcf_action_set_ctrlact() (e.g. the =
gact
> > > replace path) can clear a->goto_chain between the two reads, so the s=
econd
> > > read returns NULL and tcf_action_goto_chain_exec() dereferences NULL.=
 =20
> >
> > FWIW *shiko suggests another tweak but looks orthogonal, LMK if you
> > disagree:
> >
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809090928.8681=
86-1-jhs@mojatatu.com
> >
> > (the patch is "too fresh" for me to apply right now anyway) =20
>=20
> The concern is valid but pre-existing and orthogonal to this patch
> (and a lot less severe than the posted fix)
> I had this discussion with Paolo: When the sashikos raise a concern on
> "pre-existing" issues, what should be the reaction?
> In general the conclusion was to follow up later if worth it; however,
> sometimes we need to make a judgement call - if the pointed to issue
> is serious (and yes, the AI bots are now reading what Sashikos are
> saying  and constructing bug reports) then a v2 is needed.
> In this case, I was planning to follow up. I will start more actively
> looking at sashiko reports and analyzing if worth a followup or a v2.
> I dont know how to do these pw signals, but in case i see it as "needs
> v2" it won't be worth waiting for one of you guys to comment.

Right, I was hoping my question was clear enough. I don't think v2 was
needed here either. But we had time to confirm...

> Do we need a written policy somewhere?

The only written policy should be that everyone who asks for a written
policy in this rapidly changing environment owes maintainers a beer :)

More seriously I tried to float two written policies recently - for net
vs net-next and requirements for information in fixes. And each time
there was a long discussion and questions. So y'all need to either
stop making written policies so painful, or stop asking for the
policies. *%$#.
