Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9370315D53
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 05:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787289465; cv=pass; b=D5X1s6jFM096ahPCGjM1NRl0Eih6wmt/OKzDa/Xlgb2zAagQVeux/zaB/U6mxAxWglewxTqeIaI/II4LJ0gxLD2D0dnKe0bGnt19QEQsF9mjlpvwePQWyAg+1hkd/STchdQG6ePAXxpb7Kn0e4WLhNs+uFqt17LrsUrQkzhMrQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787289465; c=relaxed/simple;
	bh=13mpJllH/Zvzc6cEE176TorQISQiQzdps6jTNyvGa88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tltelSOHx6Vfr3YE5SSThFO1oqT7KLR09qiS5aqQrs43WFIbsktV+o8umHA/iROTqWplsmSTGs3DLT+oYTjcUzLrg9OevG9rkZFuzy06fd7VH0TUvPgopfJlj0ubTPp4vpu/fkgvpI3Rl1EPZIXSwZ6gwi2jlZmQu2wA0D4GMF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=mriWnuoM; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="mriWnuoM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso13916795e9.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 22:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787289462; cv=none;
        d=google.com; s=arc-20260327;
        b=Y7p9iwaq4PvS1f61VWcA5f1zHp/8PvRlSDLBkD9nEYaC84v/fHdZEGbpx0QE8CfL4Y
         vZSU9VY+1MJnLO1MRJb9ckGPuNTyHpps6Illg05fE/QuGS7rnGyudzbxVou13I7wl4ai
         V/EUomDvClBetnLmuP28tU6mhAPGU21myT4Z/9XlJA8P4GY2KcKR0B7cI6GGI+qBcvcz
         qLJydYYDlmKx+k7ggDKfrGQd/t5Yrmd3nJwp95ss33dpz7lUIg7xzW8f5ryq6NHLfXzN
         oCZyrkF+XtzXstwbL+TPyl+/32R+heYSB6uPtuFDYLk0ElzyqfxxUa6juMI5gpXd+gE4
         bj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=13mpJllH/Zvzc6cEE176TorQISQiQzdps6jTNyvGa88=;
        fh=Qbu5IHqzSy5OwlKMLhDhJUHtxtL269Ye+IkvBncDibA=;
        b=oXExpA+qLUYL1kFPBVw57+fFYzJl9VNC1a+LQtq/MA7FLI1kZQlnfEnThnKyb12x/T
         7GRnTTVP9sOWkAQMHDFu5hRasp3/aIEaVi+TCiy3h9DUg9FOv+Y2fqD4wd+Q2eAt538d
         uHcW3cUh5Elpr34+O7xKHG1MF4HJ/DNMPQDV6nGjgR11yR4tFrE9NTXjpD9OSztiQg6w
         94pp+DxAUy9QMv5nQCpUQeCu7Bh++O1xVlGi2/nbiDs8JdmVSEbqcbykrBxxBplXdgU+
         aozwmydnbe671Qegv53xPoLcWq9DdSXQaxsTUuDyxi7SLGeD3Vwq5UnnBrqrRSPSvNur
         OtMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1787289462; x=1787894262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=13mpJllH/Zvzc6cEE176TorQISQiQzdps6jTNyvGa88=;
        b=mriWnuoMN0TktLIEBPQp48uKY8GRxvlwq56t98AIndzWS5NbacpAxyyFaSoz7HV+Mb
         h2Ya9kT6j34XuTq6n8NUzV0UncBWQfPOhJ+G4iz9OMZd2UYqI3jQABX19+FUPoppdjiD
         BvRIGCmsdUVNnzt43ZFwJ2K/vNIeT7GKi3hX32XYtwh37fe/8ftzxYiTOXBtx7ppZ00l
         aLb4WNRWPyR3RnaZQl0NWsuWzG63v3YjzhpOVyAuT8+m4ve0L1st/yR+sZ1Xqo1ycxNA
         X5kfBKBJfq/t4R/8uwHnqopgcAYlGBfh1oecS3OEuhOlwsdVukwNy/+FhlZhKkZpeEa2
         5QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787289462; x=1787894262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13mpJllH/Zvzc6cEE176TorQISQiQzdps6jTNyvGa88=;
        b=Xmu4cTqhoFKcUoc+zDxPE1tetlUsYO0NjkyKeVqb5UwFWz6jTqBvWH4zqul8yr6XC9
         yO9JnLmwwxR9aJsTJgJEIhhhv9SPZFye0U07k/DG2bHkt7Xy4IBV28B6whAB1U3kTFdn
         ugbYrI3Zh3JEyB/OCGkCXVSiXJVpB587tuU6EhmtqulTyntTJoMOBXOK4mDm/iELK3oM
         BPoyK+SRZPsP4RQBWcrb++Q1RVciEBd0zXzhrtmYRewDGVUrsOklNICmoWzdqI27knS5
         HIAuOj2IQ8OywNM37qoTjLAu3ivGIS6BSPb+3bepsEZIQMbXFKUvAUlOtGdbRhZF7WIO
         ku+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpYh5qDXl/85ipOQ2jyFDY/yIQGIxyJwu4GCJybI7uP6g/N2J79/jiVDWAJTwV8L+drKh+hvB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiG4pK/FCU1I0+gYgq5t3P+b6fNHsLKl6hoDkx5EqhB/axK+5
	/1ITW46pPGqu+OZeapiFtjXGfH+36opvwr30GXAoD4MwBuThcQlzdSCz95RtLDuwcmHy2WoSGD1
	7G1X/SpckiWbEJ6J0MUgkwLx6D46CmtVhineIo/DzOw==
X-Gm-Gg: AR+sD10XMcD7ncgliD+lf8Gdu9jQ9dTJHPMzermmJjiV9xPo/ni3sorI+XPvGqz81FG
	bT0Et9bwWBSEQekcG1tSGWPUyeRUINIcoXK6TElnVazlijwhivcQWLZMPNCPWKPgbG6YOr4N9R0
	dWwPMpLF+37HGGWEpEiR+Jk6nCAgUWhBKQa5KPvCvwvboMD/DSWlUcIyl0vZAzVWm8q2xi78dFz
	xQZXVZbw6t7KQTXziqhzEqNMlRxR6gf2YbSsKuUwvIZNNVMUmMnt1GSYc78/r6nQ4Sdk40+aKg+
	jahDoEcKrzPaKHpz3R12YiGyiDbMdMwuS4nA2iG23D9BxsX9zajH1tRw9SPwUjQoIRWzWIO1oRG
	9xIgHxb3L/egvk3eE2CzI1nvSkjviNE34lk1QjPDwrEwQcdXfm/6ECa5ah3Ebay0=
X-Received: by 2002:a05:600c:8b63:b0:499:7f37:cb74 with SMTP id
 5b1f17b1804b1-499b06a36demr94909825e9.1.1787289462039; Thu, 20 Aug 2026
 22:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721073612.137259-1-xb@ultrarisc.com> <CAAhSdy3kDmRxcT_+dOpcUVAkvZ-F0kWdQett+mTy93gPDkwS+Q@mail.gmail.com>
 <178728288861.534500.12009100192281293732@ultrarisc.com>
In-Reply-To: <178728288861.534500.12009100192281293732@ultrarisc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 21 Aug 2026 10:47:28 +0530
X-Gm-Features: AcwNN1VyOTE5mxX9-Emhx7eOr0LfPk9cSJYrSJElhptVzuqH563CP-bjvH7fuKc
Message-ID: <CAAhSdy1shnw8-4yNVtsO8tJdebGYdX9n2mJyhoMQ9KpuitsMoA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
To: Xie Bo <xb@ultrarisc.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:58=E2=80=AFAM Xie Bo <xb@ultrarisc.com> wrote:
>
> Hi Anup,
>
> The issue reported by Sashiko has been addressed in v2 by using
> mutex_lock_killable() and returning -EINTR when the lock acquisition is
> interrupted.
>
> v2:
> https://lore.kernel.org/r/20260810-imsic-attr-race-v2-1-00ed95ad321e@ultr=
arisc.com
>

Sure, I will consider this as fix for 7.3

Regards,
Anup
