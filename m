Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F4411FA6;
	Mon,  7 Sep 2026 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766682; cv=none; b=nC+pGu4zc8k212ddHBJ3yV5L7kIAnCPxfQlDlemKAG86Q5RLDmIzgy0hdgsoyf5F58oGw+T0Yl+Xs3edkHhjDBvd0epIVU52JIKsOj9xbwsYHU9ieFcv7qARBRDFDygfJKY/Awto8qcKfHwTXfxwlnqnjUpZllFviZwr5QpOVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766682; c=relaxed/simple;
	bh=FcvyMsN2Y/2wqWW2fII8hRnosNTpLqPhiINrk7zABWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWRlneqIJZ1pe9Y0vdb/40JTg4+o8UZV3eIP5W7y5VsNypRjUXRscq435IdxfeprDrgZukNIeysJTewlmg4K6MdnV+fFijPVylh4UuXjAlE4enFt2zd52XnrCz0KrLx6E+UnNjrWoirvnQtk17/MKRPks3I3YxHLCBToHsxtLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxZJi7pD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxZJi7pD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5BB1F00A3A;
	Mon,  7 Sep 2026 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788766680;
	bh=rvvSSkjN1ltD4iZZgNnHKnwxDoVNhjzhE4/tDcpCj2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UxZJi7pD8/HCq8M39HOFHKXpa91z/Gae2k1ElqtMgy6UwaKnbXqDBnkjRVTTUG+nh
	 Wi9aPKaYECnWaynnQ5BWdv9jL5mGcP3/CueTxDXPfvncUNoeQR+E3mIAMo2tFlPAAq
	 PkZTvOeskT0HDu8yUh9h+f5VH8hKaGTw8JjY5qlv7aDYVLR0pPi2mwxn0FbeQ7ukDL
	 yZZnAPPE4fgEmVQQiQSg/E950ovvzGE8TbRZlh+eKA71EZwfz1fTKhhS6f1f3vd5yL
	 YptUCOjSXZvK0Hr2T/55LLU85jh9cPAsPz4vmGCAYcvhvqErF7ejQ7d3RHfvcMVudk
	 w7zJpzsEAwuVw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3TvS-00000000R3d-0A3V;
	Mon, 07 Sep 2026 09:37:58 +0200
Date: Mon, 7 Sep 2026 09:37:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] serial: revert guards in uart_wait_modem_status()
Message-ID: <ap5p1qzbLn1mVLrb@hovoldconsulting.com>
References: <20260907064418.92953-1-johan@kernel.org>
 <20260907064418.92953-2-johan@kernel.org>
 <3f33d9f0-65c2-49b7-bb6d-2fe33f0d8fbe@kernel.org>
 <b504b8a5-8bc3-49f2-a01d-4f24f46f84a0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b504b8a5-8bc3-49f2-a01d-4f24f46f84a0@kernel.org>

On Mon, Sep 07, 2026 at 08:51:26AM +0200, Jiri Slaby wrote:
> On 07. 09. 26, 8:47, Jiri Slaby wrote:
> > On 07. 09. 26, 8:44, Johan Hovold wrote:
> >> Mixing scope-based and regular cleanup is discouraged and
> >> uart_port_deref() used by uart_wait_modem_status() falls in the latter
> >> category.
> >>
> >> Revert the premature guard conversion in preparation for fixing a hangup
> >> race.
> > 
> > It's not premature. Just convert uart_port_ref() to guards too. Gotos suck.
> 
> (Or don't use gotos and I will.)

I guess you meant "don't use guards" here. :)

Gotos don't suck. Obscure driver-specific guard constructs do, though.

So I'm with netdev here, who discourage its use. [1]

I haven't missed your fondness of them, though, and if you want to
continue that path I think it's best if you do it as a follow-on change
(e.g. to facilitate backporting and as it is a larger change to the
driver, unrelated to the fix).

Johan


[1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
