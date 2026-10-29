Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793235086;
	b=Pzxm0mwi8F3QVZ8SI82LNAGrBeWJhizKNOJo6uCrVEDnQrUptx5NZlFU519lwhJPN7CX
	 duc7k80nOuP5crXUyA8qCPFtWokfOLybpwB/zYxPswdtN1o/0P6uGvZpaT2w/Tn5QhRmC
	 0RfxY+4aBKyWWSZcfJnaKtcAIv1jlgughbTRd2yxcK0WzJnZGwYOnmoaMbRG5+ackSeE5
	 +nLsjCkeFklFwzu8LYqPqfy0fQhHTFvXYcBIO1jQYhdRz1cZAlTwaids5y5OXJKSayaLD
	 Xo41urGP7XIam0FCCVo0Wv/2fBKA/4iF6YMNINHO7ZMYT9Dh9lvCVE2NtAcqhLB9U9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235086;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OQxAwIFM4Dy+JaXQReRXxUOmCNsUI1oyyY7VMdV3wqE=;
	b=NNzFY/Emz9dn/duNTgjpSW9tl5ZcZewigTYkhs3doKHUVSERIzldRAjEw5r4abvFD7zi
	 IZOF4OHic6YTias6GxCO7m27k6MEXzAYOriu/bd57k3JStNSFT/8vys7Zmop5qM56sPq4
	 Yw0nMME2B3ai+4F7xcJZiGwIXGtsYUr70tWeIM6l9Eqt4Z5CF5ydh1RCToO2i/vkYZl/G
	 VIHOE/culq+Ci+HAyaDzJ/3q5WVM96mi1gOfNriMt49GXcv5D6BIo6UhxzQBC4G+G8wkG
	 2GMQPJFToDUfku+AoajIr6ggh3VCDJRavgVmiC59lwY8JohQrAR/2QYBNeBmkqiOcAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehAA92vF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA3F606A31A;
	Thu, 29 Oct 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehAA92vF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793235085;
	b=SD+DQfKq7ALdlYwqFyRnn057+CYW7hTxO6psAajBz+Eju2WPVu6C7MbELcdlB/6B8/ig
	 mpyH0Rf33cRwcyRpuVFn/fPwcIS+bdAmgWIKkoepgdcWe9/fFdhatvmcTaf6KFldLNOHh
	 Wew9qQKoFp0C4k+wi+QsdFewutF3l9F58xMV3bQqMSVZHGe2lMv1ACDahRDXgf+RIL20W
	 UtkBY5IOM4HeUTrU7KMfI26AXaUhVi2Xf52WP3/PxIQsU27QnxM7xNTw3Z1T23luPe1pI
	 4T5QBqLNdwmA2s2x9Uzsvx6nE4h4ifd/DIf0srdY/mINyyR8eb7q3QbeTp+GT1HDU0w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793235085;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=OQxAwIFM4Dy+JaXQReRXxUOmCNsUI1oyyY7VMdV3wqE=;
	b=H4e8dVczWMD12G9Q+4Gcy0loLSytfnctwKtgb8faycrQx2GMZqB9AXXJT3jSNw+0efkX
	 TgQsuLx+Vl1CKRXAl/rhs76DPzOJDCvv5stcExVjiCRqZF8cCglGRlUQQ4SfFpLIfbJcu
	 66kkwCgyyJ7Bk7irZdiH+IX8L531jmRzT9Y6VO/FQG3l9m4qVswxCjM2fIyBDxoEbUHqm
	 x9Cj2MPuTkcsBsiB40xkZTBVxn4COHWvYk55DuO1g+OM51NmOg1v7r29grJH2F0hzB1l4
	 OMPR+XxXUZbJ2qj2yvE6FSnmXTi2dA7Rv3xJIxioHUVSXZ0ABYZ8KRMqze6y+aZySpg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 61A701F01825;
	Thu, 29 Oct 2026 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235085;
	bh=OQxAwIFM4Dy+JaXQReRXxUOmCNsUI1oyyY7VMdV3wqE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ehAA92vFic4byXSAkIPVnwwQYthQyBg9jUpQuOVp86pu3KZP55+xTc/9+JQFKdhoM
	 Eq8pfnLrmt3oUb0ot+OM2JSYoTPgZ69dBvrHYNCvRvN7V+DQbqi7xvCTovrNU/nUEk
	 lvfKNt+xWneyh+xvEkG05VcB/TJBqGuJSxAW0cy0h3302Y/xHlfk51fvfeTa+JzBLi
	 8ZcvKa0qRQteSHa+KGVQPkVZfvN85xAVTZeB7Oww83g9tdv6l7aykp7MkM9SjDcUNr
	 19CVdeskgEMQtWlHJMuK8sjOgwhgsVxHSLHRwNLuvnprgaUku0uXyydO4rEDXidQG9
	 mY4EBEa77cjIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5F6C45646;
	Thu, 29 Oct 2026 00:51:23 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Thu, 29 Oct 2026 09:51:24 +0900
Subject: [PATCH] nvme: unregister when pr_register() is given a zero new
 key
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-nvme-pr-unreg-v1-1-b4657ad4e98e@samsung.com>
X-B4-Tracking: v=1; b=H4sIAIuY4moC/x3MQQqAIBBA0avErBtQC4muEi3ExppFJiNJEN49a
 fkW/7+QSZgyzN0LQoUzX7FB9x34w8WdkLdmMMpYrcyEsZyESfCOQjuaMTirQqDBD9CaJBT4+X/
 LWusH5YuPwl8AAAA=
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, 
 Mike Christie <michael.christie@oracle.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793235083; l=1781;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=mAU8OTdvinewhOZxDTmeXGacEZAsamAJlbTQrV18Lu8=;
 b=c5q4qcV2O2rZi5rHmmEktc3SJVT8gpMB9op5eXzH9YJ52W2Cn/7S9he5kMvOjX8OuAtFmyTey
 Qn9UwWPeegeBs9CcwDecacqBZ51x/r2eHAnpLrCK7rJ69hmU4Jj9jw9
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Reply-To: daejun7.park@samsung.com
Content-Transfer-Encoding: 7bit

From: Daejun Park <daejun7.park@samsung.com>

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
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
Tested with IOC_PR_REGISTER on an nvmet nvme-loop namespace and on
dm-linear over it. Registering a new key after unregister now works.
A wrong old_key still gets Reservation Conflict.
---
 drivers/nvme/host/pr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe2648..d8b6ac4d83 100644
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
 

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261028-nvme-pr-unreg-24fa60ffe3c3

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>


