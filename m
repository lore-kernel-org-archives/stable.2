Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15689319852
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560631; cv=none; b=O+KHJ4h1zx+9hapMSc7EzqpG9aszes/PtWY9W49dKL8s3DG7MHEVtcSfqc9avgxsMRzX5W6MF7qvEvtI8pRIF1e5Jx/ft68SAzjVkhJnfBOzI8iP1gjsJbfGZ3KGHhIRp7dpArzpk8yK8DET7w/WL1VDh+Rp666/Zv4ASVhLlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560631; c=relaxed/simple;
	bh=DCS6KZLUxkgrDiPxwM2MsNX+j4Hds16585emdMUCp2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTAdcjvXW+OmStzmI6XjszTuziDrKqod9HuCojC+kY03FLLQ0bM8lZxS4xXEornUQ78+7tMKRfdadNW6zJhWklLiS860RSeBqWP+1N30967qmhXMwPi0DuPijegy58IAy8JJWtwjg7mMctm4CzBhiNxf3Ms5krvXAbQJvcqpOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMPdLQMn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMPdLQMn"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf1cda2b17so27994805ad.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781560629; x=1782165429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIyvWCdTdGpwmgLj68ZKIBwap2l4YcZzm7SxNeqPKYk=;
        b=CMPdLQMnnW3Ou0jnYnnTXvOcWy03jCcIntl7rT7dQ2LhP98NOH2N3ugGI/9YoFiRsR
         eLZQXpH0jU3deIPbrlix6VYmjWJZrx9YNhJ2ldQXP+0Gj/sn+2e47S9HCFhcSkkeqj9v
         0zB07vhxydesMjlx1uhoVQFkVenJ6WDBgHMwrcghsudl0kuMMxh49CMsOc2OChLaDaVO
         y7Z216c9aW68ALFJG1dQCS5BVJEhwRtd11cpNxhJEVYStWNmReuDsTU8T9u/Zp//Wcg+
         LMuLSTp9stxB9UB7V8iv/pH+y02MxzqtaHUjohI7Db+V9cg8lv570uwcfNuuyioAcBAj
         5inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560629; x=1782165429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIyvWCdTdGpwmgLj68ZKIBwap2l4YcZzm7SxNeqPKYk=;
        b=C6bGQOCF8w5M1JnEW10xj56sqWqUZ6I9T8C+w3Hju7ISvHdfwyvbnQn9V9DA3bCH6T
         4xH4AQwcdn1dwwnflreQoWhe78/Ev/SI4ngf0y4+QU4BbPBf6r2ZhNR3NyQL6bg43XjA
         UccqPP6lDy7jBZ2ud9yn/F8H0jWSoVTVK0+3Z/+3pEcRDdCKzJJDcmkc6aaeK13y9e4l
         HFrMXuJdPrY//VexLoXOK10OoPzO3v7Y7sgAXUrvKs/hMZyHTyKgjgVkFzNsDBJtFcT+
         TQ2tWqXaAwvihxJIRcWj1wa9dh9x9SjOBbdqFh+bPeBZx8OY5FDPK/ZxIzbRl7N0r9O/
         E0BA==
X-Gm-Message-State: AOJu0YxIuiz3yOyc4/1MbJUHlH4OzYgXYEfKjofUrCKbkFcbth+BuirT
	AY0/7fq7EyZNW5o1ACyE0zV2cIG8DRcqBVfER/rDcXyF5MzOCQn1X7HAK2kVy6do
X-Gm-Gg: Acq92OFhVH0kVTZnEl39EfFYH+N266ylDx6ZYzxQkn3Bzxpb7sugFxpkmVC7fP7n7pP
	1SEhJE4/YCJKTwUqvTOGAkgLvXZBtUiRxDWvizyTenEUgouZrZmKIL4/3WdnrfMXB57SjYPq+XJ
	Pl06zu8c6UaMmyozpq2Ojf+l6Dpi+f2zUezlfYDTnmGDRZl70nckDo+w5Rj1CeWjm7x6YNpwK78
	5mV5BV3DdF7d0ChSgZ5o0s1/nKj1opTX9Y9k1b45lTZWSKVgYRvbZi8fAp5fJF+gJq5YlNLE81Q
	q5kEdQ9yXhUTJzbv9yB/jeJfwglXdW/mqQDxLXez5GzHLCUu5AkzEAkqN/tWrTJsLNdMPgFN84X
	xDj24uswEsfL9PAWIWEWldQq8XNrJdCUnxAOhmNVSAvjB0vJpGsEtkMgcLwmkfHdOO6jvvrO1Yz
	1Yc162c3vCdPDvd2cJLvUIFmxZ7KxeGg26aWjdseFVc4sh+1r9qnhs4E8Bv3vY98AGp2MOGIANQ
	CXOGg==
X-Received: by 2002:a17:902:ef4d:b0:2c0:c262:b924 with SMTP id d9443c01a7336-2c699b03432mr8817225ad.13.1781560629203;
        Mon, 15 Jun 2026 14:57:09 -0700 (PDT)
Received: from ljh-System-Product-Name.tail61485f.ts.net ([203.246.85.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43326b085sm107796755ad.70.2026.06.15.14.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 14:57:08 -0700 (PDT)
From: JaeHoon Lee <dlwognsdc610@gmail.com>
To: dlwognsdc610@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/v3d: reject an invalid indirect CSD buffer handle
Date: Tue, 16 Jun 2026 06:57:21 +0000
Message-ID: <20260616065721.1589362-1-dlwognsdc610@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3d_get_cpu_indirect_csd_params() does not check the result of
drm_gem_object_lookup().  A bogus indirect CSD handle from userspace
makes it store NULL in info->indirect; when the CPU job runs,
v3d_rewrite_csd_job_wg_counts_from_indirect() dereferences it through
v3d_get_bo_vaddr() and oopses the kernel.  Any unprivileged client can
trigger this.

Reject the NULL handle with -ENOENT, as every other GEM lookup in this
driver does.  v3d_cpu_job_free() drops the reference under a NULL check,
so the error path leaks nothing.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Cc: stable@vger.kernel.org
Signed-off-by: JaeHoon Lee <dlwognsdc610@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee2ac2540ed5..05f98379c1a4 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -605,6 +605,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	       sizeof(indirect_csd.wg_uniform_offsets));
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
+	if (!info->indirect)
+		return -ENOENT;
 
 	return 0;
 }
-- 
2.43.0

