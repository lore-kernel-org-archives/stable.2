Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F153A88A
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180936; cv=none; b=TKnppnqoD1gnYcAgZ+NmoDa+DZeskv+r+zJ2t+UrajYVb0MZKMMdRS0hkjNiH7M+/qiDo5XzO7BaixQBXJsJoYD1uLbzh3IKffGHzna33DGIwUJ+ahlKMwsCh0x/3/B8zEaBPc2wlSkm4JrG5aGzo80wLmAI5DtFIB0uMEgyYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180936; c=relaxed/simple;
	bh=h+eU75xelQGswmBPjE6P4nA9394tMuqZ2wuaA3UwNrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsHB3hpV9uVvq41DSHdzSQ7kJsDN5PIXs+MMUDsLSJjzam+ei26NraqzWFb8yn011nzc14cILmyJigX7gVv0ii3vbrwkqBH63t3I2nZgrmFVSHW4GJkrwwwanC+LREVnFfiWRfuSEyJxPH58GDXlKEGs7pmhnOup9L9k+p5FtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la3ctn2m; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la3ctn2m"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so1300366c88.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790180934; x=1790785734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iB3sCFIdT441Ve5Xr6bVNZSuT6o8nHC9HcOE4t6cLwY=;
        b=la3ctn2mKT3WxYa1IpE+RuRv6mPIWPMdMofQmLFHRO9foM4VUxCnBd2exZpmu4iHGR
         rwR/ygGBMVGCPwUelLPyqDq81uNqwc79X+lShabHbTzR0j9ewZVuFvFI4B3Zar6LdneZ
         OGwu6JVZ8LrCYLdrB/FoWNMj1M1//73r5EyhsQ2tJb7F7sopxjPAm2eagWGjcrSrbdhT
         jdKcf5dlHG4FBPZSGD3NbtcH16QhpkjlUuvK1mAYSRwYKUz4vkMzrcBYUv7Hy0YXNuQQ
         oNOCGYDZXn8T4zkr5mcbEkgGtWRSEzRpc+ApKxMbadL6n8CPvCcPbbm/r3zFYlJScYkQ
         8YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180934; x=1790785734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iB3sCFIdT441Ve5Xr6bVNZSuT6o8nHC9HcOE4t6cLwY=;
        b=Z87/wvoPmKrOEDUhe0ZFqYmXFD+mrDyNRCMrWy7TgX9NCAGypIse31fE/QVMWkrNnS
         UwJND0k0uuRvVJ6js+ggb+e3r0zfNDErOQVIXqsPnYWCBoHJLiB7X3fTAjsrzbUJ3djM
         sfVsy0xo18dmdNoh4LEYZoa7S+HUoo4i2sQmsxySW0ppPhdnIVI5S0qgvgXsKW1un307
         g908zHZKqn8VbPRqD1c6wFjAWGJ5aDxHuFM4ZF1M8q5TsTjHRrM2m9zdrOAHWbDLnKxq
         hCciliA7QtSb9LpvUCdz1y5TS1mGA2emO9dqbAN6XbGLD/6qwrxMnrDhtsgdkpiGxyds
         NPiw==
X-Forwarded-Encrypted: i=1; AKwUvBw1UdMx+saNy3k6KJqf/4raSAPP+wn9rz2x6Z1tL0K6d1Ltv6Eqz8pyJ40w4EB+hnP9t8wvfGo=@vger.kernel.org
X-Gm-Message-State: AFuF++nqZmFWM5SjNqENFYZojyKtf1+9nH52ObcxcZ8oJZntJqHJadS+
	3gZn8xDkOV6rsRKElH1zMXZ+XwerJn7KZNjO4GrxiHLC2h0Bhw7Fda3d
X-Gm-Gg: AYBFou2nmWeTDHFHaMtsVOsLSwmYG5sPM7DChMfN2v2bpTJVIvRP1tW175rMhQjFqXI
	JAenSWRkZ3/x3dVZTFGaP10MuHWZhLXPoZnhP/ZyCcON2+1ilSsFbaltqrWmypm2p5vBHfGUP5c
	LTIDf64WI9O2sCH019Z108CKPqQG7cCIT0EXyG1+86hewALdy5u5Qd7LsyVsWlhEgB2s3nY3W5P
	ThBlapYD3GNAdzJTwJ1sf9dDHQAO9SGSJPqOOGIjdwtN8qtZVd2P++Qr6oZGXn01eBlruQV6UiA
	9AWqIzawYK4SoRHOENiIbxiFTS9o4TDbPZdifNBerjWqtTtKX7UmZ3oNcJm5HEdZmX4otR5/qgw
	6JdM7xVMQPPwX9OF6zqQLxhN3c6eqWi/zlxmvOxvdvmduIdaHoy98RVIerD5xzVCEjfER+AfML9
	I9Sy2r5GNMKwnMgYzkvqFARd1DyWYm1KDy0DCS28iD+0H3esogTjWMQCAM678X+9a5
X-Received: by 2002:a05:693c:2518:b0:33c:e61:e1e5 with SMTP id 5a478bee46e88-33e8d9c95bcmr3116205eec.21.1790180932368;
        Wed, 23 Sep 2026 09:28:52 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fd955sm7844052eec.1.2026.09.23.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:28:52 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] drm/amdgpu: fix ATOM parameter space index bounds check
Date: Wed, 23 Sep 2026 13:28:39 -0300
Message-ID: <20260923162839.1379927-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923163157.1354872-1-qwe.aldo@gmail.com>
References: <20260923163157.1354872-1-qwe.aldo@gmail.com>
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

Divide ps_size by 4 in both comparisons and in the diagnostic
messages to match the dword indexing.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: also fix the pr_info() messages to print ps_size/4 (dwords)
    instead of ps_size (bytes), so the logged limit matches the
    actual check (found by Sashiko AI review).

 drivers/gpu/drm/amd/amdgpu/atom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..dd6c22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -232,10 +232,10 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 		(*ptr)++;
 		/* get_unaligned_le32 avoids unaligned accesses from atombios
 		 * tables, noticed on a DEC Alpha. */
-		if (idx < ctx->ps_size)
+		if (idx < ctx->ps_size / 4)
 			val = get_unaligned_le32((u32 *)&ctx->ps[idx]);
 		else
-			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+			pr_info("PS index out of range: %i >= %i\n", idx, ctx->ps_size / 4);
 		if (print)
 			DEBUG("PS[0x%02X,0x%04X]", idx, val);
 		break;
@@ -510,8 +510,8 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 		idx = U8(*ptr);
 		(*ptr)++;
 		DEBUG("PS[0x%02X]", idx);
-		if (idx >= ctx->ps_size) {
-			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+		if (idx >= ctx->ps_size / 4) {
+			pr_info("PS index out of range: %i >= %i\n", idx, ctx->ps_size / 4);
 			return;
 		}
 		ctx->ps[idx] = cpu_to_le32(val);
-- 
2.43.0
