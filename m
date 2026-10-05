Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777164AEBC7
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211448; cv=none; b=dYK4CtphyAlLqmEjlZr4Vq3fuN3c3k3lAXKDclVtKNCErqO0EHmG/tXQxh6BvU68shpJnwoJcTdOUp7o/ilh2OKhyXwqsistJjw9J+OUU6CrPTnbC3BCib+FUoCvp3uzCYuipXtJweUcykwANiYyMD0sS0yHpNdo8lP0BCh+His=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211448; c=relaxed/simple;
	bh=ggcTsYOK7XeD0V/t0k/lNjowx8Olb6CwZ+GAwGy6DYM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cFNjbh97mUk7lls5EWZ4q4+Ohj+HlrYP84p6sAZg5tFtEKSZySK5Rc4ZoCyd28GbxUAUEuo7t4AlvlaFJdKN+dO9qa9tLwG6jE7VZMIHrUHQszmrTMAoWfwi4LE6Sh4VD4tZjGIDDSyskHIZguSOhhVg7IHgv9+2sy8RyBfJ9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VRmyHwcX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VRmyHwcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93931F000FF;
	Mon,  5 Oct 2026 14:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211441;
	bh=hwqCpi81rgZlaibOo3HuZrZ8L6cPgR0b67Mhy4Fc37U=;
	h=Subject:To:Cc:From:Date;
	b=VRmyHwcX8mA7kJdkfkz6f6u5RtZ8h2FS5zy++RVCknXDqbqv8YP5OxW4oTmlqH8Y4
	 LeDmY09DjdJ6CI3emJSt1jgh6YL8CL/TbwSFT8aArOLAdoWP02hJCI81CEJk5pH4ck
	 1/1jRqgjEV2TobgluoaVz6PYOtYOWuCvBY8c08vc=
Subject: FAILED: patch "[PATCH] thunderbolt: Fix NULL dereference in tb_remove_work()" failed to apply to 6.1-stable tree
To: pchelkin@ispras.ru,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:43:43 +0200
Message-ID: <2026100543-reissue-valuables-0244@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4310c6b8e75d6a47f7548e5948fbe6318aa4440a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100543-reissue-valuables-0244@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

