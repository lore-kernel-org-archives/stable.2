Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE707347533;
	Thu, 25 Jun 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395940; cv=none; b=ehCym39iedtXFbAtl+XwCOJ+qRzXDbBkqWloCE+n8FRsOb0nR4DfusV1yyK506LIAfdRtyREyT8PQKhj/xxmqzk/PVZqLfUKh8SOLtP1V94R+TkCOqJ/DFcK33RAbVwhx12HrgfVG6Lz3KshnKAkDlMiizG+ZcO8NsNwl9NvCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395940; c=relaxed/simple;
	bh=arpdqMBK1DxE/UaBLFUczloVuJe10Z7gXUNKH0YnAWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXqH4dWtUbivzEY/0uyijcUhI6uKXD03o+zfu+GSJZKhlWJxXISiXP5yGMwNeRe7zjlIXWQZiLErC6Jv5HIWid4ngFjnS36iikD2V6uGNRfJXR7B/+rz2mlt9R3Q94cyCIV5fn3GRMI/Y+9znevOVPJ835qBiLKTKNB3FkNfJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mXQzo0Ci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mXQzo0Ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DB01F00A3A;
	Thu, 25 Jun 2026 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782395939;
	bh=arpdqMBK1DxE/UaBLFUczloVuJe10Z7gXUNKH0YnAWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mXQzo0Ci6B+5FklRLX6RHmJ3tGv70wTykauTZlTM26stpjQXIaUvACeAeACufGn0j
	 7smCtpVWQTvrCyIU9KEvRxndZGhjNLpbnT9xMUpGXa5XB/e7HC+rDqkEqeqCK1WC9j
	 QKlz9wFjqbnB0Tzguxd4k80V+Bnsv76hBk7I5sMU=
Date: Thu, 25 Jun 2026 14:57:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Korwel <adriank20047@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_uac1_legacy: fix use-after-free in
 gaudio_open_snd_dev()
Message-ID: <2026062524-puritan-satin-f415@gregkh>
References: <CADgB2mFBdTbad5+W=bDOMO+fe1S4jg+aCNjkgd3B3Guq0WFQdw@mail.gmail.com>
 <2026052528-resupply-fanatic-496a@gregkh>
 <CADgB2mH8VayssgQmuyfMJn8Vv-o8_udfL6msVGrHrL1hO9nd4g@mail.gmail.com>
 <CADgB2mHJG5dJwzjBML08C4yDUqLHJY=Vmv6yffiiczc98hqnNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADgB2mHJG5dJwzjBML08C4yDUqLHJY=Vmv6yffiiczc98hqnNA@mail.gmail.com>

On Mon, May 25, 2026 at 09:33:12AM -0500, Adrian Korwel wrote:
> [PATCH v3 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in
> gaudio_open_snd_dev()

This should be in the subject line, not in the body of the emails.

Please resend a new version of all of these in the correct format.

thanks,

greg k-h
