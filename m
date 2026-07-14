Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067A43D50E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020768; cv=pass; b=jb0UZ7FCoGL+88vQKL/bj6gT3FnoV2vzF3CQz5jr+A4V2oZb2HxVuQtZPXFFHLyKJ/o/qNnHvf/DUg3kQzhzT5Smm93NHwpBOXGaqE+paowoNypEWj0LQ17VmfQTvVyJDyGvg0S3Zq6R2nJegXTHOouu+kOYgDwvVyR1YlSakmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020768; c=relaxed/simple;
	bh=1+6OfoIbXmuIEVoIyX1bMPQc3AaQ9LY/ZItgZpQFXXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgbFlSMXodqeiJBOoxBUpcQOD9H6r89xE93QYo4Tnyw38/BE/1FxEwIsFIx0NTWzkesT4arHX13JKSkK24wIrlLrktKsnnb7ZYEbPLEiahWtFzqTq99hVLH96P2YjNIUO1Y1wYV79jYztbGYCsDIjPWt82nHfLyedHwQWrEqNzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMDKrAY9; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMDKrAY9"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384422b05b5so549385a91.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 02:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784020766; cv=none;
        d=google.com; s=arc-20260327;
        b=LAS3sCcuKuuATQp56smvBodrOo2dSM2Fqe6xLxbUCbkjtFUzDg75DbYaVgfWtEQtRO
         SidNJ5oRCx4J9WOW44zEZrMZjnC1vKuC3XOw1H8Z26UOTQAS0TPiDd4OA5SJQbPqZ5ad
         OVzzbmOM6jc4cQ+9j+idtB9Vxi7M04QrM8XIRhWcXDY5WijjlBh6f8FbQZIc0hfgdAeK
         /yp6wPb2EYwE0dBPbwILIhDf0zDNcO1wrjSjXTa5O9hRewrF0wTUGjtocPZBhlyK6xyu
         8RovqWBCYxWFBL+qVlULH9gCxG4nOu0MctkWBJnT9pVpMqucFJIXHqpcTsBPsg7y7l/b
         RRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1+6OfoIbXmuIEVoIyX1bMPQc3AaQ9LY/ZItgZpQFXXc=;
        fh=oONkpLKj262pDpnWc2kFaZwKOcZUKzJUnavrmtlwcjE=;
        b=HHcoX2G7gNt80LYqOECnT2MK5kGktsiuri0FV+NJ9PTSV9jyr66lbntok7qk0q78uG
         JYIVp+LFhGJP0y0AOJZcTr+aKs7u724HufDNHz6spml+1c1xQmMpOLU/RJ4gRNQ3HC5b
         BbWJpLxx4uNfVSYl+t/UMdtbCtCKQL2K/Cd1hx7X1p3yHLGHluYVGPTj+n+kWygNEBGO
         uvla0E7GsmE6wnQoIqGL1iuKXIXZgjv5mqgxo8DdL4AX6BQMgvLOt1unLuouxlrkcb02
         gQt6WcZFANxl0YnRhTjpewVupIBqJimKIJfQDBduZZqRF4+idwGdXp8nHYtb9FPwcrxj
         E4OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784020766; x=1784625566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1+6OfoIbXmuIEVoIyX1bMPQc3AaQ9LY/ZItgZpQFXXc=;
        b=TMDKrAY9USx2GyQWgV48IQXQOMPhSoywVqYLHrJK0vFg8F4SluLxulW2Ic1qDCJGXN
         2+wSasQMStQrjT1KgoMQRIOXX3vCn42S9vS6p8rzI+yyMtWuhXpyT/5sP0AHkrF1F9+q
         h6icAzuqIMdWZimxjFRO1yL+Iyx1wervdi7gt1xMX39/bdr2JeHgdkhId0Odmvrs62/j
         /xplJ/SIr0pGLSgp4G0aQ8l2OCuqpVqf6fsz0Ilgt+3NeXtBzdhmiiXl22AsD+t9nysn
         mNFkWCoAo5o/keiTHYZZKGm566PAuPSvk6Ac+z8u0jynsO7oXTBJUa3x51UFNu5r753i
         pBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020766; x=1784625566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+6OfoIbXmuIEVoIyX1bMPQc3AaQ9LY/ZItgZpQFXXc=;
        b=UcUV0INx4CEukcWrcKeRBFD0aO+UPXrnEYUpuG2tQxFdiBO/upjT6Cp+M18PEX2SHs
         jjp/UWFdgVvkThfN5DJSzlxK3A6ko/a+rAs5JstI6skcEbSFoennYqYMuo/xwbxHj+EM
         RSzZ34eWWLxp+NPXv0THLu6exMTrNCZKMY6JjXHjY/Enb1KLWSaopLt66S6wLOI1yZKk
         ws2SME05n6hRycQSw59pgEnJbQE3Dw5b36+gyaNa8X3+6xWxiRCLO8QeIqEsJropwkoo
         Yi5e3iVVmb0oR1blL7uDSlxhBKqY7/FhUN3QNLG2YfniYTFujshXqJY7s8NY1zg9oh6L
         JYpA==
X-Forwarded-Encrypted: i=1; AHgh+RpIRItMt+1snEtf6xFR3m0idPjo4/mFGc4JPGZ4C3w6NfEhRmBzO9bvvjwiAO48CP4OLZwC/tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1uBH8S0s+6nH1XV5lYYz62ak/clodvpiTzv750mPG07fYt/U
	j4DAbaemuDvib9L/78068qOOoIXzflcHAJgut9+DELPQ7wv1qm9s1y9pCQPhfgdwy2u+ykfPTCf
	LhW6LXjDs91XHvPjt8su3/d1D22dyXHI=
X-Gm-Gg: AfdE7cmO4AQ3y4GA9u5JJ1hY4lh5JGGaHM1tJymr8IAaCU2fe9dWcbvAAiMChp4h6PC
	il4VEQQQDa+OA6CfEte8dPSyY+qWcT2HguD7tvAVEM0um2kvgXig/jOi0v/2/0dG7nlG/uQIrqM
	83wfetk0ZGn92LdL+DXm37ikCZCYvkRvB1m/AsJXv2n5hmP0jZ6/kEdZOayIudIF4EOWuFwO56Q
	AD8AivPPeVACIlWLHk9tnSiwEh9DZnWkq/DkTiyZX8CFCCrZ0z6CuhPGzQUBG4RJpN5IVSswuCC
	RYe1r3jzmSRhQsEwaxTeXrKkN+QNFTbp6yxC0YYBFIHXXbe2Rb/ns2tqSVMd4QB5jo8Mvmo0aPp
	+BPnMkHk0mKDMJlQhpFPpPSs=
X-Received: by 2002:a17:90b:4c02:b0:38e:bfe:81e6 with SMTP id
 98e67ed59e1d1-38e1a9d90f9mr1536708a91.1.1784020766402; Tue, 14 Jul 2026
 02:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com>
 <20260714083709.69517-1-litvindev@gmail.com>
In-Reply-To: <20260714083709.69517-1-litvindev@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 14 Jul 2026 11:19:14 +0200
X-Gm-Features: AUfX_mxhVU-rpFvO4T2J_6Fnb7m9tCvhM2LiAWJbL3xu2TTk-JxiIQfVMXQWuLg
Message-ID: <CANiq72k0RbkWk=8hiNzHUmFWr=6OA2DBHAUew4OfZb_Umb=6hA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/tags.sh: Add support for rust source files
To: Sergei Litvin <litvindev@gmail.com>
Cc: ojeda@kernel.org, nathan@kernel.org, nsc@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 10:37=E2=80=AFAM Sergei Litvin <litvindev@gmail.com=
> wrote:
>
> Cc: stable@vger.kernel.org

To clarify, I meant this one for the other one, i.e. this one sounds a
bit more like a feature.

But I am not sure -- to decide whether it is a fix, it would be nice
to get a description of how each of them breaks something, to decide
whether it is a fix or not, e.g. the other one sounded to me like it
was a mistake because it added extra unexpected files (and I guess
that could in principle confuse tooling or perhaps makes `cscope`
print non-sense in some cases), but does it?

Similarly, for this one, what breaks "in practice" for the end user?
e.g. is there an error message, or does some workflow break, etc.? (It
would be nice to show it in the commit message if so.)

Finally, if this one is a fix too, then this should likely has the
Fixes: hash too.

(By the way, if you send a new version, please Cc the entire `RUST`
entry if you don't mind).

Thanks!

Cheers,
Miguel
