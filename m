Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCCA2620DE
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784514959; cv=none; b=mwlmXJhCWXqeJg+dfbrLNxuTUcYN9gFDf2zDAYZIRi48casA5fFeqz1VHWHFVk+3OuVJ+jsGsR4gZDjpntyVkmMlh7uSj31CWk9KJU3lVJk1En1ih1sZvGZfi4w7Kdvu8bqfYdISiyM+Uu4hFVqIrTFpPsxyaZbL/9IGKk60fY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784514959; c=relaxed/simple;
	bh=EYYSljluAoaLLGAF9OrnT9cj0le6PnoXmkjBbKL16ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2dI7W9ebUwNupw8di8m8+Itth63/o9EU/kCvIVYgEwL1BdjdjEpjONgz1Xzktq7o+uLu9zxxdgbnX4a7uLbNxmgb+cg/sZUez8OMd9uEXMN/y8sNlIusWhmqC2wW9X0777961W5GNsfrm2J4K7aMkmkn089IONTUa04AHVizYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iA4ROBL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iA4ROBL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D251F00A3A;
	Mon, 20 Jul 2026 02:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784514958;
	bh=rHTzs8F3n/Rl+3QnCI+mBGHCao8Dh9ynsaFaDtWTfRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iA4ROBL+zuYn88s1OFd011xHdUjpTMSyvvyZq1cpYhD3W24wJNzl9EMk+YD+/vT3z
	 YfbY88bwXWgvO8FZQt0nEfmkmAzkGjQehDFvbC2t4BE0ihr0Efpm+nfq2Yh8y9IzY7
	 Nnw+cVOL0bLxxX+PknFhOYIDSZOQOnvl6OWCZd+XRMZfNDcdbOD0ON1MZq6xhfTled
	 NKCTLhW/nKpfSjwFqXb1Mg7AiywqLVbK2bwf+NsfDgjqQzPUsYO8X12UcL2hTdTYat
	 Q7Cl86W2EH7+wpeqCTjhsiX61Qg+1sHRSJDVTJAq26tVuh4b29KRw1nyWPj4htsT6b
	 /WVuQeoMG9w2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Samuel Wu <wusamuel@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/6] functionfs: use spinlock for FFS_DEACTIVATED/FFS_CLOSING transitions
Date: Sun, 19 Jul 2026 22:25:50 -0400
Message-ID: <20260720023553.2928009-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720023553.2928009-1-sashal@kernel.org>
References: <2026071455-cultural-frenzy-db69@gregkh>
 <20260720023553.2928009-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 2005aabe94eaab8608879d98afb901bc99bc3a31 ]

When all files are closed, functionfs needs ffs_data_reset() to be
done before any further opens are allowed.

During that time we have ffs->state set to FFS_CLOSING; that makes
->open() fail with -EBUSY.  Once ffs_data_reset() is done, it
switches state (to FFS_READ_DESCRIPTORS) indicating that opening
that thing is allowed again.  There's a couple of additional twists:
	* mounting with -o no_disconnect delays ffs_data_reset()
from doing that at the final ->release() to the first subsequent
open().  That's indicated by ffs->state set to FFS_DEACTIVATED;
if open() sees that, it immediately switches to FFS_CLOSING and
proceeds with doing ffs_data_reset() before returning to userland.
	* a couple of usb callbacks need to force the delayed
transition; unfortunately, they are done in locking environment
that does not allow blocking and ffs_data_reset() can block.
As the result, if these callbacks see FFS_DEACTIVATED, they change
state to FFS_CLOSING and use schedule_work() to get ffs_data_reset()
executed asynchronously.

Unfortunately, the locking is rather insufficient.  A fix attempted
in e5bf5ee26663 ("functionfs: fix the open/removal races") had closed
a bunch of UAF, but it didn't do anything to the callbacks, lacked
barriers in transition from FFS_CLOSING to FFS_READ_DESCRIPTORS
_and_ it had been too heavy-handed in open()/open() serialization -
I've used ffs->mutex for that, and it's being held over actual IO on
ep0, complete with copy_from_user(), etc.

Even more unfortunately, the userland side is apparently racy enough
to have the resulting timing changes (no failures, just a delayed
return of open(2)) disrupt the things quite badly.  Userland bugs
or not, it's a clear regression that needs to be dealt with.

Solution is to use a spinlock for serializing these state checks and
transitions - unlike ffs->mutex it can be taken in these callbacks
and it doesn't disrupt the timings in open().

We could introduce a new spinlock, but it's easier to use the one
that is already there (ffs->eps_lock) instead - the locking
environment is safe for it in all affected places.

Since now it is held over all places that alter or check the
open count (ffs->opened), there's no need to keep that atomic_t -
int would serve just fine and it's simpler that way.

Fixes: e5bf5ee26663 ("functionfs: fix the open/removal races")
Fixes: 18d6b32fca38 ("usb: gadget: f_fs: add "no_disconnect" mode") # v4.0
Tested-by: Samuel Wu <wusamuel@google.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 3137b243c939 ("usb: gadget: f_fs: initialize reset_work at allocation time")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 9816d672b509c0..8720ca0f64d091 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3736,6 +3736,7 @@ static int ffs_func_set_alt(struct usb_function *f,
 {
 	struct ffs_function *func = ffs_func_from_usb(f);
 	struct ffs_data *ffs = func->ffs;
+	unsigned long flags;
 	int ret = 0, intf;
 
 	if (alt > MAX_ALT_SETTINGS)
@@ -3748,12 +3749,15 @@ static int ffs_func_set_alt(struct usb_function *f,
 	if (ffs->func)
 		ffs_func_eps_disable(ffs->func);
 
+	spin_lock_irqsave(&ffs->eps_lock, flags);
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
+		spin_unlock_irqrestore(&ffs->eps_lock, flags);
 		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return -ENODEV;
 	}
+	spin_unlock_irqrestore(&ffs->eps_lock, flags);
 
 	if (ffs->state != FFS_ACTIVE)
 		return -ENODEV;
@@ -3771,16 +3775,20 @@ static void ffs_func_disable(struct usb_function *f)
 {
 	struct ffs_function *func = ffs_func_from_usb(f);
 	struct ffs_data *ffs = func->ffs;
+	unsigned long flags;
 
 	if (ffs->func)
 		ffs_func_eps_disable(ffs->func);
 
+	spin_lock_irqsave(&ffs->eps_lock, flags);
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
+		spin_unlock_irqrestore(&ffs->eps_lock, flags);
 		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return;
 	}
+	spin_unlock_irqrestore(&ffs->eps_lock, flags);
 
 	if (ffs->state == FFS_ACTIVE) {
 		ffs->func = NULL;
-- 
2.53.0

