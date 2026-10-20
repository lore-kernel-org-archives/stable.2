Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792484508;
	b=UeZfA9qg5bRA1Hv2mpSGkhy/CUxUa1o3GerznGR6e0CUbXQ6LyFnA+k/8oBaQGd7qItk
	 Uf4AxRTYkUCHWoLWSGLSwfV8Ct0nWXC79+5ECu2tvMBKMnXrTJ5ahsSzglapMgdkKXf8M
	 KkscJ4JrZzDkCWf1YqRztQQzXR6sQ1tr/qzG8yfC3VSyap2TMX6A/xU6rquwRT4vKtN9o
	 Son30nWt6/uCiydokOEy3iaanMwYnQREY4GL1lXbDcNBgOu7ERjbHM/nOtdV8hQqIPeDR
	 X80hJAYMLLekrbcNNCHMsMgPSH9WXrb5tzkUHsXRhBgJk6X8NFV6YBS+B5tM8DB8LkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7TrZi46+bzFzU9yGi+5LBKjzX2gZ2wzymm4R8mV+ebE=;
	b=expfuMgY2vuW0sjSIbxyIgDzjoFaAjRPf6cID3XBzl4YMwnpp2q8SuiVB/Uuk4YRQDy8
	 93qlhJ+tHGvOpxhG+xzf+K3Q5kYvvCmoGKxvrBDkhnalL4YoQOTlJwsl9pv7p90rNgyay
	 nmUE2OnpbZVprJunsvce05URt8snv3yvYFmtAwNEhYd6jIE0BSzTiq25M1sncw8uB+cf+
	 59Az7ctME7Vva00T93Vx8HrnAlCL/8PL6IuLvHISPMKW5Yx2FGttmz2aNvTxu5pcOtk/y
	 BYJY1IcWi4uMtBVAn/XKwR2EsQOlsqPOr58wCYm+L5eTn8cNtZPHAUTKbMJII3rSNqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O0fzRnoe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF778606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF778606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=O0fzRnoe
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so2485004a91.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792484506; cv=none;
        d=google.com; s=arc-20260327;
        b=OyB8I5TNMQ0G9rYxp3a2La/M6X26aIZv2EjrdXmsdSv4fm7QhR7VuCYHUSIG4srgJ7
         PjyVAQRHCV9p8vh+veukSbCP3ZZt8o0B2F55xIhtXCh1aZvIMVGTvjuDvvS4dpERRGwD
         6ygUHf03dYeALu18oIXFdg33nXsBtSjl4ijUmAsd9WNwEDNU9Ekm9REkeLRGxXGA1W/x
         4uRHl/VWl00WLDDinPpYSe091j811qdPWdIVZqSyTTefDbUOPcuvqe5Jpzzo5nG1yw7o
         RZhsk6qvjp5zWZhY+z1UtqIqpV48Le5Y2yeAGcMFgyhtskCZiDyvgEEnqZBwmwufRbXk
         rTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7TrZi46+bzFzU9yGi+5LBKjzX2gZ2wzymm4R8mV+ebE=;
        fh=VGduj0LdK26pCZo3EzlTy5dBQAfNAwpHiS+Y8M2WfBY=;
        b=LXYlSjAbbK0UE1y7GxKNwW9oJBK6oJtOrwSR6gLZbdvN7KghTbyGIMj07fd+e6gSHg
         VFo2Lukqk6/QVcmiJkdOEH/t6G59fVOvQzGVf4tRAxgL/udsoJcZma6OPnZYAZLy1NjG
         nrv9c+q5iwR5GLPA7G++fvTSDH7f9UJ39Yp6SMY3B02dFZx5wegJQPqw0QAiCJRybJlG
         AIBJn19yTHSl3+4T0c0N8E34KEXWJLfC3Dt30JXnUFsf0p2qGZ4O9pewWF0u7tzCK68V
         p6crdnozAVwLIHB/DNAhBCo66OuKVJWLuYA82uOTH9O/yEmf0Z4p6wfoWex6QUrQLeP1
         RsLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792484506; x=1793089306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7TrZi46+bzFzU9yGi+5LBKjzX2gZ2wzymm4R8mV+ebE=;
        b=O0fzRnoeVxfQbQIYUo7PeUK+SRH4bVQ+dJAQOjiPcpswyJ8YUvQCFvZrS2BImII5DJ
         SSiQXUnw3wnHjbHaSgjLXKBiw7o5RovbadDG9K6GYYtV6uZiPlzNO3ivfRxG11jj/kCc
         zmtBHMZHJ37bR/RrrqWe9KMsqXvXg29muDYIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484506; x=1793089306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TrZi46+bzFzU9yGi+5LBKjzX2gZ2wzymm4R8mV+ebE=;
        b=zVEFUtv19MRLC99t8+Rxom/DMM0w6j1V7OV+4R+IEsep2deYlomSdEY2bSDgpgqWdh
         k1jaHq+8f8WClP5HBLOYxCdXQ+B7Ipl5uJiSa/B3hLq2VhzxdE/01ZH7v/yDbMtoH0DY
         CjJeKulrPFiNsk1jklD0R9SKsV7p6IgF6VZ14u5+kti3NHpM/4QC1gEEj55/mg4UMoi1
         snZqQBB1juwJlc+71kmKcXg5JyaDUTlqT78NVag9qvauAKteABK/SjxqiPD++k2NzdXo
         JNT76ZigQCpdZSLZxgjsix+9Hm7aOaBdjXXujAvKk0o1rRZaP2cxXdVe161S9p2vZveb
         Nc0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzNuwGdG1ggfJHBpdZEdkGmFCZzSAeYiLKwRw5Ol2JOd/YE4bsBzEl1XNMmJHgNuAyNMTJXW9s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAoW2DkPPP088SYZ1kteuTfn9S9xVVV3r2WafDhTgcDqai/2jT
	LfBPE07l7NVnVzuqH1eQaiUX71BqpxjV1uX+rTPzBS9si5YCmg08KmF8UiV5bfPyBH7EJvuwtrY
	8kFTnWc5FpFiKMtKDSASHkJdGP4T6q8f1tSD3F03p
X-Gm-Gg: AYBFou0+AyrH5ZdbOQFD+xLAFyY3UsqMi9kEFFl4aKs1YjFlgeRQA3Cu05FEM6K4RlV
	9wu1KVVmCEMutmH0s4AFZdblQWly9prVMDxwPkwrqJzPRoQLs2/+9JDKaUtiXw3rdnrOAtS98uo
	W7A9solcqIzkH/XMhgQ5yRFrk4Ngwi0zy3XN4qsvXSakLGAAdhuJXAV3A7UaBr97A/gfUFlP4PA
	GD+9oDya8NOe+6uBIMdX28az/fd9CI2C1dKq/mo89KZ00MPff4FnpcgMvuT8l8xqnN83uKZH+Ov
	Bq7+7Fo1Kh/wXQp7BNljcjbMCjnoUkzmnM1lsFeXcN/5qwEpPzoS/LBl8S+/Fq3UfY27tPeyjXc
	9/C392U26Shm36A==
X-Received: by 2002:a17:90b:3d48:b0:3ac:9df3:6b07 with SMTP id
 98e67ed59e1d1-3acef0c8753mr8694175a91.24.1792484506389; Tue, 20 Oct 2026
 01:21:46 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018023438.3902617-1-mhun512@gmail.com>
In-Reply-To: <20261018023438.3902617-1-mhun512@gmail.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Tue, 20 Oct 2026 10:21:35 +0200
X-Gm-Features: AclHuK9Cw9XpcnOw9Jqd7JDgzHfajpSJvRQRnH2xODkxZsXKOnuVOr2__XvG8-k
Message-ID: <CAMMMRMcBT1TgmOYyYO8dJsLsdzqBiyUU4=S7XzE2zhYh_hpP_A@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec_typec: Stop altmode work
 during partner removal
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Jameson Thies <jthies@google.com>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 4:34=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> DisplayPort and Thunderbolt port altmodes queue work to deliver VDM
> responses to partner drivers. Partner altmode unregistration does not
> drain this work, so it can run while the partner driver is being removed
> and access released driver data.
>
> Look up the corresponding port altmode with typec_altmode_get_partner()
> and disable its work before unregistering the partner altmode. Keep the
> work disabled while the partner driver is removed, then clear pending
> response and DP status state before re-enabling it for a new connection.
> Use the same cleanup when list-node allocation fails after registering
> an altmode.
>
> This issue was identified as part of our ongoing research while
> reviewing kernel code.
>
> Fixes: dbb3fc0ffa95 ("platform/chrome: cros_ec_typec: Displayport support=
")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Tested-by: Andrei Kuchynski <akuchynski@chromium.org>
---
> +void cros_typec_enable_altmode(const struct typec_altmode *alt, bool ena=
ble)
> +{
> +       struct cros_typec_altmode_data *adata =3D dev_get_drvdata(&alt->d=
ev);
> +       struct cros_typec_dp_data *dp_data;
> +
> +       /* An altmode without its optional implementation has no work. */
> +       if (!adata)
> +               return;
> +
> +       if (!enable) {
> +               disable_work_sync(&adata->work);
> +               return;
> +       }
> +
> +       mutex_lock(&adata->lock);

That won't be necessary, as there is no activity at the moment.

Thanks,
Andrei
