Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAA3A5433
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942601; cv=pass; b=kofNJzcGGmU4aT3a0z64neb02xeYafTkF2d9/Cwk6iCACqc8JbszkiydUOHWoQUT8NHp/WjvnJE5hwGG22mCQic4b5a/BWkytA/Xnhz2PT0ijVhusbw2z6GlD7aGsQTAHjnU9FTQXkADhESzFjx2BJJsm5AsWlLE6T9Y2vM/8a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942601; c=relaxed/simple;
	bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHw8fu0DQkNWb7CPLpu5UYDtfZHUWoT68BZhUsUPhMs/PmFXJOkGG71zgBDdozBmrAfC+vipZAlF3HDNvni8NQ7Na1LvDj4mEyGtTiCuegQIgQrPCQCBxMcsKMAPAOdMOT2XwlvUl/+hh5DISFXzfOqk4dtceIdTcdM4Pl9BW+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeIKBZup; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeIKBZup"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so9989035ad.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 14:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782942599; cv=none;
        d=google.com; s=arc-20260327;
        b=MXXkM5cYBMdT+QRAYDHH08pTV7uOfY1jyqADWXWPr4nY+dXcjirz7L9/do82qs1JUQ
         TQm3OlKoaPdJq7yfeUEq5BoYR88zC1DoYYdpMwfju/QKYiVqkMo/uvSSll+YNykf3LKY
         SQbNX8Q6G6RMUswbNkXB3nMy20OvMboqTY2r6FwfMVkrl9PABxamDA6sjJlTUKiPIHpJ
         +ZrUKnNIRcOOeN3aoLCS9Bu2oTOg4VBpYMyxeryKj0XW9tVg+fbXaYUxGaDoASoFYtFX
         3gOgEeUCy9BOlst+2dKlgSQBdmvKb5whf26ErC/f9tViLvadz78VkPubZ6bW4mHHzj05
         89Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        fh=lc6m/cmRRto5TwQf/w388wJCULtfCmeM2Wsbn1nuD4w=;
        b=sTQsQ0BzP/nvp51L/5m3c2Q1P0DfWRvdY2b9G9LxgWK6AmbEUN1RANDGmE8Htdpvsc
         48IGXgqGoDfN1VuppkYYPuNnqZZI8S8rXoXcwPThx9ryY3CC7dJNMHBOLs+hWIZ39z17
         5m/BhSRjb6CDo2XEDnMNu4Vrg0sAfo6+76jPq7W36asrY8gGURjqVLOvyH1Y+VCCeIET
         Cl9agV2wzEJ9BxqQstv3LA4MQjt1V8/Vaf57PUzBRY8WMLC0d+0noaxYOhQ0HOiEvS23
         48EXs3jaw9FPaBb8Ae3D6IZn5ip0wJsNoYa+bMbtIt+HmddR0zvxWYEdzvEWbsDPtvIO
         pFCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782942599; x=1783547399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        b=jeIKBZupD2uAFmiEql0qVzN7IsZ7fqEk7kqd3Xa8BaERaWr4+og89gsNp5WZcA035a
         ++rqwxuSPoKYVqZOKAl6tEPV1BjifyFxTsI//o6zH+qZM8QMS483DAtQrPyZecFIvAeI
         b4Uv0Jd8aD98+ylnQxMErKttre3lbD4XqRGRybrIwKkjzVvU1zw+nkclM9KnpYIOshQp
         KclDlGFZfHWmgwHqlv2JancioAwF5uQMhBqlcBGlDLeiK6xnRpJPTDdLx5u0tBgEiGSY
         wHvIrbMqOWMBIjdTrJgJ5WJUU6IX3QFIUgQLx7JnLuJp05H3x+EGriKl6O/SAwu6++M6
         uULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942599; x=1783547399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0dblCKkE57OsnBb8pOm0NmjLkRbGQhvwMz5SEGtfxU=;
        b=WMYKRJLcwn0qLQn3c9kDTJ/j7r97O+dlyp4Macmx6QP6ZESUKH/Dfnc1xq8P1HUQqF
         LgxHE5oE7PaEj6hY4L5kIsi8YhIPP3MWCMfL/3miryBxWEXAW4b3ImgIIgsAcq3F/jzE
         UUx78wUqzMHPSqu4G4hb7ku2K63moYkL/LnSlra29C1dBABlXi1YLlC/u2B8MiH4GzAY
         laGnicOywHR8Fwgo9pTuFuL4TNh2w0QC9h0ijwGfEDWZ6ZGHbGcUFbWc8gcS1eNV98xL
         ZUWsfdxsJedOz8w1SDBnQQLVsi5pIcdiUxaOK3JaooR7nHgWrnsCXB3aPp8Gkurb+s6s
         Z+nw==
X-Forwarded-Encrypted: i=1; AHgh+RpRcEv8KoEONTzrnb0pPPQ1THSr0JqukeUpiIRSY3+WKv2do0eMkI1EpDiOMdcTShZxhpuAG8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA5kNNQaPYzBr6As5X6yKuJ/i6iwLwIJQQnBS9nUq2JvJy255x
	/LiC5dqev2h7/jZdxslOSucRSC9ODtcsdHo36ow80dUvgwHjhSjgDDBrBWiPDBACfCmHdceLiCb
	2dZuw5ghpxYr6Mkx7/9fqQLrsAhsbv/B4aMRDuwE5
X-Gm-Gg: AfdE7ckmXkYuD83YBbo8fVEzWlOzuCGn4BmwMEKrgG4RfUP2UC4RlopijVwB24FI8uV
	mkBIQQHy7cNvbJgmF5w22hTeUNVEv7YyfGn7zkG3nAAPqJZp+ZOrA5pHMtLvWYEHg6RMF2hzg9v
	BcVE9xjG0hoN8PyRf4KPbsUNU6xK3c9G6dD0EM+NYPImmI1OFfVC6qMTIKiptsWVpeCsWqNnruJ
	OOGkIgtdZO4zfHERop826tDTlC/PV5OPIBkw/pSTrSiXiL4588xaQw7QRsOptlq7gltes6QJ349
	cUobuAtfLVRaU7fR5d0E2yiQasXyb54EV3VcPnZnftepIm4CJiUf55Hb89MCONKZSW9yrVbEMEV
	HT70zQ+uVut9AR/wCCp41zs6MBYpF9A6sthUBc2vgEA==
X-Received: by 2002:a17:902:e807:b0:2c9:97a7:71ac with SMTP id
 d9443c01a7336-2ca7e91c1a5mr36388505ad.39.1782942598927; Wed, 01 Jul 2026
 14:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630211808.50440-1-alhouseenyousef@gmail.com> <20260701164222.9094-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260701164222.9094-1-alhouseenyousef@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 14:49:47 -0700
X-Gm-Features: AVVi8CdoooCP65yZagy1IFzbbVt52lLnQXjOFVI1HQAUaxbpxOSVlznX-wwdP2g
Message-ID: <CAAVpQUCfzVMV4NZPnTGB7RFCxrBPHET0sxnAoO6zKuUNZaFTRg@mail.gmail.com>
Subject: Re: [PATCH net v2] mac802154: remove interfaces with RCU list deletion
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, marcel@holtmann.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:42=E2=80=AFAM Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
>
> Queue wake, stop, and disable paths walk local->interfaces under RCU.
> The bulk hardware teardown path removes entries with list_del(), so an
> asynchronous transmit completion can follow a poisoned list node in
> ieee802154_wake_queue().
>
> Use list_del_rcu() as in the single-interface removal path. The following
> unregister_netdevice() waits for in-flight RCU readers before freeing the
> netdevice, so no separate grace-period wait is needed.
>
> Fixes: 592dfbfc72f5 ("mac820154: move interface unregistration into iface=
")
> Reported-by: syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D36256deb69a588e9290e
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
