Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795178006;
	b=o4dF+ZqdYsXmuzoc04svf3VGNAePf+930QN8xGWTk4oEKHfvAuK2jPLjH5sXA632yHsu
	 4VnVqNk2rYdvcLbesL9+PeYmOw+wbWH3kprxuadwL75mJmPwmEKoQFqCgCz7Bjdf9H1Bx
	 xqzO3L3vn1T1XL8FRUipuQcFUcYN00WLp9B4+8t4W3H72XwiSKHqsNQSqQJz27tqNCyqq
	 /K6MYLY60OpUwRwzzBSONN8bl82SJTHg50/DU4U7V1CQBwp7fQjTKnuTnQhKj0ZoJE4gJ
	 s2DdoaIdV7T/KxsPK+PWSeIqicHup7jnJ5q06TXQ0689zDgUjGPkHGLyxgaJppgFwIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j+vUQCRNRqxQSsZrwSUmTir7hqig5h2JdmSySrlx/1I=;
	b=HCPVBVXS3ot7k9n7iCugct7f/piXN2TvMG+slnikckqf0zuEJepKX7YL07ZU0zTxP67j
	 qXpQf6RYQE5Ky0MfUUERXR0KLMxIM/qt1jwmXspekoCqXMon7tQjAkeXGiZK4XAoLnmd0
	 DPyBp6uEpQI7qXBPn+64l8h3Sy/av8nXT9QxszA9uIHN9FpGrwuSbcUPib++UhZcq92PD
	 M7jcBeNr5fCJ0O6omYDjcUU+5kJik4DU06SBZmZFE7oGKl/ifnryPxUhIsuzGavuSSvWj
	 5d5+ce52HdpUUDxsObolx4e6hl2G9RSISbgvj23VccD1g0Ln2gZ2gvgyZjWSzI/03Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="R7ajZ/Ny";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75FF606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A75FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R7ajZ/Ny
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be4716d76fso78150e87.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:33:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795178004; cv=none;
        d=google.com; s=arc-20260327;
        b=qwxfSzB+wT2lqe4B2c6zTHklyJqs5z+TcqGyC4Z8+DYSoFkyJoOQlTrHnWSh73p/7a
         jJuPrOVoHDRxdIH1r1XKQel3oKJ8yYiuCkGd/TunqnrzB/dvsU3v+SqAStFNNQMitpOT
         VQPlbZpCtUPgd+l2QEA1utr+Cw+ZW6V+MVAW6oT88iRn2BDf2KUuk9vxqSZ/suwrYr2O
         CPlopxbBpO2gQ++BW8HtruhmcfA4KE7RBef+sCg9cIeIUZpST2ZiEIbW8xKyTzku5nq7
         1CBPwTPtaBuWe7+W2knhWTXSWenJVn46Ng6qFMhP2cjhewSZMn0dvg/c/WyJzyd/bsij
         GHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j+vUQCRNRqxQSsZrwSUmTir7hqig5h2JdmSySrlx/1I=;
        fh=pdgduk+dsytYlnRZZiu8KCCX3GnFU0qfnw+vhYeS0u0=;
        b=i+E5vmom0t/9Dq6DT74S6KN0fHJMpWmVkOBcHNMEbkDaHDjg4545uPFKKGdgip61Jn
         1icdeecvwCoRSC9U4NKqH8SjuZc39XfRjsKsAg6/g99DCQCL/rLGn4QVj7228AUGuP7a
         SFhNw2s8y/llkYSQPbv9Y16+CD5/nerP5psj6Dww4XIGavuO0x3k/lXHQL7IjhnX0A5T
         +xaLbju9MY5f608R447/xTK3lJ1EXjKiYoY8voJTLFPRUVshDOXRgq0pEGsG425J0g6M
         UgY2FNmhdtxjcmvqHGoXB2RSOaDIQb1XP54ykOr1rfp6Vmq1hvC/Dcy+jHltRj+YRxlz
         eMpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795178004; x=1795782804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j+vUQCRNRqxQSsZrwSUmTir7hqig5h2JdmSySrlx/1I=;
        b=R7ajZ/Nyrs6M44d02sCTDsIOFIuUW6eSVO0MuT8I23JlaGQdgMCJW9jTk0POTtozTZ
         nTEtr2ZVZIQuLdbDUcxrAtyHgU202PYla1vbh63PZKBr3++Bg4E5RBzlrUiIeGv8aZ7b
         m+UD+sQlZokl3oZhxxYM8iCWhoNSL8uVn9/K6nQmdd4uJn490QFfJd6Gd28mDZ3VYhx8
         APxb4xwqObwynjiEAEgmpeierUqpo8nop6oI5vxJfaA+3jIffLD1MKb3s6WStoARjyBm
         ZBHbs2bGuv4027YzoSrAawl4PPj3Nq3Dp8Ne8Tfa/HzxynTAATI4eahcIl8Hl/Hysr8U
         imyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178004; x=1795782804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+vUQCRNRqxQSsZrwSUmTir7hqig5h2JdmSySrlx/1I=;
        b=IYI7e0+bD81idkdcB7wUzViKg/tB+pYYHdkfOBxIEuZZFicLcN9MOXOwSHr66SuLhj
         gJKNduRN6TCMBfmnOiBjZ1kso6tUsvVWa7/rtVXh334GMrGSk/3zpssmKi1xkSi6jCZX
         muMYGYm4gcwCfapspXECuzY5bxeNr0WrmVWbsFBeTPZTp8duzwj2w36TkLmN46XB2EWy
         0UvLpMVBNvhp7YD89hHlLKXSJenfJk+UgUSHl5w6bMlbUOn8Pp/PdUphhalktH3VYYai
         Ak5/cD5gpvGIFEA4Of1erLiuloBmnVN5HhfoFwxSeSiXpgXh+EyGca5jYSAcVts/jfUl
         KWug==
X-Forwarded-Encrypted: i=1; AL+hErEltU2j8VzM7XrVDxXbFxZpnuEicZdDqpPYBkf8w4D4SmAjs4fxcvwMba2wqTngB88vkQpMfP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nosK0fEZMyFJInmu99tq+ESvyHoS/WWHvYi/ZWtJYNMNvyIGG
	zapwb4aJEsoyy4mShhTS+BsHkAME8UiPrvc07UH2jNG2MgAHLB0uDpAj5suC7Soi1ilYFMdBSat
	cEOG1hQbLfEIA8lUHwZNqBv0Km4IH8z4=
X-Gm-Gg: AZFdTZf45vZlW0S7GEDJ4U3cYrJEScse9zN0CwO5P86lw7h9CegzeYHpPBBFv3xT67J
	DUinWKPd7FmeMImwgutYdZI9BDC8M+Ygm6Q+1aRyzhDMYFg+5pyR0MCZiBIbeGIdXbU26DZ99Yg
	pgo4r/uJCcbvM0Ww/7SX5XmU03+2NMCyd0EsNrVeCqPUJa/XZVFv691BJ1s/BMX8++p8scWwvL8
	RTndHWwSCBYVLV+XRCx6PXBUckdRwoHRw741wKlK9weUZqdjKvDcH4H7o6mJ+vZILAqGu2mHSFE
	HDSwXil5RCq6Xz0vuDBs4KTGrnuzhF3/kCwbGEXPV1GGs99opjheaPaxRxm5dCnKywluq8m2Kmf
	7DIRjqAEJda7X1+CgvhI7cWaR5P44k5mx8c54kUJNaV0mQkDVEIdmQY5XRFFmFYLNU+vEko0SwZ
	6RNGrpq1rfzClkHLtb/gTaaAJTiLX7Y3AcJwssYYba60nPbLIxxnO6ad4CQ4qBOcWqbN769JaDU
	W1yy1eilHQ8QabJQ5/hjL3NihfJh7PZrcdgBnDZiTqStbds9zucuEpwQkNWi9kaD0knSTGw
X-Received: by 2002:a05:6512:1318:b0:5c0:465:3fc6 with SMTP id
 2adb3069b0e04-5c1bc8601a5mr1101167e87.4.1795178003434; Fri, 20 Nov 2026
 04:33:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-fix-schedstats-bindgen-layout-v1-1-0599dd230ffd@gmail.com>
 <CANiq72kcDMqswODJ0OqcqecDG+8mVn7Q43v48=ED5d6tsFOWQQ@mail.gmail.com>
In-Reply-To: <CANiq72kcDMqswODJ0OqcqecDG+8mVn7Q43v48=ED5d6tsFOWQQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 13:33:11 +0100
X-Gm-Features: Aa3M54ohMQ3p6lQrc2oToGcefUhVDgR0ZDZ9v2jLMN0YjlcFyiMJORGRekgKFqo
Message-ID: <CANiq72nrsbSuD8vbK7+h16eEjbYNviC8KNPCfJpxuNgJh0iWwg@mail.gmail.com>
Subject: Re: [PATCH] rust: bindgen: Preserve sched_statistics alignment
To: peder.bergan@gmail.com, Jules Mercier <jules@les-mercier.fr>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 1:31=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Reported-by: Jules Mercier

Reported-by: Jules Mercier <jules@les-mercier.fr>

Cheers,
Miguel
