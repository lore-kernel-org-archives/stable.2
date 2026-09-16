Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13F44C51C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588855; cv=none; b=sLyX4dk5oZgkuGi1jhe1s56VgiXhy/iJs3hWz7paE0R/1Y56O1yU70AMt4C4zbWnkwNmy7zdEkthfIDT04CLWpyegUd9pYV3IQd2u8MrDhIxcRpZ71YWjwRPnkAL9fANGYRH0la3QDQik+uwV2csmjegfUXVNhf7Mn5gzEQhhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588855; c=relaxed/simple;
	bh=WMRLS+gOc65hFSe1HrNpMvfSUTKQl54CcXyT6ZCoLXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Laa8FCkhhRJJjFcMMDdoOBkXfg9agfaZ/2dJGl80tJ3/YVQHKdAYRaAyYt3erAK0ILyVxRgiqoypiORma3/Pch6FESdkdJHxixZGYfKJPKfrUm9iKwS+sW/M0CuaLSFLMUIvJLZjZ5LKDxX3O1Sy241NZByoWu/BJqRLwl/jjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF5XC7J5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF5XC7J5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906761F00899;
	Wed, 16 Sep 2026 20:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588840;
	bh=+/cG0VAQ64qzLAMsJ4bQvP5a1n0C4fW7nwu0YnyDvx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HF5XC7J5DAwTP/Li+jFlZcbHjK7PLqpEul4GOkDsj1Tbf2KOMAlWltPeduquvCMkj
	 u5hhxsv7kHqu2qhVnLvlIeaKhlY1VjfOZ0Ucz1Jjj4WWQBkL3Oj1rxE7RexQKWlD/t
	 es9WocNJc+6HZ1J5JRUeclc3iWEzoU7yKeQZgj2+PVLTs6L2/aUBIgLpE3/HtTBspV
	 sC/zcvDnBHlmiQpYPIXOo+UqST7wAOSRDSxTPdvMxaTCQg24WMUVYb+9l/mSSmILrt
	 PmMLpjrqhe3JWWepxio3AXP9gi2nj11a15YAXsFPQ2aVT2RDkDh9vZcKHEd+CwjxQv
	 bojGJWyBpMSqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] accel/ivpu: Fix a typo
Date: Wed, 16 Sep 2026 16:00:35 -0400
Message-ID: <20260916200038.2459399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-moisten-showy-63d8@gregkh>
References: <2026091615-moisten-showy-63d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Kreimer <algonell@gmail.com>

[ Upstream commit 284a8908f5ec25355a831e3e2d87975d748e98dc ]

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20240909135655.45938-1-algonell@gmail.com
Stable-dep-of: 95bf070f3225 ("accel/ivpu: Limit firmware log name prints to field size")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/vpu_boot_api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
index 6b71be92ba653..88345070a9965 100644
--- a/drivers/accel/ivpu/vpu_boot_api.h
+++ b/drivers/accel/ivpu/vpu_boot_api.h
@@ -8,7 +8,7 @@
 
 /*
  * =========== FW API version information beginning ================
- *  The bellow values will be used to construct the version info this way:
+ *  The below values will be used to construct the version info this way:
  *  fw_bin_header->api_version[VPU_BOOT_API_VER_ID] = (VPU_BOOT_API_VER_MAJOR << 16) |
  *  VPU_BOOT_API_VER_MINOR;
  *  VPU_BOOT_API_VER_PATCH will be ignored. KMD and compatibility is not affected if this changes.
-- 
2.53.0

