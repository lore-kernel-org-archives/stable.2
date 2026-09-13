Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21A3D093E
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338628; cv=none; b=cM3qoHU0mJy1IRwcYSe0fyr9wGDzDhQMMFiRyAKbSnQy8uIoCaI7zBhF4Vpg5cx91K6K6NJQ6NGbMHkh10QC2+zSgG3ifqqzUAyBcNb02Ke7UK5Wubc8jAIK2bAVvMeFVLQMDVLQzKwk+CdFA4/cItXLGYVhvDKudCq95PfNDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338628; c=relaxed/simple;
	bh=/vs06QpI41Hz9IyWGKHlBvuYt3xz7bCsKS852DrFZhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuFjjhp9/hyaHKCTN66Rzr2Rdt02+pJh3N3i67xJSQ6GuLE2TmXxXIlpTtk3midNxtfGH0U5nTmRDQXK/6kZX4PM5saGS2fJZsWEektzWum+svL4UV2JfsbnmU/Q+yNnifMMuME1Fh/tWbxGu/NOYrwO4IsnXYsl1w9mAfCx4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp8u9xWe; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp8u9xWe"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efebso214544766b.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338625; x=1789943425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsiZnkuoCTKPflfGB5QjfHDZOp+0VHmNtyOlMcgcc9s=;
        b=Hp8u9xWe3K1cNFMjX3QuSn3xK2We5riYi3dzopQKe24FUw1i3LhZDdkizGQjC2YFoh
         RbGvmsISBH3Wun/u2yrPuOEREgixMIwj4qwlHWbnANL7JTkctCb0OFIrSanABOlY7D6d
         5tUYZPV3KIrjEhTvrpgAAMrmzloINrFgxO3Ar5ZJ7ENBgNhrdM+Ia7xQhR+Ftk5zegXj
         r9onqBpTfGH3s1KXyCRRoecLiArBw7Rfe4mSeL9q2HUDSiiosDFnqE/nQIDueVD4XESP
         PuBirzQLnEwPR2ShPfHSb7kG6XWRqhcbOD38El0eQP2XxWJqcnQNI9168TDlieyvE6bt
         gKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338625; x=1789943425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsiZnkuoCTKPflfGB5QjfHDZOp+0VHmNtyOlMcgcc9s=;
        b=h09zwLYCJKfTaEv92hRdRrjJZtpeJawzjqiM3IscuszsRbBZIR3uficTzWq5Mme2K5
         izaXXTjSeVD4JKngp7yAy4w+NP7fzrkBaMOa/UresKrgk/LdN9D9iJkSIU69LesMyA6R
         Fai4PBHEW+T6e/U/zLC1IasQqa/i96wy5956Bha2at047bsKOc6ucPG93Es5n1Yey+e/
         zABMrsSKHKluO1E27nV2b/kFSyKTi73LBDz8G1XTsRsnKuGSywBE+FnixScqWnD6rmgL
         lDJL0ORAsa29N0uxHbdBKGcEm+UuXL98jHlqmcrBsKKXwhWj2KUaFp0GMga32tMnQJ1O
         QYlw==
X-Forwarded-Encrypted: i=1; AKwUvBxkJPxVi6jEHcoykhXZeBnxKwcOIENU3c3MsEx3WsIgiYlqGlKhhIrLNl6O1NOlvCl0LoEvhF0=@vger.kernel.org
X-Gm-Message-State: AFuF++n+Lx8jjjgayR0yI5m87QCyj1z6DNkscCwITKnOUpVbimHNW57w
	UwIhx8cMxW/fWkxsnIELMfr2GIZpd12e5xAhCDyHXHHEL6+Bai7jVDxS
X-Gm-Gg: AYBFou0oFsmeRdFhRJZvkRnaIJah+WVixiosqEPJUJC5NwuOiehZb8MBl+cEMjBQC/d
	TbjCGgn6mI7GGj1GDlqNeRjFoImbwYqlgeXR1g1ckyKAZPzDoBaiuJnUpP2PVyRnFtu7lVKh0Hk
	7pDARyClaUVwgr8lekeX7MmUwc6WGqBZgozigtB/S6IrWrmIc1PZEWHqfEA91tSiO5StprV4r0u
	q9bnUn6ZZmdo4u2aehHOGeGLmmQHdRIfWnHwinct22DU6739XuGQRXfQhHU188u5EOE9zqZ/OzB
	cmt2yPgtRQMV4ha6vVsaYU0HXa3ppjwBWJCvl4mJuukjFEgbIPa1v5u9PHQtE96N2s8doOvvWip
	64tb67lUuBqJnlxW0d5TDKS0ff5QEH9S1pnyE7I2dmspCFQGgGewr8fTCmpZU8bP59fs2AMgP4P
	PyE+nNtguSck1leYLdKPVZjdeRNkYzVi0/FDG1Nx3dw5YWbf99v7DsT+bwOBRg3nkb
X-Received: by 2002:a17:907:dab:b0:c26:1dc7:bc42 with SMTP id a640c23a62f3a-c29b863aa91mr4607066b.22.1789338625165;
        Sun, 13 Sep 2026 15:30:25 -0700 (PDT)
Received: from beelink.. ([186.247.78.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:30:24 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 2/4] drm/qxl: reject command sizes that exceed the release slot
Date: Sun, 13 Sep 2026 19:29:58 -0300
Message-ID: <20260913223000.695299-3-qwe.aldo@gmail.com>
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

qxl_alloc_release_reserved() receives a requested size from its callers
but never validates it against the actual sub-allocation slot size.
Drawable releases use 256-byte slots (RELEASE_SIZE), yet
qxl_process_single_command() allows command_size up to
PAGE_SIZE - sizeof(union qxl_release_info), approximately 4088 bytes.

The command payload is then copied from userspace via
copy_from_user_inatomic_nontemporal() into the 256-byte slot, causing a
heap buffer overflow that corrupts adjacent release slots in the same
page and can overwrite the neighbouring release_info headers.

Add a check in qxl_alloc_release_reserved() to reject allocations where
the requested size exceeds the slot size for the given release type.

Fixes: f64122c1f6ad ("drm: add qxl driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8..049ad167f 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -312,6 +312,9 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 		return -EINVAL;
 	}
 
+	if (size > release_size_per_bo[cur_idx])
+		return -EINVAL;
+
 	idr_ret = qxl_release_alloc(qdev, type, release);
 	if (idr_ret < 0) {
 		if (rbo)
-- 
2.43.0

