Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433363;
	b=LJbBdQuu9PlVct1vC4E3uHnU7UiYn/KtGQjalWmd9jqoGpKeZjpvxSO6jXREOrZ1eYfa
	 dMoWzwd8w+IYKzpddgpJSz8RRFZ9KHtQE9myT1PNXBuEpE3efRO2ERiEjRZKnzMZeHlRT
	 8iJtuXGNSv4Bj/YokDpB2JvAAd08Mwv97Mreh5XuZ7kpp0WHzgbJWyRfUqZqkd1Zqo7Tx
	 FWd9ZyxoLJnhUvKhQoEfm4c6fOnyA1pEg9Njh4WyHCwv5/uT4JZ8ddzcyINrRplo3Qj5o
	 zevJ6c0vmPd2c/OT5DEmjhhoikUOewWfJp6jPtoOIAWJb+bOYPmZsf0dwcLMyPbUR6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433363;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Yr6L+dozFX7sFJtMBAX2EEeGDCWV7xJYhv1ACGcywwU=;
	b=m5TrADB+MSY8aQnAToIM+H9DAr9jgRwjqcspO6XHWMkuIdiVgtXMtvzTcRX2gLKKlkmi
	 YlFkeeWVFFd63rBVYdGRJGa5WWwFX+a5XrfOnvRdBfKQs/YO46x0ta6R8S+bXnD7exRyl
	 i1Hg1PoTlPGvTp4clxGaIBbBY3YnKGRbIPWG4bY62z/4Yue1ISg3uOpyWdzkbOXP2U6rh
	 FgWsbVsafiZ5zZnvgzlRehbySUDjWZtRIOkvaOpIJpfJiRCLAPby9SR5NYc665rCuFF1H
	 KZpAAKNt1l/uBTzeqYYf6J+yrmNGDY+wpMpQZCt4hL8Jbozv/csdGnWXfMyZmaDKmFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Soi9qtQZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 863C1606A31C;
	Sat, 31 Oct 2026 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Soi9qtQZ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D33A71F000C1;
	Sat, 31 Oct 2026 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433363;
	bh=Yr6L+dozFX7sFJtMBAX2EEeGDCWV7xJYhv1ACGcywwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Soi9qtQZYm4Ddz50W5KnoksniC7loriun4idmKnBmsg5O2R0S+eqkm5zMB+vB6xce
	 om8CnYDXUrkzHkbmmpkTXRGzaVR75qaroHnR9sCrto8i7fE3l+FT+yRTjfXoYw/mTv
	 bFQeOO/uRiy89D1HJ4y24AP+UupdDxl+qM82y3gEjEBbQK4PYWYb9cTTR2s0UzAZRD
	 DpocAEUgEFkzPmjdl9EbeQwd1GvypwDJ7NSJ4qW1WYAZdXJH4d+Gg6Z29SiXmJknF9
	 B6Dqe5xgF1D2QHH2W1oyCsohPZ0Ja9o1RXkAaZ5Ye5bmFDbwDzc3qzIHSxKwXJPQtO
	 uYVg+e6TxoahQ==
Date: Sat, 31 Oct 2026 09:56:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gallop Permission <permissiontogallop@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
Message-ID: <auWfECT7SNhBDZtl@kernel.org>
References: <20261030173930.40948-1-permissiontogallop@gmail.com>
 <auTfZL8RjQqT8uiW@kernel.org>
 <CAMdFwLH_cg_=cLaL-j2B_0kzAEof89r13=cYR--hgeLxC7Bubw@mail.gmail.com>
 <auWejQPzciYJWHj3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auWejQPzciYJWHj3@kernel.org>

On Sat, Oct 31, 2026 at 09:53:54AM +0200, Jarkko Sakkinen wrote:
> On Sat, Oct 31, 2026 at 10:10:36AM +0530, Gallop Permission wrote:
> > Hi, Jarkko
> > 
> > 1. you asked: What does "key becoming positive" mean here broken down?
> >     Here key becoming positive” means the transition from
> > KEY_IS_UNINSTANTIATED to KEY_IS_POSITIVE
> >     after the type’s instantiate() succeeded and the payload is present.
> 
> Great use concrete termininology.

Please also read:

https://docs.kernel.org/process/email-clients.html

Especially quoting part. Your responses are somewhat difficult to read
and we don't prefer top-posting.

Br, Jarkko
