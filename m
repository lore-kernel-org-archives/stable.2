Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E342EEC4;
	Wed,  9 Sep 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985613; cv=none; b=lpXQT11Egrl8zSyORb7VURjxd/PPhuT8TRaabL8FGTZAmcymBXSkudKFgq1+JN03Vj1lapWRy5jr2MqAPSAprmC4Sh9bdAXacGvfyQ/erWdOcff4yXzWDtUGybGPtbuGmwT9xj1ev24/9eGwi/ZdTrUfVqC60k5GYIJ22lzgcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985613; c=relaxed/simple;
	bh=goa2z8ykxWk/qcRzspCMmXGXkmS7VhcC4MjHalKWLeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyZqanN1+F/MiaC+ec7laX4M2kMRIFqGwZDsLudEh6JjXZaFSmlv1ejQiwDAofD/M/zfHW5XHqKaVACcctDQIG8nvl1Q7CEeI/JugGxqEc2slVbLyWy+NP4DZVWT9zOt0OM0FTOIRDbmLCgWFkEGWtPkVRwdqN+dyEzM9r7RsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCyQR8O1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCyQR8O1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A991F00898;
	Wed,  9 Sep 2026 20:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985607;
	bh=dybODAoFvtgg/GvfpwOhpk4/9NatfXxArR1eDHx7APE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LCyQR8O1UqxdBduBkTBBb3EbcX/IK/WQrTrnqZR8/doq2nJTVhFDwX1N6L6Rb7pB/
	 iaNAwLCSIZ4yJUzOrwKDc5obMYtNDcldoX2MADLr9MwoIRfxnDuESCgvfFYb31MlUq
	 uJT7EWRUUxQW3TMyVwZEiz3zyhXaGEzPtc8K70SjUZJ/jYq8pBEtdJaIxz4UY0KU4d
	 PNk69mrVPrmh/+wdkPCpBufhtTadm7kk94yGhJI7DlpZNiJYuvGfbNP8Fex5gmFNJH
	 cBmte/3eEsV4XDxstXUFi4LZwslC2EKZsy/wvYWDrctnT7ht6ezCUnWCHbQJss6EHY
	 +U8AxSTkq2ksg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/vaddr: drop last same folio access check optimization
Date: Wed,  9 Sep 2026 16:26:11 -0400
Message-ID: <2026-09-09-daily-reply-0013-damon-vaddr-drop-optim-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909061152.278678-1-sj@kernel.org>
References: <20260909061152.278678-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The optimization can race when multiple kdamonds are running.  Meanwhile,
> the impact of the optimization is quite doubtful.  Just remove it.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
