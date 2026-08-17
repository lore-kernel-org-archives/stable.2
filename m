Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E84B0481;
	Mon, 17 Aug 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977761; cv=none; b=tKgaGSXJ4tyMjMCz0m5BFnT6wFaGKNs7vxJxmh+uyz7X1ZYQ/NLNga4yK195LX1gXPRs9nhPz5oNsGUWdTxSP73oKjm1qStkcasIl8cFtyIdnuMNUbRwv1pgG3ZKja8esIIpTlHd/UT6XEGOaNtQa8IK4sJu+XBpbpEKYICdAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977761; c=relaxed/simple;
	bh=Z8/BKdzKYPpt9DJRJ6pYE8bYfi8YO+28uSvokqOYrM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+GlOwKS9HJ2AgpgEsOJwscFyMv2CsZW2yu3b/U7qvPkhoDXA8616QgKEqWCxjIPpQknSpkeXfnOPRyq5kXi11DIlJI5hWJ3cJASiaI2hrTbF5dswdlTp6Jz6UxiFw81kjtVtLiKtXBpgodJ2jaRENUGZfNWiA/UJ+ElGCgNvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=KywU49zq; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="KywU49zq"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a47a6f35;
	Mon, 17 Aug 2026 22:37:22 +0800 (GMT+08:00)
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
Subject: [PATCH 0/2] nvmet: avoid configfs recursion when enabling backends
Date: Mon, 17 Aug 2026 22:37:12 +0800
Message-Id: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01027db8703a1kunmc75580f1e6400
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGk5PVk8fTktCHktDSkpJTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KywU49zqZbkoGv6mn38VdoEC77PYf7D43LK6J0Fh/hiac+LQ8TRNirJGsYXijXKNv7nQsRKsq8lwea81eLBLW3EDFduefc0e/B8mgPrJgbcLenMKL22WO37vBT8daUWJvkE1n64YEY0bGhzOLubt/nCG1aD6zl+/qUi1ZytlnHE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=xZkaB3vSNVhh3AwEWOTxc3wLSRpDilse7YBukLyfPIQ=;
	h=date:mime-version:subject:message-id:from;

The nvmet configfs store callbacks run while configfs holds the item's
frag_sem. Two enable paths then call filp_open() on user-controlled
paths:

- file-backed namespace enable via device_path
- passthru controller enable via passthru_ctrl_path

If either path points back into configfs, the open path re-enters
__configfs_open_file() and tries to take the same frag_sem again.

Resolve the configured path before opening it, reject configfs-backed
paths, and use dentry_open() on the resolved path. This prevents the
configfs recursion without changing valid backend users.

Runyu Xiao (2):
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c | 19 ++++++++++++++++++-
 drivers/nvme/target/passthru.c    | 17 ++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.34.1
