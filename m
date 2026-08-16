Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2BF346E75;
	Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896683; cv=none; b=AWOrB6Y/Qn25L1FIf94/X1V4wobodJBIFiSCGC342VHCyg2snk2uLHzYTvH/BXQmH9spHZUz8bjFZu6uh4qL5cljrv+3xwjV60Dj0vneU8MP3VmEKuzLH5P2Wse8KjJ8Uce6FyYyghugOFQYq7MbTQmXGXA/BH1H4x2BQZWAPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896683; c=relaxed/simple;
	bh=F2ekJeE+WuqeAaVxK/jJWMpPvhrgloRK3OiNqJW1IyQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N7JAswwnw4tTsW4xIA6gRW4dv2BarAQFeX/YLJGNC3Q754DaT7wiyQqUG8GlxeljpO21ybO+/dKOnnJkydyO2TdM7RPlTDYdGW8FacSQUUGbARrjXIcPofBGs98xVpbz3tU8IuoYQMvim3bD9u7TWuQgxvjZh9+F/BPYj839ziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnWn3a1Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnWn3a1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7DE0C2BCC7;
	Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786896682;
	bh=F2ekJeE+WuqeAaVxK/jJWMpPvhrgloRK3OiNqJW1IyQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UnWn3a1Y9hLqvdV3gY6o75S4jE1NAt493LiZplm2R17B5pvsrudvVh7qpPtM7PB4Q
	 CIjHSK58LUAZEKYt9/2zmeflizpdGefb/z+sfLwaEwHuraNuEmQDwINFx3ZfpCbvdD
	 8PCEjwLiFR6HvOkEdC0s+pra9EI4UXKEa5I2vJ5kMGhhKAE8EoLU9SgBHlm213FZWB
	 AS3ByjDunIaGhJUZ14gFuBMJ7A8z5v0RpNusyDkNbFuVld8F5THIha9OF3Uy4Rb0l9
	 P7hGR/1wN1UmbQa4YC6f9EXJRC5JSM5rKe755v9D49OkD27+U6+Wl+O1673vxx+B7e
	 PkU+0X7Qw7Egg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C78C5DF6E;
	Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/2] drm/amdgpu/userq: fix a leaked fence driver and an
 unlocked doorbell walk
Date: Mon, 17 Aug 2026 00:11:17 +0800
Message-Id: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXhgWoC/x3LQQqAIBBA0avIrBNUULSrRAvRyWaRiVIE0t2Tl
 o/P79CwEjaYWYeKNzU684CcGITd54Sc4jAooYyw0nB/xFQuvtGDjUsbnXbWWx08jKVU/MM4lvV
 9P+N5n4deAAAA
X-Change-ID: 20260816-amdgpu-fixes-18d9598a85ca
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Sunil Khatri <sunil.khatri@amd.com>, 
 "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=F2ekJeE+WuqeAaVxK/jJWMpPvhrgloRK3OiNqJW1IyQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMaHGqH3leYU86UqPzPpmOS856qDxupfaY8ua9qF8
 ly8V7ry9tmOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmMiCrwz/Hfh2Vf1elrln
 6evDwrOZVkwR473dNaPlq9eewosvpcUaIxgZrnJov7Wojtics1aeZZWc5qIr3aIzlzYkbHeI/5t
 +k+UPHwBTZkyn
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

Patch 1 cancels the fences still linked on a queue's fence driver when the
queue goes away.  Each of them holds a reference on the driver, so its
refcount never reaches zero and the seq64 slot stays allocated for the
lifetime of the device.

Patch 2 holds xa_lock_irqsave() across the doorbell xarray walk in
mes_userq_detect_and_reset().  That xarray is device wide, so the walk
dereferences queues owned by other drm_files, and nothing keeps them alive
for its duration.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (2):
      drm/amdgpu/userq: cancel linked fences on fence driver free
      drm/amdgpu/userq: hold the doorbell xa lock during hang reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 71 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      | 13 ++++-
 2 files changed, 57 insertions(+), 27 deletions(-)
---
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260816-amdgpu-fixes-18d9598a85ca

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


