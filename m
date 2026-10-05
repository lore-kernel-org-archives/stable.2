Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CA4A9D49
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211440; cv=none; b=Y2tzpdjBUg5OHYTCtLrHY4fgIMcTWsdM91lJlkDgH3CxzOZohEuCTqn9ZCWDhsDAN3gGGsU9AuOZ11h+z1FZ3JSLCtBYuAN7bCJKkjWXCVERL7O1ZKC84KplPeNHSGpu/Kos4oJQMHJvN6lI6gDSA/sm/RqWko1I4T3/TGUSw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211440; c=relaxed/simple;
	bh=HcgORQZoXqnGpHiOHHrQbfqRJa0N3LaWDrvSWqXCPtY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Be/PXTwnu5+n1dMLnfijM8WQLbSJGUiB6z5RJyBU7c47Zl4YJI3+ZU1ARN09WlLuheXmS2FkOoppfa/+o4J4KVV2SKlyjT6OpO76Rt5TYZBIamYCIiRACLDlzAUdos9gyHahBsX6jTybdLC1ziFsl5nsSrDGMxxJKye+nRMDdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I2/aovJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I2/aovJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FB61F000FF;
	Mon,  5 Oct 2026 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211432;
	bh=G1g8AjgnNED6RLkTBqathqXhod6NuV/x1SrHk6ARqz0=;
	h=Subject:To:Cc:From:Date;
	b=I2/aovJdPa84HJGXzX+VWjNpuxMHhiVhHLtmGGS9cCfJ8VCar2YhMYbvj8p5CFAe2
	 wrS7J7akRvIr8xCkivDtVrBVsm/7E12GhpQwaHcTvIwSuRTZ4UmmFiSfAvPNbpiJd2
	 0FrF0nZc7aqf/mDbZNz5c/cb3QtgqkV8jKcVJrvg=
Subject: FAILED: patch "[PATCH] thunderbolt: Fix NULL dereference in tb_remove_work()" failed to apply to 6.6-stable tree
To: pchelkin@ispras.ru,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:43:42 +0200
Message-ID: <2026100542-refill-fancy-7a78@gregkh>
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
git cherry-pick -x 4310c6b8e75d6a47f7548e5948fbe6318aa4440a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100542-refill-fancy-7a78@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4310c6b8e75d6a47f7548e5948fbe6318aa4440a Mon Sep 17 00:00:00 2001
From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Mon, 31 Aug 2026 10:58:09 +0300
Subject: [PATCH] thunderbolt: Fix NULL dereference in tb_remove_work()

There is a slight race between tb_remove_work() and tb_domain_remove()
which leads to dereferencing a NULL tb->root_switch pointer inside
tb_free_unplugged_xdomains():

        Thread A                            Thread B

  tb_remove_work()
                                    tb_domain_remove()
                                      mutex_lock(&tb->lock)
                                      tb_stop()
                                        /* doesn't cancel a running callback */
                                        cancel_delayed_work(&tcm->remove_work)
                                        ...
                                        tb_switch_remove(tb->root_switch)
                                        tb->root_switch = NULL
                                      mutex_unlock(&tb->lock)
    mutex_lock(&tb->lock)
    ...
    /* without checking ->root_switch */
    tb_free_unplugged_xdomains(tb->root_switch)
    mutex_unlock(&tb->lock)

Commit a8937f35cf39 ("thunderbolt: Remove XDomain from the bus without
holding tb->lock") doesn't seem right to move tb_free_unplugged_xdomains()
out of the &tb->lock section and the check for tb->root_switch, in
particular.  It states:

  For this reason separate removing the XDomain from the topology data
  structures (where we need the lock) from unregistering the device from
  the bus (where remove callbacks of the drivers are being called).

tb_free_unplugged_xdomains() belongs to the former group of functions
requiring the lock.  And it also calls tb_xdomain_remove() which should
only be called with &tb->lock held.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: a8937f35cf39 ("thunderbolt: Remove XDomain from the bus without holding tb->lock")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index ba63610d2ce2..4e5d0578fd4b 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -3285,11 +3285,11 @@ static void tb_remove_work(struct work_struct *work)
 	struct tb *tb = tcm_to_tb(tcm);
 
 	mutex_lock(&tb->lock);
-	if (tb->root_switch)
+	if (tb->root_switch) {
 		tb_free_unplugged_children(tb->root_switch);
+		tb_free_unplugged_xdomains(tb->root_switch);
+	}
 	mutex_unlock(&tb->lock);
-
-	tb_free_unplugged_xdomains(tb->root_switch);
 }
 
 static int tb_runtime_resume(struct tb *tb)

