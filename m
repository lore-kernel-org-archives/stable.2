Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794475878;
	b=cuGgP8BjBwTtjdZrsmP/k9b15oMDFbtOsfn+mQyhaZG5E2kfnCdTcIfSdzM1SgxylSYg
	 GrXtqzKp6KD/UA9/KWCRXdNUDUsoEdu5jgAQxMHJgDsWzgzR9fUzLwuWFIjQPo9lYSR+y
	 sg6L+B1khEVP6PWQ8iNFHOiSEbY3BVnV1t5/1mfU2Tt8XXq0WRm9XjkCtC9Nk8tF/msBN
	 P18s08tUIDG10EZJE4aFmcmbXGXTWPfGDr9Wyn76HOu6rTjdyG/yGgtNz8ENUyrtnTHC6
	 cITIVOgJffs2mWf57XU0ibhdc1CCkl5AjzLlYKyaC4t4jK6pFRdhv9STW0vvm7r/7Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ei8dH+lQVjN7xvZrUNzulVpjahdWK5/bbzW8ZyK4nJk=;
	b=A1AePj31jdLmFBqP5/9h1nPAdc8Z3sn1SprWLW598MxoQN+nBq9BpvkUQZNYaa+PxxtC
	 IQUXaboAUOWql5T61U0P9mt7jZbKmw7pgze6ooNCu8ZP2VUS9LJKKfbk2FMRs98KGdC3F
	 uuCq0Yay61ur8+Fl4S8plHJfy6MGhF4mXtD4NysJ8PbmF3sMsnU/7g6CvdCD2FhNj0QCy
	 YLIRhjvi6NWSudG5NEkc3Hkqd4WXtbdVwd0ilsu6Ov7OLU+Y2azngMcOKnDTqVaqGjPwQ
	 4+f1l6JT9vC1pOYvviHosIlEsD/4EwW/otjnTpIeXpejp56P5OMnMRd3n4FYThy/FFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rkWZYYdM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B1606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E1B1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rkWZYYdM
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67921b515a7so4623030d50.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794475876; cv=none;
        d=google.com; s=arc-20260327;
        b=BWCJDQlQE8KygAB4O74278p6iebgU7KzDzg21XyB8vF7dWnE7iard+oB6u8/i/4P06
         s/AMWi6lTmb5zOJGKfYT8TbETwP5TxzU02neUsmCcPF7FXGLFXgyWDQv525pWfyP4alA
         BjUmyI8LodlVUQes189Wk7Ugp0OECqJ2JZwAeTdGjQgIhw6zoZfodbqy7SpL+wap4EAk
         5MuqiUn/akmrodnw3BzzotSucuhmMyMfb90BYvie3iqY5ljHlmG06ITVnAsXiEVXlrQ9
         jGbJS35ffJIHqVyhwAOW7y8MNsD5vR3a4qJVg1Pax4BrQg+QXK0QaVYUWYiA4ubTsw5g
         AgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ei8dH+lQVjN7xvZrUNzulVpjahdWK5/bbzW8ZyK4nJk=;
        fh=LAfvnfjHh0z0tB/LDGaEKkWhW9aem/2JDhvaewZ5pSQ=;
        b=NCWNxeZT+4RYezi41Q1kUl3yfLQ7QZrRRh2XvLxYo8it5X5cKvtU/GGn7crWPdTe5o
         yVoHcwzGnejDP+j5RYTfkaScEVcAbmb23BWkcV+m85jt4hRoFOHRc1GQycUAVp7QUucD
         TifTrPf7LmNBbNzK6WZy3p8si1s9XuSK+ymKlibHIN96FEAixfh8aSQOLK8vxAo7mN26
         wuM1E1tYRzNIE2xDmsU4mJjYdZqyEKQJsO302D7TkUZB5HI1WcvONzIgOA2QGp6fheC/
         eSQ7dIub6mwSqHcwO3iSZc4iAfBd/2O9UZPl9rnLH7JzTkIx6mkmz4yvR4/4TMuE4WtK
         SxAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794475876; x=1795080676; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ei8dH+lQVjN7xvZrUNzulVpjahdWK5/bbzW8ZyK4nJk=;
        b=rkWZYYdM0K7SmYI+8hy7x97hj2rpu8rdXzhNyx9CAi83bVmkcOkrGSmOCbJRzFf3Bt
         6IIlVvsQK//hm/LL06n8XXjLJ0YfD6cbRFIl2U4svXWHJrOWVeTakIxZggAzwbYOIKhY
         xF/XuH99e4ZL12APVAXrGVdMcliyKXSPN3tzqxbKhQU7aEV0nH3JS5YRpdYTQlsW9KNu
         Wvrez8SjhIABZ/+DBWa23yBWfAfqfh6xXqRncclXFCSzrqwax69HjCJqnRrv7083cGjh
         dBpDj1gZzpv/5mJEWlbh6q5n51UKNVt/v5Me6/0OWL7izegj+jVUYUHywACuf5xjrPVH
         wF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794475876; x=1795080676;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ei8dH+lQVjN7xvZrUNzulVpjahdWK5/bbzW8ZyK4nJk=;
        b=C4FVhIvJox/eubxCQScp7X/L40Uv7bYnxcafwk2OHWutc8NYlQ/PNfoHxiVKcYPikg
         T4yGnUlXPCIz55ZuZi4IsYN+p35JsNVMt8sNtRZI3Zl8MB5rP5tgu/++kV1RHFrmaNxw
         lwKKk2VyffjMKfoWVlnNOGmawcOtZiTEK1KQL1iXTw8d7tzqfnSCr6yhfHlTTK7AvrpZ
         E534MqprL3CqbniLA7CJRvhHxuVjfbt+3imQZld9a7hFmIVvuQhx966v8A9IiHHg58kp
         xJMaSdaC8886uKx/YG/gXUIZWaxDzKLFvfOoc9cjZiUsLGPpiUqs3bjXykvXaG4X3D87
         YL1Q==
X-Forwarded-Encrypted: i=1; AL+hErEkAh+xaKyN6gx0Nyl75p1X+CERv7MUDIIoInU/jAnMyNRjxfKqGV5ZeQ7bILnq/TCRBWNd87Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wXnyWak+Zht7COQuA5HtWdbLpJGR1PkUqdX5BxLFPheyYgor4
	cXoyZPtHggxLCmUcNu6o/NNjty9QMVn1MD1CSbCzdXrP7Mhif5UJdg2HhzSSUMSZ5t8uSvubSkB
	9ICWT5QCrnXnTiuiRuGmch//UjprecPOTGwW7f0F7hw==
X-Gm-Gg: AYBFou3AtphYyvbAS0hpmNM9E4xppBwRTsm+fQjIHEeOAz87szZgJHRckLBcWNDYCyV
	39IA20euMM0qhE+WHx8NdynxBYhqlKp3819/bPu/G2CcSLvOtJ4HpBZpjnR27A4Qc0kKIiUMhEw
	vZedfWCwhH3V41iGZRLc+RulAIxwam7HNp8doEX5svP5U0jET8WK2ZIRsZssei+4VacxjJ4v9vM
	KvgAtqXZvd8n33QXUUR7SRWwq+hoRYm3uB8YtGUZacvAsiziwJj2KUe6A9aOjkF5S5kWy9SLn5i
	bhj96PLBT0ZhjuQhdBvuJoX70ac7VzIMl3tQDgRD01CGpHcI9km10KTe4QpLRDCILsk7JE63eiO
	jg4tNs4oaLxVKXdhLO/eMoCZQl64foLFJwEv0Fw3AlRudXfkkB3PZLJwdeYu4E/Wly/JQ5cZXha
	Kp30xghwU0Y2suCyqURUPK2OyZgYWtgwC5odbxr+KJ0A==
X-Received: by 2002:a53:a74f:0:b0:67b:f91c:10b5 with SMTP id
 956f58d0204a3-67c67fdfee6mr2823993d50.98.1794475876355; Thu, 12 Nov 2026
 01:31:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112025159.473997-1-patrick.lister.dev@gmail.com> <0384a52a-31f6-4bbd-9de8-8efe73610e28@app.fastmail.com>
In-Reply-To: <0384a52a-31f6-4bbd-9de8-8efe73610e28@app.fastmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 09:31:05 +0000
X-Gm-Features: AclHuK9o1ZFb6zJeR4-pm6DWlpcG08b32X5ENGmHxfFB3Vx0UUm9PpdFEohX-II
Message-ID: <CAFEAcA8bim81-aKR=whfBaaT92EUAWwwNS8QFAq79Je4Sm+XwA@mail.gmail.com>
Subject: Re: [PATCH] ARM: nwfpe: use task_pt_regs() to find user registers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Patrick Lister <patrick.lister.dev@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Ard Biesheuvel <ardb@kernel.org>, Linus Walleij <linusw@kernel.org>, Keith Packard <keithpac@amazon.com>, 
	Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Nick Clifton <nickc@redhat.com>, Richard Earnshaw <richard.earnshaw@arm.com>, 
	Ramana Radhakrishnan <ramanara@nvidia.com>, qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	luis.machado.foss@gmail.com, thiago.bauermann@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 07:59, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 12, 2026, at 03:51, Patrick Lister wrote:
> > NWFPE locates the trapping process's saved registers relative to
> > current_thread_info(), assuming thread_info sits at the bottom of the
> > kernel stack. Since ARM moved thread_info into task_struct, that
> > expression points past the end of the task_struct instead.
> >
> > This breaks FPA instruction emulation, as the user registers are
> > never read or written and causes out-of-bounds reads and writes of
> > kernel memory beyond the task_struct. Any unprivileged process can
> > trigger this.
>
> Thanks a lot for chasing this down!
>
> As I understand it, this means that nobody has seriously used or
> tested OABI since 5.16. I last tested it myself in 5.14 when
> working on 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
> thread_info->abi_syscall"), but it was quite hard to properly
> test it at the time, even getting an old Debian rootfs to work
> with a modern kernel and qemu was nontrivial.

> I've added the maintainers for the Arm ports in gcc, qemu and binutils
> to Cc here, I believe all of these still have some level of OABI
> support that they kept just because Linux still handles it, but
> that can then also be removed.

QEMU has already deprecated its OABI and NWFPE emulation as of our
11.0 release in April this year. We'll probably remove it in 12.0
in April next year. (Our deprecation policy only requires two
releases of notice before removal, so we could have removed it
for 11.2 if we'd remembered, but as we're already in freeze it's
a bit late to do so now.)

thanks
-- PMM
