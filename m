Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786071;
	b=F/Mo0Kd3GKQOg7o7Oiwd5xxQhNMqSEFJzZIuBveRhKPpAlEMrKuwm3cpw0aqDqNb1zc5
	 DzvHdt2YCqN725EPG+BelKCUHHM+tM13hWMvRsVgiY3Vf5SfisrArlzXHdYKfGWBvlpWc
	 5dzx7wpCMOhc/yADsNd/RiRbfI1dzTVrNFXcU+ICiq4OZVIhri0xHUkRnJOiCM3FT+wMp
	 JfpvDAcxKkLnATjYJHg83QBjx7GVCTi9CDZrRWi7bNFXU9hDFkBbk7NPOdwUshDWDSExW
	 eK9AZeGpQejPra3PQlmsV+onKg7I2qdax4qNOvIdjkTczzStwX06PjXkcy5/vyL4yaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jk5MxHtazUjnLt0cgF87tkF1nMMgbWI4c7p97JcFQIg=;
	b=smPsWODPRyCOR6UwHLMS0g9A2iYKG1mYxKpt+bWGEZUfqn/fBqUJpxRnDR8EdfUuyB+y
	 /l83iwc94v14a9TX6SfVHUihLsf1cMzFznNVDlEmudQ8ZyCyBzDNL1T6bKd1A4TKmayzr
	 gOXYeX1xn83UufEtmGIbv85+h1MiztfFxSKhrTwxuv82gnmIw1qrl2WXvZ+eJOLPZWZ24
	 4bwNOZDc305rTiMUUQSADDCbv/0p1juGGvBUxioWqA+IRwKEapz3Sl9VWKpphL7hUA4n1
	 LxLfJ9eCVwCzLuhNs4Y2ApoQ/+lMlKQXsMG7hkgzX0d8OGjSbPj0+gzh6yGQV2b5qbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaVfo879;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C1606A31F;
	Sun, 15 Nov 2026 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaVfo879
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD7E1F000C4;
	Sun, 15 Nov 2026 23:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786070;
	bh=jk5MxHtazUjnLt0cgF87tkF1nMMgbWI4c7p97JcFQIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GaVfo879l6Q0tDc/K7TTSvJIbSEaHuAuXk8mYH4kzaRGCxsAQtSDcOAkpexKQ/erA
	 1F56JJSUCOhots0X0K14zoG9ulNad5GfvVsF8nfsEjf+nlR6D/KXhVUMCNALH/N9cI
	 4MU0tPmDkAIRuLY6hn3Auh796WEcjn4+YL4H3pzdpsxDZHjszIfua0lEo11T5zZ40P
	 VysBBfxPTjI5SR1CA0H5pbQlxQuryUbB7SC1K+BfrM1G4Bi/bFGblrVlcUSVOP7N2H
	 TNzpmORnuyio4FnPVDGn0ml+CCKnqlkDprFagc+HaOzE0GZ+ZzuxfrRmms4I9Ng4vn
	 vMUXzap4Zj/qQ==
From: Sasha Levin <sashal@kernel.org>
To: Florian Wagner <florian@wagner-flo.de>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [REGRESSION 6.18.y] ACPI: button: lid events lost since 6.18.57, please backport a004b8f0d3bc
Date: Sun, 15 Nov 2026 18:41:02 -0500
Message-ID: <2026-11-15-1-daily-reply-0001-acpi-button-618@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114164947.2ffb5ce8@teclador>
References: <20261114164947.2ffb5ce8@teclador>
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

> Oh; shame on me. Here's the missing attachment.

Thanks for testing. The patch came as a MIME attachment, which our tooling
can't pick up, and it has no Signed-off-by from you. Could you resend it as a
regular [PATCH 6.18.y] mail with the upstream commit tag, the adjustment note
and your Signed-off-by?

-- 
Thanks,
Sasha
