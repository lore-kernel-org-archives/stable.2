Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD72E1746;
	Sun,  9 Aug 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786262641; cv=none; b=Uy6JZcX5JAb3/UkeK+h/bt/4TMRY4ZyXknyFnLGl12ulR2fDpecixKJ8LcmiDvZIFBki5JupY8oZRd7lLSDsWendawL4RnjYY2kUpUJ2eWsIPP0HYunfQAZfvqf1lYWuNz7NMb4MNwFxnd03xWDwFP/L8A0Auz7U0k11JIKtiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786262641; c=relaxed/simple;
	bh=t3/gO21KzVgRcksZkKNXbGp8xOp8Bfe9fDFt7C5Bqu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N7bN9EB2PjVr7q60+kwvI27UnBffdMpKvEHolV8Nkm1lxQwrfjuLfDbfzEssV1gtmck1uMnr0BswbC1RxZCpsyuS/y/tmcDeyA9dK/R5dvgXUnMQAbWlY8gZjYR37qDfwYVrrOcMIOzZgr8BdkHH4xyswuY7Uwrr40Y6lBRq3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=UP2EJ9vQ; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="UP2EJ9vQ"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 494b8fd73;
	Sun, 9 Aug 2026 16:03:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH] gpib: agilent_82357a: unlock allocation mutexes before free
Date: Sun,  9 Aug 2026 16:03:23 +0800
Message-Id: <20260809080323.3576223-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fe58c99cc03a1kunma4bd7ff479be2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHU0ZVh9LGktCShoYSR4dTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UP2EJ9vQ1gxM645ARwolTuK52F42XtHIvawK/13cci350DGeq1GE8NgQnRYet+e+Eodp95NaO5Y7CjM1hq7FNi7/p6+e4QXh2TUQc/sJXa1fk6rgLyi140VE1AM4jGGzMMG97LMoFPRf57nEU6Ac4d+E3BnosDA0crAMhkMibDE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=dpqqTbiGbkbkZ2mFq3GpxZnYgB9Fs15wS8KdDoCZnKg=;
	h=date:mime-version:subject:message-id:from;

agilent_82357a_detach() takes the control, bulk, and interrupt allocation
mutexes before cleaning up the URBs. It then frees a_priv without releasing
them. Since the mutexes are embedded in a_priv, freeing the object while
they are held triggers lockdep's "held lock freed!" warning and leaves
lockdep's held-lock state referencing freed memory.

Release the mutexes in reverse acquisition order before freeing a_priv.
Keep the existing acquisition order so the detach synchronization with
concurrent USB operations is unchanged.

This issue was identified by static analysis and manually confirmed by
tracing the detach path in v7.1.5 and current mainline. A source-level
lifetime check verified that all three allocation mutexes are released
before the private object is freed after this change.

Fixes: 4c41fe886a56 ("staging: gpib: Add Agilent/Keysight 82357x USB GPIB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpib/agilent_82357a/agilent_82357a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpib/agilent_82357a/agilent_82357a.c b/drivers/gpib/agilent_82357a/agilent_82357a.c
index 2468a471d175..25093bfe6638 100644
--- a/drivers/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/gpib/agilent_82357a/agilent_82357a.c
@@ -1426,6 +1426,9 @@ static void agilent_82357a_detach(struct gpib_board *board)
 		mutex_lock(&a_priv->interrupt_alloc_lock);
 		agilent_82357a_cleanup_urbs(a_priv);
 		agilent_82357a_release_urbs(a_priv);
+		mutex_unlock(&a_priv->interrupt_alloc_lock);
+		mutex_unlock(&a_priv->bulk_alloc_lock);
+		mutex_unlock(&a_priv->control_alloc_lock);
 		agilent_82357a_free_private(board);
 	}
 	mutex_unlock(&agilent_82357a_hotplug_lock);
-- 
2.34.1
