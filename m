Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A923183F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752691; cv=none; b=hYkouYMyE64QokBeLccZbUAUpYQMhulY1nKdSvfFcoDHTv1ggM+3y74hC9mmlZkf+g+dWRCjnGz1IsNkE88hY1fJS/EJ90Pl0nB1sojf4/sgUqb25+8LNLd+z3Uvo8mjhoBHmEKZGsjCSh2W72He089KDpwxQ6RMM7Z2LL3rLM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752691; c=relaxed/simple;
	bh=WbMLx/i15JDVy8U4idwmH1xcQbbTxWYH8XevgE25VKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWFoN/siR3l1Z/FapEo+s5d5KhX/ZXvgtXQUpNp+zoEWsWFHXaYKSyKOEDDQpbkTnH4bvDaR7NPYO2vblhjAUgOAh3lVjP7xD5SCKCHzvgXDTSpKrCLvid+9lNCo8KS0ByLUAcvZIx+fHkRb4xIsVrNh7qRiYqXMNbsaFU7xBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3d+JxVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3d+JxVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21AB1F00893;
	Sat,  6 Jun 2026 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752690;
	bh=sBEHDmIjR3o8iCzoQnFcJLtzYg0uCLXeyRN63Ulnai8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3d+JxVvU068IYcDvl9wNtXHXMpSpWf/jhDxfbnvFrFDG4y+DepwkHIw0IZkKWLkf
	 hMycwaHJlmk6h5O1Ra9uoX9a0PGl224JCk4mtNuUsZM+iX6ZFwa1rvClmA/z3VLCIX
	 nzFxMsIN5z2fHA/oU5KJYMXkqP0c/DzR0XqwGzKrTqdfcy5cEodXs34IUBR5F0ez+D
	 AS8ZDYEHXzYqwuFi3/PsRZh6wL+QgUCtmG1FNuSROXMhihA7HxlTnCxjxV5u/ZDtWz
	 dtSvOcxJb7tx/DE299Sfi3cvcerXgoqf+d4XFgJUrdhHjd7ldz5oMvjHScgsNo74Iq
	 eXkPZjCpKgyUA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	nogikh@google.com,
	bp@alien8.de,
	dvyukov@google.com,
	Miles Wang <13621186580@139.com>
Subject: Re: [PATCH 6.6.y] x86/kexec: Disable KCOV instrumentation after load_segments()
Date: Sat,  6 Jun 2026 09:31:17 -0400
Message-ID: <20260606-stable-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604003031.561-1-13621186580@139.com>
References: <20260604003031.561-1-13621186580@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Already queued for 6.6; now also queued for 6.12, pulling in its dependency a9a76b38aaf5 ("x86/boot: Disable stack protector for early boot code"). Thanks.

-- 
Thanks,
Sasha
