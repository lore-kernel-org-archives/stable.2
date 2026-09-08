Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7F51FCB9;
	Tue,  8 Sep 2026 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859948; cv=none; b=XpkxtBEwxQLa7i1JVWvwm+0+dbbLaYjx3NGhG1PnDt3g7P/IXyf1mhxJo8Op6Qsv4+oPA2KHXO5DBUN1WUyUecqlnQVg+SjDWcE0rqWmfOhMjmdm2RdGNWV241LVCvwe2sXORbDnIHS+u5grEyzPnTHpHFT7nJPFABCU2umnghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859948; c=relaxed/simple;
	bh=aXZvy3t5uEmnoTvZI22dGtDuapgAEzI1/ZtKnYO7O2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw+SZJ3/jQXoiZ34n80MzIyq2i2pGeu4QEzS3GAeSct5oN3TmYiAH2VdJHWMR2iupqxB+1Zjkid69BmI1iKp2T3YCBUuhtMKT5qISe06+CA8tyIchwqN4/7sqd5UGxNFb9K7LohfRL8a5BWzWexYOiubPsSex468J4rraTlX3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSQPSuWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSQPSuWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16A01F00A3D;
	Tue,  8 Sep 2026 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859945;
	bh=3rW2QrII8kDl2LLF5p7w/fphoAuD2u5vYHuEBkn+8Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lSQPSuWYgaWWTy6N7eYpTL48oaGXBzfFCXMy2PE4WLlCIlvHdPtoa+f7/KxiTQu3Q
	 2xdlb2EKSzUWGZrFmbk7PYKpNPFkqgjOsflqikUNG2EmCraMZG3ZUG5M6i8BY/rSs8
	 cVO6X8E+ym0Ey7f7vQdSTw6WjCm65Ubz+wMzisoFZiGcUEccwhDUHqKoL8eZ8AOw4T
	 e9vrDSDzv/9WUGMYfyZrFZhzBC68JxpwKFwoCJQV1boRLMK+AWhN0Evt1OZGN3UxVD
	 rP1dm1XpXnUfCIl1LaEyEZUCFqiCA2FoeysN1FbWLrWlYqd135hvf4of08sIZkfUf+
	 BgH+L8WyjuzFw==
Date: Tue, 8 Sep 2026 12:32:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Will Deacon <will@kernel.org>, David Carlier <devnexen@gmail.com>,
	Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>,
	stable@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip: x86/urgent] x86/mm/pat: Acquire init_mm write lock on
 collapse to avoid UAF
Message-ID: <ap_WIZwCPKB07nAf@kernel.org>
References: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
 <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
 <b2095df8-9991-4e65-9890-c34f8c206319@kernel.org>
 <apZ52DKlJIrpX6qq@gremlin>
 <7fe0aee9-d1e9-419c-9ca6-c0160223d5dc@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe0aee9-d1e9-419c-9ca6-c0160223d5dc@intel.com>

On Tue, Sep 01, 2026 at 04:36:38PM -0700, Dave Hansen wrote:
> On 9/1/26 00:10, Lorenzo Stoakes (ARM) wrote:
> > Dave - you've somehow applied this patch completely incorrectly to x86/urgent,
> > I'm not happy with this going to Linus in this form :/
> 
> Me neither, btw.
> 
> So, here it is applied:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=cpa1
> 
> The diffstat exactly matches the mbox that I sucked in. I'm going to
> launch some tests overnight.
> 
> The only things I really munged were a little merge issue with patch 1,
> a SoB ordering issue in patch 3, and a few scattered rewordings in the
> commit messages.
> 
> Not pushed to x86/urgent, yet.

I have to say I'm confused with today's batch of tip-bot emails saying Ingo
applied these to x86/mm :/

-- 
Sincerely yours,
Mike.
