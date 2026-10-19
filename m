Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427725;
	b=pG4wX1EoBj0DbrLt/bGKkNLG7mlyfnIOMGgQPU7nJiCvBC0WIAdAMXGQ2uLW4ISlIaGm
	 HqEaSWto3PXAePUb40vmMsRIlpOyR9ueaV3S0g1JQmHCAx0C9cEi+UcW1E/kJCD01Umrx
	 QECz9Uo7KYzB88px0YYcjcZmZ/FeA7WWqKk357oUDP4qXnrSi/whpld+U6PHzrncnuFBV
	 IZwObAz2WBYiShlhdWlIQuYSXhJyn/7JyrRrcJ/1yoRxJBoNvTqUvYXaDaMaoEytmi9l3
	 E25cIJU8iUaTVThe3g8TjSsYoZVH02pG2dqp5zWd6lmLP6m5HKoFcfwpOGb+7MaVFvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427725;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BfkVfvIEOpMxl3s2QBkVFer5ppGfQ4NGC9N6gNuAQn8=;
	b=XUuLBAQSmjOzYhQk0oDIWZ/CQVbX7mz+fcEEcQIYJl+FO8K8L1eRDYNng5yNRe4nRzEH
	 nhYhXpKxJ7NTmZYVhb3D882cYJc4WXAzAdyRcEbOz9fAXa7DlxJNDr++B0QxIN0I41wR7
	 2wPAjj0Z5s3QpiefHB1+e+Cc1jIEcVucNGnpLGQkB+VtNCgUCrlcrxj/b+/ahoD8BCL45
	 tZ3uDOvfxMPgV1S5A/KNExN67BJDhQcmcwEXYLShB57KM2GEcxN52/xO0NBYlFLfhIGxp
	 U6Qzp69APbjhKavkWg/Q/8TwL4GPazaYUBqAIaDd8rUe2rf3fvrJoc6mc2E/Yg0E4uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOKeG53f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AC380606A31E;
	Mon, 19 Oct 2026 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOKeG53f
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C06A11F000C4;
	Mon, 19 Oct 2026 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427724;
	bh=BfkVfvIEOpMxl3s2QBkVFer5ppGfQ4NGC9N6gNuAQn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AOKeG53fI1OTjp6Wd1o2ENG6OQ7+rMesX5tkLGw8rBVqB/MoW/xRqJ/lZuar0H07w
	 eMXs5aU+dxfG310yNMdBeiY7ROAJHk8GY3vo/kcHo69b6oOLCBhIq6xWbgUM3Lv9pk
	 N35q8AWfkoLH8t6NUhXkQb91P6VAGPj/JkQB0CNpZWjVwQ/uVIhI2a6uEaIcGEzHsl
	 Ei1Jdbd3wZYX5Fye8pT97pfFSKPOk4pNP8h9QDzp5GAjP5YEP4JTKaedaO2uKSD1uS
	 21+2LQb44xjNcE29L8ceMi3aHPQ0amU9WUMo/M0HfEM8Zc/DVD0Tcl0G8wAqY7clEn
	 Ig3DdAtwaY3NA==
Date: Mon, 19 Oct 2026 19:35:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 7/8] KEYS: Reject @datalen values over INT_MAX
Message-ID: <atZGyF6zoA1z9UIK@kernel.org>
References: <20261019142516.300040-8-jarkko@kernel.org>
 <20261019142516.300040-1-jarkko@kernel.org>
 <2610186.1792424607@warthog.procyon.org.uk>
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
In-Reply-To: <2610186.1792424607@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:43:27PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > -	int delta = (int)datalen - key->datalen;
> > +	int delta;
> >  	int ret = 0;
> >  
> >  	key_check(key);
> >  
> > +	if (datalen > INT_MAX)
> > +		return -EINVAL;
> > +
> > +	delta = (int)datalen - key->datalen;
> > +
> 
> You don't actually need to move the subtraction.

Ouch, you're right, I'll fixup that.

> 
> But apart from that:
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Br, Jarkko
