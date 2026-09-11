Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59225776
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123304; cv=none; b=tCjjUOKJvg71w6d0AhtBF1Egk+g6QqVlcr14juqLns5WNALxfVsSzpJZiVQoXcYLTrY3sdiNeteUawEkQ8++A757A9b7F0RCMo7PC5AFKI5DIwBLzQ7D0M5Y6Qg/9U5oJl5jBDQfvPTtuIJEG4XcUlqOTi6jS8q89g3PMGMhrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123304; c=relaxed/simple;
	bh=GoX0obQHqyhE4RFqV104QJX0902CfMUoEk4l5gV5M1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uThMhY3ZwLVzGlz1FYYQ4qmAgM4tQ2j/l1b3fujrCFJQ1RoCte5GAP2Wzy2MNJic/mWGKk2tILSFariLQ1EiP8Bgzt4IHZ3+kc2wchlgrDXqSUqMr6jxOn2eEmXprExB+XIX+nR9v+v+QH6xdfiz7NBHUoLNg9+jN39eZ92QRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI5ICARp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI5ICARp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3410C1F0089A;
	Fri, 11 Sep 2026 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123302;
	bh=z8EPKrB1m3fAVYKUVb7deMOewxholWkdojucML4tDGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WI5ICARplEyQ9J7qd8XBwzZsmMArtmt+VXP2caxb0D/1ZZm3lUdbhY7gPX6mF6lys
	 jdsLFH5YEsFr+LWHxbgZl+hlTiw/FkItUVGivu+3TyJvdOkKTQKkpzC1ZObatpHGkv
	 zgT/aWcgu6BBnbzidhiAmENPZFIDm5jPslZcP4uxY+a+8BAVSyA5gbNTTOpGBmdNIU
	 kNm9AI2V3ekQ2PbegzguKAXD3UOrptVwGR4zO0gB1F8QIY7/EiyPUssR6ZHCAuFl3b
	 ZE1osBl/YqQWR2E65hdEpC3cUujrc0g9E2BqVlLE9kHsmwh98oopaFgDbInMjnqJ3F
	 Jq2NjRVNqiapQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] nvdimm: preserve flush callback -ENOMEM
Date: Fri, 11 Sep 2026 06:41:37 -0400
Message-ID: <20260911104140.195754-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090940-grappling-configure-44a7@gregkh>
References: <2026090940-grappling-configure-44a7@gregkh>
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
index bc01a0da168d2..8553d9322175e 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1065,7 +1065,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
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

