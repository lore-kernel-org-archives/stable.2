Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AE43441A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225914; cv=none; b=cPirGNo+41c7Bp2KQ1WWqOOojpais7vNPHZZXqkhkQN06rrRVqnbp9QpmXXgZCxLxYRdjeUmokWTijKVVEtABg0x+SeoF077/FwmjdMTXYV3x/7YpHLMXpmiUv2o4r3P4KgrL4nuNUhmdWIMrRWbtZlg/yej9juVCU5a0gfXe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225914; c=relaxed/simple;
	bh=YZw3IClp3GA3WoXIjbCSXCO/PncyAEBP5/6ZgI+QXns=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K4Ia2mYf7J+vNsCO7j+Vviciq8v56Y4J+kzrbh/4s4ACTwGW/zy59H9Ksqqlo8u5vzWyZaXhIj8Cwz06nOc6G5zAf3e/FdxFMUbIWvCvIWPVFsq0YLobYnJ8nJp6HSNy8QWELDxQLmX4dE0ml1gUB5E/xoV6ks3uBt3Gm3f94XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYs1PcVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYs1PcVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347B01F000E9;
	Thu, 20 Aug 2026 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225912;
	bh=V9IlgF30tDrkziZGzPF/IFp/q7wzkPy4FR7jq2qPYsE=;
	h=Subject:To:Cc:From:Date;
	b=KYs1PcVqv4diBrtl591G4zGNufb8Dfkd2LASaK9T1nNoZX4cGnKqGdcReGC7FLWd+
	 DMnQqJpphM2fxEQQvYsReA2tYhXemPzXEago7Ipr1TGCiGvGA/WdbfcAdZFBGK0LVw
	 x2GrCgz+0gdba7Mz4khEZhHxA3CxnR+atVG4A6g8=
Subject: FAILED: patch "[PATCH] s390/vfio_ccw: Calculate idal length based on idaw type" failed to apply to 6.6-stable tree
To: farman@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:23:58 +0200
Message-ID: <2026082058-slush-preface-49a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 4f6fdc6e1a7fbfa36b945af33c65a417948feac0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082058-slush-preface-49a0@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f6fdc6e1a7fbfa36b945af33c65a417948feac0 Mon Sep 17 00:00:00 2001
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 28 Jul 2026 05:30:17 +0200
Subject: [PATCH] s390/vfio_ccw: Calculate idal length based on idaw type

Sashiko pointed out that get_guest_idal() unconditionally calculates
the length of the IDAL presuming everything is a Format-2 IDAW.

The output of vfio-ccw is always Format-2, but the input can be either
Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
the size of the guest IDAL may be incorrect and should be trimmed down.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.org/
Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 6275794751cb..5ef082b8289a 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -233,6 +233,7 @@ static void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
 }
 
 #define idal_is_2k(_cp) (!(_cp)->orb.cmd.c64 || (_cp)->orb.cmd.i2k)
+#define get_idaw_size(_cp) ((_cp)->orb.cmd.c64 ? sizeof(u64) : sizeof(u32))
 
 /*
  * Helpers to operate ccwchain.
@@ -524,7 +525,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
 	u64 first_idaw;
-	int idal_len = idaw_nr * sizeof(*idaws);
+	int idal_len = idaw_nr * get_idaw_size(cp);
 	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask = ~(idaw_size - 1);
 	int i, ret;
@@ -593,7 +594,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 	struct vfio_device *vdev =
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	u64 iova;
-	int size = cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
+	int size = get_idaw_size(cp);
 	int ret;
 	int bytes = 1;
 

