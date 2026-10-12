Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC72BD0B
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791780183; cv=pass; b=PR5fkdFbPNNr9t9Akm1GqTEmkqB75vN9+EqEbA5YfLTtEOa9vEFS8tmD/71Lv12VhUJ+BrvXRieG/RNmkqnI8RR2xqavLq7aJYvLxYu9JMXc7ZuMebIsxLIbYwmVGMXGxqKEIGAsWZIvqDqUDK8s4TkbOyJcDsPL6BOCooZRc+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791780183; c=relaxed/simple;
	bh=A7ZOGiXP/y0XuuVq0GGeW4XlrYot3iLolJO+gBxOVkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUpB042vUHSu2LOKOgS7Q3dWP5t/1Ea67Lt7ofI/JoGZwN0M/8xkPZIjAqLeNzhVd7f6mWdrctFzs8fkY/zN+Tph2dNceJ8lpooqLGyEaNHDTpqJs5a3yI2RCciPPl+d5FpuaUfPWsknRdpthpZ9jvpPi0RLpMZMaILa9wgYuHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRrwWi7F; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRrwWi7F"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5337fa12431so229381cf.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791780181; cv=none;
        d=google.com; s=arc-20260327;
        b=mOXB5Ir/l1uyWkwx6PkyaaaesPiPlI8nOBIcdPELX+0HSWlHY+kVHGsmvtVnynldPy
         3ZD+pp8sA3IoHdnFmIfV+78zkoPy+Pfbysv8+BtehuKk2yCqeGhaW/7X+WerXN5CyW7u
         kYyKz9Gpyvh0KZrc7N9bROMxSxA+Stpb3vhdH0KuAF22NaYci1A1Q5MTkgJuiB8aeBvs
         OrKPnXnOO1S44iU3YFGPQEk5rkMqm9P59AMfrB1s6a7TzHVGHZL30QwfsCFeDrJbJayA
         YDZsIP1XNX24Jch0L6gRgvn7jpon6o5w6tisGKvjtyRElAkhEGubMau59OYq+VubTAY/
         TctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A7ZOGiXP/y0XuuVq0GGeW4XlrYot3iLolJO+gBxOVkc=;
        fh=LCJOQ0pJRLi0Sd6skbO/6bgXGzVaqfpzAXPeJz2aIOY=;
        b=j/WuOs616sl2My+c5Les3aFO4bT1LHbacc1FFM4KibLpgldYPCZogAeYzXyK+sbhhF
         BV6peiU/Y6X19cLI1GEZwgZ+BKTB0nw31ZnbQMrHBC49w2BewZXYBKtbApnwXfAlW0Dd
         WqrK3tWA/I+HrBJh9YNDYFMyYSQQQkDZlwKzrblYsfnQ7OuBFGY+Sq282fTUF1lJQ+1/
         Pe/QwdbhT36hX6kNb1udhBcZfnuAHHHIZH9AsaeJtLnYl+lI0f+nwbo/Ke/LvdSLj1nH
         6sGtHUY/q9A/ZR7muYaVVDkNkdcGc9C1ByYrgGXC+jjhVNjRORsQAKpz8W2+MHVv0/zm
         z4Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791780181; x=1792384981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A7ZOGiXP/y0XuuVq0GGeW4XlrYot3iLolJO+gBxOVkc=;
        b=lRrwWi7FcFUPHlfDXo5k7ZZ7zaKBuPGdktkUPvK2xQT1blRNakIK98soxv+hzvAjal
         mz+htGRZD2NIdcy6tBBo5ck7iDn+Vrw4YyXtFOfEb89sJKPNmpHWgRJBTHZoT8oUw1D1
         XQfmBrTl5N/5Jzmq3XsjQREf77vlJGoN6OZeiJFryOsFJ22py2ofsuoZpQCwoJ/VdSYm
         qsdG3dn4gKuRDAZdetFgcNnu6+R4lIAW9JZ6bHab8zYmg7DYSJvLQzfaYQXPaqlHUBNg
         Z5BK5sJJyVSyqmVmS7+QoAcxvup0m1LFnRj/7PrmnJ5lFyDiRkM9EV69wLURAJlrIVkv
         x7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791780181; x=1792384981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7ZOGiXP/y0XuuVq0GGeW4XlrYot3iLolJO+gBxOVkc=;
        b=k1xRYW43CudPlOkbyEwUDAjBZMlLvhK85aOCYx5IxO6EqsoUmtrHAuOGA16ZW8D0/x
         XU/K1ahVCwyNG7jXQCVdvII9cPv9CY4ZCFGT+dVeJHW3uy9+V3bTMs7UFPrdbAzPtwW4
         zmvSiUfHokPK1xcLKF/RBUZD9lljd0zJubEmsJdusStljl9UXX3ill+4L7IZFykzLl9k
         8xtC3RoWQwVkaltAb0j/wUVlcLYsTXjMm13NS896EIqnUyu9ud0r4FcLDPVuhIWZENzv
         TrSC8SZQNSZiqoeHemzf+xmimGup23r4Ds5ZxUHcr8R2Rf+ZKvsNuwxMvx4nrK5cPw4T
         kQXw==
X-Forwarded-Encrypted: i=1; AKwUvBxI5BpKf/28XjSP31c50/81uU6EDBp5ER/T/cLtWbSNHbmSvy5dY1onRPWVFqWJeYTXILs0EaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeVwryBp1YNtW9QErOsS6y0Z/WSGDVn+3Z4CfpK5R1DRRHR1uH
	lIuZ/sBBjjicmJULmyGSo8rTmgzEvuyiEoxmS5mPp6uTU6qBI/MFeeq4Qy6k3pWC8WSHF99gCK0
	yH+OPT1pdxaLNW/yXj6zasVFCEH71FU7dt3QtEe/6
X-Gm-Gg: AYBFou3uCuOEEGQE8T3Xj7tCh0Vkyw0YK1ULB10JHu/pPAeycFls+Cf66fpYIYT2+W4
	mbpAjxR3rLXmwnxzx0ZQ+1x7Z7tie6tvnhslGOemHHe7a/lGhnC30dgCHlJd4Z/SNwTIATDoLQG
	HuWbxQYHreSVtV6/4OjxVGrNKQKVCUSVouFpkeC3WPNvbfSWYSyygaCETUGICIVNS8HNfv52fQi
	fa6Oxy9zjURhm3u+5K+BYeXUuynZJTnZaWbdwONIufu27TEDzNnICdA7PW2VcI+To/hpRhJICgI
	/UqIrNn35q/p4BsZMLYDvoBgfblLppFkPxxCjbDWdZxMvG8YRhiy+55h5TiWJUore+lnjXH58fk
	Jm0pL7sgzpg==
X-Received: by 2002:ac8:5a0f:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-535b2d9b1e9mr21987221cf.1.1791780180731; Sun, 11 Oct 2026
 21:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-u-ether-gadget-npe-v1-0-ff466c55ecc0@google.com> <20260923-u-ether-gadget-npe-v1-1-ff466c55ecc0@google.com>
In-Reply-To: <20260923-u-ether-gadget-npe-v1-1-ff466c55ecc0@google.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Mon, 12 Oct 2026 12:42:34 +0800
X-Gm-Features: AclHuK9p36YBKHu5O0EITzYbC1tM5lufGULED7e72-TUQxSBC9jxELhTwbNAaGM
Message-ID: <CAKzKK0rNQ2sM8unChj7Ya76ogNoPCNQNx1X8vu1Dkg2FwRfv4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Fix NULL pointer deref in debug logging
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Faqiang Zhu <faqiang.zhu@nxp.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:59=E2=80=AFPM Kuen-Han Tsai <khtsai@google.com> w=
rote:
>
> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Closes: https://lore.kernel.org/all/89e19e6e-7ee7-4bb0-abd6-60971b7fd601@=
gmail.com/
> Fixes: ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with d=
evice_move")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>

Hi Greg,

I missed adding Suggested-by for Ivaylo, who already mentioned
switching to netdev_dbg() in the original report thread:

Suggested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Could you add this when applying, or would you prefer a v2?

Regards,
Kuen-Han
