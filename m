Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C4541E54
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177372; cv=none; b=JcWJW/UTEs5Je13X6/7kqhrb8cIGYdo1NuyvgtkyHSvH4at24U2p2cLsGn89sjTXhp6ixaQpLFZpOaEN4X8+9pNQD3gcntUabrqNkCQMuzNSxINp/ESJhz52rBSO078P530af21fiCmjKwvmYNJjZkYUuwegKIWnFvQbQh1X2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177372; c=relaxed/simple;
	bh=IUBOPU+ppdbziV3AIiuHiGemYVtMO7JQ5bk9OwEoA4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4xDHqBSadul/IwX/kA+5vu3goCA+Q5bQQMTQgFogEoaY6fF+8PM/9Om5Rwh/glObpLEnwkniUKsjr4/WxaA/e+NoMBvjejzIbSUEzCJaiOxk57k2zZ8ZQln9qRasdV7R55wV6QrRXvHYWdTXzIN4seBz5xAU/kMcLJbQRSuDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT5XoQOl; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT5XoQOl"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144e32aaa1cso644730c88.2
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790177364; x=1790782164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4RwhN3nTYO2NwTsY9NysVRh+VFHI1OHGWLQy/WkOav4=;
        b=cT5XoQOl0monGm/5mXZnNDGzTH/yxZT7fbs/k3J/k+bKx+/rr8buDXS7vhTiQHDJob
         mTSvfzPokQx657fdILUBzo84ZvwyM5xYa+xp12piPsVuW9st4iGNVFkeP/h+8+XR6Yfj
         nC8NnPcv6AjPw8S7fqoOEJt8dK7TToXF/OMAB7vDDbKmibqzem8xl1qHkcJHm15fZqWz
         fmMcUl7Xgr6mRxHwiVJrqqJ0v9TfcNt567krzKvEGDfHOU8I2flOobYzUtlZPNBHZKim
         d+v9UJ3jT6m4bXbl7Nf0gPxEK/ph7TsmPv3rLmE8TZfK651kS21qTaVlDg7LNpreFYEI
         GJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177364; x=1790782164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4RwhN3nTYO2NwTsY9NysVRh+VFHI1OHGWLQy/WkOav4=;
        b=McgAJJCqc3dsqybDkKhxPf7XbwBD4hIeZDw2V3L+dZenlWA3Bnc9Ab8v+SyIvNlFpi
         38v63442FEz1RhOLy8//w6Eq+9X3UjKCrg3XJ/SchHzhgbT9RLUSZ0IN0rzFQSJsLNiK
         0Omv3eFjIEbeOkLGCCjjUPXN987IAOmkblAiRKCdifJiobE++Mqx6ULncE+gwSmOttOE
         6/VphHkyC16sHBUoUwlQ+BSU4MUkfaigny+dpCHQB9wblt1bJn2flJ52awzMXmlyRFcD
         xKeAET2GatwZYSK0LOSngPYDlRfQpG4DDUFwQeot5xzG97COCGKjGPTE1GsuqCAWvyai
         UzZw==
X-Forwarded-Encrypted: i=1; AKwUvBzeHq5Nxp7FDyRu7Gr6rj6iTx3K+JHov4ljP7e1M/1TM2nbGzHqHHwzNvVfhGiFzcOqa7n9Q3o=@vger.kernel.org
X-Gm-Message-State: AFuF++k7AkBEwBQdzXv/ryYBMq5WUWQW/kOsRYYOpb2DKUaHhzCKj/UA
	4EbDfRVnfulOA77M5dL9cKVA9UWlTO+JU6gk41T3/Kl0eCUitLwP0CYx
X-Gm-Gg: AYBFou0c3Dctqi/SsyP/uSfhmj/NNHi6IP+TiyXQ/crL1SWHQtvFPfGNIKLe4LUhLvn
	GzsE4mNSDyOOtrX/e93rQsLoA5M1R7ckynb5zreFwKsOjL5ucyOVO6Rll8GKSD7wTbs5Y0pisaK
	h0f+YYPoNAiSe5v3KKy6LC7K3h24T0kZVgwkV6zYedUxxADqjviX/u/vTZW7XfW9hcHI5nAXL4n
	eESOkq2T0JQnRHt15R5mkpumob9Oi1LNo7MI9Ffev1dr9DbOUc8At3/ugZ7wQPr3d8bZuixyfxW
	AUYWthi/z1eeN45Q5TaL+ZV36LYfIUt+VPPcBhF3kE10m+Xjsx/gl9sO7o916rLYH2t0mSnHHWY
	EX78cnCYtwG/1TO1TOomeLQbT88cFcTrSTuXfL2qbPQ46o06EDrjkLxv5rKJnAgI+sbhfjdeErZ
	UVgShKATAnHOpfzmFbJv+lQBILxUBGtCpXKbIxP8ZrB3Jj3Ub/
X-Received: by 2002:a05:7022:ea4c:b0:145:15d:5313 with SMTP id a92af1059eb24-145015d5351mr741463c88.25.1790177363784;
        Wed, 23 Sep 2026 08:29:23 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98bf501sm7232627c88.14.2026.09.23.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:29:23 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] drm/amdgpu: prevent parameter-space underflow in nested ATOM table calls
Date: Wed, 23 Sep 2026 12:29:12 -0300
Message-ID: <20260923152912.1296884-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923145001.1244517-1-qwe.aldo@gmail.com>
References: <20260923145001.1244517-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atom_op_calltable() invokes a child ATOM table, forwarding the
parent's parameter space with an offset:

    amdgpu_atom_execute_table_locked(ctx->ctx, idx,
        ctx->ps + ctx->ps_shift,
        ctx->ps_size - ctx->ps_shift);

ctx->ps_shift is in dwords (set to ps / 4 in
amdgpu_atom_execute_table_locked()), while ctx->ps_size is the
remaining capacity in bytes. The subtraction therefore mixes units:
a child table requesting 60 bytes (ps_shift = 15 dwords) with only
16 bytes remaining would compute 16 - 15 = 1 instead of the correct
16 - 60 = underflow.

Convert ps_shift to bytes (ps_shift * 4) in both the guard and the
subtraction so the units are consistent and oversized requests are
correctly rejected.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: convert ps_shift to bytes (ps_shift * 4) before comparing with
    ps_size, fixing the unit mismatch found by Sashiko AI review.

 drivers/gpu/drm/amd/amdgpu/atom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..0940bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -646,8 +646,8 @@ static void atom_op_calltable(atom_exec_context *ctx, int *ptr, int arg)
 		SDEBUG("   table: %d (%s)\n", idx, atom_table_names[idx]);
 	else
 		SDEBUG("   table: %d\n", idx);
-	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
-		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
+	if (U16(ctx->ctx->cmd_table + 4 + 2 * idx) && ctx->ps_shift * 4 <= ctx->ps_size)
+		r = amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->ps + ctx->ps_shift, ctx->ps_size - ctx->ps_shift * 4);
 	if (r) {
 		ctx->abort = true;
 	}
-- 
2.43.0
