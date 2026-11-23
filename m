Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422672;
	b=cCY/juFabNCAGoX+RHx56XB0acc8CCxu3k0p9DZWkk+gub5brpX2734B7bE8g913+ByX
	 VMi4MLaE/MGnHbf8AFuae9WTIBVWzWEq9tn9r0w2DJ4qztKQS//PXxVnmfV8QcgJVE3PY
	 kuzUDr67UQZUs0dOpTy+DjSKAqW5SE8bGOddbqcbUI8b6d7w1NT2x6VUg5xvLAj5M3pxp
	 OIhpaMQk3zyMppjHXPnSUJmtkvnUzo8FbAUYT+qX3E5pxrmwqSbhykID7HCVii012CBfi
	 fimav3rXgmA60fK6NadKHyXQrO7T71cmbMZ75412CMLLaYDH0BcnzgQSgcdo/q18i0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422672;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7K9+aOsDuHxahvGj47BL/Y7ZLxT71kzKujqYeEjgepA=;
	b=BNzPeAP8J4NocHnfkFoVWF1YwR47cgzQuCiUZennfbfj3XVitID4pEZT3QVB1uw0BoPV
	 q1psPp761lyisSpnCz5fSkpTiGcVoPFWLZT4X0bPzMlvo/b83goNXStLTNL9b43G5xAoL
	 YxMxH7+WOBAjK9MMauppuxcs+WNko/Njy/Q5IyqW+Bqn6KxZN9PvQUESls5LgpDg7qFZf
	 DXDsSgqEwqSR5xGWDmmJaet50JQXXqxn6bnkfMFxQRmbDJLLo0KDV44hmLU9WIeSzQJwZ
	 1lF3fef9CZBJVEITnbfFPp6vg+ZztK1DnqW8OcEPTVpjFOGP4tpIIYm5Ahf2xRR4TYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e890Ncmi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618F606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e890Ncmi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D241F000D0
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422671;
	bh=7K9+aOsDuHxahvGj47BL/Y7ZLxT71kzKujqYeEjgepA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e890Ncmi276SyaCweelPLqt+Pz4ZSGewFCD4BnHV9q5KSXlIGqBFYopAm0F6xIfG5
	 9qJYoCMeRMSV44yzspXosE7XxQmUR3RDhUZBfPCbRxA3AwJcmmkF7/UJPbqJKWgGZq
	 EWuMGj5EJLjiVv4JysKiYlH4J7kgAnhU0ouLUceCsatn+wHq79GUc1zbHNFEOJ+uLw
	 /luPbBFTU8fZ8va5M/MO9rv7js0t4I8O5juuUNZ+9xwB71PHrFyHBYBOLmzufgthIs
	 puxTKuAmyhnIg1D0Rg5pN0IBRZUYsCm6sOTDHLEUeqw/kQDRW9uuSLTRiLzFDmWpzJ
	 oXUdEQV8h4srg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ae85add512so23683301fa.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:31:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGirZ6eLT2TPqyMfyOemeNeICsrhsDnUWpnjyl5q/w0HO9+US7lUkJ/ucOiQPQP10r3hdu6EB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7gX05cudf7/niF6AAeOd73LjyqugsJ8c0TTUsSYVJS4j+oOaQ
	eP9iY3pWYk9BcEFz7SJ6N/6MnPIiHKAt18l0np5jSiox3DLyZz7qzsRiUo14+s7gXFytWtjN7af
	TPIW+g3HiWkfalK9FcHzT97wsucV3sS0=
X-Received: by 2002:a05:6512:ba5:b0:5bf:9f5e:fe0d with SMTP id
 2adb3069b0e04-5c1bc7b4639mr2944106e87.23.1795422670655; Mon, 23 Nov 2026
 00:31:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114164933.2657337-1-devnexen@gmail.com>
In-Reply-To: <20261114164933.2657337-1-devnexen@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 23 Nov 2026 09:30:57 +0100
X-Gmail-Original-Message-ID: <CAD++jLk9n_GGtY1J+SpcOODwwocsbVXx5E5yzVHJfUNg_sMJ4A@mail.gmail.com>
X-Gm-Features: Aa3M54q5gLlwxxDHXv-dvL4zSEvM8EU1XrbSQjCzjg7QHjDJYHfM3pc1SEbMgYo
Message-ID: <CAD++jLk9n_GGtY1J+SpcOODwwocsbVXx5E5yzVHJfUNg_sMJ4A@mail.gmail.com>
Subject: Re: [PATCH] media: mali-c55: Serialise the ISP enable in the params
 and stats paths
To: David Carlier <devnexen@gmail.com>
Cc: linux-media@vger.kernel.org, Daniel Scally <dan.scally@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Nayden Kanchev <nayden.kanchev@arm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 5:49=E2=80=AFPM David Carlier <devnexen@gmail.com> =
wrote:

> Only the capture devices hold isp->capture_lock around the
> mali_c55_pipeline_ready() check and the ISP enable or disable. When the
> last two queues to start are on different video devices, both can see
> a ready pipeline and both enable the ISP. The second call fails with
> -EALREADY and its queue's start_streaming_called flag is cleared, so
> the ISP is never disabled again and every later start fails.
>
> Take capture_lock in the params and stats paths too.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

This looks reasonable, have you tested the patch on hardware?
FWIW:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
