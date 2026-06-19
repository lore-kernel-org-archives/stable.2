Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92224B28;
	Fri, 19 Jun 2026 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862290; cv=none; b=YNokJ43p7q2eg7xmv0Yqkap1FK2Zzka43a23zt/VMa+AVVuCxwbwvaEIpKXA95tyyC8JJW5wSrnw2uRIKj23kk4Augs/hg752X2qyeO08cpAxyiKqItX+x6WNipkKXJeVLyDvQT6wjvW+cQ68XXrCtIpF/lbop+UDFYqrr4GEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862290; c=relaxed/simple;
	bh=YJjsplBXA/Xq/QxZsOPrbiL8KWnBm27J4X4az8Skpfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCdRwrUREDgxsbWYLbwWFImaOR/0IjjJskX61xpgzimLRfJ6yf0fkNCiS9qMtbRBGsq3gaS6I47TmKFxBpAPMuXHVg0gxGOcCuaZAP95Qb/J/3K77UgzvnscpIELZ0xP2mkUvZ2gjdzjvxv737JL10RP5yYqfou8/dE23HqEc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2mIeMKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2mIeMKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B154F1F000E9;
	Fri, 19 Jun 2026 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781862288;
	bh=v1DvtncW9sxlEd80Ac4+Js1tO1vrXbjdLJ1eUD9a+dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q2mIeMKxr9w5K3LB/ZeItslA2luQpYE3eXU41HhAqxqjhA3Uq8AnDY5FRuL8fwO0/
	 xH9N02VTtF5nD7w3UEIpjeuvhmlIxov9g8emBi5gb7cn6TBK+pJZBWN668/ClmI3/j
	 lI/fDcpluPPefe3FMDLmf2cggPchXHvmbDe5q29s=
Date: Fri, 19 Jun 2026 11:43:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Some 7.1-post fixes that might be worth picking up rather sooner
 than later
Message-ID: <2026061917-flinch-idealism-898f@gregkh>
References: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>

On Fri, Jun 19, 2026 at 08:04:35AM +0200, Thorsten Leemhuis wrote:
> Hi Stable Team! From the regressions point I think it might be nice to
> pick up the following changes for the next round of stable updates (e.g.
> 7.1.2), as they seem to fix regressions I've seen multiple people report
> with 7.1:
> 
> * 426e5846eba75f ("HID: Input: Add battery list cleanup with devm action")
> * 12f58a6caad3be ("drm/amd/display: Fix Color Manager (3DLUT, Shaper,
> Blend)") [v7.1-post]
> * 342981fff32802 ("drm/amdgpu: drop retry loop in
> amdgpu_hmm_range_get_pages") [v7.1-post] (Alex provided a backport for
> this in
> https://lore.kernel.org/all/20260616130531.738887-1-alexander.deucher@amd.com/
> - this one affects 7.0.12, too)

I took the first and last for now, the middle one is "big" so I'll wait
for the next round of -rcs for it.

thanks,

greg k-h
