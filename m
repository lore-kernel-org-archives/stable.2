Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344405;
	b=xSycD/vSO6E+3pl99p4WbxjIjIxYh1AljIt1Smo7sbKzNI2Ibk4vfvmTXVA9Nci2+pS9
	 2yDvQmP1l4ktCE7sKK4w3NwMRb83Iw4A+LNoSRgclTdGgqMSDwCjJPYqFFL0YIm58Fo+C
	 sYqXCv7yJtq36A6/bK5kCtOL7DwJnNSDWqUK6yni9vZIk99OoZX8KVWDlHsaijxg3Hz6t
	 yDN1EU0q8sMG+kv/F6HkXtqsA/QKQq2zAthZWAgg5Y9v9WOziBG9t58SXQwqDjE8MakjG
	 ak7Tii8TldciWgO2ACm52LNMR/rVrKl1CRxRWAm4x3TGwdFvWymb5tx7NytjzVuXqAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344405;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z5BOQ/GJBZBi3U7ZtFz5HRXDsippEx2g621BWgoaTSE=;
	b=DuKdzobtlVjGOqqNnFtu9PKuQodPTacWq4c9TQBrgYNZLTnIvl6gWStsiggZbA/ZPjoV
	 R56gwO9hFGach8ZSHL169Nnq1TrDWMIhnYcVRpzpPyD84DWic+KtwCtVLGpscrLURU2ci
	 KiOC0a8qLBIl3OeRNnTuntSBt4I95cOzkeBNgShID/8feuZhv8gWRWRSTiY7EGWpZdRQm
	 QCGZuYEeXtjYVK4Gcek5npw3RuM6z0KgZIe7Vy7L9kobRygCgDZUOC5ZPPp3Y+ii7eOOu
	 vb1bCZnCvXLgi/jbVXiMY3Iou1qMLAGY+vAF+LM0CYCPc0hVcUQSEMy+xKpXlghuTqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfSroS5y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14160A260A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfSroS5y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852AD1F008A3;
	Tue, 10 Nov 2026 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344405;
	bh=z5BOQ/GJBZBi3U7ZtFz5HRXDsippEx2g621BWgoaTSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mfSroS5yxsshAiTGBln/mSSJW2VsXI0G84+qWUdniMMItd2eq6NbO11XlJUIriB8Q
	 XuLv0BIt+kULLgsoq8o68p+I9CKWIXz0JhZxLkmvXzVW2hwBiNS92y/HVDbqnYaLFk
	 Hfgqx2GJiJ9sw1oB6SEUGZqO6aN0fQfxAlv400lkmpKtgEtjdPoDMQCwfZ5SKd4FYD
	 IBJu6EUBe+o8TdTFXaIps/9kD3IItpw9Y/0fuxTx6Ix1O/3GoQexW6AO+UudiNIj5n
	 omKEUojfqAMrs7M/sBn4HHZa+JKRg05vSJy708MQgyYmTWY9avKSCXlmVUIxXDwmF2
	 jPWvaD4nFRd4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ard Biesheuvel <ardb+git@google.com>
Subject: Re: [PATCH -stable] efi/libstub: arm64: Don't use the platform register x18
Date: Tue, 10 Nov 2026 15:59:29 -0500
Message-ID: <2026-11-10-1-daily-reply-0033-efi-x18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109130300.1484407-2-ardb+git@google.com>
References: <20261109130300.1484407-2-ardb+git@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> efi/libstub: arm64: Don't use the platform register x18

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
