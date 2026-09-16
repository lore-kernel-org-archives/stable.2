Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AAB373BE6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584968; cv=none; b=NyzmIqIRXPhJbOLzTufODjWR8Lr5pBaSaKwkfbLY8vLrDj9Bi/mO1Yw8lt6G9DzgzU7IbkEY6hteQhHJTwNawA7/EkQJOqLKSzk0/5EZ7fHrh/yt585roq76L7EepFLJqWO67CraTKqIH1SlKZt65wgQ/HesAiI8cfKcWiXS/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584968; c=relaxed/simple;
	bh=NHsofWaYYVXnyYLwgauif+8R47/yymaV5pBTEesDLQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHLMTjz+CW8URPAQdGLa46mdFTwgJqa9iUJWiGnSq6hrcDQ1TA2wbT4g6qwhKm+4Cm7DisjUR7jOg3OProF/BQJPoioCxyE00VFELxIvI2y4c+POjRQqbOAcN3DVHCD1tfGgifFZhAxfflj1iyLC1ncm9ZAUPnPAhczhG4RiMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buEN0WCN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buEN0WCN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE631F000FF;
	Wed, 16 Sep 2026 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584943;
	bh=BlmDxvqPAn67pOJxPnzdDDgP4VYrosyV+AV6oypVva4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=buEN0WCNzSx+d6OODKI4PaZ96S6MWbQlLeK8j7DDEBYbr6biXscVDvwBcumowOFx9
	 +DTCsJts1eAuh6vwoiL1IBj8rofWg6xAY0Cql6J1Ee7uSBRNcGGGpTY6Yy9I4CjH/W
	 tZmzldx9nJwOKFV4Wx03epwlf5FNxue5yp7t/mOqrG9kZVF32a87vE2ZLbvlsOfG0a
	 UCv2tlvxKp2cGPVtAnEB/Cet1cHhs9LuZN/H2bLWCc8jbjNR06zY1s5B/u7DX9j7YK
	 Pm9HR7WDvwpA5xXjNgD7ULknMvX4Ztca1/naS8ALJpCnPWswLhrM5zTxWBD/WS+UL8
	 7IHh7n0pB6d+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] accel/ivpu: Fix a typo
Date: Wed, 16 Sep 2026 14:55:37 -0400
Message-ID: <20260916185541.1885084-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091601-reply-pointy-7e61@gregkh>
References: <2026091601-reply-pointy-7e61@gregkh>
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
Stable-dep-of: 0724afc55c77 ("accel/ivpu: Validate firmware log buffer metadata")
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

