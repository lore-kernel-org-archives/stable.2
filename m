Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D333DED1
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158064; cv=none; b=mCt03y/eSlmRA/wB35LyvSDr9KrcU9kAT8GwU+fFepGvPIbtxoR3WPvcAmTXs0X2Ars5dLTF7IUH5dRx1jUXh4x+ABD05SWBco7gdHR/zMMQ3nNU0owfofENlPRG4sFKIvEfOtNZwsl43zkjn1mRzlt6scRPVrBhRDNkxrD6fnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158064; c=relaxed/simple;
	bh=z+yKGPctkXtrqzlOFVfxaUZm9dDT1mByGKm4fTMk0SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU5OT3JGaknoNBZSzraa0Yadn2uzruHwvRYG7x4ZH9H9TWlrpQcvAPQPiSvP0RocofWAAYzot+gsCWzanNi2A3sRnjv3JHIX8Fq/TCFaE+AqAEiR2Op4jyWemnGidFA0AFHhfvJ9m0U6H8udckWxJ9yPdAENKQtH+tfjp4/Gzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZm/Fp8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZm/Fp8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77641F000E9;
	Mon, 22 Jun 2026 19:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158063;
	bh=ChGr4CDKrr3t2FLqZ3WopCMCzXc/wGBqJ51+tXXhYwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mZm/Fp8N8Pc05zu9cCj5C9DMh2Xq6mP3X1GduFiCrJS35OjroW1pNRyAzHDTaCKOO
	 4fuTRfoycY0sQijp337IwnBvIpWIrr0125J8bq+blhyAt0fziriW0WL4W44dC3XsOQ
	 HWxaUBPSmJxISL85uY5Li6N02vbxt3EcHoOytpqj6/NId+wpCxkmie2GmhSOrxR50r
	 gjphA6taJnLtCcm9GEezZ3ykCBgi+W8jSsv1XQRO6ky4b3UqFijHhqvTjgo+dnZH1G
	 ZsOBIWpbFZhGXa7xtIf3w/VPrIHhXsl7mm1pvx5n8vs6arN0bFrFnaOfvglwGLmiao
	 Qm0SFlpf2qALg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [patch v6.6.y, v6.12.y 0/4] debugobjects: Various backports
Date: Mon, 22 Jun 2026 15:54:15 -0400
Message-ID: <20260622152404.0002.debugobjects6612@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622092400.929691694@kernel.org>
References: <20260622092400.929691694@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 22, 2026 at 11:55:08AM +0200, Thomas Gleixner wrote:
> [patch v6.6.y, v6.12.y 0/4] debugobjects: Various backports

All four queued for 6.12 and 6.6, thanks!

-- 
Thanks,
Sasha
