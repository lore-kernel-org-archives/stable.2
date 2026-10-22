Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634665;
	b=5dRMFdBobZ2C5OvJF02/FLag6fuGP0ax7BRx6eR9TdZcy62iRkJHcAFDKMU2MBk7KKzi
	 y6ZB1TRalnZm0lCuuFJ/vIH41BftJ8GS10l4wl3vAcvBnozSA/Hu2WJx0cdPkBIe1V/NI
	 G0zYMiZBRbQCZ5b8Eo+HzUe1ZinEMuSu6CnuGDIhGkm+jsRyxoV/C1lRQBzcieIKR19z5
	 sOuxw8vM8IFdQPaNMca9eht5hCnd2MbrTqk0ZrMwRROEcbGlQzBPX7RMbSHp23f4YbINv
	 KDtY6ojE+aCjbgiPNwEBARJDt9igKLujvHng+4ifRTVdyl8mL1l5qnhi6SC9Go2CTHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pAVn1Jol9qboT3oLeJKITovPJxq5Jfw12f67icchhi8=;
	b=UmvNp+xax6SfnOhKxFSRTcYpK36Rjgfu3LtUSxXhwAwb6iEKl/nV1StJBm8BPLmx1svO
	 Ktw7KM3qERqdqXl/2MO69hpL+z6vMt8xP1s+1eGZ12PhxoJ1o0Zd3wpv6NMIP7lKAVyKX
	 dzINP1iYkXcgCKXFbRKIpZyXBszBvsnknJA2yI2zxk164bAvrzi+ZqQP9kZgcQSleujBL
	 E9/TCGLBtW+xtnvOEce9YMFSjnX9H/Ik8P132bCxQmZQuEJrIOTF5DfhyXB5xklT9ilHF
	 mMbAIsWLoCrIgkukDjnrn3xrcZKlUxIjp75GKxe8y6ZOlBY/V17k9xVAoI4IQceTA+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0hO6Ggp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0860606A31B;
	Thu, 22 Oct 2026 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0hO6Ggp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB51F000C2;
	Thu, 22 Oct 2026 02:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634664;
	bh=pAVn1Jol9qboT3oLeJKITovPJxq5Jfw12f67icchhi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0hO6GgpN3YTS/d8YEcmcRqlnsfYUU7+3hPMRKdQzBtwTiCi+1iCmepbVxtl1OZLJ
	 5YZ8GXEWLz4wIURJyh9K2Pi5YTjos0JztHVRKyFafNQL5YTWmo2gzkkVzrrAM5RiXb
	 qUrsz/GJCnn4EZ0A73HhCkHDA0FCxCDdzxSMoyQX9iH/z6TbZDIQSB2SpZJmCdC0mH
	 7/Xz0poBAPK8W8f2KmmOxT+vSnNjf4tQJSPweWWW6JmU/9x+3uAEDU8GOhINMM2QEP
	 xW/emOIkZW41KuXQzjG/gAO9beF8nDTeSVEiTquQ2ZtPcWFpQep93dIu80yT34UM+k
	 QFY6tc7O35f6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 6.18.y v2] KVM: x86/mmu: Preserve nested TDP shadow page tables if they are used as roots
Date: Wed, 21 Oct 2026 22:03:49 -0400
Message-ID: <2026-10-21-1-daily-reply-0024-kvm-nested-tdp-roots-6-18-v2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021021635.1710327-1-seanjc@google.com>
References: <20261021021635.1710327-1-seanjc@google.com>
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

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
