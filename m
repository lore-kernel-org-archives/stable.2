Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794489227;
	b=RePdSv4a3nFjedkQtzCQ2uNppEcA41dGAupANJ4F5OGC8s0/iJ9l7f62CPfrxzjdyzEO
	 hTDy5oEzKAPCgy8yDS5YxerkkWaeZjLNrSgg3Q+l5mapRv2wGC0jbSTjF5DBUyIj9NqxB
	 J2QymuwCrbzjZ29uhMYkT40K4Oqt/Qeua7hVLWcHey0rBzI89Uwv5VcHyREXtgYiLPsAM
	 tStAu890nZEfHKL0sljo9jr7Le+PbLAm8UEkPsvu43+c83xB8yej1vpeW8jRjdzT4zm6Q
	 DWbJHQ5wh87wMHF0/UiIhMi4TpN0N+Ax2yNIS/ruY9Tyt6vc8KN5+Fedy7dWV90k/dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tt+WFRdvrZSXnzZAVznwgbf/IavQw06AhCrvauaK6GQ=;
	b=ArwQIDBN6oCES1LBgeZ/wJ9XiOq4Q16rPnACgZTEQNYEfTjRRfNONOuYVK0XqUMEhowA
	 44fNW+eK8TlXYnoqmD/gOXiqSQXFUMpownjx5AOVtyyWLgQjkRx4+Xl0V23txmylp7PGn
	 ztc4YD0BNe1nT5MbLI+IONRQ3qSjRcngtZS9CJliyglMl8YOXGHrYW9YgIYe+s526mwJN
	 EJKywnM3nzVCaAa+yYqFxpN2vtSGZ7qugqlehE1I04SC48gr7PeWSO2PykKhBbAqWR16M
	 Qelzi2AVeUh1deRCIR9gzrMFxw9yLKyWe0c31SQu+xEg+3e5N7fUQ/nQ9xW0S1j8rlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=UIJzlhY6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CFF606A335
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82CFF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=UIJzlhY6
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4cdc606b47so667821166b.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:13:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794489226; cv=none;
        d=google.com; s=arc-20260327;
        b=iv4TZ5aXlAusQdSIWMBXE/O4Rr2Bn1HYooq6GMUthUsj0TMnZFDtSr4gtj00DfrTiz
         HNMWw1i+0b1XpD5q/JdlFOFU9+sCy+NGM7dj7hSbPrxIQz/cPcbxqDfH8za1y+3BLNTj
         Bi0QZxLCZ8F8cNZ1CIgrXfoVaajti+Goa0pPFO2Gj+lPD2coFp08TCzc3hRjxv9bdQFw
         c5gR8aduqrL8f4SbhYwnFD1puEGIfJ1zoaFZZRurF15itEzu7zJxlhJ4o1x/V2+cxvS6
         Q0St3xeSuuhcL4JsIF1F8pmAvvpDfi5gbr1IBZwYE1iOvn8TksxGshk9Q8+ArBKdHSVk
         9FJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tt+WFRdvrZSXnzZAVznwgbf/IavQw06AhCrvauaK6GQ=;
        fh=lSxKTQsfLJqL3cgHUVc63/o2tshFv5T0jVge4af5ZJg=;
        b=mAjizvCTsoYT8Yii4jgfCj4p4DpcTMGPXaFg8Ju2SF/y8ri6dezK6IxG8ILZtdNb53
         CU0V07h2y5Y+AqrnOi9U5FlAdF9KiU8RlQzkCYa0ORi4lqLNTQK7KDzDUIowbBy5gDYP
         bHRoXLFbuXEv53e7NOxdxIFC4hCmbLsZNZ/Ssjpa2FqT+6bNefA7z5WAyoTxbvv4tdE+
         2YnjEx7xyPJgBLE9q5IMJoi5HcFiJYzflSc8pW9mkcfRWZpvCoT6ij92F/hEzFazIjXu
         k0KOtMhDo9my/6gphAY3DgtIwIH9rVarz46/dCQaPRXeeNOlV0zwCrQhvpYXs4JGCWjW
         GQVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794489226; x=1795094026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tt+WFRdvrZSXnzZAVznwgbf/IavQw06AhCrvauaK6GQ=;
        b=UIJzlhY69Bayr+gzpIOO2ecPVg/Dl5b/ElSR55In6aKYxCYITsRRmqHQkg2aGzopck
         XhZkbzsGBlmiJCKQJaArVHr90KBvTEU/MPReiE3eLnbdIQ47IeB6LEp2REoi6imJG9Uy
         exptp/08eh/urHnv+EN3OTfET0zGOKipFDPWHJJn9wBNaKpmrGQZHcDomLzvBKmO+utO
         TYPDbm34/J0/pW+/HNQJK4nW7o+obIIvJk0vmKX0HZ22pFcRwKG/HEHln+4Kpzo/wtHj
         U7KgVz1pc41IG+o3pLhH7hn0tIwXhqIg5hAlbrxyLp2FCFPNpUFDTCiYPparpbP1Oqtj
         clZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489226; x=1795094026;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tt+WFRdvrZSXnzZAVznwgbf/IavQw06AhCrvauaK6GQ=;
        b=Yepy4aHuLTew1MnZtrGhJu4crfBBve9PsfMMTbD5SccmFV7AmXHjbZRjRYgQjCRE5Y
         axN3ZH5uNPfBFoN+u2oaiEJM+YP6aOmDrG/9iza0hWTpQ9xaxsCr1UDeNfXEA8Jpr1ks
         uLnw5wna0eHBzXkEOgsEV8cngaYUKrgENNdD1XGVeugPLCyZYA96hcA0eci+oVjSeQGC
         OTRiPORNniwONBqMLpkmaenhiblxoB3TyMv4Eh1hxWzEgiYo+FGWbPgYOQ2DQ5aX1/VY
         P7KHoaewb1Q8ARUgjthsh2JC7tJIbFk1ci4MpLjG8qKNTn7KWzciNqIrxa2xMhdXlSkY
         Ab1w==
X-Forwarded-Encrypted: i=1; AL+hErGew6/UC96lG1KdjrKfMJe7X7IS7JErSbliA+prnLbb2wnO6eSQQd7iM91VKLJAOPwBIhAXDI4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+v58Vf15O/dn/sv8oE4+pQJ3lN3iG2kGPWpqMOigfSle48Keqk
	4pW1BnHtmysznd3uGc5s7WZ8Pxr1hpxPtz8RQaq3Bc0ADmstZ1KvGPOjEgU1SMoOVw9EXyNNc6K
	BKGAQKr5nfif20LbvrAbNUp/el5reXvRacJKFtQ7bjy0n7Vrm58qaaaBUAg==
X-Gm-Gg: AYBFou1Lmds/26ntdmIwYcMhnRA1dg+LlPff00bRKVntIXyeFrupc0sK1nJB1XTNmFw
	qT3ylv09v6nROpi/JiZrBd+r1Vi84cg3FoIgrEmH2ZynDYZa8oztu9F2Sc7WkchSUA+KfzyKbc+
	fps/eBHS4XWatrebxQ0xi4nbg+wj6pAZIsNHXhMk5gStYyB4rU9+HxOZXbGvZvTSF6BYSFpQv4f
	K6IqA8wjQicgkEL610oG7HEMDOzs2mj5hbsbDO50EFviUBRwXxJAB30dU/CIeazs4gBcvxGzrmw
	/n4t1cT5o94n+bR3JFJ1YmJWZEyNEBIXsD31AgTMsybWLAG6CM55yLWPaz6+hk3OIu4A03ltgKD
	NC3Xazwa8yzf7/tdB5f421XtcjWR0v7iKVibkjxm8mIdcV/kQjFu1Rho=
X-Received: by 2002:a17:907:2d9e:b0:c41:6de7:7dee with SMTP id
 a640c23a62f3a-c506685458fmr461873166b.7.1794489225737; Thu, 12 Nov 2026
 05:13:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-ufs-rpmb-bus-v1-1-b07100e53f6c@flipper.net> <b2338a8e84366980f648b0e321e9f8edaaf633a9.camel@iokpp.de>
In-Reply-To: <b2338a8e84366980f648b0e321e9f8edaaf633a9.camel@iokpp.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 12 Nov 2026 17:13:34 +0400
X-Gm-Features: AclHuK83OfRmcNSAr3yNNJR2smWwrfyR_yt7neFWx9UxX0YmCS3qGDuhZxsxCk0
Message-ID: <CAKTNdwHcCA6taSrwmJ79KYSBREkOZgWrhcnCPG0M6=5XOw7pgQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Register the RPMB bus before adding
 devices to it
To: Bean Huo <beanhuo@iokpp.de>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Avri Altman <avri.altman@sandisk.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bean,

On Wed, Nov 11, 2026 at 10:43=E2=80=AFPM Bean Huo <beanhuo@iokpp.de> wrote:
>
>
> Hi Alexey,
>
> Thanks. The code is correct, but this exact failure is already fixed in
> Stanley's series, which has been on the list since September:
> https://lore.kernel.org/all/20260914144910.931518-1-stanleyjhu@google.com
>
> The order there matters. Once ufs_rpmb devices register again, which is w=
hat
> your patch does, two bugs come back: a use-after-free on host unbind, and
> concurrent RPMB requests that get each other's responses. Stanley measure=
d both
> with KASAN. Patches 1/3 and 2/3 fix them, and 3/3 turns registration back=
 on
> last. Taking this patch first would open that window again in mainline an=
d in
> stable.
>
> So I would prefer to drop this one in favour of the series. If you have a=
 board
> where RPMB fails today, a Tested-by on v5 would help, please have a try
> Stanley's patches. thanks

Thanks a lot for pointing this out, I hadn't seen Stanley's series
before, and it indeed covers my case and more. I've sent my tested-by
on Stanley's v6 thread. Let's drop this patch in favor of Stanley's
series.

Best regards,
Alexey
