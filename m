Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095630EF63
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431167; cv=none; b=iZ4f472iriL2bEuhydPJu6dxpSi4C9pfvBCfoYWyOF2EDSpUHDwXmOtevPo+7qDKLDYJO7V09E3dnrCZYgCZEK+qnkERFBUNygqs2dBDynNs0oWmSDjnJbIGsmTrqlf7Ar6t5/eJq0h9TjQ9aKmLzo0AicnIzrNsoY9vdD4V7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431167; c=relaxed/simple;
	bh=jnIzd9eXyM0lY5nLSKWOGJM4W2fxtczCL/IrCKu34m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwEICp3GYMnlo0CBIv77WC63jyTxiZr+uk6MM9UlnKXS++lN0cnMsxDKfLYdE/beqIa1HQiFpaB2AT5zBnQWImz0MNucxfrzv2D3GpD+Z2oyIGGkND3Td0DP0UoyRXQY9bQtpZ5UL96HERzO0+gloKYGOfcYV9ya3KtZpxt4FFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKbuiSZo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKbuiSZo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b9318997so2918145e9.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782431165; x=1783035965; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnIzd9eXyM0lY5nLSKWOGJM4W2fxtczCL/IrCKu34m8=;
        b=QKbuiSZosEQxQUhbQggRt8UItfhFDmC0tLrLcEL51qtr5EgnZSEtpeEZFqUyzXMXvT
         2d1LKTAq7z9sEbhQrJuBb9uHvJrvksZkeMoKZwZz8Bi9OI5N2aQJLxduu5Nzkn8UpYko
         hSlOhNYr30cD/m+G15lesKfFbbVcZxcIpw73hz3iLW77WmdbLSeFEfhAJXL7LAQiLM+M
         1nY1u8m9xhRVrT4Pds7Q/QI2i4O2BURUIzRQJP/F0L15PzDzXH5k3wrVZBd7ko3XTxdT
         dONZhhAM1Ww2vQF+rshUSJrSi7h+J3DWghGlYVBQxdgidDogObn9VUDy/ZRg9WaCjP6b
         me1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782431165; x=1783035965;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnIzd9eXyM0lY5nLSKWOGJM4W2fxtczCL/IrCKu34m8=;
        b=qf0hAaSA02JChgb4LtoMemJwF1jfudn78bzz3fmgNVXqmCvWe9G1AECGbtbpo1lRtN
         +xrG87EdCqgWCUWk06HQ82pBWV+TlA4TP6EkS900zGZqqwDS8gjvN5Xq7NJvEEEzdCOU
         GE84n5G6oPqEGo0yW5UJ0nYRkMZ8x78RSDEq3fD6Lcj4ckyooo4TbNYjBLeqCxHksA7U
         NzpRpMhNOL2qisYa3z2wTr+EUJ4KK3/A3RKEcsNc+Iue3A9ty/Xfl7FX+u8tgXmK2CtB
         bpjgyAtcnSB69Wl7AZAiw+IWrCLh39qOOctsasboOW9sIW5TnVoxZgf07dSP/WQd1fnf
         qHhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+rSgOFlGdQIYBF9RubsHO23Y+xomWyqxUHFEzsanaPRttNYyn824Bi3NC+pvn4R1sHlv8NWqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRyhK44aNF6uCFCvAD3abGMWNIQzUK7MzQgUiCjLVXk+jb8vtu
	km30ZzAKQC6BABJcXlJ26tFeshVWs68M91j9hAzXi9aRcweosyHQjVM=
X-Gm-Gg: AfdE7ckfv+8fkdzZb5SkndOjooKRzX4w0bMkxSCt/cxJCnl9cTbtzqJV5nkSYTE4awc
	OZFeWHb7/cUrloAk8sGDVu3nlROPQ6Hf0lhnM2FHlCcH18vptTchvC1lRCRewpoQ92igX/8WEyN
	Y+m5a7yTdUGh9AxZkK8ToWKiN+mrhp2sCJKAaM7mWTVZL/DEL7HmRwjeRmGOD9onPLWOe/U1C2N
	ypKw+VK5tFAXfVa/wNux+ijxUBTQ2e7ObdRtkwUhpXCc5i0q2oPqj1IAZnv/7u5th5o7smQzdQq
	lcE1LwGJ/4yqNkGPWBsnMcxEsAuJWWILsMO3e+HCrcrjPHTnuCFyoi7ivg+q+gQtnj5c/3PC/e8
	nY75TtH738We6ZJNUh9UspopjPSWHWFFR+4l3NY5XdTFSLd4sscl1yc4=
X-Received: by 2002:a05:600d:6452:10b0:492:1e36:85dc with SMTP id 5b1f17b1804b1-4926689ac37mr53156515e9.36.1782431164934;
        Thu, 25 Jun 2026 16:46:04 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm20285246f8f.34.2026.06.25.16.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 16:46:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>
Cc: Doruk Tan Ozturk <doruk@0sec.ai>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com
Subject: Re: [PATCH] wifi: carl9170: clamp command response copy to the read
 buffer size
Date: Thu, 25 Jun 2026 23:46:03 -0000
Message-ID: <178243116343.3635355.16109712055530784127@gmail.com>
In-Reply-To:
 CAPdMp1oWXvtdvp8D0f32vpvzGa0H9PhprQcACqqoc4Gnyy=f6A@mail.gmail.com
References: CAPdMp1oWXvtdvp8D0f32vpvzGa0H9PhprQcACqqoc4Gnyy=f6A@mail.gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Christian, Doruk,

No worries at all, these things happen. Both patches address the same
underlying issue from different angles -- mine returns early after
carl9170_restart() to skip the invalid response entirely, Doruk's
clamps the memcpy to ar->readlen.

Either approach works. If it helps, I'm happy to respin my 3-patch
series (the other two patches fix the TX status off-by-two and
rx_stream failover overflow in the same driver).

Let me know if you'd prefer a fresh resend or if you'd rather pick
from what's already on the list.

Thanks,
Tristan
