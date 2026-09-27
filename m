Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2060A95E;
	Sun, 27 Sep 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526527; cv=none; b=QvRnTzhWYChahQoZpAr6+0lbuuHcHKGGcBmargjrZjSYqBZygKzbEf3y0woR+xduWPtH7bSxka1KHbRAzWjE+sysbvkng0SCKsBVxZmkydyji7lV5yUvsZ8i2vTlOv4AkaKavhAtfLEymfSAVTdELVzr1O+9m9OQIzjcetCN/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526527; c=relaxed/simple;
	bh=GaoFGR/U8AnSRE2ORrERi1yxh49b+gMt/mOM6hnbA3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtNpiFQlQuJ2fxlX++UofvscJDU+0zJReEOwBUtB1kqrr5/8fiUWImlLOCbwOwYEqsmqvd/G6N3Vko78Ihoo7hry08np9I1c/fmRDiEyroRwtfGejMNYULhtGyOeIaNtKnjT/AiezSCy9UeDozhy5szmIAvvMHTUG2CxlPP88gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oL9nLs4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oL9nLs4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD55E1F000FF;
	Sun, 27 Sep 2026 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790526525;
	bh=kDDyjoZTZprDt7lf4HgFNIEtYfMAuyIz4FaZ2Epncis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oL9nLs4ermSQVs41sLxGo4H+/m6Gu4an7pR4I633+8wSH/ucDccrzZoszHYD7dCzL
	 ElUMXZcx1vl1YzrSvqTTp7zLpArutUPMAXVHjC7jWn6jYWLpJ8jiXXFafJ3Hu+xfc9
	 Vj8lHhHYI9JG1cTJJX3vKlwL4m8uZAMOQazOZnsI=
Date: Sun, 27 Sep 2026 18:28:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] serial: imx: cancel RS485 trigger hrtimers in shutdown
 and remove
Message-ID: <2026092715-deftly-strainer-c8a3@gregkh>
References: <20260819021916.442827-1-fanwu01@zju.edu.cn>
 <2026092332-limes-washhouse-44a5@gregkh>
 <20260927143550.608878-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927143550.608878-1-fanwu01@zju.edu.cn>

On Sun, Sep 27, 2026 at 02:35:50PM +0000, Fan Wu wrote:
> Hi Greg,
> 
> Honestly: when I sent the patch it was compile-tested only
> (CONFIG_SERIAL_IMX=m, drivers/tty/serial/imx.o rebuilt with no warnings).
> I should have said so.  There was no runtime test behind it.

Sorry, I have no context here as you top-posted and did not include any
context.  Please don't do that.  Remember, some of us get 1000+ emails a
day...

greg k-h
