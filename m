Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050431;
	b=CjS13IfnY23T60S6CS2AKuw8KHKWvMTgXxr787I3OELboGpHCz1D01UwnKshuikyouRC
	 TfTPrPVjv7rz+9yUcmZqXaBPOGFyiXr221iYVVf3mIHDLfqXsU/Goe7oXre+3ECblWFfj
	 xRtdWd7TXJOcwL396Xxq9em0+iZZZZTvlJ3lsUMHe5aJdNkU/qUCCBMIky39r3iqzFpv3
	 wxZgW0/LqkIN1bNP1LVPFpu760kqnmyVrc9FcC0qMLScpYemi8B20zda25/xxzc3IAQnC
	 JeAYWX9nLroTSnq01mXJeBjVwL5i7zW0psvYPnpXIv9ZchAQJrNX8TOjED9RYMhA7pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PN6Zicr88RwrYjGnBEVFOx893rB3A3nqUxkvWZ+yEf4=;
	b=Yby2YeY6TkZ9yxI13MGXyTwaLAWj/DFqslBdax95ijpTRBj21vk5tNX1pB4bjJuOHfap
	 nmKRCupvtD/TWCvKRNDeHb3m4QlVRTkXxk2AcMDVzct/AOTPVkqxzWoWfkzNwPUtQovwn
	 N8Fxdfiz8Yt7YwuQpB65cI0PiOkrlgZlj8llHLikfDVXRM5fk4NTPf5GaM3QMUynKu7BF
	 RpjNpjbDJpSuWCHOon+XvP2FBQlOqUwnsdrKBlrBQo4KIma1tkD4r/mZMAQForMdEVtsY
	 Ch68QNQPD5+W4rdEzqHOqrI9LrZHXd+bWZsATtwORtBcqn729UCzyWwj6UuD2J9eBPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+0jvT9f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06966606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+0jvT9f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674051F0089F;
	Sat,  7 Nov 2026 11:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050430;
	bh=PN6Zicr88RwrYjGnBEVFOx893rB3A3nqUxkvWZ+yEf4=;
	h=From:To:Cc:Subject:Date;
	b=R+0jvT9f9pl/xa5TexpL1HZ5ojrIvS3qliM15+Ig4z+hYYRft2KbHcvjr6Lg13uMy
	 gJqPmCMNSRByW/QuGvEKje4uMMJMcoJbrqcPgjWZmjmSmr5gTc2mqi1mhQPJzpMVLj
	 KQz2zZA+IvEtHRn4SeVPPAxXaEbrkQPpWmqR+PtRyMM/muOvp2cXf9Y/kyQtWooBmT
	 Tfc+bp49gGYU3V8GjZe1UDKd1c/ul6hBYu0atxptn3KQo5ij5FPC+8B5q49sIWVVE4
	 dj/RkyA2GUNTI0phbfhItHf7iVdyFOEDqacCvnSXDGLCMUmMyG2S35Oj4fukJddp5X
	 Wkf8errDBhg/g==
From: Sasha Levin <sashal@kernel.org>
To: ross.lagerwall@citrix.com,
	roger@xenproject.org,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen-blkfront: Fix IO race during unplug" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:29 -0500
Message-ID: <20261107062028-failed-5.10-61b6d1df1d62@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062028-failed-5.10-61b6d1df1d62@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4 Mon Sep 17 00:00:00 2001
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Tue, 6 Oct 2026 17:34:07 +0100
Subject: [PATCH] xen-blkfront: Fix IO race during unplug
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During unplug, blkfront stops the hw queues and marks the disk as dead,
then later during removal calls del_gendisk(). However, IO issued after
the hw queues are stopped but before the call to del_gendisk() will be
queued but never handled. This causes del_gendisk() to hang forever
waiting for the queue refcount to drop to zero.

This can be reproduced by issuing IO during an artificial delay after
stopping the hw queues.

Fix this by simply not stopping the hw queues directly. Marking the disk
as dead already freezes the queue which prevents new requests being
added and it synchronously runs the hw queues to clear anything pending.
If the hw queues are stopped when calling blk_mark_disk_dead(), running
the hw queues is a no-op and can leave queued requests unprocessed.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Roger Pau Monné <roger@xenproject.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20261006163411.2583538-1-ross.lagerwall@citrix.com>
---
 drivers/block/xen-blkfront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 86f5dd3aced13..ad0cb42c10197 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2142,10 +2142,8 @@ static void blkfront_closing(struct blkfront_info *info)
 		return;
 
 	/* No more blkif_request(). */
-	if (info->rq && info->gd) {
-		blk_mq_stop_hw_queues(info->rq);
+	if (info->gd)
 		blk_mark_disk_dead(info->gd);
-	}
 
 	for_each_rinfo(info, rinfo, i) {
 		/* No more gnttab callback work. */
-- 
2.53.0




