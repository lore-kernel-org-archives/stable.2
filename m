Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A33191D3;
	Fri, 28 Aug 2026 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881598; cv=none; b=a7rnF3oZmlWwnl2BujFmufeTrspfp4KoObh/Grv3E+RoKXSO7xIFWpU69ccq9sZDwDE1YRdK/OHvjberqLS+tAR8aDuBD4fdQyuHr3NwSQJ3RrouCIXAXFw809aEuwQLmTm4aEjqQ9dAjpyK0mvRLP6LgDi5KRIhyu12vur4uyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881598; c=relaxed/simple;
	bh=Iev3FFYXi5AYPhW5lBfhhUf0Btit7mD1cuip284qy5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJHng7PzAWcwV5HIKGLvhJDzoXTAKTLGSfu+WRwY9LZ5JRoSRmvmg1teMJ5glDgrOZ5ydJOMR1VdVoHGS9g4qwobFTdT8W/h+f3khouBDMPF+QIKIdpR1KtYsYv7AT7GVLqEcrtwnDwnzgfjuaJv6f8YyJKuU8lQHB7ngx+4arc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY+gq8Sc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY+gq8Sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833D61F00AC4;
	Fri, 28 Aug 2026 01:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881593;
	bh=Olh6RMSTsOFHOMphK+mTMik9juqloGkuzkP0GbXEUrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EY+gq8Sc0EENAFxyEfUjIIdVc2O5HZbJV5BRuKeWEEw6miLFC5UdI2yCJ8oquYm+k
	 aNvQaZIsctf0Td5fXek7UnbP+2dVNhWPZp+hIj0Xay4shXwk0zPNkvTBkFa3pHFUXj
	 rHtI7+Lj3h6lZKmf8pOvn3WwgDEA4iYlhijO80X1yAnXuqhMy3OfKLOm3DiOnWv7TY
	 CfGMvoi/FrIqGP3Gsi0iaYrZs1Em94dnGEyTtwEMCozF61JllBCdQ45t/lPreC+MPp
	 kwt83C9FpM92qUowfRvVaA+vEVKkYsbmfCVMLdP1s8sxdWkSrdN+wVlsFyIoIdp1Up
	 6Cf9scWiT6qgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	kimjw04271234@gmail.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y+6.1.y 0/2] KVM: x86/mmu: Check write tracking in all address spaces
Date: Thu, 27 Aug 2026 21:46:18 -0400
Message-ID: <20260827-stable-daily-0005-kvm-write-tracking@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826201655.9198-1-artem@trailofbits.com>
References: <20260826201655.9198-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 7.1.y, 6.18.y, 6.12.y: please cherry-pick the upstream commit directly.
> No patch is included for these trees.
>
> 6.6.y and 6.1.y need adapted backports; they are patches 1/2 and 2/2 of
> this series.

Queued for 7.1, 6.18, 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
