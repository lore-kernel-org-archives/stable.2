Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047148;
	b=RGfBOg/KyYudwX4Mb3sSMONvb132IMSSO1zKh3Yee09RY+XLZpoJ5zfv3UngSa2RUesx
	 tNxEhgX8NkgpYKlkmRtcZV/34x+uI0L2mpGjm9b58rcMT8129wZvyLdxsPs12khzy44U/
	 pbRYqbW4Y/8VJoeWkVSLk5X2uB0QWRPe/jlFD2h1FhgC2heRUaVX83kLVzpdtY/+N699q
	 VeTsjgHR49V6L+nIfDE0bUByyX7d+rWS2+O/2RhEBNIP+ScPcjafCxUoOb7bFNB9X50lO
	 sHzT84LNOiZwdRUDvUY3xBnXNFA9zT4IHjUdCx5EAbqmcyKsd15fKlLUO16en4Abjsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047148;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6cMw1jVRKAvXubBNHNjX9Ax+fIxWm9O+8OJpDhCMvao=;
	b=XPsw68b/4OUnnwQIr9fOONmvTEU9rjq5MC7Dc/OmZE/ucFjOktXfMAvSPLpcetvNViWH
	 wWova/GUqxZBIteep/4vLMdkY15Y2ShJMgwlkZSTLf+k4GnZp1PTlj7zh5j4sk/oIw8CN
	 +TYBhagPO3jDYFU0bE7x6qmCDDT8WkDVa+HVzV/LVVlM+XLVwU77z9ywEd088/aLzqhfd
	 2Qt8uvocuGMhDVHsPh0R6qDil4awNb8wcjsuDW5EbstJ6iZ+kfQrS9Uuo8NBsTIEDHZxl
	 CuIMUw4Q03qzBu12S4qzPG2+BVgng+/xq6xdJHzti6Fvmkde50XQzdXhjfWLkXCNSJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkKg6pIQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkKg6pIQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7873C1F0089F;
	Sat,  7 Nov 2026 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047148;
	bh=6cMw1jVRKAvXubBNHNjX9Ax+fIxWm9O+8OJpDhCMvao=;
	h=From:To:Cc:Subject:Date;
	b=UkKg6pIQ5KuEC3IohvWzSg/LLjiWon9XNY1kLG+gdEAr7uYZ/ttcxE/qSUsL2d1Ta
	 ZoiPladlU14bllLr9NSAMubBGwZwGARNBHe2FJB7sa3wehRqU9zvqZYojazxyPnOmG
	 +B35CQJlByFC8T6+sqFvcOaoVtW1aeY5TxF7XR8hKpRRonHLOrlZpMKs79VC5/3qFx
	 jzsS7GeXmi8pSM3w7YG3Z9uMjULBoPo0y7FjonI7O4N+6WonO2XJE/EaVgI6vcP30T
	 pNyKbK0dRLjH2mavEv9Te0dSN8WOsmncySdjc6paNSt6A7N/sp6CZyrOF/6I+0aYWU
	 8IrWx5Gs/+WWQ==
From: Sasha Levin <sashal@kernel.org>
To: x-professor@outlook.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: handle out-of-range SG_SET_TIMEOUT values" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:46 -0500
Message-ID: <20261107052546-failed-6.12-9a6cb1da4f3b@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9a6cb1da4f3bc4633bf6669faed25a361834b1b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052546-failed-6.12-9a6cb1da4f3b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9a6cb1da4f3bc4633bf6669faed25a361834b1b9 Mon Sep 17 00:00:00 2001
From: Yingjie Wang <x-professor@outlook.com>
Date: Thu, 22 Oct 2026 02:55:11 +0000
Subject: [PATCH] scsi: handle out-of-range SG_SET_TIMEOUT values

SG_SET_TIMEOUT accepts a signed int in USER_HZ units. The sg character
device rejects negative values and limits positive values so the converted
timeout fits its destination field. The block SCSI and BSG paths instead
pass the value to clock_t_to_jiffies(), which accepts an unsigned long, and
store the result in an unsigned int.

Negative values are converted into large unsigned timeouts. On 64-bit
systems, large positive values can also exceed UINT_MAX after conversion
and are truncated on assignment. With HZ=1000 and USER_HZ=100, for example,
429496730 clock ticks become 4294967300 jiffies and are stored as 4
jiffies. On 32-bit systems, an overflowing conversion becomes ULONG_MAX,
which is an unsafe relative interval for the block timer comparisons.

Reject negative values with -EIO, matching drivers/scsi/sg.c. Saturate the
converted value at the smaller of the destination field limit and
MAX_JIFFY_OFFSET. This preserves successful ioctl behavior while avoiding
both narrowing wraparound and an unsafe 32-bit timer interval.

The block SCSI behavior predates Git history. BSG has exposed the same
behavior since it was introduced.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 3d6392cfbd7d ("bsg: support for full generic block layer SG v3")
Cc: stable@vger.kernel.org
Reported-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/9321a59c-c560-4742-8b71-5b0ec1f30c2f@acm.org
Signed-off-by: Yingjie Wang <x-professor@outlook.com>
Link: https://patch.msgid.link/20261022025508.294713-1-x-professor@outlook.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
---
 block/bsg.c               |  5 ++++-
 drivers/scsi/scsi_ioctl.c | 11 ++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 82aaf3cee5825..b296fa3732924 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -132,7 +132,10 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case SG_SET_TIMEOUT:
 		if (get_user(val, intp))
 			return -EFAULT;
-		bd->timeout = clock_t_to_jiffies(val);
+		if (val < 0)
+			return -EIO;
+		bd->timeout = min(clock_t_to_jiffies(val),
+				  min(UINT_MAX, MAX_JIFFY_OFFSET));
 		return 0;
 	case SG_GET_TIMEOUT:
 		return jiffies_to_clock_t(bd->timeout);
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 122403ec3ab8d..bf049d9cb7191 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -196,10 +197,14 @@ static int sg_set_timeout(struct scsi_device *sdev, int __user *p)
 {
 	int timeout, err = get_user(timeout, p);
 
-	if (!err)
-		sdev->sg_timeout = clock_t_to_jiffies(timeout);
+	if (err)
+		return err;
+	if (timeout < 0)
+		return -EIO;
 
-	return err;
+	sdev->sg_timeout = min(clock_t_to_jiffies(timeout),
+			       min(UINT_MAX, MAX_JIFFY_OFFSET));
+	return 0;
 }
 
 static int sg_get_reserved_size(struct scsi_device *sdev, int __user *p)
-- 
2.53.0




