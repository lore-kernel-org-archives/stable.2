Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634668;
	b=cHGbeg/ESRgwYlEQE0A6ddc1yeRZ0cMB2lueSB2U699H78LkZHVMUjordtCLC1AA09yy
	 EKItIS6mEhdrfVUVHycKVeKNbvfq/SsxAz54eSQa+zoKaivK6rt/8tZNOskLJReEO+Ibm
	 52IP+vm6ZvBviYp5ExHpr4XwBXkswAfuTmE9GZkcPfS5S18FhNcWvxlv01Hw3yKyaYq8y
	 /qbc7tgrE5jcczUDc88WGvpiZYhpg6m6xAKxB35cWEEjJTBeZWk3tcDwySIHYE/alibAJ
	 CTZ8cR2gwOi6ZGWQer9V0jlZgOuivMs/gCLpccWvtOAztPdLo5CCvQB5DCKwFN/O25g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634668;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EIBe6Egbq8wlFoK5s9mm5fcqq9mc2/jTVPwCC5RTPeA=;
	b=K9Jt/HUvdk4MtwmuLHtR8S06mBwz7j6ZJ2Q6QNnw0fPTtWUGfHLRkZSTviiBvfuDvzgJ
	 r+bwxEFhGPL8qFsshDUOgOaHlRkP+ZbU9FxOjnX9ZRHWKlHkfNuDKi1ptSgd+22u7OtqH
	 2UyD9FxbywbEIheGLs63DAHTdteOZ7xeVJ4xtpZ2FAj1kymxrjSDowZlBQqOq5T8aKGwx
	 8IOpu9J9VjEN17QypN8yDk8OI940108qtYPEEMjcZK/ZjIVtaazdwozYpFoDuTqhtaC+A
	 1XyfcSWZMZxNeE9bJD7XVtRF4rkwuyrC/KlcZEpLcF1QDdx/DyXfXIoOrvGvOqNmCAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2ijeOqb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9E606A329;
	Thu, 22 Oct 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2ijeOqb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416891F000C2;
	Thu, 22 Oct 2026 02:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634668;
	bh=EIBe6Egbq8wlFoK5s9mm5fcqq9mc2/jTVPwCC5RTPeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j2ijeOqb0B6d//ylvbeNf8on1Tzd1ZfKXgHKdX+U3zdQ09G6k/bjfL3BJ+sABwJQO
	 MYeJ5vFrzIAsrdYO2xjkgi7drLqlD1o4+uv+h4flnkGewVY3egVCWpCDVGC6IMLq4f
	 0WzXXZ0iaiL23UOQrejidp6hvUeS7djnDQbnwfa47I0bQHMRYUkb9DC9y5XG5TImw8
	 vK+ngWdWz2aXiUPP5DIsIFTAFR8PJFfA2ZZEbPrj5l1ezgtW9I0Lohqu4ttymGHjpO
	 i3aV7nCuJD85m50VknQt7t2VgYYn7EpqqvGHY+ZfiDNj0q9nQf8Hr0ggZwWF+iQTlP
	 0631pJCCLnHtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 5.15.y] KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots
Date: Wed, 21 Oct 2026 22:03:52 -0400
Message-ID: <2026-10-21-1-daily-reply-0027-kvm-nested-tdp-roots-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021024921.1735149-1-seanjc@google.com>
References: <20261021024921.1735149-1-seanjc@google.com>
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

> As in top-level reclaim, do not recursively prepare zapping of a
> nested TDP child whose root_count is non-zero.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
