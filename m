Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445F3AEF21;
	Fri, 26 Jun 2026 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496513; cv=none; b=HmpodTtkwUDHpPoAfeyzDnlbm/zjqRGxb6U6ONFqofHeo+wee6FFKlCFuHwBrM9348O6uZ68Yq3TjkW+BzfMyX/bBQ1Z8GaZxsYRSqpqUC58PEkmhZ4MRaCWJp/AYagzLZaqOaz8+5r9ZroXY0H0wBbC9cECvhz9h5NENbT2Wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496513; c=relaxed/simple;
	bh=IUhNWIgpjRgv1iTrQJwpKyLWt/jk18U4zmaqfR7xr20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re90B2/tb9MbFNO6XdGwssZ530L9HRNqxaPNcovld8u7WjSBMJu5M3MwFf+i4+EB6wYJ/1t8J5x9jLfp2VwaFQS4+/IxyWQCq+urfvVdL+M9Zy/A7iXvOhCOp9+AKr26C/5ihehFOR8IfexWOla1RsaVJH/EXLIuoP/8s2HWbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnv6DS5V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnv6DS5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30351F00A3A;
	Fri, 26 Jun 2026 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496511;
	bh=vYlgsN9Z4AbjSHyymQFtlqN19ZbyPZhF2fYXASOTKeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hnv6DS5V3l7VxROMr6+6TE9utD8/wVjwlubrWA/K+8Bsyx5L3pfTWw+WzGxmTL7/a
	 dyXDE+kI5y3o6imS7Nk2s894HMRpbSHRus8RD1/CbFBgmE/Ky+lRMRML/Lc6U4wj6p
	 ZRDkW4tCRWqXAn7V8EELCUacRYF5VFjzu6UcAV40jeN8PTPc1kxdUNzjAHDyU65nbX
	 5/0kihAiyUUXRC2IK2/5LJ1woUwwuMsg+cZnYLNdfQ86iTYl99nDy8qpzaTcdLPKcZ
	 95q7izOkwRSdwkimsz2E/4Fm+ilciL8tFOmpG5H2WaIYoXR0aqRqVxiyfbZ4w3EFka
	 VDQoeZnYDkrng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	cristian.marussi@arm.com,
	Yijia Wang <wangyijia.yeah@bytedance.com>
Subject: Re: [PATCH 5.15.y] selftests: arm64: signal: skip SVE VL change test with single VL
Date: Fri, 26 Jun 2026 13:54:36 -0400
Message-ID: <stable-reply-item017-arm64-sve-resend-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626-b4-arm64-515-preview-clean-v1-1-ad19e286e322@bytedance.com>
References: <20260626-b4-arm64-515-preview-clean-v1-1-ad19e286e322@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.15.y] selftests: arm64: signal: skip SVE VL change test with single VL

Can we keep the commit message the same as upstream? Is there a reason to
rewrite it?

-- 
Thanks,
Sasha
