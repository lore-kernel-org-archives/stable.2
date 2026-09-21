Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF924A92DC
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004279; cv=pass; b=aepXN/epUPspora628mECvGaoxD4e/VkaVa5/Y4quagtvnGrIez3uR3yR+s39lwbF+WHAsjXZS9IPwT3wXk7tngLDb0pxX4nw19EuJF1Z1oz/GexhN88b+dEVAaFksgxjyMpCjzDpjsN045+2f10sKgV1UfAxG+Uf4PnBrhNJYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004279; c=relaxed/simple;
	bh=fVkMbtrDFgg9JhiC1LwbHU+t/WNuxQvV8nWO3zEnhqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZJrjQ4roc3lr8x1oKWB3Tv2Uws9hHxxjjboGB5gDf0b8mzOWvSGGrYzhwcveI8dcVzeeyf5CLKxCWUMVu8+HkHftCaAmQPIIhmOcAszEDw+Ek3fXeZy+dHX6B1zPHZGoDXm9gGJHt2Ph6ZnvmfgqyJmBg7ZhdWaO73Vl0xOEYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQoRKykJ; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQoRKykJ"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d4688decso31384281fa.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790004276; cv=none;
        d=google.com; s=arc-20260327;
        b=mxniAq9VMznlVjYHhLOVW5xIW9XKQGPBOSWXoSyUNRVDkXdRz2usA7wql1PUs3UqNk
         AE41rHc8KUoSvdKNeIMCnGNUqFWh8dqvdc46/MgxKyIskqsLK/WXTr/o5TsyWLkOIC4o
         rWjzQLCob78f4sfr14m4rAV38jypK89Xy8Ao1gc/8Wy6z/ASSWTnVZmPavXpcv9mN6kQ
         xSU4ZolIAXPKJfKhBPNXz/ax1T72M/WgPQDXWe3dHJBTU9AJpChn71FXp7KKy6Fm8Nmf
         6d3w/Rt5lakInLGejbHOe//U6DtQUhWAiWGZrjNNd/TVvUQEv9xXo+6MlQsepMtH679b
         XPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        fh=MH0vwkzXWRCK3FRNHLFJ2NzhSQuU4xOeWV5Wtu+Z0D4=;
        b=q3wO+1K1kGOp0s+Dfo5cZV2nlDfEbsLjNez91+4+Mpl2eYa02GuSacu7mldLCrqPYf
         ynSeBQL/0u1RLlh75nFfGUXktaaJWNn+8Xpc2cKK+8Rw43tSA+3GSHn04orYpp0AEfK7
         6M9bJ0ZUAEav0X1zdAfUGz3i93TZa4VK3cqGhjWwfSy6PiFxGOMWFF3viyJo8KRogYut
         V2eIVoBIvG2CRXVC63rZf6s8+RXNQf6QlSrayyZyWve/t1tqyl4wCTxNrxtCjV9M7Y5i
         VqeS15LnwBv1DDlLvekCMHk6xZZRCiGHEJvF6CMd6Bd3Gp4AncqbgC6gsiaZ/df7WIAy
         liEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004276; x=1790609076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        b=cQoRKykJFqFyI9NigTnPCxeRN1VP1Ou79d7z8LN0sQVBAb3eOJCjlisTu98bQpUjEP
         6J2SIyrGd6sKnzDGj1ylmrd1zSzIP8/Kqpdj5jyvKZIzuR39nEPXQ45vi5TDlcozpEOp
         yvkO8I1+9RFwGUQrOfXuKnEttydrjoRMXvlDrSZSZjmXec4ken4RT0S2WJg1TvM32/+u
         6cYKCBZwyDCyR8i/kCt91Nu4lyRFRK9Rq+t9VgnmFGgwkGiTeaU3M2jbQ7uQEga/8DbT
         CedNXLSET7HzY453SzdOMpT7b9jJNuQuuwrxmAxV6JaeqG/SZSPe+5qRJXI4tiimoDsg
         YV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004276; x=1790609076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3IcGGSo5+j0HvIrQfCCVAwZ7s4gKZX9RwrmAX0fXMM=;
        b=DzK3OZ0A4UAZwkFJwhlmxriMvDdtrLiZ6a1cyk21U1wR67MR7Av64y9H/SiMx/iCrO
         qdAa8yAHH9n3/mUMDDvqZOP51OijFvBIDWGIU3FrCkDv6qFCZVQBYQRj3010fMDM5UbH
         I46P3GuiAOPLDQPGebHfa3cggX77gZJ3YJv+NFjQ+iy58vvwkuAH7F43LAlQLnqaLtRl
         c5uB1PWIPe9ZbmF1Qc7HuUTbWQQx/8baEnYpa3cAliW5GU8R4SfmkeLE1koODcuYBvbO
         mGg5T/hNNlDFASctgfWeO0gNvWuR2KW6JNtFdibcu09AKRtfnBuo5CoO4Tk/0pMIs3iB
         HLLA==
X-Forwarded-Encrypted: i=1; AKwUvBxdJHi3n4x9NczrcqHz+NayYgu0fRX17iokZns0ruQbNUOANTN3bcHhX0q/x5QuINV2akhMCDw=@vger.kernel.org
X-Gm-Message-State: AFuF++nk8dQfmpY1agLLmhz0idGCq6FwHBEHo8QJHzUDmPozHYAMuFjy
	eFvvhm8390IIyivo0SGTKNLtFJ0lA8lJnDa0+T7hyWjjL1RxFi7ticJF4RA11fC0sSkX57gszi0
	bKMFeiDdwu87fY1UlrSvDZQxjGpYpvuE=
X-Gm-Gg: AYBFou1+9cAHgIQOCCx2OUlDZ6WtXFrxxFXSahjSpuFTq7g3fAawtmJo/MdPrPbEcAm
	Pfu8z+G80sxZhK1gQQkSfD1yvzu0iJ9GDwFyt8bq6yy1l1rMs3HuGio1Semu5ouVKgYBQ7UxevN
	5phXxLeTn8NSUlzaSSkYRoIUSFNMHBnLzLFfQKD1zHEKjILquoIV0fFyHBlUNb5K2LR03gYirZz
	l+B8OLAO96FrkpU/qnLCer5QXTFkvlmoCJUQMerMjqrcTu3Sr13Iv45BOBJrs70uL06cN44x2Oh
	UeUOUFHBBTUmMCl7kMIcRZZ5ASEn1SUNhH8vdO+rKJqzY53KWxMyiaMOE1ssuN2OWLnpUXkmjqb
	kr5DEy4OGsqsd75rloqaQOyuzmWZBcGjaCAOspZy3YNou9RdP6HnaIkbyt4CaSZ21y1O1qDbZJi
	vc86wW6FTpI5aEF+J1SNYykI2Pu3Y=
X-Received: by 2002:a05:651c:54d:b0:3a1:8dd6:aaf9 with SMTP id
 38308e7fff4ca-3a5fbf32d5amr23385811fa.8.1790004275723; Mon, 21 Sep 2026
 08:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917153923.904124-3-bestswngs@gmail.com>
In-Reply-To: <20260917153923.904124-3-bestswngs@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Sep 2026 23:23:56 +0800
X-Gm-Features: AcwNN1VVTW-G-tYVzMWlBy3I-0oQzwQRNZQ4azMiWAQGx7Mm8VmFuFMIZMGo3_g
Message-ID: <CAL+tcoCD9baTVJFckt8yXaTHEqU4BQ=cKCUxtyUHO2MqfLimFA@mail.gmail.com>
Subject: Re: [PATCH net] veth: manage XDP program pointers during channel resize
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, co+65e5c76b187f08b2@bugs.sh, Xiang Mei <xmei5@asu.edu>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 2:50=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
>
> veth_set_channels() tears down XDP resources for removed RX queues
> without clearing rq->xdp_prog.  If the program is then detached or
> replaced, those queues keep the old pointer after bpf_prog_put().  A
> later channel increase can re-enable NAPI and run the freed program.
>
> Clear the program pointer after taking an RX queue offline, and publish
> the current program only after bringing the queue back online succeeds.
>
>   BUG: unable to handle page fault for address: ffffc90000256048
>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>   RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
>                          include/net/xdp.h:696 drivers/net/veth.c:820)
>   Call Trace:
>    veth_xdp_rcv (drivers/net/veth.c:941)
>    veth_poll (drivers/net/veth.c:986)
>    __napi_poll (net/core/dev.c:7787)
>    net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
>    handle_softirqs (kernel/softirq.c:645)
>   Kernel panic - not syncing: Fatal exception in interrupt
>
> Cc: stable@vger.kernel.org
> Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op"=
)
> Reported-by: <co+65e5c76b187f08b2@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!
