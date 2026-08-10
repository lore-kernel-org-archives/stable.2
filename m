Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B043F660F;
	Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378668; cv=none; b=Glj9dOvewQYxBAqu4b0gU6KRC5doM2AL6/QyGd7jwO/gOaEiwh9h2xGled5RwyFL0lq+f7SqTmj9HrQrX802Htid4VwZwsUZoFaoDFk+qd+EtX7cmRz6hUf1qoUV+35S6j88pQyx+OueKXuGCSrUJufd1ckN+mZ5/D2kTUz1P3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378668; c=relaxed/simple;
	bh=qrWihAGCrqFkMcNdLvUZTQMgUT+Pgkggyran7rTHm9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SvOTmGJX3LRNufdTuavcsRLtJnMyqrxEu8VbkQyggZ2l7LMJM4WNPx/ynUIZkmNePAU8keZts7+ScQ6pUbp1YRarjeHlDxaM4r3ONZetfxDyd9jtMLWyJpnv9ExJv/M063reivDVWz2cLU2+HqxK2u++FHlLJ9GjYy2n5923Jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxn/c43A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxn/c43A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0459BC2BCFC;
	Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786378668;
	bh=qrWihAGCrqFkMcNdLvUZTQMgUT+Pgkggyran7rTHm9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rxn/c43A0RClcJ3wW3eopMFE4AD5cbJ1MV+B6K+ukP/gjaBjPM+V/EkXOHI1/E3K/
	 +u3t0cMH1k2fU1kg8s79UhC4mm0udFDIb5Y+X6iJZIO/8PwaznQAgfIi3Udu9WNzw0
	 mHXCWhgk2PIKxozXWm79EcCRb9QOMj6YphU3aMRi0socbjfFGRLywBgbTIOYpt+xz/
	 Km7O88SSXCQqY1APsRbO1/1WrePt2P2hlwLfK8TZEOfAdpCdaO9FrcJNyEkEWg8W6L
	 KOMhjUAEN69wqLxvmogNjSdUOAGMBXFv2VSKOi6OAQggkAVP1YGwXltHWVDlTQaj/p
	 vvoR3vl3h1m7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8AC5B572;
	Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 11 Aug 2026 00:13:13 +0800
Subject: [PATCH 4/5] drm/amdgpu: enforce UVD handle ownership on destroy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-amdgpu-fixes-v1-4-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
In-Reply-To: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Junwei Zhang <Jerry.Zhang@amd.com>, 
 =?utf-8?q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>, Leo Liu <leo.liu@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=UtGNeM13NSreEA2vgkQPwwzgGSG/EJ+HK2TwqY3ru6I=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMqfS40VjhmWnd2/6hD3na7ZrbHHfV8FbmefWj17e
 lyFd6J4TWdHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATMQrieGffnHOVano9rq9
 HMXn1TZyyjWGrQ8Ji//dz/WvaKP8bcHdjAynyuLigxq3Zwcmm+R/+VGSxGH59HiN/utz+bN4Pwe
 s+MQEAO2LS68=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

amdgpu_uvd_cs_msg() validates that a decode message references a handle
owned by the submitting client, rejecting a mismatch between
adev->uvd.filp[i] and ctx->parser->filp. The handles[] and filp[] tables
are per-device and shared by every drm_file that opens the render node.

The destroy message performs no such check: it walks the whole table and
clears every slot matching the handle taken from the command stream
buffer. A client can therefore destroy a handle owned by another client,
clearing the victim's slot and tearing down its session in UVD firmware,
so subsequent decode submissions fail with -ENOENT. Since
amdgpu_uvd_free_handles() only reaps slots whose handle is non-zero, the
cleared slot also retains a stale filp pointer until reused.

Apply the decode arm's ownership test to the destroy arm. The kunmap
is hoisted above the loop, matching the create and decode arms, so
the new error return cannot leak the amdgpu_bo_kmap() reference.
Kernel-initiated teardown goes through amdgpu_uvd_send_msg() and never
runs the parser.

Fixes: 5146419e6feb ("drm/amdgpu: make UVD handle checking more strict")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index e8b0c62f72be..8d3e5435cf52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -918,9 +918,19 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
 
 	case 2:
 		/* it's a destroy msg, free the handle */
-		for (i = 0; i < adev->uvd.max_handles; ++i)
-			atomic_cmpxchg(&adev->uvd.handles[i], handle, 0);
 		amdgpu_bo_kunmap(bo);
+
+		for (i = 0; i < adev->uvd.max_handles; ++i) {
+			if (atomic_read(&adev->uvd.handles[i]) != handle)
+				continue;
+
+			if (adev->uvd.filp[i] != ctx->parser->filp) {
+				DRM_ERROR("UVD handle collision detected!\n");
+				return -EINVAL;
+			}
+
+			atomic_cmpxchg(&adev->uvd.handles[i], handle, 0);
+		}
 		return 0;
 
 	default:

-- 
2.51.2


