Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8955C1CF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660892; cv=none; b=G4GRu0BoCXFf8tcc3GqP9IhbBiU4CRLaykUhUcui7PSfIzw8mRgNRi3ytei2po001bSIpZ9Q6aQ4I6ON/8g2wU0E1Th13iMTLLgwUcqeZfCWSyosienm3+gYIBGwwEZPccEoZrDmPgJiZXG9MeZkikI/btyha6NwCUOh2GEbFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660892; c=relaxed/simple;
	bh=L7XJVn3zJKEYZntTNEdwCrWKBFrCg6HrvKLQHNiolyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcJO40Q7KShxmK2AeVMPfwtFhuazvUPFJNpu+htlYKoKqTd7cAzyU+klFu4koCymq7lU8AeVKBtE/R1I+ECS029FEIZS1wQ8sizK3GFgFZ+G21FYoBoKhEyK8DL/BitBRbVSw8LsJcGlIG/pQ5Ern+ILZlk/QBKup6eXJTvNiS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLCKsPy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLCKsPy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029C91F000FF
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660891;
	bh=+DhS//7o7owj41t5iDIwF0SCGyy9ibYv4B+yFcVevxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iLCKsPy8hA6x/lcktVIlsdyn8sjQTyqgjVUWBF7en1MLAP8475WnPTJKZOB82zlBn
	 NhkNmK//XwCB31rqv2Ge84kDd/YzHO1lz0SCO2+wnBC2rQRHEakVW+ZvChRZuGOzSp
	 fAdyMg1ZW+Xh8qZJ9WdvT+qegs5dV/p2RoJJveW2q8/nxmn+6MAt5jwF3eCrNUzq8l
	 vD3ym1+00U5oIa0PAE4sKfkXIyepkbCZKZN0h+uLAYm5k7muZcGm3Gv8JReJEdvOFe
	 2Dvx+G8xaxU5sbMzYo+S1J5lq38BOsw2tB0XArQN3iIRmvftMhRaChy8g1Mlm5qBm+
	 PS2VVLAtMl5UQ==
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1fso170576566b.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:01:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFEBhKMueTgkY5ewrm2HjriuPEt3sZIyE4qfD6T+r5KLoykIPRVVhzn5hgglr39l+h0Jlp/kY=@vger.kernel.org
X-Gm-Message-State: AFuF++nTt7vdY4po0Vs1CuC6aZjuxWWwIGsS02TezuQAGpIDvb9BH1mh
	J7J5xWw5GW/pNZvOBB6ifU8RD0hnC0zDbmOShsMXjynEYqYjpA9g0gRSWllD4MjjwgpHmo9Vl1k
	/xDU08DB1StbYR9tkJxCW9eEGitaNxg==
X-Received: by 2002:a17:907:960c:b0:c29:f5d8:9c72 with SMTP id
 a640c23a62f3a-c29f5d89db1mr290535766b.33.1789660889600; Thu, 17 Sep 2026
 09:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917124653.2151894-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917124653.2151894-1-vulab@iscas.ac.cn>
From: Rob Herring <robh@kernel.org>
Date: Thu, 17 Sep 2026 11:01:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJoUywigy2A-tfe4Jg+r_bVsk5utZ0L4qZZu+rF9RXmLg@mail.gmail.com>
X-Gm-Features: AcwNN1WoXj-aX4pp7VlWV3BhGAP-WQFU2LTbUI4Kt3JEKGaQRag-A_cEy77_ASo
Message-ID: <CAL_JsqJoUywigy2A-tfe4Jg+r_bVsk5utZ0L4qZZu+rF9RXmLg@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: Fix np reference leak in of_unittest_bus_3cell_ranges()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	saravanak@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:46=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> of_range_parser_init() can fail when the node lacks a ranges property.
> That error path returns without dropping the reference taken by
> of_find_node_by_path(). Add the missing of_node_put().
>
> Fixes: 3d5089c4263d ("of/address: Add support for 3 address cell bus")
> Cc: stable@vger.kernel.org

I don't really think we need backports for all of these.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 1 +
>  1 file changed, 1 insertion(+)

A general comment for all of these unittest fixes. I think we did a
pass of using the scoped cleanups, but if we could use those it would
be better.

Rob
