Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF855522EF3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912184; cv=none; b=io0kmydwOEqFUlhikbmgkpf1KaN26khW7cYKNXk5ALHTbxhfDKaPNRb0taLcZ5HrVT1NhQ8ZhfXuJqnj9IKezFo/1JjXxsAuonIKlaBo0JRwGCi6urOstbBA54LsA6VlUWupot5fvxijlPmDNn9/WSozYbXO5UZsiglrZ0nKNBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912184; c=relaxed/simple;
	bh=6oHp6iOgu3vSfUvFoKGR28aA37BnryUeRpYDhY2R2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHrvArwXSWmdcdKPsF6kjJQZa+qvaatR+xyq9b2s9cb08v8v5qhA7m40wvZk6TT8wWLqiPoUW39j7K/cV5BuxRebZi1Aomnz4dcMGH9HLSKb203vyoRRu/5XmuEskoMVcAZ7K/N3XayftKIQp7HPhQ/kG5XQweyWKwQArrRSsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM4vImJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM4vImJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72B31F0089C
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912182;
	bh=58vcH4XOh3Uxb0/yHZpvGzQapqHFOqeDk7/phElXVhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bM4vImJeNOabcnbRhYbq9bIHyCVf6FStYaRomHk+BwpDrO8rxLv/G/eqw/PQT4a4O
	 9zdDaMeFWhCffixJHEoQ6Q01mBo+I89j+lWWvCy4PB/z8l/10Bgo6hgo34ToVcVrI9
	 Lzj1m/uhPzx5smipyd+L9dSHjKU/91/R1Q/wFVbcCRmCsP3dWI2LNSG3bpFYPuKExD
	 +PfJTT7QOVaDF//gYqAjKu3nnXEGnLaCTOA0lJy0pSuWStN4EVTJNFIPls9OifnZsE
	 JFwN3qFYqyRdnLx5JdVtMARHzUV+xTCOwQq5U9UFMW5wvo61rg264FFxbda+3yxpcZ
	 LskmvOEsJjBXg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so3370502e87.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:23:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwZ5F8NOB1KmxWUS+O5Ca6W703NbUd6/MNwZZ1fV0gN/i2yV1g6wQ8FoZXl1r5KJRwtS8jVSyM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiEwW/8igL3IU6ZpEXCUTbGYNtxjsVJghr0z/Q5N1ibJhxFWAQ
	VbvmGrRHqz6Kbi7xbM53TtfTshn9BZFTTB7cotcz5DiSDFZJGTlFH3fy8KNV2mg+J4DwLKClsQ0
	pFkR27igQBybQMFYYMZlAbDZtl7LmCqw=
X-Received: by 2002:a05:6512:1389:b0:5b8:f3d5:f301 with SMTP id
 2adb3069b0e04-5bcde35148bmr4362168e87.6.1791912181025; Tue, 13 Oct 2026
 10:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org> <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com> <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
In-Reply-To: <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 19:20:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
X-Gm-Features: AclHuK8Dko4T7OiAi5h3jqpw8o-XWUajlqhmOiANoa1OJ9welDWIOCCTNuHuWCM
Message-ID: <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the
 complete callback
To: johannes.goede@oss.qualcomm.com
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>, 
	Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, regressions@lists.linux.dev, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Oct 13, 2026 at 3:36=E2=80=AFPM <johannes.goede@oss.qualcomm.com> w=
rote:
>
> Hi Rafael,
>
> On 13-Oct-26 13:58, Rafael J. Wysocki (Intel) wrote:
> > On Tue, Oct 13, 2026 at 11:33=E2=80=AFAM <johannes.goede@oss.qualcomm.c=
om> wrote:
> >>
> >> Hi,
> >>
> >> On 13-Oct-26 00:46, Ali Ahmet Memi=C5=9F wrote:
> >>> Since commit d33e89d12295 ("thermal: core: Suspend thermal zones late=
r
> >>> and resume them earlier"), thermal zones are resumed from dpm_complet=
e(),
> >>> before the PM_POST_SUSPEND notifier that re-reads _BIX and _BST. On
> >>> ThinkPad P1 Gen2 and P53, INT3403 _TMP calls \GTST which switches the=
 EC
> >>> page selector (HIID) without taking the BATM mutex used by the batter=
y
> >>> methods. ACPICA releases the interpreter lock around EC accesses
> >>
> >> I'm wondering if this "ACPICA releases the interpreter lock around EC
> >> accesses" is not the real problem here.
> >
> > Yes, it most likely is.
> >
> > What actually happens is that ACPICA drops the interpreter lock and
> > the namespace lock in several cases listed in the
> > acpi_ex_exit_interpreter() documentation comment, the majority of
> > which involve having to wait.
> >
> > The bottom line though is that the interpreter and namespace locks
> > cannot be expected to be held throughout AML evaluation because it is
> > not known in advance if any of the cases in question will appear.
> >
> >> Recently I've learned / heard
> >> from a trusted source that Windows ACPI subsystem is very much single
> >> threaded. So it is nice that ACPI has these mutexes and other stuff
> >> to support multi-threading but as long as Windows ACPI interpreter is
> >> not multi-threaded I think we may need to consider to copy Windows
> >> behavior.
> >
> > This is also my conclusion, at least to some extent.
> >
> > The problem with it though is that in some cases parallel evaluation
> > of AML is actually useful.  For example, say two PCI devices are
> > powered up at the same time and AML waits for each of them.  The async
> > suspend/resume aligns those waits to take place simultaneously instead
> > of serializing them which allows some time to be saved.
> >
> >> So maybe the EC accesses should keep the interpreter lock locked durin=
g
> >> EC accesses.
> >
> > The problem here is that it is hard to say in advance whether or not
> > _BIX or _BST will access the EC and whether or not that will clash
> > with _TMP evaluation for a seemingly unrelated thermal zone.
> >
> >> And even go further and maybe we need to introduce a big-acpi-lock,
> >> which I guess the interpreter lock more or less is? And just serialize
> >> all ACPI accesses since most ACPI tables clearly do not handle
> >> multi-threaded access to ACPI methods well ?
> >
> > I would be inclined to do so except for device power management
> > methods, that is _ON, _OFF, and _PSx, that are not the problematic
> > ones, at least as far as I know.
>
> That sounds like a reasonable compromise which should fix both
> this case as well as help with bko221065 .
>
> >> Another example of multi-threaded ACPI calls causing problems is:
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> >
> > Right.
> >
> > So I guess the idea would be to add locking to acpi_evaluate_object()?
>
> Yes that seems like a nice single point of entry to do this where
> all the various helpers eventually end up.

That, of course, would require updating ACPICA code and I'm not sure
if doing it upstream is useful.  For example, if some hosts already
use locking around acpi_evaluate_object(), this modification won't
help them and it will certainly be a change in behavior.

This means that we'll likely end up with a Linux-specific divergence
from the upstream which can be lived with, but it won't be nice.

> > An alternative might be to introduce an "exclusive" variant of
> > acpi_evaluate_object() with built-in locking and use it in the cases
> > that are known-problematic.
>
> So here we have _TMP and _BIX / _BST and in bko221065 we have
> a bunch of again batteyr methods + UCSI racing. I'm afraid if
> we add something like acpi_evaluate_object_exclusive() we'll end
> up eventually using that almost everywhere.

While I think that your concern is valid, this can be done without
touching the ACPICA code at all.

Also, we don't actually know how many "bad" cases there are and so far
we have identified a few.  If they are not too widespread, changing
behavior everywhere for everyone may not be adequate.

> Maybe do things the other way around and serializing all the calls
> by default and adding an acpi_evaluate_object_unlocked() to be used
> in cases where we want the speedup of multi-threading like
> the _ON, _OFF and _PSx you mentioned above ?

Yes, depending on which way is more practical, that can be done.
