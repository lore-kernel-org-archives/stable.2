Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872101;
	b=LKs6rae2L+J5hvZOUC+ZfYSHP9waQo/n/NrKskA60zrAB8yc5VceyBfFbKNmCvKyu+Ty
	 MdVQJEvw9ehbqx9DhiP2dppe5n6s+MJdsn+uy4t9l0Vteu+TySmuBF66BeOvxo9pMmluV
	 oGr8lBULfXXvcMILJs4t6A0i0C0RP0S0igmzuDxWUdRA0uQ8Nf5NtcMvrXH1uamPTZlXy
	 FAgDaXTHTEEKRRtXIAbwm3r2oSjzTSpEIlxi7A3Z6DeO9zQrGbtkV1Cx2+mNtO5nbhrg6
	 iVJD7R8tAO1FvMHu/kt/jI7asNMMPOtSnT1O5oS2m9WDsl0PIbMLnr3y/GnRcnRI10Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Af1reff1Z1EffjIkRxjPvN5B/PFFTOsk4MNCtyRPsM4=;
	b=PCxJCX1MFgRvw+P8RkBxMAf8JXMBVI8K0P+gi62iC5f2RU8iC8Xm689y9sX3f8dJnXYL
	 mPWBmSb2oi8M6bzXHT1vQz+BTDSkMrhAZ24ywFXxpT8A4eo9II8Ba1E9fbmmuPAUr1GUb
	 I7Rl2wxUSZF9XTQ6jrSDNBCi/wVJcYX523NI/reUJNlZf3A1Czx3Hh7hr4wEU0I1EYMtU
	 aPzLpZHnJB/m5KL8FYfPp8L9oF8X63a6/gwsPJoIvaMj5qzd+uI/fjhr4pWPyktWAvmOz
	 g4yVKw3q+yX/YkFwQG4FU4CCFMlk95wGRQw4JmATJJnbmTHrYt0neVGzCTfr4TyPl2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cRQy3Vq3;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3B606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 23:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C3B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cRQy3Vq3
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd0cf3b1c70so2289762a12.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794872100; x=1795476900; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Af1reff1Z1EffjIkRxjPvN5B/PFFTOsk4MNCtyRPsM4=;
        b=cRQy3Vq3OMHU9OwTKTCh9lffRzgluUfegDZwWUYI0urJ9QJfPJ3mWWRyllJIQDU0Uk
         pOo/9ZnKyAqrsmxAqCKUquZT3fQn2Yf2NhhpJLAS4+mrg8edGkbl3UZ/NS0XepXIIk8m
         MFwkb225BNfp15ktiVfULrnMonmVqbu71GhTqNaVsin3AyloVqeAF0vCqIi4Xu2CfApW
         nbmGXSiG0gtxnOkKtKp4Y5d61tC8KsxS/BCu2JFZm1E+zC5T/eHqmKfaejtGnAYgvD7L
         RRK634vuPE/1HD+1eL9lN2yIudw/EZHM0GOGbww4tsSW/r/uYYxKJmWvljTcWqu4W/Mt
         JXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794872100; x=1795476900;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Af1reff1Z1EffjIkRxjPvN5B/PFFTOsk4MNCtyRPsM4=;
        b=XVnF7P1Xiu8mfSxVc5YQ50FYQbuiudzmEypDDcE8ru2xbO9dcGmL8kYYaBvUWGek+p
         rtmh+quO3w788gW4ck9yUyF/y97S6Bhp087AjnHopU1yYLHGZTdOJ+67YmvFfRw/OMwx
         IoYG+vYj68c0BX84MqA7iFvlJJVYxHgv0tEe+bOLkS3h9BKwclUQTK2g12wO49Uebgjb
         bECfbTB13VoudHpxHX9gmQwHPLgQW3bRxAqeTlvF/pJLATW9dgr3dBiCsI6tztPg00uc
         WB3HcihXLBrlGUQ092DrGXC0Kg3b6ZcHUVPlDvxAxFw/HqDpviIgkopDSCGTxKjc0ADg
         DJbg==
X-Forwarded-Encrypted: i=1; AL+hErF4NRGkPgSqQ7VC+3DEu8IZhiE1VZ0hpIJFBGc1tnesr2oAmHHe1YLt7l4EQBjPwnVTTR2syv0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9J/B8Kgpl3Oy6eJNwbiau99jDyMfaBAMMjRX9WU9r83KnmN+HK
	fm+YWQfWKoRYtf48a8aXz/1PllWBspOCBMt8SM8DEL92GfnLYUs+iW6wqttxNheEnMyZtECyFSV
	cdQkczbCNPg==
X-Received: from pghi2.prod.google.com ([2002:a63:e902:0:b0:cdc:b85b:3d46])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8c:b0:3ac:af8d:c839
 with SMTP id 98e67ed59e1d1-3b1b0a48e43mr12339856a91.35.1794872099477; Mon, 16
 Nov 2026 15:34:59 -0800 (PST)
Date: Mon, 16 Nov 2026 23:34:56 +0000
In-Reply-To: <20261109103714.4000-1-ingo.rohloff@lauterbach.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109103714.4000-1-ingo.rohloff@lauterbach.com>
X-Mailer: b4 0.17-dev
Message-ID: <179487209634.2938203.11644350063446655443.b4-review@b4>
Subject: Re: [PATCH] usb: gadget: f_fs: Fix mmgrab()/mmdrop() balance.
From: Neill Kapron <nkapron@google.com>
To: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Cc: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, nkapron@google.com, 
	me@samcday.com, michael.bommarito@gmail.com, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 09 Nov 2026 11:37:14 +0100, Ingo Rohloff <ingo.rohloff@lauterbach.com> wrote:
> This fixes commit 5eb5c72c72fe ("USB: gadget: ffs: fix mm lifetime
> handling").  The problem is that the previous patch calls mmgrab() for
> reads and writes, but it only calls mmdrop() for reads.  So with each
> completed async IO write (via an USB IN endpoint) the number of mm_count
> increases.
> 
> 
> [...]

Acked-by: Neill Kapron <nkapron@google.com>

-- 
Neill Kapron <nkapron@google.com>
