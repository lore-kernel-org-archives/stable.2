Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56123290C2;
	Tue, 21 Jul 2026 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638706; cv=none; b=gVsRKjqyKtYo2/BZO8H3qWzZ2FGll09JBcBbB9w4MNj9xCG1zkQF1odk/nCEiwDZpxEwRzljb7m8/iz7fmFCAqY2cr1LBr0blvbvMy8udqV+xgivKePM5WItEvVwPqbeFJ4rumujr8AFb3pjQfjgwCHOZG+rqOq2GwHwnSYJEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638706; c=relaxed/simple;
	bh=7xPCDOizQ1u7SHrQhIIgtw5kShKYCbn8FfDfyS5wJ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXNP1tDtU08xexoDqcQPT9Y+oghhjbe5p4txaDSr/y46YGvHV8lHi6fsVxqAhkvjCdaeMw7opc3j0DoP1AaYdGthPlEmaRoTb5FpR5KqJvsEp+c5WEZIcXSluYhFpTbCa4/ZFFrFXjcRjBOfguOycz9HEu4xaC5O3GxpQhRjRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ASoppT39; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ASoppT39"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=yh3N54zLlz8BH1XRK2/9xSCC5x98Z1QaeABlZ/LsjWw=; b=ASoppT39WOgGBGgHWdkkvYQe4S
	cJgyLlbSl6I3xacjY5qv6/YFG/MZ3TDEDXQh1jv/Bv1hjP+/9pdzequpKIBhwr+3pCw6Ux55C62Dx
	oN+Qwdtz6Rl0xsqu+8drdNChRqE0jNiLDG4IpMdXAs6SpZg26+k/VoZ6MLvJKC5EjoXUVc5N6z1qy
	JFMnl4H2ALF/pa3y0BlkWPr2gds27JlpVHf/rE03+i4LP/cKGqg4XoDypipWPT/JnYZGA1LNZmLXU
	GEjBj71FkAFQqEp7wtvzl6E3VhFVX599EfedQ1Y/B3HOY0bsEFP2ZC33ZbhZJk8dqvr5Y0u3OiBIh
	3kCAipkA==;
Received: from [187.36.208.132] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wmA2w-001bms-DV; Tue, 21 Jul 2026 14:58:06 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Linmao Li <lilinmao@kylinos.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Eric Anholt <eric@anholt.net>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: Prevent shader BO mappings from becoming writable
Date: Tue, 21 Jul 2026 09:57:32 -0300
Message-ID: <178463864902.189636.14796217669170863767.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721011558.1672477-1-lilinmao@kylinos.cn>
References: <20260721011558.1672477-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 21 Jul 2026 09:15:58 +0800, Linmao Li wrote:
> vc4_gem_object_mmap() rejects a writable mapping of a validated shader
> BO, but leaves VM_MAYWRITE set.  Userspace can map the BO read-only and
> then turn it writable with mprotect().
> 
> Validated shader BOs must stay read-only: the validator checks the
> instructions once and the GPU trusts them afterwards.  A writable
> mapping lets userspace rewrite the code after validation, bypassing the
> validator.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Prevent shader BO mappings from becoming writable
      commit: 0c9e6367639548307d3f578f6943ce72c9d39087

Best regards,
- Maíra
