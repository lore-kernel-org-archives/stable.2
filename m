Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230306;
	b=Pg/TBTkKCgyNUnTQrqEAZga1L+ckPnHUJ/SGJGu4FT46aiZ16i0cee/Yl4x3sETMvbKd
	 B9B6pHwXBpXStG1IpD9E69eWNardIDhzYN6HD/I9Vr13ep2L0HkocfloQQHslLjnstA30
	 q1/G8RCx2mz8u6PD9y454nFeuhJDLOb6gRI+5hYdsBczmTFrtNCads5oblaSP0DbWl37n
	 5QmUrjPM3sDtgpxf2kfhDyvpND5rPKFfTl80CGnJ+8iBWZXVgz3CaIRa8CeAcEfX4Bkgg
	 CKdEGPkGGD4LeQPf+Hxet6O99b6jvEVLDJgFQbnI1+zteNcKT4mg1EajGT31URkBOGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wnZYDmyfLGGQSH5dTTCSE57EXCieXIk8/rNWoLElS0w=;
	b=wop/Y4lDgae+/LDzRcOYFNMOoO+i9iE1TEgj+gJnRKVgvK/GMxVuIDxfH6fdUuLySXjQ
	 ItM5Qc1CS34AnugKw9PyX+FwhNFrF/So6ds9wk6VHkqjKssM955bgPSYADcZGp6Cjs1ZH
	 QiDQdPqTzdCey0gVTQzePKIakRKtEXbQiGUh0yakZ1gm4iV20dp5KC+xSeRDNeD51ii6Q
	 e8v1KAGgpAzdLAuCsWXIYKpHlqWml52DeIuSNK61f3yxpw/Qod7dMUMyeUxNfXH3QPVq/
	 VjHJFSN0Etyix2fWvWVKJmgo/smBippweZzZoGY7fYZcBW01VAKnuwxSEwm6yyeJs1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ofrm9xit;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3A606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ofrm9xit
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so7254555e9.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794230305; x=1794835105; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wnZYDmyfLGGQSH5dTTCSE57EXCieXIk8/rNWoLElS0w=;
        b=Ofrm9xitxKVVEYH0/cnM4aP513ECFIc6moKq4QsmZGgX3rVY+PCUSYsutGMiz2p9vY
         F+I7xJJzYIs22pjgo4gkvAWrL7hGGK27Df88u6fFrOqj3rZNWAuibH5zyMdwbKuJKAHn
         SswHY8kBiqZdtGSvlO4EBLr2GCCjIgwm1hWIKW/qCgrXw6iSt3ynIBWGe78y0K/d1Dp1
         6oAKM1KjOQ6dkzIE2D/pnYfefNsAq+A72KBWid1j9sTaxiTba10rJANiFqHIaFTr4hld
         mM//OeVompBUOxUCSHkxJqo3tDu/hZGUIx37ZFRn/Kod1bSoQInW1l0AJNPxAM+y6xbI
         WVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230305; x=1794835105;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnZYDmyfLGGQSH5dTTCSE57EXCieXIk8/rNWoLElS0w=;
        b=MOCnpcjU94SZItuVBlwmfNNfFr1EKgC4mA3pfsUSfIvpLqXwRMwtCwp+A3c30F+Dy4
         BTI8TKsrQ1SHLXYI1jxGUyCVQrjPEX+6GhnuCNeklNM5NZ+2sIRulQGw3Qjq+mjUKLfi
         5kmTzAeeM70zDFrtwmeLQRpBYyTyVgy15+1yhHu5puY0wzC/JdqxmJCQatsm4wN9T1d+
         ll4MUUBd8/8hn5IZeY47flnAmjjG16g9dBGMGRTcX/0ULCEB/++80HAPsF1h9oUATy4Z
         apdML5uqm+51aQWX/LmEAN3msPoujP3r1eh92t5SeCnhCsdJIZzqSAZwB98jFoK12FCu
         UImw==
X-Gm-Message-State: APuU4Z88OEG83SBII/YVZgFKYnTGaodvonzlOUcK4sOeu+X5Zjxr/MIf
	vgR8JC/4On9ZmPrTblY0zX0hRQJO2zYQCzy6/6q6p/UX1qVgeLMzQlmZxyKGfSA7
X-Gm-Gg: AYBFou2PU3BKkoy1cU0bxswvAtntC+wGPVMxO93hkmMwnMam1C5l0SCAlUzT2Ri9G8S
	Q55RVy9YdP3T+3+0y3AJqeYDizX3D8karPpbsNKY4yXY/RHHg/m+At1nCjtpC7i9DTBJWP8v9BU
	tnmMKUl3BqmhBO/IFKQbiVkguwB//9U1qsewflJBwV+Mj+/IE5nxJ25aoioyE6j/P4uzqRV72iE
	BUqR2I/de3INmT6uVEv7rSRLDLQjOu7jQdyJupl9hiYtEc41/2/zBzjBnXPur7NEAYCOuEfuyD2
	6WWzw/5bwp+6IqP2UCYY7mDTgGWmjemseJw0Zub9mUt/QDd/atHNVkED/T1bnliFlaJdKs4xYVe
	omJ9Tb6QVg0TJE4u3PmO6EWKghIil+NMI2ePvE+TRcmZegp60GcyEIMeund7RdZ5pdCucldoYCg
	VNOxBQJ9PSv897bT6Mk5dzFR2AS8kW5x9stFNXavCEgKckSX72z1CEpoRs0kkJ6oCQKXSIb5KqV
	pVhk1T4D7w6e8e71bdrwu1H0RIM0ZICuP+nMTY9+7f6LaF0h646p5teRDX8GIO4zbSPIvpky1V+
	WH9ne8KNH6I3K1H0ZQrWysHIXp1hxXZ1pKoYqNOUCEhzxl2a2QFdF11lJArRHrsBKI+wiUWdW9W
	3K+57GQ==
X-Received: by 2002:a05:600c:4f42:b0:4b7:6a8b:9df2 with SMTP id 5b1f17b1804b1-4b963c7ceccmr92097945e9.25.1794230304757;
        Mon, 09 Nov 2026 05:18:24 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cbdb9cdsm195583805e9.1.2026.11.09.05.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:18:20 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Date: Mon, 09 Nov 2026 16:18:15 +0300
Message-ID: <179423029589.5673.13170954461184171135@gmail.com>
In-Reply-To: <avHBBj7mqIlk4vdm@laps>
References: <179422696909.5131.4005481731765358036@gmail.com>
 <179422697447.5131.3947908931395034167@gmail.com>
 <avG7oLUJ39PZCken@chamomile> <avG95PtnRweYD0KJ@chamomile>
 <avHBBj7mqIlk4vdm@laps>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Pablo, Sasha,

Thanks for the review and the correction. The series is unchanged: the
revert restores multi-register support and 2/2 closes the uninitialised
read with the in-place guard. Sasha, understood that the removal backport
was requested; this series keeps the security fix while restoring the old
userspace behaviour.

Please queue the 6.12.y series when you get a chance.

Thanks,
Abdifatah
