Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455DDDA9;
	Sun, 14 Jun 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424974; cv=none; b=S2/KpDsGlwbHTUgOvrmFI1fMzIPEnOninpgwAPfy3C/rFw8PFVz4jeBd9dc2CgMSl7M5KMjQOn0e3o7hJJt2DWZI5rlxaf9QO8KOitP0SpKk0R3ekE5+nAYE2cF+xbGneRD1LT7l+un/pMFAtB8D1JgApIcDKqpuh34luD/JpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424974; c=relaxed/simple;
	bh=SvUi/YcOlXgiuiVraTP8nfIOD9x6eoE10ik9gST3DFM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G9oqGIYsNcXBw7UQ3UMJiGQ4rOVdttcG8+emEBR28Ox1By9c4iRziOQ8NADn1BJaSpHyU4TzXKPLEx0DoTLXE9tfY7scxTdn+4PiZe3DMZ6Il3h64/dnJ3yDWd7Cqk4QmBYhhDcduqAKAv1dl3NSaT5wAdoW4ftbMUIFzU4RnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=ZVJNNbmM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="ZVJNNbmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1781424967; x=1782029767; i=aros@gmx.com;
	bh=SvUi/YcOlXgiuiVraTP8nfIOD9x6eoE10ik9gST3DFM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZVJNNbmMqfrrsIIh3IlCJt1vN8YcT+oExcwnHHh7izu5YtEA2wXgd342GcwRQu2y
	 HVyIwc0VOTBC/Wl53EFt6PozMSIlM9EK2GTBAeL4q8GPwoHuARt3wYaDjdwxGANsz
	 KpK7xyjEr4VHhCljkdnUV8D0a0JIAOSBIkeglBlioUNTzWBOwYbhvH7s/qQ2aKujZ
	 7sEBI/Fp6eAqT+EHvFgmLicega64gDK5JWJC22dKuaBw2GhzY7RMcSWvSRzdRZG5W
	 3Rf921HA53igIGN/NjBCMrPSY8eYuOUbskxGv9YCafROv9m9F8u0BfH1d8YMTjHRG
	 baIhGPL5micQa4ScXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQnF-1wRFN41vtF-008jOT; Sun, 14
 Jun 2026 10:16:07 +0200
Message-ID: <5f62925e-0faf-40aa-a594-10ef6d50f24e@gmx.com>
Date: Sun, 14 Jun 2026 08:16:06 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: Re: [RFC/PROPOSAL] Shifting the x.y.z Stable Tree to a Continuous,
 Signed Patch-Stream Model
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <cdb0dd2f-f331-46ed-8439-1609173f083a@gmx.com>
 <2026052444-unlawful-eskimo-9c41@gregkh>
In-Reply-To: <2026052444-unlawful-eskimo-9c41@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9la3y/SVybdYPglDKuFAqCNqknIY8Ez5f7U+dDt7LOxnz1hGP0m
 Bh0gb7o5iI/oV/B6aacfG9/cbY6bTSkdXP7l4tZ6EwBuv3gsmmXRMJHD+cRmFBIJ1SJwwy5
 lLoaxklxLUwr0dbqRnJTo0cdsaGdxdGDzohAIPTGnOgSaH6pDNPbWrgV+cYAJ4cDmkK4kGr
 I03Jt/LTUjqNLx8J9zhZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ei55huHJlEM=;1y9s3OyB+NDXCHEJPV3azwQ2KIr
 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

Hi Greg,

Let me try to restate the proposal more narrowly, because I think my=20
previous wording mixed several related issues together.

I am not arguing that stable.git is not already continuous. It obviously=
=20
is. Nor am I arguing that cutting a point release is expensive for=20
upstream. I understand that from the stable maintainer side, tagging a=20
release is cheap and well automated.

The problem is that the ecosystem still treats the x.y.z point release=20
as the main externally visible consumption boundary, even though it is=20
neither the real upstream unit nor the real downstream deployment unit.

The real upstream unit is the stable git branch: a linear sequence of=20
accepted backports.

The real downstream deployment unit is a distro-built kernel package:=20
base kernel, stable backports through some point in git history, distro=20
patches/configuration, compiler/toolchain, signing, modules, CI, and=20
user-visible packaging.

The x.y.z point release sits awkwardly in between. It is a useful=20
compatibility marker for consumers that want that workflow, but it=20
should not have to be the canonical boundary for everyone else.

A better model, in my view, would be:

* stable.git remains the canonical source of truth;
* every downstream-consumable stable state is identified by branch +=20
signed commit ID, optionally with a signed machine-readable manifest;
* distros consume `v7.0 + stable commits through <commit>` or=20
`linux-7.0.y as of <date/commit>`, according to their own testing and=20
release policy;
* point releases may continue to exist for consumers that require them,=20
but they become one possible checkpoint format rather than the central=20
model.

This decouples two decisions that are currently conflated:

1. upstream=E2=80=99s decision that a commit belongs in the stable branch;
2. a downstream=E2=80=99s decision that a particular aggregate is ready to=
 ship=20
to its users.

Those are not the same decision. Fedora, Arch, Debian, Ubuntu,=20
enterprise vendors, embedded vendors, and live-patching teams all have=20
different risk tolerances, hardware exposure, CI capacity, reboot=20
policies, module/signing workflows, and urgency. A single upstream x.y.z=
=20
cadence cannot be the right integration boundary for all of them.

In the recent 7.0 security/regression mess, the useful downstream=20
question should not have been =E2=80=9Cwhich point release has Greg cut ye=
t?=E2=80=9D It=20
should have been =E2=80=9Cwhich stable commits are required for the comple=
te fix=20
set, and has our actual distro kernel artifact built from that stable=20
commit range passed enough testing to ship?=E2=80=9D

If distros routinely consumed the stable branch as a signed linear=20
stream, they could pin a specific stable commit, build from it, test it,=
=20
and declare exactly what they shipped:

```
base: v7.0
stable branch: linux-7.0.y
stable commit: <hash>
included range: v7.0..<hash>
downstream patches/reverts: <list>
```

That is more auditable than chasing point releases or cherry-picking=20
individual commits from intermediate states. It also makes clear that=20
the distro package, not the upstream tarball, is the object that was=20
actually tested and deployed.

There is also a practical artifact problem here. For long-lived stable=20
series, publishing a complete source tarball for every x.y.z release is=20
very wasteful. By 5.10.258, the 5.10.y series has hundreds of distinct=20
tarballs, each over 100 MB compressed, representing tens of gigabytes of=
=20
mostly duplicated source snapshots for one stable line. The real=20
information is the base tree plus the incremental stable deltas. Git=20
already represents that naturally.

So I am not asking to remove point releases from users that still need=20
them. Keep them for conservative workflows, existing scripts,=20
announcements, and consumers that require a simple named snapshot.

What I am arguing is that point releases should no longer be the=20
privileged stable consumption model. The canonical model should be the=20
signed stable git stream, with downstreams free to define their own=20
tested integration points on that stream.

That would make the stable process match what it already is technically:=
=20
a continuous sequence of accepted backports, not a sequence of magic=20
tarball events.

Regards,
Artem
