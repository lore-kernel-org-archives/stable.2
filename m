Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F2391E5B
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187523; cv=none; b=a84HDykqsfi+b1wlywRWPEGOzAu1h9Az/l8387+o/HEwRPhrwoPDA9it741oHtREljWG3bJs5BZavCbav0BvFKsjqbrqQ15AlgU8bPPL/OUa6oRpL6vC5UI1AU3HkBVDLZ3Tfg3kPEevMqrwNlv9/xaZV/FSUozQP/1OjXr1YCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187523; c=relaxed/simple;
	bh=41a3iuO+huJxoxMGJsCT4Dy+b50HndDEMfSNL2/q1EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnmOFaxaTXH2/zQHhjAEOjVBi9IBU1P9nnIvwPIHZBsgA3TcG22fa3XewJyjcYvvDUpBkoID6y+8AQ8NgGpo+/opmV+P4QUOTfIywKN6a4FCjWvNzNQUJjEO1qHx+3wLbfYWev15mFs97Wcrr022zr6QZ0cDFsF/wvLdy9T74Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fLU9ZsQl; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fLU9ZsQl"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-66077e90382so5283833d50.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 21:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187521; x=1782792321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDO1EjOserhoEumGoZsgGvMtUmxYpLxXPf4PmQTvf4s=;
        b=OIzpdYRt5VJJUAdP+K7mjxj8rh2fF67embUfdeSGNeW411t/Qltdd/29Q3DOuvxK8W
         CJN7djBQbWfe7FRsiwwT87HeuDJfX2FuFKFgLi3IjVc7chyZ1fNDJDze2ZEEnGGMZB6Y
         dlmszQQKl+K58XvP27kAZMaR1JjH6rGXd3S/7MTBpN+2G+EbSve+CByLPANvPj1ogk6S
         yIXahdYxSZi3Bega1jdej1i5Z7e6ZaojPEqpTm7TKOMmi6mFKnx+dyeub5oxTc810YLv
         1Rdst8Ra4FbBUqlpbQ4rb9ZSAUFMJZi8/NwwmvR81tiBnUm1WZ+ao2HuvjqBDBSnEYLu
         ypdA==
X-Forwarded-Encrypted: i=1; AHgh+RoGVC6hlO+lV83OpBERioo21mDZus7ofVG4CGrd78G2AjWm4Ihe47an8LHguaUan/G/KvFuTVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUIVJEIQRIZ0cckKw5E2yt5hYHuYnrWP7mD8whNK4uVM/4ooX
	/xgnKwYNRJZMJ/woToek0nefYIYE6JVJZ2E1RhJJO/1VdM+wxZI6OFyp069q7u+O7gyzKL2yw7G
	M7wAStKq5u7XsIglpPpECfjW6/4QmE1Gbvd8PwI9St4aICTzm5CJorNS0EOMgqVGyVj+JWOdqjb
	S84uFJs9B5ZflG5TCrFgWzzdtNTG/U0h2xAP5TUP4T7YGbRfT1sDTwYbIP+5wEr2we52FjiOdX3
	t1kHp7lyRg=
X-Gm-Gg: AfdE7ckXYZkyIpQNu/XjQZBIuXU7orwD9HJVuyxnX3N10WxoLKVOJ4KfYkWZ3bhf/h+
	49MCNmtmZ8Q82Bb48E/MeVH0WCVbg9OL2Eyph8mBOn55efIBxlq83RWIiJTRGaM1NgXT/duaRjP
	9Y7kCml7LoTLsdT3coqwfNjNRneTEqkO9iG23VrkAgMY7J8l6xjP2i3umwsD+S0CPL6at7DdjjC
	QDqYRtpcSqUGbVq1QLkpe9FQgX2pHbSItdEhMBObIxsnY6jGJFaeYFAdpWe/zd6hrr6gMjgnHQV
	c1P7E9mL/zJ8rYti0cilGkp6DhAZHvLdeWuLFoYCQsjqUNZTJaEgA240Z1gNiHXi9DjwZ1s0KRt
	YF7c1Jg5EdctE1lhiBEwoL3NkaWmd72XL+6vm93hgTBb3vFbjG/LDBSek5DMoOEEIKdCf42DgkR
	75vmCNyg+PfGw4kyOgZvuGDxI3fNM+ldBHV+dqkvq/ZoMV8g==
X-Received: by 2002:a53:e23a:0:b0:65e:18a4:3021 with SMTP id 956f58d0204a3-66312f9247fmr10272509d50.52.1782187519517;
        Mon, 22 Jun 2026 21:05:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-66314a8e3b2sm596888d50.7.2026.06.22.21.05.19
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2026 21:05:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8453e61d6f0so4091307b3a.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782187518; x=1782792318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lDO1EjOserhoEumGoZsgGvMtUmxYpLxXPf4PmQTvf4s=;
        b=fLU9ZsQlscxVBAPJU4YNYw4+uYekWi1c0jlEGRmPdi/gWMtYLKAHiS7+EPP5ZrctfO
         L5Fm0ADIPMbHz+9+WlUlP0mf5I5E+En+9hhQFgxfl0WSHEUnGLrG7U+FoY9laQNc7zX2
         cG4ISpr2I9sL0+kHeLnDmMOR+zLUXAqIybK3g=
X-Forwarded-Encrypted: i=1; AFNElJ8mpGAUrjKYOv9DACnI/wIR1Gx+bYRS1zbSS86FR8T0/Zp9B8GahfR9A1CcjgIQTG3Dg7Ozv2s=@vger.kernel.org
X-Received: by 2002:a05:6a00:10d2:b0:835:405a:7e72 with SMTP id d2e1a72fcca58-84562478e8emr13197836b3a.11.1782187518174;
        Mon, 22 Jun 2026 21:05:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:10d2:b0:835:405a:7e72 with SMTP id
 d2e1a72fcca58-84562478e8emr13197800b3a.11.1782187517678; Mon, 22 Jun 2026
 21:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org>
In-Reply-To: <20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 23 Jun 2026 09:35:05 +0530
X-Gm-Features: AVVi8Ccmh_ztCIeVp1GzlCl_L5WuCrm3B6soK9sMqzxZ0b65aO2wXvoBkhfEEN8
Message-ID: <CALs4sv1pZzgqiL9c0rqXM8Ck_-_oCBaEUKsrRgC+Kx3zrprO7g@mail.gmail.com>
Subject: Re: [PATCH net] netpoll: fix a use-after-free on shutdown path
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Amerigo Wang <amwang@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vlad.wing@gmail.com, asantostc@gmail.com, kernel-team@meta.com, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f7a82b0654e3dd4e"

--000000000000f7a82b0654e3dd4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:31=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> There is a use-after-free error on netpoll, which is clearly detected by
> KASAN.
>
>       BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x3b/0x80
>       Read of size 1 at addr ... by task kworker/9:1
>       Workqueue: events queue_process
>       Call Trace:
>        skb_dequeue+0x1e/0xb0
>        queue_process+0x2c/0x600
>        process_scheduled_works+0x4b6/0x850
>        worker_thread+0x414/0x5a0
>       Allocated by task 242:
>        __netpoll_setup+0x201/0x4a0
>        netpoll_setup+0x249/0x550
>        enabled_store+0x32f/0x380
>       Freed by task 0:
>        kfree+0x1b7/0x540
>        rcu_core+0x3f8/0x7a0
>
> The problem happens when there is a pending TX worker running in
> parallel with the cleanup path.
>
> This is what happens on netpoll shutdown path:
>
> 1) __netpoll_cleanup() is called
> 2) set dev->npinfo to NULL
> 3) call_rcu() with rcu_cleanup_netpoll_info()
>   3.1) rcu_cleanup_netpoll_info() tries to cancel all workers with
>        cancel_delayed_work(), but doesn't wait for the worker to finish
> 4) and kfree(npinfo);
>
> Because 3.1) doesn't really cancel the work, as the comment says "we
> can't call cancel_delayed_work_sync here, as we are in softirq", the TX
> worker can run after 4).
>
> Tl;DR: queue_process() is not an RCU reader, it reaches npinfo through
> the work item via container_of().
>
> In reality, we can improve this cleanup path by a lot, but, given that
> this is targeting net, just do the sane path:
>
> 1) set dev->npinfo to NULL
> 2) synchronize net / RCU
> 3) cancel_delayed_work_sync() any new worker (that potentially showed up
>    after the grace period -- and should exit soon given they will see
>    dev->npinfo =3D NULL)
> 4) then rcu_cleanup_netpoll_info() -> kfree() npinfo
>
> In the future, we can do the cleanup inline here, and don't need
> npinfo->rcu rcu_head, but that is net-next material.
>
> Cc: stable@vger.kernel.org
> Fixes: 38e6bc185d95 ("netpoll: make __netpoll_cleanup non-block")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/netpoll.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--000000000000f7a82b0654e3dd4e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBeRHN4
whHxr9A9QVhIFGAwb72kYWX3Q1Dm8Fn0JDjAEjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA2MjMwNDA1MThaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCaiNTq3n2tY/WAOJ/pfNyklHD05xYROfu389Natq3d
fFSTUwigueMbG0GP7xEPMY5ST++E28wP1lKV50hs9o6CHQ1uBYtQZvVg3gbFH3kSPOMUtNBs2x1i
n6KdHaina4JT+eGKYwn/TDbLLfbv6Qvqu1AeumdQWwWrZxwXndQdBEnXNIAh+pHvvaxOQXsU88bX
iJTp9bvMMEp560yObUkFAP+sOhwwiUXQEFoioSnwJUexYJW8JjyBVz+F49M7ZZwKiU4EW0k0yzHl
Y1T9N+Fj7KnJ59tur4AHf39E+V+nqQXji6sFkXOuwOsNG+xyExGIDZxhYLZT2TL7xc6NBJQD
--000000000000f7a82b0654e3dd4e--
