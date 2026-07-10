Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3743B47FB;
	Fri, 10 Jul 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700040; cv=none; b=iLUI/jSpwo8DBjbitI5VubPbDSWUUmBPrW5mhIGHLtAWaSc7UvFHXo22USn8aei7sMKbL26ekiEdqiUFrcZyuRpY+tbkZDNlMr8g4jmdDiclDLTXmCImOxdn0DFlOqGT74UkeZOGCoPl9k6LG+9NOWLvvpq1kMOk3IGocNUn0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700040; c=relaxed/simple;
	bh=GtqrwoiSKoC9RqAkJEPgiGp7Y1Sin20B3EKTkulVkLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx9YHy+JIGewQsNnIZbeymdo29PIyJgO/qbCGrk7uwuzSNyurkEOrxLugESqoDcOgwYQD6/hYFFteD7x/7wE2EMGzT7tudXBsRRTufBRuGSlj9yhiUd8/uEkoahwDVOpWg183nTzsk/2gVDCG7EWtOK//W3vhn+Sco3TNriaP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ/m5wjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ/m5wjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CEC1F00A3A;
	Fri, 10 Jul 2026 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783700036;
	bh=xKDCwublxZNjY2ZVkh5TvA/jmVDoU+2t1XpP5mAwcYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iQ/m5wjE+DqKrz26TLQZegT02Z1S4feOllTSruq2bJf6zwYH9j1JE/8/L+PEXtElg
	 Tu2zKhBOwKQ57bfjVjkumayMA+1LJJjYPgCFbVaeyzdid50Erzt6EedUcwJsNOAKed
	 HA/PGuH/XG/5YHCV2qZsihSq4UZ2Hr03BFJzzxKZlkY4dBBR9WVaDRdHYE0o7YQi5w
	 yB1Yz07n1wWcgVwXdgB/BuvwEK4ptyPGuTJlvkRjztZ+9HvyGpnH4sm9oi/gT/DybB
	 NHZgSYd3+9096dKTmck1BU+kdG2YoBqzCZlfsNxxyxRev2K9P/BU4uE5wl8gysVApL
	 vwF1+zCFweM2Q==
Date: Fri, 10 Jul 2026 17:13:44 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com, 
	hpa@zytor.com, yangge1116@126.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
Message-ID: <alEZIuJhv5ZXGQac@lucifer>
References: <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
 <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org>
 <ak-uER-RndpksnhR@lucifer>
 <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com>
 <ak_A6Yc5mBXCrtXr@lucifer>
 <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>
 <alDtzM28CgZJn6FF@lucifer>
 <62ccb0f7-a619-41b8-944e-11ae2d0ce70c@kernel.org>
 <alEUBzV1cevuPYeD@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEUBzV1cevuPYeD@google.com>

On Fri, Jul 10, 2026 at 08:47:19AM -0700, Sean Christopherson wrote:
> On Fri, Jul 10, 2026, David Hildenbrand (Arm) wrote:
> > On 7/10/26 15:05, Lorenzo Stoakes wrote:
> > > On Fri, Jul 10, 2026 at 02:57:55PM +0200, David Hildenbrand (Arm) wrote:
> > >> On 7/9/26 17:44, Lorenzo Stoakes wrote:
> > >>>
> > >>> OK as long as that's made clear in the patch, commit message, comments etc. :)
> > >>>
> > >>>
> > >>> Ack yeah I assumed it was a quick proof of concept and just overlooked it :P
> > >>>
> > >>>
> > >>> Thanks!
> > >>>
> > >>>
> > >>> hmm but we have FOLL_LONGTERM as an adjunct to FOLL_PIN (doesn't make sense
> > >>> without - any checks that exist for that btw should be extended to this noew
> > >>> flag).
> > >>>
> > >>> Also don't we want to encode the legacy aspect here?
> > >>>
> > >>> Maybe FOLL_LONGTERM_LEGACY_READONLY? Naming is hard :)
> > >>
> > >> I'm confused about the _READONLY, well. and the FOLL_PIN_NO_GUP_WRITE.
> > >>
> > >> We want to longterm write-pin.
> > >>
> > >> @Pankaj, how come you would call this "FOLL_PIN_NO_GUP_WRITE" -- why "no GUP
> > >> write" ?
> > >>
> > >> I agree that someting like FOLL_LONGTERM_LEGACY_* is the right thing to do, but
> > >> I don't see where this is "no write" or "readonly" ?
> > >
> > > I based it on Gupta saying 'without kernel GUP writes, and therefore not
> > > impacting dirty tracking'
> > >
> > > I mean I think we definitely need some clarification here yes :)
> > >
> > > Not really got the bandwidth to dig deep into GUP again :P
> >
> > I think the KVM gueest *will* write to these pages.
>
> Yes, the guest will write these pages, but through KVM's normal mechanism for
> mapping memory into guests.  The host will NOT write this memory via the GUP
> pins though.  KVM needs to pin the pages because the memory is (well, technically
> may be) encrypted (by the CPU) with a key that is only used/accessible when the
> guest is active, and the encryption is salted with the system physical address of
> the page.  E.g. attempting to migrate the page would corrupt guest memory due to
> copying ciphertext that would decrypt different at the new PA.

OK so it's a pinky promise that you won't write to it via GUP?

It's still really crap to just allow drivers to ignore this, which is asking for
abuse.

Is this something we could have a specific GUP helper for that is unexported? Or
does a module have to use this?

If not could we use some whitelisted approach or something to prevent arbitrary
drivers from overriding this?

>
> > By disallowing writable LONGTERM pins on FSes we broke one existing use case
> > that was relying on that to work.

How long ago did I break this though? Why has it taken until now for this to be
reported? :) commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast
writing to file-backed mappings") is from May 2023 :)

Is it vendors moving slow to update distros? Does speak to the usefulness of
testing mainline asap in any case.

I maybe missing details about the actual motivating issue here sorry!

Thanks, Lorenzo
