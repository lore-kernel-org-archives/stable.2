Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052EA360ED6;
	Mon, 21 Sep 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981582; cv=none; b=oOqO8eNotZeXTSvjdLbJY141CCVg/eoDWN4xEpgbB7BvDX7HP/4frkRTEfYwMDgu8yK3teZhEjLscJTos/6VxuAJnA9Z8yVEV6fQVMKR2/a2aE1EHpQm30yJptDvOwnKCtu0g2kwt0nu5LqN/om4VABU6Ot2z1BczSlVz5FkN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981582; c=relaxed/simple;
	bh=KPswjOlyUajSi5TR+3IDNokyrIM8kAsXLW3KmiRmo7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eAZNQEsZhq8HDwSuQD5W5xrdBVhZBMY52zxzXX6DxT/2DtCbxsNfrJ15SvDRhPvnSp0hTXShvSnfr+4om/tvRKGu0DUFr1z7uXMyLE14aPC5L4b8COu8r8NrotHH1tgWCPcVBK4ez2bl0RNZ5teW71LdHSutivr0PnREnM53Y/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=RcdTP9OZ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="RcdTP9OZ"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8e74635;
	Mon, 21 Sep 2026 17:06:05 +0800 (GMT+08:00)
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
Subject: [PATCH v4 0/3] nvmet: avoid recursive configfs open
Date: Mon, 21 Sep 2026 17:05:56 +0800
Message-Id: <20260921090559.41364-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c337224a03a1kunm2bb71b5a410b3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0MYVk4eT0lKTR4fT0xOHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RcdTP9OZ0foDlQkFFLiAw5HmNI1pPBHEBj7kQP8EqqEfYCuAex/7KhwifrvGvpcWwcE9/Z3y8N7UdZ22YED07Ds6xwkkvVDID/R8QgVt4/AWV5XAGBkT3Y1D3W55u0WvmmwCAKA2LtWqjyJ4UL5cbTOgCKaWC8sj4hjuLVQQNWU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=o7gILgiw1b8ufS9MixkHgWd/h6EpwrenjKOgQIs4Prs=;
	h=date:mime-version:subject:message-id:from;

The nvmet configfs store callbacks hold the item's frag_sem while they
enable file-backed namespaces or passthru controllers. Both paths open a
user-configured pathname. If it resolves into configfs, the open path can
re-enter __configfs_open_file() and try to acquire the same frag_sem again.

Add configfs helpers that resolve configured paths, reject configfs-backed
paths, and open the resolved path with file_open_root(). This keeps the
normal open-time permission and security checks while preventing the
recursive configfs open.

Changes since v3:
- Move path lookup, configfs rejection, and file_open_root() into the
  configfs helper, as requested by Christoph Hellwig.
- Use the helper from both nvmet backend open paths.
- Provide a root-relative helper for callers that retain a resolved root,
  including callers that create files below a pinned root.
- Drop the previous Reviewed-by tags because the helper interface changed.

Runyu Xiao (3):
  fs: configfs: add helpers for opening non-configfs paths
  nvmet: avoid recursive configfs open for file-backed namespaces
  nvmet: avoid recursive configfs open for passthru

 drivers/nvme/target/io-cmd-file.c |  3 ++-
 drivers/nvme/target/passthru.c    |  3 ++-
 fs/configfs/mount.c               | 33 +++++++++++++++++++++++++++++++
 include/linux/configfs.h          |  6 ++++++
 4 files changed, 43 insertions(+), 2 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.34.1
