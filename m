Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186287;
	b=WWf5SnE+S9JBFQoKfBFy4109crx5PZC5G7hRW/k16sQlzudCk+ZLBva3ZExiDJ24iyjD
	 i4qORWH0qC3+ftZaCdqW+nQ2HsHCwfK76xbhP0t9DEkh3COAk2Y4hJJH78P0pYtotKPP4
	 GZ+MOqh5yXpFKIW61RG3aSFF7RQuDRLnEInLUB60N02AtXkq+LigrI6AemerRakVDZK7h
	 GtchSbd5RmuqAhuiTKnLBLWaooUbemyxeAcZMH3vwRqCZRZRETmHw5AVTMALOIP4oNuaq
	 PNRN2DbdGktvIVjJX2PCAHyd2yxK4VOcJcU6InaNZpDAYXj1G6+uDb9l5XbmmXo+g7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186287;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LN+cDEaomPyKe7WgLyTQLLYOCDn8ku5XfaFlouP7r8A=;
	b=xNW7Kh3lgYzAFktnUgT4th66dWK4Rjvg61MqHb0DY/I89kJ56aSATqS7nMPV0I1BOGBQ
	 vblqfNHVnZiujVRkZjUeDzNuLQodaK1ANGGyaBYkOUkSqamK+Lc31O5pAR0VGFbJKdkLL
	 veLEZxLACo2IKO1wll/3AGxW9BksR4CzqrCE6SG80nRrL0wAYzHNGh1o8GCf2UUmxnQz7
	 F5YEAP61CsRQMEqLSWPDiYoXZ1lHrzGd2krnCHBQUGVS301tMP6pzxMRA0mXkTk1pispS
	 pDBcOpzOYbeh8BwDyTjqbsO0YZiNmUJp34kjAqmrHJg9WyRSHQcmrLKQtA0omMWbavw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjRbev6m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCBE606A325;
	Fri, 20 Nov 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjRbev6m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0610D1F000C4;
	Fri, 20 Nov 2026 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186287;
	bh=LN+cDEaomPyKe7WgLyTQLLYOCDn8ku5XfaFlouP7r8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SjRbev6meg4jt1PvBwlSQAj/RQPl2G7zVhThlJnei+8mOmcvXUpeumFwpO7b+oqOm
	 db+6HvS52T10XGSMX+q8V2GwM4TM0tareIRf97f/qAF+eT8Lj8DYY8pufBb5QaKR4v
	 3LWjocRKcycnsmZ2fSRgmYroHigZSKh1tytQc2mcl19r6z4ob4mpTezgMjB02Pva4E
	 XmWEPXNmfNbcD2uuCWs5YAF+jnKoQPBtDGXzlExEPxZoNGdUrLSsDJ0PtpIBMoSO/8
	 NKV4IK2QrzBV7MhJl4jF7Ip+IB9Uzkt92VP82sIChUzOJWMfMXXLhAfxevScqRm5Bn
	 ye5Dqb/jIJjWw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xUPxU-000000067vm-27jI;
	Fri, 20 Nov 2026 15:51:24 +0100
Date: Fri, 20 Nov 2026 15:51:24 +0100
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: musb: fix use-after-free in musb_remove()
Message-ID: <awBebBuAg2w6ZitD@hovoldconsulting.com>
References: <20261120-usb-uaf-fix-v2-1-cc3cb2a38ad5@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-usb-uaf-fix-v2-1-cc3cb2a38ad5@kernel.org>

On Fri, Nov 20, 2026 at 03:23:14PM +0100, Joshua Crofts wrote:
> Currently in musb_remove(), musb_platform_exit() drops the PHY refcount
> before usb_phy_shutdown() is called, causing a use-after-free bug.

This is too strongly worded. There is a potential for a use-after-free
here but it's extremely unlikely to ever be an issue in practice as the
phy driver would need to be unloaded by root while they are already
unbinding the host controller.

Why would root want to do that to themselves?

Johan
