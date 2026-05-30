Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C443976AD
	for <stable@vger.kernel.org>; Sat, 30 May 2026 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780135376; cv=pass; b=XS/0rzyqm9KZq5L7L4YskzHwKok66CRAKps5nG91Bocghryr+3XTX4m6IaXBYTPuKyxu6Qa+9m9bUlV75vuvuaPfM/613GsvJmbvc+yjDPCy6OwUFaG/yyxKrCHUjWnjcFN6Y5rcKi7F0O/C/YnT0TvRoCfsF3adColylDGcxbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780135376; c=relaxed/simple;
	bh=aRV0xyZX79AA+2ptor+ckfoSILpcXRbuSrq8Ab8c8tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWWv4XxUgeoSPelnsRu0Xvg6+EtgCHhT9HJVoUjqrpZ8gllXP/iBtFUpWB8oJ2e7mLkSdwuK2Yii20h6571ayCCc3j7IXUyBA3T4DRJSVDeHuhR1cd1XXtoNsIg5m+Zsk16KgJTijRGIZxN9Wwal8EO1efry7H1MYFVb/hsnfj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy9/C2v0; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy9/C2v0"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69d60694c9bso5330287eaf.2
        for <stable@vger.kernel.org>; Sat, 30 May 2026 03:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780135373; cv=none;
        d=google.com; s=arc-20240605;
        b=aLpz9MNEWAPbgunHxuOpWCC5hLE1noIlGcm1N7stliPhJOZzRmLGQyxZrmS65HJ6oU
         xXIFl3FhVXoJSG2fZCWs44aPa2ePlY4ffAssDMEjBcV9PMSab196OCwk9wcA5wk8zx8X
         pI3LkGpKUTIHwsCmiinCBAYSOkV5eo1y8g7mRXgzHY9P06C5wvTLSlnI+9V1LWFmHUs9
         vuaQImhZlgeO74xhID4cpju+UGcDmu10sMkiL3T8L67NegYq2P+lW8dzxDkV8SwWc2oH
         Lz8t4eCNA3jdHGLMpmrcD3ODiRJiMQakKdD40BF+NUfxbPQan7AR5f3sj4hwJ8UJLG1g
         Yg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wA1aH6CmxX7A5iRyqGW8vvL57CBSLJoeivyspRD1x3E=;
        fh=j1ey+4aCSeSha+D1dl8Ja+HDrbYsYkpeFCqFwYUgSjE=;
        b=hmJsQbiOEz4DLQMLPIyzybMV5FbC0qxUAEexrcDLNwfjNZmrTTl0FosyIjUN+6yXeE
         nvHLRXSshcKUsxa3DSweodCqtJXmish1Hv0DHmAZm78oaKpNHx0LVSxGLXjAkP1jDJCs
         WBRkIhsIwO9HZ0PnN3CdJxG1oLw0Dma2oNPknd9PEMHSPwdNc2I2saksnsmJyg6AJp20
         DCP4fT4TRgQMAJwEd53DcCoH3lg6L36H+/ORrfb+GVM7XpeGI9nOwvSc1CAnYTa4DQR4
         s2QY0Dp73VmGAi0uMsCjOCDDfvzurRTnWMHcPSa/kDt2Bzzpqq/J+tgLBA/4EKpK5abi
         GCoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780135373; x=1780740173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wA1aH6CmxX7A5iRyqGW8vvL57CBSLJoeivyspRD1x3E=;
        b=Iy9/C2v0BdretmYRmz0PX2XkiUjK+vgBEUlFQY491bBYz1g3NxciHOQ4rDg1Q6UaBw
         sm0Lmi32B/+5LWXkLk4IKYmlW7kqNqj0NiLDn/4w65XgOXfDGvg/NxR8vgwkl7ht+608
         hFQBPBz1BBoB89l0JTKBpPlMi+cJry/s7TmF5j4hoeo6xlBocGR+1ftaPOy6XFr/OWCU
         iS/kcXvtdVw7f0dMVmraiInjxAM5LYB11hWmQ8cHbHhlWKIAWxmfC4cMzio/1FgwuqXZ
         keLN5Mrr8Iu45suvk+ItCguyPikem61TrW9RbVZTvQE+Z+w5mnP0+87A7g3uxRqxvLcz
         kYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780135373; x=1780740173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA1aH6CmxX7A5iRyqGW8vvL57CBSLJoeivyspRD1x3E=;
        b=iwo38Lzs19Kt9Ju5w2Zvb+eK49kHGoYFyLJ/EzplCI5MRwEACsT4hvqXTa2Zb5WgIZ
         HbR86BXS2qTBLVWAotWyEHNKBPcJXd/LGULjwrJ9kEQLGF2+Ru4vRrd5Poux5b9zrjx1
         7qByfux+mwNDJriOjSbck2orAIMxcO7eSlkXo+97dZ6KrQRmq4WlMdk/P4sSGjCzN6D7
         +tSltPE2zMsNOaAqMHHxZLGMqLI4nvjT0Z2Z1lysk4ixPaXl6+OVoOspVoNqUhXFlCvL
         K7yQGAjfe3NVWpXcb6oTbL4j0+qkmg5XY4nlbwaBqBXJyR8+SqBWzT6ovpl6tudKhNCd
         JaeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uBPGnZVSG6Pln/UbyeoVOI14lULH/wcLW9yDodFgvZYTl8AXuO8BXurLVbJElQX4owLtKqyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwczjxZ5yfw6PVnKeaHTfsaUb18IO+i8mNKU32y/iyC2OSBoGZj
	eviP2KDFsWEl6iXU0rpgQkLkPeDbuEoPfJ5alDkA8PNR+XA3QfyikROKxs/PxO4BZkIEgYJqMLr
	5vbdXvAUFjFZ4r86aNeRMzSE6Viots3U=
X-Gm-Gg: Acq92OE9hE7fBBhZb3OvKuJqbcDNnSFgLtP38ODn9/9H2g9hFn4QoXK7mjg0YxneTmM
	Dm3SPe5mzwPppmf9Z2znwrhZsqwP0Cp8pzTt49VmESlwjReJWNgZQpTKok1//wwoJosy16sI6hQ
	DXEnltzf1kvOMMN9LCJIT2wxulWpC83OFVh1ZWlbd3pCexX3SzFw5AfvDgo1JnGWqzNT3zUoiPH
	heEC38Mv5dWZQLGJT7FTx6uvAI6PSKIeDLiISpss/R1Bpgu0Tw5u4Hv8BL0wUCOgXMIMUkEjX4n
	LJoDnSjVwoUawhhNY1e4H22ldjOHby+RErl3XnJu14QL2ctMsAwc80yvFAk=
X-Received: by 2002:a05:6820:1c91:b0:69d:d5f5:1727 with SMTP id
 006d021491bc7-69e102b1853mr1483383eaf.5.1780135373192; Sat, 30 May 2026
 03:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529024429.6942-1-devnexen@gmail.com> <20260529050649.14109-1-devnexen@gmail.com>
 <ahqh3Zv8xXNENzHb@zed>
In-Reply-To: <ahqh3Zv8xXNENzHb@zed>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 30 May 2026 11:02:40 +0100
X-Gm-Features: AVHnY4IJRqkWaRtmQ6e3Icb9LwRiaPlqA4vFhZ-emg9TT2H0DQQNJB7tXh01f5E
Message-ID: <CA+XhMqyhpn0kHgz=i9WUS+1rFN4kWW3DpUYubBN1k-qcKo+RpQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: mali-c55: fix integer overflow in scaler factor calculation
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Nayden Kanchev <nayden.kanchev@arm.com>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo,

  On Sat, May 30, 2026 at 10:55:59AM +0200, Jacopo Mondi wrote:
  > Have you hit this issue ?

  Not on hardware, I found it by code analysis. The sink format is clamped to
  8192 and crop is clamped against the sink, so crop->width can reach
  4096+, where (crop << 20) overflows 32 bits before landing in the u64.
  I don't have a >=4096 source to reproduce on, but it's provable from the
  operand widths and the clamp. UHD (3840) is just under; 4096 gives a
  zero increment, wider values a garbage one.

  > Could we maybe first do the crop/scale division and then do the Q4.20
  > conversion ? We could maybe save the below do_div() [...]

  I don't think we can - dividing first loses the fraction the Q4.20
  factor is there to keep. E.g. crop=4096, scale=1920:

    correct:      4096 * 2^20 / 1920 = 2236962  (~2.133)
    divide-first: (4096 / 1920) << 20 = 2097152  (2.0)   -> ~6.7% off

  So the multiply has to come first, and that pushes the numerator up to
  8192 * 2^20 = 2^33, which needs a 64-bit divide either way. BIT_ULL()
  just does the existing multiply in 64-bit. Happy to switch do_div() to
  div_u64() if you prefer, but that's orthogonal.

Cheers !
