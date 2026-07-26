Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE432695F
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785064725; cv=none; b=Kffh+/ZN6mGXh/mPcQHTDC+oVVo6wv0dYAQ26dSCTEqhAyEhgIzDhAFdG9/gJgF9v8qcSFnCKsZU5h8AHx8Y3xjhI7VuQ+dlFqpE/z4g/pgOnE2u/bmn7T75VaHC7GRIa6ubR1CSfvZRMB/Xuy0H/pnaPJNSIo8bd7ZIVSm5ArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785064725; c=relaxed/simple;
	bh=PIZphixBRJfF7VnkS9m9WC6SLVx9Jf+lryF2NDZauQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOWzciFzc4huGyRux3Cw7vT83MiaDO5UChgwJjXPSZCQk6ZLJCv+JsCP3zndZQamfrQe5KDPhoS8n/q7QFTW4uYu6EoQ0tfp9qEk769NMit38F2vX9gHtxUjGANvqwioO5gfa7n1FaCqnED9BThBYv3B+ayPdh6t8CpZSfHv5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BF23+9Qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BF23+9Qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74B81F000E9;
	Sun, 26 Jul 2026 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785064724;
	bh=65QY4t0vANPNUDsuqiuRUYMJIlYwyBXa7Lu4VelOViE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BF23+9QxF/JmQLh90AFidIfpkzxdf7p7pUjVELr19dUYDZ28lWwSlrXI2RCxFLXoj
	 nfywiWW0kIXhGc/1YVAWmpo0/myidEbD47W6UOnUfk1mcN7lXZznQL2aBEkYQBa4cS
	 SlG4+JEwu0LLwKMXDkKn6Ltiw8mZtUldcQefaea0=
Date: Sun, 26 Jul 2026 13:17:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net 03/19] can: raw: add locking for raw flags bitfield
Message-ID: <2026072653-handheld-reliable-4a78@gregkh>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-4-mkl@pengutronix.de>
 <0f3b44bc-41bd-446a-bceb-bb2c9581ee6b@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3b44bc-41bd-446a-bceb-bb2c9581ee6b@hartkopp.net>

On Sun, Jul 26, 2026 at 10:08:52AM +0200, Oliver Hartkopp wrote:
> Upstream commit 1e5185c090589f4146d728ab36417d8a5419f127
> 
> is missing in stable.

Which stable?  And why wasn't this tagged for stable inclusion to start
with?

thanks,

greg k-h
