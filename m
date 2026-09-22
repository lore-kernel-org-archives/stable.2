Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1D46D571
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099483; cv=none; b=P/pg/ez/QbiXKybLi9/j/+LAqNryjZZ1f019L/lpr1dvB+rEwVsMXzj329alibgWhtyKJJtmUgQAST0uWWbN/mBg95x0RPcfIaJoexPm8GKdE9zplkniGUhpz8yX9qhbXtln/Xawibqs/3bpxTRliyjO17Zl2uKqg6Hscw1Qac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099483; c=relaxed/simple;
	bh=fVolzbCZG8gOVYmhPIFnew56YI4yN2ZD1uBhyxFN9ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhIz8xDrjtOqxcXJXs6iuC/x0/zOFOFH2XAmp3Zg1qlQepQ8xV7W3+9djZyG3cSEYVLN6if2lK98ZHaqfhAGFb+Fz1ZTp50fSXOvGrEzm+x7shjBiPBZ64fdKeRAHgdCMH0EFET7tv84QBlUfgHHCxASJ1rrievrRzDvtgaqXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2T3Zfgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2T3Zfgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B206C1F000FF;
	Tue, 22 Sep 2026 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099481;
	bh=eBhpQcvgZ9Hr1gCQ14I7SyOX9nidLJFwnptwNuJndyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R2T3ZfgpC9hwW5BLGHmqQsNRQfD5nzyRAmx3bq8HgLvqGPPsJZ5ZkqHdHKka3o+Pg
	 rDCQvBcgih+rHYwhrPP9vXhe9zjXx74Zl8+PHppDQ/ZZbDZ3rw+1eqIqoyyMPWS98L
	 8AUmbp4pd9OvtM2jxS8cPl51MhQdtItkGSQ1lD3XOX6VdqM7Otd0i3GXJ/zJkaf5Pf
	 o9vP+oJhOv324pGhQKxmAffUjBaErbaSpEwmsXLT7GHYUROhX3SzGb4Mo2amVoQMZl
	 Gybj4P3XmZ5Hi2SXQRfM/bY2b2exFune3MJGY+uN1H9jac6eouzKV8v7HW590Uj5sj
	 W79nf5jP6olJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Gao <gyf161023@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] memstick: ms_block: destroy io_queue workqueue on removal
Date: Tue, 22 Sep 2026 13:51:19 -0400
Message-ID: <20260922175119.3309427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092240-eel-composure-463d@gregkh>
References: <2026092240-eel-composure-463d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yifei Gao <gyf161023@gmail.com>

[ Upstream commit 90af7fde083e1b22c349c3a8b1626728e44e474c ]

msb_init_disk() creates the per-card ordered workqueue msb->io_queue with
alloc_ordered_workqueue(). It is torn down with destroy_workqueue() only
on the init error path; msb_remove() never destroys it. msb_stop() merely
flushes the queue, and neither msb_data_clear() nor put_disk() free it. As
a result every card insert/remove cycle leaks the workqueue and its
kworker, exhausting kernel memory over repeated cycles.

Destroy the workqueue in msb_remove() after the disk has been removed and
the queue drained.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
[ adjusted context to retain msb_disk_release() instead of upstream put_disk(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/core/ms_block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 1d9e83baf6414..f4c0177460b02 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2226,6 +2226,8 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
+	destroy_workqueue(msb->io_queue);
+
 	msb_disk_release(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
-- 
2.53.0

