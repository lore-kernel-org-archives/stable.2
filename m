Received: from mail.flyingcircus.io (mail.flyingcircus.io [185.105.255.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5C42E8F8
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.105.255.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166914; cv=none; b=k4Y6NWX8xBEi18/wavLMjAJ6aEDfi9yBqc3/jkXPU4ncBsNfZJhyEkIwoyZs4CE8zP4u70EnHaOuxctdifcZWBVQ2nc2Jsczxdqrpnp5FH1ZYEaGnT/9FdXfHr4E4Fg7Y5OTxTK/kKzqduDDHzE4KnamsxXq37hyFQvX+ZZ8Tao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166914; c=relaxed/simple;
	bh=na9/4sPpjtUD4jFZ00XrvZdF1bGkk4FuLrfUDxeBN3M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F8xa0j5AUUIni3j6QjJoCk2yeC5Q9sYUzCcoPlakX0xCmvElyACOhsMFhM8rLEIqw+7rL6omM3c8YzLBt4n9qD6ZaCRaCGnaKxGGyw8saC6+rGOejFJnxEPaKHfM3oSA0fEkImpK8JFcyLuJe27nIUoMcSDBlG0ipYkkhXjTPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io; spf=pass smtp.mailfrom=flyingcircus.io; dkim=pass (2048-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b=A+lwzxHu; arc=none smtp.client-ip=185.105.255.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyingcircus.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flyingcircus.io header.i=@flyingcircus.io header.b="A+lwzxHu"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 000A8185505A;
	Fri, 16 Oct 2026 18:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
	s=dkim; t=1792166478;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=na9/4sPpjtUD4jFZ00XrvZdF1bGkk4FuLrfUDxeBN3M=;
	b=A+lwzxHuYzMibn69jzcU+qEgZL7TzInk0XA7fWschn2iEEPPv5FtZ+M/BUSBQ/WhhLUGcD
	02L/dRiFbC79im3zi2dCCBpOM+KMQg1DZj85/v2q5k70WQlKh2z6zevYvpb3HaCMXvbqdq
	P55Pdh8Fnmm6pGMfiRZoQ292AqNshpZQ+x1Vcb6dApIc4Zzzkgni+NlQoMFT445z5RgGL5
	/yLjUEzLk2coZ9C392OFr5bN8T+HBOIiKnFgEmf0vAt1QSL+PMttml8qcypa7Lb7veaL7t
	OVR7GncTvF6NjxB2vvhP9u2cTm4MwoSiA2s3gvaxalROVMkmqd1NPcQZ6po/dw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to
 xas_split_alloc backport
From: Christian Theune <ct@flyingcircus.io>
In-Reply-To: <2026-10-03-1-daily-reply-0006-re-kswapd-list-lru-aca1f2d5-6-18-queued@kernel.org>
Date: Fri, 16 Oct 2026 18:01:00 +0200
Cc: Zi Yan <ziy@nvidia.com>,
 Deepak Nagaraj <deepak.nagaraj@baseten.com>,
 stable@vger.kernel.org,
 mfleming@cloudflare.com,
 Kaz Kato <kazuyoshi.kato@baseten.co>,
 Stephen Day <stephen.day@baseten.co>,
 Greg KH <greg@kroah.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9479A92E-645A-4A30-8332-212707E66A35@flyingcircus.io>
References: <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
 <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com>
 <CAL3JwHN34En=iiEB+Zyxo3=_xfODTY_k_kddb2njN+AJwSCnnw@mail.gmail.com>
 <7C66B0B0-1F43-41D9-9B4F-89956045D81C@nvidia.com>
 <2026100327-shrine-refusal-0488@gregkh>
 <2026-10-03-1-daily-reply-0006-re-kswapd-list-lru-aca1f2d5-6-18-queued@kernel.org>
To: Sasha Levin <sashal@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)
X-Last-TLS-Session-Version: TLSv1.2

Hi,

we=E2=80=99re being intermittently bitten by this on 6.12.112. I was =
considering upgrading
to 6.18 or selectively applying the patch to 6.12 but couldn=E2=80=99t =
find the patch you
mentioned queued up for 6.18.=20

Is there anything we can do to help move the missing patches forward for =
6.12 and earlier?

I have colleagues I can ask to step in if needed.

@Deepak: I=E2=80=99m guessing you=E2=80=99re running your patches =
selectively in your environment already? I=E2=80=99d be willing to apply =
selectively to the machines that are affected over here.

Love,
Christian

> On 4. Oct 2026, at 00:32, Sasha Levin <sashal@kernel.org> wrote:
>=20
>>> Rather than picking your patch below, I think we will need to =
backport
>>> commit aca1f2d5de17e ("mm/huge_memory: initialise workingset state =
before
>>> folio split=E2=80=9D), although the backported version might need to =
change
>>> mapping_set_update() like what you did below.
>>=20
>> Please send us the properly backported, and tested, commits and we =
will
>> be glad to queue them up.
>=20
> I've queued that one for 6.18.
>=20
> 6.12, 6.6 and 6.1 are left for the tested backports. 6.6.157+ and =
6.1.188+
> carry the same 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in
> xas_split_alloc()") backport without it, so they have the same =
exposure as
> 6.12.109+ and the backports should cover all three trees.
>=20
> On 6.12, mapping_set_update() is static in mm/filemap.c, so =
62e72d2cf702 ("mm,
> madvise: fix potential workingset node list_lru leaks") is needed =
first. 6.6
> and 6.1 have no __folio_split() and already have mapping_set_update() =
as a
> macro in swap.h, so there the call goes before xas_split_alloc() in
> split_huge_page_to_list().
>=20
> --=20
> Thanks,
> Sasha
>=20

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick

