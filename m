Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF124BB80C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446462; cv=none; b=ndk/RqvrcS/nvCBg8Kb1C7KDrES+7XbH4cxEl7KURWA85bgsf11YG5etKTW/mdXBsAB5egzxsA9M2hEuUW5Me+QYNT6q5WGqxu/CFAACcnq7S9zNyXFd8zTvnsKbymSz8MLFbjfp/K1q2h3aEztsuaJqnduXPAtfT0kqE7ODl4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446462; c=relaxed/simple;
	bh=SeHMZkz+k4kDFWzDeqWx/HN4RyltFdZb8icA0ZMyaVk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WSJDvxY0U5aZkAfeuAN8GjGge8NoUK0dW9KKFDsFpYJi/WyKl/gV7fDFAjUhHPvCuSGaic82wzsOeCl9ZTld5eTPA/H5rTqOJLFzhM+DezU8nIDUhJzMvbh+OBcflAMFQAZPH2Mlc5VlTDGOnDja2ovgIIglqwAsChNCHb00nbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YAqSU6UV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YAqSU6UV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6177D1F00A3A;
	Thu,  3 Sep 2026 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446450;
	bh=BBBMqs70ia1B1dZ3DAMmQQ+xpGXtBZtB1ms0UaWvsSI=;
	h=Subject:To:Cc:From:Date;
	b=YAqSU6UVqZYPo3BN2ertPUty4Uu7M8nBzP8M2XkjFDwjyHXDU4cr9W0wOavxbcv62
	 OaAbgXiyO0vpiNeBqih0BU7XFqqVfEtt3hxgFSPv6LBDYK7y5A8c0EgDznaWTV+BXn
	 ZEYbWpY/jBJUSznq5NXmqHo+gyMuUMQOp/6AhhLs=
Subject: FAILED: patch "[PATCH] scsi: fnic: Use GFP_ATOMIC for VLAN alloc under spinlock" failed to apply to 6.18-stable tree
To: gonglinkai@kylinos.cn,kartilak@cisco.com,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:18:00 +0200
Message-ID: <2026090300-shirt-frown-80ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9639c6324524ea3f934908bd51f02430000954ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090300-shirt-frown-80ad@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9639c6324524ea3f934908bd51f02430000954ab Mon Sep 17 00:00:00 2001
From: Linkai Gong <gonglinkai@kylinos.cn>
Date: Fri, 31 Jul 2026 15:38:20 +0800
Subject: [PATCH] scsi: fnic: Use GFP_ATOMIC for VLAN alloc under spinlock

fnic_fcoe_process_vlan_resp() allocates a VLAN descriptor with
kzalloc_obj() (default GFP_KERNEL) while holding vlans_lock via
spin_lock_irqsave(). GFP_KERNEL may sleep, which is not allowed in this
atomic context and can trigger a sleeping-from-invalid-context warning
or deadlock.

Pass GFP_ATOMIC so the allocation is safe under the IRQ-safe spinlock.

Fixes: 098585aa8aca ("scsi: fnic: Add and integrate support for FIP")
Cc: stable@vger.kernel.org
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>
Link: https://patch.msgid.link/20260731073820.16449-1-gonglinkai@kylinos.cn
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/fnic/fip.c b/drivers/scsi/fnic/fip.c
index 21d08a710f0d..231dec180675 100644
--- a/drivers/scsi/fnic/fip.c
+++ b/drivers/scsi/fnic/fip.c
@@ -137,7 +137,7 @@ void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph)
 			vid = be16_to_cpu(vlan_desc->fd_vlan);
 			FNIC_FIP_DBG(KERN_INFO, fnic,
 				     "process_vlan_resp: FIP VLAN %d\n", vid);
-			vlan = kzalloc_obj(*vlan);
+			vlan = kzalloc_obj(*vlan, GFP_ATOMIC);
 
 			if (!vlan) {
 				/* retry from timer */

