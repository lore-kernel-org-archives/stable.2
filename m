Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31834BD36E
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888538; cv=none; b=FUF3cobWGZx3/WdCtNhPbwVdwAu1LzKSGB8IvjhL64Q2S/3d7OWVOKZv7uG6ztbDDXpTGT9sqx96MhJ5XH5Kl9wiAwSPRvu6mV9FI7uKzkUSIyR1s7CJlN3hRa41dEI2qWe6obSJY0YP2f9oh7k+OCrviSJ76dPbxkj17qWzR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888538; c=relaxed/simple;
	bh=6EyADXqmYYhBqK6MOOrCPfzuUoxGVJl2IU3glffKc4U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f0bmaGhMRi2dz/dNg+O0K+yWu+J8VMH/pzKzLW8789zsjelWKLPMDt2T1Dok5d7pD79xf0xPxm0i7jPE/yZs8+8DEaBI+FQvI8INafC+JiowqDPZOue5vHMdufctFTJzSoiC5MAI6fK5OLSahN0+pjS1HT8OuyJ8mvATmkTK/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wmevna6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wmevna6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E653C1F000FF;
	Tue, 13 Oct 2026 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791888536;
	bh=MZKpJz24QUBtDg3LRVJZfpXCXLqDUgfQIvMI11+Js4k=;
	h=Subject:To:Cc:From:Date;
	b=wmevna6kHl5bey1s1aK49+9YFjc4ivbZhAqMJW9YJ6vSqBP0GGoho2Qe8wKqLgmJd
	 Nrvbrpth4NUIb8fKPKifZoDjhQYoN5i1JMA/Cw/p1XD7AyBmxFQgxVb31j5b14Iw6r
	 KIADB5rk4hU4Hr1AfuiFONlLpQ5IpDcqOJlhyJOo=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync" failed to apply to 6.1-stable tree
To: luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Oct 2026 12:49:01 +0200
Message-ID: <2026101301-define-tubeless-eb20@gregkh>
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
git cherry-pick -x 7453847fb22c7c45334c43cc6a02ea5df5b9961d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101301-define-tubeless-eb20@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7453847fb22c7c45334c43cc6a02ea5df5b9961d Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Fri, 16 Feb 2024 15:29:55 -0500
Subject: [PATCH] Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync

Fixes the following trace where hci_acl_create_conn_sync attempts to
call hci_abort_conn_sync after timeout:

BUG: KASAN: slab-use-after-free in hci_abort_conn_sync
(net/bluetooth/hci_sync.c:5439)
Read of size 2 at addr ffff88800322c032 by task kworker/u3:2/36

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38
04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
<TASK>
dump_stack_lvl (./arch/x86/include/asm/irqflags.h:26
./arch/x86/include/asm/irqflags.h:67 ./arch/x86/include/asm/irqflags.h:127
lib/dump_stack.c:107)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
? preempt_count_sub (kernel/sched/core.c:5889)
? __virt_addr_valid (./arch/x86/include/asm/preempt.h:103 (discriminator 1)
./include/linux/rcupdate.h:865 (discriminator 1)
./include/linux/mmzone.h:2026 (discriminator 1)
arch/x86/mm/physaddr.c:65 (discriminator 1))
? hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
kasan_report (mm/kasan/report.c:603)
? hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
hci_abort_conn_sync (net/bluetooth/hci_sync.c:5439)
? __pfx_hci_abort_conn_sync (net/bluetooth/hci_sync.c:5433)
hci_acl_create_conn_sync (net/bluetooth/hci_sync.c:6681)

Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b7d8e99e2a30..4a28aef2f01f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6670,15 +6670,10 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	else
 		cp.role_switch = 0x00;
 
-	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
-				       sizeof(cp), &cp,
-				       HCI_EV_CONN_COMPLETE,
-				       conn->conn_timeout, NULL);
-
-	if (err == -ETIMEDOUT)
-		hci_abort_conn_sync(hdev, conn, HCI_ERROR_LOCAL_HOST_TERM);
-
-	return err;
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+					sizeof(cp), &cp,
+					HCI_EV_CONN_COMPLETE,
+					conn->conn_timeout, NULL);
 }
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)

