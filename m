Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD047DF8B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629097; cv=none; b=PqYE2ND7qwPNCFp2Gvn8ZtX6kgB6zLkOY9TRTwz+wJz0+IU7l1u8qkocaX9lMNynrdLvfzU+ZNlGE78RbTsfGGzHhJdVFjzJpCyYIIkDXl+f3LHaVNBijKthjOVurG4OvmyQlyYuCo5YvTFLfnqhLOrvwNUpGXPeCTrJ1UNsyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629097; c=relaxed/simple;
	bh=s7tm//mRPBsDb3t7vmY9bmWaaE1iBCc5iCpZfh+zNUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahzkt724r+PBfLgCbSBSCNVzmpYFlnydfZ2DQdvyZ2LHUK05rJ1HTq98/Qg9wvJ2/I743Wg9aCCABClH57jAVCFIE5NHWA6uefxjhDMEAhijfsr0fxt7eej1RNaRjN5e/usQUL3PG/sR67q8m3YTYd3g71Qg46tseIeJDFOJLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ohnBcEIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ohnBcEIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED02C1F000E9;
	Tue, 21 Jul 2026 10:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784629092;
	bh=VonXgQB36krwEmeV3j4CGguUXdDRi+zB5FY0bJezKW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ohnBcEIhUfXferlV9WYmYIsVV8YvOI+cGehPPeYD114zsSnconm4h8TpK7sJDadsG
	 AhVowbxZI1Ist7wFm9d8ihlYdu/a9sSj1TBtb3oyEBB80BeagE4mz4tRORPQHiMpd5
	 9qbPSIj76cUsIvREUCiyI5Fdn6fOEJh7aFDuA8aY=
Date: Tue, 21 Jul 2026 12:18:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH stable 6.18 0/6] bpf: verifier: linked register tests and
 fixes
Message-ID: <2026072146-apple-condone-0ef6@gregkh>
References: <20260717044731.121353-1-shung-hsi.yu@suse.com>
 <20260718192718.0008-stable-reply@kernel.org>
 <al7zWrJAeYdQ2ytz@u94a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al7zWrJAeYdQ2ytz@u94a>

On Tue, Jul 21, 2026 at 02:45:15PM +0800, Shung-Hsi Yu wrote:
> On Sun, Jul 19, 2026 at 11:00:22AM -0400, Sasha Levin wrote:
> > > This patchset mainly aims to backport upstream commit 1b327732c846
> > > ("bpf: Clear delta when clearing reg id for non-{add,sub} ops") (patch
> > > 4), and its selftests patch in commit cac16ce1e378 ("selftests/bpf: Add
> > > tests for stale delta leaking through id reassignment") (patch 6).
> > 
> > Queued the series for 6.18, thanks.
> 
> Hi Sasha,
> 
> I realized that we have commit b0388bafa494 ("verifier: Relax scalar id
> equivalence for state pruning"), but not the preceeding commits in the
> same patchset[1]. I not certain that b0388bafa494 is expected to work in
> isolation without the two previous one:
> - 3cd5c890652b bpf: verifier: Assign ids on stack fills
> - b2a0aa3a8739 bpf: verifier: Clear singular ids for scalars
> 
> I going with the conservative approach of reverting b0388bafa494.
> However that also means that commit 1b327732c846 "bpf: Clear delta when
> clearing reg id for non-{add,sub} ops" will no longer apply cleanly. Let
> me send a v2 to address this whole thing.
> 
> 1: https://lore.kernel.org/all/20260203165102.2302462-1-puranjay@kernel.org/
> 

So should we drop all of these from the 6.18 queue at this point in
time?

thanks,

greg k-h
