Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BEA3ED3CA
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819845; cv=none; b=VDhoL8+m9Ps2wV7yWvntLkEGNhDEfEUm+5IVw13BbLYpqhQon+jMWwKlIUzeEOcUvncCw4t+W1HEWgSUeNoWCsMxK48sFSgUtkOIQzOxxb+RUPnh5BNbrt9D6qAeV6rjm4QWwVBNugNRZ5yXVSkJyxl3qGWuiqcLyiAH39Let/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819845; c=relaxed/simple;
	bh=W8yXFKvwNj8QS3dUv6tZrcTUl/bEEEJbwmy1a18FlVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ob5bzYMZDjlNBc1PmHFn2VI6rso7A9v00Tc3ksLD6gtUV9eH2ULb7MKEMepQ5qOYXsD9OS5izZNJntLsGIb9DfK99xCMGAhGkF2NrsVOAIlhUjsmNSwa/u4Kjp9AHmO1yXkvsTeozWhMZvdWBc+gt4YdnhzDaBDJDAv1CSxWZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZCGQJV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZCGQJV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9387B1F00A3A
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819843;
	bh=W8yXFKvwNj8QS3dUv6tZrcTUl/bEEEJbwmy1a18FlVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AZCGQJV7UOkLrNWP3hWTN74vYBGgXhr074t1TTnjnM5u88GE9O8vW54ZKt+VlQQUo
	 HCcdzTZUjX8OafFknJd846s2Auxzxg3a/Pnd2RUnAFIUxtPVWTrF861irfANwK5G2/
	 fkic5ynaNHuaxSdNsKwHM17SESOtOgEAwL1e3VuQ/AWk0zeKNq8N3YIck1RbKGQUPi
	 8XTJEERmf9zTFs6fcrz0hwwMeKxE6xxaFxN94M+IOXnUhetnNjDWbn3dwpHrwiH3GW
	 vAD9fyT9BfgMLnGyXQN33G1zA6SzXql3MLHdl/govOIlDOHiaZXLRQwxl+d2w2t43R
	 sdq7iD+UGsM4g==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb6d00883so1566460e87.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:44:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrDC83ahGMSDEn8vN20ivkjbm4/uXerSnVJJlK9eQe5GgZY0aICTroFLYIIO7AEx7saMjX8mFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAc/A8d7SSpsx/BtaZ3lAuwvvCD3Reim7F7PQND2ficGvTjdfC
	6XVSmAOOhqL2mNngFzyn1q5LZETftHXSdPFTzE8OhW8J1TIgwb9XgYupj9txiWo+JPuXU1Nv0VX
	Q4H7EvYFBGN/VfwTM+d1Hn6mjifr70F0=
X-Received: by 2002:ac2:4f0e:0:b0:5ae:ba7a:1789 with SMTP id
 2adb3069b0e04-5aebdb7d889mr791136e87.13.1782819842431; Tue, 30 Jun 2026
 04:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-enable_wakeup_capable_gpios-v3-1-fb59647d89cb@oss.qualcomm.com>
In-Reply-To: <20260616-enable_wakeup_capable_gpios-v3-1-fb59647d89cb@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 12:43:48 +0100
X-Gmail-Original-Message-ID: <CAD++jLkURjnQa44bWAy0E5EG0t8f7kAvQsG2S_Jviwv8LGaL_w@mail.gmail.com>
X-Gm-Features: AVVi8CcYfeqj6YwfcYV_eKNotXa_k8YSs5lPlnaztoOTJAVOIQtv8kQy35rHWaU
Message-ID: <CAD++jLkURjnQa44bWAy0E5EG0t8f7kAvQsG2S_Jviwv8LGaL_w@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: qcom: Unconditionally mark gpio as wakeup enable
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 12:55=E2=80=AFPM Sneh Mankad
<sneh.mankad@oss.qualcomm.com> wrote:

> GPIO interrupts that are wakeup capable need to be forwarded to wakeup
> capable parent irqchip. This is done via writing to it's wakeup_enable bi=
t.

LGTM and Konrad has ACKed it, Bartosz will queue this patch if he's
also happy with it.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
