Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B63E9C23;
	Tue, 28 Jul 2026 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226426; cv=none; b=uYMFrnS46EU6GeiBxlVDhRvB7Gq5gRVU7+I6GokFUuTPUBWQQz0mR4zN/bAuygWEkrCC8zdvuVGdezJvFmCqk/6PHyQdyshS1OcEzG9Y4Xo4x45WHfxVyAKiSzLQ/3EoFUT1l3Uym6s3chJuu6o4zH3drWTziF1+gf0Zc03594E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226426; c=relaxed/simple;
	bh=0JaeJ93QmvKw2USL3k8yw+2joearmSdhFpa7weiYBik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9ZzXqB2ZACOcuHKXJl8f6tgK88nvN3eJnaf86mhbqoKM76S8lvsm+cLo3yeeOYn1P8ZlXpgqxbF4Sf8L3mKX20Wg4gXMeV86FzixPBlgf4EMKizzhwkU4WtpFUHyQ9yMYsW+vXFaSBfZ7qAjZ6jZdHFBlkqZdF9TraBYNEZlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=gHdAqtbQ; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="gHdAqtbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785226422; bh=0JaeJ93QmvKw2USL3k8yw+2joearmSdhFpa7weiYBik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHdAqtbQsWOuu6gwq3Xb6fFoWeIhEanbvUQ3YsUrbISmYJcxi/2X4CuIROaABAlaN
	 E/MSMkSy5bCB202DoT+0ykDqjtpFE52JObgQTVOEPS6nIdyIBFAANo6Kecp2HkfC0l
	 5/+W2eIi1flxFOSYBUACcXLMV0q9e3Ix5rp/Anv/fmHXEOwlwWKmLx8TReYVVNPcUL
	 Eu6jnURcMgTjFNdUGE9DKGTp68LcBKOiCsURCMrlEJDuN1kGlYnFuXKbD0WyBhrRbK
	 UARr0pUgjUIgMhvOrNB8OfSUKh05Z5BaW9OOue8IP+ceU9Bir/8XJr9JUcvu8uxR3k
	 ApO6Gg5cud33A==
Received: by extorris.mess.org (Postfix, from userid 1001)
	id 62A2941567; Tue, 28 Jul 2026 09:13:42 +0100 (BST)
Date: Tue, 28 Jul 2026 09:13:42 +0100
From: Sean Young <sean@mess.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/15] media: redrat3: Error path leaves device in
 transmitting state
Message-ID: <amhktjcUpSxHZNi4@extorris.mess.org>
References: <cover.1785158244.git.sean@mess.org>
 <d22b8dac679cc4b4713dd03875576d71305e3912.1785158244.git.sean@mess.org>
 <d59b23fd-0d97-471b-8af4-0379349829ce@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d59b23fd-0d97-471b-8af4-0379349829ce@web.de>

On Mon, Jul 27, 2026 at 05:57:23PM +0200, Markus Elfring wrote:
> > If the allocation fails, transmitting is left as true and the transmitter
> > cannot be used any more.
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.2-rc5#n94

I've tried to re-write the message in imperative mood, but doesn't look
any better. It can be improved though, how about:

In the allocation failure error path, the transmitting boolean is not
cleared and the transmitter cannot be used until the device is unplugged
or the module reloaded.

Is that better?

(I don't think we need a v5 just for a change of the commit message before
commit.)

> …
> > ---
> >  drivers/media/rc/redrat3.c | 6 +++---…
> 
> Some contributors would appreciate patch version descriptions.
> https://lore.kernel.org/all/?q=%22This+looks+like+a+new+version+of+a+previously+submitted+patch%22
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.2-rc5#n310

This patch has not changed since earlier versions.


Sean
