Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634015;
	b=b2+4hrEHy86Bz7mhLXFSZUqB9bc2pK7LsDj1in3mSya96AejnpjdV8+WWIqUDZKYtS14
	 f0Tf0gfKVLL0hmJaFyNpA/hZet1SC1V6YkstC0edwNBAm5L6x0EuEH+Byd+BpftBdUhaC
	 WfZRCsY3zhW3mwR0lq6jLprvQzjNuGz6jUwBOc+hGQ3vkdnpc2C60GFufYrGwIoHFgixG
	 Bc9r5c01yWPTzbYO7y0Wt7kv4UO0MogItII979vWvsxGYExaI1eKdWnWGYenawTDG2J1j
	 oBMeGO7JTJAIqiDFzJ9kvwdkDLOSZnSg4qvNM+u5RBKjt9riallCvUO4va9wFVNPTrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634015;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=dUGqfqfNXJ+NeO+UdV4+i/sAm1iD+FfxTNuQmN5fXq0=;
	b=dtKxZ2WtwPWf9MU8IN2f/uQXnvOmtqR+ONZwddDah/o93w4f/ySX5T1Ty+CTKzglxqPZ
	 1vr5QR4brKABjpc0W8dgZhkAHVPT6Fw4wNjlp9SLZ9mnQnbakEaOI5UvJ48jDseqzKd5V
	 sPsfYl+qs6HkGJzNcmLon4yGg6hzkyBkBHykwPlDsH/9riW56OAFc7AKmamQQBzdsWMGZ
	 HS1ZCjlUSCOa9a3xQce4UGL2sI9yRlgi2GXqoSR4dQoQoPONk9PxMwsTwFqqA9uc6pO04
	 fWcD/2elKcy0dAA3/ggDmFm25bttMbfozY1TTE0RfpD1FqaAOzP5JhZQT7pKgIKXQ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ZJfGaKte;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1888606B1F4
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1888606B1F4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ZJfGaKte
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jJG9l5Jtfz8t53;
	Mon, 02 Nov 2026 16:40:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793634011; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUGqfqfNXJ+NeO+UdV4+i/sAm1iD+FfxTNuQmN5fXq0=;
	b=ZJfGaKteF192khBUuklQ6Xw5liAqkmoqqW286YTqNFHiTpfFVKhU6vHZWBov2skspqFpeL
	mLfoBIlwy61eMvsxsX82pHork/l398irXUM25j+A9vWkcejGFpaQBawPEvRKm1dCUVacI+
	zGmXMusCtsqZd/ZKrq1C68kLF4lfEKuvaLfZ32jmJLFYVb9uMa1Ny9PWjLT5sHnZxIK1Fm
	pSjD6lfRNeLVW/3PUwoot9U0SbkPaMRTdj4+qn4jWWBbx6AzYIfKe6H5ZiVUJvKLggSQ9h
	3av+HfeZfxm2MqF7YW6PvfYr91VF+xPDmwhJZQznfA8bQVy5ObGQi2jHOwljMA==
Message-ID: <72cba5d23a977185696db12ac547174708652bcc.camel@mailbox.org>
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
Date: Mon, 02 Nov 2026 16:40:09 +0100
In-Reply-To: <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
References: <20261021094227.48034-1-tvrtko.ursulin@igalia.com>
	 <20261021094227.48034-3-tvrtko.ursulin@igalia.com>
	 <84b5777a04dc75c013eb9ac0a44d972cf88db12e.camel@mailbox.org>
	 <6e113935-f303-4f49-bc27-e1d85abffa70@igalia.com>
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
X-MBO-RS-ID: e456fc94603ff365fc3
X-MBO-RS-META: 9zsm311osryyku1ki34bkx49oi936zaj

On Mon, 2026-11-02 at 14:47 +0000, Tvrtko Ursulin wrote:
> With FIFO and RR, on amdgpu, SDMA rings, only if more than one, *if*=20
> there exists userspace which does dynamic priority changes (calls=20
> DRM_IOCTL_AMDGPU_SCHED / AMDGPU_SCHED_OP_*_PRIORITY_OVERRIDE) on=20
> entities using those SDMA engines directly. All clear now? :))


Argh, maybe I should not have asked, but since we are here already=E2=80=A6


It seems that all this is inconsistent already.
Why do we even have both, priority and rq_priority? Both should always
be identical.

I suppose it is because we're in the "transition to CFS" phase where
you will actually need a per-RQ-priority (rq_priority), later phasing
entity->priority out.

Right?

If so, I wonder if we can't leave it be until we are at CFS?


P.
