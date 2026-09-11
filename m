Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6F28C2BF
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086572; cv=none; b=btEewLcK/VeooEUjBWD8C/gkXxuuFM4AMe3QcYFShKJWsyYoZpuLV4uLjKNWmItS4Bal1Ae+MkYVFktrXyWYmGIgldw1ztn5996Lllu/1MYtRPs1i5rSfCW5Eu/+hxkt9qcsx639kRSMjqmoR7r5OozspPvZFIrhOcIyY9PSwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086572; c=relaxed/simple;
	bh=A69E6dxPywQrxObkvha4lyVvuK1K4eAVj9Nl1DaY0TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5WpNpKDh+yAIX+8GpgW3GGua6Laqub0pD70BX4zY1Mv/fkbbZSfphWkrEIMOlP8I/xXJv9DHPrZxcRlXC/ueA44lVSBKjAdupysqovvqs2m4eIFBMvHHUvewo/2RXQ5TGh9GjZeHLSfxMDIAQyIym3FipaICkeBDCl1L4SCuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhBw00sp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhBw00sp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484281F000FF;
	Fri, 11 Sep 2026 00:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086570;
	bh=zWrfNv3tnV1G76f281Q/xb13AUs9iS/4ZFl48Bpzv0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhBw00spw3qLoUMgnuuv6YqTrnMYnIlaAOW06S9hfgtKFnXOeqfNY3C3KTgdMQlrY
	 fAx7fnfizPYKpy/Tx/cNqxptb719vaQGulIMpqr58486Sl0wnTfoN/l5k2zQ8g8Lac
	 2tUlAsBBqL9ZzGLfRrOimZ6960jD9Fh++YGkfbAGRGy6cqWOKNDuhxTqdEITZklGL4
	 cwLbfeJSAsbVX9JVGjf43qCWfiQEhxlRnopgPaPcIdXHD3gaX3b8pZCYAcdr650FXx
	 2iQuZGWaXYtZWeFgXicYyHHrM3AiqwIHyVTJUe4Gd4sPp+4NudR7C+WMM4qm6BQezY
	 d1pvHMUDXyjcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/6] nvdimm: preserve flush callback -ENOMEM
Date: Thu, 10 Sep 2026 20:29:23 -0400
Message-ID: <20260911002928.3429646-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090938-graves-stress-5791@gregkh>
References: <2026090938-graves-stress-5791@gregkh>
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
index 5e079d61cbaa3..39669eb4ce34e 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1093,7 +1093,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
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

