Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372943B6BFA
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784702351; cv=pass; b=LYo0FIBcH5htQaySBaE6HrZN4U37K90jlNZKnoRb3u0QYXW0JkfBqCxgWO9cjgErm8qboHYO3mes9kWCjS+r+Sr7S/vuG4h59exQ2iqZKpIfrqmsjOwCNH6a4c7+IBkX1q/iTeAuXEWtzVmHum9bW0uZLI56r7F/oZ02Tqewf6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784702351; c=relaxed/simple;
	bh=HIE37KoHMHAXC854461zGzisSjmMaHFopPnXYPxgwAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ae4uEisdKmD4M9D7NJECYBRc6naOs9qvTZMyb/YYMk6p8S99jvEEwc/dPS1LZTyx2i5mivEF7xKvvXK4QiH+UuohFZtB7Qtyhje0amJsvrPfYrct4gvpr9yeQIfcWwXOHXUtI3bxTmkCJ1Jd+r3ePdI/UdKgADX1oKHG1x9F7nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf4VhFu2; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf4VhFu2"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so19223656a12.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784702348; cv=none;
        d=google.com; s=arc-20260327;
        b=kYPEVEwIXk9Yneq9vc+PhMVhNFD2DPEJteRuY9/IT0a+feIlMGODMacA/rLTvXcgOf
         esfSdtHHzOhb2UvB6Kb+y0P/nbC3W0FwChJUF6ayOfwkGQkhuvpxHraOeRx/eI5rZ0iR
         +xqChvaqWC2FV2z/b0KWVhev7vufoRcUCcT26P/HAeNDFiK4u3cd1qW2fGa4K7YbHr6y
         l5I8zW79XqcPDBiMOEvG/VWWlCMxGyGD+zHGCv5s8M2r9ODLTfr/iUU612D2HQCSPgUB
         2OCxdhXMXKhZ8pS+cQpJCXuH5reIGRwgbXSN2ErwHq5HKo/DPI7E+xQOkHmcp9loq8Jz
         bJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HqcZEVXr35WoIysnsLw/6omkNUTAVW1DhB5S9YH6cUQ=;
        fh=JKYYp5Q3AuDq7VTxmdhsPxlfMqsWm7LjPyZ8HWinUSc=;
        b=nb43IMzDm6Nbfb4luNj52UD9OfW+vnBTIcr5sVr0u1AvArvUisRXrKFdr1S58MnyR3
         mV+IOKBlA7TsKfBtXC7XvFSFXtrALZExag0uOF+D6oxezJPtthvUTjXhDVq1OyNf7fd1
         hsTeUweyZ12qY7u5gJlskSDVcj7bdC3JJDmD+6BvZJHjNOHEBHVVc8dYXYH1A90pkBYd
         IMmIaECWWbfOCd6zr6ob25cYu/nubzfecCFAiDO/w+8QUQnVqKx0nTD5No7QRK+2MlzQ
         V8g2lJXvagrwz4sWcvi/wThA4ZyydhFj7M8P+eN6QMlY9DZk5gUOC9iR+SO3ineZkkZq
         PsmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784702348; x=1785307148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HqcZEVXr35WoIysnsLw/6omkNUTAVW1DhB5S9YH6cUQ=;
        b=Vf4VhFu2UYMOUlcUPW/Ueh3XZj0uwJ3boFbffmWxUsPyCJig2tYwPLBW0GbPtriotq
         Cm9wBA9ulcTH9HUBxQ1sz5MFR7M7TO0WhHadI7oiC1y/f4EQgpPLDG6AYXJsn956Ijmz
         R+b2D+pG7dzByHXw4ksR616+rUEW0ZSqza9QCyY782fOhbkMn43eJIhYqn7yZ4y3JWM5
         0LAHJNoqGNIulfnM6/LdAXD6IKVZGIZfWOEBD5jUwX+vxi0LaHpBdFLwU1nrhV9Yja7C
         RNlrhUyT6t3HLnFt/TljniHi9x5E60tDEV2iDBziXqBrqaP/d7U3I9jzKxKeQu70iypk
         oidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784702348; x=1785307148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqcZEVXr35WoIysnsLw/6omkNUTAVW1DhB5S9YH6cUQ=;
        b=hNagNPfUzN15Fsa05EPkGb2R0TBfa2wDMgjFDdYB1gLZB+C88Rvu1W6Y9SbrQsKY8z
         rpDCvXbcWA4HR8gbY6OWeYoMTvnnmrcfcYsSDxeEoyh1UKMjGP0pWCujD3H0pcwcRBtO
         R2rW5bCXelolOwD1POSnJlZhbUj0dmlRIWbfN3dUcGOr2rLdmpYJXK0SoPp0b70wPfi1
         H7eO8U9Af+uvqNbYlwqEGu+xqz5g1jNCUBfkBgb4L6eKLoN3Ebh2ZjINN1zXKLw3xAuk
         nYjjZgQYMSuWRsGJ7vsy2ydwPlnNGEUsIwUZZ4VHgYZiI3FXEFuWF73BWUpaDUmplsEY
         OzRg==
X-Forwarded-Encrypted: i=1; AHgh+Rrqo+2wxtfxfhMMMT2UfrL2EPbLipVP3nBaTFlgsQTFkqODa7kCnb0706QCMZvtbyD2AjY4OQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxouThDc8bxmJaMNgfAH43OtNh3eQbMYPpHieq1MACw9qCMw41v
	3xXWRYi2N4SNH98jk3+2cKdUkdBVVi3qu9Tq8qoCiIjPejftLgye677ZRjoCrVoimgHq/LyWM0B
	zrrwYFwRPz8W2yuWEYlvJQbqy+0vC0A8=
X-Gm-Gg: AR+sD11trvs82giYrRQ/bnAAVn55Sa75gotQ6Fq0+0CpVLelVIWMnbWan6mhptwS2IE
	bXfpZd16C86ZWZPUjODtu8Nws6y4uDEtuIPGJb/+rM6tN2n+KQ5vKYzdZeyefMSXXIITdCWCjGl
	QIzJiwELv18u22d09Hn75QDYv6rw10v/odQXmYfZWUOqrqFWgmNbcl7T+WCG+zUZfYF0lnFkgYy
	VoOi+6B1fnaFhJcPbf4onb9QSd9rlIxWUQVRVC152c8H5iAc+l/uBpdruzb0QY8XKWsJsNCD/NC
	C3RJbE7IoLaTDfU=
X-Received: by 2002:a17:907:3e9a:b0:c15:cccd:336b with SMTP id
 a640c23a62f3a-c16b477c675mr1073652166b.31.1784702348036; Tue, 21 Jul 2026
 23:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709144718.64535-2-bestswngs@gmail.com> <20260721115912.7438f90d@kernel.org>
In-Reply-To: <20260721115912.7438f90d@kernel.org>
From: Weiming Shi <bestswngs@gmail.com>
Date: Wed, 22 Jul 2026 14:38:31 +0800
X-Gm-Features: AUfX_mw1GtdkaM2O1EvJgyJUI-NJthQRq6sSmKRvYnn_6H4g7HZ3GMMXKVK-0Qg
Message-ID: <CANgPUi1zzByN=x8kNHMQm0Mo-_Py4E4OLX6VvNbPseNxunpKEg@mail.gmail.com>
Subject: Re: [PATCH net v3] tipc: fix NULL deref in tipc_lxc_xmit() on node up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Maloy <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=B8=89 02:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu,  9 Jul 2026 07:47:19 -0700 Weiming Shi wrote:
> > tipc_named_node_up() builds a bulk of this node's cluster-scope service
> > bindings for a peer that just came up and sends it with tipc_node_xmit(=
).
> > Neither step tolerates an empty skb chain: named_distribute() finishes
> > with buf_msg(skb_peek_tail(list)) to tag the last message, and for a
> > same-host peer tipc_node_xmit() routes into tipc_lxc_xmit(), which read=
s
> > buf_msg(skb_peek(list)). skb_peek*() returns NULL on an empty chain, so
> > buf_msg(NULL) faults.
>
> This patch has been sitting in PW for 2 weeks, due to maintainers being
> on vacation. Please repost if it's still relevant.
> --
> pw-bot: defer

Hi Jakub,

Thanks for the ping. This is already being actively worked in another threa=
d:

https://lore.kernel.org/all/GV1P189MB1988CB4E92D2BDFB80894B4BC6C22@GV1P189M=
B1988.EURP189.PROD.OUTLOOK.COM/

No need to repost this v3 separatel.

Thanks,
Weiming
