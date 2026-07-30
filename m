Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555837F725
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379257; cv=none; b=fFGYJPdy6V4ytz1M+ccGDbQFQ9Gz8I58+slzL60/nlcewAmwCpusqLpb6D3owt+LWdN98naBtfOxnyHTPk50OHwTaDovPIx8mmCurwyRJCRqFfPs021hNYwmIFAcs6tAevqQuNFtR3khl9leaAnKFfAt/xy0O/4kgYCTFJCEr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379257; c=relaxed/simple;
	bh=0miT5lgJHXQ82IFOLecmMUVR9B/LFq4EO1oop5trrtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5WnoryN09Q+kM8tl6O6FHkXNjq5CcCFFdvsgawfQn4qLcIBV5EQ4Vwv7b3DCzn4iOxSeLRGGSPCQRSUsmCzA1a0cwT27FpfIkOefxDRw1m+3UOY3f8/H7X6wPhSpsnJS/2wlL0iYQZAGWbNZHw89hAWu7d+FyTjEOaM4q4tf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUwotkTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUwotkTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB76F1F00A3A;
	Thu, 30 Jul 2026 02:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379256;
	bh=PIc9FNSp/4NTrz36pt+uw7Sd+U0d/7DiDzN0Lcl76E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RUwotkTYDu7+2rKnbpA7MZhhJ44ovvNqBASiN2Cm/uIOTwyW/V9H2yyT4W3qxDMLy
	 6mhIhenlNAWnM40QiA8FrjIOhs0lOsTyfyeZU5N/hnQo8J52D1rXtE9olWzCdHPKPt
	 ulrCp5/X5jJBesO5quhyPJYsfBJHKS2LLWy3h1EZsSI5CYZ1ECI8w5RXkft1YvKXQR
	 iw+6mV3vmp+h6Mutvw8Nrx9u7Og/eqKfkrqSg/2ZLGZLyYCX33rJpxQzdQjTABIjlU
	 VrRg5Lg5XHRSYKsWczTAs6qiIM5rdw/4hY6ALRAMvdtP6zdpDSYTg7+ZxQyyhBZtOn
	 DQVm5l5hYM0Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eddie Phillips <eddiephillips@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] gve: fix Rx queue stall on alloc failure
Date: Wed, 29 Jul 2026 22:40:22 -0400
Message-ID: <20260729223316.stable-0029@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729212123.1421456-1-eddiephillips@google.com>
References: <20260729212123.1421456-1-eddiephillips@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.12.y] gve: fix Rx queue stall on alloc failure

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
