Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDF339386
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785994632; cv=none; b=rfm9re2EouuAbCUEDIcXbBiyYEafJJAJhdh2oYBw2fPrL5HNPzd7s4yRajSk6ixaKJqt6MtIuPiZsQ0i3HgpbMHdBffU66yYNUT+Wyqu3drEP2PXn5rH73oDm9Udyb7L6teRqR/c6eA9pcgNjANIBv9J0j5Seh5YO2xQjekBpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785994632; c=relaxed/simple;
	bh=vnLj6gby/UCQ1lMlnu88o1rIuhA4GPrV7rvpcqemk3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcnfjdV8R/+Sb3xmGIXNTsnJelrDzQYysKtGxSdUvC49SoLOSTehZQnRwmSry0P0UuPEYQRCT7RHZ0tx7LF50BrX6DzwYkXz1dHNQHV2LycvrMXakwMJsgyU/na8JT7mqeqHqi2xCWzTTDaZA6bSUAEzKmDtIME+xihyk3eUszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgQrPMaR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgQrPMaR"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc61541f8cso6663965ad.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 22:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785994631; x=1786599431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnLj6gby/UCQ1lMlnu88o1rIuhA4GPrV7rvpcqemk3U=;
        b=SgQrPMaR063W3H8Jxr8iTBOJ0wEbdBFoZPLHzHyzj2EHXvlKvTZd7ySPw+mgLDhIYd
         ydVcg7XVnfjpD9EXjkFBZC0LvCCTxKKRIl9FObJSAXIrb9tOnpQB/GU/5BA+u2pF0Bl+
         HNkNR+Z+wAaHEEYzGnIV1/1S3NPB6ZS73ftdIKpcmttdO7v5aXITXuTKLkMjfETdF5PN
         1Llgu5F0g/zO6qc62fVIGhfY92zU5KQIxzdITD9+J6PS0OiPvxFWg6NaaQk35nFw0RKE
         hs54138Rdz6BdQ4AfxfgrHocytGQ/+hAxNE9pHXWkDJgacDDm/hCLwOz/HfvXoR8IwtD
         N9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785994631; x=1786599431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vnLj6gby/UCQ1lMlnu88o1rIuhA4GPrV7rvpcqemk3U=;
        b=B248rB/Ley1p679YcbM16R2/Zl7Hfz8zukhUuIV7BCYHgxRSuDKJfhXFYcWWbAoQrp
         Mr8m2jHyKvxtwJn3RaRG41qeUxhbAIgPczuS5NdWi1wGDMMWxMJfVCVkjpnHJ+VVYIWt
         kIlXP6xx0JIZpwpJ43n/N9bcDsfuUyDZuDIurm/BsTGcpkJvJW3YJTqrWzW5SiNJtOfo
         wPDQe22xuQ3uMeJVb3k8rbENwXcXqREyoOzOn8Y+FBisnr34oDZaBW8Qg7qqZhjqzCzD
         hroOtLTDAorFeCwRlSZrYY91pD0NPHDAL1hHBVehnwWJrdOl14jkJfkQCrmGhbjY9e/8
         vXjw==
X-Forwarded-Encrypted: i=1; AHgh+RpPwLAcf3nVx5nBcDjob9npaVX+Ahqzm3vuLEW6xmDWi1/SxFFTTonTRo9L2LLs9JaKWk04Ki0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtcRKEIJJcNIuQuzhrub24Mtnen6dh5S91RGucXaGyqjMuPdOY
	VOduua2ppb4fVQviRr9l7WsYYHg79T2y8p6oHV5xT75Kr/zd7RfxWm4W
X-Gm-Gg: AR+sD12QRBx0yRZpXzdvDrflUrgBaHm048pCtD2WOyoO5mGDDAuuxW2FRrxwZZiUVg8
	+GNu4ZIEqWZx7mhbNCmBMKCya9i2i/Mg/KnplMvMNNa4g5p4ieNZdcb4+HOTgdxNB9LExx8yxHf
	Wyh6dBE+A/66SIz7gx4+kZtCY5fFe5Pp9eQH/QZUPQbIU428g26mYEwu7FGXTjNtHgP+nzOmmuQ
	wb6AzJnywFOcyHp989SPc55qgj/wfPgh3wq56w8ju1I7+N/JcYQE7ansDDyEFeiAKmNfWBZ9mtc
	qHXfwUM4cpEZNE5YbtavIa9bQGr77uAOAe5XmDP6DjjSuwaZdUPZGCvYSuV4rpdzgqM1nyIh+44
	4BtOlpimEqPPdthDSO5smU7V73ZFUkvfNM7jW7EcaJxoNX6tK5JIcly1QzrKxgWk5u83OJYgCkM
	oj3PAsPIQCPPq2jXfMH4gLeE7sQuMiErR3aWsSCywiTulNinBJi5/MMMPC/Tmjscfo
X-Received: by 2002:a05:6a21:9cc8:b0:3b4:7459:85a0 with SMTP id adf61e73a8af0-3cb9c291f2bmr5478186637.18.1785994630586;
        Wed, 05 Aug 2026 22:37:10 -0700 (PDT)
Received: from Default ([2409:40f4:1038:e01b:68d4:26a8:ff11:f316])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586401507sm23018377eec.9.2026.08.05.22.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:37:09 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: i@zenithal.me,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH] usbip: usbip_host: Fix null pointer dereference in rebind_store
Date: Thu,  6 Aug 2026 11:06:51 +0530
Message-ID: <20260806053651.25088-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080602-estrogen-dry-f499@gregkh>
References: <2026080602-estrogen-dry-f499@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06 2026, Greg KH wrote:
>What prevents bid->udev from becoming NULL right after you checked this?
We could use usb_get_dev() and hold a reference to udev when the busid_lock
is being held and then release it after do_rebind, or would that be incorrect?

>How was this tested?
The method to reproduce it is in the same thread.

Thanks,
Jeffin.
