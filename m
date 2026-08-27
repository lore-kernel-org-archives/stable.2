Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27947F791
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844330; cv=none; b=AiGOVosTGt19M6bhYsBEnJwnRtDhckSCEDqevnesCibMUReZsw0qlbi9ROvWNqKdZb/UM3SgixS28ezby5bLQJX4qT6SzF6J2C/m5pGtqrc15DVkpeKV9hTYSrSVNMjcF+kfIK3t3ivcUWpuJwah13T+JwGuONcI0JvE76lSQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844330; c=relaxed/simple;
	bh=Xh6FfhS2ea8UOTbehrIxN6G5Cb0/oxIDCneCcs8+/9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9g2Y/SyWLOtFuUMDGoG8zpLlJExwAq3tRVU0S+rmgAaBfCWasYNpwuw9FagwAoOcucXqGr097SacM0+x/KGncVsXqgT7eA9j3jst8tkM95uS6oAWhvdWbC7a94LzHCHrCx19CdhTX+Yva0QS7YHaIJxQsG5JX07HKq/qkgDwAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAnsrMHf; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAnsrMHf"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso20333a12.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787844326; x=1788449126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=flL6svFl5aWrkKlDeo/jWDXl1QN2synua0XBk3WWZZg=;
        b=rAnsrMHfeqwa+MQBlie6QB/4lzRlfXnzMrzyMTC2yfyjOMkQkugfMRff7BX2+wasUp
         LK1b5vV+AqMQyvwLpuJAR/YoudMiXbnAO3LKPzel9rAhb4dgQ9ZNG8rB1asTMg5VR1Vn
         olHe2lCM1DKix+tgMxgyiLS09bAWc5RsMuEPY0OrPOuuu7kQNvV6DOVy/K2E7Di/7cGw
         pFePjrtocYxn0B1bxj7eQMnKPUhBctdQgtWKf006Via0fUnw+1arjzWaH3GzHKIWpLI7
         PgVeVA/nHI9Lr3V1+ZxkiyH90sqNVyTTC8hFTHguOVGhCSxEd6a1rPNnQl5dc1YhPcSC
         OUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787844326; x=1788449126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=flL6svFl5aWrkKlDeo/jWDXl1QN2synua0XBk3WWZZg=;
        b=FLmk4uscn/MRIB+vvcypsDTzQAGovlPJlfW14OpNDlNn4Q3zZzXAFwFmLXgtRby6ir
         Y+7vOM6Jc+Ix0u3E9L5UosddBy770r04JCfrWye7j1TZ16xdFq5dwuiGlakTWJaZqR3f
         fsN7ITrkbevNjYTnSJjHXBavsnkdm4AOu4HVJ/YkwAyYn3DXwwUJpEhsTgVyQjrhGZhK
         rDgoTLkrCcH85QwC9IXcpFgnO8Om0KV3jp0r7KLefLnLl/EXCx3S9umukxmDMwxa/TrC
         kDZczxsLDwgVM9sLJyWOEMZDiRerG/i9dQkQwghsPl78yHjsc8xGR8xB6RbbIAQFQ83p
         G/Zg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4kc0Hkjia61t0Kf2c/G+v9RzK14kYkPPCTUBlQJl/P+ENYGaK+S8wYGbAgeZKHETte4C5+q0=@vger.kernel.org
X-Gm-Message-State: AFuF++mHTI5X5Vdembw/8GHatKpXB+33EnAWi8AZNRB0b5RBH5p8Jclo
	TowwK3Uzu0RioYzdjN/cHri5IuPWHaWWLrpX7/OMYAwF+n+Q6jtW2wYa
X-Gm-Gg: AR+sD12241cumqWwvoPYCR+NNvbRGeIJmu3yH33KBMZI0SY0rqP17frH9ArBRaHwp7m
	eMvtNrq8IXEU57uk6J7/eQ3v04FW9KKy/hEwEyMo0K/+prmj0KQeTu2BzKOYUsGaa+WrEaTdQ5n
	+th1DRDicTBwTKgD3blkXgYvBcIrHdLhY4PJgM5zo2zmbUwHgYcYOLpoV9oJodsmV7aihSqPcQd
	07sdVTvxjeNXkM1nUJE76rykXOx2weCywSqelO0dV/B8lV1jGQxskWDf9nhdlU2jCF2I616abT4
	KDqpfEYapadqL4oS3OufheL8NNAj1T7WALm19clDsrl77JUdoAU3PrTIN5mg8U0AGOGxeLbX5Ut
	7qLjy1BvtDk582q5+U2mdlCyIHTdub+uNWipJwWLTQo25nf0inhAHKwhymsw7bP8F2WW4PgVO03
	bCsPEUBwgkcQ7b3fQHiJBVnLBfpv182rgAF+N28CHdaZVjspykron3zhPM3gw8rYBjNdfcSAZY1
	NIz6qJ5Jl6goRNkh6/x4RfXTonmMbNvQqaMLivdUgpu7PeEw3cb+w==
X-Received: by 2002:a05:6a00:17a3:b0:842:5b66:3c7f with SMTP id d2e1a72fcca58-85625842e10mr135248b3a.0.1787844326328;
        Thu, 27 Aug 2026 08:25:26 -0700 (PDT)
Received: from hnkz-ubuntu-vm1.mshome.net (flh4-125-195-69-140.tky.mesh.ad.jp. [125.195.69.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535a8b8ce7sm2174914b3a.21.2026.08.27.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:25:25 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: hughd@google.com
Cc: baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kazuki Hanai <hnkz.64@gmail.com>
Subject: [PATCH v2] tmpfs: fix unicode_map leaks in casefold option handling
Date: Fri, 28 Aug 2026 00:25:16 +0900
Message-ID: <20260827152516.805622-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827151426.796843-1-hnkz.64@gmail.com>
References: <20260827151426.796843-1-hnkz.64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

shmem_parse_opt_casefold() stores the unicode_map returned by
utf8_load() in ctx->encoding. The casefold parameter can be supplied
more than once for the same filesystem context, but replacing the
stored map does not release the previous reference.

The final reference is also leaked when an unmounted filesystem
context is freed.

Release the previous map before replacing it, clear ctx->encoding
after transferring ownership to the superblock, and release any
remaining reference from shmem_free_fc().

An unprivileged user can repeatedly set the casefold parameter on a
tmpfs filesystem context from a user namespace. This causes
unbounded kernel memory consumption and can result in a local denial
of service.

Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
Changes in v2:
- Keep Fixes, Cc, and Signed-off-by in a single trailer block.

 mm/shmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 89a1495e55f7..62440caf2df5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4508,6 +4508,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 	pr_info("tmpfs: Using encoding : utf8-%u.%u.%u\n",
 		unicode_major(version), unicode_minor(version), unicode_rev(version));
 
+	utf8_unload(ctx->encoding);
 	ctx->encoding = encoding;
 
 	return 0;
@@ -4976,6 +4977,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (ctx->encoding) {
 		sb->s_encoding = ctx->encoding;
+		ctx->encoding = NULL;
 		set_default_d_op(sb, &shmem_ci_dentry_ops);
 		if (ctx->strict_encoding)
 			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
@@ -5073,6 +5075,9 @@ static void shmem_free_fc(struct fs_context *fc)
 	struct shmem_options *ctx = fc->fs_private;
 
 	if (ctx) {
+#if IS_ENABLED(CONFIG_UNICODE)
+		utf8_unload(ctx->encoding);
+#endif
 		mpol_put(ctx->mpol);
 		kfree(ctx);
 	}
-- 
2.53.0

