Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7E33F5BF;
	Wed, 12 Aug 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547753; cv=none; b=CqeJm/nFXNZnlvPRtA2ktdKFD6J2qTGn6AaV2Kpr10E/cI3rfNKCFiJCgXj0qgCjI9arb2NaGutD/ELWlInVCz7aqVa6b0UJrs4qhXDY0ObEWb3BoWxHR8XRgskq97JOo7uQOGtzbori5UjbzvE3wGeia2PXjed23vNgzz+aBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547753; c=relaxed/simple;
	bh=8kNRk9Jxdtlf7ifXZvqyvZtv0lbpYv6pJR5OAz82Js0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOL9UtW1Yo2TyXDi43xRBFsktq4s7E+M4wcphOByWWbs7lX0tsQTHWDSpt4D5LPQQrOGkVOHMg+Q2X6TLh3nwmUY0naw6J8e17wqcaJ96bTMx26Op5gn3FVtkrTfNs60EpH4A0eWfyn4UWj0tmDZl/sdMUUwEc6JMQxEjBITZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHTlujo+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHTlujo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008BC1F00A3F;
	Wed, 12 Aug 2026 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786547752;
	bh=lPh6g5iGS2WA0/mUV2gpwWeFGaucRmMGFZUtCeA+ObU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GHTlujo+BUk2vYYvApA/At9WHYcS7dfyrj1YiE1mvYOM7GM0fv23hslpd7x1OO8zW
	 wTiQCxVEmf4xbV71gl4VNve+a7mhG/wg0AINZVJXshFlDjvmkd9MAkiovyCwP9t1pQ
	 LJJA1rhMImJXrBZlq1rB4HpGE95EW4qEtsNz0sYSOFTqIitPsQ5ciVrMRDStX8R1SE
	 8OE1obJb4jSajGyZFxSFFb4XuoeATEsGJuHDk9oGTFuJigl6RK6KQjEwgd741BzNKT
	 2XtVNk/hM7PldF3d6neux8mWAC6PtobkW+ahB1meoeN5bCJzI8qbSDbKHiRzym6Rj6
	 Tpn9tyLCEaajw==
Date: Wed, 12 Aug 2026 18:15:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Steffen Dirkwinkel <lists@steffen.cc>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Denis V. Lunev" <den@openvz.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	David CARLIER <devnexen@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org,
	syzbot@syzkaller.appspotmail.com, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Message-ID: <anyOHfbXJAAmbcdi@kernel.org>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <555ea1d43a12c30a8f1eaf10c899b3790d728f33.camel@dirkwinkel.cc>
 <anCK3eWFMwZqq5ka@pedro-suse>
 <anXvODEvV4f_Taj7@lucifer>
 <anxbSdxDlyq__-T1@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anxbSdxDlyq__-T1@pedro-suse.lan>

On Wed, Aug 12, 2026 at 12:46:09PM +0100, Pedro Falcato wrote:
 Just Hold the mmap lock on callers, but it becomes messy quite quickly)
> 
> Mike, if you get to queue up my patch then please replace the diff with
> Lorenzo's (with a Co-developed-by:, I guess, since he went to the trouble
> of moving quite a few things around). Otherwise, I'll figure out how to
> re-submit it after your series lands.

I moved some things around as well and here's what I've got:

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=cpa-fixes

Build tested only for now.
 
> -- 
> Pedro

-- 
Sincerely yours,
Mike.
