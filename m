Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAAF3B4E9B;
	Wed,  9 Sep 2026 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936319; cv=none; b=ZMLJZRpxS64cPy0rJ03vYhOqJNaZmmBAqLfBIhF74lDdymAbz9IjSqwjE/c3u9fRyMk9mGI7rl+RydDK8Ex1BintkV27AGPf4Qh+XdaQVCgVATQNG03X/wvQx3rAx/8AHcLHRhWdPGJWkqeGKzoFnv1/pSruRpnTz8lpgjVk8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936319; c=relaxed/simple;
	bh=MpZNvYUqsLZlaih+HciCxLUKMn62j1FIs6s6NAMOt1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdNUmbdYu0zuL7+bCuENbd+bSNTrgr+CCSx29IIGaN2lX2zDnLq7WNtInXhpT4kiZ1L3U9aO7GRzdG1Aj1wFspNjAKiaqHsufiLuSgL3AgmuNCMv8tk/6prXKQQnkxPiUDXmmCiH7Fi6cDJrgeQBMvUDqVoLQCTjskL5B00Kf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVpI/crm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVpI/crm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A651F00A3A;
	Wed,  9 Sep 2026 06:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936318;
	bh=gHlyXkGD4aouYNP/UxWOMEmtewgDmyqgdbR4J4vNfuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVpI/crmbCTehSjX//NzYyKi/Q0tH88FsfWv7XgHGuzglRq0olZW9qWm32/POWIhW
	 eyHep5l3ajdpo2+ruvn5nRTKmvn096kz2VOR2Tjk5z+Vx41Nyrl4DAquFdWoWP73Jr
	 evuspY7NFS+5a5BTV70rDyxw3Ts9PDr3hIluOepek/1IOOFvy7A5P+ZSx8dHiK6ZRi
	 tHOodI0A0XbSNCGxOS5HU4VdEUX70tH3d+69Ws5Dy0odSf9MdrWuJLKsZkJ6s7BzQo
	 Qf2G/aDy5pq+pRzxfbRtVXzLCrT780L9A6OJCE0PljlB2Ef/wPwxYqzsYN2BAxSF6k
	 xBWOKQPyqrUew==
Date: Wed, 9 Sep 2026 08:45:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Will Deacon <will@kernel.org>, David Carlier <devnexen@gmail.com>,
	Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>,
	stable@vger.kernel.org, x86@kernel.org
Subject: Re: Update on CPA fixes, x86/urgent and x86/mm
Message-ID: <aqEAeL1Na_D7egr9@gmail.com>
References: <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
 <b2095df8-9991-4e65-9890-c34f8c206319@kernel.org>
 <apZ52DKlJIrpX6qq@gremlin>
 <7fe0aee9-d1e9-419c-9ca6-c0160223d5dc@intel.com>
 <ap_WIZwCPKB07nAf@kernel.org>
 <54f55b19-4a42-4c5d-a6ec-979132e11ece@intel.com>
 <5394f2d7-03e2-4aeb-a5da-60a0368340d9@kernel.org>
 <cd92444e-777f-470a-9bc9-f64e5edf10e3@intel.com>
 <3d7152ba-5e41-4cff-9c96-08f77f60ede5@intel.com>
 <aqD_asyNQgzSQBy3@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqD_asyNQgzSQBy3@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Dave Hansen <dave.hansen@intel.com> wrote:
> 
> > OK, so Linus pulled the x86/urgent fixes I sent earlier today. I've
> > staged everything else. Here's an explanation for where that leaves the
> > other x86 fixes.
> >
> > ==== x86/urgent ====
> > 
> > x86/urgent has 5 urgent fixes in it. There are 4 that are CPA-related.
> 
> Note that the rebase you did of x86/mm onto x86/urgent added the
> 5 MM fixes with an incorrect SOB chain - I've rebased x86/urgent
> to fix this up. No other changes, so if there are no other issues
> I this we can send this to Linus later today, and thus give it
    ^think
> an additional 2-3 days of testing in upstream until -rc3.

When morning tea has not kicked in yet. ;-)

Thanks,

	Ingo
