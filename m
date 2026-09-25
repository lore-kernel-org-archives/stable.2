Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99664AA1C9;
	Fri, 25 Sep 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346293; cv=none; b=AUYzDP5BkFvJ3lLlB1n7P/Ghw96ZX/9vQlAgW4lCi7ESDXdlZYOCeSh3+XYbg7Z4sMM9JGOLREOP0KzyFOg+0ZM34iyo4Ufjs2YDZYqmxJKdHF5LU2EZcwuQedMkwSRIqauOdmpn6qnPqk3zN+PawtbYLDsOzkL/vddgw8cSapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346293; c=relaxed/simple;
	bh=Fo27gl1RGyenZyUjEKAJq11sc/Bjc3iIib4jpTRAiFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtC19OTaSxB5uLQMMXbsq51S2+C2yx5r5KaZ185q0j8miAtYlFGcVAGL3yx8oPRYxAH7h3A9OkqVkhiUOe7ronYXWU+b32pT99W47v3OUMptF3E5Xz/hOmcl+RvQ8oXsU3cZESiphJICHqGWywgE9BztBa6gO3wHM6B2fYa6cEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ioU/GpfN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ioU/GpfN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=dI6bBwIKN837u15LRjHH6yORdLJ9Jv+nGmfAtWoSIj4=; b=ioU/GpfNjfa62OUxfeGvW6DW12
	c4fgOUVYMwNTcttmdh8BxOz34aUZnFpQamcymo4bK7n2RKsLImC6ULN5ILwRQx0L3mIndvivp6eUK
	eZ60NC9rAIFJvLQauigufGK0ZsToOCNIEDhhtUsZ3tgSvkikb704pWnwbq4UnwwdAwFNlOwrdHzVN
	5SBGRXms0heZcKcsEkLImF9/lUYsNpeaHMzFlWfntWOC2a95HTCW2IJn/HIf97+XG+35giNf6Frdx
	yxYr2apycUzRbGpYGAmTPKCzalAj0NuS7SYCMb8zemr12MFzI9mgXZyafK5z7++NIZo+16zcQzeFg
	Ldks3oJw==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xA6qh-007BCc-9l; Fri, 25 Sep 2026 16:24:27 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: mripard@kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	dave.stevenson@raspberrypi.com,
	kernel-list@raspberrypi.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	eric@anholt.net,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/vc4: drain the hangcheck timer and works on V3D unbind
Date: Fri, 25 Sep 2026 11:23:17 -0300
Message-ID: <179034619503.422955.6530940008343029668.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915095103.156007-1-fanwu01@zju.edu.cn>
References: <20260915095103.156007-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 15 Sep 2026 09:51:03 +0000, Fan Wu wrote:
> Nothing stops the hangcheck timer that submitted jobs arm, or the
> job_done_work that the render-done interrupt queues, at teardown:
> vc4_irq_disable() cancels only overflow_mem_work, and vc4_gem_destroy()
> runs from the drm-managed release, after vc4_v3d_unbind() has already
> uninstalled the V3D interrupt and cleared vc4->v3d. A timer still armed
> by then reads V3D registers through the NULL vc4->v3d pointer, and the
> late callbacks run on the vc4_dev embedding them after it has been
> freed.
> 
> [...]

Applied with a small adjustment to the first comment, thanks!

[1/1] drm/vc4: drain the hangcheck timer and works on V3D unbind
      commit: 94cf5971b1d04c6382437387c4dc3836cc7a1437

Best regards,
- Maíra
