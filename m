Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CF21B191
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158063; cv=none; b=Jqefmdb8LhOLyYm3QHoXfSxCr6m4ck8/zaNV4Xqe9Iu0uhU8i1+65QgFWRtidDQZ93WbgqC9aT2g2RW04EP7AatKyuH/dH2zH/vojd5KdSyNcitrE7qLZolfxmwhOD26J9XgZmRmh4DQ2cpYMlWPPq4KfbwN4OcnUA8pp/o7AaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158063; c=relaxed/simple;
	bh=/PvDjwXfL4d8ojZL5Iw6Z4Z92K6WWr3yc+hYSgYDrJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REKd8Dc7yUbXo1SqTTI/dIxQtIXmy3tnMmEqWs/vHP1D75icbpRwA99Hcb+uMM9r5+iTphekPOc4icClaSwIfaDM2RRoLUbNMM/UeXmp1Jemxwm/ExC8l2eiS00oezs9S9D+aY1yqrtpHG7ziprUICWaACbjQScl5wApTLuhfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPrJA0ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPrJA0ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F0E1F00A3D;
	Mon, 22 Jun 2026 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782158062;
	bh=fF/FGalmczLJBR54/lDenR4pHv/HDXTywKKOe4nkhuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MPrJA0iiR8eKim8egdVAd9BVvc4dVzoWNo61L+3jGv4B+QeCHlrTfUzEvUO29wb2V
	 rwVhBj/pIEJmqOjE93GJZoOahovl/3ksbiUtYDuSqqg4FHqeczeEnBVtmqqfwbIaux
	 tZ0eGyn564BLd9EsBtQH3Jjdzu7GZKRpoEewmgoTxlIhXHtPYcjhg48seRDesUw3Rd
	 ZESxfqqUfgbBZZv3zQoNEyI7JjJLvoWfXb23WcQMg7OLvp0PZG3k+oHO0YnGUrJ/BN
	 bkzT6FrjShQqPBAZXraO4za3PHzZJBsqvrJHmSddunZobGiTjHF6ow7HgTScsAQhpP
	 3OInVvOsrnNCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [patch v6.18.y 0/4] debugobjects: Various backports
Date: Mon, 22 Jun 2026 15:54:14 -0400
Message-ID: <20260622152404.0001.debugobjects618@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622093040.582177124@kernel.org>
References: <20260622093040.582177124@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 22, 2026 at 11:54:33AM +0200, Thomas Gleixner wrote:
> [patch v6.18.y 0/4] debugobjects: Various backports

All four queued for 6.18, thanks!

-- 
Thanks,
Sasha
