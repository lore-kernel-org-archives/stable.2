Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9B39A054
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266911; cv=pass; b=PP0P4vmwVn8F47Ky601ZH5dc9MPq7HmdS1n74ematM9lDxCP0BS+Yd9iZQ/x0487+yCohnb4SdgGPJTP4oMLDcz1LRfvvFI38AIC+VNKCfeMKm6fCP58qtPlo8kYdT02taxFFvLnq0K+uEuOEzUwnAvPQn1N+e0PVRHEYvOHL74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266911; c=relaxed/simple;
	bh=7t95l5tIyIrvb8GA058vJ22/PqoU8KtEqZHZXzXWxGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZyH53sOirC+GL0a4q9Z1iSqKBXUYaO6//o2K3gndsHZylAWNvzTGPZAlWWIClI2++vB2w8J3huF0VXAc2TBYwhKdMaH7ExNhfneYJakJbs7V/evbXjwhO3s+2Mj1Ol1n3NgUYOlzwYvtZpQZpvuKfuUpGvmFbXGjao0PWgiB2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVGZFuqi; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVGZFuqi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-396affa9420so704709a91.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266910; cv=none;
        d=google.com; s=arc-20260327;
        b=sbverXufdcrd05tC+jqSIOZ6G6pgnDYmvhgdbFOB1ZQSU3mkeBUkmbvUNzNoDOyRaV
         uKJj+xU3YbYNT1wkzSRRo8bNpQxVt3Wu7DywEplqLvBHNBnCFWfJjJebQ0E5aRlHyBzw
         esADM8ef77dBnJRdDF+20+A3Iiqy3GFyPbBjRf0/j56Y5x7rDMmeq1bhGcwL09+CL8b9
         sMKcfCLKFW6UfcX95DfqRhv5UNJ2hU60DNVrORaXk33dqEj015bxkLg2irD27oaIclSY
         i/3JjsdEYVIz990eOhlInoR7B7YUndSV8dCct7OtMaCJ96wnP3V07J5ABvnuUT98APec
         sMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zEO4ToO7aIfa8An2MxNmN2waWRZjTMnWleI/IMLu47k=;
        fh=5x6ixC4Vq0nLcqHtcuTwJ8p88ycxrLHyNUsFjEnFg6Q=;
        b=podFV6FagJqGDd0lDHF/qZIxeUriGmiBa2oyvO8gzJ7aZpX3beyF8omkpnFeBcHCCb
         yjqlwJpXfOHGWT70OKq53r+/BvXWXw6QQZMH2sSNlC8GzBQ+1+vH4fjvi94AtsKV6C6s
         h11hKGWQyyipQm1p8FZ03tk9adbOhGbBu/0SRg4wnjGqrUfg5J17gdq1FSJ9TBHVSuyN
         yhA4nOkEBbV32kl26UN5SgLAwdCbjfvY8gnX01umdlECLERfo7iZXYcjHEJHfH/9jdXJ
         HRZZ+JYZQr0JA1CIHOe4GbjRO89eLLARiRTD+WHmpG4unZfidJUUisTFs/jTr4qD7bHq
         FhdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266910; x=1788871710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zEO4ToO7aIfa8An2MxNmN2waWRZjTMnWleI/IMLu47k=;
        b=JVGZFuqigiSZi/EaDmVUstxXL81WLuTR7FSd8PSHaPThQDRyTh3KZdUiO6cK6OYsiU
         /nwRkkQNjgq3u4AO+IBZ/Va/G8/K+HmiGANVE0vk+xI0YCjPANowG+toN3L2/fYNCVhD
         wDYe+aTqZJQ+8/5PWMRj4xIL+LCtEjlufj18mqq/e7AaMvdJhlhQySvu8ZNLtCasq4Yn
         +yOhzqdSzUmOIYzAYhTtJkqfwIBu+McKU0tKx4BtJw9uO+VXlZlXCunW65n6ocb+ouSk
         v/F+E1gvVetigC8FzZRmWPAt18BNdo3zuJTfjl7hhMk0qcs7HT2OEBcsMsKZT+24hzMd
         Mg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266910; x=1788871710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zEO4ToO7aIfa8An2MxNmN2waWRZjTMnWleI/IMLu47k=;
        b=C0QlCGkuLrq2Da1eHl6Jbnfn1G3o7Ogg8rsoJguiBkO2aJOoW5Qt5e3pu+gIXZrbe6
         pHLCxGsVqqNZ9UFi7HwfFMCSPGZef9ZAN18HcCy9FBTrCHTn990Vwh2mMSANjMHbDOBI
         BK0BptW7vaAgehqEczQVJz7r61b9N65V0LFwDrIiC9vrFXJJzj5rrDlC+2ipahPyfy97
         UOxTffMSA8nGoRu1FHX+yau83rHrDJMYjAnxjGURMJXpE4Z6z1CUcJFGTIHNq5V0T3iF
         ulzp5t2nioedkCp54ZkJnheYPPbz0S1LRkioLLfTFSLi6C5iGGgbT+A72vJbDCsJXI4l
         hWJQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/1kdwhkKzgGaq+oNESZ7bR5r6p1zmRwDHRSqzKpj4QG2MFURyTdqwDOhL9gWKwSyVWpevZyo=@vger.kernel.org
X-Gm-Message-State: AFuF++lSrG3q1Dr3W1fCKbDQ62EqhwQdCkObbmEM1la5w0wprYZy5Xcu
	BxHEmcrb7JYhcWWsqJoTJsXMrcRLbIW2Yxndt7eDnEJ4pt3QuoiChC1YtD39i718fcUP/DPgpdh
	lDxczVOuJFk1Z2GEVH0KUdorNMx9NIOk=
X-Gm-Gg: AYBFou2oCWOIQu2Snhsd7xkrT6W3OO3mJkwYFN8kRUo8O/6vEi4+WIY8kWcr4NjEO4R
	rBQ7/ygfbE6mZB3e6tyjN0gTtEFeVa+LbsYoh3r3z+D25UC3X7d4DlOW7aVNjbwh4eUDL6G1Y1k
	P9zfRO1w54LwmfdT7L2SRuQGXkVIuCkb+1mSKlHPfgEAiCXp+toLwT71lFKX+C5KpT3F6MUK1WG
	0e0my/tMGVvI9B0aJVcmqPLsg0IJ0oyydErLNvAod4Zvun0PPbkJaVMZ2KKCULlOMaDqXqoF5KC
	OJM8UacWkv347z56VV7EjWgaIwiyNIpLPJObCkc6doS8moo+A6Y8jY5/n/MHwdpIRTgQwD/axNN
	Rh+BeLJfDaQVQ1SQcXm8C8U7SCeizZPsyEjBH1x7G4VhlYsvmqQb/Q5XvN3N8kt4aW9ubgRk=
X-Received: by 2002:a17:90b:3e50:b0:398:bac0:238d with SMTP id
 98e67ed59e1d1-398bac026a5mr20438534a91.5.1788266910057; Tue, 01 Sep 2026
 05:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901031824.1377498-1-springbreeze@stu.pku.edu.cn>
 <DL3YRAXKKEEI.GOGNVOO3AV02@garyguo.net> <CANiq72n0sgSPQ6SmUbK+tv9S5VZktA7g5XMjHOBOFNYLo2oA2w@mail.gmail.com>
In-Reply-To: <CANiq72n0sgSPQ6SmUbK+tv9S5VZktA7g5XMjHOBOFNYLo2oA2w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Sep 2026 14:48:17 +0200
X-Gm-Features: AcwNN1WnWizbjOWWN0pUKb8lC0ggsF-jOAgWoTP8zR1n3K8yJhpg0iqGxAVe_1c
Message-ID: <CANiq72m=CJ7ngSBrnteyt07fHNRJ63J7m+=LY7UDHLmwYKjCJg@mail.gmail.com>
Subject: Re: [PATCH net v4] rust: net: phy: fix off-by-one bit positions in
 device status accessors
To: Gary Guo <gary@garyguo.net>
Cc: Chunfeng Song <springbreeze@stu.pku.edu.cn>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com, kuba@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:47=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Definitely, if the patch shouldn't be automatically backported, then
> we should limit it with a `#` comment, e.g.
>
>   Cc: stable@vger.kernel.org # Only 7.1.y and later (requires
> bindgen's raw pointer accessors).

And then we should have a custom version sent to the other versions, of cou=
rse.

Cheers,
Miguel
