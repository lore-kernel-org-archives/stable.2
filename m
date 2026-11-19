Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124630;
	b=I1M3Sew004dGYeDVl93dqxNjObTTJwWE8oeV4uNQMoedEPARmrFa/gojHKXYhB0LLWzC
	 03Iwd487U5InfsJLG62xAa6NRiFqbueJ5cLoSoHk6SwEQ8Jiqtg0/VDGLId50/gINp8cA
	 7xTZzuYNFwyRPcBjUN/3FAzOukmpgsNCkEUMHmMvcc3nKVP9w11LYbUrPSoKaYDpDd2Q0
	 iA5ebwm0s9lORoREBdLZKBJXR7jhmBTirZ8vz4gtpebn2Idx4YddqRnUrFQ40EZWKrUy3
	 lrzrAK3nPZR7Bja8o+k8t22+2QqAuJn8yeU+bnKXgFO1A2PCCpTA7ROHyn4ZlqJrMaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124630;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=5Tw89trH96Xpm50XPeAndztRNUxh8o55+6VxfKE9qb4=;
	b=Zv34f89RSKAgM8Bmp+qOve9+mleiwFGxuy8Owir6Zh4i9HZpf4iV2P3SM+SBPO8IN4HR
	 xhn9k4KfDYOPOz6h3+QdqD6TAxkFFhPYtB3ZtQql1YW31KslHw7oICFXO+YJGsySEoQlo
	 AMNtjIQ/mpHh8t9vcR3ch4jM4mrSMgztrZvM/E4op4+kf+cZ0RVwJCzr+MCj2OM0ElKq5
	 81k1pbCcnpEle1w61IrkAUsiFY6BXAP5dFOwAgpWIY3hmd7lqPK7uo/zShlD1dc8A5Pgi
	 s79IwmIQ5va2UBWQtNHNXTx3+xd03Zt5C/448IqUWtRxQ+PWp9i6CUg4Eu633Idwsdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBjhMj8C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05139606A320;
	Thu, 19 Nov 2026 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBjhMj8C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E141F000C0;
	Thu, 19 Nov 2026 21:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124629;
	bh=5Tw89trH96Xpm50XPeAndztRNUxh8o55+6VxfKE9qb4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=RBjhMj8CRY9tZBa0eZluTmf2UolaKLmOQd/bjdik299obZe+kRsVrQ7xvPbCjnagF
	 4djnnuR5RrYr2fFDzatmYLejnMraodfSl4jiB4fjDR5nAVBChEAeaTuCsQ2QP7HVwh
	 RpQuZpuPVQYGJsKuXl5mWvDWUAyfWMJGnoCoiaP1/1ca1WpV8Ut2P1dLtQ5NOPGBxM
	 DOynrcguitnZZ3MXxPQW3VUdEOu8fzHGqpenFP/apRSkzu5YsSWKqb6NpzIJtXhKXQ
	 qq3pRLLo4djx0C5Tm8XDDPTROtAKlpRwdAl9ycxsvPYj1FQHUjh/OOlN5ksbOJhae2
	 Ph3fg8m+1jp8Q==
Date: Thu, 19 Nov 2026 22:43:47 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, bentiss@kernel.org, 
    dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/6] HID: wacom: guard against NULL input devices on
 successful probe
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
Message-ID: <o25qn5o2-2257-6rop-oo57-9o4o54sn688o@xreary.bet>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20261024033040.316652-1-jinmo44.yang@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 24 Oct 2026, Jinmo Yang wrote:

> When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
> the corresponding input pointer is set to NULL but probe still succeeds.
> Subsequent irq handlers dereference those pointers unconditionally,
> causing NULL-pointer dereferences reachable from a spoofed HID device.
> 
> This series adds per-function NULL guards across all affected handlers.
> 
> Changes in v4:
>   - wacom_intuos_pad() now returns 2 for the normal path, 1 for the
>     NULL-guard path; wacom_intuos_irq() applies "result - 1" uniformly,
>     suppressing the spurious input_sync() the old "return 1" would
>     trigger (Jason).
>   - Added pen_input NULL guard at the top of wacom_intuos_irq() to
>     protect its helpers wacom_intuos_inout() and
>     wacom_intuos_general() (Jason).
>   - Added pen_input NULL guard to wacom_bpt_pen() (Jason).

v4 now in hid.git#for-7.4/upstream-fixes, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

