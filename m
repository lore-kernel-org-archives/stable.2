Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416049;
	b=VxEUpuUhinv4ioNVrGHtw+jEscOQqAsyAcjrRF3lgPRyNgUFJzYgXo+kjdeWDnccLhfJ
	 yzb/rvx46cGHwxX7Gitkcucf7xPiFmRBOPWPRIjfSgWxcE+SLCxNSSP3MicAthoUjvTlV
	 l7JGuhzsNU3aKo6tUFLnO58yZmR1C6+MABmjoztVvH4rNqHGNglvJ4PEbNkwF0HbDcTz4
	 KuGrhBy3OWQeTSpQxOn9LDcsubKNaxBIqCMEmVr/89pYIpJW3tU28YIsgCAuXUm2/LuwK
	 VbOLaOX+iEo+HjcODeS3ImSPa1bqQgjhmSTXDzR0GxZs33qVe3WTKhCNh98U6n/qvkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tjJRV0KdXCifSxUE3oLiRkKLGvKex2NUG2KQPU3MPpI=;
	b=gG86kXapzfDp0MT1E7Qa5EoEgWVQK9RwmZ1BjoyumCt/kW2SAszJmBXl0E6cXUsxSqnT
	 J42fbjAxaBPQ4AuBM038jS2vYq0KYrCVX3t2gBBg9ns+cU7aZEJ784ue4fflyIYsxOMPF
	 CUZD/stCfx2AhsFqZbbWYOhyAWzwM7lEPVFPni3+a4VsIDmbQeiW/W7vy3fZ0Llzu/hk2
	 yBDx2+FFTQJhy5Uvg97VkCcP5jGA4o2pSkzoJqfUPopHKuyccjJy0Ae0FXbryra7V6gPX
	 /GEORQZidkmVlBKkHZk0LNnst4KX0y4uxa2t+7eITKdvUvrpa35DoGez2zX80QtxD9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIN9nhyM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B91606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIN9nhyM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD291F00A05;
	Wed, 11 Nov 2026 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416049;
	bh=tjJRV0KdXCifSxUE3oLiRkKLGvKex2NUG2KQPU3MPpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IIN9nhyMneDeI9TOJesvscX27vYB1MOc1N17QR5auuJCHrM3+6yegUofEwlv1arCA
	 bfi58oJ9j8mREOTxBRSrpm1yktBjZYyIIfi5BYpyhCC/k3hcphEvovTXXEnp/+0XLJ
	 VshMtUIzdgCiQWBz/5yEnj1jcvBtkEvOPSl4ABSEDsoOUhrFvdI7GyZY4tKxrR6fCA
	 Ly/dt2I8xLkwQvksk+MWTi6SSdyPX0a398TfOYqug5mNonY/DL4AbZnPo8ZEeQ0hqs
	 VIy/TcscG5B3yH7zQWQYKXwYySwxmvB4PC2AgzmXln95WB4o5ngznmQsqMvU07wg3j
	 xdMxGeleML3/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
Date: Wed, 11 Nov 2026 11:54:07 -0500
Message-ID: <20261111165354.3388568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053640-failed-6.6-9b036546a02c@kernel.org>
References: <20261107053640-failed-6.6-9b036546a02c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

[ Upstream commit 9b036546a02c6c9a5133f9c1e93503896595c6ba ]

When dax_range_compare_iter() returns a negative error code (e.g. -EIO),
dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds the
positive return value from iomap_iter() indicating more iterations remain.
This positive value leaks to the caller, where vfs_dedupe_file_range()
interprets it as success (bytes_deduped = len), causing userspace to
incorrectly believe deduplication completed.

Return 'status' instead to propagate the actual error code.

Fixes: 0e79e3736d54 ("fsdax: dedupe: iter two files at the same time")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Link: https://patch.msgid.link/20261015143426.17620-1-jianyungao89@gmail.com
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
[ sashal: adapted status references to the existing compared variable and processed iterator fields ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 94d552a2e6097..bcb93c105bb44 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2067,7 +2067,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		compared = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
 		if (compared < 0)
-			return ret;
+			return compared;
 		src_iter.processed = dst_iter.processed = compared;
 	}
 	return ret;
-- 
2.53.0

