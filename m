Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278154488E
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990501; cv=none; b=Y/ZgfwQ95fjectloGKVC+nsIIk9mR+FeNf/8kXPhPHjYWqkWPNp3M6nvKg/PQUPky0yNyQnBFPzOPnt58HCiezseJSriM3zYVdBgv9u9Jw1QmeTtWWIbzqQG75Q+CsXWbZF/TtrnKR3dkOBjwPI8wkxjt2fUPpZohf/a+vfVp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990501; c=relaxed/simple;
	bh=OrVR4ICDaqIMRFPXX7OWuZx/GX2al5sZl9xwPRxED5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCvCRx1be178CzzP2zQYm/uaZTfI2fKK7GDrYt5yHja/3RrYoayOywVLfwOarHuy6Cc7CWvb87rk2Vc4zJdXgvvNQME6Z0YygJqbIjuwk8mzeIVEEym2g4A7MyuGwl0lT6aZmnIXok9WlzF50L/ZGTexbIaScBVRtIiKjzDr2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD2nmMtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD2nmMtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3EC1F000C4
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990497;
	bh=ljk9MNy1mrOZMOuTAp5WT6L4E5edUdTWjdqXrdRQBe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XD2nmMtPGm6s8KO2i0KDKogYIhqcbBzXqw3iBp5uSmdKK7S2k6V+CArmJIEl1/KyI
	 gYcNtC2LPq/H3zjOiGOg23l6GMybqupTm/+iYCYkOBZue6Gedwk/5c/anI1E/6nxcR
	 kmg6bdrog0KfyUAGjMk7L8b7/iJbGGTvQab9KLkAizjPF8g5mUpB7DcjNVjqlSAzsb
	 dS89Oe/1CCLTXApGBES6GU0K42kWL3rSVTKqKq/CWDgDWl4ENi637yKc1dB4BP8sp3
	 OPbbzYq3fb/CeYEBZWfuOV9nWW27R9vQFf22bhge9/NEhy4A/9DhYlCG0TvcBOiARc
	 XWzzUQZSMQovA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so474539e87.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:08:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJUOBRONLzahdBdqfFTq2+nQcPnEJkcn+gIxohVASLS0KR8Kq9vAiCjWtWnfUuxsLV/OdYfVo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDXVhHlX+mTcyPS2ZUEjYYz3Eh74XLLqEbyQurSP3LixK9qj7V
	ISQymLl7kpvYwosCL+5CTiZFN2h6HLG0063tWrcL+ujpGrOhWPmnacNKKhjPJU+muQdcmzzb3e0
	TnB86EK4+X9ya13xp0NPvPCAncf/helE=
X-Received: by 2002:a05:6512:3f0f:b0:5bb:7c7c:c4e with SMTP id
 2adb3069b0e04-5bcde8e65f9mr6142561e87.63.1791990495980; Wed, 14 Oct 2026
 08:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org> <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
 <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com> <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
 <b64b8092-93d7-4873-a55f-422b8e70cc04@oss.qualcomm.com>
In-Reply-To: <b64b8092-93d7-4873-a55f-422b8e70cc04@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 14 Oct 2026 17:06:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4xiDYBGA0LsUq4esJCzYBXjsmmXb1ZJvLcUZqDp+yuQ@mail.gmail.com>
X-Gm-Features: AclHuK9xOO3fl-25LwE2ScVkTnZoEmEEqpNoPfQjqZjGkNfKWcVggqNMlzc8seE
Message-ID: <CAJZ5v0j4xiDYBGA0LsUq4esJCzYBXjsmmXb1ZJvLcUZqDp+yuQ@mail.gmail.com>
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

On Wed, Oct 14, 2026 at 11:58=E2=80=AFAM <johannes.goede@oss.qualcomm.com> =
wrote:
>
> Hi Rafael,
>
> On 13-Oct-26 19:20, Rafael J. Wysocki (Intel) wrote:
> > Hi Hans,
> >
> > On Tue, Oct 13, 2026 at 3:36=E2=80=AFPM <johannes.goede@oss.qualcomm.co=
m> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 13-Oct-26 13:58, Rafael J. Wysocki (Intel) wrote:
> >>> On Tue, Oct 13, 2026 at 11:33=E2=80=AFAM <johannes.goede@oss.qualcomm=
.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 13-Oct-26 00:46, Ali Ahmet Memi=C5=9F wrote:
> >>>>> Since commit d33e89d12295 ("thermal: core: Suspend thermal zones la=
ter
> >>>>> and resume them earlier"), thermal zones are resumed from dpm_compl=
ete(),
> >>>>> before the PM_POST_SUSPEND notifier that re-reads _BIX and _BST. On
> >>>>> ThinkPad P1 Gen2 and P53, INT3403 _TMP calls \GTST which switches t=
he EC
> >>>>> page selector (HIID) without taking the BATM mutex used by the batt=
ery
> >>>>> methods. ACPICA releases the interpreter lock around EC accesses
> >>>>
> >>>> I'm wondering if this "ACPICA releases the interpreter lock around E=
C
> >>>> accesses" is not the real problem here.
> >>>
> >>> Yes, it most likely is.
> >>>
> >>> What actually happens is that ACPICA drops the interpreter lock and
> >>> the namespace lock in several cases listed in the
> >>> acpi_ex_exit_interpreter() documentation comment, the majority of
> >>> which involve having to wait.
> >>>
> >>> The bottom line though is that the interpreter and namespace locks
> >>> cannot be expected to be held throughout AML evaluation because it is
> >>> not known in advance if any of the cases in question will appear.
> >>>
> >>>> Recently I've learned / heard
> >>>> from a trusted source that Windows ACPI subsystem is very much singl=
e
> >>>> threaded. So it is nice that ACPI has these mutexes and other stuff
> >>>> to support multi-threading but as long as Windows ACPI interpreter i=
s
> >>>> not multi-threaded I think we may need to consider to copy Windows
> >>>> behavior.
> >>>
> >>> This is also my conclusion, at least to some extent.
> >>>
> >>> The problem with it though is that in some cases parallel evaluation
> >>> of AML is actually useful.  For example, say two PCI devices are
> >>> powered up at the same time and AML waits for each of them.  The asyn=
c
> >>> suspend/resume aligns those waits to take place simultaneously instea=
d
> >>> of serializing them which allows some time to be saved.
> >>>
> >>>> So maybe the EC accesses should keep the interpreter lock locked dur=
ing
> >>>> EC accesses.
> >>>
> >>> The problem here is that it is hard to say in advance whether or not
> >>> _BIX or _BST will access the EC and whether or not that will clash
> >>> with _TMP evaluation for a seemingly unrelated thermal zone.
> >>>
> >>>> And even go further and maybe we need to introduce a big-acpi-lock,
> >>>> which I guess the interpreter lock more or less is? And just seriali=
ze
> >>>> all ACPI accesses since most ACPI tables clearly do not handle
> >>>> multi-threaded access to ACPI methods well ?
> >>>
> >>> I would be inclined to do so except for device power management
> >>> methods, that is _ON, _OFF, and _PSx, that are not the problematic
> >>> ones, at least as far as I know.
> >>
> >> That sounds like a reasonable compromise which should fix both
> >> this case as well as help with bko221065 .
> >>
> >>>> Another example of multi-threaded ACPI calls causing problems is:
> >>>>
> >>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> >>>
> >>> Right.
> >>>
> >>> So I guess the idea would be to add locking to acpi_evaluate_object()=
?
> >>
> >> Yes that seems like a nice single point of entry to do this where
> >> all the various helpers eventually end up.
> >
> > That, of course, would require updating ACPICA code and I'm not sure
> > if doing it upstream is useful.  For example, if some hosts already
> > use locking around acpi_evaluate_object(), this modification won't
> > help them and it will certainly be a change in behavior.
> >
> > This means that we'll likely end up with a Linux-specific divergence
> > from the upstream which can be lived with, but it won't be nice.
>
> Ah, I see.
>
> >>> An alternative might be to introduce an "exclusive" variant of
> >>> acpi_evaluate_object() with built-in locking and use it in the cases
> >>> that are known-problematic.
> >>
> >> So here we have _TMP and _BIX / _BST and in bko221065 we have
> >> a bunch of again batteyr methods + UCSI racing. I'm afraid if
> >> we add something like acpi_evaluate_object_exclusive() we'll end
> >> up eventually using that almost everywhere.
> >
> > While I think that your concern is valid, this can be done without
> > touching the ACPICA code at all.
>
> Not needing to touch ACPICA is a valid concern. So I agree lets go
> with a wrapper for paths which we know need to be serialized for now.
>
> And then add that around the battery methods + _TMP + UCSI methods
> for starters I guess ?

Yes.

> ###
>
> Should we also stop releasing the interpreter lock in the EC code?

Which EC code do you mean in particular?

> All these things (battery, _TMP, UCSI) seem to have in common that
> they might talk to the EC in some cases?

Yes, they are EC-based in many cases.

> Where as e.g. your powering-up of PCI slots example is unlikely to
> talk to the EC ?

Yup.
