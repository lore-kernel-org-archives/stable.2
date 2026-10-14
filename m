Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756753D9C9;
	Wed, 14 Oct 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990879; cv=none; b=efIXM+KMe8TOQG8mv6XxnHBqXHtlEdW910tI2KXaHHgde1kSibaH+w/Dx9koQJQfKoQY10iaVwU7s5qjv8wykAHV0QV9Sr4kXoVWKMqipfUiMxpxrtrwOVAy3S9O1+DlT9AwGjN0rzO4GBopstmj0aFQo067TheMJg9caRTpLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990879; c=relaxed/simple;
	bh=5HLdvCKEtor/BZh+ZJtx4KLXQxhliYq2xIHaNVluhkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkHDAgycCzV/VstmW/3IwE9C/dsFWcs1cgFRgSqS60hAdmsotVWeW6rJnVqaiKAS2JCbKEHc9+2b8+XpUXb8topTiJL4T7s82bhJ897gadZlsE4bywhgWCnHHyjsW9TFJORjQ7fZHxxGxIBaOSeRPI+OQcKPeQEuj3N2mrnqn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JexxFad0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JexxFad0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F581F000C4;
	Wed, 14 Oct 2026 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990878;
	bh=m2t6IV3+oio1dQSemWtno2dRZmypxTkjVf9NZHep8sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JexxFad0o14u0n+lZ/R5GUNwTfzl/lqChfiWtq8GWjs1MebfLyLh/D6smPOu2kDAL
	 53N3BkMtBzMwXaxUFnjSWzj5XjmuevoHi+BA9MSVloDGKA7sqf4SmJsvidIzXMnk2L
	 bXuWn+GwmA9zKQhgj3L0F4Pzcp2173uFrb7WjcJNcRShtpl3q40yoSPtjndYfqmowi
	 wHkkC3SDDZjfhghwMk3NtyL0V71q06dFD7V7994q6JMrv3FiqeCWaw5c4V6beQoeXc
	 RlA++T90ejHt8G2Et9t61Vvi/3HJ8ifzIDMuBMG2/Kojc7ZM5Xs7EHG7+W4IZHI+Bt
	 yk6/XAHiTGjbQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xH0gd-00000005rd9-2gom;
	Wed, 14 Oct 2026 17:14:35 +0200
Date: Wed, 14 Oct 2026 17:14:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	driver-core@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Peter <mario.peter@leica-geosystems.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
Message-ID: <as-cW9ZwmMCPcftL@hovoldconsulting.com>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
 <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
 <as86K1qm1sHtgTFL@hovoldconsulting.com>
 <DM4N25JXKTQM.3K7TP9HM68KQ2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4N25JXKTQM.3K7TP9HM68KQ2@kernel.org>

On Wed, Oct 14, 2026 at 04:42:09PM +0200, Danilo Krummrich wrote:
> On Wed Oct 14, 2026 at 10:15 AM CEST, Johan Hovold wrote:

> > But it's driver core that needs the extra reference. It seems
> > reasonable to require that any subsystem that sets a new
> > type->need_parent_lock also makes sure that any device of that type
> > holds a reference to its parent. And importantly, it's already the case
> > for the only user of this feature today (i.e. USB interfaces).
> 
> Exactly, it is the driver core that needs the extra reference count; for a field
> that is owned by the driver core, and for which the driver core manages its
> lifetime.  If it needs an additional reference count for async or deferred work
> it should obtain the reference count for this scope explicitly.

As I've mentioned, it's not just for async or deferred probe. It's also
needed when a driver gets added or when probe is triggered through
sysfs. The bus iterators only takes a reference to the each device and
not their parents before calling __driver_attach() etc.

> USB interfaces already holding an additional reference makes the proposed
> contract work for today's user, but I'd rather not make that prerequisite of the
> API.  It would push a prerequisite for an implementation detail to the user.

I understand your concern, but my reasoning is that this feature is only
needed when devices are tightly coupled with their parents and where it
therefore probably always make sense to pin the parent.

Note that the need_parent_lock flag is now set in the device type struct
which also holds a pointer to the release function that drops the
reference. So it's pretty easy to check any theoretical further users.

> Please, let's not add this API contract. Let's have the driver core deal with
> this internally.

I can take another look at it, but the alternatives seemed either error
prone or a bit icky (e.g. a helper that returns a reference to the
parent after checking the dead flag under the device lock).

Johan
