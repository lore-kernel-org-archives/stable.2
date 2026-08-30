Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69930F548
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123127; cv=pass; b=JNZF189dgd5DZpfgRQvj4ArRjQzBIJNP7IgTmpAH9dMxOm9OyaCzMtKATpilmqCLjgLyNmz4mZmJ9caIjsEeRJUe+bFuB/Sgu2pPv7AX6EeLp63fsREA8lhJuJBpFbYDwxrJdaNicwgxF42CbZCyE08FOB3o1GnCPXU2txwHSsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123127; c=relaxed/simple;
	bh=AYjhl47EsIwn1DyL5gmpc8wtKBp5jDGTaUHfCK2SgJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPL72VZJ4RuN0W4iaMRie+zc5bJjycD9RTwa63hyhP+5AFD0RsRVPB2fkIbuTmJDIEyeglTNR5Qjqdxvyv8nmKlY703KpNPDvMKseQ9Rp6yiTFWOZh7C+E9YRoIeRxjrHu70+qMEJANcyZaTBV5fDlI1j4nJMWOhmxr6uvyHxE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/Fy4QX7; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/Fy4QX7"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a5f95a879cso8249a12.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 13:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788123124; cv=none;
        d=google.com; s=arc-20260327;
        b=OyqwjCA25wXbtN4TaagUNOeTWyQL8D0RGUvtWN2mi4SByLRvbZ9pgA3RV6TaQr9mcV
         CpRGxyyG7XdbUsA758yAeGL48AoFOIgBCJ2oeweVqDLOMAWPSwwm/qykk1S8O6Or35wa
         FUIjBEahlZYB1TmrDlOdEEXBTP9PFHQAp6nvVghZuxTTWy/Isg7h/PgAmwPmF8LpqVMO
         NSz0C0N2I1RSbbjkXCnlvB/LVaV5KbtUEeUSAtgyf94sL9gkNEI4tN5QCSezRUm7N1Me
         cpbja9Wsu6eyLa5XOkH7gZY3hmkuRw7Zt2iyuHDpboOm3BJgCO/jRqp0anqGPXX/dKdb
         e4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYjhl47EsIwn1DyL5gmpc8wtKBp5jDGTaUHfCK2SgJ0=;
        fh=pLMDztlXHc4KZLJ4zAnz7yXHJjpiYpnlcbw6fOHEpQU=;
        b=AH+2lHExjOyHw/S1qLZS00oCPxcVLgroS+0JrzDxYhtj4+dOSNp+wNDYcEqPUiknBU
         80SO+QqBrd1WNDr6X5RlmS0eoKiIoyMQIp++f9agysKNd8jzQfmXoREmUHAuGKzDJ0N1
         TOl80ENVChbnAiCQ7K3WU1XW9w9HFDHLZhkFY9ifUc3JUwo1zaxaPNuOY2epkbyQNmoS
         p0OuOMbPRgyyANUj537TWctur0eG+/E6iOrmWRNXczR4cANBb4OzcchApop6sixEli1Y
         UIzKrtTZ2Rs2Xsb5D5ObIVCWEUNDucpodWLK4k+Qo//B4L+e88XTfRtLYv4Q4W28TAcG
         ruRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788123124; x=1788727924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYjhl47EsIwn1DyL5gmpc8wtKBp5jDGTaUHfCK2SgJ0=;
        b=r/Fy4QX7ITrSC9mh4ISpwMhqu3ZZMZBpjsmiJ/bup7R88go4/YSnTewfLXnvVNPFcQ
         Xf4a8LH/x9S/r+UGeVDF8+3rnm654ZlWbXYGh0cYQrca4CIPlv2anlqD8HW0/EpFSp9j
         Um1trhjl2thJKxEWaWKf6hhBVKByqD3ahx8vPnhjLsre/n/0BuKtyveor99pvoSxVile
         QE749loy8Kv4lY289+wzZJ/KL2jeIJMANXoxX5XbNhEPl9SNUOU+Vq3ofPOLQItme62u
         Y668UQfr+sH6jFHUEGMPH0e1vFkN1D++wUPLurHsACyAERU/MO3tA3zYUFNrQhdYKWcK
         1H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123124; x=1788727924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYjhl47EsIwn1DyL5gmpc8wtKBp5jDGTaUHfCK2SgJ0=;
        b=cnUR00kle0g3BJQjR9MMcjD9uQI6zNHFWVp0TTOWNzxgYH0m0Klp+gbdjFxLJMLrA3
         BIBDIcmb71QVkXC7frPsndl4C7XdQ2+C6yvh9N2utqi+NubFrRXVtGJJVvSLykzI54pn
         HRU48x/a+/50EGm3EnmuxN9f2KMQArh26NjT5C5a+WmVCxL2NM4b6fG9ZONsR1VsNC0b
         UUORe80R8YuBFQshph+KxQiajpbaK/2g13QSWDdzfEvVYTTHaWVRoSkv+ubGklvZNUNy
         ybg+HvzZBBWxGWevSG+1h4SG20ZRUNTgJelzvS7jK86rG/vwXfGSCmYj3yLWo9LHk4Tf
         GLig==
X-Forwarded-Encrypted: i=1; AKwUvBzSOIcxHpBi0O3LuNmfIn8HrQCr9PphKRi4CmBCOJQdmsN6/fjnpHfqQibqACxX72xxVmQGkuM=@vger.kernel.org
X-Gm-Message-State: AFuF++lPI9Llv4xmeKcY7pjc2PtFD6Un2SIK6qtiMyJ6o/04z8Q0xuGU
	LkHqFFJkDFLbL7ZPJUL2cPd1cg1lvgCRZ3IV8GdRb2sG97tq5Tp9L0CmhcZklbfxpddWgUWVsUj
	2Hm7st14mlW+6lUp0Qy9N+6TeIxI3TAJDnSdS1Dbv
X-Gm-Gg: AYBFou2N9LpQmUEgec980t4soU4tSZmYSZximRF0XE5A0Ft/xaKRb1MiH6VLbTeCFYl
	CXe5Hhk8L67Ecaoiccu2TlPGikpoe7xx1ihYezqk5vGX0xzlPlj/jURAtd5GhfaLD7tz7xL3AKR
	5USnJIuMgRr04C7jqIYF069Y7lOXJD0NHu7s9i5OxcUz2UXS/8FHz1a8vcNRQKCFHZYtpcg3Qvc
	X2z1OxTZRxu4epxen/gookC18q0OVpKVroaS69gYGgW59DWa798AurCidMniIuTdWfj02/6SCI3
	oXci3cagunNEdiPisZhwEaVueESirI/NeL0vyGjQisE=
X-Received: by 2002:aa7:c4ef:0:b0:69c:39f5:7e36 with SMTP id
 4fb4d7f45d1cf-6a6334422ccmr20461a12.0.1788123122697; Sun, 30 Aug 2026
 13:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830142333.1741155-1-tristmd@gmail.com> <CAHS8izPvuOBx08kGEp+sFR-VjCa=Ta4Ub=EVb1kBP+ROZOMYnQ@mail.gmail.com>
In-Reply-To: <CAHS8izPvuOBx08kGEp+sFR-VjCa=Ta4Ub=EVb1kBP+ROZOMYnQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 30 Aug 2026 13:51:51 -0700
X-Gm-Features: AcwNN1UQs3VpoPc5tVAlx3mcW2vUdqnrQx3Tyi9lFFLFEIZgxoe0lirGis_pFI4
Message-ID: <CAHS8izMK_gXiyd=1XEJgSOD3Ybzdmet3ucggboyy2vAsWRFLsg@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: add missing permission check for bind-tx
To: Tristan Madani <tristmd@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 1:51=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Sun, Aug 30, 2026 at 7:23=E2=80=AFAM Tristan Madani <tristmd@gmail.com=
> wrote:
> >
> > From: Tristan Madani <tristan@talencesecurity.com>
> >
> > The bind-tx netlink command (NETDEV_CMD_BIND_TX) was introduced in comm=
it
> > 8802087d20c0 ("net: devmem: TCP tx netlink api") without any permission
> > flags in the netlink spec. As a result, the generated genl code does no=
t
> > enforce any capability check, allowing unprivileged users to bind
> > DMA-BUFs to network devices that support TX netmem.
> >
> > In contrast, the bind-rx command (NETDEV_CMD_BIND_RX) correctly require=
s
> > GENL_UNS_ADMIN_PERM (CAP_NET_ADMIN in the namespace's owning user
> > namespace). Both operations perform the same class of privileged DMA-BU=
F
> > binding, and bind-tx should require the same level of authorization.
> >
> > Add the uns-admin-perm flag to the bind-tx command in the netlink spec
> > and update the generated C code to enforce CAP_NET_ADMIN.
> >
> > Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
>
> This is the second time some AI finds this 'bug'. It's intentional
> that rx needs permissions, and tx doesn't. rx bind takes ownership of
> an rx queue. tx does not.
>

It may be worth it to add a comment at this point for future AIs
reviewing the code.

--=20
Thanks,
Mina
