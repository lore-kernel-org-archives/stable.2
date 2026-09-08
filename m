Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC45392C4B;
	Tue,  8 Sep 2026 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862328; cv=none; b=CFzKxhzgvfDaFBsEFJL1oqxFVzlBq8ZkCWCUsz5IMt9Y0jPjN7aOOYjVtbYhqgEESTKBm1pcIMWj7YqDuBcr+w3UAYHkCZkn1hEuHnq2BkJiube/7TlCe8dimirKoSAk4DYq/8HiJqsVm965n79L3IqE7XLxqP6t364Q2rChMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862328; c=relaxed/simple;
	bh=2dvmuQE1lrmfcEaPMxFCDlNU+EOHjJ2mW30kGX9NQu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVDI4PAckwPkfjWpznvUFwa1bT2Ij8tU0DPwFhF8h8+US52OgSbObT9H0TMOVt+cjgjvCF9Omja4u2BANGbSngW+oj0pcF0SC24vOf07l6sT0EINhhvrzmezcJcjDdnSwdhUkMREPuK6n1QFmeFrNvx+AYLEueh1X2WaHq3sKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX3LGGwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX3LGGwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410A91F00A3A;
	Tue,  8 Sep 2026 10:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788862326;
	bh=h4+NbS/bxE87beuPTf+FpRA7Xpg3PIxenn0XWkscecE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VX3LGGwlGLTIPMgqXpOTf1dExUEurscHoeOb9Ed9Wjdbp6KYOwUDiekWAaAlZ20Vb
	 Kq7ikvhZy1FE0KDryzxaPo2KWwHgU1pXD0IgfsYSOvLL3P7MdOyHHmfybfLvPSkBgw
	 Z/2RG3OhhGZiY9o3dNza89vPuMBivBmnRhj1t69fVMmuSbn4fYHPiUUWSSimf6WvB7
	 fIkiJif0KUwIUBOvxUtdBB/Z7tXUqWRR28gPNQwkEwasf853uv8HVHzZyh/MFSsv7s
	 rF8BvpWIlhjB0hGy2jytoesNrllw6l+GbGjHd8Sbvcprkf4ZTVmm+1JX4tzz4fub2u
	 NcjnTOKwHfNpw==
Date: Tue, 8 Sep 2026 11:12:00 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Will Deacon <will@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Atish Patra <atishp@meta.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip: x86/urgent] x86/mm/pat: Acquire init_mm write lock on
 collapse to avoid UAF
Message-ID: <ap_XuF3ubLQAJ330@gremlin>
References: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
 <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
 <b2095df8-9991-4e65-9890-c34f8c206319@kernel.org>
 <apZ52DKlJIrpX6qq@gremlin>
 <7fe0aee9-d1e9-419c-9ca6-c0160223d5dc@intel.com>
 <ap_WIZwCPKB07nAf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_WIZwCPKB07nAf@kernel.org>

On Tue, Sep 08, 2026 at 12:32:17PM +0300, Mike Rapoport wrote:
> On Tue, Sep 01, 2026 at 04:36:38PM -0700, Dave Hansen wrote:
> > On 9/1/26 00:10, Lorenzo Stoakes (ARM) wrote:
> > > Dave - you've somehow applied this patch completely incorrectly to x86/urgent,
> > > I'm not happy with this going to Linus in this form :/
> >
> > Me neither, btw.
> >
> > So, here it is applied:
> >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=cpa1
> >
> > The diffstat exactly matches the mbox that I sucked in. I'm going to
> > launch some tests overnight.
> >
> > The only things I really munged were a little merge issue with patch 1,
> > a SoB ordering issue in patch 3, and a few scattered rewordings in the
> > commit messages.
> >
> > Not pushed to x86/urgent, yet.
>
> I have to say I'm confused with today's batch of tip-bot emails saying Ingo
> applied these to x86/mm :/

Since I don't seem to get replies to mails on this topic, I can only
_guess_ :), but:

* I see patches in x86/urgent that aren't in x86/mm, so that rules out
  x86/mm being a stepping stone in the process.

* x86/urgent has had more patches added to it, for series sent after this
  one, which fix bugs from 2024, 2025 etc. So that's all working as
  expected.

* We've already highlighted that this series fixes bugs users are seeing in
  production, so I don't see why it'd be deprioritised.

* It's coming form a private dev repo/branch so I can't imagine it's a
  wayward script (but maybe?)

* The patches have been in linux-next for a while (maybe Dave/Ingo wanted
  them there longer? They were there for weeks before the ->x86 stuff
  though).

Perhaps the reported bug that you've now fixed was the hold up? I guess who
knows :)

So yeah, I'm also rather confused :)

Ah well.

I guess taking them through the mm tree wouldn't really be sensible/the
right thing to do at this stage, so I guess let's hope they land for 7.4.

>
> --
> Sincerely yours,
> Mike.

--
Cheers, Lorenzo
