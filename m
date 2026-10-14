Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8372EC0A2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941262; cv=none; b=ng2qzVSAlSPICNUDRGj6I0oKWQ0/pZdjtahdzSS6bJ2md4tMT9ZfxcI7nuuEuSnzaJD8eQN3CSS6GlwKqT8s32NCxHr2bEoN/SUvJwbA5Qm/Lsj7yYUZwyxThIG/lSLOkMBBxKts3qLjr+BajbVNoHWIls5R9VFFg7SW/LLE17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941262; c=relaxed/simple;
	bh=/Jkjt8hBmkQGxlZKh/irh3Vz9GT256AZDFzjw+oxEUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FL5avr6GRRDXCwVjldbUfAqMRAUUT8KDR6rJpUezPNfmq0CNfWgFKhZXXE4B1t1QGOh65asw4K/ItrTy7XXixKk9ML/d4J3jdfXooI1hoUtnw5PB6WiM0nGFpoYZMulx6asxzoHlOxgsQ+mAwAPFHn0ThXchQ+xnxkKguTCaoP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJpaG23I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJpaG23I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CFA1F00893;
	Wed, 14 Oct 2026 01:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941261;
	bh=elzvRdi3CdF+Y6oWbnkz2J8mvRVbOf9WtvlOfGJmnTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJpaG23ILLbl24cw0Nnm+x8P7uD53qtOlgk/CAzsC+CzFS8QZd8UljtehQIsAR6ur
	 7c8ULB91Ug4gbiYaz+cm7mUbQYPqrBaAH9ammw1ZRge7qVGDIjZZHrrsEsK6bn72Yc
	 n26+68gwrdyfP6nCJo2CnyIUoqe16tXUtbt5aQ6uX0cVV/cPB2bi7ONgDw6z1Zw4OT
	 yEiaE3t9hQg7AppIA2PPz/flQmtIJPIeCKC+Ymn6tR7GfbLQGiJkCsMfaoQHq+vg44
	 0bDzhgXWn8xXpupa0WMim7zZPU6R7TY0eH8ivyR+Y/72pwXOdOVK0BlT0mTSwtGjk7
	 8dw4hhtiUvvRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Adrian Betschart <adrian.betschart@cinemaone.ch>
Subject: Re: [PATCH 5.15.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Tue, 13 Oct 2026 21:27:11 -0400
Message-ID: <2026-10-13-1-daily-reply-0021-amdgpu-sink-mode-native-totals-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012160527.8479-1-adrian.betschart@cinemaone.ch>
References: <20261012160527.8479-1-adrian.betschart@cinemaone.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Inserted modes keep the native sync positions; a real mode with its
> own active width does not. Compare those too, so only inserted modes
> are patched.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
