Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFB4AA57C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322579; cv=none; b=DIS88Dkr9OStz89xTXdXPMUP5e5lRPRZ6ua3NlBxzYVOz3QL0e4gUIERfeLvvGA/ThAeWbtxLjRYmGb+5ZfMPvy5ZCSHbAhiz6jhzXmwv0u2eBFDKXYjkiL2To6u8BgKQFuTOXE9JWxr42vChuh0L5HBklfYcgEz+MfQwbRF50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322579; c=relaxed/simple;
	bh=+oIOcj8VQKn8rzBNXnGEbEI1dDgL2TrzpG6uUFSmaIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh8OYx0gVs7LiywsbHtIU2vWazUpXncLv3Su7OfARSlYUxi5p5gOJ2ZIkx6b/Uxahhg+8y/74KRzUskCTNtpUggnyQafwapY7kNT/p92k5bNyfJSSqey0m2KuI/H7ceTsYJsgyb7sGRgrr7jkVOWP752UJ+8VeN2y1irXaeb3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaRAjPjy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaRAjPjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1D11F0089C;
	Tue,  6 Oct 2026 21:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322577;
	bh=VfDGpSx+5kTu/BBw6xoWODccHJOIX+rnJJVW9O4sKZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IaRAjPjyzBKgVPjB2mUm1OlinfaAqoSV7NGEtMs7i4EyVT9omFqSZULyoRO/07bSA
	 ch9ZSRBGpWiVoNf5nIjlQSyiM8kZgfK+RjSjzT61cFCo1G54CzhS7Bdyejc37xbJFM
	 mRK/EScoJn/EWRP1Hlrp5foRVE+CoCl6nh4rR14/uaadMhYC7T1mGlIxY5bG14zsGO
	 9DIQxQKsUGxx1Sih1AkfOVntzPyYdTO1er4qvh/3Pi54vkyLSL1D7n4Ew07F0m+wvl
	 4ZZIMlxCvnnAVm2mB/A6j6iql2ZVyqdKoyQRxJ8PBJc18D3NeNzjjUBW+uFHQCRqyZ
	 sNU3yFJo8HQFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH] ipv6: use RCU in ip6_output()
Date: Tue,  6 Oct 2026 17:35:38 -0400
Message-ID: <2026-10-06-1-daily-reply-0006-ipv6-rcu-ip6-output-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005-cve-2026-40158-v1-1-98505c5ee970@bootlin.com>
References: <20261005-cve-2026-40158-v1-1-98505c5ee970@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 11709573cc4e48dc34c80fc7ab9ce5b159e29695 ]
>
> Use RCU in ip6_output() in order to use dst_dev_rcu() to prevent
> possible UAF.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
