Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504F25776
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774219; cv=none; b=WV09Mv+GliktwvsOszjaYlFmjkD4okorGmylxkLfxa21jYDUliFbOa6JaLWchftNaGqli5z53/2SoxTz8WbM07s4pZjngvLCwnfN+bwHdZDbqBIv86pLMm1eUdYJzY4h3DUFeNQCa2HMKp0o+lt+N9rqwvUU0jv7ByRKBEsURzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774219; c=relaxed/simple;
	bh=FQ6nBDXmQCfLWAuFi2f4O8pFAgHUsxEYNnoc1pfndT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frXkE9Gj4anjrdPkjI5xNbx2U611zQ2Rm4sanzxjo7mnGOKmrbuKc94G1oNMDOanmgu85VkZSlpMdcEAabTqSLiWaTG1f6nFnxoUC7SkQYgGhX1sNjiU9dZ7xbtGSnS3dvgAmGalYAKGjXa5B/xr3ElUCUjo3WbRSDd98Of48rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYSeAr1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYSeAr1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2C21F00893
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774204;
	bh=IvxNpbDZSTuVJu5n94z7iJrbofTyan2ItN/2vmT2AiM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IYSeAr1xDmzA5TxpPy4hHTAbNtHvsHLK6Xk0mdggkJfVTV6NJvKn80l/3Bpb6rHEv
	 0Ct1J28pP7wexhpwbldakTl3vWieIyz/h1QbfQzc7IuktCYy7de60XiUvyrm+6bIWQ
	 u7mR6j0LcO/eaLiWs4HFqLlt0d28qXDiuan2+DYGyHQBa+Z2qldG51cZa7YveFSEHD
	 0NaQLUeoCoMBJn9UpRm8wy2BYotjAjaV3QSBbyWqdnfbq2H2kzWfS1XGc4qOA3SbuK
	 gayC2xrUVQ6LqW/2pjAbwIBjzbmwcfJZEwpKoBhxXy8kvTINv/RaZjPFPu2P9dZi8q
	 oeRUYoK5pPIqg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3d84150dso590330e87.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 06:16:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxC0E/G6SYqEfAI4JDc9UFH7V5n9F0E1L4rB/uts316PYJa9YSFg7cTrB/O8eann103xRZAzsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkg3AivcojbmBb0XgfXLuuEAbRLfiiRMF7Dvd87jfxtnykgX8t
	ggBiw+zTCTcFVJ3KvMhKl9AqYTAQQhFm+9K+zgQTnP87CwE/kq88gRZC6lbwfjvt7KJhAdNFpr+
	crsd4o0agIW7WQsh5kQuSy7rsa+Afbww=
X-Received: by 2002:ac2:554a:0:b0:5ba:3d18:39da with SMTP id
 2adb3069b0e04-5ba405e3180mr400071e87.45.1790774202749; Wed, 30 Sep 2026
 06:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917134811.2153902-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917134811.2153902-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 30 Sep 2026 15:16:30 +0200
X-Gmail-Original-Message-ID: <CAD++jLnpPgLS0ctWL6n7_293mmE0gzZbxGTE9y8A=O19-JVMhA@mail.gmail.com>
X-Gm-Features: AclHuK_4EsGObMTSoIffXJHHoNHOljACQDjIXC-QnuqdASt6KV0myUbfgssO338
Message-ID: <CAD++jLnpPgLS0ctWL6n7_293mmE0gzZbxGTE9y8A=O19-JVMhA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: Fix clock reference leak in ma35_get_bank_data()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, schung@nuvoton.com, ychuang3@nuvoton.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 3:48=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> ma35_get_bank_data() obtains the bank clock with of_clk_get() and
> stores it in bank->clk, but returns clk_prepare_enable() directly.  If
> that call fails, the reference taken by of_clk_get() is never dropped,
> and the driver has no other clk_put() for it.
>
> Drop the reference when clk_prepare_enable() fails.
>
> Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO drive=
r")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Patch applied. I dropped stable because it's not that serious.

Yours,
Linus Walleij
