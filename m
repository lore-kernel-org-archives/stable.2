Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640683;
	b=OgPbM+AUHEdJoHcUivXSN13LPAzc4dSQyaVgC7WN7qLFe2LIkIh2cRspZDZ8gKK2w/HI
	 hMD6aiB6BTQw9XzMMOae2DshPO30Zd5WZtYBqT0ReitoGvRQo4qotfF++3OoqhUGxt37d
	 3NUuwmh7xYpmcsEcC9HU/SlAVA3ClTOwLZcDw5YMB8nMpZG5DWRL4F+IC75uAupa3k1pl
	 nVjW81skKOiccO9C3P3QitYXaUn66/ZICDr5BjYGyDV6bmJ3RiZZH5DUSRMgJb8Cz3atB
	 RMvAI4UlIcxB0BWwn+TI0VuHB9YA8KeWRbOKr0ymYg2lQlpfm6D26nGk5xu72GDE6uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=IG6kRcjYBU/g4TMKgH392ux+rt1j2tFirKvhQsBLVGA=;
	b=tkhputTMfvzk1NQYwDQmYZ1A470h/ESXAWumIFB6ftSzNsCTEXIqkGMkWjjYAmWRo14I
	 yFGTGMBkLY4wttBtkd8DPNNhil8GL1ayHA2x4f/g5QH1zIKgE4EoccjnnzhPNjLYn55mY
	 6l9WJKxHBCCYGSBIB9gN8YpDNAOesMH9nd2pbR5wC8Yc716/D7GDY+t4JbqCMHIdXjdd0
	 kQ3sFRKbnTv6pt/XDweUqKV7soPSaFSALZqxlCyC+RbMG6bC/W9r8F1ILw+UOEmKxUrLL
	 Dk5oD+m3QIhG8P1dQPf1kc8eWrKj8mydcoMD1ZWfQcQNURBFStqB0nB+ld6NOrqN9Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bf3tVT52;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E8606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C18E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bf3tVT52
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd67e98f68fso1513999a12.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792640682; x=1793245482; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IG6kRcjYBU/g4TMKgH392ux+rt1j2tFirKvhQsBLVGA=;
        b=bf3tVT52Xz5oe7HWwuYdS4vPehCYzK78ylgL27ucbRU+UeqRtEzcHk7F3S011WkXBF
         pQuhp6XFXukbPgM2erGAacWTr/XOdRowGieSeW8VcwaJiC+Y2eNlY3A//Nj8ELV23hxt
         OsBKLdmoEABBSzY/V8U5xamVzwUJdCku0jOLMVUWcMy5jtcKeuzTMhti1bufQZRftZpm
         l8g9Uya13AwmIKkMUb7GpoqwLDpgOf3/M822hqMcL00rWm3tw6buIhmtj4/Y9E0wkdsE
         LHQMfTZEye1o5BMPKPXsFaUuZvYlon1uaBwxocZeCF/iclZfi04952tpqpyZERt8PCoI
         GvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640682; x=1793245482;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IG6kRcjYBU/g4TMKgH392ux+rt1j2tFirKvhQsBLVGA=;
        b=0xMwo2PBQMevuzeOiCbCS0FAj+/ylaWx50YI3oiZ9UeQuKMVqDjOvrzBl8ZT8P/BYU
         0QdudQHXmCzDRm+/uv3/n1SsI4Wii3czY6ufK+tdW+BeX4y8PBrHCDTcn7hSZICobB2H
         WmjJw6Ck83XRrt0FJ6/sAr06eHnBZt2q6R+kpUaceC0THqWj2nQBaPIjRL8hEkNany/D
         jAyoi3Zu1pAUYBJnLPGPUCvBuy4Hk3nFc+A1SHD3xq0CXCzdk2eu047MvfVxu0lCN+Dk
         M2CXqIbZVbQb/V14chP2D/OU/w2yrOeTvOkAjsWDRGWggdPcTYRl/v3EMCUdL1eNuT5/
         A6Rg==
X-Forwarded-Encrypted: i=1; AKwUvBxAKejBWSyfklQF3pKlBf7RUulW5V30XJELW8Qx0Ef/Y5F5GiC3PvW54TzcgpJGPF8rTQ7dfE0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIam6oTjwznA1ZE/pw5sJMMk7bZU8wbOjkEiVqf/b4kqoTUsPM9
	ZfUFwRvk6rDshshuzN5y1jssWldtuvHd7CA5qqAMrkwRUDOEUzUv1+rbTHtMNnMfR9rj63S/v8q
	5oPkYfEJ9WE6KrKdayvXHNg==
X-Received: from pjwo21.prod.google.com ([2002:a17:90a:d255:b0:3ac:989f:b65f])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:548e:b0:3a8:2c7e:8986 with SMTP id 98e67ed59e1d1-3ad86f44838mr3389905a91.17.1792640681540;
 Wed, 21 Oct 2026 20:44:41 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:44:39 +0800
In-Reply-To: <fdb5c391-01ef-4a23-94c2-4f3853909348@acm.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021035450.3488805-1-stanleyjhu@google.com>
 <20261021040615.3566831-1-stanleyjhu@google.com> <20261021040615.3566831-3-stanleyjhu@google.com>
 <db4d4e246ad6b4769f736db0d3d1678adf9d59cb.camel@mediatek.com>
 <CAE14pdcR7NPqK3W6Pfy+FkRrXSXB9wFuweOhLyFtSye_Bg4vWw@mail.gmail.com> <fdb5c391-01ef-4a23-94c2-4f3853909348@acm.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022034439.3033316-1-stanleyjhu@google.com>
Subject: Re: [PATCH v4 5/6] scsi: ufs: core: Fix double release in ufshcd_abort()
From: Stanley Jhu <stanleyjhu@google.com>
To: Bart Van Assche <bvanassche@acm.org>, Peter Wang <peter.wang@mediatek.com>
Cc: "Martin K . Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bean Huo <beanhuo@micron.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 10/21/26 9:37 AM, Bart Van Assche wrote:
> Do we really need the code that checks that a command has completed
> without notification interrupt? I have never encountered any logs on
> any test setup that indicates that this happened.

Agreed, we do not need this branch, and v5 removes it. If a completion
interrupt is lost or arrives after the command times out, leaving the
command to the SCSI error handler makes recovery slower in that rare
corner case, which is acceptable since it only happens after a timeout.

I will send v5 shortly.
