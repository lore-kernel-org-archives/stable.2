Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2022E0B5C;
	Thu, 10 Sep 2026 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789016063; cv=none; b=DUxAEuvEQP+EbxLyR2UL2WtpzdywWYjCdupLUoAEPInCAuYVeFVnv2Uj1qcgwk9qY6jtoipxostZ6ZspmyJ80CnR/Yq7ZHGiPBTkxrdeCxij8iABrKdV8+3uCSsgjdIveqBLznS+YfsRWPGmDrV70On85ohBt/Y59VGCgXUbzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789016063; c=relaxed/simple;
	bh=Ddi3vmY56A+OJnvZGNLzzX04tVkrqlrw869MVFV80hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQMmqAPhZa5OyMs3ZYH/qrsPGt5wVTeX88JuipdWYbo+rN38F+pcVFvwg8eAkVjme26fH+EvwHeDl3eeETgUa+fb/jw2i88HIq5AYVmZxb4AWjXyLB3vvqrQMQYjBRWGEOtgmr1nCI+XSazFudzU3h037C9Efd/+A16GofSRaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Y//61vps; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Y//61vps"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3a5a3c8;
	Thu, 10 Sep 2026 12:54:07 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v3 0/3] nvmet: avoid recursive configfs open
Date: Thu, 10 Sep 2026 12:53:57 +0800
Message-Id: <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902103202.GB8095@lst.de>
References: <20260902103202.GB8095@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089aa7def03a1kunm413fe85d181356
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSR8YVhpITENOSkoeHh4YSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Y//61vpseLMPMbRKNQjZO4WUB/OhsVOs0OQydhXCQO+PqaKk+zwOx/yMJuTH9Dp51t5qd4MOKZJGtaPZ+CrIImIseiPwFZg+9PMwXUYmsqUNrxm3nvx70vZrRIs38zN3iFG+SvBo+vIHLcyGGQ/U+HETqnTP+KiYqF5gj05kDVM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=r4DZPSSWJirORZ4ABDo6ALp7Yp4ZhsDi/cAg9PK+Ixo=;
	h=date:mime-version:subject:message-id:from;

The nvmet configfs store callbacks hold the item's frag_sem while they
enable file-backed namespaces or passthru controllers.  Both paths open a
user-configured pathname.  If it resolves into configfs, the open path can
re-enter __configfs_open_file() and try to acquire the same frag_sem again.

Add a configfs helper for identifying resolved configfs paths, then use it
from both nvmet backend open paths.  The resolved path is opened directly
after the check so the backend does not perform a second pathname walk.

Changes since v2:
- Keep the filesystem type comparison in fs/configfs and export one helper.
- Use the helper from both nvmet callers.
- Use file_open_root() for already-resolved paths so standard open-time
  permission checks are preserved.
- Rebase the series on Linux 7.3-rc2.

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
