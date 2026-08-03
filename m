Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BC42FCBF
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781931; cv=pass; b=dE/b5F9nv19JcLkGD4fMY79/CksRzSStJsKFWu1byDJ7SzEwDf2ligktr7FudoTra+R2w10zzmrCBfus2Fur6dYmQhX7Gd4TY3IA5lY+HEVPno2Kzx2hTox/msM1ahI3f/7J7KILIVcJ9ESAQMzFqvI2R+nZI5xZmxpCzWCp07U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781931; c=relaxed/simple;
	bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAoYdclOsaJsDNKBmxLEypihg2siktGLOZTjOoAtCiC8yyeAoGCug3qlGFKMrpwKodMZKofjXbwplY55e3q48JDJk3A5AizMpGoCDX8INnpUvZ99PLnd4+7XATt0gLnmPnJ22IUYi07J367ot3oPwjWUdtUEkjIJRctfwEq7mXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QD6ij8es; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QD6ij8es"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacef7d299so19955ad.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 11:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785781929; cv=none;
        d=google.com; s=arc-20260327;
        b=ZJnLvfDh3vLDp/Jvq0e2Tc084JVCE4UgJKXH0RLlJF4XTYaX/hVIccP/DdFm7Vq7jR
         OzGpKTK23sw8w5bBmaqQbEOMfe0C16ZsG4G0l2Okkbs9u+kEEK5nWUFmwnPifQVfMktV
         Rwe7AFQBaRpOy9zkhtfqQPM5rMOT0U7CuMgl30v7mMkuih+QnjrQC925ekDeXdrvtZkm
         05wEyoktFP8hMjM5mXZnNDLMeSc6E7qirInVUimqyxs63yzMDWhvdxSFi7Zx+4NFfymO
         nVLc5tRDYMxzMlZIjIzc8k/LrpUj7D6hdWKhbxftl7hI8eVlgyS5vMNEpO+8N6duA/Tg
         C8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        fh=uqIgrn5JfVAEuZu34ln3XLA2r7sLFEbzJrSDdd+INog=;
        b=gFO5d9TXKwNzTqUh1UaVnaKBQbE8fZiEAaNqsBz9o3d19NuWluAe0+69lcMun7faLc
         qdWbK4F6RxFvGv/OyRL+IKPRfRMHth9FKfjH18kTv1aB8E398AnNCrqERDpUGHWC/iYe
         bW9haQ5tFrU5SduZ00fCp50LihY5AqLvrwJIMGbgirYdUDCpu+7bZuFMJgwPFKKdxN6N
         FAUYLeW+Sk9k4XQ0ZLuJO+OlKxKeHvDVqrXNfJSphzgtEPUOtj+Fo8OY/tGn2nIFjOyA
         MwRhTpuNNc3n5Lo34Hn5gOYUcn88LHMaMuZOmWPkmvncsUeHC0GMlRtzg9Un2Ozf9kD+
         WLEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781929; x=1786386729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        b=QD6ij8esOYUdm2Uo++y+AEpUjnjjH0LBBYwmfY+bS9fhjaa2Jz6yMUdQJ6rdyiwJJR
         Zpz6Ccu0E2qvoLIpHHRrJbUpvsUgTTyibW1YsdH8XtzWuNkma/PviKEf0T0Yat+QTnB7
         8gq0Rwl42AoT1/z212tY8xY5VqAEHBNvDvaTAke2qiNRpZLr5iHz9XkOS6DSdyt5ae74
         LI158rARYwKARIaxOCcK4NC3AfJoq6grQFB43hawuf8s+05uQn0jI67WEe6++/G5FC/v
         g6S6JrG2Zxe5lWJMOro7sp7lK1yaAvlNbcJ3iRN7EJDv9iE99pweW6M+vXQU2Oo1Ydgo
         Dr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781929; x=1786386729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWbjPp6NkbMPfq2XEGlQC1OmjdeNiTHMdP+BoLTJlbU=;
        b=VngkCrXyFlII93i8GezFNJ08AStJAYUD1RcEQLfHcGBTBhjYVZMM9WZ53eGJyUY8/e
         T9ZPuZhJo7KHfFjIsZ1ilBxI9CUY1crPsBlU9wBBhHcJufJQN5oKhuf2ZaXo3YflBQFj
         toCMnXN+ZlLw5AfHtKvG5Nvf8mK3OzUWt8AJocUBjjPxTX1LEU4QQ+EuJZByzkFO57U5
         ipcPrnvPxmKlo36hvYvFraMRwhEs4RzfDiRjTZwl8AShYPmJM85fHNzteRBZXWmvFdSd
         J1TC0GfGnbM5PRxBT1ivUCeFODmpTTG67iCh0HdmkTon+SZZlEGevC7wd+8pJ9UoR9Xo
         5kbQ==
X-Forwarded-Encrypted: i=1; AHgh+RoLA3RtcnKN9LcBNkfv3n7vL+zvKqLK0cCJf/HSYbVUCfQVzTh/eTSOFmj/AZTjcJEE/UkrZu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK34TPhhrnXs6eN1xn3TcBHLBwE19Vhu98cDXF6QYb1k0tWL15
	tvWHqh+BBNIt/WsVPk4N+U1D/72Fo3mI9AntYlNvkbCTg3kGJn9m49dulzMpXbrOYBvZuAA/ihL
	QZf0fXEKXb+7QhNsTo6mv3KRtQCTjWUWpPdkyTlsq
X-Gm-Gg: AR+sD10D5ypLdfVkTM3hmtYLNrDWWyaKD/HgJ1HlikcWR/ajwKaNaG29eou0JlYhIzK
	ODGAXnm+oO3cGt27waaYS4pzLzotqYrSVTMOFu83t581PYorzyLlcqQNJ/epQrh1IVzLBZAPW5f
	+pp0p/eCaeNDi5OOFT1/47ndafXUSFVvxec6ieiJpZR+3OrR6OY8XuZsKPHZecCIyvhDY9PoIpt
	wYMVv0Kjit0Ri4R6QVUFNB47RLR8cXk4kQBx+/Z4ptWzj/uZXemCKXdTbQSj0d/ggq5XkLtlNsH
	9g4knG6MpMPwJ10PGEq883WBx/QV2oJf8CZqL+uQJlsk
X-Received: by 2002:a17:902:e945:b0:2d0:8b22:7eaa with SMTP id
 d9443c01a7336-2d08cb31baamr1688045ad.20.1785781928753; Mon, 03 Aug 2026
 11:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com> <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
In-Reply-To: <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Aug 2026 11:31:56 -0700
X-Gm-Features: AUfX_my3dNHecsoUf8e69cV4C1hLKJkdXZo40JvErJWzFKOvN7k3ok7JtkXPFd4
Message-ID: <CAHS8izPdDV88eP90R2sVa_dLUy=btQWTHJ804g5TrDh_2xKKLw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: atlantic: free stranded TX buffers on ring deinit
To: Yangyu Chen <cyy@cyyself.name>
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>, Igor Russkikh <irusskikh@marvell.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:46=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrote=
:
>
> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
> stops at hw_head, which no longer moves once aq_vec_stop() has stopped
> the hardware and NAPI. Completed descriptors beyond the budget and
> everything still posted in [hw_head, sw_tail) keep their skb or
> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
> the buffer ring and the references are lost for good.
>
> Today this is a silent memory leak on every interface down under
> TX/XDP_TX load. With the conversion of the RX path to page_pool posted
> for net-next it becomes much more visible: XDP_TX frames carry fragment
> references on the RX ring's page_pool, so a single stranded frame keeps
> the pool's inflight count above zero forever. page_pool_destroy() then
> never completes, the pool is leaked together with its pages, and
> "page_pool_release_retry() stalled pool shutdown" is warned every 60
> seconds from that point on, on every ifdown, XDP detach or ring resize
> under XDP_TX load.
>
> Bring back aq_ring_tx_deinit() as it was before the removal and use it
> for teardown again, with one extension: TX rings can hold xdp_frames
> nowadays, so release those too. They are returned with
> xdp_return_frame() since this runs in process context.
>
> Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
> Cc: stable@vger.kernel.org # v4.11+
> Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

FWIW,

Acked-by: Mina Almasry <almasrymina@google.com>

I've noticed these claude-generated commit messages are unusually
large compared to the human written ones. In the future try reviewing
the commit msg manually and making sure the amount of detail makes
sense.

You can put extra details under the `---`

--=20
Thanks,
Mina
