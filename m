Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8894AF168
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211446; cv=none; b=muss5eQxFiyh3QUOw6yyPGs26/y3P/jbUEij0WcZYf247yinqS8RPLcCoQtnWB1Q2fat5m2qB7KQdAU5csmrAWq+IabB5RRI2EswDtp431LDIPVQyGPCHwdpwzG8tj9kH3xK78zw5bmtdenQPDerTH9x+PklObHFcG6jTuAaGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211446; c=relaxed/simple;
	bh=CXUpg4yw7sNV0JaERGjEB1NUR6E8oaA4GEzJsBa74wg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ls6oPIi6WZtBGMNr6RmUJ/mFrlW8d32YLqRaRc9e83SSChj+0g07SJWpwSfLhPPscVi5EcXwNAItvf+X/93ajq8lLRV/StfEEeBWUDJP/jcalYqNLIn6rQmIKSqF6kDT5b9qlk6oqRRPMPB9JBgnpXFbAK/wWpqURxMQDlvt8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AasazQIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AasazQIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C214E1F00898;
	Mon,  5 Oct 2026 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211438;
	bh=RGs91XXYTmMztN0xm/nUyHvgQLlOJwJFjDsQgqIufyQ=;
	h=Subject:To:Cc:From:Date;
	b=AasazQIRZAzOO32aVkBG6pPRuztiQnmeTD2StPH5ruGt6j9WAWfk/tv+6KzJsbTzb
	 xOOWvylTk2bJ/ochpXPZn2TG6Td2d/rNwPxOwb6CBNe19Kn3+U978C3V6uJlrjBguN
	 MFbKySDnsTW/N40Hj14elCZPXw3yo3QCc6axcCKE=
Subject: FAILED: patch "[PATCH] thunderbolt: Fix NULL dereference in tb_remove_work()" failed to apply to 5.15-stable tree
To: pchelkin@ispras.ru,mika.westerberg@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:43:43 +0200
Message-ID: <2026100543-winnings-brussels-2477@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4310c6b8e75d6a47f7548e5948fbe6318aa4440a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100543-winnings-brussels-2477@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

