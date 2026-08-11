Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9694B0486
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415293; cv=none; b=Anw+4uZ9uL7F8yg1mkY9hGFn22OJT0nQXv0S0HbMi43ApdGfwocDvPdyOgBO+aTU8XCWP+JFPUW2NdQHpg9Yv2sipL/gQqLVtViMMU37pSgwy83tzBIO1ZR3WqZ9o6M/Y0hY+hj7fhcCzAk9GytR8DORnja66UHwePWOK1N0avU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415293; c=relaxed/simple;
	bh=uvx2J8Kwnq3pK/ReEOH8xyx5bDJpYA2EVlqj2212Fww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p451BdybIivGSKjhLlBqZ21V7VSD0ZhZBjpojeDrCTcqPrFjbwDS1p8Zot4E+CRwbM2WWtBUe0sy6klKmboqbknHezUI+axWyUnG/SzSYyBdgKR2S7MG12ms7PpQ4JcC7WPV2LJEgsNaXJH3WAILmQ1whR8fvvxGdwQdiFEigl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m2n8hkh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m2n8hkh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765091F000E9;
	Tue, 11 Aug 2026 02:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786415291;
	bh=XOl9/Sm7kjFPeJiwgYU/095aX+Z8syqjZ2lYENTKrDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m2n8hkh4iQ4oj9u8R3a2iE3dw3qJ0s7z84G4pEQlrl4033hEGt2SL5YEWqklfj6YG
	 GQu8LuVhmAz4mpdt9UNAGNGVCrX0IfGW+qpL4pc+cNNiSOMa81ErnkIqFqHScraiwZ
	 PLq+3g1kjCzyO4UqlnvL+6A0slfX2DEIYhkDnHW0=
Date: Tue, 11 Aug 2026 11:26:39 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Petricek <mp@petricek.net>
Cc: stable@vger.kernel.org
Subject: Re: [BUG] apparmor: deadlock in complain-mode change_hat
Message-ID: <2026081110-scenic-ditto-22e5@gregkh>
References: <552f7777b10a92ef675cb12a07ba8b7b@petricek.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552f7777b10a92ef675cb12a07ba8b7b@petricek.net>

On Tue, Aug 11, 2026 at 03:46:21AM +0200, Martin Petricek wrote:
> Originally found in 7.0.0 in LTS ubuntu 26.04 with pam_apparmor + su in
> complain mode set to change hats.
> Then verified in newest available vanilla kernel I've compiled to see if
> still present:
> 
> 7.2-rc7 vanilla -> affected

Please resend this to the apparmor developers and mailing list,
stable@vger isn't the right place for it.

thanks,

greg k-h
