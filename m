Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793212786;
	b=KKaXyejUx7em7QS5yiu9goNamptQ7ynATKvfeH142GiIK0FOTmIp+1p33LIzXhhlrDmi
	 Vc6GnfvstvTSCTHqzKZsssnYujnQOBC2Ves4biIA2ZUGb2t0+8Vb8Wo5UtXipV4zondrO
	 GpEABS8Iq/0svecRLhKvu6gbkdx/yIk9DPCx3XnqbIsK/78gmXiq7SfTkPr9pD1xYyTYF
	 UmIeBnfwnAms038w9iRk+INidkDb+EmD2H6TnbNqbG1Z2MX/5NzeGXDS0D35rC2yRjAlQ
	 vMa5vpuA67MVGxakY0MNUwc6XMcwKSP2XsUeu2jgaJOH5/emUwXalbkZUaNVvgMaV0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lzWBDFykZYmQVbPs60wnZX1zpllZ/48DYMT9Prys7GQ=;
	b=p9vLoqGrmU6YB9jLNGwlYW9qc7moWjjt8285iM5IUL0xjum58C9YTmZkr1A4OHf1qj9P
	 TfIoXWy/0knqSHYTh+HCJPScDxHNpEWo3Dztd+NB4i3bkWLIOzseaTdG6dGL9zrbibhuH
	 YjD/w2s0Mow3GdHlVTs64KoxdATpfHxA0DVzvqvKdFpkH+Ffonw1OerkA593bCnzuYu5A
	 mqI9FdcNa/5MBcAQ3wccNw7/I76qbmy9740ucgIAV3DpQom8via6sEZmbTMmwSqTnC/yZ
	 xwTYRWzd1lsmK0QtfdvcDPbaMB7SREO1DPas7YjgBoHUgsTl19tnBDJCdOpNXxRLEJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	dkim=pass header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=sAcaLbhJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD9606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ACD9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=sAcaLbhJ
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a75a5fa32dso387709fac.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793212784; cv=none;
        d=google.com; s=arc-20260327;
        b=BHMyfCv2/wHrawznUH1tBElKx8bs3ysnWdKc63W4rlW0LXp/ppDCKZcPPh7KW/vyXm
         ve2Kz7QiFxlardEaOQ7T+rFAnVIpzVJPmVdBW4Z3cSXIoPaIxb8azHY6b9hkjZEqD13Z
         Zu4lcb7Xoa5CsBCSFlfXwyFfkY5BhpbF8O6OBA1G5houBIk1ry1mN9ryTc1m5ry5XUOB
         1m7Xx488dAsJhbVMydEvlPOLOhwOi7OzsN+T3na95OkQdBfNf6bvLh+a/aX2vTSEVed+
         jpohX4M4GOH40OtAhcUNgX7PV6cR72lZqZPStGRjhN7kh1rVCAmyEkolz2c1Pw25pWzw
         t7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lzWBDFykZYmQVbPs60wnZX1zpllZ/48DYMT9Prys7GQ=;
        fh=GySEJWVaklKIsdET3syM6jkvUXTWADcQe4cIOvwNhao=;
        b=nOAz6GtGPTOvALXJxeTra+S404KJPMFxn5S0WT2HwrzFcKOAX9TX03BxNlBjaceLTj
         EBUxFHeGRWSVvOqAzvi0mwsaguyzqvSkp4IiOn7672eDtXu6/sHNXkIAoQ5E/+pwZ3Sh
         zRSBNOjw2Iw/KsjzeTXSn1nIr5GUPEobsUR8R+dTeMeJCHdW3c3KtH6V3Mq7Mb9J3/c8
         a1MIizeAisVnnakHZz6dnewE90xQviu0d1Rz7mJ7GTNvcrYYoleY/3T800AZNl4L1oE1
         guENNLt3kZ1HxCH8vT83JPZlYUwvRiohOM96ic/WVrLQLISCE/IPZDH5KQQiVJwDlCqq
         RbUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793212784; x=1793817584; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzWBDFykZYmQVbPs60wnZX1zpllZ/48DYMT9Prys7GQ=;
        b=sAcaLbhJ4PruFteD+5ifr+3dehHdYOyHdN7/Vug7o1ZVK7UP2t8RBFc/6vSdb6NVfW
         ThBR0SoY8CmwCphHBJ4Gdfp50QsB+g+GP1v8j/NbV+3kxjFc/6yZQLfGdSvgfRA22mJw
         klP3MK7XkXoieaY3VVvZuj6Aex00KfJw78O4rMEcY+0TXJE4wSJG6PinXcn8/8YwY7/Y
         mOWYqgQ+4Skcd0dkw6+z+9xC4Cua95f/TjhuTrP4U+5SO3+Zb7XbyqoDj+viEo8LxcuC
         FIUDPwrr3uj6U4tbAk//zbh/VHK2umu7B1EbEoZAf7wqMMRkBiLyvh6+cyhsSWPfjjs5
         8+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212784; x=1793817584;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lzWBDFykZYmQVbPs60wnZX1zpllZ/48DYMT9Prys7GQ=;
        b=Rrr3xAAqpxoYB0MUWeTzUFKuIztW32Acp4Yf1zVoPLeROpWqaezeFyMQVOBf9L68Fm
         nCdw7NZgm6Cg8DPiSZ3hlIaahRR0tpLrfA5OXloo0zlY4YnbYAVEMYXVy45Ibxh/f8Y7
         4f+41OAlnIakGAcxQF0HCvjvtoyuYRc/ZI+TlF7f8TYdioAvwJQVyYz0xcKkP7erT8VZ
         JeF/7PACx7K5856ovtPRVWmMRoQD2l0KH6EtOgQaGMq9jrNPLpou8m8CqYOOvjgrMLOI
         SaGEg77c3ooaD6NqZ8yFBcqFp5eA7dU/MPzlAH/O1iFKp/xCZngZhfTBHTsbQnNAQ5n3
         l4Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwEqXXPZX86M9Qui2vsm5t3Fi9YzUO+eaxungAAADzAj4FvtuUj4q6j8OoV4bnuTGZIj6v9Y48=@vger.kernel.org
X-Gm-Message-State: AFq9FYIE8v5m0fPyEF2jVBAz0FxkQs/FFwpNpv+X4t5i5YtHfdugZg0M
	ECFLYmbi12E0nBrL2D+lGAeE13/715sTAPNGSLnHxsx4ZKOYHjD+v0to28Ie+K/mI/wFvy4xDvy
	LPlJdXgAJaaBb7HsgaF80qLgallFfOXPvBpST8pB/gQ==
X-Gm-Gg: AYBFou1mKZSLsIlqp6AhTg13PCkgidzWAedcZIQ8CJ9CaQgTgu32A1CfPaEF7keOFx8
	D2PXphfPfyvp94Rrf7y863HxxrSPXXORQxopf2ZblIgM4vMP5FB6HpLZYzRAtZSo9tzOjgx/Bn2
	DGegEEJAIPb7OiwMaPxiugVPBh2jZcg8jA3PmUMvGm6P8M4CJCMGQuHVcoP2LZOWnJzI9ZnwSUN
	Qdj73ZQnVYT1wrGaX2rbNcGD0HhhordfGfQbWvV4zlg0oxOjh7SJMTuM5vPqdJ7YiXV0xbI4awa
	hCRlo1Rdpjkgf9Onkjov/HBmJvXBBGddbdwg+/HArUnYkc9J8YW6GGY6VYcji/09QbK41gShmXD
	omAQfsZUsfNpL9jWgkhoRkVItEONQtrL9YW3fZOj3oG4iuzmqsxEZM2kIawxnnp7S6JdzELd+5l
	WFhlou4y8BE+x2BlW2vRYJxKsQP+wd+sqhvfFAulQlcRWP0CeD7gxRkS6d/DessWpReKKltK8r3
	g==
X-Received: by 2002:a05:6870:702b:b0:491:88f1:f3aa with SMTP id
 586e51a60fabf-4a8bb48c1b5mr2356106fac.26.1793212783847; Wed, 28 Oct 2026
 11:39:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026164028.78792-1-lucas.tanure@neat.no> <20261026164028.78792-2-lucas.tanure@neat.no>
In-Reply-To: <20261026164028.78792-2-lucas.tanure@neat.no>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 28 Oct 2026 18:39:27 +0000
X-Gm-Features: AclHuK8Od9Fw9YArha1MRLfNbwD9hyqoyIn5oK-539amYVA4Yy6MtEUKuv8b45Q
Message-ID: <CAPY8ntBg==BaznZcnm+zj+GWcooDeo7fW3_WfyAAEes86BNhBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/vc4: hdmi: power down the BCM2712 PHY when the
 output is disabled
To: Lucas Tanure <lucas.tanure@neat.no>
Cc: Maxime Ripard <mripard@kernel.org>, Dom Cobley <popcornmix@gmail.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 16:40, Lucas Tanure <lucas.tanure@neat.no> wrote:
>
> From: Dom Cobley <popcornmix@gmail.com>
>
> vc6_hdmi_phy_disable() is empty, so on BCM2712 the PHY keeps its PLL
> and TMDS drivers running after the HDMI output is disabled, until the
> next vc6_hdmi_phy_init(). The TMDS clock is therefore not stopped
> between two mode sets, which the SCDC clock ratio change requires, and
> the idle PHY wastes power.
>
> Reset and power down the PHY on disable, as the BCM2711 variant does.
>
> Fixes: 0b1dbe82e051 ("drm/vc4: hdmi: Add support for BCM2712 HDMI controllers")
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> [lucas.tanure: Rewrote commit message to clarify the issue and fix]
> Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
> index 56e6a35da357..5040f014bf7e 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
> @@ -1197,4 +1197,9 @@ void vc6_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
>
>  void vc6_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
> +       vc6_hdmi_reset_phy(vc4_hdmi);
> +       spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
>  }
> --
> 2.56.0
>
