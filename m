Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C019CCF5
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573584; cv=none; b=Y2bYL6Wx5Q50QetLrK2Ns7XfPDb/hGhSo4UNsNjUu4xQ4Cdkm5m8wJe7FmpVHHzdCRbAQ5QBY7MG7AD5IKJCplZllI40r7ioOiCrwX/EfpKksk9zyEGTzOF7jx+nYN4VKbMSTzajbOBf0JhOjPv6YIwt4ilFPG0Rbdi7ee1csf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573584; c=relaxed/simple;
	bh=aJtKhPA8Ii89k5Bn+ANeNGZlEn8xfbMvKK5TkqbdCFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHXYM1jsWoP0TQh5QK7Zltxlhsd6M02Z1yfqvXyblSRplJtlQTcAHmwb2LwBjPDxn1skpmKFIWInbpbSaz0dcT17PlS3k6eOgv1ZLLgn3+45kCOX/EC0QAC2IduiQOSxaFpsBiqW/tsORwplMNLrwK1lg4KyavztOHfZa47ZqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRQx/u9L; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRQx/u9L"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1325060a91.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790573582; x=1791178382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aJtKhPA8Ii89k5Bn+ANeNGZlEn8xfbMvKK5TkqbdCFo=;
        b=SRQx/u9LwsgONKwh2yNpAE/GYyxErVeBKHdSMymnX5H1lKnrXiWnUGN20hhECZq1hx
         kJPyOawDx8eVETyp7qLWXtp4hfmsvgZw+mLkmJZr4V3tRX4BYHAZrZFvny80qHN0tO5O
         drUmNpOXEVzY+qxDRRvZoDs8WR1UJNL7LYaEhTBh2+Om1dz3Rqnb1dHZ7v3WTet2Ybg+
         yg0fD5CWvFODWMiacqRDVXXEE2YWfDkgeVafl2rKsgdYvr45vh5k8FWWuUip2GdRQgvP
         Erws6yoHMyLH78Nh1keS0OXgHU3oTQrxVDwFUZRnE4dOE+ciWVdme7reGmZzWcYJJpAl
         4ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573582; x=1791178382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aJtKhPA8Ii89k5Bn+ANeNGZlEn8xfbMvKK5TkqbdCFo=;
        b=jUeVWsHgQBNcPAYYSwnhi11cC0T97e9VE2NtavHtcw6HzQtEMZ+9/pOpaVzweA9Uk6
         7k091IAn/TzgDD/EqEZZ/tvSAOpAyjTHbhmkfRcnLikJKp1Tpr1QHtc0MIlEskEFiFbe
         5zTjYKEjnYM/y2oBam5+V5f1Q8H9JvNmA5jEVVUYxw3oLnQNnp1DM2BhFVxo5g3mX7rh
         wVXzHSBfyyaQHcGOIrLTmJ/RKOpmJLcD3wL6AMdrwgAT+4rVOSAEug5LlAsFzr5JHSsL
         cv9aWWf1NMsE98NhrZbgXGz5lOSMhoyzcNv4YcklBfFT6GH7bJaY118culaSTmkOihy9
         IqFw==
X-Forwarded-Encrypted: i=1; AKwUvBypFBqA7xXjAZTZyMEIQ79j8IRpZTN4Fj9jnNBJQSXcScgAWdc36AFa37gd/1rpU7iz9ftxfJc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe4I8VqRrEh+IRsjJx4w8TuWsyFAdzzBrqpJLy5PtqiiQtzkba
	FFnfUyUD4LdM3jv26FQwp9yxQmc9yofi+vBGh21PUDg7rYnaDENRCSA=
X-Gm-Gg: AYBFou0tycN5i1a8Y1Ee2HoCTr+owNjpjd2zQ+hP8M+B/diTeSV4M1PhrJyUPbwvHub
	6JtWXGWC7J9qXH3Tf5FG3cDOP2mzkvGfeWZwXLMm6SVnMAvZTwQzHF/HfcdyjjdaQwrM5ldyxs/
	hR+kx03g9nxFfFhPPIpyeg8ecoCzvT6VW7Nx+fkDkuE6okFJxUmpyZv9YFytIP7UX+WxYKllB2D
	AwQ4qGl7CfhjmsRKGOdFFBxHLjgksKK5mI9eQFRAEhpFnHL1oGl65602Deh8x1GIZpp4J29aJIy
	S5WlTkVBUODNR85QeJa7NtUTl9tWVpXgvk2LAcNB+oH2XQLTOCRZT+QnmmKJD9weiZjLxmQ9xzw
	+d6Qoa37XyLY1fnFuMIJjl4/du986ekrUGDFsB0vznIVpQoiQErEzHTA/Q7wgvrLLRfBHEExegG
	F92VmC1U8MDTgfxopeRKKb+bKrzryVLFrwV0vy+BRFq86KiW8DB6aeT6giPcijrzapJUxl2gyog
	BKBUGQfarZ63eJ0X+GX0SfLyYM=
X-Received: by 2002:a17:90b:440b:b0:3a0:b540:c00e with SMTP id 98e67ed59e1d1-3a0b540ccf2mr7945136a91.40.1790573582298;
        Sun, 27 Sep 2026 22:33:02 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:712c:b4ae:f935:9398:3170:36f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec711sm25046924a91.6.2026.09.27.22.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:33:01 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alistair <alistair@alistair23.me>,
	bhelgaas@google.com
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	jic23@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/DOE: Fix double free of a duplicate feature's sysfs name
Date: Mon, 28 Sep 2026 14:32:56 +0900
Message-ID: <20260928053256.742182-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c4cdeb880a6eb8368c4fdc8de58f3b0bc6c753fa.camel@alistair23.me>
References: <20260928035035.252394-1-donggeunyoo.kernel@gmail.com> <c4cdeb880a6eb8368c4fdc8de58f3b0bc6c753fa.camel@alistair23.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Sep 2026 15:19:32 +1000, Alistair wrote:
> On Mon, 2026-09-28 at 12:50 +0900, Donggeun Yoo wrote:
> > Leave the name to pci_doe_sysfs_feature_remove(), which already frees
> > it for every entry.
>
> What about adding a NULL check in pci_doe_sysfs_feature_remove()
> instead? Seems silly to keep duplicate but unused names allocated until
> teardown.

That works too, and I considered it. I went with dropping the kfree()
because freeing them in one place seemed reasonable, and I thought the
cost was small.

If there are no other views in a day or so, I'll send a v2 your way.

Thanks for the review!

Donggeun
