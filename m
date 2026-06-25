Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA4722D7A9
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355546; cv=none; b=hJXIb0NELpDleV31K8shGyZVXbH+YQ3rpfxjOlrnYNdPehhglSXqdtgCr9Ow+XxZ/ZonTe9xin7fq3PQmTHk1pgSaHSIu2QNtSp3tJD0tTAcXdSlunCDQNZNjc5x7RigSgw8FHtrNgjXr5KGoRJ6n82hBbmE7D5a97x5sw4ewEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355546; c=relaxed/simple;
	bh=AySLtgFOtp3529pAwkKmx1IWp7boPyf16WKMeJ7VPcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adrMnciOAZzYP+iSrlDUnzT7pa75wr72dImW1ISI6LmMql7mJ4LfKzKBAA/rx+On0cHbJvm9HTfKoV/TO5DIkNDO0cHJCUYwBRG5JlPhoDTe1GzM6vau0RTitr+XktJflli1BZ6SGBX/sImT8uzmtu5Tv335kJh8Fs+XOmAjQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1O3RzMw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1O3RzMw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6b7bd4e8dso25035ad.0
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 19:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782355544; x=1782960344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJTr5Nx9Y5ptjpvg/KPhM4NW7y4Vw06GKfeQFFI2HR0=;
        b=f1O3RzMw9Cu/2cncPlbWfkljhEUyroaiSd+5NxpGSJguPyNinmxzsBtG5ctxTKO6On
         82KefBXYsrO8w+dEBs1Gt6bDiPixgtCY6K1XqZyAk1ZJYhNdTmKgKYmPLzy4JEhTzCzN
         6tLsmS48/FHQTtaKOVGNSJiSdMIM5aPY2wNuPbff22wDsnPr3X+c+A50IoOSZ4mihYZA
         CWpkf6WWCO9hPD1pnjEmB3uWE7gRgiaZGFeKWMVfc7rx75AY2PEibZcbZHmjiZEAjGze
         +WsVAsAGUPgWCRPml5/zYodbj0LFQPI7pUA0xPtFZsOUugsFbErjkb8Ab5oFGb7cWIa+
         2kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782355544; x=1782960344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJTr5Nx9Y5ptjpvg/KPhM4NW7y4Vw06GKfeQFFI2HR0=;
        b=DrjVhGyGJCchdpBPsYtUsA1rlsMUuqJ4XgJLZyXxP8OVVtXtsCwIj8r7pyl6SKDvG2
         Rdm3y7SwPjPW4EdD3dzJWIMrjx3pNUYY+VC16BGlHXK2gCYNTo8MuWa2a7K60ZoKCTS3
         sv+9FmnAxALYtSHdXxD8BYLHgCcUJ/4D5GvQf7vpwAXC2GPXcJD3e92lwxCQQChShini
         XnQOTKa+CkG2O4rBRKr4vdeGebMUpHFIFjXvo0YU3PGOJpeCny386GCvZH/UWkhhpc5c
         BODQaIU1lJ2jBD65JGEAf/P4rp3DvAVe7g7+sUiJqobLkeqSX2KYVSE2PTgPIKJCaA+G
         8eMQ==
X-Forwarded-Encrypted: i=1; AHgh+RojQpUWFnRFo20AcsouWwlG7oWXGsC9TRo7bbmKLsD3hoywweD0gpBJdgwsBBd88RDBrlFWyg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw362V/HbGKhh7t0KPpmll6Jkkh6AtokB0w7jtM5elpWVXLt4wg
	2Srfw5ArwF/n+eBhS2ZpOoYBv+l48FGhGIIGtnunKzkjDkyxdqnxiASbEIu1r2U1j+DSmrAQsyO
	NlcI2us2M
X-Gm-Gg: AfdE7cm+k+PynolFVy6q/5faHLcgyfhCOZuksF+lUD2b9NpQOMG+1fYCF5wwblx96mx
	ry5uerGAKaEaXl9NOaHlZ/wKX51iQFB0InJTWupIdfPJI9VrFHHhzRc5DA6sC+z10Z7sJNHy6ci
	PxKp50dRUqgluaGzglt5QRPjoBcrLSIrr/J8HhP90PGsx0GT0tnwEJjoT3CVrlFCNw4krLWnLcS
	ojQjnmC3PqQedI+1pjHcyVGON65SS5mW0iM8iX0uOt/Fcx8JFBtyUs4WPfNXBuO6JI1O8KwApU+
	Qs7PLyUu2aPYm3HaYzzr5rNfjlUQ/O37b9XWFY5/l/Xqb8mhVq4Cr9yHrhozLOjm1H/09BVt5tz
	NX7sQmryQrvSk/fPKOeoc3wr8Kl0jA9XpsZ+ljoYG9MYnT7H9WXIpl6/tUspZK1NRGQ8qYhz5o/
	LosDB21aQ0YeH6NfrY8dIt/Oq3pBO0bl3yLHz3Gd5WG+AH9uw6ZbuQuTlEK2MEDgTH006BGFdVo
	8R5lQqn3krptf//12wdeu7nfVPCBW9FK60=
X-Received: by 2002:a17:902:cf42:b0:2c6:a078:bfb7 with SMTP id d9443c01a7336-2c7fae6b9c1mr870365ad.7.1782355543229;
        Wed, 24 Jun 2026 19:45:43 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b9cc8496sm744276a12.8.2026.06.24.19.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 19:45:41 -0700 (PDT)
Date: Thu, 25 Jun 2026 02:45:37 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] binder: fix UAF in binder_free_transaction()
Message-ID: <ajyWUfA5BLrlNo9A@google.com>
References: <20260619185233.2194678-1-cmllamas@google.com>
 <20260619185233.2194678-2-cmllamas@google.com>
 <CAH5fLghnFSB0KYHQ7T4LEnHcx+kLP0RavpQL2LSyO2MCjE4DeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghnFSB0KYHQ7T4LEnHcx+kLP0RavpQL2LSyO2MCjE4DeA@mail.gmail.com>

On Mon, Jun 22, 2026 at 09:55:29PM +0200, Alice Ryhl wrote:
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -1658,10 +1658,19 @@ static void binder_txn_latency_free(struct binder_transaction *t)
> >
> >  static void binder_free_transaction(struct binder_transaction *t)
> >  {
> > +       struct binder_thread *target_thread;
> >         struct binder_proc *target_proc;
> >
> >         spin_lock(&t->lock);
> >         target_proc = t->to_proc;
> > +       target_thread = t->to_thread;
> > +       /*
> > +        * Pin target_thread to keep target_proc alive. Undelivered
> > +        * transactions with !target_thread are safe, as target_proc
> > +        * can only be the current context there.
> > +        */
> > +       if (target_thread)
> > +               atomic_inc(&target_thread->tmp_ref);
> 
> This is more complicated than the comment suggests, but I think it's
> correct. As far as I can tell, scenarios where to_thread is NULL but
> to_proc is not are also scenarios where the caller ensures that
> to_proc stays alive during this function call.

Right, transactions with !to_thread and a valid to_proc are undelivered,
and as such they can only reach this point from the to_proc's context.

> 
> It's unfortunate that there's no obvious better way of doing this. I'd
> like to just take a refcount on the process, but it's not atomic, and
> you can't take the proc lock protecting it because of lock inversion.

Bingo! I'm using the thread as a proxy because refactoring proc->tmp_ref
to be atomic would be a bigger and thus riskier change.

> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks!
