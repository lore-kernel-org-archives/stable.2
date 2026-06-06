Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B68346ADA
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752697; cv=none; b=i6M1xE7M7qGDUZg4gtNSCO8acejOaumchMmWgB6pUbjMwcv0pKlSQhG40nIiqloG0y4z/q9fTZemwCeo7OpoJoZ5sQqm5sYlPCzazX4yJWcy/XCa/CNnSP8XDhe5OSRJsYrnsPl4tBuyLtC9kqCtGZymKezRnILDPFuTRYJ2pTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752697; c=relaxed/simple;
	bh=r3MvCLHn22H1sDApLuEBvy/ldspKp1T/unyeNRwQefU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2r1uqGNWban0qZGAPFXUByi6/28dl1i83Z5UkkvSoOQPXDxflBOxykC8+a1aLKK0BbFfoBbZuEGqePLPJ9XjuhS6JzFpKdk2/bA28P4xPqBPG+6jwemXlZ8kEyKkpth/rGdDy54yMfPjs6hO/Fq9Z8GNGyGjBGhI6vwRqLbPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEDmyuIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEDmyuIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5F81F00893;
	Sat,  6 Jun 2026 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752694;
	bh=0JyHE6T5pGyjMJSzEetwvTLlPbxwA+1Urrm7MvimLa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GEDmyuIwGzWbRJ39iCMo6w9rZFjl5asOyYSIhu6lBtYhZMCjYWdHtHWYKu7Pr3eM1
	 72t4Yd+/HpXD1kJJF0wrF0C+b1brnqj7Gdo5tVwC8loY80+hrhZ9OphIA1xOwfF54v
	 UtAUpEKw0V1Sc7XRH4BdW12hVxOZ9eMdNlgwSUcAj74aLl6ZXZw9jbP0paNy2AdQAd
	 0QjUKRQTPuZKsarlsstekoFXKWv9CTqQnFV3mLCYCJUvoXfIw12coyUwWH5HhrPaeN
	 P2PYPMhG8aT1X8ghThqUwc8mEokc+8MBQdUL8sj/W/uaAEJN1nL7AIjwfJq+fBNjoo
	 Q4d1xoMd28lJQ==
From: Sasha Levin <sashal@kernel.org>
To: herbert@gondor.apana.org.au,
	karin0.zst@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 6.6.y] hwrng: core - use RCU and work_struct to fix race condition
Date: Sat,  6 Jun 2026 09:31:20 -0400
Message-ID: <20260606-stable-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605093047.1672-1-681739313@139.com>
References: <20260605093047.1672-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This doesn't build on 6.6: <linux/workqueue_types.h> was only split out in v6.8, so it's absent in 6.6.y.

-- 
Thanks,
Sasha
