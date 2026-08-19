Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8E747F774;
	Wed, 19 Aug 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154773; cv=none; b=AwIrXnlMS5h7dPuERXi8siNnzWEKnQn5VwAyAXeAyZZ32Miegeb2hS897XWrcZzNnPUUtq/AMwKQzcapJX+mdk6ti95F3YOFAjd5bp2XnuE3d8ziX+jdWqG8AIKOEWpCqwbQnotu+Elz1Iyf6JvTUimoH06FFNnwb/YZVXMGcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154773; c=relaxed/simple;
	bh=l9Im5U4x3gB32ADQA1GGGm15/Sj7YSo8tgR+r4DYxJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mp3eamGTdFBKoQcERMGnGRK2BT8cW/+8et+RywdTaiuSevT8O/KNHgcXR5tYshOToGntzRg+0SyT2x/RHaVI6Lfhf6boZgye/fKykLWJaSNtVO3OjY6BcpnYSIQfOEhoY/mJwXEkwCOfP2ypFIwU/AiM75Qdr2HPKiC9A9BZCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=TrOoaB0u; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="TrOoaB0u"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a95ff6dd;
	Wed, 19 Aug 2026 23:52:39 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2 0/3] nvmet: avoid recursive configfs open
Date: Wed, 19 Aug 2026 23:52:25 +0800
Message-Id: <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01ab97e2903a1kunm38a93da01445a1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGR9NVkhMSUIaQklJTRoaGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TrOoaB0u/vLbkxcd9ooY+sYodz6ttLvfP206kDx8cLWSSNx8PVI2XRFPXlVdMotj6l702Ii/i/lYT04z6vblJybWkFwUjtRXUEvGomLf7937ysdjHK3MBTn56bOCS+Gg7IHg5ofaqi/++Y9ed3bUl0Rvr1RAIr7MdGWQtJHEpDE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=sTS3S21AVaGPg1KNZfUBi7GL9TMq/vAFdOnL6DwUes4=;
	h=date:mime-version:subject:message-id:from;

This v2 moves the configfs path check into a shared helper so nvmet can
reject configfs-backed paths without string comparisons, then reuses it
from both nvmet open paths.

Runyu Xiao (3):
  fs: configfs: add helper to identify configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c | 20 +++++++++++++++++++-
 drivers/nvme/target/passthru.c    | 17 ++++++++++++++++-
 fs/configfs/mount.c               |  6 ++++++
 include/linux/configfs.h          |  2 ++
 4 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.34.1
