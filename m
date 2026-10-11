Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA1638736F;
	Sun, 11 Oct 2026 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791711522; cv=none; b=jifTojCrrVZghtdjXb8aisWOh1Bhol1rvTNqmBkyfvk7cSQFJt8he3ckTM2eoQYkh4p8vmv24ZdsL9Eq3BN5PZRM9tBzEytXhzpZMpyHj0nNdF/LYwUHpJrbIl6pysxC+H4F/+nAf1r9OU2hPWrOI49lRSCqN0dd48/5P7MpGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791711522; c=relaxed/simple;
	bh=Zv8knCoY4YDVkjs4QNk7DsICwc53qbczaL0KtwolOvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kipzQliYCTRzePGBWK/WVHy7wET5zFM4ZRUlFxOb1bvrTZSoADpVtvrqVynNurtx9hUA8637Xatp4avX5oBIzxLaax+60X02dry8ERDjR0AaFZWEp6if+gt2PM9i5/3/M1dJexGLLgEf83D7WVVXbpc91rPBbIInznX34XmqreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqZZ0GCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqZZ0GCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3359F1F0089B;
	Sun, 11 Oct 2026 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791711520;
	bh=gxIgMXWd6poINFuGgBiWkj0WE4vpKzNx/D7kevqt618=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VqZZ0GCXwG+eKFO7qehwyOKdV50McF+1gEMKmAmhh94h5FSBW9B8ZivaWoCCkVhRT
	 t1EUkZZOfzxDmqucR/SHfwYd4phaoW4orJ9RYH2KrCExgjSPgnR5nZs+wS+psL7UpB
	 QBET1iaZWWvJ1H26uvXbqshlyJI7uTboOnnFob8s=
Date: Sun, 11 Oct 2026 11:38:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Adin, Menachem" <menachem.adin@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Joe Finzel <joe@sudmix.de>
Subject: Re: [PATCH char-misc] mei: me: Revert "mei: me: add adler lake point
 LP DID"
Message-ID: <2026101101-muscular-nuclear-c7ef@gregkh>
References: <20261011-remove_adl_lp-v1-1-177758bd617a@intel.com>
 <2026101122-immature-endurable-3ea6@gregkh>
 <PH3PPFE241D7F14B2822C509470D836EC5BED902@PH3PPFE241D7F14.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH3PPFE241D7F14B2822C509470D836EC5BED902@PH3PPFE241D7F14.namprd11.prod.outlook.com>

On Sun, Oct 11, 2026 at 09:23:07AM +0000, Usyskin, Alexander wrote:
> > Subject: Re: [PATCH char-misc] mei: me: Revert "mei: me: add adler lake point
> > LP DID"
> > 
> > On Sun, Oct 11, 2026 at 09:29:12AM +0300, Alexander Usyskin wrote:
> > > This reverts commit 930c922a987a02936000f15ea62988b7a39c27f5.
> > >
> > > This device ID is not belongs to HECI and added by mistake.
> > 
> > Should this say:
> > 	This device ID does not belong to HECI and was added by mistake.
> > 
> 
> Sure.
> Sorry, my English sometimes betray me.

No worries at all, I just wanted to confirm this.

> Will do v2 with above wording.

I can edit it if you don't want to, not a problem at all.

thanks,

greg k-h
