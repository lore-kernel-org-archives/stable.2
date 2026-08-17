Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC92AE7A
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786942899; cv=none; b=gh/6FfIhmAfk4hkQKoPX3x9+VcIEUPYyopEYfJBc4/wDss9EuFphgplVHDPNk0W7RQX40Xh9RSUXDLNRK8rxbbkscrkk9m9dhCAFDwYLwtUkPPVq0xIe5FvZKblrvEWJ31Y+/SwBjlSua8A8QBzXMXRzoE4oB8F01YMFp/YCVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786942899; c=relaxed/simple;
	bh=BxsyqwhhFB+l8Wo9i8wNGnrbRKSbwQjrHVH7jHFKRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylrgjt0OTj6apMp7x65O1M4Mz3kkBrr0uLXUYUmPL+5mlBZEaeSwRixXk3wdxZczeeMi+EedBPbuI4f3dnVHnc/fLEALCVTy3frx4IrLzF0xJ+5lJKNNuW86jmuHt2jP5o6BXYM19CWptqM4wxaD5fj6UaU8uJsSXEDSC84MMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gzO3Fix7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gzO3Fix7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA07B1F000E9;
	Mon, 17 Aug 2026 05:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786942898;
	bh=LR6swIVa8vuPJsZG/ZYc8P7ruNYeDeQV3HIieYo5Upo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gzO3Fix7TILoWSVQ/DE+LmClLDqmR28Ctwl/6wcuxBvOEoUqIAbK6/LeYa51z7Gvi
	 8rpk9J5BZ4RyQA7yadRBTEwc9U75tkTL4BinOC3lKBn8s8riNt6G9mhq31oX0xKoKm
	 vNiQF26+aCJsmseKzcszvR2iD2J9BOEnO86Vw7gM=
Date: Mon, 17 Aug 2026 07:00:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	dmitrii.omelchenko@cloud.ionos.com
Subject: Re: [PATCH 6.12.y 0/4] crypto: ccp, KVM: SVM - missing SEV/SNP
 platform-init dependency + 2 bugfixes
Message-ID: <2026081730-denatured-spiral-61b2@gregkh>
References: <20260814100652.225499-1-jinpu.wang@ionos.com>
 <20260814193000.15@kernel.org>
 <CAMGffEk4a8cF4utrMYpNvbcxBvuEhPnTY33_3GGs3RU4uy52vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEk4a8cF4utrMYpNvbcxBvuEhPnTY33_3GGs3RU4uy52vw@mail.gmail.com>

On Mon, Aug 17, 2026 at 06:51:27AM +0200, Jinpu Wang wrote:
> On Sat, Aug 15, 2026 at 4:33 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> > > Patches 1-2 are the missing dependencies of commit 3f8f0133a5fc
> > > ("crypto: ccp - Move SEV/SNP Platform initialization to KVM"), already
> > > queued as of 6.12.97 (bb1c8464702540 on queue/6.12). That commit
> > > dropped SEV/SNP platform init from the CCP driver's probe path,
> > > expecting KVM to take over, but the counterpart commits that give KVM
> > > that responsibility were never queued alongside it.
> >
> > Queued the series for 6.12, thanks.
> >
> > --
> > Thanks,
> > Sasha
> Hi Sasha,
> 
> Thanks for queueing the series.
> 
> It might be worth adding a rule for the stable-kernel scripts to
> ensure they don't pick a single patch from the middle of an upstream
> patchset. This could help prevent future regressions like this one,
> where a commit dropped functionality in anticipation of a counterpart
> commit that was left behind.

How do we "know" a patch is in the middle of a patchset just by looking
at the git tree?

thanks,

greg k-h
