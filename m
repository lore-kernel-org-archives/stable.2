Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC0274670
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503756; cv=none; b=qTnyGrojG4bJsC2bUgA00i7bsWUkgrMq/Zcnn/9wX/EGp6s4SFsqFPelAP9PM/zGSAzoLKYRsnh7xBfTu6h+2ynd3tiIRONf9/fWgx7k8DyMijpQglPnX0JvV7WonU+uXPnCH9QjDuqqyDBRAKCLMFx4OcPu+NLvLOrZmD8vXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503756; c=relaxed/simple;
	bh=d7I0OfFSwWSSx4AmcU0UYv4XKanrmpEM+OseCxiJO8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMBrSjuabHt1uRRt1nksDNtUJuhq5KIT8xW358JcSfQfxj0tB0Z/YPyzo9y/d2ZU/LR38FKfDpX7RQIFkWgmlQr1l0I98EdeOa4u9cAuFjCRF8lnTRg8xy+8RFM3AF2dna7uvu/U495rmQG1S6reUABTL6G5Nd8U5JDcgbm3kr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p96FcwKB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p96FcwKB"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so1581753a12.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785503753; x=1786108553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/RqXA7Mt1vKjaBPSGjfXVG5xDvHOpBaE00CsbEm2xEc=;
        b=p96FcwKBqPtIdeYGErzu8dJcSoGx7mCCpuO3cJlfM+8n5jcz/Tdx6Xf+bWh/4JEIgG
         7lNTkpTZXkRyBwnPJmTJRNP0MWh+3+SWnr/JK6OzWyJYQfD4t8ySvZkkoNqq+PIjNzOB
         BBNjY4RtYZq4ucTNxiHPDGEvm3Gst8rMHrOhrPiqQyPUAoVarPqKWrZyw03sUKSZMFNO
         jM7TsbKQ/JwuJt6/AdgahTK2xMxbCzLKfVKttGOMAvv6TmecXnTnd6mMLbzweXVrpTp/
         pQ/rxbfckKkeIcEMt7+4NWZ7irylsLq1doIR0lXdXTdbe3HJXEmd0zqNEK1RN9Ydx6iq
         NrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503753; x=1786108553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/RqXA7Mt1vKjaBPSGjfXVG5xDvHOpBaE00CsbEm2xEc=;
        b=ColylEBVfNcs+ETLa6GwJApB27sjrmZVVmpoqzG7kblEBv+dEOxS5mpqaQZizwvcXX
         e1w677kCH8d3Q7fWDde6DLAMv7pKhWacay+BRmDloFdx7Zb7wum2fTv9tpp48b97NPeY
         O6Qdm4+dC2yNEd5QjdVf6sqvh/ApYNZR3oOPO5dlBDVb2F2ldkkjKBzdLj3MU10fDGFp
         TJ/ubaqpTdz0FIFGjnC+qdfoO7omSURXfmJAIwWCrdQtA6qF/XcQD0MJCqN03pW2W714
         V6HkScn3sB+/yuoxmeKVuIkp5dyfmfEgDKPAm0AOJAgzjcMZG518hPPIqH30pSOVTZ8x
         gOgg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3sYE6RZtPmoZyzyKolPzPHRxurUQLpAjNQnCkqnYNChpMj+mRsvt3xhwEUFq9mx2GDgrCWWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SZWCK9MuZEHTpihPKP5JZqOpg5g97Ml8cJkCsEHsKGgbSH6J
	e7MsXhhnDIEGs1Ey2pjwCyjMPkppDmlzBY3D4FYgGDp61t9+qosSLQ8V
X-Gm-Gg: AR+sD131UMX9byEJfIZ0imbBryxnXHUiCEkkYqtdSV8dcrm7STH95wUo/5Vkg8rOdaS
	Vvde/JCdzrB6Azyg7WRP9TkP4jPNh9FA3ySpqk3ukBWnMv4jIVM5m2JRnMKuTIDUafiZOwzJOFU
	PldPS9Kr/ntQ6f1swo8FBwcO1gfqJaOZdfiajFL05QgCrUGadciQjo/VuxWEHPpzmE1uZa8kOjE
	lSUarUn8A8jgwW3BULdZafE0dV5xGxhaFQUig0S4GdybabbGnK4kEfIz5Bclh1k2e9yw/9PfytI
	M0vTRuepid+iecxGI0+L6ZUUzOZhljCSXCU8SqB2emRVwqVISPAshVBovC5HaljcMMEbKozAUQC
	R0ndveaMwq6Tiflwp8tz2mBnx473zp1pXjjMVTRBGzY2RqiTljSnK/GZYLNcmsBDSGsS94tHLRl
	NhahpV0y62Z6rR+lSEuVpCYWiiIvl8oZqS4ma5EQ+aYn8jqokJiFUzemPLSkgS2fIwitld9OUlY
	+QzTr6XqP8qdT2uauxmWtJJtRwLFd4j/TKyngqGlf0yX3VX8m42BfQxa1X/6jzaFH1tovxLIZbi
	9/y/ahsm07bOpl8j7QAQqYVZV+UVAEPh/FSTEPDS8DVWWCreIspU5sBVBu3uhdFJDkzjt9Q=
X-Received: by 2002:a17:906:f58c:b0:c15:ff7b:ad69 with SMTP id a640c23a62f3a-c1fd21c3288mr110230166b.34.1785503753032;
        Fri, 31 Jul 2026 06:15:53 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fdfd6c57bsm89659166b.17.2026.07.31.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:15:52 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:15:50 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] tty: don't oops in tty_unregister_device() when
 no cdev is registered
Message-ID: <amyejjYlqV88zhT2@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-4-kmehltretter@gmail.com>
 <2026073057-moustache-unfixable-5ab1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026073057-moustache-unfixable-5ab1@gregkh>

On Thu, Jul 30, 2026 at 04:29:57PM +0100, Greg Kroah-Hartman wrote:
> Note, LLMs love to write a lot.  Please always rewrite the changelog
> text to be sane and concise.
> 

Understood. I'll clean it up more.

> This looks to be doing 2 different things in one patch, or am I
> confused?
> 

Good point. I'll split it into two for v3, with corresponding Fixes: tags.

Thanks,
Karl
