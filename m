Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273116;
	b=UpXW7Rpj1GCJGYdNW7lOoOdMhDIrf+deHJAnqhIFhgF1hClZlDNLN8Mh0qa98/qNEdY2
	 N5ysKM9U0tnj3k/s41k39hdbe86wyDVH6KGA7uUkVZEacbOg7O5DzbANbBFV0nZvqOCeQ
	 ZWxrL82Hj4GgqG90JoFO2Udmaix+iGTGKxXqzIXITv0XHtj09AT2ndq8T6y60V+1xxW2l
	 4Eg5kQzuYjsFobwZADCgyjpxgRP9DkYlAXsxjhiUjZ5w3nXhN9W8hTRvk/8lKBxdmKDjZ
	 ol1gWbnn19ahL+LpEDYiG46txP+bYL2vUqTQ12FhRHESAmGygsZ/wOfKVIc/GjodCHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M+ruW4CLEQLPACVT5F79jdMiC4Q32HBkpkhmYgWgrUU=;
	b=aSPxq/ASLZenbIq4Yqhk7++Kmb9R9DECzHeoPEt+BX2iKOe4diYbQ3I/CxFRbHb4Y4mx
	 mxRYfhNbDaJHplC5SVOzv3EBBQxzuib1Ce5CwcbeJTcsp6+/6dp6MTleNfiyZaL6CuSl2
	 0sdDxkwNjHDMyaLPsl6oXIErvTwv5NAeMPSqxMtDcMmtZTnkPa4JBKa/YMiBc0m/IhZ73
	 bz4Tl9aYOpiVke/3ghEGwFsAUi6DKZInkpvhLi1Nq11EQZw+YeGmwQPU/d+B34lDK4sr2
	 QndJ7JENmUVnp60BA9+POeXOFi4ISQ66lf7LG4ogGw6SivxniMzTNEFpbJcFVm1G0Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMWltEhT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMWltEhT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEA01F0089F;
	Tue, 10 Nov 2026 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273116;
	bh=M+ruW4CLEQLPACVT5F79jdMiC4Q32HBkpkhmYgWgrUU=;
	h=From:To:Cc:Subject:Date;
	b=dMWltEhTBtA4jDlTtXRvEc2T8g8q+9lWbyDwVO3r4z0hYTjzkllgJFqKNfvX8F4zD
	 VZB423ovFzbYObXodUhISyNckOpCWyYH2fqjJCvlbCBiF2DYHN544D1IvvID+19OXY
	 bq/6VS1WnTJScwoJeoJAB8G41Yr9xC9mqy9GK5xBylkHdFsrn9f5UfjJbwmw3NMsxa
	 RU9mitOzbGDDK6zut3TX9NbWzh5faUjeEDViXWR/Ffatj0Getv6YJtHhzaiItXiXfa
	 rxTeozDJ3b+GGEWV3XVj/6fysObr4D4WTewEI7a/GoDiVDZvxvRTkPWqxaOoQklEid
	 817aj2bpKFKjw==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme: unregister when pr_register() is given a zero new key" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:54 -0500
Message-ID: <20261109201154-failed-6.6-a9d431124fb2@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a9d431124fb2e58215daf0299d6fcf47bbc2d6b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201154-failed-6.6-a9d431124fb2@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a9d431124fb2e58215daf0299d6fcf47bbc2d6b1 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 29 Oct 2026 09:51:24 +0900
Subject: [PATCH] nvme: unregister when pr_register() is given a zero new key

The block layer PR API defines a zero new_key in pr_register() as
unregistering old_key. nvme_pr_register() sends Replace Reservation
Key with a zero NRKEY instead. The host stays registered with key 0,
and its next registration with another key fails with Reservation
Conflict.

The pNFS SCSI layout client unregisters this way at umount. A later
mount cannot register and sends all I/O through the metadata server.

Send Unregister Reservation Key when new_key is zero.

Fixes: 1d277a637a71 ("NVMe: Add persistent reservation ops")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe2648158..d8b6ac4d83bb9 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -128,8 +128,12 @@ static int nvme_pr_register(struct block_device *bdev, u64 old_key, u64 new_key,
 	data.crkey = cpu_to_le64(old_key);
 	data.nrkey = cpu_to_le64(new_key);
 
-	cdw10 = old_key ? NVME_PR_REGISTER_ACT_REPLACE :
-		NVME_PR_REGISTER_ACT_REG;
+	if (!new_key)
+		cdw10 = NVME_PR_REGISTER_ACT_UNREG;
+	else if (old_key)
+		cdw10 = NVME_PR_REGISTER_ACT_REPLACE;
+	else
+		cdw10 = NVME_PR_REGISTER_ACT_REG;
 	cdw10 |= (flags & PR_FL_IGNORE_KEY) ? NVME_PR_IGNORE_KEY : 0;
 	cdw10 |= NVME_PR_CPTPL_PERSIST;
 
-- 
2.53.0




