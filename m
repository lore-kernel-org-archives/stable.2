Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C039B4A1
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576392; cv=none; b=XB39Peq4LjKX+Xs7H4pJejYV7XoTjR6YJcmTMwM7MiSD+GCS6RdvE99pPysOWyFgUVCkTqVdAixpEnmT9NKgfaK2SgwWdskpUBA+Yoj/BcPnD7yh6EuvRssyQbrGl/IyXs00aninNMdohrce+yppfk9fQl3hEEFPmzJTaCNS1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576392; c=relaxed/simple;
	bh=8uCmXvPFOJoNNasKoEgsllBkzUyihOscHlFbhfP2/kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S79ydsvanjYkihx/VlUuFfkA/+kNieWgklMVNzSs+nq1CvWNwAZU6iYp0AU+hrljxEGMHetfJw5QvpMIBgHEMsPvtcadNxHVasgoc6WGU6poorYvkWbLc3LttQNk7yCGCpRWzE9EgXrZ9nvGzXOfivRVOlDiMbvFRA+CBEHgtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faRL+C6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faRL+C6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243061F000FF;
	Wed, 16 Sep 2026 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576389;
	bh=TGR+Qps+DqVnv/WseQbIe2yxJOwMZi0Jm7BYjSD/2Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=faRL+C6L1EG2KotG3z5zEVcEMEH7mHIpxF5AMfbCSscE+Bs9bV1BOrC14ZSkCwQuB
	 N8dNRj53IvFfHa8mWtUYZIchz+DFHcTSuAOBa3OLXnbIJ7IOqAyLUP1d4tFh+wBDhP
	 9Abj1n4pD6aPG4dKQKnIXLKQFJUT/VvsbRydRSXh9sZY3QHwVls6gcis8J2+HI9WYC
	 6q5RftPl1yu9hk50xJfemdOI2J3tALAoB9pSDYK36msR6vpELqG/t4GOwc6L7595O0
	 83Dx9xRfkrcHX/0o2rNZoGM81/cDSw/8V3UV/LtDsE1RSjYIsi5+ckIR2yTDeQgvE9
	 F8j4CuPnKBjRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	George Zhang <george.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info
Date: Wed, 16 Sep 2026 12:33:06 -0400
Message-ID: <20260916163307.415632-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091651-justifier-ramrod-f274@gregkh>
References: <2026091651-justifier-ramrod-f274@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit c119d05a36a884482decc67e55944648f8cba97e ]

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 829157e762ed ("Revert "drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 718937777e532..d4a9d5e8fb429 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1699,8 +1699,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
 		dma_resv_describe(bo->tbo.base.resv, m);
 		dma_resv_unlock(bo->tbo.base.resv);
+	} else {
+		seq_puts(m, "\n");
 	}
-	seq_puts(m, "\n");
 
 	return size;
 }
-- 
2.53.0

