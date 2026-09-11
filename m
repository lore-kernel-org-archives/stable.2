Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BD245012
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091038; cv=none; b=LTcYTyt+8W1r9Us01Q4EyiRWKIrGpROu1wyD2CqC+ZBsDjCNAX4eeqMwch2c8kIY9aF1epIpkUcfQFI8p06Y/2Yu0fFcK8cDUMrGWuUfRFiGcYx6xISHW5o2BsokdQRNjZsuhuBC/49wWoIglcxyPSZqgMMidx2n71uC1ALoyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091038; c=relaxed/simple;
	bh=stD6/mENqPfli5yCUHOVGSD8WpWgGvdfDJv1Yzd/H0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4d4kxB5P7buBdkcWfqtDb5Ou2jy0a7uM1Y2gOz+BsUHNRGpUjlw50vc6vZgYnvCeKyUp1SwSfAp4r5uQNyb9SiFoWLJkvRVYMtAfEI5/dSLycZI8g/sySrXNZmUjLw004UDq3QISPQ25zU2wcw0nIpwb8yoTkdQyoYsEnWoEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayzbeZKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayzbeZKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40191F00893;
	Fri, 11 Sep 2026 01:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091037;
	bh=IyUna8Bb9cHOuSxO/Q7gmILjgK9wz1pdrLZNot+c1gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayzbeZKqQB6lXnnZ7iTI8qwpiJCSCTXjHqyRGwYu7uapTugF3qONGaIYQ0BN3w0TO
	 Il9O3fb1TCmd0nW6cZ7EiYor9Do2yO8K1E82SLowKNydGpkRHXAwG+VrOSsM5oxMIq
	 43QYIKu6wNmaUyNek/BAWLopq0Lpmvy/tOw8ze4uUFBXz4qc/+vpxiPvzcD194jyiJ
	 fFJ0eG6ftLjl/inIWQHoojKZUhywDeCTVHXUI3LAZxpnBmpHCHCOiokwZMF6f7bCYu
	 roSgdx+7PaduSdB6cITnUnbWz+nugQdGupbYFf9Rt+qsB26H8Cuvn6hyuxyPCSJduH
	 flsRbVwvVta+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/6] nvdimm: preserve flush callback -ENOMEM
Date: Thu, 10 Sep 2026 21:43:50 -0400
Message-ID: <20260911014355.4149601-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090939-disdain-corridor-626c@gregkh>
References: <2026090939-disdain-corridor-626c@gregkh>
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
index c13264c7b0deb..f6d14dd7b387c 100644
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

