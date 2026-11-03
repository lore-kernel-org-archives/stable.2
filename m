Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721804;
	b=tWVmvCYXg8Akeyf8OClI4tTAuuRSqMofUzNymlCSnbgPDdzJOpxclx5tvdE8Q1ykI8MF
	 HdxkknHBdLYocXsa1CvtV95FGE9MNgL6ok48TlKYnk5oledhHOVZawFhtHHusRDONBLkk
	 oU90UnhwGC4TByuS5A30DyvlPpLsxZMDAnrPfcgLsQ7ZqJ+UGv8prlm8zE9JX8G7jr7Va
	 BV2OeHIsw/Ng6LrBORzvklQpM+sQfZ5IIZkZSxsxsv1riC9S1E30sb1w8yRpOmVrSPuEh
	 fR/8/8SEESEXuLxXAMkBMr4N0Kfh9CncDBs1NhLfX2VqqJ2Ti4r6mq4iWUNOru4CIbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721804;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PmqAMN0m0LlKVLmim0O2UColmqtAweSNc5SBGMdXPZU=;
	b=VbQTYP+kpRWKuiLjpIH1Wrzom363tTGBophdo4vgpICnzDg3V/NHyzAgMg8AwoqvNgpj
	 QE3huQ7p3mgbxDGFGSSW+s3yDo+2jRgHMSIxTQOatvMcETP1NLnxEbDwvjigbeJinZk2z
	 3xh85gIKnN9miXksJu9qUPkUNmLWg5TpxgCn9rai2yhdeGOlTknrDn/d+sZPwa+AnY8bJ
	 dok6WdsMFH7sCORrbn+jIUrwJePde7SwrTbApvpD3REDMhrIp+pzNR/GxJoYN6Z9bXIfw
	 7YZrXCpHyzEJ5dsakfY6xySpZ73m9LiEdd9Awdl/g7Eccaw9bQJ/yyKZzR/AwH229UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZY00OjRZ;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E9606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD0E9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZY00OjRZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=PmqAMN0m0LlKVLmim0O2UColmqtAweSNc5SBGMdXPZU=; t=1793721797; x=2109081797; 
	b=ZY00OjRZjsRHrcrRdHBCMP9gnyLtt2iPBMAW/Si9x5InicUV2P3DjXpzYw6InBrGCo98Fy6lmCP
	5HI9hNDBlus51a/8g0j4dkVD0K1CXA/speMcvWS1WR+tSiAEaXFI5LbxX9BRVY7Ioi49q7O57CNR6
	qFaLLPiCo8l4LEMrVQOggZ3Xj0JTicmcRKYRLMipLLsfFTb+w+UCMtJv1SW1VBsghHDwYaWw1RubA
	humtgpJjEP6V6S8jY/xVpn+anmzeM5SHhc6ENExAH/GL11n9bwDXvK+zBcDvijP8jPyVlesv+WbHY
	4gEn99ATXLA9e5wJzpmLNZyJPICIOY9awMxQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xOGyU-001NPa-Eq; Tue, 03 Nov 2026 17:03:02 +0100
Message-ID: <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
Date: Tue, 3 Nov 2026 16:03:01 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing priority
 at runtime
To: phasta@kernel.org, dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 stable@vger.kernel.org
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/11/2026 15:40, Philipp Stanner wrote:
> On Mon, 2026-11-02 at 14:47 +0000, Tvrtko Ursulin wrote:
>> With FIFO and RR, on amdgpu, SDMA rings, only if more than one, *if*
>> there exists userspace which does dynamic priority changes (calls
>> DRM_IOCTL_AMDGPU_SCHED / AMDGPU_SCHED_OP_*_PRIORITY_OVERRIDE) on
>> entities using those SDMA engines directly. All clear now? :))
> 
> 
> Argh, maybe I should not have asked, but since we are here already…
> 
> 
> It seems that all this is inconsistent already.
> Why do we even have both, priority and rq_priority? Both should always
> be identical.
> 
> I suppose it is because we're in the "transition to CFS" phase where
> you will actually need a per-RQ-priority (rq_priority), later phasing
> entity->priority out.
> 
> Right?

The opposite - entity->rq_priority goes away when FIFO and RR are 
removed and we can (again) consolidate to a single run-queue. Until 
then, it is FAIR where priority != rq_priority (because everything is in 
the single run queue), and FIFO and RR where priority == rq_priority.

> If so, I wonder if we can't leave it be until we are at CFS?

I'd like to get the fixes in so I can mentally focus on the continuation 
of the bigger story. Not least that not fixing it causes sashiko to flag 
the bugs, either when touching the neighbouring code, or possibly even 
just the logical functionality.

Regards,

Tvrtko

