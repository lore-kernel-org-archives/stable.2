Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610819;
	b=ANyO/jXPi2EQwReZ9WOZlc6GLd+UCh90mjtDlt2IkVLDbHmqyvPZTa4FTFA8LdJj3E4J
	 alO0rZiwCsViIFJq3lTBNV5jMbHTpt5UwnNQQ4Ru/OetADaxy8KdHH42VqNjIvCQSRIf4
	 J48ZtPi4BMFjifWT02CCH4aB7mvn/1z2w1Re3wZPelBZA8j4ZHDwjGcWOu7fwc61nf41j
	 FMf4PoxFTge410yXfXRMAVodm2XPRKajUrRq6CK30sGr7OQgQWhhNU5CbhNMJaS8auAGU
	 9SrYAL1rcD+6VpYOoHJiMlcMk8KXvsH9SpAL4aTLHXgVpwYGnDsBJl+K7DQCSff5c6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610819;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8SZc+DeionhtRrfIBQbUdgyzsh/BCgUsjsAERfOrwX4=;
	b=dfRMBfrmvoGxxcmEKRbVQFieNtPqVHs59+S9akdBVY3T55E5eYdjOvEPHi6GfJjXjy6h
	 p0MAgaYYqlEr7SmhJuJ5dLB49nMuWB1QZcJBo3ASxURNJ6s7LZCddZhkVHHycFzFbHskT
	 geviQGKDuTvGgsUhQcKopKZJcJLkJQBcfmScoY/uTTwCWK+v6twYmNPpQmmsQj183WLAq
	 LrDiCyJcwrR76oiGuWKVt7mZzyOJjd/zdkSYk8CxQ1eslzfG9QWSIqNSBw4+fFlEmUYJz
	 eCRlbL+S8w6I0k4R8eQ5wjl1K7sNhZjLRzOLdLmN+JgoADhch+m5aeiV/cWg7v2gAsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vwtu+FMA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4F606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vwtu+FMA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738261F000EC;
	Wed, 25 Nov 2026 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795610819;
	bh=8SZc+DeionhtRrfIBQbUdgyzsh/BCgUsjsAERfOrwX4=;
	h=Subject:To:Cc:From:Date;
	b=vwtu+FMAGQz/E8JXoIg2FtfR6mmoMNArgLRgVjKo8nsE+REINc+4VY44fkSX3IAQ6
	 9vM3Us+ONFZYvGTdC1MMqXaRWFeKF25iBpZbpTTA/8pzo1m3ii2dCRGOD5keOdvge7
	 sgrzZhpfsoWEJyrN6Gj4CcXvjo3mScMHqx2bwgAo=
Subject: FAILED: patch "[PATCH] iio: trigger: free the trigger ID after device_del()" failed to apply to 5.10-stable tree
To: lcy8047@gmail.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:45:08 +0100
Message-ID: <2026112508-sinister-decency-b03e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x d32bf759801e6df23038dc834622a122ec76a4dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112508-sinister-decency-b03e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d32bf759801e6df23038dc834622a122ec76a4dd Mon Sep 17 00:00:00 2001
From: Changyul Lee <lcy8047@gmail.com>
Date: Fri, 6 Nov 2026 12:47:37 -0500
Subject: [PATCH] iio: trigger: free the trigger ID after device_del()

iio_trigger_unregister() returns the trigger ID to iio_trigger_ida
before device_del() removes the "trigger<N>" device. A trigger
registered in between can get the same ID, and its device_add() fails:

  sysfs: cannot create duplicate filename '/bus/iio/devices/trigger0'

For example, adding a sysfs trigger while an hrtimer trigger is being
removed through configfs, or the other way around, hits this because the
two paths do not share a lock.

Free the ID after device_del(), as the error path of
iio_trigger_register() already does, and drop the "Possible issue in
here" comment.

Fixes: 1637db44413e ("Staging: IIO: Trigger support added to core.")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index fc4651490d42..1078ffa8e06a 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -105,9 +105,8 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 	scoped_guard(mutex, &iio_trigger_list_lock)
 		list_del(&trig_info->list);
 
-	ida_free(&iio_trigger_ida, trig_info->id);
-	/* Possible issue in here */
 	device_del(&trig_info->dev);
+	ida_free(&iio_trigger_ida, trig_info->id);
 }
 EXPORT_SYMBOL(iio_trigger_unregister);
 

