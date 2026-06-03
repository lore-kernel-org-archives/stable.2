Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6E3A8FF6
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499682; cv=none; b=g3hCSGI4zf/Qqiftj7HDCMvs9n8GwUuBFigWYBpAr0jUbGEVYyApJmZRtyXUY4P3phfZhNO51nGAhhvagZl/Zfsc4bzYZUsI9ygKju8l4uCZV1Fm5V70jPGUaMcKDOcuCJ4PfxbZ+Z2boyZMRKPj2+tWuF4GhNptrHLdR7C+FH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499682; c=relaxed/simple;
	bh=hiv6JrGJ+w+A4aShddBGl4vrAW7YJaog81zYB9+ZoZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1fyXKlO2LbYR9im1D6pCO/Aon3K2X1OhZSn9mPHU6oiNKAfpM7wChVHALob6okGTObITe1sGdgB08WHlgw6rDsrjGM25LYSjlXSyvbSqCoHhL9ROEU1GgF6Gow9mEWwa4JdVOHNqNkEGOKP6nfIvXcoo/285XwBg0Bf3rnp2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkTTTfZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkTTTfZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D01C1F00898;
	Wed,  3 Jun 2026 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499680;
	bh=c9wec6HOAcXQM89KrClVf0Yh4yj9+WR23XvId5JFm4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkTTTfZzn5pH8qi7t8wDZoLfg9sVi7GrAfb/sLTw4SBDPK/jrkdXFyZgikPw6famk
	 KzAMQFXChe9bC4cqdhS3TbgBxd/B5OyetvscffhmwCN20FPg1n4wHbuvlJCETFzts9
	 0b8AkWtiXVWjYW3UNqO6v1L8SelUAcPdM03nhFRlR9RrMw94Ig1Kh4s3pUYgw/QIlo
	 PeQQYhYfOFmYuV1JPj/W+LeeX+t58UORMAXKknKwy2cFDZ6zIIDdIEe8xChC965xU7
	 /Xq5Ytuq2bZ+uR7koQYBxJelRn5cglEeioL9w4Oyoot2bRI8TUcvGC7HWi6tEIBIxC
	 JJZGs0HkoR//w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 5.15.y 1/4] drm/i915/psr: Add defininitions for INTEL_WA_REGISTER_CAPS DPCD register
Date: Wed,  3 Jun 2026 11:14:05 -0400
Message-ID: <20260603111500.item011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529080317.343937-1-jouni.hogander@intel.com>
References: <20260529080317.343937-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 7.0.y, 6.6.y, 6.18.y, 6.12.y, 6.1.y, and 5.15.y, thanks.

-- 
Thanks,
Sasha
