Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2A381B05
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391635; cv=pass; b=nn5vVkXJNKHkf4AnSUQHprKtf6MdxE6HnZZUQHbFNEWdIn0DNcIBRai59NQ1faJThTfPGsemeGPpC/eys01RYMeZeKxZpDRm/P96H59A7OWuuDZbWfMI/BH5CD//6w8W6RGDQzvtKHdbe97SEyYZdApvLSUvzJWM2HHfq1rM4hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391635; c=relaxed/simple;
	bh=IMlaILTOkbAB9uMS/NSr16LBnXTrb/sXg3+eB26rAGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FV0x37amQJvqDsZ3/jpj9TwIUM48OPHfx2OqteDScWAWl+0j1BouKpO1IE7lp3eOgnKpJphpORVzVMLwApUcVmMYn1SVAlyV9LzpsDrpmhX7WyhEBr39FUnSRP01LVW7O/TZ8Ted/zSyQzmCu1yINzYemt6NgZ6YYNWAW52jk2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rBoQWAt6; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rBoQWAt6"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39f631dbce3so14037281fa.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786391632; cv=none;
        d=google.com; s=arc-20260327;
        b=lGs5/joeyA56g61fJzjm2iUI/hzWpnbXsXtrTYDHVaNBMI4eDOX4mPNioI7rhkb8N1
         4euSVxkLB5xbipj34kwWdA1ih/bGW2KnlGmt+GocbFvfoQatP8nlIgvwrX7GHBOwTKHr
         biipMRLiFhFvMD69EuAh87TArWZR9sJdahW+lTtQ5hyLC0zrCxpNo9cvEXiy4kvfVEsf
         aeUPPUysEqdNSlUvn49XCBYwxahWEhttMSrt57+pzVl1GTvqRPlnpQKiFo+LujVbgQBf
         /JfrdzfnsW78JMF2/jJeb/b58Ym4P6LmUWMsu0RCbtdZTdUnQk4LE1pkuy/ylH87O4UR
         6JOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0emqQgQvCjLt6dODytlsiFZWW5HrZvPVq08N33ZsbY=;
        fh=kedfbrCWU9FuzR9Pa8OidO2RRrGltVbk9tEP68Q51lo=;
        b=iH8NcTJV/gl9AmljzOp9k0Go+sz3v7YpT7+cJdZUPcJoajfmKCjh7uUSdq11nZoGtB
         ElXsNP6hhpaBjr5xsF1Faf6MqStURk/bMHD/k6e/UU/M9QMZ165lOmNXf1rJP9UXqNnl
         IM0VB6L8yQufkbYX85KvkcGD+pODT2LglEoJkhGCKaBIvS4bB0pXKGQtpV8yIsPHEuhL
         NrDIQ+ssdZRfMplEBlBLPvLuNjf2/WEPrVmlh9cBaTjoD7DxgxkwCS74C6bVB4Cd3oq3
         ZfatFm8Ir0Job/jL9bfO5nozEdIQuXTg6HuTXUJ0jcadn6M7Qg7Xt0sX+OODQe1UF+ZZ
         BHVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786391632; x=1786996432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E0emqQgQvCjLt6dODytlsiFZWW5HrZvPVq08N33ZsbY=;
        b=rBoQWAt6smLEkwzEn5bB+fm2oilNKPv+FMns8e6wPQKmSTb8sPtU6AnT+adqTlVvXA
         AFqIz4Cggm5QcqnkvjdOfbZMdeFH79ZuxFWN09jbrAqLCwWZ6Qu7A7mpGv15RHvdwTW+
         crvpA4HsRzgHLExIizkjYxAohZOj6TyQVkBeyX2Lk0mXDZs/xmAWGLavGe5+LwLSiK7B
         QvqX3NIuPQY6cp7zGLaQfDTbb8xf3ArDS9cWU1lmKArA9K8Fe/V6oXnjlEA7Ab5720vZ
         9b7fmMx86YKaLK/eB0uFXIlQGf+PaMh8NnKHCwjE4SfAuF2VuIbYxJN5byP/wqlftwsb
         v+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786391632; x=1786996432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E0emqQgQvCjLt6dODytlsiFZWW5HrZvPVq08N33ZsbY=;
        b=Ji34pgWQtVfjvDydv+aQMOg0YfmypPjzRVdGhGZDwCYSMFT4ir8UzOs7iNkhZYLe5g
         fvs7Ob35iTmJgwL1dBswy9ghL3z1nG/r+g2ek2px+118pVbVP76GcVEyq1DvCw/hKfGc
         qkp9qXA3/KZu8UCTS2CU3emMzsZCHtIEeXONs9LEQCiRnE0n+LVx+YokXDfz1idNuPIq
         QDM/7emEhlMT1jNdySPtCDZT7yPgGiW9CXl9BXhN+NgWgkQS0w/OpU0v/ne0TTsObXoX
         JzK07fExh00pnbl1/ByaU5pRCNk86JsM0DAnDHVZRU40LYMmw3Zq/NML2yTwc897zQcb
         TxKw==
X-Gm-Message-State: AOJu0YxWshaHb31PQACrZfkMr+SnQNjQK51zQQRVaEM58Eofrsi2l8/w
	sx+LcTM8Xe6K7l0gh7ISw8WnhH6R/h1Tn+di6RNmi/5Xtkz7v1yIxTLRIiA1WobPXTLJIxp3J0w
	X9Re+LWJa2ahVCaYNTQJYtQJa54bQxcJPmESV2Gyv
X-Gm-Gg: AR+sD126FgSdb2qnRF3br3z0xLFhFLniQntGfJq/hDa2TLkBklQao/bTeGHmUXltCGv
	r+/y47wV0r7eiZNgmBjYXnwfwovtJtObOUUsG8Yk3MSk1i9PM7oA2M0f1zEtqWtssWXMVOVF4CH
	YFOYPi9qdIUY0LrAYLzMx/xs37s0spijbtVYgQaRXQRXXjcSAK2uaSmE2FKwDw9HA1hxy/7pLWX
	pG8zTgTdaKQhAUXXN4OmuaGe6KDpQkGz3WPSIo1D/CUwIJuSVFgIWcni5gyjhEJH5MXsnvIHVKk
	7vBtS6T8XRmPSZ7Fd4szUrTiI1dOSJAmXu8BrI6/o58N5wkG0NFkCOGwS+gWyotv+13GP9KLcY6
	h3kJDx3UD+ZFzQ+vsJwUuqRMjQntlH+muFJuNNhYgzXPbUvyYlE6nuR2/WXC8f1uSOI2lSP5SVB
	6dwIVq9paL
X-Received: by 2002:a05:651c:1989:b0:39f:bc94:eba4 with SMTP id
 38308e7fff4ca-39fe581f77dmr25525751fa.26.1786391631535; Mon, 10 Aug 2026
 12:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807185801.2070943-1-tkjos@google.com> <20260808221923.stable-0007-sashal@kernel.org>
In-Reply-To: <20260808221923.stable-0007-sashal@kernel.org>
From: Todd Kjos <tkjos@google.com>
Date: Mon, 10 Aug 2026 12:53:39 -0700
X-Gm-Features: AUfX_mwe8hTp2BV4ZasbuaVxv45Y0F6wxFzKzOP9fJ155xfAbJTT7dUZkTz5i-8
Message-ID: <CAHRSSEwuVvz+DYUdbLc7vyCc+5rr8ZQRuD5fkLxdbQTHBYBnGw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y, 5.10.y] Bluetooth: L2CAP: Fix UAF in channel
 timeout by holding conn ref
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, kernel-team@android.com, 
	Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Siwei Zhang <oss@fourdim.xyz>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 8:25=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Fri, Aug 07, 2026 at 06:58:01PM +0000, Todd Kjos wrote:
> >-      if (conn) {
> >-              struct amp_mgr *mgr =3D conn->hcon->amp_mgr;
> >+      if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
> >+              struct amp_mgr *mgr =3D chan->conn->hcon->amp_mgr;
>
> Hmm... I don't think that dropping the "conn" NULL check is safe on these=
 trees. 5.15 and
> 5.10 still have net/bluetooth/a2mp.c, and a2mp_chan_open() calls
> l2cap_chan_del(chan, 0) on the l2cap_ertm_init() failure path, before
> __l2cap_chan_add() has run - so chan->conn is still NULL there. With
> this hunk that dereferences chan->conn->hcon->amp_mgr and then list_del()=
s
> a zeroed list_head. Upstream is only safe because BT_HS and a2mp.c were
> removed before b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel
> timeout by holding conn ref") landed.

Nice catch. Thanks!

>
> It's also missing a follow-up fix:
>
>   d38eaf611839 ("Bluetooth: 6lowpan: Fix using chan->conn as indication t=
o no remote netdev")

Added to series in v2
(https://lore.kernel.org/stable/20260810195147.4121080-1-tkjos@google.com/T=
/#t)

>
> --
> Thanks,
> Sasha
