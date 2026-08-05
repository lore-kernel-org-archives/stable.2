Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98A3C8C46
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929488; cv=none; b=oRtRsD2u1G+1EL3MvRpBa9yPhTvCNBblprHMLlXHKY6aXswowat3H215oq/NFzIT83JWkC4Kr5G3D5bz6qdyr8VhWbUJVR2U6s/AV6gg0QWI4QKuXYjd7JvRggz9fpwzPcfwnRHD1ZJqbgqZbq9VF4c4DzGJvDHMjCku0uXBkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929488; c=relaxed/simple;
	bh=9JcGpxvJSn/vnOXYOqgfb4IOJ0HcY93APm5DRmKH7TU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dYQOI2cxKlhSa0RkwSCpO3XRrt99vhYlShl9kuXE/l6hdupljGca3WMlTRS/h0vCsdGyNbh3veLHtLtgB10/a/CcIyo1XiWr7m1BwcX6uIb1ChJPQzf+2d+19vmWZX/A1AQEGB8n5A515xJb55l/6kf3Ga5c4OV7TtoEyfaIwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AfFyC3Kr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AfFyC3Kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3881F00A3A;
	Wed,  5 Aug 2026 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929486;
	bh=cjnNLtx/SlQk15tJqU2ilWdbpYZ04nl+/f4ujGLgCm0=;
	h=Subject:To:Cc:From:Date;
	b=AfFyC3Kr/aU12cJzY4DWu85R9nty+ewjN3P/iZYFOxr5Gze7IUN/GENif8DNxg5kG
	 QZ3414WdUeYiMsRqsfW3+bG9LTgYBPq9o2obnp/XFL20c8DlrxrQaPcPSEhpwTgL0z
	 wposZXTJMTAeEV4sYiTMEfQbf7IqgNIaV8QMVKcc=
Subject: FAILED: patch "[PATCH] net: pktgen: fix proc entry use-after-free" failed to apply to 6.6-stable tree
To: nicoyip.dev@gmail.com,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:31:01 +0200
Message-ID: <2026080501-smudge-pork-db82@gregkh>
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
git cherry-pick -x 817ff6efdb7f484ea547218e11e17d8e43daa3b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080501-smudge-pork-db82@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 817ff6efdb7f484ea547218e11e17d8e43daa3b4 Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 19 Jul 2026 22:57:40 +0800
Subject: [PATCH] net: pktgen: fix proc entry use-after-free

pktgen_change_name() replaces pkt_dev->entry while holding t->if_lock.
pktgen_remove_device() removes the same entry before
_rem_dev_from_if_list() takes that lock.

This allows the following interleaving:

  CPU 0 (NETDEV_CHANGENAME)       CPU 1 (kpktgend)
  if_lock(t)
  proc_remove(pkt_dev->entry)
                                  proc_remove(pkt_dev->entry)
  pkt_dev->entry = proc_create_data(...)
  if_unlock(t)

The kthread can pass the stale proc_dir_entry to proc_remove() after the
rename path has freed it. A reproducer with a widened race window reports:

  BUG: KASAN: slab-use-after-free in proc_remove+0x78/0x80
  Read of size 8 at addr ffff8881478fea70 by task kpktgend_0/67
  Call Trace:
   proc_remove+0x78/0x80
   pktgen_remove_device.isra.0+0x11c/0x4c0
   pktgen_thread_worker+0x1214/0x6bc0
   kthread+0x2c6/0x3b0
  Allocated by task 95:
   __proc_create+0x204/0x790
   proc_create_data+0x72/0xe0
   pktgen_thread_write+0xd61/0x1510
  Freed by task 28:
   kmem_cache_free+0xcb/0x3d0
   proc_free_inode+0x5b/0x80
   rcu_core+0x50a/0x1850
  The buggy address belongs to the object at ffff8881478fea00
   which belongs to the cache proc_dir_entry of size 192

Move proc_remove() into the if_lock-protected list removal helper. Keep it
before list_del_rcu() to preserve the ordering required by add_device().
The rename path must then finish replacing the entry before removal, or
it observes that the device is no longer on the list.

Fixes: 39df232f1a9b ("[PKTGEN]: fix device name handling")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260719145740.2888967-1-nicoyip.dev@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 8e185b318288..ee64f3012321 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3972,6 +3972,7 @@ static void _rem_dev_from_if_list(struct pktgen_thread *t,
 	struct pktgen_dev *p;
 
 	if_lock(t);
+	proc_remove(pkt_dev->entry);
 	list_for_each_safe(q, n, &t->if_list) {
 		p = list_entry(q, struct pktgen_dev, list);
 		if (p == pkt_dev)
@@ -4001,9 +4002,6 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 	 * list to determine if interface already exist, avoid race
 	 * with proc_create_data()
 	 */
-	proc_remove(pkt_dev->entry);
-
-	/* And update the thread if_list */
 	_rem_dev_from_if_list(t, pkt_dev);
 
 #ifdef CONFIG_XFRM

