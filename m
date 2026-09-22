Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08624B1B5E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070196; cv=none; b=SiNCul19/NQd7G/BEzx+51XvmJQ4f8YY1sz5hiuYPTO9ptmQShy8oti1EET698M4JBfvzf3BCi4Mod1fxQoTbZJQHHj61+xqGVrJPrT/vJ7KSdFWSOSXhs8JkWqRnsB3PsehNF62R8YVC2pQ1xzJ0aCgAA93Af2dazf9iXFxrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070196; c=relaxed/simple;
	bh=HuaT9XCnKqbhvfM0KTO9xTFRh9oH7zObPKseNFkcEJc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I0Zl7Q7i9xodSxzT4O3/uz1ro/49YqBMGHnQJl2evKlr+bNb4uugL4mfzFBZEAXnwKA08wBx2PgBkwBixbtrjl/j2SBDrbb7Ieqgq/b2kgzwOWx/fjQYkS13c+bsgUNakfs0Jsb3zmf1pHKgaxx63RVfUwUKWQYXnGoOEFmB+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RgRlan9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RgRlan9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FFB1F00893;
	Tue, 22 Sep 2026 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070195;
	bh=XVoedeuOlAhy0RcVqM2hD5IyRma99g/hHZ07RJh1fkg=;
	h=Subject:To:Cc:From:Date;
	b=RgRlan9qbwZs6RneuVACYiTDTKJKmlXk1aPx1MW1hEcWGg0EWxQlLqkAnJlLCFdBd
	 ZtHmoYkXa3vFMBz1EAiXlrCwr53WMV1QSWS0mmMO9LoL6NW632bo91Y3g1X5NedQ+2
	 gPo658ry1wOMtQR48CWVDgNXa3FKpudbVlGvQ75s=
Subject: FAILED: patch "[PATCH] memstick: ms_block: destroy io_queue workqueue on removal" failed to apply to 5.15-stable tree
To: gyf161023@gmail.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:36:39 +0200
Message-ID: <2026092239-justify-dizzy-3fd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 90af7fde083e1b22c349c3a8b1626728e44e474c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092239-justify-dizzy-3fd4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90af7fde083e1b22c349c3a8b1626728e44e474c Mon Sep 17 00:00:00 2001
From: Yifei Gao <gyf161023@gmail.com>
Date: Tue, 4 Aug 2026 21:34:56 +0000
Subject: [PATCH] memstick: ms_block: destroy io_queue workqueue on removal

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

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index ce33907bfc24..65154e569a9e 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2204,6 +2204,8 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
+	destroy_workqueue(msb->io_queue);
+
 	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }

