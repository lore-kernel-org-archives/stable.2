Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347A2E7635
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598153; cv=none; b=E4IG2AY7xixdZGRdVJocAoW/im4FPlpOfW2IdI584rUeqtGA09SERvRjB8jJNxqWh4SNSv0T7sEKUrto9+5mz5te6qnx1AAoyvQAVZjniW5ojbol46vZEIHyiaedYW8VEG9BBv/EI9PUXe5JLU2XPGR9lxuburAT6c5dSM4Dr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598153; c=relaxed/simple;
	bh=CYr46wE5XAX7Y1vwDFvlJRJLa3xImyeWpZgtt6PYaaY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzj/s/bRUQI0t7wCsjEkkqWnOZjXvwIqRZeSHaT6vJvG+7iGt00yx52G6fkYarvQXnufDemy+JdyBm0WJQ/zgp7+yvWz+fkQ19G7E/O5IhrkTu+3e1u1CoHV59GSx6CooTy6KGe4kd2asfmtEJFbLOgrUY/X26ChGRAi2r4fCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp5pldoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp5pldoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348C31F00899
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790598151;
	bh=CYr46wE5XAX7Y1vwDFvlJRJLa3xImyeWpZgtt6PYaaY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Yp5pldoCFMC0JiPqxHh8tvKEvJMqEfjGcdYwitMww7msuDHlhnzLKPuqYuY6lT7se
	 AHqdAuyLRQrDytmaSft8DRu++0XgkLYotdvumKjgj+KQzmjyAAa0BcG4H73IgnEspg
	 b/b9pZQqK5CNqWN2Ko3lVBRBaaucOlBINUQldz8jS67WEaaeUqihakEe67vfUoPsSu
	 P40c62EYrnIsRCfIoJlV1plUMP9fEE684fE5J0FDyuR2uJbkDcR4lSj3Rev7VprgWg
	 OvHoyzhSDRxeT0h8pkIJTzoZFWNp59gMfiqHGUg0R+QTyWDJdfMWnMXZvlLI1dPmm5
	 4KEJ6lHU8MQig==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8e6ec4dc0so2704840e87.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:22:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzPYv1KkX+7VpvJgPUXYSPRPheCttGLiiyyn1GbQaepoWN2pT0fonxERLz7JVwpQQ1Uhjakoho=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOIzJLr2wJiXzFZ8gq+jVRC+p9KK4buLAckwSz1055OWOnjrJF
	tAQgOmpVsYmM4/hDk4xAB7ewdA9f7UGfAHVENwm+oRl8kD29rXmQnuGQHM7r9WRPT9kXYYaXbCg
	Vks8Jt72Js1J6RuVKIy7bvCSZctT0Zo1dxrBCp/Ortg==
X-Received: by 2002:a05:6512:3c84:b0:5b8:e2de:6f67 with SMTP id
 2adb3069b0e04-5b8e2de6feamr3570218e87.33.1790598149932; Mon, 28 Sep 2026
 05:22:29 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 12:22:28 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 12:22:28 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260928112546.631440-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928112546.631440-1-fanwu01@zju.edu.cn>
Date: Mon, 28 Sep 2026 12:22:28 +0000
X-Gmail-Original-Message-ID: <CAMRc=Mf0+O7393fxkcupH2Gs3q9L4-hZn=ORE_zC_c9FFM67KQ@mail.gmail.com>
X-Gm-Features: AclHuK-nfTnJntkhEiDwnqhH1uYRFQ3P8cKjQ9tdRKoWajTwO1i7cEA4_kF9RF8
Message-ID: <CAMRc=Mf0+O7393fxkcupH2Gs3q9L4-hZn=ORE_zC_c9FFM67KQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mpsse: fix race when arming the IRQ poll worker
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, songl@zju.edu.cn, linusw@kernel.org, brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Sep 2026 13:25:46 +0200, Fan Wu <fanwu01@zju.edu.cn> said:
> gpio_mpsse_irq_enable() schedules a poll worker before adding it to
> priv->workers. gpio_mpsse_disconnect() can miss the worker while
> tearing down the list, after which the worker can access freed priv.
>
> Publish and schedule the worker while holding irq_spin. Set dying under
> the same lock before disconnect tears down the list, so a worker created
> after teardown starts is neither published nor scheduled. Use
> kfree_rcu() for such a worker because irq_enable() runs with the IRQ
> descriptor raw lock held.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: 179ef1127d7a ("gpio: mpsse: ensure worker is torn down")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---

Please always include the changelog between iterations of the same series. I
have no idea what changed since v1.

Bart
