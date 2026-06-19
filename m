Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB343DEAC9
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781904580; cv=pass; b=h0T9PVDKFMI2BapOQ7VWQkk0tG1LYOwTDSGfb4hu/7sxZZCezxc+MvmX04vEUpJdhJzLXq1xwizd+wDUEgij8fvpYg+IHSwZqHRGUa1ISgjEy/3jB1SeobYAjHGk4zSoSFqLcZuF8KfuN/umbzrSEzUVk80XxrkbyKjM1e9WtBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781904580; c=relaxed/simple;
	bh=T4Vl7ScyqX/6yG4uTdcNG9eMwrrnNQihDYIZQ1xVyGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRpMSyUW6lOM8wveo4xFUijftz6sBh5yAiAEPfQkpmkaY20JS3l9IXPcSRfDdDm6oxsSBiT8TzGKS1WAix1Xp5HsFT3bDVkvIycoLfLEbMc9v/LITc48E9eFP8lfI+tul7nyM40qwmQEsW4pkxkcIIx41aozxghWqJ9lyW7Dyi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVZk7bPp; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVZk7bPp"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13986d61b4fso2955279c88.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781904579; cv=none;
        d=google.com; s=arc-20240605;
        b=kSrhMb4JSmwTFAjWbQFxU5O4y5Nn8DuEzuMhK/vK/FGsPF1HF8S4CKx/mYWIQPNc91
         MSmZZony104tyjQq5CpXTL1VgEWQbUBGgWR33OBBHiCNdJuxL62uPoZtwiPuYKfdeLa+
         DgEAAxGUeP78lFc1ieY1uIIchHCNeTvV0jAsuLxrxKtwc46EJMDbWq+IdWOVDWi2EK2r
         ZXFWnY62DJfKak8Rb2o5RVTs2ANVAU5iWAamniulYwF7T2/URYkHsydB4GL3fe6FANzA
         pdruWfwX5nCP8nAn8cxjgVD/HVCX9wxHRHwR7KhLGf/rdQPYxi5hEhfeErnUExwxL1On
         udkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T4Vl7ScyqX/6yG4uTdcNG9eMwrrnNQihDYIZQ1xVyGY=;
        fh=laWdsZOI4FB0oqBb80hVnqh+qnx2f7Gk3HxGNKaUgCI=;
        b=VirECMVGEr85L6OBiHOA8JeQfN13tmZXo+w09uxvWPFnoMSPPNueHpmWCypTdLjlwP
         f3jhA+raZDlVJGm5kVIhwqV6E2kw3KGK1D+TuASvMYfuY5R/oHE/BZV4Qvt/zXF9TZYS
         AV+ATbGCQ1dpl9FQfLbkVAxCCiyPYufG0fv/4T78UVPWwbCOD5xa0Essft5X/n3zGhCd
         VXbcA+xlNAudBcugOxwCXsOpSso5hb0JvwMhEt39uZ9oRDSsNfxHWI35RZYL8awD/ymU
         sOnp1tsAQ/cADE/KpefWXCdWLiQYFZk2R2lEcfU0zCvWQvI2PM1ypV8SakKqg0Os99mm
         X1tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781904579; x=1782509379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4Vl7ScyqX/6yG4uTdcNG9eMwrrnNQihDYIZQ1xVyGY=;
        b=EVZk7bPpHUzFpGM03AP8VJ7Kio71aQWZ6+AwYimnCvy5qR/YG8dPiK20DiE/4szqtz
         qK2ecJH2SBaSf/tbWu42VXiY9n2CsH98ZzaSJ10TZgsxksamp0RE57DI+7+KqCy5I1G9
         SBixvf/XuDdrjPPSO4r0eVxr3aHbEiGISzyu5FDMyrTi+Trt7nKsnizAOk7XoOGqrRZq
         jq78k9Ahs2ZoBt2EsZ6zO1IF+TAXBYx9XsN437+BOAvonm+J46vrCCAjWrdeAYAukn+w
         56vtisdwdxSfemo5C49YAfq8rNFxUVi/AzLFrYeGvV36zrP05pMKKMKSFPKylO9+HlBq
         jfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781904579; x=1782509379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T4Vl7ScyqX/6yG4uTdcNG9eMwrrnNQihDYIZQ1xVyGY=;
        b=SOL0IWvkyc3+sGWzlfNXJ+gXjx3hflgl55na8DkniOEGzeAkbG6VoVx28vsYMbJ6G3
         OZwU87dzgrkOGFkqnzMKSCemCuYm4gJ1RmTlQHL5D7QpOeDpBnNCDf4Q6BZGb3pzpFYx
         cowc0IT4DtBR68ZphkdG2hH9oEaXPPk4954SO9+hrfDvsAskwEQPtPWkUeC17fV6aJTI
         IkpswLEhc72GQf9mPEjT574ViDmiebDiUDPXdobI10inL+MuaxwqA+gtecgpKofZZXj2
         11ubUbNboRm1w3cr9MDkcySy2wt90THIEqFfN1jdIwr1ad0l3QWLoapdnAYLMaHph2Yd
         78hA==
X-Forwarded-Encrypted: i=1; AFNElJ+k+0nLEEMxIM2IPtCivetyTRbjiwdlno1+bfEbTBY8vE1udCvIBGZy1SqET3cZpAHPZX6fR/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCkXrdV2YO1+Iqf/0I45DstWiX+kJnCtRcZO5fkSi2h1tuvHn
	fmzv2AJ9dSCleH2/RUW8IJZu3FX5hVrnqqT0f1MkvIjuSn2lJxlS9UohDksPWm8Bh1a1Qe7nVCe
	5iTXl14eqZ6qSHAfzsWIZRZb0SBs8mhAotkHT0J/L
X-Gm-Gg: AfdE7cnh6tJjpGH2NJchz2nM5lc7p2S4FMpXbuO7+npkhh1Tsdp7Z7bcsUUUHzK3xpK
	lTFd8v2YHs/MPkSI+ehdv1YhCq1OPIkucXLkEZxhXGNoFeljAUiF7d1aV74bNnJ4IWLMP5qrMyH
	ss7Sh0FoyelSafXrOm1eMPysazkWajavECfGL9xO7x0rWClRVqzaXIEMMOc9btJNgvCidWR1ipY
	tw5KVhSRQ38vi83IY9Q3bhsNaMIvcW2815turWbDjUzEDKYkhfcPXcYltlcyGHY++zxBNQN11TO
	CuEOrON6kyg11v9kwcNYp6ahMVQoVgeWO/R0Olx1OleTMO1bNl+kQSU2e4YX5QRUxsQ+cWfeozd
	JxzvBQ8RVxU0Y/hIdh+/N6YoKhKzDRTOVMaeH/jVvXRCd1LnLtoY=
X-Received: by 2002:a05:7022:43a1:b0:139:817a:f00a with SMTP id
 a92af1059eb24-139a210c4famr3381380c88.17.1781904574988; Fri, 19 Jun 2026
 14:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 19 Jun 2026 14:29:23 -0700
X-Gm-Features: AVVi8CeTbFth22JNyN4ZbCRv9iOwGjjOFHXaiWJLYUYc1xJtx2RZrKLN8qTMr8M
Message-ID: <CAAVpQUAdmJUihGxFp7QS6tP5htsKmP2Gt2Dgpzp_KTwkNb+fTg@mail.gmail.com>
Subject: Re: [PATCH net] net: sit: require CAP_NET_ADMIN in the device netns
 for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
	Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 12:08=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> ipip6_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate ipip6_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed. sit was the one tunnel type not covered
> by the recent series that added this check to the other changelink()
> handlers.
>
> Fixes: 5e6700b3bf98 ("sit: add support of x-netns")
> Link: https://lore.kernel.org/netdev/20260612085941.3158249-1-maoyixie.tj=
u@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
