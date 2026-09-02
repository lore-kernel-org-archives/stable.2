Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D7488207
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351066; cv=none; b=Db113GZ7EiQerMXGk1acD0TepveKEPZ7jRe44gCsGsDIqNqXAYDqDdaDzXbcvOHDPqnyhGW1dfcVjIdGCqg7mWw2cEsDyGDlIvC0RosX5olcGqvAu9P7xscvdjwB+AUVzyBl7Q7zDOyU3TR005cuGBD7DFi0PVs5eLyLq+ip6Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351066; c=relaxed/simple;
	bh=YMK5LvesX9XitnPi7os9CksoixaX/8C7fM7tV9Cgc3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHHAC9dQoGOgzj0ov/kjcr6HfB4wpLCipMZOwWYS/LQMldKJbrWVWJeGBHRcRx4U4TjPHP0YN+wdL1QKVo8a+gJaD+OJxd9XkLKA0HXBpVMjTM3YCWq7iGI2queKzBlMc0LokrNZ8Y41SB5kSJE3NCqKlpi9fGYyUkXpjS2agEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFrb+DEs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFrb+DEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788351061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zanSzEiwTIQarru0lltqSRWr2TKEL/j5OJqjRgaFpJA=;
	b=OFrb+DEsFLGTv7gnkXFEqnTC/Fgd7kaStVqw6R+gSNOfbYZGM1IzVhaUz2tVKPQmfnvcuJ
	lOe91d2q8fOvbUigy9dbuyQLufvABQ3r+2kHXFmIGf4gI7a7fCfdBXu1/OKE4fBhVM0yOr
	XnkdlaHxe/J6eq2C9GlAhIdN/bULjGc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-2dqzDj8YNfqSjBxsi3hNOw-1; Wed,
 02 Sept 2026 08:10:57 -0400
X-MC-Unique: 2dqzDj8YNfqSjBxsi3hNOw-1
X-Mimecast-MFC-AGG-ID: 2dqzDj8YNfqSjBxsi3hNOw_1788351056
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48E8D19344F7;
	Wed,  2 Sep 2026 12:10:55 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.158])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1428D3000223;
	Wed,  2 Sep 2026 12:10:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	Qi Zhang <marsy12010123@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] afs: Clear stale peer app data after address list changes
Date: Wed,  2 Sep 2026 13:10:22 +0100
Message-ID: <20260902121024.3328255-5-dhowells@redhat.com>
In-Reply-To: <20260902121024.3328255-1-dhowells@redhat.com>
References: <20260902121024.3328255-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Chengfeng Ye <nicoyip.dev@gmail.com>

afs_fs_probe_fileserver() fetches the current endpoint state under
server->fs_lock, but leaves old_alist as NULL.  Consequently,
afs_set_peer_appdata() treats every address list replacement as initial
setup and only binds the new peers; it never unbinds peers removed from
the old list.

An address refresh can therefore proceed as follows.  CPU 0 replaces
server S's list and drops Pold without clearing Pold->app_data.  The
server destroyer then clears only S's current peers and lets S reach its
RCU callback.  After the callback frees S, CPU 1 handles a callback
through an RxRPC connection that still pins Pold, reads Pold->app_data,
and calls afs_use_server() on the freed object.

KASAN reported:

  BUG: KASAN: slab-use-after-free in afs_find_server+0x3c/0xa0
  Read of size 4 at addr ffff8881013e1af0 by task krxrpcio/7001/74
  Call Trace:
   afs_find_server+0x3c/0xa0
   afs_rx_new_call+0x15c/0x390
   rxrpc_new_incoming_call+0x97c/0x1730
   rxrpc_input_packet.constprop.0+0xd03/0xec0
   rxrpc_io_thread+0x967/0x1640
  Allocated by task 93:
   afs_lookup_server+0x1a7/0x14c0
   afs_alloc_server_list+0x43f/0xb60
   afs_create_volume+0x923/0x1490
   afs_get_tree+0x1c6/0x10a0
  Freed by task 0:
   kfree+0x131/0x3c0
   rcu_core+0x50a/0x1850
  Last potentially related work creation:
   __call_rcu_common.constprop.0+0x71/0xa10
   afs_put_server+0x213/0x2b0

Preserve old->addresses for the peer app-data update so that removed
peers are cleared before the endpoint state is replaced.  Also advance
both cursors when the old and new lists share a peer; activating the
old/new comparison without this would otherwise loop forever on the
shared entry.

Fixes: 40e8b52fe8c8 ("afs: Use the per-peer app data provided by rxrpc")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Qi Zhang <marsy12010123@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/afs/addr_list.c | 5 ++++-
 fs/afs/fs_probe.c  | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 63bf096b721a..73195d76b481 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -394,8 +394,11 @@ void afs_set_peer_appdata(struct afs_server *server,
 		struct rxrpc_peer *pn = new_alist->addrs[n].peer;
 		struct rxrpc_peer *po = old_alist->addrs[o].peer;
 
-		if (pn == po)
+		if (pn == po) {
+			n++;
+			o++;
 			continue;
+		}
 		if (pn < po) {
 			rxrpc_kernel_set_peer_data(pn, data);
 			n++;
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index a91ad1938d07..8c62334dbfe7 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -258,6 +258,7 @@ int afs_fs_probe_fileserver(struct afs_net *net, struct afs_server *server,
 					lockdep_is_held(&server->fs_lock));
 	if (old) {
 		estate->responsive_set = old->responsive_set;
+		old_alist = old->addresses;
 		if (!new_alist)
 			new_alist = old->addresses;
 	}

