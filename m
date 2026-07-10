Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1C42A787;
	Fri, 10 Jul 2026 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688728; cv=none; b=sob8RWJ1R5r5CYEriuXtfyDAGgkuNbjsLPQwCmZV5r897EcYQER9Ze///3xDjepQxNJF1O5y2ilo2Cdh8MFYTPrrcsXBRMybzOc/ZoZS08EUJ7CnqavlRC20WN2W4ingDoOcmVQ36RanM51fycuGTIiZgRNcxKabb+LAN7/+W2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688728; c=relaxed/simple;
	bh=KFETl4TXy/LH8/y5KgOBsNpVEK9YzFWWJq+os8wSWM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjN/v/A0+VRxN2Bn8NxBcCj8Ll2P1+lDz8Nqny8zO3N2UG/S4qR4K8/XCqsMCpxPmfXziszk5DOcoJiGsJLg55QRLfelLhzaA9Jt4YRdF2MZ7BXPAoYBojO31ClzEqDS+cLdUyjmiVRr1OKaA30Y67KFXmeOEQBPMcY1FglxmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrWQZLhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrWQZLhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4551F000E9;
	Fri, 10 Jul 2026 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783688726;
	bh=LmIFd6NecbJf4+X2ydIIw4wwOP6wdd7YR/KqS5WZ50E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZrWQZLhXuyPIBRfvsp7lrI7tuUEQtaN3LjMvZfGlCqgDDXZiY/ejpQdhyfSPMUyWj
	 QRZg/gZEAty5BdWvUNWo6KdJjyvJ6Lq9zquHhn0qK0yoPP8b/TYRUXB4cHk6hcaD6S
	 P8+soimOzK7czXdDLyHHp57/K5vFPaMPpSNtaCLyhK9VHc6CemoBjvKR8f0pMLPhKh
	 Xm/sshs4M1i7yzwKQk3SVvJ+BmEV+1DtCs/xeey6iHDtu3v6BM6Dsk+qRDmS66dyeC
	 hzFdTc12yg8ic9rtvsMZDVMd42miTAkWQdq+NHnhOE6RWz5GTkdfOgRsy6uAcK6y99
	 nJeGs5z8Fc0pw==
Date: Fri, 10 Jul 2026 14:05:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gupta, Pankaj" <pankaj.gupta@amd.com>, seanjc@google.com, 
	pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com, 
	bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com, 
	yangge1116@126.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
Message-ID: <alDtzM28CgZJn6FF@lucifer>
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
 <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
 <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org>
 <ak-uER-RndpksnhR@lucifer>
 <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com>
 <ak_A6Yc5mBXCrtXr@lucifer>
 <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>

On Fri, Jul 10, 2026 at 02:57:55PM +0200, David Hildenbrand (Arm) wrote:
> On 7/9/26 17:44, Lorenzo Stoakes wrote:
> > On Thu, Jul 09, 2026 at 05:19:10PM +0200, Gupta, Pankaj wrote:
> >> Hi Lorenzo,
> >>
> >>> So under what circumstances are we happy with totally breaking dirty tracking?
> >>> :/ seems iffy, and exposing this to drivers generally is a bit worrysome.
> >>
> >> The intention is to allow long-term pinning of file-backed mappings only for
> >> migration avoidance,
> >>
> >> without kernel GUP writes, and therefore not impacting dirty tracking.
> >
> > OK as long as that's made clear in the patch, commit message, comments etc. :)
> >
> >>
> >>> Hmm I'm confused, you're then allowing FOLL_PIN | FOLL_LONGTERM, but disallowing
> >>> FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK?
> >>
> >> Yes, I addressed this in my reply, but it wasn't a clean inline response.
> >
> > Ack yeah I assumed it was a quick proof of concept and just overlooked it :P
> >
> >>
> >>>
> >>> By the way I think this should be expressed better if I criticise myself here :)
> >>>
> >>> So like:
> >>>
> >>> 	if ((gup_flags & FOLL_PIN) && (gup_flags & FOLL_LONGTERM))
> >>>
> >>> Or even:
> >>>
> >>> 	/* Only an issue if we pin... */
> >>> 	if (!(gup_flags & FOLL_PIN))
> >>> 		return false;
> >>> 	/* ...and that pin is longterm... */
> >>> 	if (!(gup_flags & FOLL_LONGTERM))
> >>> 		return false;
> >>>
> >>> But I'm confused as to why we are suddenly allowing something broken and what
> >>> this hack flag is supposed to achieve?
> >>>
> >>> Shouldn't this rather be:
> >>>
> >>> 	/* Only an issue if we pin... */
> >>> 	if (!(gup_flags & FOLL_PIN))
> >>> 		return true;
> >>> 	/* ...and that pin is longterm... */
> >>> 	if (!(gup_flags & FOLL_LONGTERM))
> >>> 		return true;
> >>> 	/* ...and not overridden... */
> >>> 	if (gup_flags & FOLL_LONGTERM_HACK)
> >>> 		return true;
> >>> 	/* ...and dirty tracking is required. */
> >>> 	return !vma_needs_dirty_tracking(vma);
> >>> }
> >>
> >> Yes, this looks much better. Will incorporate this.
> >
> > Thanks!
> >
> >>
> >>>
> >>> Yeah this is just a bit horrid having to stare at a this a while... So
> >>> FOLL_LONGTERM_HACK would enable here.
> >>>
> >>> Be nice to avoid this form of it as it's difficult to understand, do something
> >>> like above or a clearer version anyway (probably best abstracted to a small
> >>> function).
> >>
> >> Sure.
> >>
> >> Also, I am also planning to rename (FOLL_LONGTERM_HACK ->
> >> FOLL_PIN_NO_GUP_WRITE) in v2.
> >
> > hmm but we have FOLL_LONGTERM as an adjunct to FOLL_PIN (doesn't make sense
> > without - any checks that exist for that btw should be extended to this noew
> > flag).
> >
> > Also don't we want to encode the legacy aspect here?
> >
> > Maybe FOLL_LONGTERM_LEGACY_READONLY? Naming is hard :)
>
> I'm confused about the _READONLY, well. and the FOLL_PIN_NO_GUP_WRITE.
>
> We want to longterm write-pin.
>
> @Pankaj, how come you would call this "FOLL_PIN_NO_GUP_WRITE" -- why "no GUP
> write" ?
>
> I agree that someting like FOLL_LONGTERM_LEGACY_* is the right thing to do, but
> I don't see where this is "no write" or "readonly" ?

I based it on Gupta saying 'without kernel GUP writes, and therefore not
impacting dirty tracking'

I mean I think we definitely need some clarification here yes :)

Not really got the bandwidth to dig deep into GUP again :P

Gupta could you please clarify exactly what's happening here?

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
