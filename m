Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD23806DD;
	Tue,  1 Sep 2026 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271494; cv=none; b=aWbgmAiBlE/OOaq9UTqDM4MXV8lieCerKiD6PhTjE/Cp7tpbeauvp7zY1aOXlspNRUZcNpoR0d6AneZdMJ6POjzNp2YCnAv4L75D1Yoi+f7v+qiHwVk+KEQRH/VjMlgtc+x8gQp9w9O2djo2kGdt0/jcfrJiT4R5o1UucNF1Qg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271494; c=relaxed/simple;
	bh=HbY4DPrMJkx3De3nTHm3fKl70R97kjMHbmWTQdki/ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoG/Q2iuaueMctwylMFIhe2gtjuUl3JsuXkfeOJX9xn/JUmsaLAfUx7LrE37/aate5EIsNaZxoRjcT8G5fT8SudnCS849T+wEANU2R/5FN7asorX5VQ/hB7cAO0AaAnChcMUei3faplsFqQxbQQsbO4OkFvK+TmfPUrhbhcDCvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un8UzOe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un8UzOe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD371F000E9;
	Tue,  1 Sep 2026 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788271492;
	bh=jPLfUhAriQbeMNme/A39zpXETQORrdj67BYHQz8lV2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Un8UzOe7yvDiZlaJZYrUAKFkDH0TegzfLYcYwy+uq6CIxgPM01vHXE/PBTJaAXpT+
	 8RD+s30Zgh3pa1hXsVaQ1qrZywD1ADplz+F5qoyL3AmIgUCjpgRaQoJ6H5Zo9/U8oA
	 UatVwWKsocdWy/GE2xJ/pSlMMVpbC12NG/Y6dyfRtKvKASHCcP0nlcgNkdWWjUlDLK
	 vWoFZc732Pz2vmoSXttFuMD93jSLT7QToAF3Kpd8tL4lKGThza1Z7hF/7/8am6ufN6
	 BpjGPsn37pyqDkFAgL+6EqgW2FBfuytFEx70wR/cF3SPuiXzYolByTX7WNHJpXcLCw
	 8fhzaK4ghHrNA==
From: Danilo Krummrich <dakr@kernel.org>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbirs@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/nouveau/dmem: fix DMA unmap size and callocated accounting for THP
Date: Tue,  1 Sep 2026 16:04:42 +0200
Message-ID: <20260901140442.4036-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
References: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 11 Aug 2026 22:28:49 +0800, Zhenhao Wan wrote:
> [PATCH 0/2] drm/nouveau/dmem: fix DMA unmap size and callocated accounting for THP

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/2] drm/nouveau/dmem: fix mismatched DMA unmap size for large folios
      commit: caa1bc2a0a6c
[2/2] drm/nouveau/dmem: fix callocated underflow on large folio split
      commit: c2256c044a1d

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for Linus's tree and should land in the next -rc
release.
