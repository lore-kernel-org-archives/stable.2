Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4663DA5DE
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592113; cv=pass; b=bKB3Fq773Y0r/rh8Aa4ApkVCzIevhmNpPspFlUftE2CUCYdXsy02lq7jJLTeAAlp7fwiqotJUuz/6+0q3+fg2Z/TXjIbJGOOb22xLuTyEcM2ps0VhAh4MbouWqx0MvOlltABoNIno1MJBbF0hXEkA0aUmU1s+Y0HbT1lrZk10Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592113; c=relaxed/simple;
	bh=bW0qzFiTRf+DMNpOPeHr6adolSjQR8/BCOdiBi8dxl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPnDXmF6ru0sGAXC+phGXlajZwmU9ytQIDYSOh8g2m4123ZOPlrLsTXEzq/Ipc6VAXsTfMYi+iL7rwSjbXuOmA+QontQjoGto7ncSWCaeAMIqn7LsXRP3c+/n7lfWXVI3DSxGleyFRHoQKLc5uP6KyG9MxS2EyJwnZtB4FTNkqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXod94sd; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXod94sd"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ad2ac0a0a9so2790582e87.3
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 23:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781592110; cv=none;
        d=google.com; s=arc-20240605;
        b=VpM1PQ5IskwUKfW/fypRh/MsTC1oEfppf41JASPrDosHMr7Q5dz4uFzMmXoDqehido
         j/VU7yB2ma+YbBAqFz6ErKA23NbxVBK2jlZpYnLPU5mVS9B6WSKB3s4SIxfz9gkBUn9G
         NJOo41Y2JaGyhGSrgKjtSh3OpUvce1gDd6ecyxZHJkPtwn7Dvl5YM1DOF5+E3G2i5c78
         y5DN/NEvXNjcV7989Xq5Wv3iyE86vCczKlC42/IbyQo212kskNffhXio4WIVAYy//FQF
         aNzJmj/UKkrKRlXAw9h2W2UBPmQRrGcVAyCDl90JVvmJxSOgguMvt3X/5DTLOJBRTK4J
         ReMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8nYgV8UCTwvqHW+8oSFglB3WRdbirruSR5C+c6Sm+jU=;
        fh=OmfLHg+JFxxOF4tCVllYvHbbKuwm9lygxyat6zZcNMo=;
        b=glqbLOwBqm8NT/ENeHcjae2KcgkkEBn2IFCswucWdyBt+Sgyakb55B51IozEc2++mY
         dYWp7wagX/rMeCktFeX89Y/2D1zwgPHfbBLqSspUsKeFMUgvZUO7s8OC7YCm6BDSp4kd
         3zoqsNobhSUMmp23xBSW5xQwm7Sz/XyfviGCYEesjVzZRNSdiUESJ21R1A326QF05L0R
         akbt3hq7OLw8oQLBHEeU8qPPgr8bB4JZieOKEB0i3DKuOJ13maq7cEngC46bYcjmZiC9
         SAEfuOoju/ZC8g0EGV2hy9SwDJp6CnhlcwCGMKlKA1gijRDktXnVQrJg0GvqbK6diCg5
         6cww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781592110; x=1782196910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8nYgV8UCTwvqHW+8oSFglB3WRdbirruSR5C+c6Sm+jU=;
        b=mXod94sdKzC4NutNw5+zVAf9jrqBHCSms7gdXWG2jB2R6ClUYUfjHi/s98O8Sq/u35
         CsXmUB8W+4x+8CFyrJrYSR2MHCGpnLW2uSzLMj4uxFeJJV7LZylLP9HM5tmVKNLF7AjL
         Q7nGkPnasXHqZzt76FcFqFMQ3zDjT4Ixulc5RiuC5xWQ9uQsVGVW531e9ZMKUhDSo+9x
         xfdVcslxS+6UaC/NqKDYmWVrA+EVAdlS9GNf+bWQSbYxF5Mh2ffIrfsgoS/+YKMLx4rd
         /o2sEI79sT2h4WY5I6LwA72WKf8Dgpbmq/NSm46fmVG3PPWiK1bEzWtn6oWgVtHrx4ux
         rnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781592110; x=1782196910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nYgV8UCTwvqHW+8oSFglB3WRdbirruSR5C+c6Sm+jU=;
        b=Kj86gQMJEtkZnpelekD5rQEyASZTeqKWBKibwP28GYa7VdImd+3XOC9N2A1npF518N
         431l5eTDv0vC4rNBaZNuRfRvteJPgkZuHO/15mUFGNy7hoWw8Z31/Xn5emupBij239HS
         zC5+khfiLUJyOfFuf75j7dxGRlIkwlCcHYgaq1ohw1D3uqgV4gyF5yOrkIILXTMF78QV
         5/KABJiot+sLSbaGrO40UnV0Gdzgc8b2Yw7ayObkQfpranJ3LrtNHMk4HD9s8ly3ibuE
         GJbdY0JSwwDTbV07Ad+DdWL957OyOKzNqYIb7p9oC9hBZxuwYIFTkM1lXAEJLk+63CEu
         ESWw==
X-Forwarded-Encrypted: i=1; AFNElJ+CR5AclSFQIfgWsm3TwFEo5vV7uyAZ5I0oV77jxIrJaVAezGj+ouDygKoSMMiE9JjGItxygo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9Qc5FM600CaW+Eh+YZvu8MrPL/0zUJ2CTUwkl7Uak3uHDw8Y
	PK5HzWyqxiA26uXm00zAWWwUAk6ggjb6w8Slc/RV4QqsHxlT9m5u0gCYUYONER3SLqRLrjwWWOL
	6ERy7Zw/1S7GdAkyAENKdoQ1G3/2FiQT0vr39+7A7
X-Gm-Gg: Acq92OHhFFwrYX6tAMn5pc5DJ9xlaYSWbLhSAT5LydgJ0tK6ecIQXUvhhwMP5AWcc/B
	mves5BrY4F0NvMSlrUIW6w6O+72LexpSt/p39I6MbLDuNBoJL7zhdtiUlQlFnhN/LGZ7fiZJOTh
	4Cq0FXlDSHtglGBnMTjR1IDYreV3rajfjRkBpyuYPIhrnF6Zj9VVJbvS23XWyyTxI2Yo1qt8UGe
	gw6VMXV45TKot8asY6U0X2/BZhaNBHuqqSkIyYGA1cYok6EGLYzshCIagJjvMqm/Bed5o7stR1O
	1xYY2w==
X-Received: by 2002:a05:6512:4047:10b0:5ad:3035:b35a with SMTP id
 2adb3069b0e04-5ad30ddb7ffmr2812951e87.52.1781592109884; Mon, 15 Jun 2026
 23:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com> <20260506202842.1788682-2-kpberry@google.com>
 <2026061617-flyable-civic-a986@gregkh> <CAMAJAJE+w+vYwcEzkZoNDwoAC3PzJ54sGGr7s+5edBW3JJFKHQ@mail.gmail.com>
 <2026061614-trunks-outcast-6684@gregkh>
In-Reply-To: <2026061614-trunks-outcast-6684@gregkh>
From: Kevin Berry <kpberry@google.com>
Date: Tue, 16 Jun 2026 02:41:37 -0400
X-Gm-Features: AVVi8CfFqMmObC8HfQKKLMUvWwbhqN3oRCF5o9cZ8oGI-6mkSngILvbud1jtBkc
Message-ID: <CAMAJAJG3Ox-GPz+t05On6F6pJt5rFAvo2AcMW9jJmG1O4EGOLA@mail.gmail.com>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: xmei5@asu.edu, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, pabeni@redhat.com, rnj@google.com, 
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> That worked, thanks!
>
> greg k-h

Glad to hear it!

It's also worth pointing out that because the fix for 6.12 was done
without the ce7a381697cb3 ("net: bonding: add broadcast_neighbor
option for 802.3ad") dependency, it conflicts with the c4f050ce06c56
("bonding: 3ad: implement proper RCU rules for port->aggregator") fix
commit series that was applied to other trees. So for 6.12, I think it
would make sense to:

1. Revert the fix from this thread: 3453882f36c4 ("net: bonding: fix
use-after-free in bond_xmit_broadcast()"),
2. Apply the patch series for c4f050ce06c56 ("bonding: 3ad: implement
proper RCU rules for port->aggregator"), namely:
    - Apply 4440873f36553 ("bonding: 802.3ad replace MAC_ADDRESS_EQUAL
with __agg_has_partner")
    - Apply ce7a381697cb3 ("net: bonding: add broadcast_neighbor
option for 802.3ad")
    - Apply 6b6dc81ee7e8c ("bonding: add support for per-port LACP
actor priority")
    - Apply 4916f2e2f3fc9 ("bonding: print churn state via netlink")
    - Apply c4f050ce06c56 ("bonding: 3ad: implement proper RCU rules
for port->aggregator")
3. Apply Xiang's original fix commit: 2884bf72fb8f ("net: bonding: fix
use-after-free in bond_xmit_broadcast()").

That should make things consistent between 6.1, 6.6., and 6.12 with
respect to those two fixes.


Thanks,
-Kevin
