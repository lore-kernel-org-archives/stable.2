Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA1B33689F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653994; cv=none; b=S9eaJvh8wo5gje3/8ksPk1inKzn7GlZOE8IAJePhM65eCh6bVy70UBr5zqqIGxxE+n7jfyP6QqYsqzSiPDZaVU+hS5OFf1mes7wY4JGohR+83hS9rNV2qu60gdHNklrWh7uJXueZiHMbjQFLG1ydBANLMo8irhrp5HSVn3340jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653994; c=relaxed/simple;
	bh=30zUDDWRQj5KsPgwotYgJEOzht5ermfNIfN/8Ee0EuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAJw08y9tmnU7ZA0ORktRn920edN2QR9m8dLBVsWXLFs3Cl/ffqq7t8g4UKR2fFQn5u2x/PKJQez00AvqbOOy+Qc7dEF8NQrHz1DKQWIFzMTik4lK3DkWMP8F9rc7eeb48TSx2LGpnEvIuz4Bu3+enOu/Hr5eNZ5lxEZbrmk5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcFJoUvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcFJoUvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2C91F000E9;
	Tue, 21 Jul 2026 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653993;
	bh=fOQ3616HDNlss8VS86r0GaOv6dK1Win+86QzaYGX8Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcFJoUvtWK67OFC7Y6YWxuegxyGC7A+AATk2W2w3xd/NO5CKxlBNHkXh3vYrof3BY
	 pABoxYBUwPn3nxCSLt1pt6xnfqg/svajcPyLb4i5xWURCoeLer6T95kk4gAdua82GS
	 XSb4f7N48oOApSOEdHtYpllNJgvdOqkAY/V3aGopiz91kjPCPm5YxnIknPQQ27BB36
	 85Rv2220CCHiAr3swZCGVTWSUCEjNMIQrsvvhGrWg1Tt+2LxqdMIs+Uep7qXTgwLCO
	 u5TD2OP1PeCkPjlRaXoT+FAOUPWqUJ4TJhXGS0TgkncR21Pp26rayACHLAj0Zk17MA
	 IlIzu/t5wB42g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iommufd: Break the loop on failure in iommufd_fault_fops_read()
Date: Tue, 21 Jul 2026 13:13:11 -0400
Message-ID: <20260721171311.108330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071611-prong-distrust-2ab3@gregkh>
References: <2026071611-prong-distrust-2ab3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit 172fc8b19825a0f5884c38f2289188284e2d45ee ]

On a copy_to_user() failure inside the inner list_for_each_entry, only the
inner loop breaks; the outer while re-fetches the just-restored fault group
and retries the failing copy_to_user() forever, spinning the reader at 100%
CPU with fault->mutex held.

Check rc after the inner loop and break the outer while as well.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Link: https://patch.msgid.link/r/336a9b6e44fe66a24199d3be777c405c85c98622.1780343944.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 8226e28d79a510..4b37244003f2d7 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -296,6 +296,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			}
 			done += fault_size;
 		}
+		if (rc)
+			break;
 	}
 	mutex_unlock(&fault->mutex);
 
-- 
2.53.0

