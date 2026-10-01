Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6350435EEA;
	Thu,  1 Oct 2026 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790832802; cv=none; b=lOgHFopkE6E/dLj3UD0+UXWFUYbKkf2v+nUGR69adGs/Zw3DHc0v1DHp9DHdt6RbvQXUCEgRR7CB0V/aWCNtxScn7Ljif+6Vh/cCjLAiUM+XS0ZJrfMBGi1CsfFjWN63qknFyGgk1YtKzhPJotOD5jgRZ856I3OB5cp8Jx/cy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790832802; c=relaxed/simple;
	bh=XUDDvUFQpm+ruZEuCaUbfeY+kgHeu7VKphbsgiCi5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCbv40flLhuoFOsnPk/5i/iTmyfiBXAtWKOARaJUmmVGiiupH4AlWu04qhL9Il024fGGEX/0amG0cQ3IkyAVXVcw7jZw6etDlCQt4XTqBWwn1jZr36NQ0K1P8hI16Pe+ltFpCv66diIIUzZHjFfvsgwHDgy++Qjq2RiSHbqiD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lT86yK5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lT86yK5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A723E1F000FF;
	Thu,  1 Oct 2026 05:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790832801;
	bh=XUDDvUFQpm+ruZEuCaUbfeY+kgHeu7VKphbsgiCi5jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lT86yK5yixFyKx9TSEwzNcfiDruo4cXQNtTgbD7Yt9nxL3UbkYlmt6Z4V1SDwzOmO
	 aVRxeyie5G4KPo4CWHyvxBVmYsp6tglHGmSVtcOeuN0htuha9ZslZF9J5VGwdiUc9d
	 FKUAkEmSHABikg2nQCVoqAl5OuD5c8Nu3HE6esr4=
Date: Thu, 1 Oct 2026 07:33:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yudi Yang <2000jedi@gmail.com>
Cc: vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
	elder@kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio_codec: fix stack overflow in
 stream name parsing
Message-ID: <2026100106-starving-agenda-f750@gregkh>
References: <20260901185600.2725678-1-2000jedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901185600.2725678-1-2000jedi@gmail.com>

On Tue, Sep 01, 2026 at 01:56:00PM -0500, Yudi Yang wrote:
> intf_name and dir are 32-byte buffers. Parsing a module-provided AIF
> stream name with unbounded %s conversions can cause buffer-overwrites.
> Limit each conversion to 31 characters.

How was this issue found?

thanks,

greg k-h
