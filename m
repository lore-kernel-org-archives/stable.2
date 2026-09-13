Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010C3B8D7E
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338625; cv=none; b=amJLpE19rYpgTorOzAosk+lQTc7jpl11zXFw38uTSLne8fS64zKNQbCnmrWxK4VYqHs4kPKuytH1TA426iA7CV3LSzthG/OQwfSooBF6vOFhapJzO+WqXcN2W+J+O+M3Ue2aU9wQd9w2vZd5vS+PXs5zckN49FBVnGjTQBJH2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338625; c=relaxed/simple;
	bh=quWml1qKIcoD+RKtWJ/Ai+1ejZ0xRpDx1djyhN0dETI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcA4y6sEp2wiWB1XYCNBfXFOPqfGBfrk64bj4ay7kVEueNNOFD4wdTNWikVl4yQ9Btdghex+FEYfb3DrbFWS34ygxNFZisj7uwGwovQyTiIsoH4d7INvJ2b49/2zD5hYahbWEOafNN1zeITQJ9Dm58sA3QghYSvsaKkXcAvfu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/tJt7Vx; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/tJt7Vx"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso3001366a12.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338622; x=1789943422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vt5o0BxKweowhjdX5zbCd6SyPluSfyfpCfycMWtAzT4=;
        b=V/tJt7VxPs4EKKisp9WVcjbf9QQNPLV41K1OkfX2F6J07ZMr81SEIFYu+hiW0CAQFi
         yslALiOu3tt+0QyOiHJcev+GsBu3pVLg96yN95EtEECcHJKkYSC7a5cA07FrsAoTWmun
         7wj3kJUl+7EWN9HprEswLseDNTPndrpg1EKh+M8z8L7KvYPyx4QkxERftKZbI2vtFyJz
         yJr0+RaKrIDqLCZ1Mmcy7L3Mf6CxkedNNK/nz2OK/qyfQBY7YhgzVoNxCRW8v5PwGMWd
         CggNOdK3eoX6KjBz+7KH5g+WTuUr/MkNzjktAUSM2rEQOfNR3cuZxdHRJMsiGiPKitu2
         5g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338622; x=1789943422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vt5o0BxKweowhjdX5zbCd6SyPluSfyfpCfycMWtAzT4=;
        b=qO8rIHIFIvzFOathPFbuKdVgCDB4wFkgM0x9K0QAdS8Nv4WyTtaF+PIBF7ZKiM76Ys
         qJHgD0wsb0w1Ayf29k6uRon+yfYn7M+WYLR+vLOZJflCY8ynVEeaJ1mz54M2jo/FwcPq
         wXtDXTQV8fCVbAa8qNuXIK+zTtnyZDLpWGzlQQDo6eVpk0lCipF9DjUUpr2XSRcX99r9
         yxsUPDTaSVAhcjNcsjSqQssTt+PNLZvDnHC+mGvwObIi7ulAZWj63rQMFVLCr75WPHT8
         mjcWa2v+sTYu4zIyJuc9UdpYQlfbspllF+6xBmfZDG/9M3zmvDL/fpoKuVS6MRqeP0fX
         9vvA==
X-Forwarded-Encrypted: i=1; AKwUvBwP9jFNsO5nYsNm1xFU5Y9SQ9F8YUl6KwyXZ8kaTAE2frwyicCBWTPPgBtgyfotxKg+MHrUSrw=@vger.kernel.org
X-Gm-Message-State: AFuF++kt2P72PYUeA1REyUcA64ZxW1z6xM63uv2K+Bi5gpi/rb97a3MK
	fzp3gNxJeDPeb1GNToP//1C01U1mlwRJD1tstQSV7gwJvCoC85NqAieI
X-Gm-Gg: AYBFou3vpykmZ/8rYpkLC17aJJ7oLQLdqaOYt9SlD00wKrv8R82uJgMmScteDnVQI42
	Znm60pVXpuWibQKqBTeK36w+tchd6Jnbr1/xFoRg+Meqqm6SnPUGT7tA9Qkb8CUUXQR/0MwFEOO
	R8VSC/rLv5binphISshu0SJDwAZ6fDZHVhMi877l6dHkuGJ9GwQV54HYxJ8P71mROqlfSqyak4g
	o+mEVsCt6GbdbBT6vEo/EJxvSyCpkdGjesiPFw6kqMv9DpQUQFdN9pnoDVmCHGIZTTibU5h5Phl
	oP7fCQZkQUTFb+YBqg4z+PedmhDe4/1EjIzW/m1+qguC0QNhHYMD9HbUwVmCI6TM/M7exyv8RLV
	WHswFzNLTXuFX/5p9vHs+ykrXqmug0e5GLoJHIahmSx00ZF18yLBBEak3/l6tOcNcI4mZFDx5sY
	OdsMQqtqC42kffXRGikDXUkzzqsC5VuAOVFsaEbAMLdbDmPDQoXfUvFz5ZkDr+r6Pr
X-Received: by 2002:a17:907:7215:b0:c25:5a7:87f with SMTP id a640c23a62f3a-c29b804baffmr6802966b.0.1789338621865;
        Sun, 13 Sep 2026 15:30:21 -0700 (PDT)
Received: from beelink.. ([186.247.78.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:30:21 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 1/4] drm/qxl: validate relocation dst_offset against destination BO
Date: Sun, 13 Sep 2026 19:29:57 -0300
Message-ID: <20260913223000.695299-2-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913223000.695299-1-qwe.aldo@gmail.com>
References: <20260913223000.695299-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qxl_process_single_command() copies relocation entries from userspace and
passes them to apply_reloc() / apply_surf_reloc() without checking
whether dst_offset falls within the destination buffer object.

apply_reloc() writes 8 bytes and apply_surf_reloc() writes 4 bytes at
the byte offset named by the relocation.  A userspace-chosen offset that
exceeds the BO's allocation leads to an out-of-bounds write into
adjacent slab memory.

When the destination is the command/release BO itself (dst_handle == 0),
the write lands relative to the release's own release_info header.  An
offset of zero overwrites the release_info.id, which the garbage
collector later uses as a release index, leading to a use-after-free of
a release chosen by userspace.  Both paths are reachable from any render
client (DRM_AUTH).

Add two bounds checks:

  - When writing into the release's own BO (dst_handle == 0), require
    that dst_offset points past the release_info header and that the
    final byte (offset + write width) stays within the command data area.

  - For every relocation, require that the final byte offset plus the
    write width does not exceed the destination BO size.  Cast to u64
    before the addition so the check cannot be bypassed by a 32-bit
    integer overflow on ILP32 platforms.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026ce..e727a35c9 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -204,6 +204,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	for (i = 0; i < cmd->relocs_num; ++i) {
 		struct drm_qxl_reloc reloc;
 		struct drm_qxl_reloc __user *u = u64_to_user_ptr(cmd->relocs);
+		size_t write_size;
 
 		if (copy_from_user(&reloc, u + i, sizeof(reloc))) {
 			ret = -EFAULT;
@@ -220,6 +221,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 		}
 		reloc_info[i].type = reloc.reloc_type;
 
+		write_size = reloc.reloc_type == QXL_RELOC_TYPE_BO ?
+			     sizeof(uint64_t) : sizeof(uint32_t);
+
 		if (reloc.dst_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.dst_handle, release,
 						 &reloc_info[i].dst_bo);
@@ -227,10 +231,22 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 				goto out_free_bos;
 			reloc_info[i].dst_offset = reloc.dst_offset;
 		} else {
+			if (reloc.dst_offset < sizeof(union qxl_release_info) ||
+			    reloc.dst_offset + write_size >
+			    sizeof(union qxl_release_info) + cmd->command_size) {
+				ret = -EINVAL;
+				goto out_free_bos;
+			}
 			reloc_info[i].dst_bo = cmd_bo;
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
 
+		if ((u64)reloc_info[i].dst_offset + write_size >
+		    reloc_info[i].dst_bo->tbo.base.size) {
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
-- 
2.43.0

