Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2F400986
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397323; cv=none; b=R2P9RalojckEnQFhdeUDY2HIVyVdIWrMQXdgvp0fjr5kSyZXWiVK9mZc9VdmGqiio9tpX9i9tbiu/uYHlAacLiP+NktXUjV101V5OcKOgqOz1H+fi3J1FIPlXmfVd8SsZcpz0nP0Ey1DDWX6LWbno3yR6KMfIkmf8HqChp6gJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397323; c=relaxed/simple;
	bh=M5AtDyHHOMlaumTgwZjkDOGeQkkIvvIvxFlfhdD7cwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jat5pCfjv3q1alMjCkkxBKRxU9iw3LQnua6A5sUWN9qj0vx6+7NhYaP0dsSiMdvHY+Netfeo6yu4pi1uLah2LHhxpraE4ssGerodIc5mLhNSprn7S0O3kdkK/s5YQVXZ7GSSz28SbqRGPrBsEXapCu+DC4Ta8Rxf9tdfAlVe7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ARwyPajt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ARwyPajt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=seNbymoRcba+dBQzFLFgF5NtopXFYp7K8Fp+GLTKr0Y=; b=ARwyPajtVtGQQ+hX31nzrDmTvM
	1Du3AzxeECCc00B6AVmZcEOKNe23YcyZCLHJT14cDp5/ECsO+Ny0VwvT+f0mMjoloBvhmm6Pv+mkh
	nHxs2y/MXOGZOG06oDznb7j7gdBi329bsgma/SptRzXia4LwH3JP0/6nr4AmNRi7KvB/zzqgnzJxs
	hteTFyE+dIEr/cByN9t74KJHnZ63rRLOVhnQkqInm5q2pgTUzEgQtBGgAaGSPfXO2f3Cna3XKbF+8
	ubeSNWkLrxX5BNBtnAiZa+fXMAtK/scTC7wcf29wzpAafxXb8OaGUoPaa9mg970H2WuG/X5ZxIRj5
	m4SVlwGg==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x67z1-001wqw-GL; Mon, 14 Sep 2026 16:48:35 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>,
	Iago Toral <itoral@igalia.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/v3d: Fix system freezes by serializing the GPU reset
Date: Mon, 14 Sep 2026 11:47:35 -0300
Message-ID: <178939723879.68746.4885647874791336675.b4-ty@igalia.com>
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

[2/2] drm/v3d: Remove the now-redundant reset lock
      commit: bfae5a8ac53e6d38e882d856000596f1da7df306

Best regards,
- Maíra
