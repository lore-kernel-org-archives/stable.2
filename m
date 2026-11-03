Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793730991;
	b=qr1VXomLnmCNC7soIyVcVfwirHe5djqPu0yubApB3AJky3GtWXLQYoTzwqqLoV19YT8y
	 vHIXMVv5emPWllk6bxHL+O9JcKfBNpLMzLXLumC4BriNh35Zh6Jt2L3hrgqMauaubPbAy
	 MqTiA5Xcqu5VP2nbgu9JyfUUsLJM6gN1jjjI2aM/TczT2i2FtVyy/HXEeL2OnqlwOZTM+
	 MM2weaJYeSS+L7N91J0iBld5DC7+khhua2oKNdI70R+zb5K6Eu5KW+rmtIFw5cR4vNoUQ
	 B+TbsSoxyHodrzhvySiOehwIrl8/3ZE50aNOKOTnjbdOYk1gYMQDbjE8HCFaORvSFOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730991;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=j01sPplkCpeqYoQ1XyPHZ4w2xiW/+AulZEOKO4lkg9A=;
	b=qWjVh0zTCsu/bhpnqZZJOpwiIZVKkS3VY+UFH78clB1rPUUTlsxdyLbyGIb8JrnkkBqJ
	 IoCSrEYJmfqZMAKQpVDxa+PdOMeNJCH90JsYaxP0CRlwm6mPKkogaqyV6H58hoqwSGooH
	 HMTSUQLLnZeBVsvwfj7NJk1zXjMtvSbNlFSkmyUORCjeECzBy5Z+cdVmTQy4xMSJayVKs
	 1+/wsiYDe/00X89s2LF4IH0IPWktyrw2S/T2okFPVl2dEggSdaHJijbae3pIj/u8l+VBt
	 BvM6vnbXKYnc8DiAtLby0vT3Kr2BXqxs1fUplRLg7Qb5DV48Z29dEKVey0OU1b0DVOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DuRrYOC1;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Rh7PXIZ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC6606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 18:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28FC6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DuRrYOC1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Rh7PXIZ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793730990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j01sPplkCpeqYoQ1XyPHZ4w2xiW/+AulZEOKO4lkg9A=;
	b=DuRrYOC1dngAPxnW+wVbTdNu2r7WtChZ71vj8fbMlt29KuG9frdcPG++14zj0NTu5WTeTi
	pWkX1MO++ohdy61mrElr3ezID2znh/oPZz5s422XDf85VKi1vJ3PKDpiiZdWVCFgMr+JgC
	q/6Vqb55/fzqVXZ+CpTFzcbBE57GK3o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-cv9EjdjGO0iTZeDffjIj4w-1; Tue, 03 Nov 2026 13:36:28 -0500
X-MC-Unique: cv9EjdjGO0iTZeDffjIj4w-1
X-Mimecast-MFC-AGG-ID: cv9EjdjGO0iTZeDffjIj4w_1793730987
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ab2cf30ab5so25898181fa.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 10:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793730987; cv=none;
        d=google.com; s=arc-20260327;
        b=VitW1X2VfaBzoaBSUK/L1xel9nrdc9ZPezxLxFnbAc+ROdC4SVFfm7NyeboIOx5LMH
         zv6g/FRij2zzyl+DV2Tqj/fiCRQSXPgTsDmUP6XrDAXI+4ZP3O8rvZfDZ9i8y+eTuCKY
         qw0OmWOd9zAvbhT5r4MtNFYGZXDxgTn9YghivxBuNpC7QV6z4sxFnTyooX71AKJlUdAQ
         ZGgy163VzlUAzhdQzDiOw2t+H+sNL0ylfWDYXSimH0vWaaVQ2UlvjsK4kMbRXmq6lTJE
         rr1yAKdpX1cTGsgN/Ljq6BQPKCVDlFYO+sRa6N9VYfliCWwJA3tDAW7oWP6hvEh+jBn6
         04ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j01sPplkCpeqYoQ1XyPHZ4w2xiW/+AulZEOKO4lkg9A=;
        fh=bT5ki+chop8TMjw1vp5AzC62rephncig2SYZA02Bfa8=;
        b=G6tqZzqYY7aszksmwSTJVLj3MXVSQcSjAoxRKUf8r5TxqJny+rpOkdo05Ucm67Sr/T
         C02cEZTt867zeniUQas+qwkms7EPWPPLPvxR9mO2nciI3HSFMgtIxg9dITE1Ik2ntBTx
         9z9NKouEnAoP1awtLzIBBxP+fkanwIxixAkztrJDUnTG/gfHR69FMyrQPsVNLMvEl7QA
         fmIEA4R4NYwLuHHGjSgF7ISdbMPTfwKwNPbLiCDJxlPdUU3wTQXZG0VoOV4EekkIDn8p
         gYd9U6FAYZHSI00IyLHqw2hfBjVSiJvF9DoEyZnxjDIA02VvyyHrCrnOPpZp2h8r6XCZ
         +Aog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793730987; x=1794335787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j01sPplkCpeqYoQ1XyPHZ4w2xiW/+AulZEOKO4lkg9A=;
        b=Rh7PXIZ734uzcAk1ghkz/oF//TUWNxVSO7PnfLA/prSeJ+d7td65UScIuZx93maOii
         Egaf2wlL8laL/y/TZmMgiBSsKzICpeqrj5SDbteFPKfecqPO7+jeb+/JuhDtACwPZTFl
         RdHqqQV8svyxSaBYb19UeqHfuQQhyXzY8Do7sdQEnMJZKOMnqO02eKLNGUBpnYyPWvJS
         jsn3Tm5U/ECL/05esCIDWLpA7/9lSWxWNEhlQSueowcKx1VOy61GtfLc+XWXOT9vIeJv
         G6oqEx7A3jtxAW3Ca9m1x5zgtrL1z38GnI4xms8nNMMLMtAn90gK/d63sgPhUOr8thDI
         u8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730987; x=1794335787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j01sPplkCpeqYoQ1XyPHZ4w2xiW/+AulZEOKO4lkg9A=;
        b=uD7MTSsUGScN7ECSLirQPM6Bt4Fw7SECFafCCynu2IuAghAH2t/7PctvZ+57geYMHA
         mCZCXuMphTQ3jzXxYJRJmNxin2LbqvM0cOQbp7j7ixfr4p3ClgDaoFQ1QrD5HV1BET7d
         rUDIh3hjnD0jfVbOfCFNX/LiSBYbkMMh2g/snGuI1/jt6Gnea3wuSkl1Sr+nvVqfdwIk
         JS3n8blxbKe2DXiUjTAnJoknEwSDOgQ4OvU+d557WHaug6X6/AwwGu+xZAtZOyEkjRm8
         v9CmMtwpJjUEB8r2oNnj2CJcTMhF6sYn8Z4zO49emVVtySYrOuWOcQlDNGZ5FPH3tbME
         rqxA==
X-Forwarded-Encrypted: i=1; AKwUvBzTRPxi4vbxyhHEz1opTv8R2lGOpOovtV1s/8TH1S2+uzgoBXFDJgu5fRbZ4BrdFdAHFeXLXoo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZB3OVimcr2SQT0BkIVJ69JtOfBgAxwnMo4fwrS9EDrJquIqy4
	A1tEmQWDFatQswaxY3CpnBh9tILnNTS21z3navj0i5dzEMsV4Rvitxuy3lpIlEekHc0m7E1V5Eb
	Gv/9UDuwgGaM2dbWMI0bsqlO5XjN+dupGtdzYchXV4PycMloRjli0jBM95Kahbx0BFZy6n+q+tp
	ulY7xJL8I7FqVamrUaVPRDIxsMZklFk/Dn
X-Gm-Gg: AYBFou3pKkem6Bj9S6UzsfJM1Gs+EAinl5qZUkHnQnPFAwPzd0fXMxLuAOJ2KVpqUdZ
	pf6LOPY3jMf6CzPnqUqRIsIUf7KmfcKQOpu4Cd57RN8+gFntmUYq8cV5R1gKu2H6j2cahJtLlC6
	Okw3hGxggtmuQFWMx+jOwIw+bKbb6eJcf92RBL4ZisGs20dKU4WAdjGSE2
X-Received: by 2002:a2e:a883:0:b0:3ac:4ce6:8b7e with SMTP id 38308e7fff4ca-3acb7b4dcf4mr36387061fa.26.1793730987135;
        Tue, 03 Nov 2026 10:36:27 -0800 (PST)
X-Received: by 2002:a2e:a883:0:b0:3ac:4ce6:8b7e with SMTP id
 38308e7fff4ca-3acb7b4dcf4mr36387021fa.26.1793730986742; Tue, 03 Nov 2026
 10:36:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260818140746.1913226-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <CAK-6q+g8ZFFWRZfhW5AsKM3_LcxBei_RdBfxgSdsa=x8=7b+jA@mail.gmail.com> <868a092d4d27c0f8999057916b1de4da@oss.cyber.gouv.fr>
In-Reply-To: <868a092d4d27c0f8999057916b1de4da@oss.cyber.gouv.fr>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 3 Nov 2026 13:36:15 -0500
X-Gm-Features: AclHuK9184TyvecLrVXGuMPslSGYXWlRccRhA098qg00_x4VCfICGj5GbqjeGHA
Message-ID: <CAK-6q+jPTQ1BXP5NKdFXSwPjXVimgg11oFBzvW-T787azxWnag@mail.gmail.com>
Subject: Re: [PATCH] dlm: reject wrapped messages with oversized inner lengths
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <jeremy.jean@oss.cyber.gouv.fr>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 3, 2026 at 1:13=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<jeremy.jean@oss.cyber.gouv.fr> wrote:
...
>
> Hello,
>
> Has anyone had time to check or process this further?
> Current commit on master still has the issue.
>

I don't know what happened. I will resend them on Friday and ensure
this is applied to dlm/next [0] soon.

Sorry.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/=
log/?h=3Dnext

