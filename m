Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795608355;
	b=uVLnpy5N7QJzdBazoNmOVyYMievScw4OMH/aKedeyfjCBe7NxoG9a+8Bs7isGBGXyzEZ
	 MUrtQlUpFup0J0RI38ZtQSFWf6UlwXK69ZujS/nkioRUvH18TQIokb/N1KQwvX/0mtAAy
	 56aN4Dn6rB1Y6BxDPBJKN9yh5IKJl3MqIEWasZxmveXo+I5dc+LRgtVO4sMd6hM9E/EP1
	 fKvwCUu7RxT8UZ3Ze9XSsDn4RYzKMrQXrlmtBG54O30VrQvlAqsu8yXpxYK8dl8Id74C1
	 +4DzFa8Dmrg5fDJBLGJ5Sw9NHxCaNsKb1AW6yY7n/7q/JWPloGSakZDUE8ka8R1lbZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mmpzCTGF7idKvkeds9ux4PCjDdw81921HPWjTxWauKM=;
	b=l/dp4GRFqpqfdZDKzMSPfWOtXe4DAdGaT7R1Fs6TQMFx0iu42EsJ3BD43G601S/Gmmty
	 thTkeIRB7h3BPoOxJWfFeHnFoJoppRujIdF4797kZco1YCg7K9+vLEEJn8jsZ7sTu7wZN
	 H164KsXPVxP9VYT7IrOG2RtnWWNZHWnPYbWmNtPWKWsHv1HtQkkKcVk8ZBM5fGrBAa3ub
	 cI5LjrelYpAEg3vIyidNvulHhRaxKz0aJ/xi9TEccWDdVzEejE00CxW1aUwYl3vUMU9sC
	 9W5IYT85tBhEyVjfNNDlV9JZ4EDpyjJ3KjAS2ghPrzMZ99lZycN1IJRgdydoAKH8e0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pjX6QKXG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C10606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C10606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pjX6QKXG
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so4382341f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795608353; cv=none;
        d=google.com; s=arc-20260327;
        b=TyHN01nSdUof9SxorseIePwQeW4xfc6UT1RJExsmFMPNGL+z1KrEc+AtEcrqw6TpWY
         IrjDg2O6OH7s+AIsEcCVtDnugdPsI8kCuQOvtgu8tKow245S8UAeEVmw+wg6FHofmsWP
         Wl2gkJNGjYlpg2Lr1xnP/2a1qp6iskAV+COTqYk7VQ/5Ya4U7fqp3gB/DLlrFYrhAHJb
         bqkFiBPuwAYRgyFKhE63vARnktLNvoyl7Smjk4eGMgYvBESp2Xcv4uAJKdgPETO06plO
         wVKwSNOgboFMWgFw1oLMTWWmBKjfC6aoQQm7u/EoReZf+GuIWXuseMNcCM33UM9DL0Rw
         Wz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mmpzCTGF7idKvkeds9ux4PCjDdw81921HPWjTxWauKM=;
        fh=P5KxzgmIE7YzVSza6vzOD/Gy0bljkDE6Mgm2um3y/gY=;
        b=d2stqPqFx3EPRtTVu1N+NhPrqAjjeEU5AaD/KVpdOz+Beg2hYuZMd05Q6hAc3GY3LT
         RiKuGer/NRaYyyDVibJJJkorVE5hSxyBIfB43JpIfN23YnnqCK04wLRaX7ZRiXVffVKI
         hG7g7kucI5LS/+cn6GXWTs71CxYiwlTiCkSAzalswaaU3/LWKinY9gnySD2he1C5FJx/
         Xh+L9OCwMXzSjnxe2eDBgP4E+It578Ro0hFKV3Wq0Rrj2SDz22GJTcFun2yvuYocg3rM
         +iRRiy8ENiI1ZJ37IR/S83QaSWTTq031V2q4jCIHoCeGdq45NclruyTlp9YENIluGBue
         Bfww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795608353; x=1796213153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mmpzCTGF7idKvkeds9ux4PCjDdw81921HPWjTxWauKM=;
        b=pjX6QKXG1IYWPuNjl0k+8QjE5ymS8vtEytzSOtJkfs1RHFY0DcWjq5Ki3RkEBzUwjr
         fET2ZoGdpDQVz76KNEMLQ3W3K4BGMAqGag+pH2GQDU8ylUe9pUwzC9r10veWdEZhjwFf
         RVfga+T1900YQda9M99rTh3z82hVG8MYmNK5nq6POAKh1DSNZmbD4OeZl4P7IG/ruDyt
         e1TOEFMvwZsON5XeNlcDp70bR/0lYIKov3PlwK+VAn9QLLQo52NE0o17/I7r1j3n+Sl6
         cxWNQuMvE0tun2uMMH4uMbUmrTM5cOVIjjaDXz8yjG8O7Vv5XfB7f3KvBmtBwISInZOY
         dL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608353; x=1796213153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmpzCTGF7idKvkeds9ux4PCjDdw81921HPWjTxWauKM=;
        b=CSruSMf4MlrqDQPzZFeVLFMSWhAzoTSQ6KAsKJfgZ617Ic/mJ4G2ZpViYinHUW+jfB
         ns/Awwe4C2xb2Pikl+93wDQctL4OJt6S1jRw/kwdfAHPB6kncoy6TWeyYYZ5Q65HSbpc
         RFcjlETqfijivnkYGgsUsx9TBDHCkT/5757f/H9ToWkkzc0p3acDdHwMaUiU/C/oH0L+
         UOGalAA6gnTclTMxlMlr4OP9tRAb05q3vfJpK3rfsYeC/C6E/Rn1lPHsTQjvbq+qmtN3
         +dORY2uUwWxozL/5B/oG0LGpCjV85VS/HUIo6/5BGnEgDKo+miOvkjXZHjxhAefGOyxy
         uSig==
X-Forwarded-Encrypted: i=1; AL+hErFaxnwnEjo6ceL+xSIxOWHd7rbDZiHfG5SdYUoIA2DccyahIhUaFquXQRZ0RIutrQOIuqV7cn4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/j00WAtAu8j6GuvDxSLq/p/MKfAIc1T7w6lpMdbSj7f0+LkXEj
	wW9DNNDrb/AYCs4LdX26yhV3vIquQ7ShfsqhLqFtP7dzij3Mj11oLxkmLcI2kIUeqceEWdg0Ata
	mqgc3qnOzTDqNIceOnQ8alHd779CepGb09UhQe0+T
X-Gm-Gg: AZFdTZdFAXacvp4fIFdZo7Q1EH1Fnf90GaXuq6gnhryNRG6cgUyygnxEP1YfU+KPGWM
	w5X3e8/FgKA3hpeRs7RHuzz01IJ8oqYKTjpSxod/CqQcXvdydb/ndd2uYHVw+kgOqsBogBNXd7s
	5EU1mKAJm4rpyHSYkF1w4iXStKBCyJFg9oYMuyVTt3RzisxzN74Lv1dCUB1IBYkKCtRaPhpoQKZ
	tCXbctMJoaf8XJ/RVdr4rS1fS9XjyraMprEXxfzpoRV8B7dlhgiQJSJ6fIkhDYKfYvgAd7+yld5
	xYXuK4kmOyL1QHKOam+557RSwScyJqmTyKvdF6Ba6gNU12oRIakOFy9U1xlALM7HaT20gcnKWEv
	tyk+kL6zSImYEDxg/67hr8Hkn3KK2KXbQRyAnTMhVlG8pXFdcjHYEvdfZK8A0gj6Nko1DiKTeuK
	cz9qly3cs9tvt4v++Uk9J0N71YTKdHnEM8GKURS42K0LFr
X-Received: by 2002:a05:6000:490a:b0:4b7:80c1:11bd with SMTP id
 ffacd0b85a97d-4b780c1127cmr8568730f8f.35.1795608352904; Wed, 25 Nov 2026
 04:05:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com>
 <20261118-ordered-wq-cancel-v1-1-916e01f9affe@google.com> <2efd4eef27cbd033bae9e4f5d5ba30bb@kernel.org>
In-Reply-To: <2efd4eef27cbd033bae9e4f5d5ba30bb@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Nov 2026 12:05:38 +0000
X-Gm-Features: Aa3M54oB_Bc5JJabfyDqaJiI78UWC2_tVPgPCR0cvXKqYj-o-7hWp3ZKJEhfypQ
Message-ID: <CAH5fLgh7b7vFj4y7Pi-s2-4KuwUQg1C1HD6VdDTTkd+xRWaURg@mail.gmail.com>
Subject: Re: [PATCH 1/2] workqueue: fix cancel_work_sync() on ordered workqueues
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 12:29=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Alice.
>
> On Wed, Nov 18, 2026 at 05:09:51PM +0000, Alice Ryhl wrote:
> > +             if (unlikely(pwq->wq->flags & __WQ_ORDERED)) {
> > +                     struct pool_workqueue *oldest_pwq =3D
> > +                             list_first_or_null_rcu(&pwq->wq->pwqs,
> > +                                                    struct pool_workqu=
eue,
> > +                                                    pwqs_node);
> > +
> > +                     if (oldest_pwq)
> > +                             offq_pool =3D oldest_pwq->pool;
> > +             }
>
> @pwq still has @work queued on it here, so it's linked on wq->pwqs and th=
e
> list can't be empty. Maybe drop the NULL check? e.g.
>
>   if (unlikely(pwq->wq->flags & __WQ_ORDERED))
>         offq_pool =3D list_entry_rcu(pwq->wq->pwqs.next, struct pool_work=
queue,
>                                    pwqs_node)->pool;
>
> Thanks.

Updated!

While I have you, is there any chance you could look at
https://lore.kernel.org/all/20261119-rust-workqueue-v4-0-707c68994940@googl=
e.com/
?

If possible, once folks from the Rust side have reviewed it, I'd like
to land it through drm-rust-next together with the things that depend
on it.

Alice
