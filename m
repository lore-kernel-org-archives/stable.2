Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3935B137;
	Mon, 22 Jun 2026 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106392; cv=none; b=nm4D5lAqKKlZVIFTY/+xu5e/6JlydUztRcuUs6vd17bK1loHEaxVOiOZusNgqRm7oLu/Gg3L09U6SdVtfe31dtBx5gC68+sYKGPcnX9HMKVtKoRtrrvokO/yN42OaoKG4FLY7FwfmvZSE/lxJ0I//0H/pe+UPdtn7Ux9HAWfKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106392; c=relaxed/simple;
	bh=rNoK9fF43K4ybem9tlRR6n5CVAlpePxuA56MoHLiusU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bShOt4yRAUvhckBmfbQ99fAHFNyT4rCDAlzp6zaIpPEactqGaj3bMBPsw8313Vs1nmuVijwVJ+Fd/XJAORW5IYzhHa6KX3Uw07d4XD3w+Roz9gupv8ZoP8mHPYaCXB0nlolJd3RvMaI9pYObtXrzvn0q0rhOnJEthqTuXrwIR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpgvY5+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpgvY5+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A01F000E9;
	Mon, 22 Jun 2026 05:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782106391;
	bh=FnU02T+zKMErLH/eeB9bLxYz2Tm1NphmIy9sh7U8WKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UpgvY5+e1fDZ/6fEw0Pnebokaf9evWPUmG9hAkFLD8oRdHC5Vc1yUG7FSH47XKRg8
	 5hiODGo9hVgAbfg1IHC2aWIbKJVrgomL3KNQa9NJWeaKLd0+f8WqkEV/U3AeAtM4Wo
	 9cqHrlYoSV7lBnyN0NJrFpJBH3KsuxhOpVV+A7DY=
Date: Mon, 22 Jun 2026 07:32:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Some 7.1-post fixes that might be worth picking up rather sooner
 than later
Message-ID: <2026062236-ludicrous-detached-6e20@gregkh>
References: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>
 <2026061917-flinch-idealism-898f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026061917-flinch-idealism-898f@gregkh>

On Fri, Jun 19, 2026 at 11:43:41AM +0200, Greg KH wrote:
> On Fri, Jun 19, 2026 at 08:04:35AM +0200, Thorsten Leemhuis wrote:
> > Hi Stable Team! From the regressions point I think it might be nice to
> > pick up the following changes for the next round of stable updates (e.g.
> > 7.1.2), as they seem to fix regressions I've seen multiple people report
> > with 7.1:
> > 
> > * 426e5846eba75f ("HID: Input: Add battery list cleanup with devm action")
> > * 12f58a6caad3be ("drm/amd/display: Fix Color Manager (3DLUT, Shaper,
> > Blend)") [v7.1-post]

This doesn't apply to 7.1.y, and would need a working backport.

thanks,

greg k-h
