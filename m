Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAA348898;
	Fri, 28 Aug 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893709; cv=none; b=i2kcYvSbKmYnNry6pJxVZlHav94plIxWCjmjrhSuuRVByQt0PCFBHWgY7X8QgIwWf/zxvLFQU9wMuJmVCqGgak2kQ1HVr16mMDXQwMUxK80hXOr9fQDfuTftFgiSs8/OFE624b0aLMp6XnbtShZrIJw2WcKovf1sozeHj+zGgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893709; c=relaxed/simple;
	bh=lBkauQfi0izAxkf+mvyvLYvHkt8AIQa8GtsGZulGRjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boHudUTUIp4TvIh0KwJXQH4EX4ltz/oSf7a7lFv5jUrqBYovnTNI1NsPVk5ia3FrS/YDN3S4flr5u8d1KftO1D8xQFFJrfvOwqjSXADt4ZQ2zVUEFbBJfE3SmVE27vK1ROpucOEhi7Py0zCQJwqpTENI18nPg6DKsyILpAR4VQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn; spf=pass smtp.mailfrom=whut.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=whut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whut.edu.cn
Received: from Mogu.localdomain (unknown [223.73.65.69])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ba72fe20;
	Fri, 28 Aug 2026 13:08:20 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/3] accel/rocket: Fix job submit error handling
Date: Fri, 28 Aug 2026 13:08:02 +0800
Message-ID: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa046c4d93903a1kunma5b4953488364
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSBoYVkhDH04aH05LGE0fS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

Several independent error paths in the Rocket job submission ioctl can be
triggered by unprivileged userspace. This series validates userspace BO
counts before passing them to helpers with signed count parameters, collects
implicit dependencies before the scheduler job is armed, and propagates the
first per-job submission error to userspace.

The series was tested on RK3588 with zero task counts, invalid task pointers,
invalid BO handles, and oversized BO counts. The requests returned the
expected error codes without warnings or errors in the kernel log.

Changes in v3:
- Keep the individual count checks before GEM lookup, but change bo_count to
  int so check_add_overflow() rejects combined counts above INT_MAX, as
  suggested by Sidong Yang.

Changes in v2:
- Split the three independent fixes into separate patches as suggested by
  Sidong Yang.
- Rebased onto the current drm-misc-next branch.
- Dropped incidental blank-line-only changes from the original patch.
- Added Sidong Yang's Tested-by tag.

v2: https://lore.kernel.org/r/20260827170608.39511-1-Naixumogu@whut.edu.cn
v1: https://lore.kernel.org/r/20260813142059.151644-1-Naixumogu@whut.edu.cn

MoGGuU (3):
  accel/rocket: Validate BO handle counts on job submission
  accel/rocket: Collect job dependencies before arming
  accel/rocket: Propagate job submission errors

 drivers/accel/rocket/rocket_job.c | 32 ++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)


base-commit: 20331505df9c7d8b29f2f9309231607a41a74120
-- 
2.43.0
