Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A13E1688
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957428; cv=pass; b=kD280EwYItlefy5CG26XQb34m59yfrZVZ8OzPbWP6juwtZiYLPhnOdWHFeuBWXhLlIvTgrRNnUT93ho5MOUpMT+TH3QSPaPNpPeZ0ULVjwnh8aInCKuKXslHRGy8qJZQEcpQkcUYFuLfppjkJXaiPJ1oDxnzfp/AkgHm5/0YVB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957428; c=relaxed/simple;
	bh=vAGc6aYy53n8Ge9kSp0L4eR4cVBIMAXOr4qdllGJ4L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSlSky7fhfasLFHDMcNbY15cCEZEy7wODP92ZxjyA4wHgAMAA4TwGfP9du9LOJDnPfnL87kr1Aq47JhsAseUNLhCrUNw33df2YGerZhykafZMqNhhSfCjwBC/1bIYSZHaMPfbG+99ZYRhgijRS0pvYgjlHeK0iD4USuuhsCYoIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqiCxx3D; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqiCxx3D"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so9403801fa.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 12:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957422; cv=none;
        d=google.com; s=arc-20260327;
        b=i8Bowqj2BUM/kwLXhPic/2U1Eu/O3n9JXU+aMTYOxkGz0pUYOo0qzbHbzKK1QGwInj
         S+dgpOQfbiF+5Jstlwdo1vrc2+o3VeITqub7eIAmzAjH2ioppl533u7NZyy3cfHFdQJK
         0+gmrNE69nZfqepgS9bkglSRRC6o7DW3qdIC6ZI+fTuzwLp4OoihMacQI5+kYdf2TSLD
         YOoJI5fQcw4PAps3iSwH4ELg/5J/TsMoFxSweF7JvIf4Foe1nZL+HuMudCHK14ZT8qFg
         AwXQHuvJbX6zjycCevJK5wGS3Uw9C29GoImCUz8GynrrRquF7RwhdNlv452BESZmq/j8
         ubeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        fh=+pUl6xHxUAUHF9hJwJKpFIN4Z16F/qenn+73g8wSWe0=;
        b=mIO79Y/E/QsYBa34hMDq2bErF4xJkGUutXTKbUGG317Iq7outqZNoOpL+fhvuTC/hh
         cDFTpYtpQS6L1wBJR3ns+QZ6wFBzvBdL76ZNv7GnaRAd2UFZ9mWBpdpxrnA7By/DFVsB
         DpuZxC5QOBoh/eMUORcGBnddfrqiV7DApDhs3RwD9ZOA+uwjSo3moIIZP45LbL34O48z
         xNJw4U6KrOvNe9S5ryeUPtfY6PEXBkqt+Q312VtzqPdsGGAIawts/+Z+y40orZwZAdRi
         O/kWfWEcmWuZakmJgVVzQ+9kVTPKSCSAXeY1od24YkotaMaixXLMTBpTGeEc+tzhij10
         yqWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957422; x=1786562222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        b=DqiCxx3DiTaycwe7AdZtoPwcpH2Pjb6vGcDysi2Z5gmyJ0HAE4MzwObahewCbTGuYB
         pxFM08wLxt4+RQvjmLRVSnFuMNXwUlQos4d9dajUup9wcZ83pLGq6aJrlO7Ew2ZwCptd
         QcyWR+s3xKKV+FpJoH7z5ZEb4tjMjX8VP1Cccanh98THWVPxgoj+rDH8Mtr40AGSmtg7
         TM29Kxv+VWkfaR7MBWzZDS+NQIwwrfMGLvoYf8IVUPQlUeP5EjzQUtr7lCuL9oNmQfS0
         AgC/fwweAN0pbPzO0VtDZN8K8zDHkWMNxf9RqR0Cu5HAZXApTA4kIJWT7NTHXXRxs5N8
         sDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957422; x=1786562222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        b=OsXd4JQwGKWoqFH6tgjVpG4B3yipgEM6QjIYyuO6R7B4KnccctVx1Qu6XC6GIicRPk
         2O6CNAoX06LjhbOW9DkX9k0LIUEHkGbnAvmaStiLqZMf75fBrfo8Omv+1xGxKPR+3vZC
         qs6lcWofivsyML20BA26iOGhGfCueg6QI30VnLgXuQdjVNQSS6hCv6Se+h3sDUPuvyxY
         Lsv2+JWiQHFYQpuvNKtrLT7uTo+Dgz5RHpqgL6E0obfH1K7YdeNzG8sfXB6TTqY+/Umm
         MdFCpnh80JIVYC/07OFuPUZFWhvQF/RnipLcdswAwl5FgLzs82xkEXJHSIFSOflEWxFs
         wyVA==
X-Gm-Message-State: AOJu0YwQncN2PI8UdO3HaS6PMqDhxYcLcP3cRQQZUbHos2yG7jUurHkX
	Mt4L7MceJT9/H8MslCH0r5NcARijwvHfYYb1SEQde29MuNsqwLe6aYEwIvyHLf86aptY4MekxuJ
	4dcgHP93spwUXRYna7Lrtrm3k/yUwOJyDvgPYDcfp
X-Gm-Gg: AR+sD13AR5qEh7k/+JEeqJw9nQ9W7XsDDW6G5i8QKWOm+PooUHVDzNADv0S/A0jWSi/
	1pZlcFMv08LYP2EdvVyGxIdncfe8nx2pGv1Mm4F30LVrFqLJmD22h4KG6XISHG0umSZKTghWrEX
	EhVnysJdiIHQl5tivOk/WgghCuPo4TTmLokxo9yVIM3en3Y0yLSiUuqQu9EvSFwIxzNipW/saMB
	oPRjwZ3om08v6ObsZyH5m63t/UB0hshn5XBehBfNMgFC+KOLAVjSqfs6n5dRuQFyUI85aOGMoRe
	SHnkcWycwXeLOjASGM08M1PwhCIUTU1PNiyuc/m+/FRn9JwbqVbsvAOsce9hJu/5Ezm7UMcPUn8
	vIKPGFOR1pLL2AfawJFDJus/+Vqoq0drpah3PTBg0kBZ/s9Mwg5VAch/u5uzzE6BfQSRtQ/QtYz
	jWiv2H3jFoX9EhNTKf+2Uzz0u6Lfk=
X-Received: by 2002:a05:651c:221e:b0:39f:bc94:eba6 with SMTP id
 38308e7fff4ca-39fbc94ec7cmr11124031fa.14.1785957421590; Wed, 05 Aug 2026
 12:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804214406.750710-1-tkjos@google.com> <20260805011006.stable-0007@kernel.org>
In-Reply-To: <20260805011006.stable-0007@kernel.org>
From: Todd Kjos <tkjos@google.com>
Date: Wed, 5 Aug 2026 12:16:48 -0700
X-Gm-Features: AUfX_mw1nkkw5kkLj8bI2FW2wAiOLfVkEzSktWrAkzdsdv_wgjivU38R77dZlH8
Message-ID: <CAHRSSEz69qwV6KzFuhU_cMq3QDBAotSvGrkW-rpHWWubpqqY2A@mail.gmail.com>
Subject: Re: [PATCH 1/2 5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, kernel-team@android.com, 
	Lee Jones <lee@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com, 
	Xiangyu Chen <xiangyu.chen@windriver.com>, He Zhe <zhe.he@windriver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:13=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Tue, Aug 04, 2026 at 09:44:05PM +0000, Todd Kjos wrote:
> > @@ -192,7 +200,7 @@ static void sco_conn_del(struct hci_conn *hcon, int=
 err)
> >
> >       /* Kill socket */
> >       sco_conn_lock(conn);
> > -     sk =3D conn->sk;
> > +     sk =3D sco_sock_hold(conn);
> >       sco_conn_unlock(conn);
> >
> >       if (sk) {
>
> I think that this hunk leaks a struct sock reference on 5.10.

Yes, you are right.

>
> Unlike upstream and the 5.15/6.1 backports, where the sock_hold(sk) sits
> just before sco_conn_unlock() and the upstream hunk deletes it, 5.10 keep=
s
> its sock_hold(sk) inside the condition:
>
>         sco_conn_lock(conn);
>         sk =3D conn->sk;
>         sco_conn_unlock(conn);
>
>         if (sk) {
>                 sock_hold(sk);

This reference is not needed in the new version, since in we take the
reference above.

>                 bh_lock_sock(sk);
>                 sco_sock_clear_timer(sk);
>                 sco_chan_del(sk, err);
>                 bh_unlock_sock(sk);
>                 sock_put(sk);
>         }
>
> So after this patch the function takes two references (one in
> sco_sock_hold(), one from the surviving sock_hold(sk)) and drops only one=
.
> That is a permanent struct sock leak on every SCO teardown, reachable by
> any user with repeated connect/disconnect.
>
> While respinning, please also drop the Change-Id: trailers from both
> patches.

Will do. Sorry about that.

>
> --
> Thanks,
> Sasha
