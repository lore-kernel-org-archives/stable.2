Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A335DA68
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248186; cv=pass; b=EUSfCWOnM+0FYpa2Xu0tyn5HZdyvfCKlNdR/x3zzRFMPa9eNZAoxT2qFDFUFFlkicSg8UMZMu9ejJzGCUvCr6A6cSLKV1MAAohGCrdYbSUroS6S7UZQ9gGl7DYuTXVeHI5+Fibau7pHdSKSlMqyBDFVRWOpJW1v94doEd44Etn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248186; c=relaxed/simple;
	bh=scRqJg4KU9XRGMMQmjBz/z1e9UrAgeP4lSxWj+3CvV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWPPMVMzfDe9mP65ZP2guU/G1eo9YYykJ/XiuPTK27ShTl9r412+ycCvSc8BDsrcijtZy2rkmFLeo7jwMaS76V1lIdccH47cNIt7ZR7nzO5OO1SDg50HIR0/XJ1kOhl2uSAaiIFGZvhnxhNxuAJRAkHmuZE2sJ7OhqvJTbZ0Jyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jC1ktIJq; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jC1ktIJq"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso121150a12.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787248184; cv=none;
        d=google.com; s=arc-20260327;
        b=J7TNtZ0ySfWuJQiKDF9OC2uWmzskCcUa9uygY3DtersH9x3qAjD/sZdV6UIrjlaXda
         mOg0GfJGkd38knDvkYfs9eBOSkv5aToo0PuPUUvjtpCQejn3BDzRXLe69jfOyGfXd/fQ
         f6jKcVSggiDsSv8r3YIUbXhdK/ggD3uorRRESDgNpp8oxfBLUmFOaF0IkroMaHSfc5ja
         5NNNAQqNt/zgf3/NNRrDeIJWrsiSZ/fo1toMWTq+Ad4VSYxwv+e1UGWsV1BzAAiBL9A3
         UOzTMHeRl0zUe1buBx4gj2y+G9DEcMa9O0iNFiyTBrJZkQ34t60CDazc5GdZco7nbqZ6
         aXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CmcwQpObp8rK/yShro+4Scxu1zxgojYuFikiYx3D+pY=;
        fh=f8EGNBkbLGX97ym1DJRilHv+WvZB0MzCD074UPJgU9M=;
        b=kZsOghgCHipbaOx0gYMtXJcNFN1fFu7QxOP46fFOtcAQ6WKWPajSLo8HY/qYvkvrJa
         8cv1YgF6FRCIxxSWBClQvUNpcOr+wS8S++A4J76iFcjMTP51PrpQfBtGycx8xiqfba/4
         jBruEZCVvzGWTc3yj0Y1BHwrv40RHr03ffxwq/YJr9r+lwQsp03qCnR6UllleXDMpmff
         hO02WYRILn/cp8SsT8L8vTvOXpO13qbiWHShaXOgYf5J6qI+PVzTJAjAaYusWN57Qfsl
         at1r3Zq8uou6ZmySEl8hZXCiFr765W6xUmIpywdSkmSjbTvIlLb1DVO8p1MRn8GdNC4X
         rjXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787248184; x=1787852984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CmcwQpObp8rK/yShro+4Scxu1zxgojYuFikiYx3D+pY=;
        b=jC1ktIJqutxoU4gDiJh1Rhdj5nQQ0WALbuvXq9KSLh3UaZLfHILZmnWzsehygZRVC/
         TToqJlFLunoGpk64+JYeH7kXXEZjkmtjdiGteFyEC1zb+hWSCLY69+SkS6LJa0wCwNpS
         ilxmsadFWQtKy7hObE0fuPeFeOAsWYw4a5QcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248184; x=1787852984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmcwQpObp8rK/yShro+4Scxu1zxgojYuFikiYx3D+pY=;
        b=AOaSu7sv2jonno3lw1r/Z7v5GrnavQ+u7GbskhJQR8evE81ha1F2v/ofRp+6W/3VQ7
         LtXD6JZCiEasO0kYuU8gYoLBCvGtSano1fiwJjDTxEVg23zS8Wl8QROXCxVBWVYe/+B3
         pSldJnOBxV8p5oArsR9F6uHEH+BlcZePF6b/nJOJjwB7S/Uf9bD25I0lOD1oHAsuw3Kg
         IB8eCfAR3DSmlSK4oeGkUyjShaDW8eUZop8LBH5APwCkCHLUm61wUp5As8fvG/nfqK5J
         pYEc87bXiFznwHtS6eOnRk9q4aGTp1S8hIFa9PZ/x8PqoCCHNVksLZKG4HLvapJ7pBil
         +w0w==
X-Gm-Message-State: AOJu0Yx6r2YkH+O50DWKGxGa8YwH5n37FfNMcVzE0dyDXqPywrkYXQ/h
	EwRBeQ63D/MTZVVy/z0mPT/ioOJubUkdf1iKjLmBmYoomnsr5JUe9pVXaYRVcSUHGCW/a//fCAp
	vAzoIAIrY+eVJOM1dSBgwXCUP3Et5DdY2VqaeHhnj
X-Gm-Gg: AR+sD12g9lbpkyxhsL74ZSAzjJ+VxYuNekU4mbTTepGMhKGRZOFez1hM69g3QObfGoW
	U7QLdBWjL5sCKBhCGygHaKIC42KdJZRPJOUkTJRVEs6N+SAZ+QJGkeZLLuCB2JNSaQ6E9AssAIK
	i1i2WLOxaHW4ujONzmBtBYoBkefFxMDg3soPex6Cc4ZU3yr7rklEDwVaT2Rp7VbEcp73mSj/YTZ
	lZt+98M/buw9CoEpy6hBH+Dr8Cwo1d8NQIlf49XmBRIqt3RV3pqv+pYXuLjTyl3u8pIv3pYHUDU
	yyXqppXNXo7n+618XcuZ3LJF9wItdHBbKDejz5oxIA==
X-Received: by 2002:a05:6a00:6ca2:b0:82f:2b0:2809 with SMTP id
 d2e1a72fcca58-851d3817017mr24869663b3a.1.1787248184012; Thu, 20 Aug 2026
 10:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818101735.16655-1-jhs@mojatatu.com> <20260818101735.16655-2-jhs@mojatatu.com>
In-Reply-To: <20260818101735.16655-2-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 13:49:32 -0400
X-Gm-Features: AcwNN1U-J51-4o4xhcv8Itwt2BV3UxApsKXIGufvIdxkSOh6aH05D8cbn9tzvYo
Message-ID: <CAM0EoM=J1YnjBLpCOPjDwFOOwAYgZLtOXCYffTmi=w5Ne40bGw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: tc-testing: add TCA_STAB overhead
 rejection tests for DRR and ETS
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:17=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Add tdc test cases that verify a qdisc with an oversized TCA_STAB
> overhead (2147483000) is rejected. Without the fix, the qdisc is
> accepted and a single packet drives the deficit loop into a soft
> lockup; with the fix, the add fails with -EINVAL.
>
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  .../tc-testing/tc-tests/qdiscs/drr.json       | 20 +++++++++++++++++++
>  .../tc-testing/tc-tests/qdiscs/ets.json       | 20 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json =
b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
> index 2b61d8d79bde..7713eb35aaeb 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
> @@ -86,5 +86,25 @@
>          "teardown": [
>              "$TC qdisc del dev $DUMMY root"
>          ]
> +    },
> +    {
> +        "id": "d1e2",
> +        "name": "Reject DRR qdisc with oversized TCA_STAB overhead",
> +        "category": [
> +            "qdisc",
> +            "drr"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +        ],
> +        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root stab ov=
erhead 2147483000 drr",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> +        "matchPattern": "qdisc drr",
> +        "matchCount": "0",
> +        "teardown": [
> +        ]
>      }
>  ]
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json =
b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
> index ee09e6d6fdf3..da7ae626f7e1 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
> @@ -1007,5 +1007,25 @@
>          "teardown": [
>              "echo \"1\" > /sys/bus/netdevsim/del_device"
>          ]
> +    },
> +    {
> +        "id": "f3a4",
> +        "name": "Reject ETS qdisc with oversized TCA_STAB overhead",
> +        "category": [
> +            "qdisc",
> +            "ets"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +        ],
> +        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root stab ov=
erhead 2147483000 ets bands 1 strict 0 quanta 1",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC qdisc show dev $DUMMY",
> +        "matchPattern": "qdisc ets",
> +        "matchCount": "0",
> +        "teardown": [
> +        ]
>      }
>  ]
> --
> 2.43.0

V2 had a different title.
--
pw-bot: cr

>
