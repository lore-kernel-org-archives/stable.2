Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789040;
	b=Hhs45doHNuZNggIEJDCEYmqMDTCuQYXUPLbF/MBQHtzOq029NQKJLagSclnElj29R9d2
	 cjhBZVH8qOfpFLulds8vA/TSzFuQruKhLz39z6DVCRYka81YjEs5dQnB+3ZQ9KR9lN826
	 Ug1B/l1P1B7Mtt+QN3uzW0U90sKR8cLdKQlmje9EutdGZClDr/fho8PhqfZu5K9/fmk6v
	 fJxVufEw+vp/4ZDanApilqoCjAkbnck2cr4wfS5Ru5IH/I8zKvjzpxa4Z+lTg6mHqmDiP
	 lwj8Mmnr5AiVMkAntVDTpw9CS51ZdbGNVNDgFWNzCrw09cocAeA31oSw/Zgb13Pi1uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789040;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=C1t2w24fWeOoDhxdfcptUtgJ8R2xYuJdVJTWO4qDgQg=;
	b=BlaTpku8LRK9NpDRCAJHv+x76gf6sTLjOjjj66KSdh5d4GzkZwykAZCFcanbFiSw4nQz
	 +hK41zgKAq4Av/M5BhoyKGSBUDoBWL+jXFcS3ZF4IfcMrFzckpH55zDe781xEpCtGbcSX
	 XRbJA/S7K+9cKgyaRN9eqb2gJsivsi0K5lla5hXW3VqqxRsiiagO3QohyS18t5e5+qs/G
	 HOsKXATRbqU5qukLP4M6cLpdHzylF8+RHcxKkdFPEg3erqG9ItTHX6h/1eu6/ymWBBtDG
	 ajv2o27DfImtyM3SVcvSj9zk8kwPvnBpdKW/8VOH6vH248qnGjebqrbCPBI+rtJIM7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=K8S+fZEx;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84871606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 10:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84871606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=K8S+fZEx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=C1t2w24fWeOoDhxdfcptUtgJ8R2xYuJdVJTWO4qDgQg=; t=1793789037; x=2109149037; 
	b=K8S+fZExBC/tCdblhl2q3P7xThqe0SGE5aRZdQRKBvJMIDaBJVpIsgrZtwfjFac7Zu+V127BkAl
	ZfmTpzqOtO1rFUtBvxiixKe3lRcfQTYkv2z6QtiIESSr4+sMzunglpmMoubCdTJ08rBka+/NCNe/D
	hO41/OrwadpxH0T9whL97ufVehgIeb8FL+nXwSTKCqt1xe6zc2JElCZboRQskioAAsrjkXEy5/dZa
	5fJIMVHZ6sykyY1pcTc/9MdzPGdBvaJ7j4oywfk/QUOQoiby6HFeAJ6DVxECgGORaSJZ3mp+RuuRZ
	JslgUKIJXYncC3QrPNHwMEZw+YhmMdi6p6mA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xOYT4-002AYb-D5; Wed, 04 Nov 2026 11:43:46 +0100
Message-ID: <7277f083-2d17-4bed-bdaf-e6c616cc5ec9@igalia.com>
Date: Wed, 4 Nov 2026 10:43:45 +0000
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
 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
 <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
 <64e2b65e-afe3-4fc0-8201-03cb72ae5d32@igalia.com>
 <7327af158cb66e6a5ac59e8fee413d569e85115a.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <7327af158cb66e6a5ac59e8fee413d569e85115a.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/11/2026 08:48, Philipp Stanner wrote:
> On Wed, 2026-11-04 at 08:33 +0000, Tvrtko Ursulin wrote:
>> I lost you here - what should the comment say?
> 
> Just a "TODO: entity->rq_priority could not be fully removed due to the
> partial revert of the CFS scheduling rework. For formal correctness, it
> still has to be adjusted here".
> 
> Just so that the reader sees that this is in an intermediate state
> right now, and so he's incentivized to git-blame the TODO to find the
> associated commits and mailing-list-archives.

I would rather not do it in a patch with a Fixes: tag, or actually at 
all - it feels arbitrary to sprinkle a TODO mentioning future work at a 
single random place like set_priority(). Could we go with these two as 
they are and continue from there?

Regards,

Tvrtko

