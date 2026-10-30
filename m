Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793378250;
	b=4Tju7kwqFTTpgGjVRpP2adG0N28e9YuPNU71hB01vCSrr1ahTebPNksGCag1sC7Mala/
	 Q/YI0EPq7AAbkA8hUVY2ua7gJgiRIvl/3E+sBSCZ7n6RHyJHEZBPreLCmLGtzy8exHmZT
	 TWCraKoTyS5cWue2ZOv+oyi6Kbg/YXLwPvIgJ4tJeKv7vxUGj6CHriE9+ZGGMd7dy6kF1
	 HFfxrx16i3cfsafrl31uOyaRBydQhTyeGZw82UE1+RdbXFDVMtJiLjKAcMassGNzfiDPD
	 QjZDTdW+7MJWkdwTxfinb4AGmx/MKxgKFOuTaX749YEEJSdfKoMCNVdeYIucCDpG1dQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zAYL3j86a7Q88ddu69k+6OJol7/H9flq8cPsx2AHE54=;
	b=qdohpJbQGxJeCFkk2U3FeW9oHfegQ7cHYehGPMrngzFcc2NJJL4HAcLsMCgmgfPj7qHx
	 Puw+iwnsV8wc7kIzjgGjVOfqFmi878202K3Sll0KNFpJMGqRaGbKXVaXauxaQXTk8h6V4
	 4Va7K0zhJwX/PxZhdX74WvEOoAWhimxBrLa0QOlMJXpF6rsdlpPeUSD+jOHoOr5iOrJKE
	 mrcxfx0VHlaHpxsxPH0C77h3fVce1Qy9snLyqKY1BuR2uG7z8g6ONwCoNgxnnqneXpzYN
	 RTMB1JmXkAewXw1rKIqSefwVd9QyHTBhDjKX7f7kESqxPizY1XKxV1GHAl62v8vMnmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JKB03Jte;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC7606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66BC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JKB03Jte
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac01ff101so386954e0c.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793378249; cv=none;
        d=google.com; s=arc-20260327;
        b=e15VHLkXXhfumqti42HhIbXsrrCevplOm4m6eJVB/fIZUXU6n7vEcB447yei3dUDg2
         5xOVbQVsyQ5T0HrzU2GY9WCsflLlTs+eD1v7iisPJFMBak8hxEGrzAopLNB149VibOGD
         FriG6R23WBDSSuNN1oo0U24kSZLBFs/slrIzCHIF6WIt8XMG/6N5WrLWqEJ0hCgN9CYb
         VOw300QPqjGeyOWwjH/YYkdcAsOC4HJGjJ2i/L6lPm3bmweB5lnSwWNqFQqYueRinrsT
         1o/GZUAlJBlcDrPVbIGZIXeU6vMEtpqM/WBvuRLEGH1WsZzsRtDTn3HBGMy5FljvcR3Q
         ur6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zAYL3j86a7Q88ddu69k+6OJol7/H9flq8cPsx2AHE54=;
        fh=FbV9VhoHMOIo9x/aM7S0NA2PCDtriDSit9d3Vcm+jm0=;
        b=iMGQwAwsBDoIeLxHTTwiH3D5O81g6KX4ossum1bni4Ucoa/WQbEDKKaJMp3mB3DRHu
         5C0HfNKcm9Qu/iq3W+EF45G1vO8lSElu5BXq40YsVFfcF6qegU2BFl/oHw7psdLpja7n
         bb532dyCk27yWy71Pa8N1hFcpfaHMvxaApb2XdvG32ej3kfmun5t5u7T8sLIq/qpF/KA
         kG/WkrO3VsmjKf7ZMcBMJZq+fq5Fn19SdwR72pc7woy6kQFJAfh0OD2fQlQ4dNVxCrk1
         c4Stnrvl1TTMZta72fbAYi2ApzgJ0NrgliUH2Q1PSwlvNSGmtFxKJrTdKhBbPgEpo2WP
         P6mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378249; x=1793983049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zAYL3j86a7Q88ddu69k+6OJol7/H9flq8cPsx2AHE54=;
        b=JKB03Jte4+7R2ngephq58nAE/tcbmHPMF2QEwMNcXU2F7eetDr/WOmYYlrl44yTqtN
         RIh8vMqfHczAbS7oGRzxCVewG5/XeZzhAJyX39H6+H0XsFYxArtwVV6LWtWjhdQIbx/V
         KI9ZYuayZ4HpVmreMInLlqienLA+uWClI4EWmg606uOzKOtFAf3NtWYG2ZjrwUCojYMm
         je+haQM3/zKDV6LHPvT3lA2D7L/EzQl5NYYnuokdS8L0VywnuRIO0kr2ekPxYeF+wBhm
         vPFJGJlNc2AQkjhbFmM50CKxUl3Bp/vnrm0svDBLygp6UjBwL9P8qCzytttXGRW7vh8n
         ZOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378249; x=1793983049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zAYL3j86a7Q88ddu69k+6OJol7/H9flq8cPsx2AHE54=;
        b=ZZgQDl82PX/hucNYk7Tf5z3qbsDE+fEkPzjyNpDD2LHOgxYKBr6X/AOj9lUB3Uxu8z
         MLE2qNtlVCnUZg/b2RP4jF2MqAZu4YcFqaBIO07IitV4u0jPKQTqOUMtKhATuy1A/nGu
         f3/NiCYstxcoTvBWvXKpyNbvM5kMg7fLJMkjcG/jFz7PXeFqfAAwhZcbKuPsbBq3DSMf
         RwayS6JhS8fefumG9rehHMlSuP3N3N8ZAB2odX8ZtgxBz6QJhecHcwK7B5iHY4uZme9K
         n3XOKT4CbO19lCiTQIiySjp3HwKgYIA4srh6spufmqxR1sgOAxNFb/ay8iIknaymQNpL
         hA4w==
X-Forwarded-Encrypted: i=1; AKwUvByWeS5QKJoTpHhe/qp2x2NPESQPMlAjBv6itB6oWYr16lQT8bmHUl+tuOH6uZFwap0vUmOZecY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJe5lzcgugo6Cw8DwY7GQqCY5zj40P5H1PWKcYkNkjdQXjQnurZ
	Q962E8TB41vEPCQ2Lo8NMjCRYsjh/2uq3X1RqpPOV85BQXh9C3Yw2PjaK4Wy4Gr0eOq5JlPbWrK
	ha6s2IKvHtXycZVUKwQXOkQnPTnNuCCE=
X-Gm-Gg: AYBFou1MCTjKvMFa8NHJXiAsnVi2tqmvQZXF1GaJuluynNkTasKlsEw+Z5cCCyh7FNO
	530Qj7pJKK38fPu/VA0nduz+ZtWwxLJMI0VxbMgjRsnvZ0MaJtsRw9Um/gA37uo3/HT3s3c63ph
	A3x7olMr5OT07O8vfxU6Yx/GXfz3HXx7Csm4JYT3n1sJU161zj8L255zrE8K1bSH1blfuxO7pV2
	vEibqxmgVDAf6dX2JXAEgDWQhndP0oMRb25b/zki5vXMEslcC2YBHClSa8q2Oy0RrVz+tWDDLeR
	g9gbkEEbw8O57xqX4rN+hwpziFs6Vq3TKY3BSmLveGbKfbUUu0xxoHnlDeovA5mYYz7q+1agSbX
	MCBJCKx5k8kygf2TeOEeFldwjmTG4c2+r4JGtW4Y9EsTnjlKP6JnKC4qo/VQbMYBud9i4dm0lcB
	F+XldCWDh9
X-Received: by 2002:a05:6122:3d0b:b0:5ea:d1c4:7cbe with SMTP id
 71dfb90a1353d-5ec6899a08emr1698294e0c.23.1793378249305; Fri, 30 Oct 2026
 09:37:29 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030161046.1497894-1-gourry@gourry.net>
In-Reply-To: <20261030161046.1497894-1-gourry@gourry.net>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Fri, 30 Oct 2026 12:37:18 -0400
X-Gm-Features: AclHuK94a7ygO8e952sy9QWMqMjYz7wrdIjjao0GQyAzyDD8wGX-wdE4eecWNOg
Message-ID: <CAN+CAwNsU5cOLvvHttz=9FOdqHEy62cmvVmJzhL4_1EhHwfyVw@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: use one node set for interleave weights
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, rakie.kim@sk.com, 
	ying.huang@linux.alibaba.com, harry@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 12:12=E2=80=AFPM Gregory Price (Meta) <gourry@gourr=
y.net> wrote:
>
> From: Andrew Morton <akpm@linux-foundation.org>
>
> From: Andrew Morton <akpm@linux-foundation.org>
>
> Switching weighted interleave back to automatic mode while memory is
> being onlined can cause a kernel divide error on x86, and a panic if
> panic_on_oops is set.
>
> reduce_interleave_weights() scans N_MEMORY three times, but hotplug
> can cause N_MEMORY to change at runtime - and torn reads on that
> nodemask can cause a total sum of zero bandwidth.  A node that
> was hot-unplugged and then hotplugged back can then cause this
> loop to generate a div/0.
>
> Record the nodes visited while summing their bandwidth, then use
> that same set when scaling and reducing the weights.  This gives
> us a consistent state even if N_MEMORY changes.

Makes a lot of sense to me. Thanks for the fix!
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Fixes: e341f9c3c841 ("mm/mempolicy: Weighted Interleave Auto-tuning")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
