Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F356C64D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095737; cv=none; b=OJC+vfaIJ4+C762+hYlfIj5Yh4Eit0GSwyGnLfPsZiidtOsgtVuLZ+htSzYwV4ScJZrudiNM2vNbIwA3nBG11EH7INc0Dh9mLegbna0ENXohlwbUkRszhNPlDofH0mAsTmlSq263xXS6vmfPE6V7JB4sc+nLD3Wu87Hftd3yM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095737; c=relaxed/simple;
	bh=KSJ93yiDpH5XJhhuldYygql4nz/wcL7PNjwvM6dTnDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgNdF4tVhdQbP2czB2ooTaQKsCUHewjlCnfcfnr+aSUzEjaRGcyWmoLPYTcnrN67nqGWHzScaBpSXwntLUQI5mYgNuVaLGDKiFWEbz/WsA8TH/5VbWFwEBzNVnpw/4Zvd7Rl12ht0EEbEzIH+hQfcNvrxXQ05ZV49E+N7n0dU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXZiiycg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXZiiycg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E71F0089B;
	Tue, 22 Sep 2026 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095732;
	bh=8tKvk5LV8Bd+uobnm4PlB0vbUX67IYBCAHrLvkIOG54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXZiiycgPe3uiVZTiRsq2yKM48wZiDT/q2Gn3kPBChMdOBf6APHn5xJn6V2nj5DPo
	 qv+AfJuN78hf7EsC+VNwmX5rbqh6vbzOoB590LgXGx5G5TR9/AdSFF+3RTPGo07dV5
	 tp5iqvgaIatPgQM2ajFinenxVEo5B+348Sce6X9Q81BDX/WzDfe+Zb5QYwvDo3oiqj
	 jb8aeghEIn4tJbc0LNI32Eg2ZsN4siS1dQJHBMiRVXnRivNjQE+D3Xt4cHN4fQs4OJ
	 ZbChk/e9zJ24wgXvRylIuRExj4iSSpUDx8WBY8DkTgIGu/oRX0PYwDAw7qm0N7fXn0
	 Sh7SWDar76cgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Gao <gyf161023@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] memstick: ms_block: destroy io_queue workqueue on removal
Date: Tue, 22 Sep 2026 12:48:48 -0400
Message-ID: <20260922164848.3125553-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164848.3125553-1-sashal@kernel.org>
References: <2026092239-justify-dizzy-3fd4@gregkh>
 <20260922164848.3125553-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/core/ms_block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 0486bbb10e44d..8f0e993403951 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2208,6 +2208,8 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
+	destroy_workqueue(msb->io_queue);
+
 	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
-- 
2.53.0

