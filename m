Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9123EA84;
	Thu,  2 Jul 2026 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952730; cv=none; b=HQoSm5xRJBUQQGtVykuCQBDKVXx5dAGVJhHBwAISOkm6WHZISBRvVxej2nPse76Ys649WBf5hyibR/IcNxlTkjNqirTT9g3Uqqx+G45/IEPiv0/P4mZhg8Zk9lCjLR0S5o7fDYaEe3ZHAiNemCffxv74WP7X2SMMlPs2PNf2kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952730; c=relaxed/simple;
	bh=KFloiX/NaoYvSItTJ6jV74rTn+xe6HAIwwjaM/RDAu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWmDsmAaF2/8Dfq3jXdtrxnvkMfzl+7tlnSHmZusTQ6bePi05Hz4dB86iM7RojNq07m8iI6XXKfQuCkcFBH3WZ9lg/fvtyuy07MVxBGZgA0Q9z70iQjZDEzWjEPtz/dPWRgfpoAeRQt/Hulf/B/+dt8krF025aVXr6PSqqC4s6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxZfILy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxZfILy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E001F00A3A;
	Thu,  2 Jul 2026 00:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952727;
	bh=xVHiH/jTz3G7qfQnR0AINzLrRVsN8rD7LEdf7ebVKcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CxZfILy5Y0CfqcgMFc/bXL1WVvB0yiBrqNn/fd3Z2065AIW3c0e6ai1Cli63tfZew
	 siPl/BRnZcMlOxShBj39zWKBLg72yOyuJO06Vk80vs3auHo3BA5ObsTq4yS4BJUTOU
	 a+wM4potE8v9utBdxNJYboeMEeDNInSsaZYr2aypnklHk2EdQqYKatf8M9Cf1iSV7w
	 52eLMdnbFYuW1qFUoxTgthX3Yh9DqnXhL6mw1cXzrEMYNnz3B+beoM+gM+JABEnEyK
	 V4wQyhsPMYMMg0VxtZjk/CjoXdPIn499tW0uDGlDBesAyXBKuiVDYznJy/7vxfsrgT
	 P4Cp3Xgg5Waew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kuniyu@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	sysroot314@gmail.com
Subject: Re: [PATCH v2 6.6.y/6.12.y/6.18.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Wed,  1 Jul 2026 20:38:30 -0400
Message-ID: <stable-reply-af-unix-gc-v2-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701065306.281809-1-sysroot314@gmail.com>
References: <20260701065306.281809-1-sysroot314@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit d82ba05263c69fa2437fe93e4e561cc40f4c03af ]
>
> Igor Ushakov reported that unix_gc() could run with gc_in_progress
> being false if the work is scheduled while running:

Queued for 6.18.y, 6.12.y, and 6.6.y, thanks.

-- 
Thanks,
Sasha
