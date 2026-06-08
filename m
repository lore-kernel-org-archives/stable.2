Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490138F656
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904511; cv=none; b=S/ns3i7F6Lyjt+Pm0Ssh28VApyNoEVh3+God6cjhQsIbe+1PWkDF4k14qVZRltorRKfABDknXG+5tE2dVGi0Jbw5r6Q2RP6OiQLk7iOiDUMMzqEmaRATizq+fAl538tvWF3hyc4tOx1q2X77W12NPD3kPdEuQoCCAKz/nREEoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904511; c=relaxed/simple;
	bh=R7MwiCWB0jLjrbgihAJaI3C+U48f2yX/bqNuxPmV05g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQYzWPDMOgX9q3Y9xivJzbPmtpnbf2pmDC5cK2e1E5wdJZ8BQJX2EiTfQoWvLd4vNRXydLNRVujD8u0A7S9/Me4Imd95ieJM1MxMmT7Q8ITsjYzmBLlEt0wJmOPJpLf5rhv9NTk+BCAFZ8Zl6rQbcrU1TR5HzOJ75nRwxCYLSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6cfcad4f979so3472210137.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 00:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780904508; x=1781509308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt9sAdVpyjABq8uk+bJPrbepMfmlnejqLbS+z27bzVk=;
        b=R0AJPcegdySRsMUml2g90+XfjErkzpHsVZDSydNjlPlatQVp++AlH2Y2ABeuPvNqZ/
         7w1++cz3rFGEATtT73xsRkULkTxoXMYASU7SupwKmnt3IFDAT3e7vP4/ag6jEnUdULT9
         fQUmrwDcQEMNgl4O2fQiHuhAWx6XiUI+MhqfGVR8eeAPr3kqUlyKOmCS+inx79dbzdDV
         ceI0k+MYKSQ9Z5Z9z/aUgF2eGLnsKLlAuvhg8NLVKE3PGPSr4TjdNbp1fthvjDQjViI2
         046cZLltS2c20QxCzN2xK2RTb0u7Ok2GouhU0ieqvkFf8EHqD5Y+jPNcUmTwzPc7mbm9
         pZVg==
X-Forwarded-Encrypted: i=1; AFNElJ/skwIuDsGMIF+T1F1jQo1EbwdguHyot2Nr8Gh9Gi9ayhEYud3bMzfoMR9krqUpNx6aEGIGucE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniaANi1uxa+TYOZoFO/DFia02A6LNkN9AT6spl2uthY1my/ud
	VdXUfZpnxb6CzsNnrQ6rnZjOPH0lVqvq0C/2uSZ5x3coqIou5eVg7mSnu4iLmrU0
X-Gm-Gg: Acq92OErwMamAiOLJ6dU7nUfy06qe/VB8AI9juUjLICyPdYF/58C6nd46FEuPyOJkz+
	Bsu52S8pIlpkYydheJYC84CcCYogUt2n2fIlI2gZZhChvdnqpLW88we+SXh+wWZkm5MSjBY1dYp
	Cd4dAgOVNYHJSUbPKZMx5AYMOct/TsbnowHATllTo2y6zTs6Lq5oziC2d+WR+ktK0slFoKkwLEV
	mjhRk7FlkY6NXPwu9Py+XLTYpbQdfA3hthBhH5DBwuR/exU4xJcphKtClDFyIXTRLrhIHPB8o2H
	GWZ4ejWD9RaIOURN9b8QoRJ6IZY03bDSV4U1LOL4IsQgtpzBFnp1VlCXhYEJPVZia85jIFbxqF4
	JlRg2hINxu3Dxci3dI8mWEsstBpHXWp2P6UpixfLbdnf8yg6pGAquIdzAOoMuvAfuGOJn+fE4hG
	B3h7KnexWFPfLOxZs+yTSyOrJBNfjZET2mJpvc6YxOst4dsKReYBHQe6hsiAsS+kjYd1vIHXcjY
	do=
X-Received: by 2002:a05:6102:148e:b0:633:8c42:183a with SMTP id ada2fe7eead31-6feff8177bemr7716792137.9.1780904507944;
        Mon, 08 Jun 2026 00:41:47 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96414115a93sm12619017241.9.2026.06.08.00.41.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 00:41:47 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ab03872a64so1760896e0c.1
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 00:41:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/95Lx5WD04mPYFZ3ojQQ1YB5r8nmJzpRfUIJLfJbEvIuiL6bj7DR4uLLhsAX2cUknM1rzkwdY=@vger.kernel.org
X-Received: by 2002:a05:6102:6b0a:b0:631:7781:fe8a with SMTP id
 ada2fe7eead31-6ff084a55demr6790737137.19.1780904507130; Mon, 08 Jun 2026
 00:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608071123.128964-1-vulab@iscas.ac.cn>
In-Reply-To: <20260608071123.128964-1-vulab@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Jun 2026 09:41:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWz1Z6Pp1hss2X8R2D_9-bLjUpYnpdGEsGtZMKbF9L7pw@mail.gmail.com>
X-Gm-Features: AVVi8Cdai5h3PhjO-8qphts-gv8u9z_8lWsZUpbrxaI2yb-8L5dWz5NU13b55BY
Message-ID: <CAMuHMdWz1Z6Pp1hss2X8R2D_9-bLjUpYnpdGEsGtZMKbF9L7pw@mail.gmail.com>
Subject: Re: [PATCH] i2c: riic: fix refcount leak in riic_i2c_resume_noirq()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: chris.brandt@renesas.com, andi.shyti@kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 at 09:13, Wentao Liang <vulab@iscas.ac.cn> wrote:
> When riic_i2c_resume_noirq() is called, it deasserts the reset
> using reset_control_deassert(), which for shared resets increments
> a reference count. If pm_runtime_force_resume() then fails, the
> function returns without calling reset_control_assert() to
> decrement the count. This leaves the reset deasserted and the
> reference count unbalanced, which can prevent other users of the
> shared reset from properly asserting it later.
>
> Fix the leak by calling reset_control_assert() on the error
> handling path for a failed pm_runtime_force_resume().
>
> Cc: stable@vger.kernel.org
> Fixes: e383f0961422 ("i2c: riic: Move suspend handling to NOIRQ phase")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
