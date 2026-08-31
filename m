Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915D46D56A
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189944; cv=pass; b=SWCSrUo1fXQ0RgFtTdC47YhUzEtH56zUbAQvpU7LDF5RphpWPaSAYXbkMppYxrW1T6/JNphPGqbBKDsMjI2jj6Xt0xM5APV0gH58xxgaaPyniQzI4nVGgbLQdNHC5yCWHKzK9Av9UEDnnthiHpsIN0cj/ehyIPH6EE5GtjKhgNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189944; c=relaxed/simple;
	bh=5r5lIWIE05yql962Lu66IpUSpOLRAbYoczG3Qe81sGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prU4vagqwW9R2rj9qkv4mz7hXOOD9HRzwwhYwk0wvfuVaxsrXWz4WQ94DVFPNl+zaUCgPOQj4fGpfi11x0Q9A5XgbJC0qGRW3tCmEf+wJ/85nwMqYRLPWVYEiF+2T6yIdwFkbjJ8fVoWDC5nc+aAc84eHi+GVcDsDcnTwwJE/Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6osjXU+; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6osjXU+"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66f88b68518so114002d50.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788189942; cv=none;
        d=google.com; s=arc-20260327;
        b=fCW59vgFPhq4GcprzHBWHbg+3oWFeq932ViwVVZ7SsdAa95ewmx1hrpeBhfmuX+nd+
         NOYM+SNuim5k4W90Mzak67/W41HAbEz7PwTiwhAefre1Hs5aa64N4UmZuU9E+I0rqfeO
         rDJbaKBX/Qjl0eodzDrYHisNns5Gg0LCmGEnEysB8+XOaG6pc/MOxO3Ocy/ykB0v/fBK
         JzgpE3Bg4A5p0eCLatsoXOodkmwWIbOUTKqIrstmWnoIUP5onwVgyBepzVrOlBt27o0X
         NNb07l0RcD52x+7cLrpm6jLiErwaI/AnJN3T5wYodjrQ33DJpvYwgWypfETlLAj5Pb+G
         p7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        fh=Pt8U8b1MGHnGDjSEeTrFH+wBN6XOLqZdcDnTmSDcT8k=;
        b=UYZCwvswNXWtdbvJO3BFnaZxH+BvfDkJa0qraWnxRrddqpwoiR+ypMxGow8sERqYCe
         mk+/PYGd6e8gBc1R8agSofDxp0lmy9APpOOUekFvqa4hx7WNTMqaES0lPYd5svzPVo4T
         UUr1QKDL130SStLgCAAqzoIgI5UJoCGCArH4Y0dcc44cfCoXZ866uiP/cSji4OE8Dj2H
         5Dyq/nf4pfwFiDF4vA6sd95kQbelAginrNXO5phi2oFveDcvlCEM/e5O+rJ9OdZHkBcA
         K8vvVwp6HQN6VtguiNugXspgA9v7uBwpWz41rGuaXlOr2VId8zORJCfNv8B4v8B3b6Pi
         1tRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189942; x=1788794742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        b=Y6osjXU+kW6Jam4k1IzXYyj3nNibFhcTM+I5jK2qbm9mDMGLIx1hPxjDBoFcNCY3Ec
         DAii1KiqmZyrUsr9JN2gVDNeyqCrHhp7ppAXrD3VGfMSDGE+NlVW7hnC/HL2RdaEqmlB
         /CzW3lzSC43kheUmPJOK9NGmjyaziTpAJD/wtE2Yrtiqg3t6Dqj6DKoTcHpZ0inIA+C3
         mJLg0xbTa5j8x3pRPmt1tG70FqySbqsYXXiIHCn7XWhPArKfZ0/aVxMdNYqukd6XlHMS
         I5mSMCjOcM2g77EFw1hAE5CV8UUIBhzqXuWtKSnsNtvAGGm1FhjU2Spe/7fqtRiQV/tL
         J9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189942; x=1788794742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        b=WQVR8YvrIviVOeNb4r4EXC0ycvXPYD8vEh1odZ4LwMsEo9rKhL073ptMHhsjh/qWju
         9Z8qjfc53NsYmIKqNcIScpv7IM3yKQ7OkL5LjdxwpNPIZ0/XjWEZ5S6qIl6ZA5alI9lh
         LcDiDbLwQGTpZUFthKWUuYIyNcfmtCtU2buqLGjGRKXweGKeQ/sTfvslBzd7fif2imWr
         qO8ap1gVgeZM5VlYCjPBhR5VOJ0zNkYDGtOZBi+nbVyGmZLvWJBPer/OYlbmgVzLqwQn
         9m0cyy8IVZWK6O7gZdwKrtOWbdiIwj2vOZSOX+kJDOzV7VUmjwMUpPxDx1tSD+D55odh
         Uwzw==
X-Forwarded-Encrypted: i=1; AKwUvBwVa3LW1pKblSojcj+675EzPEFfnVHhy3urhmmiepkYNJ+xvF6jLa+jRYpvWLJXhojYCY7bt9k=@vger.kernel.org
X-Gm-Message-State: AFuF++msahSnNGw9+UfRwQ6zjAcn6YXYcG83LZBfVw0172XTgKD0Rql+
	vsKtUeKFKddmuUIC2tDArw7JbwFQCLNuf2KAWlkrV6X/Qdcv5IqXvdvdaBAOABoz5Afe+jFZKHZ
	q1ms7bJJremFrWu7VHEXo7YMapSbB9ZY=
X-Gm-Gg: AYBFou2iHjSeliAShtydihGrvSWtKOryRqt+bawi13SbU3wQVEmBmsmK7ivPNFOUFsh
	P1qcslhfzpDMAfrv34qAlb7gMpFfpt9LxINJEWCRt7BFiB7eNvo45DmtmDv/HuEWyCB+t843SK8
	XUNNnPGtsXCyTgjLegHgq9t2vlX8xJQkBRTcxL0sm8xtY6evj0o0XzMGBeNXJSBrBAYk2e3I26q
	SY/tyfN2/8XzTibs+2UdNHesVW9WjQIJplKnmywhmrOLU/Ltpy6ZvjVegPS9Xwyh+roGVzG/W4h
	YfUcDXu4I9+g2C6epG7p4jDrxIiEAHtttlu97z3ElYAfUxN4+N+s8MB8Zt2GLjcPEZ8NKJkI0SV
	Hf6ryVYL8
X-Received: by 2002:a05:690e:480d:b0:66d:132a:875f with SMTP id
 956f58d0204a3-66f87615f57mr469041d50.47.1788189942058; Mon, 31 Aug 2026
 08:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
 <20260710022854.3739558-3-michael.bommarito@gmail.com> <20260831134023.7784374a@pumpkin>
In-Reply-To: <20260831134023.7784374a@pumpkin>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 31 Aug 2026 11:25:29 -0400
X-Gm-Features: AcwNN1XCy_2Zo6asUAI6Mo_MrE5tR1bf4Mf0i1abV1r9A7R-zlEGvrG8uEVg748
Message-ID: <CAJJ9bXzmVKLQopUHTNh7-C4WggMcBJ3s9KShA05piwm9VTMTOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: hyperv: add KUnit coverage for device info bounds
To: David Laight <david.laight.linux@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, kys@microsoft.com, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-input@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:40=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:

> This has landed in rc1 and fails to build (with gcc 12.2) because the tes=
ts
> in fortify-string.h detect that is it writing beyond the end of the
> structure.
>  module_exit(mousevsc_exit);

I think Juergen and Jiri already found and fixed this, but it probably
needs to get bumped up to for-linus sooner.  Sorry again for missing
this on the original series.

Thanks,
Mike
