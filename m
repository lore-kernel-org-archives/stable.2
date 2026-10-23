Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785788;
	b=T+Fy7m3x0GjED7uQoqP2irHksMfL0gzzIItzDPzYqwdU1HcZDkXYMd0Nrg8FwHxpPxPt
	 DcRi+PRRHob0Eei+Rsg2njqlaUyoKgf55ZkdKbqNUgt1NxUjLquaX9u5FMVbY+M6jXAMI
	 brAwBIXvt5YhokrhGyCEQ9x7xuqwGJFnooXgy1+y04pf7+ouCx9RxbuR5Ij7WG/xheC3B
	 UIyaFZdAWkXs4T9X+EVuXgiJshU5PfsrbPGXv0RwRECbcRKpLc1KUhR1AMNuhTw7PvNF2
	 8pCCVQ3Jpa4ripBF3n4yKD17s9CHSte9KKRUed+zO/mc/FpPTpwHVePGLqCNE46sFFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785788;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VwsTNUIWgPGNrUvwHU2JTnkVF1TKtK53W++DxYs7jXE=;
	b=QJ6dOMg5Nu9hd6zZnlrw+aCoVOMjIopZygYeiHYw04Iuad0X15MF65fUEUrlcRM/vQp1
	 /Jtuk9fuNv/N5UIjCOde4xPtqRd9iZSeNz0xiPbBifgrAV7/j4FrFb1hnxQcsnSh4LJ1u
	 DEriEhR8m3D38Illiegkga6uLI/IuLvANdkxdx6z0TnVPKpSDW3aq06aRwo1JF4wdtZBe
	 WJsOZVPiFUJRE9Rb7uRvUGhHSROfr+J0LMBUnaAbifCByu4ST3tNfyM/sGU08mzqMTPzq
	 qCkOQas4n/SmfU/aYQNjPpPep0dmtpGi7SRusg3og2MC+rK+yiYUKp9MywTKx2jQhYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Blr3eB+j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A35606A330;
	Fri, 23 Oct 2026 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Blr3eB+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416311F01825;
	Fri, 23 Oct 2026 20:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785787;
	bh=VwsTNUIWgPGNrUvwHU2JTnkVF1TKtK53W++DxYs7jXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Blr3eB+jadRq8XnnDJI5LiUGJYjybneYXqIdZ10tcNU5k09Uus1d2wZWZgI9Qm+io
	 lk1LGvRT9AouoNEAHgaMcgOjZxEgBYhTXNmKosueDRi8QiL4Wbhlj+5oe9JnPBeCcN
	 PTTzQGOpkHzUXbfG9uV79Fcbfc70Ktpu24KXjX7t7+mNM4dK5M/gzyo1yCb0PqXSns
	 p0KgBluNj2HqiDwwcQ5XTqDHvW/i6KHKm54yJ4NM0iTNvsZAjK1p3C9QVbTTIEtqC+
	 XICQv/+OUFBTZcj8A0JC2Zxqv5dm5U31HLsDy93W8uDcGhN1gvPBKAZVuMb2bTBRRp
	 u+e364Q3fQLcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	fuad.tabba@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aaron Ahmed <aarnahmd@amazon.com>
Subject: Re: [PATCH 5.10.y] KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save
Date: Fri, 23 Oct 2026 16:02:47 -0400
Message-ID: <2026-10-23-1-daily-reply-0011-vgic-its-null-collection-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022174537.2767-1-aarnahmd@amazon.com>
References: <20261022174537.2767-1-aarnahmd@amazon.com>
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

> MAPC with V=0 drops ite->collection but leaves the ITE on the device's
> ITT list, and vgic_its_save_ite() dereferences it unconditionally. A
> guest that issues MAPD, MAPTI and then MAPC(V=0) therefore oopses the
> host when the VMM issues KVM_DEV_ARM_ITS_SAVE_TABLES to migrate it.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
