Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B182846A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531552; cv=none; b=aXevZpRyHkCMEO/GcD58t928m8yWaNgp926NnieGEjC7kXU0vkbGejELpJp8pWku7MgC0Rf+jXBEnYDPhl0ngtOxNfe3NY8xCLT+WvgHYBGX9fNw5jcGBaKWpfSnY+HINX8vIN0PBtPdSJ+gk8SHEXJdkuAE2HcsOn3pQA66bI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531552; c=relaxed/simple;
	bh=Lokx9tWcu3ZzjuR1RR6L4wD1itfA8HkL4WSZlCcXCPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2SHncwqdJnNG5pvT1sGBqZhgs4cLym60QM4IjxOd3LE/nI8cFX8zOJWVB73NhL654IZwGe4KebbifRc8l7K8Cnn0qTYr8vzkISy4HVb31sTjrMnTq57vWtoOobRo3JBsb5qsby5Q9jf3FPH3QZ3ES62vSpvjOAhbcNukg21qUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rmjzw8Fm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rmjzw8Fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A551F00898;
	Thu,  4 Jun 2026 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531551;
	bh=8ja6ZFk2OXwfX7Ldxwk6O3Y6wlqXJ9sVKst+Iu/Rw0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rmjzw8FmjNht11OHXoXXi4ycFSUm30NsUA/kqs+iOnUDv8f/BiCcsMULGUO4kdULi
	 aiqDdu31UjGQQrVUwEY3Jl06YtO/gNHnuGJGejOzM5/7WiJsxWzrvlvlb8hem4MzEp
	 33JPi1eN2JLQzhmxhwJzYvBI7iKQX91zHmclW09LeUIFnljcz++oML9mYxfTcoM93Y
	 26B01PBpl20fpWUpMssTSVHCPlBqpFUpgpsbgu6T7cbVSQscLGlInAJo9+hXctTzk8
	 0bgUzMZSEeNmzVGIYHsZKqRwQRWyvPnYbMfZxddHeXTX9vU2ionc2HVMM7mwoENVkI
	 8GQPMHTNxX5LQ==
From: Sasha Levin <sashal@kernel.org>
To: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	will@kernel.org,
	Xiangyu Chen <xiangyu.chen@windriver.com>
Subject: Re: [PATCH v2 6.12.y 0/2] proposal to fix CVE-2026-23346 on 6.12 or older kernel
Date: Wed,  3 Jun 2026 20:05:37 -0400
Message-ID: <20260603210831.item003a@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
References: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH v2 6.12.y 0/2] arm64: io: ioremap_prot() rename + extract user
> memory type (CVE-2026-23346)
>   1/2 arm64: io: Rename ioremap_prot() to __ioremap_prot()
>   2/2 arm64: io: Extract user memory type in ioremap_prot()

Both queued for 6.12.y, thanks (and thanks to Catalin for the review).

-- 
Thanks,
Sasha
