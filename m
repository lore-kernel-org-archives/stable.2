Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57403CF69C
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499691; cv=none; b=RmRkJXNE41HDFNAxSZmYeKGSTjLTRXFrvWW8bcELyD6ZyMuxAM6nF780ZfKnfMhUAvZpdAm2BuY4ZZErRatqFEVGfWGVb5eQiPP+3LVEOqs4IWBkaCiEE3IkLd3kH/4Km5LErcw+imKL1/bMauYfvJZNOwlvGkxkq12Z2XhL7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499691; c=relaxed/simple;
	bh=x2CyR83K8Ui/zDUZ89B7pi39PinAtPOk+fTNyDbzn4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bD13P6fS0tlWhjfFm+4uvwZ4mqMxq9XVfRg8ctTIGGKAFNMpRjlLVy2cpt7kHlXgkSxSDB0XD1hRmD4bVdhh0suyBTcUSIny0cXBm72tB2fYrHUBuWAw9ZD5EXaPUUrFj8eU0/DT6tMimcBVtNR7b8OZ3fC2aLvpeVltq0mhTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY71HQL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY71HQL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC941F00899;
	Wed,  3 Jun 2026 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499690;
	bh=4Kj4voNkYXV/vTBaXRccNGRUErzTkLYlawm8sg0S9go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YY71HQL3X8uxZd8gqUTntArVVdKl5vCKaLcTmatL/DbEvJi3ttGx1rOzYWRbUzJtD
	 qeAWNha0I/hJ8AAWZuF5msbqWPH6vRuu4CcCgS9sRkGl6+i5rP1IQ7Knbn0orXchL0
	 vHCFndUXWsrN9tuJWNMdVVPvBbl2lv9qJk68hpsvMYSTSz6PAEvZ0FL5Mak5cae2Di
	 s8fnCLU2GFBhOTEQxYmFKxm53R5vNFLmchjL7zusVsuBJVzqyUcezwhOPdCwNd220w
	 +qYEc8wyJULxZZ4zdjE2J4xY4fOaFmrQ8PHZcAH6cxXHD4aqGbkOR4jUXOQdmchrEs
	 MN0eI8ykj+2Ww==
From: Sasha Levin <sashal@kernel.org>
To: kuba@kernel.org,
	edumazet@google.com,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 6.12.y 0/2] Backport 2 commits to fix skbs flush pending
Date: Wed,  3 Jun 2026 11:14:15 -0400
Message-ID: <20260603111500.item041@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529092952.2555-1-681739313@139.com>
References: <20260529092952.2555-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y and 6.12.y, thanks.

-- 
Thanks,
Sasha
