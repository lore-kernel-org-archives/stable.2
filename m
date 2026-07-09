Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807735C19F;
	Thu,  9 Jul 2026 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611854; cv=none; b=nldKc0MGuZDYOZ3TmWVGBznT7dxWQWzNywYH7xt8BT6Is24O/Hl/kfl8U0CXw01Ci3qmI1NgWL/SUzkJZ6pVRoziQE6PFhY/re/t9cdAknYVtcdz7j5tlPgZwwbOeegTMOwcktSgAAz5/WpN5vq6pt6PuHdjpWlPr3fdBFtJy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611854; c=relaxed/simple;
	bh=5ihj3jc7CuunbXVvjwb3Muc/bkt6kYgmHKeORiD7Vss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1sKjmfu93Uy8qX7zXqlqSEoRvniOtgqEfvo+o6D6sk4znQp5EPM/2wa3gr45bBYMP5TfPC1errPjpB8+UmPkI9kDYy7gZqLdOcxyAeUQhmt/m1gZHXJI3rAoyMfkSpO8Gogi8ph3xNADCktjgdmtcMJL45LRTfGGRT65UY2tQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwliaWv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwliaWv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A861F00A3A;
	Thu,  9 Jul 2026 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611853;
	bh=285LaEGh3A0QFIVOYPOsW/0/c98eMaQwDcpzh7ozqYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KwliaWv9bxV0Nv7YosIm0mo6z799KEvSo/GZ7t//Ow7EyigBPfVX1n90yTa8hhrbt
	 Kc29sHuXjnIFYPBHPPaQ+RLeYsmx81DkS6cv4rY6WW1+jMdtMug7C+cyz5tvuCtW2v
	 eD7W1nhMTYogk9MFDautO55WmQLHocTlSIZ/cWsZBf0t874xH2kHaB4ajls8U9bYzu
	 lVpiE3fB+UrAlfB0ipJ8vXO+p5IIdwqJfBYdEgVfxTjJrtSag+MVIQhrcPg9Lz5n7s
	 F0JCXQUGThw6Wuryol7BRZUk143S3jmt9JlSMPs6KxnRaFKT1xH/wQfNLFQQVzPwAX
	 luIMAxhslJUQw==
Date: Thu, 9 Jul 2026 16:44:01 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, seanjc@google.com, 
	pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com, 
	bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com, 
	yangge1116@126.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
Message-ID: <ak_A6Yc5mBXCrtXr@lucifer>
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
 <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
 <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org>
 <ak-uER-RndpksnhR@lucifer>
 <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com>

On Thu, Jul 09, 2026 at 05:19:10PM +0200, Gupta, Pankaj wrote:
> Hi Lorenzo,
>
> > > > > > Hi David,
> > > > > >
> > > > > > Yes, it fails in this path but for file backed mapping, vma_is_fsdax() returns
> > > > > > false because
> > > > > >
> > > > > > vma_is_dax() returns false:
> > > > > Ah, okay, so fsdax is not involved and we really only fail because of the
> > > > > writable_file_mapping_allowed() check.
> > > > >
> > > > > I was for a second thinking in terms of nested virt :)
> > > > >
> > > > > > Host side backend is regular file backed memory (no fsdax).
> > > > > Okay, so we'll end up mapping an ordinary file into VM memory, and expose that
> > > > > to the VM as part of virtio-pmem device.
> > > > >
> > > > > That also means that vfio etc. won't be able to longterm-pin such device memory.
> > > > > So this is not a problem isolated to SEV.
> > > > >
> > > > > Forbidding to longterm pin is actually the right thing to do if the filesystem
> > > > > relies on writenotify, as spelled out by Lorenzo's commit:
> > > > >
> > > > > "
> > > > >       Writing to file-backed mappings which require folio dirty tracking using
> > > > >       GUP is a fundamentally broken operation, as kernel write access to GUP
> > > > >       mappings do not adhere to the semantics expected by a file system.
> > > > >
> > > > >       A GUP caller uses the direct mapping to access the folio, which does not
> > > > >       cause write notify to trigger, nor does it enforce that the caller marks
> > > > >       the folio dirty.
> > > > >
> > > > >       The problem arises when, after an initial write to the folio, writeback
> > > > >       results in the folio being cleaned and then the caller, via the GUP
> > > > >       interface, writes to the folio again.
> > > > > "
> > > > >
> > > > > Hmmm
> > > > Yes. For file based mapping we don't allow long term pinning.
> > > >
> > > > If we take into account the fragmentation concerns for MIGRATE_CMA and
> > > > ZONE_MOVABLE allocations
> > > >
> > > > solvable with FOLL_LONGTERM, I can think of two options(tested) to allow file
> > > > based mappings as well:
> > > >
> > > > 1. Fallback on FOLL_WRITE when FOLL_LONGTERM fails as suggested by Sean.
> > > That is just not acceptable, as it breaks random other stuff (MIGRATE_CMA, as
> > > one example) besides the file-pinning problems that Lorenzo added.
> > >
> > > If we're going to hack something in, then that we bypass the file writeback check.
> > > Not that we don't use FOLL_LONGTERM.
> > >
> > > I'd hate to use a GUP flag to indicate "this is a legacy hack", but it clearly isolates the
> > > issue (needs a better name obviously):
> > So under what circumstances are we happy with totally breaking dirty tracking?
> > :/ seems iffy, and exposing this to drivers generally is a bit worrysome.
>
> The intention is to allow long-term pinning of file-backed mappings only for
> migration avoidance,
>
> without kernel GUP writes, and therefore not impacting dirty tracking.

OK as long as that's made clear in the patch, commit message, comments etc. :)

>
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index ae9bca4eda5ca..e2c531f914d44 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -1912,6 +1912,9 @@ enum {
> > >           */
> > >          FOLL_HONOR_NUMA_FAULT = 1 << 12,
> > >
> > > +       /* TODO */
> > > +       FOLL_LONGTERM = 1 << 13,
> > > +
> > >          /* See also internal only FOLL flags in mm/internal.h */
> > >   };
> > >
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 0692119b79043..1fa0aa0cdc99d 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -1186,8 +1186,8 @@ static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
> > >           * If we aren't pinning then no problematic write can occur. A long term
> > >           * pin is the most egregious case so this is the case we disallow.
> > >           */
> > > -       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
> > > -           (FOLL_PIN | FOLL_LONGTERM))
> > > +       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK)) !=
> > > +           (FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK))
> > >                  return true;
> > Hmm I'm confused, you're then allowing FOLL_PIN | FOLL_LONGTERM, but disallowing
> > FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK?
>
> Yes, I addressed this in my reply, but it wasn't a clean inline response.

Ack yeah I assumed it was a quick proof of concept and just overlooked it :P

>
> >
> > By the way I think this should be expressed better if I criticise myself here :)
> >
> > So like:
> >
> > 	if ((gup_flags & FOLL_PIN) && (gup_flags & FOLL_LONGTERM))
> >
> > Or even:
> >
> > 	/* Only an issue if we pin... */
> > 	if (!(gup_flags & FOLL_PIN))
> > 		return false;
> > 	/* ...and that pin is longterm... */
> > 	if (!(gup_flags & FOLL_LONGTERM))
> > 		return false;
> >
> > But I'm confused as to why we are suddenly allowing something broken and what
> > this hack flag is supposed to achieve?
> >
> > Shouldn't this rather be:
> >
> > 	/* Only an issue if we pin... */
> > 	if (!(gup_flags & FOLL_PIN))
> > 		return true;
> > 	/* ...and that pin is longterm... */
> > 	if (!(gup_flags & FOLL_LONGTERM))
> > 		return true;
> > 	/* ...and not overridden... */
> > 	if (gup_flags & FOLL_LONGTERM_HACK)
> > 		return true;
> > 	/* ...and dirty tracking is required. */
> > 	return !vma_needs_dirty_tracking(vma);
> > }
>
> Yes, this looks much better. Will incorporate this.

Thanks!

>
> >
> > >          /*
> > > @@ -2746,7 +2746,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
> > >           * If we aren't pinning then no problematic write can occur. A long term
> > >           * pin is the most egregious case so this is the one we disallow.
> > >           */
> > > -       if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
> > > +       if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE | FOLL_LONGTERM_HACK)) ==
> > >              (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
> > Yeah this is just a bit horrid having to stare at a this a while... So
> > FOLL_LONGTERM_HACK would enable here.
> >
> > Be nice to avoid this form of it as it's difficult to understand, do something
> > like above or a clearer version anyway (probably best abstracted to a small
> > function).
>
> Sure.
>
> Also, I am also planning to rename (FOLL_LONGTERM_HACK ->
> FOLL_PIN_NO_GUP_WRITE) in v2.

hmm but we have FOLL_LONGTERM as an adjunct to FOLL_PIN (doesn't make sense
without - any checks that exist for that btw should be extended to this noew
flag).

Also don't we want to encode the legacy aspect here?

Maybe FOLL_LONGTERM_LEGACY_READONLY? Naming is hard :)

>
> Please let me know if you have a preference.
>
> Thanks,
>
> Pankaj
>
> >
> > >                  reject_file_backed = true;
> > >
> > > @@ -3180,7 +3180,7 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
> > >          int locked = 0;
> > >          int ret;
> > >
> > > -       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
> > > +       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM | FOLL_LONGTERM_HACK |
> > >                                         FOLL_FORCE | FOLL_PIN | FOLL_GET |
> > >                                         FOLL_FAST_ONLY | FOLL_NOFAULT |
> > >                                         FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
> > >
> > >
> > > --
> > > Cheers,
> > >
> > > David
> > Thanks, Lorenzo

Cheers, Lorenzo
