Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3610314B66
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482132; cv=pass; b=QgkEHa4OTOS4k1uLAsBfsOwHjmq49XvU+/kYT976NwMEKkhBsj4wFn/Lbjf1jrdf+cyXVj4SlSXA0cqA76MDk28nUSa6t2PAFfXqBJVZugG5dS9xNP0GowuuLwc50IGHM8R+d9EkVK6NamuzKaPlFMsC1WaWN3sFoOsPJ3XJXnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482132; c=relaxed/simple;
	bh=6mc+ysZ4PjKe5tpOOyTXrXxi9SHfqCj+f7PO2DH/4mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsBjEuzdvrLqvk5D2faPI3hPoNRuBOK+2BDm1ZbZjDXBwAcSSM/BpXu7k6syn6v5smwxoA5r34AFnmsz+H41hFw+n+dVXvLmWUD8gu835Y44yweQxlI2GSr1KJ5DAe1EKtLNp8RdUS/M8/i5MxHKHPv36fcFDCTxBt/d2nNpYOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlB8TNX8; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlB8TNX8"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5300bdf61d9so6315531cf.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 17:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788482130; cv=none;
        d=google.com; s=arc-20260327;
        b=GkShiCuaSG2ajmE+o6BwLhmu4YRex02tGFsVj3GXlz2zMpkPoimsUNFAK3MvkHnnpZ
         H2oJmJg4+5yY5dOcY4M72yhVWJXefoHQHCtJRHT6T+yhhZKSyyzMUk4+YCChNwnkvec6
         5/4qrtk9lOPZQ5rvA8GTZJ2hpuphZPPd70fHklJKehOPbH2kAaaeMm7/kYNMQ3/qF0QO
         9cCLvyLBtZifCfgk3DG25sT2VprL4XGR2/Wre3U+yrQP4o+fND2IuQ7OLjevGtqsAPPW
         GahecYfC/uk3VeYU80ZwPjUp3S+35Bm0w3P0I/EwhVVCYsOFUBjPJNHnYMf0XH0+S7Uo
         yRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=frzNhQSteSDys2/ZOWWgAmq0ecP55hQGym3yBI7s6zs=;
        fh=4lk0D9tUaGcv0YFXGbni0NBSqWbo8flpdGjtZ8ychfA=;
        b=qLO4T2/kFm9y89k3mzuswMZ3nZw/Xpm9jYWxveygBU3XOVZDyczbZg0Vnq1TnTCeme
         2RnQfnxZJ0dPlwPvkrEUkSD+6GuCo8HswDC8+RNMA3TmwYzDgntMh9pRIaS3Zk/oTJ8c
         M/GCV9ZgPS0/ILhTMWLkTteUw0gch6bfn+uRUOHaLj3VxPvXxGTlvzVW8xG//yGL5V2g
         hRLDD+6WevvDU6wHOF5X9cL6Jn7NtRLRbzcx92ZqkqqS6TYMlAVCaxNc24zAMyKLCYQp
         WggGT22XPHjc8majt4WDKVY/SGsfz41gT9eiJyNr3+6VwuWNpeEDvozC3bixfI9BJwC5
         XT1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788482130; x=1789086930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=frzNhQSteSDys2/ZOWWgAmq0ecP55hQGym3yBI7s6zs=;
        b=UlB8TNX8useah/0RCFqkgFZIV1Qir7qAm7MYNuyLColl4lHsLkJsIq9/zfuHS6zJoh
         sswmu+DyF4Bk+w+pxwK1yrGBXvUuj2ZgqamzxYJQWCuKqmp4eyasDG6cjPxB2a/JOfCQ
         OnvDSfeVB+czFqmpCPDXpNJvT5DBC8Dbah5KEdI5ATTMSUAWnWYuPPhZLHK4VV916mbN
         oefWwus63EHI9gIST2KdHqYo7nPyW5TI/AGNKe3n3pgXt9bHE9REVbiDKN4EpgeKnSi4
         HYkn+HFsJWTLGWtkHZPoz2fErSC3eCQVJ0u7+by/odEOzTq+geM9yPf2pzd7o9qbqrPd
         OcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482130; x=1789086930;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=frzNhQSteSDys2/ZOWWgAmq0ecP55hQGym3yBI7s6zs=;
        b=FU+mU5XZn3iZhL4WRA6naxgCzx+GysdQujNBTd+BvjPrdnonArjATke8wFngpd1jdC
         AUICVZvJpHrayT5d0j2d99QwLjPXR3Js8uN8WfwppoGL8ESnVLja7TLU9HMuah4aNx23
         GJeugcGmcprJgopXf6SMxh4Lb9YbnnJ61H0wbKf1U3rnuDAXxbV6JAjhmTBuJT7HhUbq
         Fd+jyBK3wYgS9PRaRdTNZUctnPzY6R4VvI1Z3+Od1jwVY15/ewPOhMrw0AQT8Td6sGrd
         WKooPy3HzKmmDnBxg3gx36qKTZaevfY10SSaGOnUMBDHsjSvLMQqTTZPxYPxux90ecSx
         DBRg==
X-Forwarded-Encrypted: i=1; AKwUvBy7huzLwlcTajPCj3e1kxlaVnEKtljdlw1+GgOSkcGgC/u7srrCqgRvTT1e/+Uo1BE34w7m4zY=@vger.kernel.org
X-Gm-Message-State: AFuF++mr8OfyYqNXWPXTR5nweTFRpb/duUx2JAnlqjT8RJgAImVmXFZz
	O0wg7ET7N6YAHf2l60vwaObTDeoqi8O/8wPO49dj3dOfIUOC5dVWM8rGEYphOW41CcpWv1VlEbP
	aLWeIB2src3SzHWK/hXUgJli3+XE/+qC+F1oEgKYf
X-Gm-Gg: AYBFou1NmHoPyW8olxJIoV1VxlxC8LS4bRp/1CBJjN6Bj8DKwDP9t9LF837D/5u4T4J
	RmpdRCNno81sGeROtKH1RfugE7JZYZegrLmG43R8cCK0RYZpfYCtXqdR47IRC1t00fFixlYjbpX
	E2WcpjmX5HkgQiu7aJTCac2EFCZVUKF1WwOFl+C5Gt7nf+hqHqoh1npqIRj8PIpUcr3PHIBFlto
	L7Ld9Cnrf4c6c4VYgzz7LDGM9psnKhIY439JcdhUJJN23pAlGm88oe0V5uVA4pwfGgMXI1TQ0mG
	750gEEsDCzakHHKeledi8GpTy8FiUBAs3iuzIBOUqGRwEwgSY84NDBVkxLLbGr4A76SyQhsXQu0
	r7Wy6351SXajwZ+NDmB6A9wTfNKz6VevZfCD0L8y6iAxIatIJsN0NFOEAGwUaNXN0PWaF
X-Received: by 2002:a05:622a:13d1:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-530549f8dacmr25714951cf.40.1788482128968; Thu, 03 Sep 2026
 17:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-1L5H.v1.20260903184552@mojatatu.com>
In-Reply-To: <QDISC-1L5H.v1.20260903184552@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Sep 2026 02:35:17 +0200
X-Gm-Features: AcwNN1WZ6JtfBewsjSnHeZkprjED3AmjHmsOyjvG7B-1OWmURvRIgA8rmFLdJJA
Message-ID: <CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: codel: bound the dropping loop per
 dequeue call
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The CoDel control law schedules the next drop one interval/sqrt(count)
> after the previous drop, using the configured interval
> (codel_params.interval). For very small intervals the scheduled step
> rounds down to zero, so the dropping loop in codel_dequeue() never
> advances and drains the entire backlog under the qdisc lock in one
> call - an unprivileged user can trigger a soft lockup this way.
>

...

>  static bool codel_should_drop(const struct sk_buff *skb,
> @@ -156,6 +161,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
>         struct sk_buff *skb =3D dequeue_func(vars, ctx);
>         codel_time_t now;
>         bool drop;
> +       unsigned int drops =3D 0;

SGTM, note that this line breaks RCT.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
