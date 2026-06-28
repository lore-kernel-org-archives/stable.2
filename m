Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26751175A6B
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617626; cv=none; b=lEnq+1Y8MRUC/rBBLzb0z+kLOpexboDAlG2rGGdQd3oXkObfSVO56dbd50hkZmPOyw0QRqrmFmTmzDES1dKqFMcXqGahR8APNNgSZemDZnZJHRMTbVU5iXzO2RZ2itUsiouD4A4MUcdpGKzWMr+GIDUEVJwf+LHy86t0UNGY5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617626; c=relaxed/simple;
	bh=hP7w0RKjGVbkExDO6sJtZqWhwFo4d9OVUD3xtdQQ7Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKYYq0MKwnSxEKxzqG/A6YTZt6gcWupoLYkwk+8pBzYpvBgfArJRUHYHsH1ySlSbRnbLJCSwKng66RoWgSZxk6ZsDz2cQ8Ti5fkGXJ/r8G1DlsUKSvsiSlJq9cZQNHyh36B3pLxJNs/ju/C9dFDyw0zp7Ii728HhkgnaMNQZOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyhuiDvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyhuiDvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875461F00A3E;
	Sun, 28 Jun 2026 03:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617625;
	bh=hP7w0RKjGVbkExDO6sJtZqWhwFo4d9OVUD3xtdQQ7Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyhuiDvHMZ4AWebh8yOKHyOqTXoAzm0wPp+R/3fbdOSJi3PzbKuXyNj/EabhxkK4C
	 WQX2fLc2jIByQ0ugLoz/6OjS5frvOkGVoJ6DZH4T9ClPzJK9BGUfvTMFUVIhgN/bIP
	 dwwPuiweAFc5x6RaXi/E0APmQ+s5ovXE8mgbnPHspByZMv0m1sU+dfUzxiWtoxzvWQ
	 UAJWrEl7XfGMXNAF/SOS7tsextc4Ac6eZju+mOUtxpZ+YIiU4VZN335HU/psBmw6ir
	 5sgqOrMKb1blToJGUk4WtVnavK8BojfWRoHRSYE6pWybHFxQrU6Peb/nhLIcm6IMD2
	 zLnUfRdnM3x4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 7.1 00/26] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:32 -0400
Message-ID: <20260628032401.0002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 26, 2026 at 06:12:15PM +0200, Sven Eckelmann wrote:
> [PATCH 7.1 00/26] batman-adv: 7.2 merge window fixes backports

All 26 patches are queued for 7.1, thanks.

I just fixed up the backport on patch 10 (and for all other trees).

--
Thanks,
Sasha
