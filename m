Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0C35972
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244087; cv=pass; b=tX7qHvxUF3+zbBAbXC5FvJOhDutltHX2G4qe/N8NJ5XvABCpAJqnGa92s2y4ZttGQfcrZEhMiH3CNbMwoDNOLMvrItvYTnqG4QmsuhDDfWk9bzpLBc3vuCnj/QCbDBWkqA2LxEGGFerb8ZTye2pjOLVWyvnACTSOPpRoHD8BR0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244087; c=relaxed/simple;
	bh=lNyyd2ein6yMzcciOAtkON5QegH2oDVx4KbXKTsv8vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XASPq59Sjr4tAkrhww5xJnDq9rBTASxDelMnQ/PThKshtNWE2k3I0BFNZaN7qwkZc3nYc72ViKX9GKTBEG7mfhAPez7lAr6llfPjYH7y4bndMjoBHfqhcycrB1M0X0qj7Zo8kXJ3NDEnB/QYrcFVYfSmnSFZDwHIGcl54iIjxD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnWHY5XK; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnWHY5XK"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9158fbaa4bbso70849785a.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 23:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781244085; cv=none;
        d=google.com; s=arc-20240605;
        b=SG/7eQfVxTvTpMVIb0ea12VCpFPyR/Ki7dAH9bjUcEWmgZhbqwKTfrjYn7rvCWhHNx
         0lqwxHhKYCGxkuLuyPHw8+GF3abH8zU8zlwHu5sKYJdXYuLh7G5/7aTIVumWf+wCER38
         7ovnlOhHn3uQH6cWBWz5LGSkpoj7OuBf4jC/ItmBWVYh3AQg+nLTHlMXBSgmlfuFk87I
         z5V2PMPj5NFaeS7ldlSc6jZDKtB/ypoq5QCp3ZWhMYJLS4O8e6BzexuQD2HoBxzlFOG/
         ZSgH92CZ8ksu+6lBvG7RxftL7ASTXet3otq6B7VZ3xPevRhlvNvPuIHZX/gYLhWQtupn
         sICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNyyd2ein6yMzcciOAtkON5QegH2oDVx4KbXKTsv8vQ=;
        fh=Qggg2HuEK7yCeS7hggqnwr/I8MK/x3uRyI4q8DcoeQI=;
        b=PRDnpESUz3nmWBMPphdSi7gHYa6KgeerDJXitVv9L1sZ5PtBKa6xQ3/27hDpseTY6r
         gydYbFw0RN4AhzarPmh6KPNYkZuVt0xVwTnianygT2hQRG7VAkxBsA2o4ARMFfJ6G8nZ
         cL5NJqJto8vSQJK2TbgejSD9rK6PFNGr7XzU7pEMgk+RaezlBTGv2nRXAYbPIlzRomzb
         nbU28UcIfJ7tQj1dVpaXsts8BHqmftYd42YieVJqd/28FV8Y6HNtvnk7kjJHYNaQ9eSg
         bi/ktDwQWx2v8/aj5LrEK8t+foEITPoawexvkPYEEsJNCSj3g9gfWpqIbFe5jIGjAMP/
         5WHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781244085; x=1781848885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNyyd2ein6yMzcciOAtkON5QegH2oDVx4KbXKTsv8vQ=;
        b=tnWHY5XK4VFFCBFrxOlwONnJHPWiW4SQJfKQxuToEi9MgR/34YT8/DBb+5/aw//NWe
         qokfX7EsW9fh+L4315bH7AOW5ZWHzjWu5LvMVcGww7msm2wv1huu08xeo6u8uW5+sE4/
         qUKpx++CcA9+l/QEaBJ8pjOfbZxxB3M9avFiUS+mOm6B496F8WcjZMwmmaaPKgD/GqJX
         WFZkjwscvRF0MRAuOtYd5gs5dz/XEuvklqBEqMpUzMCzY9Tt7w7oPhCA8bCy/5yFB1uD
         URIePKX+eh+Gv8JQqOJ4TdwljIXNR+3fqUYmzXgY9BvgF3iT6waiNxIuwE5/u8tTBC2X
         KOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781244085; x=1781848885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNyyd2ein6yMzcciOAtkON5QegH2oDVx4KbXKTsv8vQ=;
        b=m4Qx0i9TPNXkcz68x9e6dmBQ9PJNAvfoanOge8myeRVP3WcP9+RzBc4PvhUdG3IJrN
         wwveeazLJpYTCPjy0qKp2JzbipHnDYfLzhCENbf/uwmWNKMuIawibxjfb2OhcazqmRh3
         XJ7svLlnEGwAu1j3A5EtVSxL2zPbSL2581oPIPv7mgscgZXB0c2NUVMJPmu+Yx1GcEb8
         DosIOMKE6noo1rceQsLHWjeqX3IGul5iq1tyMQTokqWfLwbEGAZvZ4wuYtDbCcZJg+5n
         vYHnPViilaRpaCd1AIgVyXYlAwWeOcCIPGZsFF/233NRGtJHwTvNUEUPiyKlxqit/+LO
         1ENA==
X-Forwarded-Encrypted: i=1; AFNElJ/6918ZmM/UHMroUnNGi1P6QKruXx31Uahwpn/CzuvG0uZNi7P8/dy4+NAwTfoICY1jpfTVTDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEj3CHJc7uDBDsmvEOZszzFVAr66oRdN3YsHYgDlc8OCmpI7oc
	eEW6ZR/gDAfqcZ0tnqhNi03FMmXICmfitZJtV5vxaond7GW5nNp9tY9BuRx/B7WwCoJBxHOKsne
	RFxAqExd1HUn8/oeGGO2rpdtFGNJcwCDSEOBQ4VJm
X-Gm-Gg: Acq92OHeEd5NQLQSkbo1aWMUg9x/q5QLVLC5KgVl9QFC/v9Ki3M+GB1w8Jn7MYZyFJD
	RKUKi5kk5oRCxZh5bBF7lxkaTfZ5sRw1WmNtEYe5hNox+tnbrIEGCQxxxoXeL1OFwxhbQTBVZ5o
	TzSDQDxAdKEPDy/K/ZYFkqTCRLLGobJX1cl2qUQT680di/fiJK4H5h2mOkowa0WpXV4DSmgox9L
	biiq6QdoX4/1zlDGawn1xdv2LyougZVBSA21xZ9M8PxNJ7IWxbSS7aCZJr4r51GHtEPP2r+UyZz
	YeMezteiRFEF6vMMSBg/rKh/EycuZ3IePrdPJbBCSp/T2gGwJoG+reRhVUJWpeiwfBb35aVuXia
	BzSevdWS/e+qksnvX3Ug=
X-Received: by 2002:a05:620a:6601:b0:915:8988:4e55 with SMTP id
 af79cd13be357-9161bd1718emr174397885a.40.1781244083480; Thu, 11 Jun 2026
 23:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612020941.12694-1-vulab@iscas.ac.cn> <CANn89iJVksVj+tnSgGFeWo9C1m7V6gM7pA_badBs6G5Z=GMO9Q@mail.gmail.com>
In-Reply-To: <CANn89iJVksVj+tnSgGFeWo9C1m7V6gM7pA_badBs6G5Z=GMO9Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 23:01:12 -0700
X-Gm-Features: AVVi8CcSmE3YLxkjVaOY6nOT2yd_vAl5QPJY-MbMPUVjjUTYmrdKCJTvHqAA76M
Message-ID: <CANn89i+bQHftM4-36j6+8Hn6iQgTi6Z8r5+YOFDju2KXCU-Jmw@mail.gmail.com>
Subject: Re: [PATCH] net/xfrm: fix refcount leak in clone_policy()
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:53=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Jun 11, 2026 at 7:09=E2=80=AFPM WenTao Liang <vulab@iscas.ac.cn> =
wrote:
> >
> > In clone_policy(), xfrm_policy_alloc() initializes the refcount to 1
> > and sets up the timer. If security_xfrm_policy_clone() fails, the error
> > path uses kfree(newp) directly, bypassing the proper release through
> > xfrm_pol_put(). This leaves the refcount unbalanced, triggering
> > warnings if refcount debugging is enabled, and also skips
> > xfrm_policy_destroy() which would clean up the timer.
>
> Can you show us the warning?

Having to clear a refcount before kfree() is a new thing for me.

Just curious of why this is needed on a private object (not visible yet)
