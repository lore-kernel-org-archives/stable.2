Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E41E7C2E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086855; cv=none; b=ZrFAEjnd57J2vyv3kqbzpL0v1LlgHZbHmsII50C1dh2ERwEs0uNQ3rAyvE9eUApGfK+ciN+trnF6BDdPv4AcJ4RFOpOPk8YwSK/MQ7/Z9YojIwFLF5V0A7Xg/TDQ8bh++qYflCOwRfClpYwr3pxcz6znLPkG4CuIl4IfDcLZNTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086855; c=relaxed/simple;
	bh=8E8P/BfbS2MOGetdTsbO8MwBvfWyXA5b7Jz5SjqNPMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ13ftYLEuZDXAJwRXAjQrHhb6+YI9GXT2m3szegt70c0quonEh9dhkDA76YTPycLXdLvLTIqGAxVEGFvm0XarI5tboMtcFqjJ5+Pvf5Ne8j2AMNC1MCHJ4TnQAUCdWep6KD+O7KrERetQn2b5rUSBx9GGlL+Zq4fkbwyHzXUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0+aY9t9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0+aY9t9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C381F00893;
	Fri, 11 Sep 2026 00:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086852;
	bh=REXKWILcRDKu9T4bijhcCh5T0JID/fPFroWzWrvLlsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0+aY9t9W7EE/84TG/75h5clpGf3+/YX/UDDjAgNRpxd5/BMLXo3n2R3Pk13iYfRT
	 xAJkyUcfTXqBpC+IdzINCKNpTOPUrT8AfFbUolGvRhd4gqsjfClEUdPdiRJMA5Ht3L
	 REIl6ucvbA1Ys/85CVJKrAJlnUR/lKs+cJOad+UwFX44flzXM7x8yn7X8ptIel9qaS
	 vjcZc5B2QFFN5KORC1ND+BMxQIucCY/TVcxq4MKPG9ooVx/8vjqHf+auLNXAmmntB0
	 bHcxqUqfWlRwJtzSI7kqx4mYMnaXrPdgggV/RIcnrVLI1uTc5FGNQou3UlGS65veuB
	 suZY1oET6CsFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/6] nvdimm: preserve flush callback -ENOMEM
Date: Thu, 10 Sep 2026 20:34:05 -0400
Message-ID: <20260911003410.3483414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090938-reliance-nearly-8ed8@gregkh>
References: <2026090938-reliance-nearly-8ed8@gregkh>
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
index 5a1c68c701cfc..92d835c8dd168 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1094,7 +1094,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
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

