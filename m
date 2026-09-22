Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2413C342F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070200; cv=none; b=YYF/EN1iwPweBifjtAy01slGfs6ONq+6bAMgvxjvhsJs+kiunWvPsnWv666It/9EQcxy4J6T3AIJZSy/5S4brL9P+phfpOqLnjkVKCxVtFLAQnkq46De4B1MMhb+GE0zHQCDlIViwQk/GlCMs++6AaI11XYvDiQdkZ+uLMhkL2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070200; c=relaxed/simple;
	bh=Q9YfVsD3sYqyNp+XwEIeGl92jO5971DFWxOib/Cy+eI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XDMx3wTYBHl8TugLsFhR/S9ThFYzZx+IH0pEFnMh8t4pZ+ziUDj6VNHB2U26w1cm6Zz7kbT96L38fZJbcTkwQzAZf+BxWFwGL/0ADeu73dvrqSzkZURqBferqDfvqpGCAXx8i0N9NNMQdWfzKwEJtjFUnr+awGg5F7lzRQ9NljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScMfmGcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScMfmGcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1810E1F000FF;
	Tue, 22 Sep 2026 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070198;
	bh=6IT0/JTIVNPktOvltY3Pt6PW7EXd8ktvktUjGdrq9Ac=;
	h=Subject:To:Cc:From:Date;
	b=ScMfmGcTfROmidS3rNDcfhigK8yIoCzUk5UaS+xG+UKbivc+VbhhEId1a1gBnNiHR
	 iS5+flKIa5AbbOv1t8KfgJHHPQcFYksuVChEasH3n55/NpMqR95qcKcVjC6AM9o+zO
	 YWGZ5wSzPkFwBeq9p+XC06SnHj0po/wzhFohHfMY=
Subject: FAILED: patch "[PATCH] memstick: ms_block: destroy io_queue workqueue on removal" failed to apply to 5.10-stable tree
To: gyf161023@gmail.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:36:40 +0200
Message-ID: <2026092240-eel-composure-463d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 90af7fde083e1b22c349c3a8b1626728e44e474c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092240-eel-composure-463d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

