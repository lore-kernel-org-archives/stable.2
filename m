Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807878;
	b=v/B70Tij7VrfkKGblKS37ecBM2wTxEET8NZquXCAfKEJdfqv3ZR6vobXxkk/KtLkTnwc
	 CnkUVLV6xK4SLz6iFNOJKRsY9kK5oy+bHRE5jiC8+FN2xPmZspohCyDQ+uNM9MNpJhjwS
	 xiocPz3IvxXDeFAw0NTkMqOG0Q9aMduH1NkNruPhCMTIWs5BbPrGUZWXGG4udKpRnCJeQ
	 Wqsqv1Qvig65fdXQmRNsMEwHnLtPZeeHAqdpGSkhhNJicnFGJMHtdfSHx+GmuFxv68xqO
	 wD3n4WiICBhW392ZIN2d/j4KLAdOG6fX0t40t1IfKz4QT8YO46KKi75acsp8hDu9W9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807878;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k0BofF5OqxPrUTD62Rw8leMXWpk+OHC8+xPs4Bm8KO4=;
	b=SmQSqFoR+1FB6X7LXGRZeNcqWuDP+nIdJFCcZTQufjg+l6W1xsnCS49qOKee6gYyZvkP
	 h0Ds8yziHFCcPM3jV5xr1hnlMXXOZdzhvKeV5IALORTBt/ahZTiNIZf6Xq19CsB8XLDuJ
	 qgDhEdWVcil5vHUqLkBX9Lz1qTH7u5hDkYDmyDQ/5R9/50Hd/XImrVtqbdmVmiFitrcJo
	 IBGA8xkphCrloqn5Q/B0e/0N6ALpDPVJdYo///oQ4TyX2p1EVTTCZAyChPN8DZEkdOVFG
	 sOGEJouPNd5fG8NNq4CqGI0yPqzBFvwMTlz8VVlf+2Y82bjuszbNf/zMVDS0ATwGkzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRvdyHoX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C46082BCB
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fRvdyHoX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89F41F000C1;
	Wed,  4 Nov 2026 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807878;
	bh=k0BofF5OqxPrUTD62Rw8leMXWpk+OHC8+xPs4Bm8KO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fRvdyHoXWU6fTHP/+Yolt4U57P+yKaY3gvkwAeARbCfUluwdrulM/6ljMmVMJwFLf
	 s3pZf1Uncuysug4Y/XqeE3ekt9bDz7/uJUnnAToq5Aflcx5E5VOhBKeJFIwodg4SbQ
	 h/Lu+fvtEq64jUvn7k/BIeK/0ByOkfa6ipRNuIwnFscPbwVAQmJBO+mx8zeVzoxCI2
	 9f7AwwwosHw6iDp0L8Ypq327Zdsg1E572lKx+2uZv//77Sux/k2AsgpDo5n35NS853
	 iPUPR2GJzNtn+8gI7T6fjx3M/Dc1hwWuMYZLEkIVPK5ElnG617p0BDlvuusuW3NJ/k
	 BX5EG99eYmiBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nirmoy Das <nirmoyd@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iommufd: Fix event queue release use-after-free
Date: Wed,  4 Nov 2026 10:57:56 -0500
Message-ID: <20261104155730.3918848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110435-fastball-maroon-2fc3@gregkh>
References: <2026110435-fastball-maroon-2fc3@gregkh>
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

From: Nirmoy Das <nirmoyd@nvidia.com>

[ Upstream commit 440ca8a4b69f40088065b9e05ef11373292a254e ]

iommufd_eventq_fops_release() drops the file's users reference before
reading eventq->ictx. Once that reference is dropped, IOMMU_DESTROY in
another thread can remove and free the event queue, so the later load
accesses freed memory.

Read ictx while the users reference still pins the event queue, then
drop the reference and put the saved context. The context reference
taken by iommufd_eventq_init() keeps ictx valid until the put. Fault and
vEVENTQ file descriptors share this release path.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Assisted-by: LLM, Specula
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
Link: https://patch.msgid.link/20261014133632.3440297-1-nirmoyd@nvidia.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[ sashal: Adapted eventq identifiers to fault identifiers in the existing fault release callback. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/fault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index bdaecb6e1f7a3..6e918eb0ffbf0 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -373,9 +373,11 @@ static __poll_t iommufd_fault_fops_poll(struct file *filep,
 static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
 {
 	struct iommufd_fault *fault = filep->private_data;
+	/* fault may be freed once the users reference is dropped. */
+	struct iommufd_ctx *ictx = fault->ictx;
 
 	refcount_dec(&fault->obj.users);
-	iommufd_ctx_put(fault->ictx);
+	iommufd_ctx_put(ictx);
 	return 0;
 }
 
-- 
2.53.0

