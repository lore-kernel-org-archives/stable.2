Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634666;
	b=dJxz9Euui40gAjlDd0SLE3xgzpR/11xVAY93aPHcnTIi2I2WYDk8ujyKcboqrKoLAB3K
	 HE6AbI/RXFPv0nMgl6/j23/vLVPOOSgWAVJKeNPp5Dpb4dzXSSdtIfPjJ7J0hTsUl+uPo
	 i9PJrskJaHbMV4LrHRkI8/zv+yr+Q7xzsw80NjUPka9AnfgNbIsXgR0+jyiqTWPHO5RAq
	 Z+VqUvO1oBPkvIhdpDsY9XYQbnMx+Vh8X0s8xae9R4z1qoAoNiTRcMmwPcoMR7YiBQgxK
	 /4KtebFpeaNQTi+A/DZRgPudYD4BNBkqQcC3BX6/xm2KZiSPHX6jk6AqXCNgKzbvp9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634666;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hg+FivwBknjBJZxVK2StnWl4Fz1nX0/1Y262RDWpDjk=;
	b=H7XSWYJnwCMhK4RZyFlOQ1NYbtk9rKiUxRHmA/QpQblAxaO2t+tvPw6wzTyqLbjuSlo9
	 t6EXMVZpEHTv1JNFhac9+YAz0+K85OmHit9IsHOZ9+0vnuvSwxFTgfZ2c9w/EPDCgCC85
	 x/hpZzmjLk3dHxrFjWrHLPbVeidWjIcunIOmbr1VR1B7bsK/E0ze2Wv0LPafp8hmd51Yq
	 isuioDeYx0ge14Xclu0LkkM8qwTo01aVlPX2f2EHdvAgSOp5UmZjxXnSD73AvQOxprN+g
	 9rNovjsd5oVoY+bEiYz6Ig0eLuesul7fE4GJMYX7hj/Q7s4RBwSx0Vl24roz3YoOlPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WOYdL/GR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF30606A31A;
	Thu, 22 Oct 2026 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOYdL/GR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2841F000C3;
	Thu, 22 Oct 2026 02:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634665;
	bh=hg+FivwBknjBJZxVK2StnWl4Fz1nX0/1Y262RDWpDjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WOYdL/GRSXs6zO5aS2EKMmMQSGT1naJjbnsEs5sHeIWG5DLlq7uriD8Zumgkr7HDU
	 GzIB+trQYYXno90MkizLv427y+aDbjOT87yAqOcQ4OBhzmNnifpcrWBdoA+67N4ZHI
	 04O1fE4bXGPEN/4m9tYvJN1dPj9rYEFwM3dxBaUYpkPAoc6gmyb7yaWk0za80GeJy2
	 jJy9hjxU1gC1ZvoKLwZeUttN9ZqJjcVR8JRqsLV+yneiO70MB8IZXuvw7FTNX6Ev7n
	 qwsyLdcGe9QwMtnS07tSb39ojsroBXwxi4Y44Rf9VkuuhVQs0vp6Jjizv34C5Ohj4t
	 27ozD8MGGP+SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 6.12.y] KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots
Date: Wed, 21 Oct 2026 22:03:50 -0400
Message-ID: <2026-10-21-1-daily-reply-0025-kvm-nested-tdp-roots-6-12-and-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021024503.1732165-1-seanjc@google.com>
References: <20261021024503.1732165-1-seanjc@google.com>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
