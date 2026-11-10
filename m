Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274003;
	b=dRz5SLPPx8Z/8463KmLN1sKD6tydnBkscqvR4NiXwgrKLgYe5uJPO0QQ0lnQg+eQXEM0
	 MJ4Tt1Qih9wCg0W4YYKCfMgddaq+mdtx0mJQ3u2U4BjzzrYZQDj5BmpbLnlhzt8taiBqd
	 n+nMVrdoUd6cFRc2JQlHQT338wZeB+VLy7FWx9biCTeXTHpQveaX5/SOPOGDaTcYQkR+5
	 yemU3L0PUTKR3AUTetrhaSbjbTcq4a9ETyfELrK0Y/vCLRuvASakr1wvr7/ydfXtwQlER
	 dUuzEXlVWynsMGJITNk+S3wBfUs9isrbjYSn0AZY/Qk414HYvobZxEyghZBjQ3oM4ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274003;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ulDGRdlEhRhdVf5P9BUE+whNbCjWFMzoanwf9zNWFqg=;
	b=LY0i20Q0/eHIiDbuJzyGVVPAyMaKlYf7HyvrWV43IEkFLBtMosoZ4R5wD54301SHMlFw
	 hnfFEq0FaOuC1Zs/6vdMMzasVArpTrCyNZZyjaH9Xu6027J0NGgWF8A0716UxDmQT99En
	 PqegOah0xh1Ny5JJXQ5r6vR5W5iHlNVs9sKQTmnl/xEaT6EKeTciLQTI5SxYk6xKY5jay
	 AMFgTgK6YCn8io1fOA//plg+f/spNZNJk3Dxjfg2mb4aZShEY5hQ48/ilYyDeugEUSuf2
	 GmOP7HIYnvriXMu3k8IV03EjnZv+qBlf9Yqn+TQFbvYvtMpfSxnqaiweoRoZc6TtKCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oXGNeM/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB415606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXGNeM/k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2834D1F0089F;
	Tue, 10 Nov 2026 01:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274002;
	bh=ulDGRdlEhRhdVf5P9BUE+whNbCjWFMzoanwf9zNWFqg=;
	h=From:To:Cc:Subject:Date;
	b=oXGNeM/k9jCUkJCAwzyYvqmlmHXtXoQdfwUryAZxbKxeoL6Sni1AVLT92Jt0yHzB+
	 4qjjKsB04sIug9ihEAK2C8CaMfqAPfhK72gfWJCGaA574sI5MiV+qN8ul4Is9RIm08
	 KmfZPJSyHk/eX5ypbpHwwDOxeK08DNLgQ1vdsogWoLBoMrGYOiYQDj8C/AfWItSaP+
	 lhHI9lX0bxHCySzCcvcNH/GCdPLv5gEUzlQ6cPX/i0dXULD+Z+Mmryzf/3x0WP7Meo
	 F+RT+AzMRTsedJedCYab9j68Lndu5ysPc2ZcfqxEQZfQJQ1veD7agT/fcUwxh3/xXX
	 pejGDDYKz7WjQ==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	hch@lst.de,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme: unregister when pr_register() is given a zero new key" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:41 -0500
Message-ID: <20261109202641-failed-5.10-a9d431124fb2@kernel.org>
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
git cherry-pick -x a9d431124fb2e58215daf0299d6fcf47bbc2d6b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202641-failed-5.10-a9d431124fb2@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




