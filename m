Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91564854E4
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328473; cv=pass; b=ggDCWjDIUnlI58rGIarDDyB7PfqKVEtbiVsygUGWc05EsgknIGsLpiVl8OBsMlIZHAIrSAd/QxjSa+2xHPTDXWd5xcKy3AHyqajWvjeMoJsWv2aT3eRCqyOoLmLTPQcXwhKyQX/o2JUTm7pw9+77UYI+U5mfJA+RoiGLwzgQGp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328473; c=relaxed/simple;
	bh=Z5q+rbktykD/DNtdkcPWya6lGy9YBgzw4JRv8i9v1WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6GwYuh5mtc7VqHzPheL5HIIo8clEcO5qSbqAY83xBtHxs3D2j41XARPMsq3CHjXalCVnKsVvMQyHmCHICSbD+f31bPB7IJg7JTYCV2IA1BzsHYxxsljHZyr0zt42zbYOKHzA/HTkoywfkzY6q9VtJhzp8ATeJxHqcnj1+RUC5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZSvnyve; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZSvnyve"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb767cc71so7662141cf.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 02:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790328470; cv=none;
        d=google.com; s=arc-20260327;
        b=fibKPyGr5d6XJsMcuES4Rp1prVcmtz3grMosE+JOW231jErW9jLUyXnAWv1PFh/2O6
         lJV1WJ2uxeBShYY1po3wr9p+pY01N1WfHlvWstih8axeLzOIzfTcuD67cGpCCgaRZTWo
         AuFC662D207Hj/8jzQDnsRH2X+E/5ab/XnYYE+zmTigL5Pkd9BdWTYPMQX/G+zQwX+rp
         A/TQ3q2yp5OcHuNgZdr8gXm8ucCPQQYN3UJ9x4MTOcVeCitwkffhUnsCIdEgbTDrRvsT
         kHTsY1PAe5FZfnaJUAJ3eQx8VS9bGiJd601L+dSWaPFpK5ueFKrFY5FVgMkugB1aY2Zd
         gH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8R69reE7bCSDEqOYnc8T7Z3wrMNCm63YNA9ekTLLEBM=;
        fh=fZWAe9bZu5yqwHloFRy3PyQK5t9IpE6oPCAJ7rMoJeM=;
        b=f2wRIb7RdRJXZvowvLBJZC2mC0oIDVC+t4Hq0vrwFLJd/Nh1fKGDXD0L41+YBXpDDH
         UrmGS+cdrgNdSdPTwgLF83oI9YHi0hAr2Mcyck7WA7VTm7VvnckKYxb890lUZKV8bRPc
         Xq3w6P8YA6pyzK7Bh2e/EQkV279Kn12gHVg3i9DO3pwesQkPIDuhjxtUzB09YTOVenVc
         kKxXr6PWqOp/NzmGssazygBiAKHZDYqeYLhmjqiOvzzxtejyKwiGOXcUst6GecR/jykv
         /QnJfTtkcsAAdNbFGHCqRW7zGY3ScE8lvHCBU/vsYhVQSv8TGxcwonRSxNtcopDwwTaL
         HxTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790328470; x=1790933270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8R69reE7bCSDEqOYnc8T7Z3wrMNCm63YNA9ekTLLEBM=;
        b=CZSvnyveCaw1wrpMf8iGmN/NXaUnZWnVvTT6yXMarP3CZydtnNicmiY6QqNSdNQo3a
         Lbp9+hC/XRjKB3mQ7/R+czvPZAjGrQo0Drt9p3zZDtu3zRL5ZrX4uCzOEfLWTjxSovJ3
         uFUAIA//lA2rUJtE+qd3DLZCoRhXZ92o24T1I5WsUhMoUIYb+EwM2WvJFEl8eNvfIcI/
         F6PGk5TffeuhkHBowjff9J3JxklcpZG6JewwownQOAl3YLabW7tDxlMIu+qJQnF22qcg
         PdGE7hOkTybrBNI7QiNaRMFG2OX8G++SJWCXO3R1NzkAHkT4G/j7sb9Xu0pc2ZM4ViP4
         3vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328470; x=1790933270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8R69reE7bCSDEqOYnc8T7Z3wrMNCm63YNA9ekTLLEBM=;
        b=skRfTuo07Bdf0pUaGag2KiINZ75cuslXm+kno8ZKqdl6JT5P8EXiDLHseoST9oRH9p
         2FZVZOEfGX27A7UGwjEigRzOUchpcfwqbfBp0sXZo71S8hbhfMIA1U298IMXgG7Fnfhg
         ELPRq7+4U6a8QkEA0Foc+0TJZGu0XcHtrOD31UhNvYV9N7CmmOH8DI2TqrjWwdPJi4h6
         cxjmYihbpcrdUpRaUmCWYJpkFQKTgNv41fzdEHjeDDi+LgFDCF4K8/TEIoJFYzPlAbl/
         bHcCMKbmYSw6owG+awAD+Iw6XpmYs4562cGD19Zvtba16CrGZnqz3Xfv3yWGfDHonQPl
         LM3A==
X-Forwarded-Encrypted: i=1; AKwUvBzeaeGpcctyms7lHmLOAM34JWd61tLIxTsUooPFN37L0FCbWoERkIguZZd8PGvzgnve0d8lnrU=@vger.kernel.org
X-Gm-Message-State: AFuF++lvP1qlm+K467SAUAWqgi+GuNxveIllEqI/rTsbPscT8UMgffL/
	K1jkUPhNLHaP8+V6G4rNONQFlDH8aeS0crMrhke7dUn87+bknxw/iZvZ7cYnFrHnfsrnzonS50K
	/ZeWKcrfMSUm4ZLuuxeYQtwmcI2Gwt6Lgq7mI2ia6
X-Gm-Gg: AYBFou2nNJRdXCQCR3EnLJlrnLNl4OBkafHq/FQT4hwHdmMBASfAE2xnZKC+LzeupoC
	fQqB9mKcbgmFHy8c7lYsGzk5p+YuRIQxpHnGEYwcnPPYcHGraw/7T8PBgX6btNEW6jSVFTbEH+j
	CIfG7TTW2jME9Kz6OP2nl58ibw3vS58G/qnFAYBfadS8BaSu8AGDVv6Ucf8bU+/eLyxXJO98hos
	1WjIOI9zOg5KNMi46JSIMrcyfe4UEt/Q7lW4F3pJGs0MDv8e2P8vPSibTw1JZ1PxbUxCx5/R9xC
	bYciE9Rk3hf7iBb6fqGjI1cCx1WaVXrtJHBHoT6AZeZ2yDoQ2UwU0tvK6lO1SXjKgNDuQ5RoWdk
	FzJ7qOi2Ka3GFDqIDUbk3+mS4xybLHm0WOptRQhdCMQpTreLjCNlDpMJ1ZRrexfOGSAEC
X-Received: by 2002:a05:622a:1106:b0:532:d202:3280 with SMTP id
 d75a77b69052e-5330b5b173emr36157521cf.17.1790328469712; Fri, 25 Sep 2026
 02:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923035217.179102-2-edumazet@google.com> <179031917882.2160803.2662236543443790926@kernel.org>
In-Reply-To: <179031917882.2160803.2662236543443790926@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 25 Sep 2026 11:27:38 +0200
X-Gm-Features: AclHuK8-2Ms_0eQkIj79IJ8K7ChjCrA_yLacd7EhkxPo8gkOYUm48iWk7m34Fk4
Message-ID: <CANn89iK0w7uLcJCk2_eSMOV3-e-nk0f2FY_rZhH-gsXUzgWSoQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/5] ip_tunnel: do not clear the active encap
 before validating the new one
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	u9012063@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:53=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch only fixes the case where
>   ip_tunnel_encap_setup()/ip6_tnl_encap_setup() itself fails.

Right, this patch is only about the memset(): a request that
ip[6]_encap_hlen() rejects must leave the tunnel alone.

ipip, sit, ip6_tunnel and ip6_gre changelink handlers setting up
the encapsulation before validating the rest of the request is an older,
separate issue. Fixing it requires staging the encapsulation,
as patches 3 and 4 do for ip_gre, in each of these drivers.
This can be handled separately; v4 states it in the changelog.


>
> Pre-existing issues:
> - [Medium] ip_tunnel_encap_setup() and ip6_tnl_encap_setup() update
>   t->encap.{type,sport,dport,flags}, t->encap_hlen and t->hlen one field=
=E2=80=A6
>

Pre-existing indeed, and not specific to the encap fields: the xmit
paths read o_flags,
tun_hlen, needed_headroom and friends locklessly as well.
READ_ONCE()/WRITE_ONCE() annotations (as started by 88b84cae6b94 for IPv4),
or a consistent snapshot of the configuration in the xmit paths, are
net-next material.

In fact, my plan is to convert everything to RCU.

pw-bot: cr
