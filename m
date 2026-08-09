Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11D2DE702
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786286887; cv=none; b=M4w+Oyu+kKFP5pf5QnkjevRVY0+Bh04MFDGqhBhyq238I7VVcxoKbXrDLdJEOEL6Z2i+JoXWjaO3seAG9itWV5eUtc/ks9aaFrLozOXt2aMenup+E9iObG2he69NotuxAGCbECJtFRPQtJIVi8DiHhm7aQSQt2gVMy6tYeK3k1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786286887; c=relaxed/simple;
	bh=BOfvsSjoapZ/Zc+CnFxFQd25B3R9ku7UifAqN/YL7s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go+1kXA7zftLj1NFY0+LCyzRTLhzdmCXejM94anU1RmiVmxI7zFSsePlFjvyKAxOV13H2XF/lmah0dM5Mb9zVTfSZc0rewSturkqh7yJ95CjJa7W4Uta9pJ1kTC3w6tagor3uCG2HilPM517IIg3ojSpRQvFLbK2j25hh5DqQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDBC3ly/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDBC3ly/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED2E1F000E9;
	Sun,  9 Aug 2026 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786286883;
	bh=I2n+kNDjShQCEQ54KfqVf1wh7K0bLT0w+utbZZcUW/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SDBC3ly/s7G44GQHGVSgEAhsSPkkKUTCvL2LhMBkJJBBco18+x735yWQ0yNpyd8uE
	 wp0oIjDKhc+I+a8BvXOiMfj8r6KODvyUfsmhJWERBRFSnTACx5CBZ5BQ+wZ1vBl/37
	 fx4UkcLDUG4WHIkCV2IZwupSp4bo1VqTgGRQzo63oPbphsNEg052eoNUbx1U3Bc5k9
	 q5i7qwoSKCAg2LIrHtHKBxy6mBT0yP2EHZT/C13o4bBSysdWXrC+0sZnXaYB4C6mHt
	 G1RMdnkcLG93x0M8ur9VhERxHbtBYxcQyTS2xigOoaT6KJKon3hQajMbysykGdQVD0
	 yOxIj5odgJusQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] btrfs: add debug build only WARN
Date: Sun,  9 Aug 2026 10:47:58 -0400
Message-ID: <20260809144801.1787109-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080520-punk-economist-e412@gregkh>
References: <2026080520-punk-economist-e412@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 3db15c6ca6feb2c5000a1cbb39c33866e0349abd ]

Add conditional WARN() wrapper that's enabled only in debug build. It
should be used for unexpected conditions that should be noisy.  Use it
instead of ASSERT(0). As it will not lead to BUG() make sure that
continuing is still possible, e.g. the error is handled anyway.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 8bc4d7209611 ("btrfs: zoned: fix missing chunk metadata reservation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/messages.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 08a9272399d26..66ea41aa36082 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -181,6 +181,13 @@ do {								\
 #define ASSERT(expr)	(void)(expr)
 #endif
 
+#ifdef CONFIG_BTRFS_DEBUG
+/* Verbose warning only under debug build. */
+#define DEBUG_WARN(args...)			WARN(1, KERN_ERR args)
+#else
+#define DEBUG_WARN(...)				do {} while(0)
+#endif
+
 __printf(5, 6)
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
-- 
2.53.0

