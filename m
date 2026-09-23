Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B3544D45
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179990; cv=none; b=r2e6rtUh+sbG7AYpTsXAWajT/aFgVGI/9SFmio266B80QvbpXGTJP53noUyI2PRQKvKhpmA3XFERIY7RJ0pSMQ4qupe1CAFUb1ur2aXKxqW1nrZ7fzwkQCccqrOWnvec7azxTwJADR062ra8w2UR/EC1wKk43n5no/EZreXQero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179990; c=relaxed/simple;
	bh=1g0BHNHVwJMI7+P5OfhufmxEK7GftIxxvTr1NNSUwak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bliGw1w/pM1P2+OI6JBH69pN8ymSKhRaCj7SAieMmOwXqlMx9OkMfk8gYV12GZoM71E8dfnOjMgik+8ZtQajZ+ofiWkhTXwDjyzMTgavS1qu1pCgqdwTTCAaLonc4xvbGGMm93LztmDyJrM9wrRquMh5WUdHqrPm5dKrEDy/Pm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkAANFO/; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkAANFO/"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso490662c88.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790179987; x=1790784787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sUIXWjLbTey+d3P92W9cG28EMxJiRiFjR+QNnEvmF1I=;
        b=EkAANFO/6XSeDq3iLh8+j/G7YMFsD6YjxMq+ek/ncBvPEOlyfOcXwPvSx81Xqj/86J
         Ts4PEVq6+48b7iuCdltQ0DKfQRt8uW7TlKgnt/0mIVCes6wjT9XJqay0w65vopGCZ3e/
         0L4g62UUh5/mSJt3lXdnkCjIZ2n/lh8G6lZLzscTTp7NyDCPUaI+zFjrXMVx6/g85kwK
         g8R4CUgX/GUOEhz5hgtvDBmXJVBESTo+wGRYJfnZ9ZxDstsWIy8axc7TFXDh+3edbzzz
         j+mpFicJEg/fddTlgSl99enlJjFSu90ZSLop1rGyyiDCDjCsywRVP1hlKrVL/phJs+OX
         ejtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179987; x=1790784787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sUIXWjLbTey+d3P92W9cG28EMxJiRiFjR+QNnEvmF1I=;
        b=vtXiH52TYob8nM4a6nfPGlttzjm9CC96QIs2i/+xmONto/V3D7p9NHtBrfCTJKBbde
         4DPBD+pUxTy68S9atEBZL6eC4U1v/C16fBW8k3+MILGoIGHsfACO7vY8Ql2u7KkEFz18
         Ae5NArbhyz1s+sq99k+MuHrEYk54nwlM5RqF6zYehRXVN3Ro9l3o6W0ixT223JhLrmt3
         BLM6Vmbf9JzOjf9RcexSA517lqiUxubJiA0kjzkR7WKksR0rjjBLvzREiNcW6ZKijttW
         1PlD7osZ12prf2+BQ7IBNoh9N+hkyQ7ijHjE7a7R4RWYO1bHxnLrWNXs3VTuCaPILV9y
         Cauw==
X-Forwarded-Encrypted: i=1; AKwUvBzhfRGKxIPIdIa8O2ukg7e1qPnNqPSb7ux/8iXkCz1xVHhHHOEjJ0LU7Md9KFMkSaxTmIx0URQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nTSd68lZ1k/Cr8S0SrLyLhzktmpYbiEbw+Kns1vr2du7/v8+ad
	dHdD3zOZHX8M5YcCICff9SiHzaPiFeYMHdRfzIzDM2UrzmdZ5+1Go2Ug
X-Gm-Gg: AYBFou0Mc0rUIigB9pZjf47MbIfpYXPIyI4LyD82PjO9CfdJ8+r5S9VJW1xYXZzSwRK
	2Mo0it0tCQMPR+xo52BE4K6BNwYRuTt0dBcRrkdGM4oJDhX/ekrgQLAMHCWUW0O+cz7xUacPTeE
	4xuaP2Vq8lpgV3dD9u6mij59bu8xe1L4grz78JcUfcGHcnUhI3EMRuAlKCE/hVZqCLzTiTuBr4m
	pR19DlNXaG4wTbNY7Ny6ILfTQzI9RfaBhfMt5yP44fUk3t5Br3aYI8/ky7//APNvlmwEvJ6NNSZ
	Rt4qgVWsE5AdbT9AcvH2zCYRp+uaTim8wmBN+gqttajnyHPdVu5rGVSY5G/vhSB2XyNiLeEwZfQ
	fG7CrguvatFtBknt1BtXGDZn2f7vwm1oi/7VbcsAljoneoaAhQQ3GlVsycMR6+e86ZpxZODP36v
	sx385KcYVdP8bl/FoccI03H4C3jpfzz7b6ghMyDzCjNjKiiLrSPBRf9+jRdkuoyQovp8bJi4qDB
	A==
X-Received: by 2002:a05:701b:20de:20b0:145:152:b54c with SMTP id a92af1059eb24-1450152b7ecmr819023c88.23.1790179987346;
        Wed, 23 Sep 2026 09:13:07 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14501794269sm992777c88.8.2026.09.23.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:13:06 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] drm/amdgpu: fix ATOM parameter space index bounds check
Date: Wed, 23 Sep 2026 13:12:52 -0300
Message-ID: <20260923161252.1363895-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atom_get_src_int() and atom_put_dst() use idx as a dword index into
the uint32_t *ps array (ctx->ps[idx]), but compare it against
ctx->ps_size which is in bytes. A malformed ATOM table operand with
idx between ps_size/4 and ps_size-1 passes the bounds check but
accesses up to 3 dwords (12 bytes) beyond the stack-allocated
parameter buffer.

For example with ps_size = 16 bytes (4 dwords), idx = 5 passes
the check (5 < 16) but ctx->ps[5] reads/writes the 6th dword at
byte offset 20, 4 bytes past the allocation.

Divide ps_size by 4 in both comparisons to match the dword indexing.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260923163157.1354872-1-qwe.aldo@gmail.com?part=1
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..d0a45f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -232,7 +232,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 		(*ptr)++;
 		/* get_unaligned_le32 avoids unaligned accesses from atombios
 		 * tables, noticed on a DEC Alpha. */
-		if (idx < ctx->ps_size)
+		if (idx < ctx->ps_size / 4)
 			val = get_unaligned_le32((u32 *)&ctx->ps[idx]);
 		else
 			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
@@ -510,7 +510,7 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 		idx = U8(*ptr);
 		(*ptr)++;
 		DEBUG("PS[0x%02X]", idx);
-		if (idx >= ctx->ps_size) {
+		if (idx >= ctx->ps_size / 4) {
 			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
 			return;
 		}
-- 
2.43.0
