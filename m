Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCC348465
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821139; cv=none; b=tGDj2NQTYOE6lmjluNsuIJCCC7AP0XgsNPYqcnCtOy+E0JZz/axoRJRMJYcuanCEJojEdWNr6twr0ZTvr3wUU53N5GP3UPV0fqsx+9iKV/zfsgW+0/dZ1iTF+wSmav+3ZU9viIaflAsYnOUlodH9dBtpxPrzk6E97mOPaegVnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821139; c=relaxed/simple;
	bh=GQm+nNyzTCfmvRI1waZDd12WExEiQKhz8Rd3iQ0y+bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuE92RiLeyxX0CwKEMBrTbhAmmRcxfTmC6cyXeDEpM7jPtT6dpqBdRcMzIsEXDuHJof/r9yD2gFtk2RNIvxYzu8jlra68frEBaUpkwZe0XncTqTszRCyNO/Hb67VD+53gw6p3W55f4oxCMkka0Y+ulou8tqTfMZpcwa1r77gB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jD4LalVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jD4LalVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823681F000E9;
	Thu, 27 Aug 2026 08:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787821138;
	bh=6fiIro+qxulKHhi3b8BKV20LlstmBsErTLxoywpkl4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jD4LalVH3lOKeYLPH4FhPyWDZkypBlSWk9z1BVppRKJETcTW9H7v6EO78gHb87wsa
	 RB7aoyLyOh/T9ddAcSscEqU+tZ64gdHVuzOV0W7MtfRiq3K0R65bbvqsvVyKRFmR1p
	 1Pl+Zgq+iX4Pz3puM6T/DPwj/Dcxf2AsxHmJlvew=
Date: Thu, 27 Aug 2026 10:58:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: sashal@kernel.org, hexlabsecurity@proton.me, paul@paul-moore.com,
	stable@vger.kernel.org, stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.47-rc1 03/10] Revert "selinux: use u16 for security
 classes"
Message-ID: <2026082728-sneer-ecosystem-fce3@gregkh>
References: <20260827050834.10002.stable-daily@kernel.org>
 <20260827083802.4044165-3-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827083802.4044165-3-guanwentao@uniontech.com>

On Thu, Aug 27, 2026 at 04:38:00PM +0800, Wentao Guan wrote:
> This reverts commit 3683f35c14816f827a80e217072018eb6c37422e.
> NOTE the commit revert the commit in stable-rc/linux-6.18.y

But why?

And a blank line should go after the "this reverts".  Or just use the
standard git text here?

thanks,

greg k-h
