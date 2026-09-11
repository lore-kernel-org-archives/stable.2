Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2C30DD1B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089200; cv=none; b=bUr53TOpKi4+7HRwS2ADhAujMCzZxc+R781I7r+jyEt8XICghWnMBmmTm5miTB/eEs2sCf0pXQglXyBBYyAXyFENHYV1kTSFXEgjjEr/0rMvFMUHZHwWBKS9V2lo7GMt1eQJczoC69TgpTR57px+xhuOkSEz3MC3N7sqOYLIgcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089200; c=relaxed/simple;
	bh=qUGlc6Zx2DY79foGMdFOB4kykbR8dlfPhuZbolzITKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuFN5ySqwCF4xtiNFhAMghWoRnhQJCVUoFoG4YVrtH+OAuiGCUUDuVchrjnZIkYSfH184cXJSX6KdeEEiycD5CSNDrtrL/sJGhssRgFshMBqYpiqkCPLyds1RguysP1HacMoMLu3xjGlDz5Z+RzK5wMKhmP/lAQQ330FthZBp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcya39GM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcya39GM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303AB1F00893;
	Fri, 11 Sep 2026 01:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089195;
	bh=ZdRHE7huHV3dNkHkpVe8xYBDrDrLS+5Dmtctit27fhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hcya39GMrFt42h+Mjx1XuwXCVCMjxIQW6z//gUW5zXoK4FMLwmAGDHh0TXOqm8o55
	 Ih/W9IgugTW9knE8LRzmEDcZnYyWV0TVk6y4r5NTReGFGZQ6Iv417KWTKTkPnbhBUL
	 JR8Nzi5sUdEtDdbexqA0vlUMPwqHqOlc6RZmPjYVhc1Ir3sGG7vPMZl9H8uneyQIDb
	 SwM5qLp5Gzdw/hGwe6o8Ozr3s7cJtecMwsYPtalw8A38E6I23sO4OAu/qtVTwErT4l
	 kyta80JjU5ImzvD0HD7jdpnWXl/zp1h5fJYrzYb6jyLvhuP1BAMJwoR3sFFmWt8Ghg
	 JMxm8SBu2/Xcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/6] nvdimm: preserve flush callback -ENOMEM
Date: Thu, 10 Sep 2026 21:13:08 -0400
Message-ID: <20260911011313.4034971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090939-defiance-yelling-974c@gregkh>
References: <2026090939-defiance-yelling-974c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

[ Upstream commit 6b7108712a4b1c37cac69815aede1dde202b3187 ]

nvdimm_flush() maps provider flush failures to -EIO. Keep that default
because provider callbacks can report host-side or backend failures that
should remain generic I/O errors to the guest.

Guest-side allocation failures should not be reported as I/O errors. In the
virtio-pmem path, the flush request allocation can fail with -ENOMEM before
any request is submitted to the host. Mapping that to -EIO makes resource
pressure look like media failure.

Preserve -ENOMEM from provider callbacks and continue to map other non-zero
provider failures to -EIO. The generic flush path still returns 0, and
pmem_submit_bio() already converts errno values to block status for bio
completion.

Suggested-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630092338.2094628-2-me@linux.beauty>
Stable-dep-of: e57140944b5a ("nvdimm: virtio_pmem: refcount requests for token lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/region_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 849c131f39c75..4e24dccb2ff86 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1112,7 +1112,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
 	if (!nd_region->flush)
 		rc = generic_nvdimm_flush(nd_region);
 	else {
-		if (nd_region->flush(nd_region, bio))
+		rc = nd_region->flush(nd_region, bio);
+		if (rc && rc != -ENOMEM)
 			rc = -EIO;
 	}
 
-- 
2.53.0

