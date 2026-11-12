Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475619;
	b=Quez2ACqx9sySZdkpkYpxYMS/EZ/lBE3wCZQHI6TibEr66qim0yhoj9btvJ566wscWtt
	 7/fiYJVkU7pfrUQRUhDry0MY1ylyW6z4cXOd0VxczBR1a70P1btF1Wnzd43AbG1kaiN8U
	 Pjhb31WEPwuXgJS89SI6BF3LfNvGBTEl0iwnSSt5FhhDO298xTsClCoOY9TEvTx+sxJz6
	 l0shhuGrZ+RB4WZzWRdJtFkeBeJN3o+pcNVK6lBn979e3yXXsZwm9rSA2Fgugw6dJ//dt
	 llW9iIbKPV6/r4zMPpHUP3xE/KTjlmjXl1mJ6a9wdwvYSIl5fu3l+jC132fWVV+DCWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475619;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=zocNRhiyz5vscgwAFQBGldAPsbQFoA9H+SMXbX6J+CI=;
	b=UXy+EXyzji4TBgi11FA7CvZdLV1ZH2t21EdZ8NolBiZUPeRyomWThD307V8FovUT9xcv
	 DMMiewo+ovg0HBuhdSQhvN0Lpsa8vXq5a4K9LVUVDAW6IjfKYa45c3amqQE2fVt36LIAO
	 J3hYwRzCYZG0QiwYPw+jtGHjjGzT40fG9IAWDbe+vCca3xCQhz8f3Mneo2SbDnM7jjGUx
	 weNkCME/E0F5spTQKy1zOp3QNzbscH12U0rsEegbDrZGq4XKfXll+qHUnV0T5hESGumzR
	 WKvOQhjS1zMQF9jnHryBdhbAu72rEkX4YalBxITU/RfsRWr1D5BaPtndMxD/ro5HJGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KaomOVKw;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B5606A886;
	Thu, 12 Nov 2026 09:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D6B5606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KaomOVKw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=zo
	cNRhiyz5vscgwAFQBGldAPsbQFoA9H+SMXbX6J+CI=; b=KaomOVKwI9rMBz9nfW
	h0VJf6AtbH223/TiJwtXQ8La/v4lr8OpC+WBAxaFMYahn8XngevJE/mKxTN8Grpk
	frbiMf3tSwGp9laWt4lLRzylziklNbnCUFclS5TdPp/RdwSUFSlgmAxuZAiTVYgv
	UoxiN5EtRSg0fkSEoh9gdblZQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3vxNLhvVqk7smHA--.49066S2;
	Thu, 12 Nov 2026 17:26:35 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] md: fix stop_sync_thread() hang on new sync in idle path
Date: Thu, 12 Nov 2026 17:26:34 +0800
Message-Id: <20261112092634.1700963-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3vxNLhvVqk7smHA--.49066S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr47Xw1kKFykuF47Jr1fJFb_yoW8Ar13pF
	WIyF98WrWrXrWxZ34jgaykJFyrAw1jqFWDJrZrC3s5Jas5ta13AF15K3WUuayDGa4Syw42
	van0gFsxu3W29aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY-eOUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3gvLemr1hktX2gAA37

From: Li Youhong <liyouhong@kylinos.cn>

stop_sync_thread() waits for either MD_RECOVERY_RUNNING to be cleared,
or (when MD_RECOVERY_FROZEN is clear) for mddev->sync_seq to change.
The sync_seq counter is only incremented when a sync thread is reaped
in md_reap_sync_thread(), not on the md_start_sync() not_running path.

If the previous sync attempt took the not_running path, sync_seq does
not advance. If mddev->thread then queues and runs a new sync in the
window between flush_work() and wait_event(), that new sync may start
a real sync thread, leaving MD_RECOVERY_RUNNING set while sync_seq is
still unchanged. md_idle_sync_thread() then waits until that new sync
thread is reaped and sync_seq finally changes, even though it only
needs to wait for the current sync attempt to finish.

Fix this by incrementing sync_seq on the not_running path as well, so
that the wait condition correctly observes the current sync attempt has
completed.

Fixes: a17d1bca5aba ("md: fix stopping sync thread")
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/md/md.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 68a72513e884..1970c945e597 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -10352,6 +10352,7 @@ static void md_start_sync(struct work_struct *ws)
 	clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 	clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
+	atomic_inc(&mddev->sync_seq);
 	mddev_unlock(mddev);
 	/*
 	 * md_start_sync was triggered by MD_RECOVERY_NEEDED, so we should

