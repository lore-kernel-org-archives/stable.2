Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D233DC4C2
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654045; cv=none; b=K99Dk28+4XsRFZ0j1jfkuORd4xGIN1Mv2lwQpTMaPyK0AJ2T98FD79wwJgJOVavMH6GJgQSiNnzmCtNPeFET6qZzdTTiAs+3fG5a3CMMNE6lBbb6fjg2h3Wq7MKD6+uWZJzDYoY1MtgynR4DXEQKXuVMMYCEAY3/0VULscrW24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654045; c=relaxed/simple;
	bh=VGb6A7rV9ha3ah1ri1EK7udyIx7kepJKT+W365u+V3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC+4ncaEYloi38JwyPZmMJ1XClFGaZ2AD5qCqfVIkluU08VnaIrMgdaemtOQV3/FgsxzT3Ui+aBGHJ76njI0pmrBShBET0mwlSgs4/TM944YAoQh/Lize0l44qiH+lwD+k7D1/AoYHeoi/18Ti/xH4mMuFm8a19WLE9njZmUXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McREvxKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McREvxKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942591F000E9;
	Tue, 21 Jul 2026 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784654044;
	bh=xnSMCQ/UGMTT2o+l0k7VkUvbHe4i6v4VxvpI8inALNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=McREvxKyJ2LMNi/9JufI+r7rRz4o9APLKqe/QWdotlbmOOSJNXLcVdIG8+6z0i9Zv
	 yfJhXzarkIz2P5KD6ybcsIJKAZAJdbRJNowjYH9BWXgq1Me7EEEbAd/osa46XaCNEx
	 dyJz3ePnq/5P9tzpNVtUc6h6+F7EquRQBYt7lhnYBJyALZ7THBcycL9gVpGhaG9A3y
	 3PP3uWGWs0Ywa6C+MBx4jM4bDe5QOSUsjGUCuYozL/cgUu3S7COKemo5VRkaYsYV3T
	 3Pi8XE+0EtfarsgzeqHtKZj4EiZQpNOVwdqtWFMmh6Nq7A3hXa9F2DsaKjirl5CqPm
	 YsjOGu0FoTt5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] iommufd: Break the loop on failure in iommufd_fault_fops_read()
Date: Tue, 21 Jul 2026 13:13:52 -0400
Message-ID: <20260721171353.111431-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721171353.111431-1-sashal@kernel.org>
References: <2026071619-canning-snowdrop-2a4d@gregkh>
 <20260721171353.111431-1-sashal@kernel.org>
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
[ sashal: applied to fault.c as 6.12 lacks the eventq.c split ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 6048d8a1c8380e..ff454494191352 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -299,6 +299,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			}
 			done += fault_size;
 		}
+		if (rc)
+			break;
 	}
 	mutex_unlock(&fault->mutex);
 
-- 
2.53.0

