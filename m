Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3074E80B0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561324; cv=pass; b=u73BP2w7QSVS6f2qfkjfkSMMMfqMv5CzpHrOg/Gt4h/GmT+y/O4I7aZAgqKlrBp9HHQ+a8dNj90KMplXcSM9DZ/6eLHqOtBC2EGMcce0adO9NsNGr9/NKb6GU7D0gkQV9aYUrEHrn5jzxT5tt+LNNDz3W44gWesBHyw/DtMQxEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561324; c=relaxed/simple;
	bh=Bq881M2dqm6GKoOZGIh/gzGfZPXNikD/fmFhifV/8bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2LZsFVxqTYDm5j54IviBJkHqKbezfgFZ+mLE37lpe5BEz0zN6z/z0XYKN3c7Z8MB1rjFByLZfglMP7SwAgN0DryXyE9wCpoh2ps1IuPYfU1iyOQT2/b5iRXFiKG0CywsvChvj1saSkmkE0mzW+IfE+65wUDjp15cfi3fXoca4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=aDW7G5DV; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="aDW7G5DV"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d7eso7584291fa.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 05:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789561319; cv=none;
        d=google.com; s=arc-20260327;
        b=sL0YbOSKMh4AVcGEuBVUZUmvtVrmw2E8VhAUhZX7nv8Xl1r0WwhvR0DFDVefuu+3Ks
         LOMpRZ75AhoM30hbI/voLB5Acxc5gTc6/Mh5bBfk3i/5bcDBOUg6xYocJilVWS1Az5QX
         7Z17aooF2x8mbbVq8vfN4ZcI7VGyTQOLfWFV/q13k0Ekhf64xdfNgnqJvFIkCyWtqts9
         WCczggIq6Pv9ms9sxXYTldWfYjpbbeZGIOuVIX9O3vUevL5KJYZv98afOj4OFaV5u4bi
         m054FojSNq8PH+D2UvvG0HkHDjoPTSRVuxru/3c1MNlrefAVYWBJdSOtMO1Y4Ecb5uZ+
         aqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAMMSKRtR5SkKpZeFxgDlMOeMMYKcKQW0S4EL9ByfSk=;
        fh=hP0vR/eR5wHaGjBiv9fQ52jRJvbgdZJosfp0SkuWYpI=;
        b=dGK7rs0NFiXZTx6P0vBnUl+xRpN19VgUwxKB0ZndJnlaoZfw7++a+w9kMh3RJSSx9x
         cLy3aaKDrE6fObnlEgCFe9dFWHmu7pT4HTWRqq9ReMqjdfRl9eCWkNkIZaroWswH3fhB
         19UVCOtsBLOvH58de8NV+0WQ624RuHibRCe1giiJihLNXqd675wCulqj5CcrIMYQbogA
         K7HPUmq8VflaO478nRsYe3oCJg/9HfAyAJv7Ku65pfmuO/4Dspk3pB72mBr2QRb8T/Ji
         4kFeRNiiM0J5dpK3Enw/1z18a38UGcDjuv7OqWdOiHWel6bMILmnMVIym6wEa46CqquT
         GGpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1789561319; x=1790166119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WAMMSKRtR5SkKpZeFxgDlMOeMMYKcKQW0S4EL9ByfSk=;
        b=aDW7G5DVZIZguqUQAQZ9d6ieMhNF76o1BAJzGf6emv35elRZYmhWyB4tEdqLklciIr
         5WTgpEoP8+rVGA3a33dzmcpSLqG5mZsZTimKJ+sITg1kQLeXyHkjE/2eItUNrcg97BDl
         WWeOWHaSUOMH1Inp2MjiK+ZkdyZ5+6LHvEFFBwXyAYBvN0CeRA+fLlon3BBb6slYBU5p
         NRcsi4p68+CCxatGA7iNASlxvLQ7RuCDj0ybhTHckpuvz77uVwGXsNoMywIZe3wW7705
         sFEKDwrAgaefhNNBlmNvAGnLn+1P3Gzh8SwWrPncsMUSxY9vsi+OI4Yc8u8oka6s8ei0
         79dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561319; x=1790166119;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAMMSKRtR5SkKpZeFxgDlMOeMMYKcKQW0S4EL9ByfSk=;
        b=uoM3cMjbozA+bfG59x8TtFJVyqgvByVJoiflfZOAaRg0pcJfwEsC4Bmv8XwVX07XRo
         S2aU6sppGsbhL9uExALfmiTRbiADPUMWJ7Hl4UEW5G18JZnJ5S49iPFQh0TIVv9rhzrj
         QiPt2vJTz4fnqeoNWajRwgQFm5Vn9/FCrAx5+8SR39cYbcCik7UPK7pCNXW8I29AT/br
         TgdegfeeeGwzkMDEyKP2KqMRomzfXxO74vVJ/SuXXXeS6vI6wIlEQed9qO0XMmK9cMrg
         q52xavYplJaJmeX2TRfXLkuEdrSkJKrFpwmkajnw14QVxwRnVziNu58RrW+6sNhZBQOZ
         UKMA==
X-Forwarded-Encrypted: i=1; AKwUvByjb0g5XbMCBoQuJS20mXe06kE00mm7CaGH3UAKHvOjqwjo+YLvbEAYaZpTbLHgmPOIrHpVkI4=@vger.kernel.org
X-Gm-Message-State: AFuF++ncRBQuwhOGq4wgHvgOFS2p9KNz7c5hEgUJNmy4YwzRGBiErJam
	l2IoKSd5wXe2Qoki0asTCXCs6DlHswoDJrLXiVrV021yK31uCuLJue3hXIOzjG5o0YyeXHIimJP
	a54F8VFx9X/uiTf3uOXe3vdnRA3+UnFqKCkEyEqeehA==
X-Gm-Gg: AYBFou201RXtR+0zjXpkKDDeVz6//H6Yf/9A2BG2ukxoucBvwasmtJ86ZIjmIhBKjB4
	mjDeOyZylnt7kfSB6HEX3cMTZEo6wilnlP17FNKatLbm3P0P+SpkBE/XcvLEV2OGY7A/dtA0bkv
	QAxpxhGx3VoGYtraSi9JyPFUkw57BUdDgjKmgnwU4igegJLKk5wSV8TnSFGsLPS6XBVzSkJULHP
	UbQV+lfu45FFAC+HtTGoawWOeoV+/WCCnFm0pEVgw2QvPm8S5wuUB2IgBdGPHXmQxJ55C55z9sM
	C1nbydDP5MRd60DipToa2P+L+zR/t9jLXUk7yu5kHFtcbLT7FGnAMTHKtCCwivOULW4I15xAQFq
	ixdVQc8gkviyRxvuXS3b1SIJSKNCcBalqsaVRhJFD
X-Received: by 2002:a05:651c:a382:20b0:3a5:b957:d23d with SMTP id
 38308e7fff4ca-3a5dc9c4523mr7083011fa.6.1789561319145; Wed, 16 Sep 2026
 05:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916094817.2007756-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916094817.2007756-1-vulab@iscas.ac.cn>
From: Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date: Wed, 16 Sep 2026 14:21:44 +0200
X-Gm-Features: AcwNN1Vj5MCCxsybETxa2RMBFpc8N2_N-J2Oave1MHK29JMnf2xnRGfsiC31dsI
Message-ID: <CAJpMwyia7fYUOq=dj8E2FWnrtjZ9jHjZQSBW2vwB2vRBkbi2eA@mail.gmail.com>
Subject: Re: [PATCH] rnbd-srv: Fix sess_dev use-after-free in process_msg_close()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: axboe@kernel.dk, bvanassche@acm.org, danil.kipnis@cloud.ionos.com, 
	jgg@ziepe.ca, jinpu.wang@ionos.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:48=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> process_msg_close() drops the device reference with rnbd_put_sess_dev()
> before using sess_dev again in rnbd_srv_destroy_dev_session_sysfs().
> If that put drops the last kref, e.g. when the device is concurrently
> being torn down through rnbd_srv_sess_dev_force_close(), the waiter in
> rnbd_destroy_sess_dev() is woken up and frees sess_dev, so the
> subsequent rnbd_srv_destroy_dev_session_sysfs() call operates on freed
> memory.
>
> Move the rnbd_put_sess_dev() call after the sysfs teardown so it is the
> last access to sess_dev.
>
> Fixes: 2de6c8de192b ("block/rnbd: server: main functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.=
c
> index 10e8c438bb43..2ebc2eac384f 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -361,10 +361,10 @@ static void process_msg_close(struct rnbd_srv_sessi=
on *srv_sess,
>         if (IS_ERR(sess_dev))
>                 return;
>
> -       rnbd_put_sess_dev(sess_dev);
>         mutex_lock(&srv_sess->lock);
>         rnbd_srv_destroy_dev_session_sysfs(sess_dev);
>         mutex_unlock(&srv_sess->lock);
> +       rnbd_put_sess_dev(sess_dev);

Thanks for the patch.

Sashiko has critical finding about this change.
https://sashiko.dev/#/patchset/20260916094817.2007756-1-vulab%40iscas.ac.cn

Can you please review that?

>  }
>
>  static int process_msg_open(struct rnbd_srv_session *srv_sess,
> --
> 2.34.1
>


--=20

Regards
-Haris
