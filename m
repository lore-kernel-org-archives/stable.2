Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9C4052CA
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821199; cv=none; b=b1ZTktxv9NjB+gHcsfMBS4J/cwKOislwoJkVvIXNhZxbEPW71aLZDF8iCyL4052LIUddfYPV5Z1ZWS1P8SsbfVc/pqt42ANr/3oxj6ULDYQTO/gOrBIZX5D5wDJmGEjMbGJ+q/CKQgMhNMHO0Ds0nkfVWE5raRKnLi81H2boteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821199; c=relaxed/simple;
	bh=mkBKvYTRgSGqAkoi0DKVqZ3u2dui3jghVD4vTRjy1Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgLBaUCXFWZuj0FkypVtlOAFfJ9o43Tbu2eoRqjganbNqfe7jPNPAlDGmLkKmgLj9+ZOyKZ2Lx7kymlTR62zOWDUlZY4766fpDrpTu4BerLyExM9y7rTFFjWEnHy4gh1RBOCXNARFPCtBN3INmlXTrEXMfHGHSkpkaUcEhaf984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gqT2crEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gqT2crEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC981F000E9;
	Thu, 27 Aug 2026 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787821197;
	bh=1cVdaMhvVngnAvQRGZ+UuClwdQKN8PXrxrz5Uj7W1mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gqT2crEKzkUuYFpZXWa7+89SGWp/1p4m0EZs01ZoGtXY0dG4LgxElMdKp2PSb9TRK
	 SsZEQ8kaBiCSxu/3pSgd4XSAdytVhKFqYmU99DMYzl3FfxuWHwv/fWa/UkmnB6ZJaH
	 CenQmN6XSvUSABZ7x3XnHwNSM2KGpwyv1lIWGnPY=
Date: Thu, 27 Aug 2026 10:59:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: sashal@kernel.org, hexlabsecurity@proton.me, paul@paul-moore.com,
	stable@vger.kernel.org, stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.47-rc1 01/10] Revert "selinux: require a class's
 permission values to cover its permission count"
Message-ID: <2026082710-viral-doorstep-98c6@gregkh>
References: <20260827050834.10002.stable-daily@kernel.org>
 <20260827083802.4044165-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827083802.4044165-1-guanwentao@uniontech.com>

On Thu, Aug 27, 2026 at 04:37:55PM +0800, Wentao Guan wrote:
> This reverts commit b6336a9b52baa35136f024ab30929fdda83b3160.

Why?  And this is not a real git id in the linux-stable tree.

Do you want me to just drop all of the selinux patches from the 6.18.y
queue right now before I do the release?  I'll be glad to do so, but I
need to know why.

thanks,

greg k-h
