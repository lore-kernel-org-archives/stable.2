Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780320;
	b=Hws+44XrUBHXS77Uv3hOx4+mxgvWytzXeEPLyVICHyRQU1Irseicu7Jwep+A/52hlsC5
	 cKUswW690FFuAcVf6zYqzkiZzWKx3ME9igVGlm9iaAwFuVuVpbwyVT49vOIKCQELucnTs
	 j/fn8FMtvJ10HpcoANlVZOxNEfrtWuCyW0M5oLofyL4AD/jgRlXGwiNQKlhVYqTrTDKDM
	 C/xBgHPU161gOBXXXfV9nfbaUZPcLFfyALd6a30X3IavM/JwwXD8COcOP9prIASa9p+QG
	 J14ChCFOF6taeBicGQqiDG8/I55EDMg+5NINDLLGpfuM8ujTk9IecYn5QQixlsXDhDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780320;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-META:
	 X-MBO-RS-ID;
	bh=V7dDBAzV3mcLjs6XCIA+U1la/+cXsiOiJ/OxebKRP7k=;
	b=z0Y1Ch0+/uKqWjf71B8m+RKv7GBhFfCckT41faJ3wgFQ9yvib3izMswMcSCFk7bCZ3V8
	 8j4wxrwLcX1kOinFrN2aX9uKBpmN80d+PQpcHqWS4vdh7GFVLyBVQNo0zsrHwsCksijVK
	 BBxzK8+8lkV4BTkK9gGFkXOtvslEtQjZZbMgqDwzuR8FP4ziX932oW15qg0zWg9X9/7Tb
	 oKbdlKNfjbPuJhtuUJ5cj3Z1jN9jW/7wZ1LxmBfXbguvaT4w5pi0HGMVp39Gyco6pNhcN
	 9k0m1pUk8Hs9AqXfiaTeG/YYILVAnN+lLscy9vafZ2Bwi4dClUC2wxWyZl1O1K7w7xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YnV4thnu;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E865606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 08:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E865606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YnV4thnu
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jKJH968FszMm4v;
	Wed, 04 Nov 2026 09:18:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793780309; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7dDBAzV3mcLjs6XCIA+U1la/+cXsiOiJ/OxebKRP7k=;
	b=YnV4thnuEW3PAFCubKZxrgnv2WVq6Snr17C6oCPkZylvXsSeHgDonb8QhccRHYrbqohzzq
	xvstCn4AkHff7cfVZonKCpNz7+aOSHNimGs0XzWwZqePhOV+LthR9AiqcVuejKG6OS7SN4
	oC/eqGnniokUpgTDVeVNhPUGVE0ZNOHRm/EUToZrOY0vv6LfOl8kNcAPWNB7X/1Ma2y7ke
	MqYXMwisCl1bjq+S0JlpVB+um1aCmvIr+5Ke5yzc8l63+W/rfIRBMK28ui+3ayNm5PcU6N
	9rzeT/X96jb8PkxvGAxJE1c2C9GItxdtNCPaFLYO6Iz4ZkWFKFm1/K5D+qZIWQ==
Message-ID: <6e9a32c633eec28b9d5e539b9e35c00a26ea5bd4.camel@mailbox.org>
Subject: Re: [PATCH v2 2/2] drm/sched: Adjust run-queue when changing
 priority at runtime
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>,
 stable@vger.kernel.org
Date: Wed, 04 Nov 2026 09:18:25 +0100
In-Reply-To: <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
	 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
	 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
	 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
	 <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
	 <dd6e0f86-67e8-40c0-bf8a-1948623d0646@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-META: 9mcgfcds44eaidqu4m9i6i84qznefcqg
X-MBO-RS-ID: 77aceeb30479762a143

On Tue, 2026-11-03 at 16:03 +0000, Tvrtko Ursulin wrote:
> I'd like to get the fixes in so I can mentally focus on the continuation=
=20
> of the bigger story. Not least that not fixing it causes sashiko to flag=
=20
> the bugs, either when touching the neighbouring code, or possibly even=
=20
> just the logical functionality.


Fine by me, no major objections :)

The only thing that makes me a bit uneasy is
drm_sched_entity_set_priority()'s semantic. I know it's only used by
amdgpu, but nevertheless the reader might be tempted to think it should
only change the priority of an entity within a runqueue.
Could you add some sort of code or doc comment hinting at there being a
TODO for the future rework? Good to have that in case any of us is
assigned to work on different projects in 2 months.


Greetings
P.
