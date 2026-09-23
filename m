Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F2306D2A;
	Wed, 23 Sep 2026 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133426; cv=none; b=ZFsCEuJ/IyFK0/zYfey+rmwFZC4PjdVPzyANN4sFxXaoZyGTXBXKHwvglz2tsjhln1JAcfCaCtaxq7Y0ij3kLB1vWOBKfnr2R2P7kY90BwNSazPS+ToqKZibulFTYjHS7BA6BYLyqDD5xAAhDGffwHBKX7AeVP2W7JwHsk5a398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133426; c=relaxed/simple;
	bh=cpdCqDTtq6OzdQmR7vApqFII+zHNBr6OyO5hRcTXONw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bsZbHLA/EDAGxRUcDhl+jGaBa+5cTQ12ez7X9tos8/6dk2rC8jFzYbp2HFSAzbG8kI2Ln/N01l9SwLauQdeUH+J2OoHdfXKn+eqlNgXh41U1IKS/gyOTKRAUDklugGF145Oj2VWB2N7wR9CWWlW91xnXl36VxZqUmLAi2MzE5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Uhrspv5G; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Uhrspv5G"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4eceabcf1;
	Wed, 23 Sep 2026 11:16:56 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v5 0/3] nvmet: avoid recursive configfs open
Date: Wed, 23 Sep 2026 11:16:38 +0800
Message-Id: <20260923031641.2016406-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cc44336203a1kunmae5dc6a4b63be
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx9MVktKHUtOQx9IGkhKQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Uhrspv5Go3edRSJCakrVJ8Ct/hJu2mXJsft565oXrjZwu349un2wQlVxjjeicJFymJCLpnOaL3hdIiS6qQrURQiglQgJ+C3HwXVbkqTlZvTom7+eHdH0m7aqOxwYWTzLCwZHO+p4jCaWtBhz1obdGnKSgvPfXZsq/eDPXdrCRbI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=C7RRtsNWLeNcIF2K/Vpd4E+BXgF+UtHFYZksle4q9+E=;
	h=date:mime-version:subject:message-id:from;

The nvmet configfs store callbacks hold the item's frag_sem while they
enable file-backed namespaces or passthru controllers.  Both paths open a
user-configured pathname.  If it resolves into configfs, the open path can
re-enter __configfs_open_file() and try to acquire that same non-recursive
semaphore again, which deadlocks the task.

Add configfs helpers that reject configfs-backed roots or paths and open
the resulting path with file_open_root().  This keeps the normal open-time
permission and security checks while preventing the recursive configfs
open.

Changes since v4:
- Make the filesystem-type check local to configfs_open_root() in
  fs/configfs/mount.c instead of exporting a one-line predicate, since
  there is no user outside configfs for it.
- Add kerneldoc for both helpers, documenting how they are meant to be
  used by configfs store callbacks.
- Keep the Reviewed-by tags on 2/3 and 3/3: those patches are unchanged.

Runyu Xiao (3):
  fs: configfs: add helpers for opening non-configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c |  3 +-
 drivers/nvme/target/passthru.c    |  3 +-
 fs/configfs/mount.c               | 67 +++++++++++++++++++++++++++++++
 include/linux/configfs.h          |  5 +++
 4 files changed, 76 insertions(+), 2 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
