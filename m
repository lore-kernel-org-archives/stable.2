Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAE73D902D
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247626; cv=pass; b=np7D5yU1s1wpOxb2TJubG1V/nDeHSm8HOq9qLQpjgKg/f8KFDtt6/NO0T9u8h92EAQAP+uRgQBQ3F1iakDCihaLsj/4j2QzvoU8Th2DThgdmw7wLvMrCHSpOb7r7zIqaazq2o48LoH9fboN1shkIjP+nQFvdjePCMIfmuAPs02M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247626; c=relaxed/simple;
	bh=fLn/U8yJbyJy4AmM/RvWgkblgbys8OLsbj/lFvTx65E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqXFS/cS8z0aKyDOMXJJeB5+YB/+ysnReZVv1MsYW/xEwHEJqnZfx4C3ioxrEiiE3pYKjUUfzg7BIEyP7iKUERJdLACwYYCLXqWQTHu0ur9gCldovfr4wCpQroc3Qytgv4+9u0jrVPMSXB3o+kLrlMfh1G3xS5H0nDPyE30w4MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOzIQi1W; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOzIQi1W"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1370417c01cso769412c88.1
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247615; cv=none;
        d=google.com; s=arc-20240605;
        b=ISBSUB38r7EtB9KIAJ1+KjX4lW9omcsbw1IpN3TvkYCRdE5oKjwukIgTxVnCvYiGUb
         c8XcC7BrB8Gxc882/D1lfpT8/c8LhPdGPy4fkX4htZvBdjCTjPOb9X096nIOHckMjKDA
         /CUhSQRFviUre1BcpMBXIObNh1yXzQMyCekrsrJva1iRzmvPrmiJIw/r55kN15DgccII
         T1rTCbp3kjrrytfW8CXh6WB0oddOAo2IlKY6c2wuxYJj2CeAGcZK8xvMOm0y0w3WfQiT
         r6iXs22ujkC26huNutcF87d+Cl55BRbmQ2GpGAFmXdSVDhzc22fDWk8z1Vf/8nQSAstO
         +ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fLn/U8yJbyJy4AmM/RvWgkblgbys8OLsbj/lFvTx65E=;
        fh=rJaTHbOkhDxxMP4WSJ49ZIJk+OnTmCzkbRj9OHjtmig=;
        b=IzMcgaMLi1C3LpdIesN/6ZEovqWJdqNR4Huqb9UEGXBuTHa1wtOmSHDOxEslF7Zcaw
         FF7CV7+R6v+7ohkZeInc71fJY/thVk6jHtBQg5Rx42RRYY2Ze8driJR9/IzbFmhCZNg0
         jRJYNtGK6VAPe8wSvabAMFUTYZMxqdnZUc5s9Acw6nV6UaVwOmAeZh/dQ4r+pkce0ASs
         z7Zgd23HjYp4F47alq4nQvN7feTJSmCxFNMUbjTnLBel+QPVUcEAjlgXj4Fk3XH0LtMe
         Yc+6yLeuhLVidkXUu+S5piP0+voTQZhmW1rERNC0NHvQm9l4IzkZisjq18RnN0pannr8
         TKlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247615; x=1781852415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLn/U8yJbyJy4AmM/RvWgkblgbys8OLsbj/lFvTx65E=;
        b=lOzIQi1W6XR53rdfyN2PHBuVoubKkg3loCfLnZ/xgtNFchUymchrMMaKKy8c4Y4X0t
         ZGUUworyiYJRAzKYPJS/W5ONRQFfd1IU9EnDj+Rv3tkiMBXbeqR8kVefJsayYtpi9gRk
         SRY2wB+kSeAVgNfA2ezG7kpbhIxDlk3bz9FfqV50aIJI06M3KaZWnuKKdFr/HkeAopuz
         5NdhBuDYKNLjlW4yt0yLHWhQEV8Zokl3djxEg7ehEUnV9zvG8e7PBEH7BuRi1SICfW0l
         KxJGjzxv7znjhTpIBVHVSkx6z7YS5Av9jc3fmTYpSY2bGTRuihfnq3m7KPJ2wSwP7UPX
         /hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247615; x=1781852415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fLn/U8yJbyJy4AmM/RvWgkblgbys8OLsbj/lFvTx65E=;
        b=WlCOMMzv1yRu3acwElU7iQyUNuQrL9IRf/JKocdFeAnvtm2VNjhpFA8kOMJTeffeqb
         PWTjxBS/eFJv2QT4V0BaDoLbyx93K8D2grLqjv9182Iv+Et5Y0HvMRPDEPZ5fhYHzIVa
         AVQbF98I1xM4fFScjKn2WTd3+96avTuSdkAtJPsaSDd/mNeChfzCcIlRwb+Xizwibo2w
         jgLT6IuRJgip79VWaBMUDXsyrDIa/4Wtj6jAaqNYo4VXaV6FBYdhiuu78vQGfezK/j1J
         EqC/cXR9+jNySzefDw/RXZScbXKoBvSLya0jBlgyAq343pPBSXONMmUIDRwTd7w1SezS
         xSEQ==
X-Forwarded-Encrypted: i=1; AFNElJ98bgBX/154Uh5oyqDSbLw6IX5nat7s9noEYJLbP2wL6wLWV8iErquZSyWqN1qr3vH6sNsMqFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhsK4BOHJ6+LW8AzL0vkgtsAXql2Q5CXDpxEQHuscFb1OaEQs
	SW8wPLNkk+e2by3wAbtp3n95APyoP4jpJrmwfNirujWAvUpoCNp9KUwaX6cnFwYkeuoCm3I/6ZT
	QAImU9k2+hoNRKjHfEkNevSuaU/TXfZrEnNv2YutT
X-Gm-Gg: Acq92OGWBp56qjPqjm7qc/Z+Pi2rj05cOY8I1EV1Z5YLPv0tEKyCQaogPd+ZBBLHpc7
	XzAsm9Lpak1rYudfmd2IxIPtG8zgL2X2QZfoyXOgarRCpEtbeGuhNwj5Mmewxmn8wSxY/jwLx3z
	L2orYt0UsZ5bIOL4DzoIeOHMjz81XoYFlxHMhmwAaxmhw0QtYhqbmrT1J7qPpt8kD6TOE3BPmod
	KqM7z/U1k1RudD6+XqkUMGyL8ol4LAM0d7IYraj3CMvaJLJYTeFkJ6fEfhxFN1lGXqubGXqrpbd
	7XJ8WQMOPqFg9QKdoWo4HTj5a1tjTfwdBYn/DSiAaBLUAJJJBd/cY4xQCZZVs7bJIveq3zv2I0s
	5cqorq7xBMTwURbfigmkjal0y2PWyMFkvcEb8UFLyiY7LmuRNqbqG
X-Received: by 2002:a05:7022:61e:b0:137:9ee5:208d with SMTP id
 a92af1059eb24-1384bbe26a4mr620057c88.33.1781247613853; Fri, 12 Jun 2026
 00:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-7-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-7-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 00:00:02 -0700
X-Gm-Features: AVVi8CfpcR1-jNm9zVP9HiE7DEszLMMfYpkSNApG-FfdrrRUFDUxEDJ0ECI0LgI
Message-ID: <CAAVpQUDUoae0D=sJnBC6pfm5HcBhfU3dwZquE0xo8GZ8T9eObQ@mail.gmail.com>
Subject: Re: [PATCH net v5 6/7] net: ip6_vti: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> vti6_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate vti6_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")

Wrong tag again.. :/

Fixes: 61220ab34948 ("vti6: Enable namespace changing")


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
