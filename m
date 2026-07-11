Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A3375F88
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783809; cv=pass; b=trXbli7Gf3skDax/tlB7UbJ60A/GxQm0y6x9dX8v/NzW7H9pP0UJf7irX6Ccc3d575mUljY21pEOFBGkvPZ+hXas4ZjvfhChDd+RFk/6GOCM85fNHp8SnzvqliklCI/evgLdp/0Xo88eDsP04k7pVT680ldjD2I7squpMAkNLYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783809; c=relaxed/simple;
	bh=VgLcjMWmevXm7ESHz2wQzgI3sAUBCb1NgNAir+5i0GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g10p2RlE6S1rGCHAJZCthhz8vRVy6vi/lOkivO9CL9Bvdaq6gzU7cRYJAemObSDK30tXocV80nfjPPkcAozKhtaTCKCN8qLnZncJEfp3LjrEgoh00gwDzmg04zy15NeadOLcDoZYPGBQJy0HXktRTZH+NC8ZvGBwoMGllHTOFE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajtiv3oa; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajtiv3oa"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664cdeab266so3011670d50.3
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783783807; cv=none;
        d=google.com; s=arc-20260327;
        b=RA1B7OiFbb5CsM1AHZ+UDsUpT+OOpFAxa9JAeNi6jL1+nUYvuoojRt8rHR1va8lTWR
         wsWOZMkqn0QsKL7TtP04JdwLtosbkbKpJIZr9ZZH8yZKkJ6YPkAglscHJ865tZc+3xyG
         d11aflL0MSOiVkZltoosHKYn1QTypr5YkuUUdyZKDeOKC8yH2w7zKlG+CQ0hGEl+/e+s
         a+f34VqAjhFppe1DQ+VQhWgTKnUV20IgB0+oCeR0+cHkhmnCJ3v44lOZeXGWjVN2h2Ff
         Wls8tghzBR5zBvzE4hc3RmYQ7C4A9iItqQsODiJtU7e6SKkL+9rxzIKNFqHD6EeAN8Iy
         MgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        fh=MYEEm3TZHVFBGJFUKAOCK8o9SwQoje9Z4+bTSoUX7WM=;
        b=n1F4xhHKhPEJ846n94W1HCpaB26c2hvuA4cqdYgpLxqyG0pfRVSmShe6pbIghi8mTg
         3FN7v0nb1YzOdZ9b2EsYaFvT8nW1L8zrlwDP3De6Gk5lWIjg020lkBZB/vn1PUu4Ntfr
         aN1VSFR2dt1iRPf7L4+jhJFBg+V/QLRO5eOBF56yD9lTXB8ZaTX6/qghKkcCC48sR3yK
         E7AH3wqVfrFYqyY0JO4Fym1gVAhkFCYjOSP4+Eax6zC634oVvagyvPt3sIdGBfjGZmyh
         ObvV5iMRPDAiRvJs01+G5j7OTgvyzf7HSJHS4j4APzFy7/mmyIJq83nNXH+G8ZR51h03
         yYPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783783807; x=1784388607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        b=ajtiv3oavXmmjMpbOwKJqH7BAIYIvgVi7IIg9dXw0KTqKp/ph2w4B417H3PMC9/sXD
         /7AgFV5NXnEXnJfPAKh+7WbIecsq+UPWtCG4gaojfi5GSUH2cpqz8ija6B2TzVkLPedg
         YMaS1tyT1o0bl+LrEeIdp2MoC+OS8I4R7jUc5dvuigIOODJIEYORv6K70pxrG9cqGaL5
         j6+DWMkz66QfbcZGznOt6NUyWwoHeFH+nDRMCkRle1kbETISrnQf2kIfV1QnJs2zC9tV
         P5umBpOZr2Vo9BpdpfGZ/qpyZVwnEQDsdSpN1ZAtq1wHgGp6WqbswLGnYM/I509tk7fU
         8L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783807; x=1784388607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+djRPG1+yP7gLniNybddU9i7XevMPm8WBoJDKoJ3OMs=;
        b=bJybGxFlKufBiUa5F1satBr7URikvD+t+Iq60We/blRJVDtPvNEXxxMgH6iqL5Ct9w
         +qlV5CvQK9+bHpF5ylPv4S+n6CueTCH9iZfXE34nHBhx7Ytx94D1dfWGlwP9JB4qnrQr
         VHQzfCqkZzh/bOiig2pNc4Mnk0U1h1Es2TXFjH0X/COKQBW7BkecpBBXEDCJ2ZJvfxel
         f09yEcnTOkTkX3G5H5z49I+KGY1FMBac7yS8CLCrYDbywUManwyTgrjRA6iCpEozDsaV
         mkyREcwiaprE7v8DnWVtsCz1/9yZ0v0/SjcXM0mDVAaCJ/gQFuQkT/ux2VV3c9sHaKkR
         B80w==
X-Forwarded-Encrypted: i=1; AHgh+Roms3XlXSzrVjByLwRFdqAJxhuvS3ISfnNAwAjPaVr16dfe5UHnJjGKKvHbJE7zdVzUi4D71Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjjVT2Ay5eilARcRf65LXDVYrsmgYythE46U5QS1BI8nD4CWZ+
	VoOmgxszOTmlra5qJgFMkEM0l1ZWX3BtPjPsfHvoIm0BJzHWLO2x86izHCuWGfvUQ17V4Rqb0bx
	KlCnZlKEGm/cwAs2OoWiY1EEY//2FMME=
X-Gm-Gg: AfdE7ckxxFL2a95ZdO7wnZkAYMG9TIdm8+OzNNboehw6/hyIppInoUiV5nkIDbxE9VM
	pxDesutYhyuBf7/VuxLSuyo6MiAp8rxzaPaaNXirjs++UEoW9gKF0coIGsxCINJBY5kk740ARAM
	PeJkJ8L2pUtD4zBTyQO0b1anoaHnvnsbtSX6rqsUuOZPNHVzcMgoN94gEMEOqHtXYbABA3jjFhM
	Lo5DQFTVd39L2DEI5qCBI0nbwAaxl40oWoopo6Od/zaRf7o1/QAXGBqIS61/9VRxh33H+UDzd5K
	9Z4LNrYxOyTpQpBPzrqBImEVR1QWehn2D61p
X-Received: by 2002:a05:690c:480b:b0:81e:4e5d:4849 with SMTP id
 00721157ae682-81e90060695mr22842997b3.16.1783783807477; Sat, 11 Jul 2026
 08:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711150754.2918392-1-michael.bommarito@gmail.com> <20260711111503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260711111503-mutt-send-email-mst@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 11 Jul 2026 11:29:56 -0400
X-Gm-Features: AUfX_mxgD_lh4gOsRso7LSqjgvGgXmvPV1lIQqbOp9oTE3YTU5O6OP4lBsiP8lo
Message-ID: <CAJJ9bXwUtQ3pHqZ=AMuwaNLs16pmujiMdeBQtB5kFc6JjM-Pug@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: validate device stats reply records before use
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 11:20=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> Why does it "matter most", or at all, there?
> Host can always deny guest service. In fact, this is how cloud vendors
> charge their clients, by denying service to whoever did not pay them.
...
> I'm all for making things easier to debug even when the device is buggy.
> But I'm not inclined to add tons of hard to maintain code to
> that end, and I would be worried broken hosts will come to
> rely on drivers working around them.

I am always confused by the CoCo threat model to be honest, since it
seems like some people care a lot about maximalist reliance on the
contract and other people are more practical about how many other
vectors exist anyway.  No hard feelings if you want to NACK, but at
least it's documented publicly now for people to consider.

Thanks,
Mike
