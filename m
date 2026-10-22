Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634669;
	b=04oURwx2j/NDRG/VkvluBN+VZtmVWxeCDHbayRc1aORWXkrB8nA2rzGBLW7smmkiKaWf
	 sOcSP9aTiX14gL++1FqpAIA16YxcQc/eJ7LSYaW4ln8n0z64s1gUbr6ib0Wyo2ShHpIBY
	 wL5ANrOKtksk7abBb8EbNHCCdYYUkfbK+bRB3eYlAenuw8Vfkx7KYdhXQ6hXGKGCB7bSH
	 kzRTP2U/UWQ8rOQzUXM9/E9qOZD5yPDn2r7Omsvw26WqmkMbUIKhnNXE+9IkhqmEz3spK
	 vBPLFSG0VVat6bPl9Awdeg/Y++mtw8ITkUJytQQt/drCf23P17bGXA7EI8CRIeEfNeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eqIAb+75Qior4keHXkQKTkAqaRImIdmHpze2q8qFUI8=;
	b=R9C1UNbHRnVTYfiOtbkOO79F3vbBHcstdOYivFzxPYja1DpTjc3ptAdfYx9VW1bA1g9/
	 QTQ0XhxyQ6f3+WbJVdJVmI/EomlZCczgPrth+ULc8Wg7OwlieUngRRqGYk+AJRTucG0m0
	 1XPvDPRLN62SUbFQa118JxsboZxo7toL64wQ6FnONdyy0lbv1CH4QuKWh7vfl1T3SgG21
	 sLWfm3vA8PkUYslhH7ZI57shKbC7ffeAr+VZznB5glU3jC3LcHbqNd/mPnnUBmfqJy1/O
	 LaXFkcBkukns5NDtcDnmYzJ/FaZeHk6uJvP/rp5D45tm5PfXjpRduCYszSTvI5PN78A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9ya21h+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19F606A339;
	Thu, 22 Oct 2026 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9ya21h+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C70E1F000C8;
	Thu, 22 Oct 2026 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634669;
	bh=eqIAb+75Qior4keHXkQKTkAqaRImIdmHpze2q8qFUI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9ya21h+ddlYNjmPvA0xQrrReH/72TcT4IDCXTbNoW3KeEUmZTXCLo7Vk5ZNvKmBt
	 DLukWZNRRYbDXYdonN992pJ6SwxEv/+FN9oaWLXrO84WXvQPCQRfAoO92PO4X/wUDD
	 5SfGCEaNmqtcLaW8mxZKSkxpLs8cyTpSpR3Y80E0Rq7fGM3eUbXm4b4gBGMdBUzo6n
	 esUk237lVuczh+gl81to5ImrtjI8nxUbl4cGkqGWW7pVcSte2cPbnINil5wnHOS1rU
	 RpE3uNPgavdJvgjvQ2TbpgJAbodTs/IfhkVFKs/meRYpBwNhvJHkGvJTle9TzOLZcP
	 VMxpgpVpswWvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 5.10.y] KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots
Date: Wed, 21 Oct 2026 22:03:53 -0400
Message-ID: <2026-10-21-1-daily-reply-0028-kvm-nested-tdp-roots-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025059.1736339-1-seanjc@google.com>
References: <20261021025059.1736339-1-seanjc@google.com>
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

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
