Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433234;
	b=ZWqgRmKUh+Z72LGr6Ym5OuoLQdDa/qQ7CIv4n2N9k9Kr74nj2Y3T1JfMYUf/uQLTMswS
	 Uz6ReAnQLweWKa8TrJh7YXwnKrtiEeBFi7BIlBZJsbmwlA4CZcQ0UODVOGJrJbNRUfMhD
	 l66qJsT+sWXw/FRWm4zdtgHwO+5uQVupm5H9udB6V93T/CcTJ8S/tYWlqmOCxWe9yhs+m
	 HKS2aeo/b3USQBxJrhnw5LDBfIXTl5QpOboabHrqEDNsTVS2CFoB48w4W6i77RMH85Ii3
	 8uU/F4+Dnc856rdwEh3PGSVIxODig9VepZO5v5bbCdeWPpMZLnXgWWTpig375mCTjAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433234;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=2j+jC12QkRNqok+2AiyyCLusS7SO/t3Ih8x/mKvGy70=;
	b=ULc9vnhlfsAPP8RPqQGIbGkhKD2hdqnt+5YszM3zRNGNiZ3NIwqHGtG0xPurx+hfIqCP
	 njW+4nLFnhYx+gYqgoZbywSEwg0Zv6EYAjZCJqwT5fgHVBhiL8q0JGv9X9S31XETSUx7j
	 38PxRF75389Cg83HsnORdD7Olvb3fmsw56uOkmywYMSoW6ZGC1Opx+Xo8BEo8Zj1zJoZy
	 DHvXOeretAtp6MPvL81B4lFXXS8+7OiLNqWyqew+XoLaD9tMFsR3v8l6S75epVcLad+Jb
	 1YG/k1l426TnoUPSqn3OROkk1xv3sIH9ciBOfKngZMlSf7DHspyScYP7HldfCOtweIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="liZlL/K6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0C617606A331;
	Sat, 31 Oct 2026 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liZlL/K6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 28B8B1F00A16;
	Sat, 31 Oct 2026 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433233;
	bh=2j+jC12QkRNqok+2AiyyCLusS7SO/t3Ih8x/mKvGy70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=liZlL/K6Rteh7RGtdrH/m6rofW2BzdgrQTAZpWkd+rHvifEWrT0ZsEoa7quReVoAg
	 cMjWuElTg4WLf1jewNlEfDuPzFV+z+WPK37O/nk6a+fH7CLyy0sexge9PAsQ9cp1Xj
	 kVdNUnFhYmTfhvdxxOTif1CvYDcaOzUmWakEbVEUenaY8YKyrTGXjzn9sYU/rZdAdt
	 Br++T2oPGCAjlU3CFVCz5nFBfB+P10PdEp65UTSAMQ9U8aHtlmqmC9m9HNLQ1Tx9Qm
	 EIYwDh+2CO6ZqZE6t6vVDfpwwc0jI7nL5v0TpiMbtqwHSzv5wvwBQnry7gEdz0+4fu
	 l4Ein80cHxFlA==
Date: Sat, 31 Oct 2026 09:53:49 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gallop Permission <permissiontogallop@gmail.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
Message-ID: <auWejQPzciYJWHj3@kernel.org>
References: <20261030173930.40948-1-permissiontogallop@gmail.com>
 <auTfZL8RjQqT8uiW@kernel.org>
 <CAMdFwLH_cg_=cLaL-j2B_0kzAEof89r13=cYR--hgeLxC7Bubw@mail.gmail.com>
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
In-Reply-To: <CAMdFwLH_cg_=cLaL-j2B_0kzAEof89r13=cYR--hgeLxC7Bubw@mail.gmail.com>

On Sat, Oct 31, 2026 at 10:10:36AM +0530, Gallop Permission wrote:
> Hi, Jarkko
> 
> 1. you asked: What does "key becoming positive" mean here broken down?
>     Here key becoming positive” means the transition from
> KEY_IS_UNINSTANTIATED to KEY_IS_POSITIVE
>     after the type’s instantiate() succeeded and the payload is present.

Great use concrete termininology.

> 
> 2. And on the second para
>     For an unrestricted destination, construct_alloc_key() still
> pre-links the under-construction key,
>     so concurrent request_key() calls for the same type/description
> find it and wait instead of
>     starting another helper. That visibility is what deduplicates construction.
> 
>     For a restricted destination, the patch skips that provisional
> link until the key has been
>     constructed and checked. A concurrent request for the same key may
> therefore fail to find
>     the in-progress key and start a second helper. The keyring still
> holds at most one link for
>     a given type/description; each result is offered through
> key_link(), and only a key accepted by
>     the restriction is cached. This is a duplicate-work tradeoff, not
> duplicate links in the keyring.
> 
>     KEY_ALLOC_BYPASS_RESTRICTION callers are excluded from the deferral,
>     they keep the existing provisional-link behavior and bypass the
> restriction check as before.

Ditto.

> 
> 3. the rationale for the code change will be to stop an un priviledge
> actor with write access to
> a restricted keyring from bypassing the restriction checks.

OK, so I did not mean that. That is motivation to do a code change,
which is I guess what previous paragraph try to answer.

It says nothing about solution per se. And neither I see how this
answer would give anything on that.

> 
> As for the points raised by sashiko ai (concerning
> potential outer-search bypasses in request_key_and_link)
> im going to need some more time to verify them and fold any necessary
> fixes for v2.

Address what I said about commit message by writing a proper commit
message.

> 
> Best regards,
> Anvik
> 
> 
> On Fri, 30 Oct 2026 at 23:48, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Fri, Oct 30, 2026 at 11:09:30PM +0530, Anvik Loitongbam wrote:
> > > construct_alloc_key() pre-links a newly allocated key into the destination
> > > keyring with __key_link(), bypassing __key_link_check_restriction(). If
> > > the request-key helper instantiates the key with ringid 0 (or any keyring
> > > other than the restricted destination), the key becomes positive while the
> > > provisional link in a restricted keyring remains, so the restriction never
> > > sees the payload, potentially resulting in a policy violation, where a
> > > user with write access can inject keys which are restricted on the restricted
> > > keyring.
> >
> > What does "key becoming positive" mean here broken down?
> >
> > Also I have really hard time on reading the second paragrah as it is,
> > let me count, over five lines long. I honestly cannot say that I
> > understood what I read. I tried it three times.
> >
> > If you understand your fix, you should be able to nail it.
> >
> > >
> > > Restricted destinations lose the provisional-link deduplication while the
> > > key is being constructed. Callers that pass
> > > KEY_ALLOC_BYPASS_RESTRICTION keep the existing provisional-link behavior.
> >
> > The second paragraph should be reformatted and there is no rationale
> > or descriptio for the code change.
> >
> > Br, Jarkko

Br, Jarkko
