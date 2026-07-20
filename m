Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86253976A7
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575800; cv=pass; b=uVp/lZCQpHk3jRE+afie39omm899TPfA7zYJackcSeh0ICHSLjTV+8tippK4ugcrcUYEALfuNa5RrUNxXr3Zx/WdmUxtjBiezeQPIjd3BwZD3aYyuRF6eQ3Gc90y8DEjFdbzvmfpay+zR3kDMaZMCEZZFSd1sTHw7pYh1lYMjrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575800; c=relaxed/simple;
	bh=FkD3jB2s3IIbN08+g0w0TygpA5tj0fOSjjBWkNKDgEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgQrInMHjEa/jBf7mgLm3IQgW3a2Ok3ohLO7oZZH+n6ngwaiqbmaJVmnwWZG5OklAGp7Ma/3bcxK5gNmwsIA4LRTDoVqTRMdrMM1Wnb7uCS9IuD1NigKTYo8BtbeyGC/Nw6f7SErhgeL250sW72CM/AFW9QvfRRSfj4JQly5urI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bee/C3P5; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bee/C3P5"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c15a5b265so831201cf.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784575797; cv=none;
        d=google.com; s=arc-20260327;
        b=R0IRfBzwFECHVZPVTtbWCtpyXwszgXM0VBrsti25XIOPbLlIDayzNjxBhJ4MB1rKu3
         vBwFUx2g7qo71TSFt+AAHHL5ZXCCmNwFRIY/exdEDkLEW8vYI5EidvJ3jKQvMb3BtAwm
         1s++D/rWIEMzbPjCacGsiHUW6Ref7OykBx9kBPrGvZsBMJwL3iHbCxY0BrYghvyB+Urj
         RB/D6oeK5oyYfo6ncpYuT+fBeCd4Nw0bfQIPNLbFOz/IiXQ12v8Hr4tpbpidAxkdcUTn
         UQYFv5Onia7fBZThzaYCp9bQ9vH67uFZ+tmaIVTddVA6Wq//711C2Tz45tUwvh7IsshA
         Wl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FkD3jB2s3IIbN08+g0w0TygpA5tj0fOSjjBWkNKDgEk=;
        fh=4TVBM00aAfkuBAP7rXpzqfZy6mFic51bCwioPFPlhZI=;
        b=dmS9AWRmdYNWHOiJxa9iAtjU7eRKI0Eh2A7r9jD4Y+p/CcrLmOOWnYaGWs9UQMoq1+
         K6BNWqIn2RsWuvsmJXKDy2UJ+22wB53gkoH3gJrwtm5nLkAqlh2hx7+NkCjSUxco9OCT
         La3NMFObpWBtPvEe0iVJol1+cnK+hdAb3yL2hrA5DQP5wDcK9MkeILX5dRMjtXt51iIX
         suBU8PcviYqQg7sKHFlQBo8w4PG0FFiZEBZKieg5kxp7/PtDY5fs6OYoJo+yP+tGybnQ
         I9v+e1Ya65ApX3vjehmi1xqPXWGOi92ck8XAbQywi+d+BzvFgNaRS9u64qGyVeNDVUa2
         dxqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784575797; x=1785180597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FkD3jB2s3IIbN08+g0w0TygpA5tj0fOSjjBWkNKDgEk=;
        b=bee/C3P5ccu4lf8/gcvCdxFchEoVE/AfdNfJdJkiXEFIlnfp+9JwUgqmwvXeQKJpR9
         61TbV0GLC7IKQztjAOinsKdkIrd8GjbKqET9j58ujJ7lOYZ4UuFdBAxeKjIRAz2U+LDG
         VgzDvG6sES0OZfVwfLJyzLI7zI2oayzj4vcc35t/iwHM+sUBjM+KxxSFn1XyJzoIGsdr
         Rdyfyp37Wn/kAycFe+3sulb8FpjYSxAA46X552Hv6q/OyxUostZx6N67QezkJs3Bk3Zt
         aPAfHroP3mJWvOv8bNDxFDNUBltv+XlXf4ogB7SAx4z/Y6ZFN5gfWsnYuCUafjj/ads0
         7uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784575797; x=1785180597;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FkD3jB2s3IIbN08+g0w0TygpA5tj0fOSjjBWkNKDgEk=;
        b=KRQFpcNxkj/X0tO59odWydm9QS9tx/A+c8EIK4Sop70sOQdSO6Wp+wPSBexVoTcqVs
         U1vb1kpz0qQq8phIS5L2HquUVY36IhME62OgYPceAIUOazCPCv2t6qJkuuwJWQ6UlPtY
         2s6lKgpuqq8vPIFQQEpGWki3lRabSVhvzGV/su7gggML04xy6ukEC5zBWhtz4vn89Dlr
         ejeGoJgsM4Qfyo/y3iyquJESY+zKocegu3gIlSEx+DT6ZfzfXKGIsAs7VNQwOTZRaER8
         8qNOi85SD4kMzdgybhPAX/kfL5hFrhWGSwZSO2OEtOaPTh4WiEoBMdKGWBHfanl6vNL5
         jBhg==
X-Forwarded-Encrypted: i=1; AHgh+RppSH5ELaS7p6EulJSnh3qtqU160QXJJnUONI0V2wIKglhVqCHk/6nrXiqK+/3yYQybVi0j2+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdAwMgFKo4pswcNKoA0zjt/Tr7p1hfuuu+bujycqkc7J8IuQS4
	FNIA/kF7+LEFJoumYGUZeZlzlt1vUDOWMx/HC8xF4LlNKdIeA12kp6ohtkBC6sYOOmjgW/72x1F
	FaMXjDkV/MRXynX3Abvceb02s3YO1JlVB7+WzqFq3
X-Gm-Gg: AfdE7cmGQTRrD+fhzPMWhRYjPZ80+8r5rJkmUF1BADTNLEQ5xFqnniVGSr0BGnlXlOJ
	+TwOpItV9catuJc1Z5ovaJrkVVtrw1+vQxMDFhM5wVCiilU9Ovyx8g4/cBHpE08jodtzzl5luU2
	32D6vgdcBeR4mUPn/U8s8YwcdZ3zL6y2pxSmOa8NSn9/QUynOvUkKMC48ntZQA+dexz8sgNdd/U
	YHJKTYFKTgOyhd7DHyZU7FKZIYgCyzNBcP7lhinjHh4Re8Do9sP9Zc8vvQ=
X-Received: by 2002:a05:622a:6d13:20b0:51c:7a90:a79a with SMTP id
 d75a77b69052e-526033764f4mr4774471cf.26.1784575796860; Mon, 20 Jul 2026
 12:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com>
In-Reply-To: <20260718111340.159896-1-linux@yoavmoshe.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 20 Jul 2026 12:29:20 -0700
X-Gm-Features: AUfX_mz0YGJIXTAqoc42mflq1D8eqRe1dNjHeR1gvxIC8uUY_rJ9mhzujQ94LHE
Message-ID: <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 4:14=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> Relocated suspend code in OCRAM lacks compiler-generated CFI type
> signatures. When CONFIG_CFI=3Dy is active, the indirect call to
> imx6_suspend_in_ocram_fn triggers a strict CFI violation panic.

Would it be possible to just copy the 4-byte CFI hash prefix to OCRAM
when relocating the function? If not, the __nocfi approach seems
reasonable to me.

Sami
