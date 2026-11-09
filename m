Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264403;
	b=jAwYGWa4/SG8THxst4lqiu3JxtvxNMkHKXIyqi0wWe7GhQ4iTDkt5f5gb/HDdEfg/6UN
	 hEr881sdTV5lh9qg1OU3uWBLeoaF9vCGAbONDeH6+DzlAlIvo82oG1XefEB5yJp/xJX4h
	 ekUm0/wNjLKXg073nQ04ibgakTURYGzHCyxS05WyVGKl8buH7Wo2f7abTcydY5Ct+GHQx
	 kPf8eAfGpRie1u1PUTzN2vwWC+Xm784Z9mAOa0Hlgl2NJVUOQuoc4TdnKi69VhRUj1EJm
	 RV6rq8qUohVvPAR/10FQvY+288UheTrSfRdWO7e0jXhNZNsMxQkV6TUMi0FdJMmTvpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cpHV4pQiI8EZUKNTXc7X8urga4axIAaNowcZYHhqBwg=;
	b=jOFDY0NnDXZUD9PIyeFilVrHN60SPg8yVo3ndp0gD5xV2SnThjm6/vEJZQdRr3yGdDeG
	 tMMl6wOsC6PVLIxAbgeHfNcyskpMHpNbUH0h23bqJ+LPazjc2QtHYNNU855wzUwe3Fn/R
	 RUXqdne7fJHbIYtiBiLKk9oOU25cfE1RV9+mbGbLJ51ceyEjyaD+w7935SnYVxKpvtggt
	 bBaElmagkyKgXAUnroZio0+2QeokDbJCcyMkVFi6L3f7WijlptKkDnjPYMtsLqXzYosc2
	 nIlp0ihHm1cEvn549Lg8bj/AoYQMA6QSGQIroj9szoxWbGwmq8C1v1J5JG90wCTyU3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cs3+w6Ls;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889760A2606
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 22:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0889760A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cs3+w6Ls
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so3304298eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 14:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794264402; x=1794869202; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cpHV4pQiI8EZUKNTXc7X8urga4axIAaNowcZYHhqBwg=;
        b=cs3+w6LsFgfZRzeWv7Fuqb/31INY4tYYsUa8IPrtzQliRZPc9nv50s668gGIg+ugor
         gdFwHeAGsvcWE0Di4nq0xAExDCH/lVzKtq8NSfj0jUyyPAFssH8UxpsPTsgATI6qROrw
         Lnw8jkHPQWRceWbKH9zrLgHsM+G8yY8NEuJFOXnwHVHAeQ9Fm1I95vyLAr8OaMQQFgOT
         ONjsPlk7tPVj33JD4x9W9/zQFO8fp46Fscji+x9UGTZBZQ5pGPMAy5j3Zses5M/OpMb/
         VCcn3Hi7lZifQ1fpLJfbAervjDWegoNJULNmH+BnjHgr18D0wfSXr1LHoxMi4wDqTRKu
         UK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794264402; x=1794869202;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cpHV4pQiI8EZUKNTXc7X8urga4axIAaNowcZYHhqBwg=;
        b=p2uEfo9q57kE3aoOjk5oK4BYn/9wrDTPMxZY4mKVteiE1wk+/XOC9nSlFgYTHWWK6x
         fWSxQ4VSvvyc/puEqKCfU2oFeHn69kBlQGO+d4RF6uKkSqbgTYXCriSRKIgyu7WG9tEU
         p+82pa6VLN6/7GDGaTivpO5Gor2SvY+qEp1fp/Qrsadf3Wb8qs2FxKksc5w3CnHT9MGv
         wWG1l3TQLsrF+zOy//ODm4HlAj8wjqdVR177zxYVzx2LWy+RSmG0mxQ5jqEslIlnvcSw
         lAL7pnPKgYi/+D4+THGNbVmVOUG1q/DRC83hwsTnACrtok116q/J2ZNjoTeXIfGCyoDl
         89vQ==
X-Forwarded-Encrypted: i=1; AL+hErGAC309uSK6eYD4sje9rg/5AxFiwAxZJrNcWqTGD92kY9HNxS/Wc8WQ8413dbsuo8z9NKTF65o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9f5pdHdSh0IuIGMi9Kw5aR3VHrnHJ+a4zcKzS9PFAyzWsed8kQ
	mWYALeTeSH++RPK5tQ58TEZfo2o+AetEi0JtLFWv8Xfc8K6rTni43Arsx83iCK+0UOiT8fqI5sm
	Y5xg1UsAe2Q4eGmruYNVi05Qo7EpD1w==
X-Received: from dycc21.prod.google.com ([2002:a05:693c:60d5:b0:36b:e6dd:b513])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:ec8e:b0:36e:ff7e:e57f with SMTP id 5a478bee46e88-3751ef77817mr902291eec.19.1794264401697;
 Mon, 09 Nov 2026 14:46:41 -0800 (PST)
Date: Mon, 09 Nov 2026 22:46:36 +0000
In-Reply-To: <CAH5fLghTUOHcTAUC9_wqtP0xB18AWsca76xgptN9=wBx6mXUTQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <18e61a85b0d13e9c.3137322e32332e3235332e313736.9c152.0000sendgmr@google.com>
 <18e61a8cb2ff887c.3137322e32332e3235332e313736.9d011.0000sendgmr@google.com> <CAH5fLghTUOHcTAUC9_wqtP0xB18AWsca76xgptN9=wBx6mXUTQ@mail.gmail.com>
Message-ID: <18e681f787fa9e86.3137322e32332e3235332e313736.1b3581.0000sendgmr@google.com>
Subject: Re: [PATCH 2/2] rust_binder: account for deferred work size in Thread::read()
From: Chris Wiseman <chriswiseman@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 09, 2026 at 11:35:28PM +0100, Alice Ryhl wrote:
> On Sun, Nov 8, 2026 at 4:11 PM Chris Wiseman <chriswiseman@google.com> wrote:
> > +                    deferred_size = deferred_size.saturating_sub(work.size());
>
> If deferred_size is zero, then this evaluates to zero. It'd be ideal
> to avoid calling size() here since it's a dynamic call.

Good point, no need to pay for the dynamic call when deferred_size is
already zero.  I will guard it with if deferred_size != 0 in v2.

Thanks,
Chris
