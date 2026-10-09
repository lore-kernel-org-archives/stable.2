Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81871431485
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576993; cv=pass; b=HdtPdo2m2I8FCaJBQdo29QumEODdDJXo4E+3296C6IJyDl633aSkbQXj40t6rNRf+ex1y9Bct/RIuV2jed6PmesdMDCn2ybhBVESwdbCc+YUxQmsx/wM17BkkMKh64LXINndpoSn5R8Uwsic2G20fTDD8K1taMigpXFb9FLVTTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576993; c=relaxed/simple;
	bh=9ZstjgpPw37lwOmQxNVbD7gUthkSfwTkdvZxCusc7QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3XhT1ZQq886Gu+sPgPrpdTExNU6ifo1ueBTiAvm1jjxAhIozRFXMCPN5nm9K/F6YInprpu8mPGBZO50UZmOUf/S6KBbZC+cb7NMvm9GfIZpAb5nPAd89X2YcgIWIG+kJFXBMzWW/tQhiZ1IQtBgmh2iNnyl5uDaZLz912LPJsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=J2PJsXPj; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="J2PJsXPj"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b06c0794cfso695857b3.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 13:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791576991; cv=none;
        d=google.com; s=arc-20260327;
        b=Mmr6gM4QeR62K50mGouV/p5YcF0JnhO+9tnqgMM/PqIVbe6u2zc2WBwckAAHhbp4Tj
         Wo53mS7CyOE6rS/bfbZb9PuvTCcc5skCS20ZL/YvBrRh3WfdRiNWBRSfcY61zv+Axics
         oTJvHUFoSWqlJq9LwBSWFwHgutLxYes3ILj1S3OGlmsijqMXQNR7nSohVyZm+vIO3rCg
         xz04sdOPjVBmFr48Ve2Gldo8Nj8W6AFoObloipsno+9Z40DZofTz1foXrWZJX2RkPf0q
         joQIJ5zJ0FCrvwgo3gOqsXsHDykspTX47UnUxmlC/3NaM3zWN+QUvtor6pOaLg84BK6y
         5FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ZstjgpPw37lwOmQxNVbD7gUthkSfwTkdvZxCusc7QU=;
        fh=mTN2pn6gM19/FcgH9Gp6/HlIXkwjiWhfarLOL7F89co=;
        b=VWGim0qcA2lwCXk4BP9Mc40rSkTMe4hG+CnElzALy9xBsuLOWn+cTFZimAGUgYdWcM
         H6QmqKdhKXa+254cxTcGYEfYLRiIlShb/3D9qVCUo8X3bFuaJ4/7gvoJhvnPlBKPcNtZ
         KBsWMKxgT9WGtDujAs6n3TWs7mlmSkLBwmaBiO3+RbPw8Vgbu/L49egJG+TCRNMTo/dZ
         z9dJjVxxXDVNG9UFE+yi1hJaLyb0UbY7nzJtCyf5FEA2PRPll8XSOktaHsku43nuCyTB
         wbhD7pYheutrrQ/68VoEZKp4ho/cAiPJ7kxH77Pe+r0elTSFC9mYuBHrlrddhhynzsur
         LTrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1791576991; x=1792181791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ZstjgpPw37lwOmQxNVbD7gUthkSfwTkdvZxCusc7QU=;
        b=J2PJsXPjVseJD/FlS1ey3Ik6q6O/j9URIcuzNuHvqwAAHUIdkHiTbCsZYMoNDZxVyx
         CqsHyrbhrIwLF/udZUSYeV6KwoWW5PRSyZW359Af3xOlvMX/qI+BPXz1J07q25rvTVeJ
         wFu8WbOQzfdR9A/0FWTtr2WyXZq40SjQ/iom4j+52+gjKu59BWljoJCMhm51OKojrjg/
         iRa94YEeowQF2FRNep3TLaVoT936kzrZ9Cbg0nhRWiJ0LvMYhvK9TIRerF6pc/JRFTOg
         Cv54jBZTDLUC+2yZJ6u9QdTSq3pCvFTTkEycQAfDqMws1Yq/lTmZYJn+Pe4UGR194c0V
         2IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576991; x=1792181791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ZstjgpPw37lwOmQxNVbD7gUthkSfwTkdvZxCusc7QU=;
        b=oms4vKlIrOo0ZfsgXaIoStdYenya/o68qKCU7bhXr7cfN52qq+V7fzhu54+Nu4ZhMb
         KCFmXCgTeEXGJyqG5nDPMqq34UPP2DVg9Ffmry7uGPHi/PK7aWx/y9EPjn5nPVx869Yb
         O0ALBTTXt0+APiEyzICo+mte5Demv2vLHi+0XfgY4L6z0ByLrwL0J+Q0mI0dlU6Y9wPm
         x79Xz1+U0WOs9xe2LH7X/gsjXjsoPOXP6JTYGIcgca6TW5w9G+HtCiAePKHI20ReBhj5
         A1jxyX7zyBO8RVfFPX0Rn9oHXX22JCChjSCkD9POTiVC/OvUPluX+eRm9TG1A9+l0hUy
         LkxQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+Dh86GOQFmgkYvW/3V77zM9Dn0AQvT0UBemBxasS8oTnTNOHQgqD619Pp1nYwideMGek1QGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJS5xxlG2a2PMkg8+V7Q8loeUsswOvJu76WDioLMNjN+Fd0gVQV
	HIZ2CjMJmOaJwaYeprXBK+UQC6Otsd1+DKq/OdTZXmax+yqzXBvY92vTNhBo0RLnCX2kyFgoWRO
	FtZFJQaHJUm7hfyRVTaODj1V9FoaMs92h6Uhd0u0nbQ==
X-Gm-Gg: AYBFou0RGxM1R96X5/9df8oWuikeA2BYZ73dOU1Ey3sKX9GTEACSI22UnWDbAxfHMac
	3fl+sXZJCS8NxlOj+5xjiOlIoqgDWB9o/9lG//nqsqr4OmQUamLMdoQ9lu/05Go9Cy9fcC0Um+b
	lDFmR1gT+IXujQzLIaVysyYQtHzFmtzBQRzBhbDmBS8HjAWTD7jMncJaElcNunLgEE8R79rGweF
	1e2SujlHM7uv+32kieASn4FpTz7xjraquJ38QxBQ1sKXi4WmYmC/wViGxl4hjczAgvwHl288U8o
	v2rbbLQyvU9J4zoij7m0s9kvi2N9tHg91NCDg14OBqVr4HpRlskcDOs=
X-Received: by 2002:a05:690c:7483:b0:8af:5430:23f3 with SMTP id
 00721157ae682-8b07edcf030mr14065407b3.19.1791576991277; Fri, 09 Oct 2026
 13:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-i2c-xiic-block-read-nack-v2-1-76735ed0b0bf@nexthop.ai> <20261009145800.rc-reply-0001@kernel.org>
In-Reply-To: <20261009145800.rc-reply-0001@kernel.org>
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Fri, 9 Oct 2026 13:16:18 -0700
X-Gm-Features: AclHuK8NoU9nFQdsnoGWTbzltxdeCAjZZJguqpmO0Y-nucjuamlvwsTRrY9h3TM
Message-ID: <CAGYn4vzAM2RVv3y5qW1C3P50qYN5J7UKmj-LsMDv9EdqrX=G6Q@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "i2c: xiic: defer RX_FULL until all trailing
 bytes are in FIFO"
To: Sasha Levin <sashal@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Siddarth Chilukuri <siddarth@nexthop.ai>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

Thanks for handling this.

Best,
Abdurrahman

On Fri, Oct 9, 2026 at 12:01=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> > This reverts commit e6fe3ea04f0113fe4d47c03d76e03805a4768ca7.
>
> Thanks for the report. I've dropped e6fe3ea04f01 from the 7.2, 6.18, 6.12
> and 6.6 stable queues.
>
> --
> Thanks,
> Sasha
