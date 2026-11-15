Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794741103;
	b=3eM8HmKBdkM7dJt3tZ+A+Zai9kcr8pzzol7pXAbHQN4L13YO46SXbX7FXnp5JwDj15dS
	 /c8AtxU8qBJq49AqAGkcbtZEHba4DGIBk4mVjIan2W7bcDIU7AOGMsF6M4hcXKu96tFUK
	 Y6mDG8STfxrea4nwZ1mmHVRQh+OE64GlKL8p9mMA97idjJaXstxarnB3HejnUR+7zjKfa
	 c3/43wpxYyHgYf911d2IMQvG/fcRmOWn5SQgJEqLt/Cqzj7HYmQVkpWDhHpxvJ+io/68R
	 4Pk8Hd/fxNY0SKHrprQEGBZRYlBZQdNoLFWJ7g4PeT/6a/MLZqf1V56/bRPS4VbNgCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794741103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=niupttma8X2M6tpT9/+fkvKpJUleDbchTCyz/6AChGU=;
	b=WOUjMCNBjW2pJY4WhdDny6ukUq+POR+5Iqib296PfC62rRPX4miUnQiItvvipgH2NrL2
	 oUQr5aWbYZrG46CKM1ZvONlGX6lyGunM1ApGRxw0MUEZQBfOkZ35QbT8+TB3a7ecViLtZ
	 BQE7Rvo15z+cnjFwP6tDBBnmO1NLvh6wuN/EBJK9jzW+Ps+TDrnO0dmkca/MM5QiYesPD
	 hdf6iS7xsrJY7A4S+Xt8S4a1dFXb7vYEDUTDyLyHQZzsGsrwQhl3mk7f55es5s3poEzcv
	 MOX0i2dNb5jCBMFuDbX/oZbxH5yJ1s/eFGHz1+Ix0qb3bY4q6wbqbFHuVbjhtrK7+Gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=of3jASAY;
	arc=fail smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F909606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 11:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F909606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=of3jASAY
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71ad047710aso749407eaf.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 03:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794741102; cv=none;
        d=google.com; s=arc-20260327;
        b=I8yno0awCCbLPldUPhw8hyRn9sf71vHmoE8/ftZwUNUaQjWXKV23GXxFmEsNyqq178
         XoJmvQHO7/5/69VF1rV/3NbklS4Xl4cdYF9Fzr/ep5eGUvM2yG05akshlY+bq8RUOUj2
         3Twh9+k0MydJMrctpan0IBPhnIWxB2mFupPjDgxG/QnYYCLf2lOswNTEUgVysMTsT/cJ
         k5RnzdgHC2X2hjNJW6EY41Sx5EoK9Xr1XSlh40G9jH6eRAQwMfFBnR74s2uYG25tMDS4
         3derwbRY2nc612xitNCDUcSCZrd/qoV5ATjS507wnU+EeuuRT6SFXF/FVXh5mZpGmanK
         JHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niupttma8X2M6tpT9/+fkvKpJUleDbchTCyz/6AChGU=;
        fh=P8tx0D5Wk8VuDJeHXE74xqSmir+BFJ9Xv4u9KFOkQMU=;
        b=YrdAJIC3mDHTIKVA4mVz5W9NXz52Q9QUVH7iYZP2uZfWJW5BBbT6Ocy7HiDaA9VOZ+
         bpetXSAp+0E/3uvSqQL2cuhxV0lmHmd8eEnArmWsoJAtWJqQFJDdwCEwjFHWczROZ5VH
         B3vgQeAwsdGkMGa/SqExMsz3NbEC7jHSEejJECZt8IGX7Bsn/wWFreZzk3L1+Er6aC8f
         cYZOgUxPY4O7oOEcuK8n448SC4Kvhc2KCNQ2bGAhdserpWB7cm8mXbtMm53UjaL6tFVu
         xfD8GP0x+qg0r6ekEYpBNnusV+EWiP4o/015dFDPe1pbb+wl0UBt9S2Giv23XT1abOUC
         iUxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794741102; x=1795345902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=niupttma8X2M6tpT9/+fkvKpJUleDbchTCyz/6AChGU=;
        b=of3jASAY2uRq/jJWJtu/J+egIQO1aiAxkyVYlqd8JDWFDtFgfEM/Ma9B8dkH712nlU
         FwU+6/jbKtlEGp+Te4LjsNsdHikC39GeG4Nl9n3ilFv24t3C8VTdUA9jVreMg2jF0crV
         etX6Qs1vrc1s6u9lg9S4EZP4HwAE5e4ybxFh+06r4L2XrA/e/pqm9QUnr0HVjdj0toYX
         0UeYI6CwkDYj95zh0ysL4i2peIRMgecP+5lvvpTKeZB7JzWwfBKpl+Pws08y8ZmK7NJA
         pOvfunaaFGTpvE2TjiFqAnvKDCOaHNvdi6lYP8Qu5gY/UTUJdyhnNjwXvZDIXDHxCzfj
         nbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794741102; x=1795345902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niupttma8X2M6tpT9/+fkvKpJUleDbchTCyz/6AChGU=;
        b=HEgpIbWeb5g0BpxnUbHBQl4438WOoAzv2R2jBB1FO+vm+125pVsAb59Q1izbH/vaGv
         GPHbo1hTy0U4wVo6k1VxGChdGYT2/zl0erP7hNIH/DClXKigFHoOgMEactpSUQDcdyEY
         bhMwHRiU9Urxr9OWIzy79D+qXItqBxzpgnuyJHlYVFH7g/RG2LlkdN9O/iJZCZuO18g8
         F7AtFY7LvFInY0JWvutXSbtCFfF4OJaaomvSYzNv2YFZugpwg0odkIIE1StOscmba+Ro
         jI1uc45/G3/Ue3h7ZpaQhjFQwgtIEr6/jjTjOd6nsZ63WsyyA3nZ/fwvZHm5A0yrN4+K
         dAaw==
X-Forwarded-Encrypted: i=1; AL+hErHyheMGeq18+IaXv/zz2XcEXK9A8QfZltE9WBHbIwxUeZWf7Q/e622IiQ0GFQV2sOXoBNHEzgA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zWEEG7HmhbvQdiltmNcdtT1qw+aIGkf/tIr24oUw9zEr9JPy8
	gowuGO6zF3As5TeIJ5ct7kQ5QHLL7OpCRzKu/Pjyz+VZyR3E8xxKH0BXLwYYwE3Haib6Y1mwGpy
	/COw2eiwULR0880sSg36F6AKkXspGzC4=
X-Gm-Gg: AYBFou3Fn1EbytN5vBovmETL+IiemEZNPBCuBLIkANWhAWPqCHc+Ua3CFrfK8bvWHA6
	vHlAgtuv0mCy3KS0QsS//zPTdqswdq8GwVjiHHzg63z9BIFKwqwXTOE7BbhxcEh+wUGlKWeNrcw
	TgQHry9CyRykI/L3tAFknMMV4hhgvgpvg0eQqsoKiWNiOyoFnV+GannSi8Sk18JvF7f/gt7Mjox
	V9HBG9LLGOV+An502l728OaBZuVvlXEAUWLwXF6ZGkZ9QczEZWRLCXTIiyY53VhytwIDVYygATD
	0fRY9Hs7ZLkSqCs4030oQEx1mTUWRQBvDKKmuU71If6to6cmyW7NvcD7YTKh5defXKHgRhTUatS
	+Ot5s8fSoRs3jDkv/Y+mtkubrlVrfzq2sBpq6cTFpcNfincqk2PgXuFw3gDDQ8itJmnm6UzdfaU
	p+Tu4HDmany8pn8gY54+fVVSdLHnm34YYxjelnVOtD/vl+CCcRHi4+PKBrqA==
X-Received: by 2002:a05:6820:4189:b0:716:d376:1676 with SMTP id
 006d021491bc7-71ab523f56fmr4513622eaf.87.1794741102408; Sun, 15 Nov 2026
 03:11:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
In-Reply-To: <20261115003352168cE_tyVxSyZV124AM31htL@zte.com.cn>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 15 Nov 2026 05:11:30 -0600
X-Gm-Features: AclHuK-yfkBjfTlRzPqncy1or8kBWwirdyvLakJdI7oKdEpo6iQh6u-uxa2CP6A
Message-ID: <CACVXFVM_nfkBVnVr8oEVjjTOYp7mhox7KvhkME30QBc52b-yxQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: dispatch the next fetch after a batch failure
To: shao.mingyin@zte.com.cn
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 10:33=E2=80=AFAM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> When a batch fetch fails, for example because its provided-buffer group
> is empty, ublk_batch_dispatch() removes the failed fetch and returns.
> Pending I/O tags stay in evts_fifo even if another fetch with usable
> buffers is already queued. With no new I/O or fetch submission to select
> it, that fetch and the outstanding block requests cannot make progress.
>
> Claim the next queued fetch under evts_lock before completing and freeing
> the failed one, then schedule its dispatch in the proper task context.
> Marking it active before dropping the lock also prevents cancellation
> from taking it before its task work is queued.
>
> Fixes: a4d883755399 ("ublk: add UBLK_U_IO_FETCH_IO_CMDS for batch I/O pro=
cessing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
