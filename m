Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F794CA29E
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448424; cv=pass; b=Vi0JbkUZCfeGOgSQwrwRI3rqBctWbBdXzCRX2gIwFtr3LD2rqlR3ecTI2zlqqyWgdmmf8qiHH6S6EnfKWvOIqmXfPCVzRF5OJjCNIVy3RG5d65uZtztuXKS+xSQvWH5nnr5UIO2AKBpSv+XY202XSPP9KZaycVoCFcSIuGnObAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448424; c=relaxed/simple;
	bh=gHC8dvdEpDz1Nz2lUo3KmKCOdTOAJ71y5C+4u4jq0tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6ozy9kycLPPOQZ6VTBDIQNNcgFaY8Jevw9q0PZuKTl4LiT72sLcjLtG4a/BFsbu/t8Qcgh+tJNS1BDWZTwOJ8d+0mygiIml8chXPAhz9SNg02cLIJwH2xkVvKZ9wGD0Dsl9JwPEUc8WeIzJ4vCQZIHuDa8p43yIGD6tJ5HzbI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUEq0o2C; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUEq0o2C"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1c7962bdcso956a12.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788448423; cv=none;
        d=google.com; s=arc-20260327;
        b=ploxE8dOHpbH1V8YNIJ4wihf+R+mrKU39MS52oY6IvLXbkiEA3dfgKMcMdCrf0yiGl
         bdIFYB47HOmY1jG+WswpfzSjjc238yu5XKNSMDd6Lj7aODMN8t4CQH7t4J2DgKrjRaWe
         lssH31D9F1eiXHCXSYAl/BW4KFknt9YOg6+oLFaS0Bhg7wrOz3PoG5Y+Kk8ezWBF4NZX
         KeL7S9tKSqqi2DuG/JV+0+4dx7x3OHLKD9xCshKwQklPfFX3AFv+IlZxFqRrnfjyIAIJ
         qomYfvHq0oi+y6xhWTA6x9b+TiFyiq1Njv/Cn2MORqKSLwhi2KuSn1kER2U06pgN5zI6
         SuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHC8dvdEpDz1Nz2lUo3KmKCOdTOAJ71y5C+4u4jq0tQ=;
        fh=ZXH18aCZj7OO1l//4N7B6hPTg2oFZvRPQM/FrAh8Iac=;
        b=a39JYhv60kB7A6X07dXYzWrt5vNTrQfHAtoNxiAncgFE6lFCnSk5n4kxVYWHwq7Can
         X759ZpqchyPorBR4ig2pXx7krXOEPiRIt739f0boCrL8QqZWZtMez04fXNwERm6CvrPG
         RNCUGSuHaacexBsdA7PmNflNW/aV2nnFzJRrxBro0OpXlj0jUSggfrySO4OyuJhzUBMm
         yzNn0sORDxcD3gd8LLzMUTVNpeRmlpiXXUA0Xzm7vK5mJLPfDw3eDEolcowNmWNAx89A
         8AviWH4Ez52FgHNQrROCQ9tfsJ+6c//28+UxgmVezbskTNz2AzpUdIZBhBATQ9up+PY2
         Pt9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448423; x=1789053223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHC8dvdEpDz1Nz2lUo3KmKCOdTOAJ71y5C+4u4jq0tQ=;
        b=mUEq0o2CwxleZSzvmjWoFVX2AFDshj/8GlUrOSmfQcRcZPhueWCXLXzqWKuAIEAR/v
         aG/BC+xab000RhJRZnIvWzZNxcbFu4F0bRU4tIwkLdN718Y/oVERClD0uX6yW2BolS+d
         rEo2Ny7OgA+xZfBMP8KuEGvzJyVjX88fxCovbs7fB+kfXVZelxTkicSmiEq/gKgXz8O3
         jQmgfTOz6MgvO28o7D4LZI0D6GUDLIBXOYVEW+UjkQ19lOcp7g7/ipmfBSP/g7pj6yww
         fj0BUIkPcJSjbnz5/GkkdtJt34p5nW9jBUNe8oj6OrXBroJiq5l05KyEb2d1c98kuZxI
         /VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448423; x=1789053223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHC8dvdEpDz1Nz2lUo3KmKCOdTOAJ71y5C+4u4jq0tQ=;
        b=EQJPt5pvEoklMBwbNLMiFy9Dh7Df8OOx0ECHeEjRfqoMu5xi8FYT1LA8Ikouu95J+e
         1RMHeEDro0maAq/xEybMjCqN3blxc8B4lAwFEXbFl63ipalzY/skXididyCjC2dD8sml
         1uOh4VcCHKF6tw8yIPtqRboZzUUl2hHDKjB9M/Cl4hGpwO8CovnZPgznzv6qj5ltFh8P
         4tXvPgOushLOnc6iaG/iytseabMrKDbc6kZc1s+gBs46Zx7fHdYzK8VPJE23byTQ85wP
         SErXOn40e125fdmPGRwR0SH7ygHU0I8IGJjuzkhCpkbNNPS2ttq2zDtTY0ZKLkssRIbc
         1qpQ==
X-Gm-Message-State: AFuF++l3Vel8Ojl4CCA7T7j5Cu7lXnVsvyk35gjaEnOTZneG0ESo6Zdx
	aTCkQ1DrmjEri2q24ifzXa05XehHErq5/khFY9FQT6uBv27qwpKIwAw2adY3iL0fLPKyXhKYMN2
	xgg5tRtJKXxg0p+HwHJd3Ulp8WyHXEhc=
X-Gm-Gg: AYBFou1KrOQPzaH7VGQfejzsHgEucm0ku90FHi5TUVBLLsm9OSJd+bFRwNhWucEEJ1x
	fEQ9SwSRgBuAWswayIEAGyZZP/nIoX0ic5UZc1QtB7x8BlijDshKJJ87jh5ZzS8HpmfU6pyFrb3
	6WYsJtxryGROp/Z8dtMUtnHHJ+gXiciI7zEtAdoAkZp/z9uOVeW6k0U9x2W7Ojs5ohbH0v5d6Ni
	Fy69PkkiQodji8HWH/ZgSKLqlzGOAOjqm1xW03a1ZmEuOvWBU0vSEYBOT8bISvdVJTM91REKx5g
	O48OTlU67pO3K2B4icjtudCSWOf2yEtj8vZ7BPPidcZsRZFv8nQvY6BEw+A5w0XT9YAS//lYbRX
	7guZvKHD0PauF4tye/fnJ3ztjKAe4+83NF9+XVTD4RTYaZH24OgunI2I2Bup7
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr13316971a91.3.1788448422874; Thu, 03 Sep 2026
 08:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090303-moonshine-study-20ce@gregkh> <20260903133902.763984-1-sashal@kernel.org>
In-Reply-To: <20260903133902.763984-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 17:13:29 +0200
X-Gm-Features: AcwNN1Vv_qCor0zGsm0Y59Y3FyDly6yZsq9oQqWOAlNj_4BOfjz9S_alqe34YLU
Message-ID: <CANiq72kDcEL3W1FWd37D6VxwyJd2Q2nKqLJCHUw1cd9_9VqADA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 1/3] rust: rust_is_available: remove warning for
 `bindgen` 0.66.[01]
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Tamir Duberstein <tamird@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:39=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> [ Upstream commit 41cfbb4295cf9fcdffa6c89ddc84dca2fa392c98 ]
>
> It is not possible anymore to fall into the issue that this warning was
> alerting about given the `bindgen` version bump.
>
> Thus simplify by removing the machinery behind it, including tests.
>
> Reviewed-by: Tamir Duberstein <tamird@kernel.org>
> Link: https://patch.msgid.link/20260405235309.418950-19-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Stable-dep-of: dc01dfb37b34 ("rust: rust_is_available: warn for `bindgen`=
 < 0.72.1 && libclang >=3D 22")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

No, this should not be backported -- `bindgen` 0.66 is supported in 6.12.

Cheers,
Miguel
