Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC43D954F
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928803; cv=none; b=sii+tM/7Ia6wBUh3162xseWkXj9HSswrniHgsjJKqYfR5XBJbBpOIaOZLcI33x0EaQqOBU5IngQkE687crODoi23qukvlrlE/Ok/EmjV4YPX8e7xyL2G+Jj4u90SAN42k/RovYy0o9ULTOb62GFijpTNFYZ/qmUBmD5Dv1prgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928803; c=relaxed/simple;
	bh=FIwJLiPALQ/U7ZadAFSF7n+UTfRqG1gRPg3GkEYdBT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRaogzE50n88bEuUXIRn3XIfJ3TO/9UvKE5InJ7XFPwq6w52L/X6+WRDmmwqQYLVArA6Hzmox2+Jkh/aAKvDylaZi1GfZbkvAQVzlKF11Ly/VvT5tW2TTdaKoQ+eVi/2pci1aeA7AsjySClN76zu+NZ+2+bIsxJiK2Qbq3zlmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhi3l8+L; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhi3l8+L"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so5729a12.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 01:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790928801; x=1791533601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JRkehR6QhzTUqhAnAiS8EO3o0r2RIFdddFBrAAp0J8s=;
        b=rhi3l8+LjoUzFlgK7wSjbQXd/illpt0avK9TUQhkBnzx5rGp/Q5UKbmA5M4G2wIoEf
         3nN2PaicPcuk4vu2e3JxzOKHNWB9UxQ5WbZm5T6pl0veJRZazlBVOAWDg+RQ5wsUo15e
         uIkeoNA8wCNhaOhnlYIq8knvDLwUlb37OnNZca8HDRQdeUiQ3AAVgH7tO/DqCJ0oBQTB
         EnwzIP64+MhcnoKN5WxS/UWZf1213LU/00s6uI3E9nVkVion8YkPRwNK8lHin83BG/vX
         UA6dj0gqMe2KIqlM9TM0xwjTXUUP6fueoDTqw/rBlMzIxoVIthDLQFmnY+pWTJnN+bgO
         btqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790928801; x=1791533601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JRkehR6QhzTUqhAnAiS8EO3o0r2RIFdddFBrAAp0J8s=;
        b=SS61D5YBCHXIsEe5cwMcbG5jvbYJ/BWeHTE2b1lKpjsslsLLV/VA1Hm1j1lP9S0qoh
         M1GkTwyUl2yprMEyv3WqNsH6ejWt5qYDRTaKWjlxK2XAaC1bY6oH+iR39F9vQ50OWO1d
         0cYHAiltvUNEJvK6KivUa+oU4oFcQjcr/h27yLbswH4MDENeUu/hRVUE1M2PCIkgrWms
         eoU3rYzutuf3SrdTejcH4C+VrJDJvwhh7N4g5vRahd0UMxlgEgkcGpLndyrzbL5VFHIL
         uhUVqc1zdT9t5iTynm4YPzIxaKK2m4OQCjAAfCiKjYvy4jXfigteMtRTbQFcW6NeMvZD
         ja+g==
X-Forwarded-Encrypted: i=1; AKwUvBwk+kaNooWLoUMcpXphAgLAr05btxBvgXTLB7Y33hLHADzIdpFY5p58uO0xLnhU857xgqN8B2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrJVgo6E9Z2F431vgtDwegtRVGgfceZSQ0tc7Df0NPbssJTxiC
	K/8Rj9Cvb4yVjF+dYgl0bw60djv6MFcGKml23kwej17p3wSOvW0Mc523
X-Gm-Gg: AYBFou281RGIK3nHzYjaHDrbBgAd+Ei9c64Dr46TqSXCbw9UVPdMPt3fmlCSzRpCY2s
	2fimvinj7owMHY0Dtv/iIkvxLyC2A3sFdsiorLBE+O2d9rzfN+FhIXfV3/g86h7bu9+k1jRYoyC
	U7ZZoQamEhTXA8dm6C8BU5hf8qTxC/YLaIdKim21d5Y8oT7GsBAnVzIhxp6ZIM+Wz649JxzOWcN
	zBMjG4uRBqraUCpbGIvj8Yfwk39M024WSq5/vYXDUogMcR5bvvZCPPRRJniUIEKY3WIONVDHOC6
	XnX2qMBWGBsoXOzJzi1RSAuDF+PKh+hiyI833zrekDpCT6iw31c8YoxOCkj62rStHRgQctvjHQU
	qJTHQhoH4+hbtu/jflulqVRmaCb29mB82HtaowyHq3prKzhgw/tE6ST0WShggU58m8TKHQtm009
	RETaY50DHaDIlzake/dP8tVCOFYTTQSWTxeexpFHs+6CwsAQjUXvKYr3cKgXM0eS60Skx/VeD1u
	Ti3bdQ=
X-Received: by 2002:a17:90a:d64b:b0:39d:f08e:e6e7 with SMTP id 98e67ed59e1d1-3a6ce3570eamr805756a91.9.1790928800962;
        Fri, 02 Oct 2026 01:13:20 -0700 (PDT)
Received: from hnkz-ubuntu-server ([2404:7a80:860:3300:f22f:74ff:feda:3295])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6f8525c0esm692758a91.4.2026.10.02.01.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:13:20 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: hughd@google.com
Cc: Kazuki Hanai <hnkz.64@gmail.com>,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	gabriel@krisman.be,
	andrealmeid@igalia.com,
	brauner@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] tmpfs: fix unicode_map leaks in casefold option handling
Date: Fri,  2 Oct 2026 17:13:03 +0900
Message-ID: <20261002081306.637148-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827152516.805622-1-hnkz.64@gmail.com>
References: <20260827152516.805622-1-hnkz.64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

shmem_parse_opt_casefold() stores the unicode_map returned by
utf8_load() in ctx->encoding. A filesystem context can receive the
casefold parameter more than once, and a second successful parse
overwrites the stored map without releasing it.

The map is also leaked when an unmounted filesystem context is freed.
This includes the temporary context used for remount, because
shmem_reconfigure() does not take ownership of ctx->encoding.

Reject a second casefold setting, clear ctx->encoding after transferring
ownership to the superblock, and release any remaining map from
shmem_free_fc().

An unprivileged user can repeatedly create tmpfs filesystem contexts,
set the casefold parameter, and close them from a user namespace. This
causes unbounded kernel memory consumption and can result in a local
denial of service.

Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")
Cc: stable@vger.kernel.org
Suggested-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
Changes in v3:
- Reject a second casefold option instead of unloading and replacing the
  first map, as suggested by Gabriel.
- Reword the commit message to describe the remount and close paths.

Changes in v2:
- Keep Fixes, Cc, and Signed-off-by in a single trailer block.

 mm/shmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 848316eaa7f4fb..1bd004c3dde20b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4509,6 +4509,9 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
 	struct unicode_map *encoding;
 	char *version_str = param->string + 5;
 
+	if (ctx->encoding)
+		return invalfc(fc, "casefold parameter cannot be specified twice\n");
+
 	if (!latest_version) {
 		if (strncmp(param->string, "utf8-", 5))
 			return invalfc(fc, "Only UTF-8 encodings are supported "
@@ -4998,6 +5001,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	if (ctx->encoding) {
 		sb->s_encoding = ctx->encoding;
+		ctx->encoding = NULL;
 		set_default_d_op(sb, &shmem_ci_dentry_ops);
 		if (ctx->strict_encoding)
 			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
@@ -5095,6 +5099,9 @@ static void shmem_free_fc(struct fs_context *fc)
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
