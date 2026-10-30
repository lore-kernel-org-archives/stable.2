Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793323016;
	b=SMbFrtK6tZqoZ7XazHz2uaiAl8bRJKlBt01Dh+58kiJ+PUkqx6q8O97k3HxGiQXAFid9
	 8exyDGxOZDmFz6Fi7wGKZ+X6+MGFaxba44T6afepmd4HpAfOEGqBGRgoh39WI6ZiGaP1Y
	 n1DHrCorGhpUwI8AE2w+0SrbWsJr1UEN5feZLFxEnIz7m1z9GQeEyoeczZQi/GYzU9AlO
	 FszOZyJw5x5OPkLDyY8cO6GnDgSZKmCFaG15Mu0x+2QC/wPoAhZ0ou50TNSiQS53EXHWS
	 QN8u1XbD5VWh5YQCA8/kteXpyOZw1/E1OiuwHpC+ljbMnwO87Lba0hHzjGdpDOm+ttA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323016;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-DetectorID-Processed;
	bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
	b=DNwSwvJMBdvCX3zV+tA0FxTboXC8GRDF3b44TgWLFX8DezcSJim1u5FBfe+OE1Q12lcC
	 Dq2XJ2V0gecSK7EwIBpAxs6sMHhrT40CIOkR6vbiwBiXvEeSgIuaaLMp/1bNutp7793kA
	 Wjt+Prc9dXvVgdys96vkpkl198WTBe3LYB/+2B/OAsJCuQosc82pasxY74E1PaWqkZuGe
	 IFrz7F4NegO5tnA37v7QLACFkLCl6A7q7Iz5c0VS1R5eNDYsFtV+LQL69UJgO/NAznVDi
	 siwqLcqvuJHxUJLa+0zWV4Bmo7wpsc0XaW+ELOl9KkeISPQb1oANB9NYih9bm0jDPIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PHo3vd9Y;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218B606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 01:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9218B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PHo3vd9Y
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so86627a91.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793323015; x=1793927815;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=J/F9m2EsbWMo+r2vwJY//35FEBlK78IiRZrDcAxL+9ZxK93ROJu+ouiwHBqt3yzTmb
         JW5lh1dqboq6eTyf3jWpa2u9mxdidBn8YfkDvSFHL+va3Ff6/AB1I+vWutNp3qJVeB7w
         TC+Hz+Z+dPEzNnSMI73GzzIunZGtXIzyjR/BbU694YUDd+8kfIuy5YFoY/SgQP4mXzgv
         4eospDiZ3VrIQroUX6RcoSSA6etcVfP8JSLWZkfwg4/iveRysAH0Y2673A3OqF09mnw1
         Nr3ZVs9akjz8n3tVmIcQCX2rtsnihMxRN3nJ4PI5ek2QDbNhxotr442dAp9MWay6iX5i
         jpyA==
X-Forwarded-Encrypted: i=1; AKwUvByIYH5C1v7NGqWFKcEq7zdtmfh+I/9N34DZqFLgkUDvaMjD7ULdvMhU88nZDHTT9+w7wispJPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnN+go9WS8V0TgiG4Wif2Lo+DBGOZFkrABKkMd7jbZkt1dXFfe
	jN7YeX5zKO+/mOoAK0pVmmPK7FfNeDcailn+w8F0cymayqCFCfBYPKkyl5pZe43UHFaRTsRAuCD
	d56wgGsoAKHCqjLRbEtO1tKjcnBH9NdfMfU622OdOTdL9IlEcseNp4h3C0ieVgIOQANWI4aszpZ
	x8LP63gNoTh/hF47p+bGxVeluRcw1ZYczh1I4PLdCml4ou0of7KQ2k61c0XjKIjI6IxhSWJK8T2
	eWf/NOxCTTpbndW
X-Gm-Gg: AYBFou0lwtAblo7Yuox61KzB2dZgL4GsXEzeoD4kxW2IJafVd9jS1rOi0wPgNlqFu5Q
	hgyj8EI95FkJJXInF0CUmr8Sripdw8zJNfPx41BFAPDX7zYxSkTv0G15SHNF1AhYAALLFUghAYX
	WJBTQR19LN2VFKacewEt+qQ2kO3tJO9OgF43TXweNbuUUhQK5jXD48w16XSSXWFO1NOexCb8xAb
	7YubZr1SvMNNQIZWLGnqJZ+1QwM2HNtugvqUkZMOD/aSaXKvJQgXRg9LNZwx6z52rw6IPdxeu2N
	PYOMdtd8/UuCv7cFP3wxcDkiR7xujhpD+OKWStzZZIGk1q5g3DBEOGpD6OdKtzpj9MFpFMqGLfb
	GT3KnEtwxrkwtfUw37qrqN9suqmkNeDESMh4vKpwiru/MLxacNoDWDi4hAW0bAATh1qRPiHMlK3
	LPHfKJHWG7Zg/BsC0J1KqElW/xlyPB+Dul/r6qedYq
X-Received: by 2002:a17:90b:3c0d:b0:3aa:f4af:1e0b with SMTP id 98e67ed59e1d1-3ae8957d281mr552080a91.8.1793323014657;
        Thu, 29 Oct 2026 18:16:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae881b211dsm234007a91.4.2026.10.29.18.16.54
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 18:16:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f13c143c8so27043385a.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793323013; x=1793927813; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
        b=PHo3vd9YM8aXH+tiZHr1fZL7SweShW26SaR7KA+kdYj/OutiifGsBdjmVmY6zVmdDF
         4wZ5RzjOIUwLvNBORb4qVuHxkvkXnssx5W9IA8XSr3wArl4+LDoY4VLksYTe6Oy9Ep8I
         LSQDOhWf2I8/qMoT9O2LJyFZtdhGbpULzMRmY=
X-Forwarded-Encrypted: i=1; AKwUvBwrC5m2s3JIq3lAHOWkQnNwFRv0vvuYp5UH7xXkTCB8U/Iyd+wPnzWdbf1bCJ+MaFkA8iIji9M=@vger.kernel.org
X-Received: by 2002:a05:620a:444c:b0:93f:322b:2209 with SMTP id af79cd13be357-944216ee8f5mr158766085a.28.1793323013537;
        Thu, 29 Oct 2026 18:16:53 -0700 (PDT)
X-Received: by 2002:a05:620a:444c:b0:93f:322b:2209 with SMTP id af79cd13be357-944216ee8f5mr158763885a.28.1793323013008;
        Thu, 29 Oct 2026 18:16:53 -0700 (PDT)
Received: from localhost ([192.19.50.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2c7sm11353985a.10.2026.10.29.18.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 18:16:52 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 18:18:13 -0700
Message-Id: <DMHRZBXFHC7H.1WAJIWY0I99QZ@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <ian.forbes@broadcom.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: log missing primary planes only once
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Zack Rusin" <zack.rusin@broadcom.com>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029215540.3008997-1-zack.rusin@broadcom.com>
In-Reply-To: <20261029215540.3008997-1-zack.rusin@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

