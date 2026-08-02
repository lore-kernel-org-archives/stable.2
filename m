Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F591175A86
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707629; cv=none; b=eTP05Pq3lVuX9pveqDAqp6ffPmVPE8+osN961ke33ljATQZ0yLUoXVKrhjWaH3+wlMqry/qCoZO18uh3fpwZaPEvP8ZeYKzQ3pDbOfVUU76AJrWsBKa2FXTRMHkuTRp0J01WCnf1Gz9SXT0jkEbUmo991XAwLGuREkNEVxR8zmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707629; c=relaxed/simple;
	bh=U9eJ70NHFctf+oa3DmwVSOlW2b9tVGqtt0bQ4EYSe0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkJYMJXBt88Dlqg3Ob/R0aRlpvAhSvQ2iFASSe7JI05iP0i/VriUMmfx+gWmO4GnCFf0GcQ7HTUb02C2qMZXksHhQfa3YIdRUUmBiQciDb3/NthyWhDKvs1VZOw6oAU6Yr0B7nLx+HiaVNgk0TwwikXjTsYV1tIIcMO/v8p15og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iKyTbVSE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iKyTbVSE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=5tW3gzMRi2JQESc12ri/SYeAcCCTrJ4+Im41jFFRNfU=; b=iKyTbVSEZAT2OwiJV8E1908GeX
	fRQJB2KtAlkp/+wiDW96FgrTOoHseADUdgCTBfvfNqkFO8WokA4mYn3OGogaNB0n5kZkFp0A1GhOR
	ZL4mnHmgSowBOulzEI+UmwGjFmtR5YntD8/upF2m9RzkOp0gBB1Z0DhtMKV/G16anzC4hmBLX5598
	6opc0pjT0ib6uSo/+DL+JzY5dsn+7D09UpRr8S/NJ79F44mgDoCEK6wV0xLcXwyT17+/3HNdmtW34
	k0AmXuXI8kJHRxzBK/dlVLcR5MT1welSKk4EveYKZIk379Zu+dj6sqqXUXHRgt9yEFjTQNiMFArWU
	Q5cdToug==;
Received: from [187.36.208.132] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wqe7o-00CiK4-Ji; Sun, 02 Aug 2026 23:53:41 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>,
	Iago Toral <itoral@igalia.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/v3d: Fix system freezes by serializing the GPU reset
Date: Sun,  2 Aug 2026 18:50:19 -0300
Message-ID: <178570741174.1182025.9933861973750671100.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
References: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 Jul 2026 23:09:21 -0300, Maíra Canal wrote:
> V3D exposes several independent hardware queues, but it only has a single,
> global reset. Therefore, when a job times out in one queue, the timeout
> handler has to stop, reset and restart the schedulers of every other queue
> as well. As each scheduler queues its timeout work on the system workqueue,
> those handlers run concurrently and can interfere with each other.
> 
> This can be reproduced on a Raspberry Pi 4 or 5 by running glmark2-wayland,
> which keeps the CL queues busy, while a second application triggers a GPU
> reset in the CSD queue every 0.5 seconds. The failure is non-deterministic,
> but it usually shows up after a dozen resets: the DRM scheduler warns about
> a credit imbalance in one of the CL queues,
> 
> [...]

Applied, thanks!

[1/2] drm/v3d: Serialize the scheduler timeout handlers
      commit: 4da94744707b27a3ae1197bdd7127da4505dc5b1

I'll apply "drm/v3d: Remove the now-redundant reset lock" to drm-misc-next when
the former commit is merged to it.

Best regards,
- Maíra
