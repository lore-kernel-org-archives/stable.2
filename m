Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636E3BB69A
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715146; cv=none; b=PwjQxMdy1cHA7/viTqjurGUP/T5u3DAIk/SS6TnGgBHiSaW6bcaMTv4ThvQjjWlouJLQipI1jpeTPprTrl526Acjp5HqBe9V16/9g1zXG5j+UZDy4YxiFNN6vRgRvDsrSwzPECnW7w7q6od5rjzK5mClMvJtICJsSwIMs3ESxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715146; c=relaxed/simple;
	bh=YwYH5tfsgj4Yl3t5CcGdPq9DJN6xh5+uKWNAUWiAL2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvIIjHeMa1K5jfCkLFggA5vtsUG+kYMuvV+mbs5qGac6uNSSDqSnFuvhsSYNTacWt7bLwQPtIhnhIJDaWJr5YnVTEovr1qyENwidOq1dPwtBSTCUTd81+P4enhpCoDmRp+ru7tNyUA2cGljpjzhYTngpK9JhFn3dCuiJWGLKHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV0K8hyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV0K8hyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACAC1F00A3A;
	Sun,  6 Sep 2026 17:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715144;
	bh=aioskovU9PaUQTcVt3a+vNjsfEMIThpUrqUhgz5f8Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cV0K8hyl35oASIaJu0jvJyKBgxIXNwWRFooKC4SCasZjd7hPMfdqRQ0JiK4Dll+/5
	 ZMGhXn8yVm0moF6iyr9OAElIXlUuaym3xY9zr6Hka95gHOuAxyMd6IZVoSyp+9VX0r
	 l9zyOspM1ZG+Ej0VCCkV9rBQEYY9SgDc+RmgiA9/9LC/v+I2/uc/hT0ZGBo333vZDZ
	 gDC01MzwvOLgh9hqdZf+J3FsvmBlQltWEk3HWaAzj+V+U0lKwB54N7t2L2ZjDjXdLq
	 lZlxq8vZ9+HctUI9mrSRe1dTiX5hNkz5qdvlf86UYM5rebHZ3MaOzAFaQobAtIUUXY
	 4RxHn17r/+4aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] btrfs: have proper error handling in btrfs_init_reloc_root
Date: Sun,  6 Sep 2026 13:18:58 -0400
Message-ID: <20260906171902.1684623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090300-visible-upwind-24ae@gregkh>
References: <2026090300-visible-upwind-24ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 00bb36a0e76ab7e94bdd70d561baf25f9bc1415d ]

create_reloc_root will return errors in the future, and __add_reloc_root
can return ENOMEM or EEXIST, so handle these errors properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add comment ]
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6d8ba4572922 ("btrfs: drop recovered reloc root refs on recovery failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5b921e6ed94e2..b0d34879e267f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -878,9 +878,15 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	reloc_root = create_reloc_root(trans, root, root->root_key.objectid);
 	if (clear_rsv)
 		trans->block_rsv = rsv;
+	if (IS_ERR(reloc_root))
+		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
-	BUG_ON(ret < 0);
+	if (ret) {
+		/* Pairs with create_reloc_root */
+		btrfs_put_root(reloc_root);
+		return ret;
+	}
 	root->reloc_root = btrfs_grab_root(reloc_root);
 	return 0;
 }
-- 
2.53.0

