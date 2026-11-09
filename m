Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184490;
	b=OnwWUBw8H8Y26UUR1pz2K5+g2aZF6rdMI8AV52xWyqDQaG27BvXSPDV2Z0jUfcEWLYoL
	 lysvYrAxiVnu+3Jj59Ujh2wpuPg4zI3X6gh4yrvvIRYCCv439+wszPc2fTCWMbq8iJ/r5
	 mh12O+/b4UVxP246ImpUH2UOoWzikpDvRmzC6FVo3jf+5sG08KFvGDIquMnFnjmBCNdbE
	 +KD//mSEdtQGn0PLerh2HIHPwohXl1m0lrJ7PcKqkWQj9nId6iColVHkJhv8XV/wg4K8L
	 P6qYP+Vat/1qThrGzWcBClI3diBW+AzWGobkrAIcAAFpRbABreod82sMOoRrRT528Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mQLS8kfkESIX41BEju9LI6mfLU2iWBdkxx0IrXLaQRc=;
	b=EjFqgaV6G6Xwq29CFT8HwGQNx7Uo3prPR2aZcpOZ2De/xSXICa2w7+SweOaI3NNhbdHO
	 JvGQSDzt7DzwxPezOkPdOz2LKtLIYub0SiXYfqWGhQOl3MUzfuogPJBH/e4h+kppAoeIK
	 gosCrJCaeV0h6zH9EnZ74nSsqoYttW0k2FiDla+MTv5LzEIA7XF8xzFu4VWO0of6OsO2B
	 Z+s/ZXYFmaGKMKe5coLOND25ePahGQkYMVFu7ZHovLlaw4vVcCddyeL2D/2lguRYz1FYd
	 rQW8ELyqUrZXhwdf20qCaTcHENoELEeugVkt4GiWWNIcrYnoX72U1sGrTjbO7bjE+uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cscvp72P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF6606D811
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cscvp72P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402E81F008A2;
	Mon,  9 Nov 2026 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184489;
	bh=mQLS8kfkESIX41BEju9LI6mfLU2iWBdkxx0IrXLaQRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cscvp72PmrE8kq6VVrsQHdbYsO5c/3QYAeqRf3EdSFpjOt4IV6rPRJqw7TNvOsVl+
	 jS4RgLsyTpeWcHlmtWK91+HnYrXauKICUAOg/VCNPxJoPeg/3R7CKAE6iNNhsbTnIK
	 xXp/ZkdlQ3FDozXB4nyTKiAF1JYKauljA+8aCAlFAiknXgdib1pbubVHmv3rNfwbfN
	 xLh8YYsmRs0Qwe6hbA4NOPu/dejPU4IIbkO6uUu2k5xJ0gQBeciOQhZhlaz/N5mGJ6
	 qLm2q68xCKfJ57EXsXTjOUS7yb1ZgK4dyxeoFhRrylFN8XinghjPckMMYUwhkWnZvx
	 905UZvM0EOujg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 7.3 2/3] cpufreq: CPPC: Select the frequency-invariance callback per CPU
Date: Sun,  8 Nov 2026 19:34:35 -0500
Message-ID: <2026-11-08-1-daily-reply-0007-cppc-7-3-p2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108112738.2566137-3-christian.loehle@arm.com>
References: <20261108112738.2566137-3-christian.loehle@arm.com>
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

> commit 21e018235d99bc86249b034c06646df8757b2852 upstream.
> cppc_cpufreq_cpu_fie_init() initializes deferred work only for CPUs whose
> feedback counters use PCC.

Patches 1 and 3 are queued for 7.3.

This one doesn't apply to the current 7.3 queue: 995e7d468070 ("cpufreq: CPPC:
Create the FIE worker before enabling PCC callbacks") adds
cppc_fie_kworker_init() in the PCC branch of cppc_cpufreq_cpu_fie_init().
Please rebase it on the queue and resend.

-- 
Thanks,
Sasha
