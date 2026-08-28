Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6C3C4572;
	Fri, 28 Aug 2026 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896263; cv=none; b=OjLTD88K1u5BlpRetZB0gPqWFGoRnbn+q/dQyaeIDLwuZC+JL/IJyC0pL8clgT78CRHqhF6aqhGSvSFNsoNvbuRcju2W4ZVubepzJ3vnNgED5gU3Lj5KONWbocxFe+XqqvqOgwep0J9qcaSIZFPEJSZfX9gHC0GXqs5y1iRMyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896263; c=relaxed/simple;
	bh=0gg2/B3gl7R6BwfoU8E6hD/S6YU80248AA8eNR4WXvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roh+3/M1nXNM+mm91BW4J4EkP7GrbkaXcGzw8XRAyJoJwM610ffI+gteKG7tHhvAOwusvYBueRydVhBFqwos7wpQQxnrj8CcnEoyyv3MMo0VVdJAC7Ldn41q3oHjxt+NPzUNsGhEX/OOx264M74iANLLM0Ff0Z4A3iowP7yqMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GeWL3LH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GeWL3LH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118321F000E9;
	Fri, 28 Aug 2026 05:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787896261;
	bh=0gg2/B3gl7R6BwfoU8E6hD/S6YU80248AA8eNR4WXvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GeWL3LH3o8PYLj2yMA5q/J7/+NN848vEKuvzLuBo+JAWyoGBpB+nbmqLSmAwnew3E
	 HcAcA2AVR9vTcmOHrQ+tLn3L6q7i2N8H2h1u7jfI8ExqeOgWQSAhoBlCUbb08Ugcz7
	 ofCmhupMDwBiK5QVpkZazAjZ9rD/kiAEE1DJd3/o=
Date: Fri, 28 Aug 2026 07:50:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Daniel Starke <daniel.starke@siemens.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: pin DLCI during configuration ioctls
Message-ID: <2026082810-vastness-detest-6637@gregkh>
References: <20260828031949.18580-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828031949.18580-1-a0yami@mailbox.org>

On Fri, Aug 28, 2026 at 11:19:49AM +0800, Qing Ming wrote:
> Fixes: afe3154ba87e ("tty: n_gsm: add ioctl for DLC config via ldisc handle")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qing Ming <a0yami@mailbox.org>
> Assisted-by: Claude:kimi-k3

Please have your llm read the email archives for why you shouldn't be
touching this file at all, UNLESS you have the real hardware and system
to test it with.

thanks,

greg k-h
