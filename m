Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048851;
	b=25N5YbzKWnngf0t4604BMoBJzaH9nY+B20W7Ezd8XoOZGr/8tBIUyPS+R+lf92Fk2YN2
	 1agQsgDjnD086RT5VksdAhFINc7WlJm5JrVGI8lCjEgMmZbutMXAQIbuiHUVIFjMgaoX/
	 VwAmPh8m9AQkflIKyykbBV9pKwKoEbbnnw3ice9Hsj9L20tcLGZEIIgaT+qv+5MJdpto/
	 vNLIzSawxM52YFaTn1WDu+leumca2hL7at8Yy+Q+Zy1k6nVIfDafiqCdrEpE7WCueaolg
	 73o67y7Al1oY4R8c+rN3k+eHN8OjYzts5ZpfspIg8h0EhFdw3ud2CTAcK1nzHINgXdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048851;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=s3G15wxCaoTc597y5q4GBHfK9cwGWobtAb+aBbItrfc=;
	b=xAHrZGI14XMZEMHHlYX32u25/tb4ONImTY0qO6aVSO8wJi2mRByZSYeBBAfevL871/hO
	 ERLa8euth2aS1h+q74vT9H2NtBi60xH321Ee9fBSpJk5mFeqdccVoYrCUcJcJ/4CUiGtQ
	 sy2/ptdxKBIzHKShhJySjOgUJ2sp/TgqRGM31iIhKO1qJLNTiwpKgQo/zU5G2DSE1tEbt
	 n0eushmDnJBquW9Zd7SCzG3O/QeB4iVjoIDx8NdngWCMaMroMXUVBOqiZL8lCux/VkGKF
	 p4asmINaH5lm22Eb0tkcyJRB0F8QhiIx0Uodp8BldyOWdjykWqJbliH2mlMxRq6vW3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHUWmd9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59773606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHUWmd9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33D91F008A1;
	Sat,  7 Nov 2026 10:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048851;
	bh=s3G15wxCaoTc597y5q4GBHfK9cwGWobtAb+aBbItrfc=;
	h=From:To:Cc:Subject:Date;
	b=jHUWmd9C/i0rsRplRhVzPsjJIsY1642KRLpHwINrW0UH99dEJ9eY9J7j+1CCxaZ9B
	 WCI0tq2e8fhfWG8bpzwz5aifcCceEGitCVGzJfaUuMlE4A5RrvlM9mtVCr+uIHGY47
	 EGQMboph7Zf9E+iBtN9YgBOgHzGUparRSW8oVNOaE74pVYY+Ol7kn4pGBgHrf2lU4L
	 98K8gGar9/uFMBxIusVh6QB653n9ZAgnPo2ZwmD5sOT4FxP9mmNU6+aVrnR40cCnhc
	 Hasgljk4Axmgg6ztQXnnpjf6FUbvRfp/i96wxZiWZmyaS/Kh6d/wa4kVjimnP64bSQ
	 G2XC6vcOnHYSw==
From: Sasha Levin <sashal@kernel.org>
To: x-professor@outlook.com,
	bvanassche@acm.org,
	mkp@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] scsi: handle out-of-range SG_SET_TIMEOUT values" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:09 -0500
Message-ID: <20261107055409-failed-6.1-9a6cb1da4f3b@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9a6cb1da4f3bc4633bf6669faed25a361834b1b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055409-failed-6.1-9a6cb1da4f3b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




