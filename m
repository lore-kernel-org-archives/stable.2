Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FF3890E8;
	Thu, 27 Aug 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850385; cv=none; b=jqWw6xuxKzb/eDjK2ImbTMqES5WcYn7BnOkbIJevfNsft2s+UbCi3s/1EcFG2gCxHONckj4yv3OMqh50K3Kz/mGAdND5sf5O6fD12GhxibIOUdI2ZwPD1h44jOsycBAe8OvJwGHtC3XolhSVrxqf3BoNy9RFXQErKoK7g4Cr/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850385; c=relaxed/simple;
	bh=rO357+BlsTE+Uzlr2tqR7NjDKfJCja7sX4WZVb6GeVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWVxO8cya0UBkiLecUUE7tC84VKXkP6DRjtn73ZZPVZIHjUesxf6cWZ1pESwm/g07v3wbR5+o8PPqggpwCdEBEEQNpwTn8cB1IfS2AM5nBhqmOeahD573zLvvWVsi/OPoUZBFoBmSbHLLWOWcg/FCx4ucHYpCfow+cMnew+sJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4b9692dce;
	Fri, 28 Aug 2026 01:06:16 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/3] accel/rocket: Fix job submit error handling
Date: Fri, 28 Aug 2026 01:06:05 +0800
Message-ID: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0442fc4a603a1kunmddadd30e6f5a4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGhhDVkwdGUIdT0MaSk0aS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

Several independent error paths in the Rocket job submission ioctl can be
triggered by unprivileged userspace. This series validates userspace BO
counts before passing them to helpers with signed count parameters, collects
implicit dependencies before the scheduler job is armed, and propagates the
first per-job submission error to userspace.

The series was tested on RK3588 with zero task counts, invalid task pointers,
invalid BO handles, and oversized BO counts. The requests returned the
expected error codes without warnings or errors in the kernel log.

Changes in v2:
- Split the three independent fixes into separate patches as suggested by
  Sidong Yang.
- Rebased onto the current drm-misc-next branch.
- Dropped incidental blank-line-only changes from the original patch.
- Added Sidong Yang's Tested-by tag.

v1: https://lore.kernel.org/r/20260813142059.151644-1-Naixumogu@whut.edu.cn

MoGGuU (3):
  accel/rocket: Validate BO handle counts on job submission
  accel/rocket: Collect job dependencies before arming
  accel/rocket: Propagate job submission errors

 drivers/accel/rocket/rocket_job.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)


base-commit: 20331505df9c7d8b29f2f9309231607a41a74120
-- 
2.43.0
