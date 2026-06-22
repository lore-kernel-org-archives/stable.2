Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4053A75A3
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131814; cv=none; b=Lk2r61ezfL+eNAMM7cftiyAhoQEXAaWjj4qYbB95hCSXyl/7vn+P369Ls/iJerHKZ7+/Dw3781/Cym9ZOxcOiRaZ6WMG/j7zAprimfKC3JZ2rnLaP/EvXLhjdC2lRLWIpPJbh5aydn83tPbVuphjcUC3r1B0VFe0+4OVra7GyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131814; c=relaxed/simple;
	bh=eUbWCd4uA8L8ygZtERA+T3ccKTe/KW3JOZWQf6S5pFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrYvHYVQlbQ/iGv5mXsJpnFcRt+2PUkTzMTD4kauTc+WqmNutMXj8BYlcjBETf29TVWin2ukQovibWCJGO5FfwLxf4YRIo3eZI1E8KGG1xaIQt8RJ8rFwY5Y9MokyGhbVL05/LtfPS41QRV8wS+2IIFm9tdbubTCBVlFWtS73gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTQwzqcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTQwzqcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FCE1F00AC4
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782131812;
	bh=eUbWCd4uA8L8ygZtERA+T3ccKTe/KW3JOZWQf6S5pFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VTQwzqcWsL+ec4uJUlRyWBn6P4NDKvuFWOnLMBCwEajeaJsaL6hyD4ZSyR4yZehTk
	 w2iuOYdo8byuNGfdivY1NaxqjPNuLE5iiSdq7njvs+98Q+plKQKfL4aPX0NeHD3CD0
	 PqoG/O+FxwyS4oMkUjI7nBR72+epLp1BLEsKHv3FrXPPLB2MRzpH2By//67XBu3heB
	 K+RBE2SX/4zEGl1ivagT7tbdh87WqNMLsTXk1DY4jYHxFamRQTLo2Km/3yv4IxGorK
	 p6jVwpME8gxObHWtf1bdvt4slxX0HYrbQ2RGRVFsCQTAltq861p/gxSMmLskMyzFhk
	 YWtgaAA96LGtw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa68d9d56fso4936429e87.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:36:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8d+DfRUJIyLIW4o0dXfSUFtEoEX2/jQ62HxQWDYgt7Me03Orpm87ZO8Or4zrPTTng4LAgDWc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovbiBn94IRuBmlmytSk396dngEN7n3rJqD68AejNLip8NvcJk
	4Y9RL8L6opaqzeqbxsApu7i4AoI80vRD9lkfOhCjKXTyb0s6TNktflOIY+BQv2/8qck75hAHSo3
	tCkKypByf4c48rZTStiI7FodUe6GvyA8=
X-Received: by 2002:a05:6512:3ca6:b0:5aa:8824:1571 with SMTP id
 2adb3069b0e04-5ad58f5896bmr3300879e87.49.1782131811251; Mon, 22 Jun 2026
 05:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622043015.643637-1-haoxiang_li2024@163.com>
In-Reply-To: <20260622043015.643637-1-haoxiang_li2024@163.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 22 Jun 2026 14:36:36 +0200
X-Gmail-Original-Message-ID: <CAD++jLmEUnYXwm3VWMSZJW-rtQkQniyhcs_0J5ex9OxsP=2SxA@mail.gmail.com>
X-Gm-Features: AVVi8CdfcYAReKAYIfo8lQyvbhkLo8Uu4wjTfvGwWbMoKmleSl20UIG87a7HorA
Message-ID: <CAD++jLmEUnYXwm3VWMSZJW-rtQkQniyhcs_0J5ex9OxsP=2SxA@mail.gmail.com>
Subject: Re: [PATCH] net: ixp4xx_hss: fix duplicate HDLC netdev allocation
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: kaloz@openwrt.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	huangguangbin2@huawei.com, lipeng321@huawei.com, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 6:30=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.co=
m> wrote:

> ixp4xx_hss_probe() allocates two HDLC netdevs. The first one is stored
> in ndev, initialized, and registered with register_hdlc_device(). The
> second one is stored in port->netdev and later used by the remove path
> for unregister_hdlc_device() and free_netdev().
>
> This means that the registered netdev is not the same object that is
> unregistered and freed on remove. It also leaks the first allocation if
> the second alloc_hdlcdev() call fails, and the first allocation is not
> checked before ndev is used.
>
> Older code allocated the HDLC netdev only once and stored the same object
> in both the local variable and port->netdev. The buggy conversion split
> this into two alloc_hdlcdev() calls. A later rename changed the local
> variable name to ndev, but the underlying mismatch remained.
>
> Fix this by allocating the HDLC netdev only once and assigning the same
> object to port->netdev.
>
> Fixes: 99ebe65eb9c0 ("net: ixp4xx_hss: move out assignment in if conditio=
n")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
