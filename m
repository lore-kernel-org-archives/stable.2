Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50473A6B82
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 05:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636731; cv=none; b=lpFz9WKkmyKqSr0aXe3jOpMofZRwmD+p6rplLaQU2AS7v+/XATHbhXAVrYSO0E0gyd4kTwPD1Wx+csuKgrVM7Q4iy9+S7s4Sw8mzyNxdxRqndOGGA//dHrAmL+QoTlQPFX3AGBBBOohGmpMC4OZ5VPe6asBg5rfSqbVDhjI67lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636731; c=relaxed/simple;
	bh=Jw591gxAo8QXvZ6OwhBjVGbyJHAl8zR7f+zbFYXfMXM=;
	h=MIME-Version:Message-ID:Date:Subject:From:To:Content-Type; b=AdpcV0wDaRScJEIws2EOmX8wD32wofFAZzrhjHCsRclJxgWWQrS/viLhKRo7zdU0phHtLuNTwdEf5oRm2EojpXxCgKOa92RvK7dWi4UB1Xkx+gfnNuhnrNe9BAYjaAzRHeEssZdEKq3GMrZhR0RULCtHVD8e6ldtiQmVF0LbBsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBUv2Fwu; arc=none smtp.client-ip=209.85.128.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBUv2Fwu"
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e6abfca68so64792627b3.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787636728; x=1788241528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:date
         :message-id:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jw591gxAo8QXvZ6OwhBjVGbyJHAl8zR7f+zbFYXfMXM=;
        b=KBUv2FwuvBmuwoglvrS7W9KZOUQ7dR8Q82nCV1TP4NL0S5gsDTGHA4EquLNXYS8WCR
         vr1/rdFZz9EB3efp7LH7A8J3zNi7VQOb54MQ1OGg9/SP551rYXASwBcF8ohNNigY9eMK
         6wrjKZOvctdX6CDTl4m4oaMdaIdRlfpaaSuYzbTNniqvy/NGOp+uZUohy21ym0jeaB/E
         ZQzTSekmALwBw6W/DXURubnPVvjYBaHpKOIy04aa0NQXAnOH2TuGmbiut4jHoFnPdfCp
         umb+JxYDhyEd3yDPeQFNvb4UVXsUxLNGNfps0biqArHsRDmeLXd8+IhqM38Y/iQzkg1Z
         2n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787636728; x=1788241528;
        h=content-transfer-encoding:content-type:to:from:subject:date
         :message-id:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jw591gxAo8QXvZ6OwhBjVGbyJHAl8zR7f+zbFYXfMXM=;
        b=SSgxkYUOejZJ0AdU+cmmWiJ+bvUKxN0JL2I8mEJJPS6N68+oacRlprmiNycwu8EBeK
         OyKeGnu1Fg256MoU1l6ZZDxZ1VuXULoo2wPXnmz5bxDOFwW3Odsogz6fwu+wtC58B8le
         Fr3aqHb2f4DhS2mwXnVhUqCjJCFPD+dOycxH7yehR3tXLviSwKrw7CIHHGEUhtSntjEr
         UJloXxsJx0WkzEDhoxR2o0u2OIWcUz2D2y/LGkpsRqmuRHnaVefzTA9Kx8eSldFtmPbz
         pSeZLQv6kwKqlbHEuv5Futu5OOql0n+FhsMEdnw4SRI5nMZ+vDX1vB4/O+LmljzNG+Qx
         9maw==
X-Gm-Message-State: AFuF++kvMr/xqJY9I7Vn02df+CFus2DQIOIvRW2kpxYEfATaeW7nkcpP
	DabjIOv+N5qvXnCXeOUyqvC8iF1oot1LXkk2HsTwjBA5mRNGf6EUsfOkrqSmvAgp4CbSszCyDWB
	rOk0=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:690c:c501:b0:855:37f6:a73c with SMTP id
 00721157ae682-85537f6bda4mr8646917b3.1.1787636728548; Mon, 24 Aug 2026
 22:45:28 -0700 (PDT)
Message-ID: <autogen-java-acfb85bc-10cf-4497-9107-477628a61bb7@google.com>
Date: Tue, 25 Aug 2026 05:45:28 +0000
Subject: stable@vger.kernel.org
From: solvebytez@gmail.com
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgcmV2aWV3ZWQgeW91ciB3ZWJzaXRlIGFuZCBmZWx0IHRoYXQgdGhlcmXigJlz
IGEgZ3JlYXQgb3Bwb3J0dW5pdHkgdG8gIA0KZW5oYW5jZSBpdCB3aXRoIGEgbW9yZSBvcHRpbWl6
ZWQgd2Vic2l0ZSBhbmQgYSBtb2JpbGUgYXBwIHRvIGltcHJvdmUgdXNlciAgDQpleHBlcmllbmNl
IGFuZCBidXNpbmVzcyBncm93dGguDQoNCknigJlkIGJlIGhhcHB5IHRvIHNoYXJlIGEgZmV3IHF1
aWNrIGlkZWFzIGlmIHlvdSdyZSBpbnRlcmVzdGVkLg0KDQpMZXQgbWUga25vdy4NCg0KQmVzdCBy
ZWdhcmRzLA0KU29sdmVieWV6IHRlYW0NCis5MS05NTk5MTc5Nzk1DQo=
