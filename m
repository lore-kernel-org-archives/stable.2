Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36253DBD7C
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993087; cv=none; b=WzuRSBzXKRtVx9AHVI5Mq/VFQK+3AQ0rx5aryvpOugfy4Z5+1W/er1m9EKQ5piDEMwGUZSydYN3hVlMeWm6XfIqxtK/7bdUgVr0uTOq0Qun0t0nIUVCSbGHTAWrPWnPhveG7KOBa7uNhOXlRDkFMYmLJmpc4IcCqgMWLSOyUIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993087; c=relaxed/simple;
	bh=zD16fMf0ZMJoNAbDkUkjkvBtlSpglsJNvNSt8JU7lxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdR+G/6ecwlCWr9XWRO4REuyIkTuiz332Jmp3hUHnzobPb9uEeo/ABTN+rWgaQsgfKlSzuupScIQFwYWbC8hyNIzWG4U7n1745buPP88+Coj6ZkutIrfemAijpJa4DIsP6MZjeuTKmK/a8xMEo6DVHk2PWxVB63760oFcbPWM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtVF/OiE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtVF/OiE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780993084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfHVYwJjeckBljNNeVdi/xVk7ybji0LvQllDM/zHzBw=;
	b=gtVF/OiEMbpCy0oANnkOO9lMnJJ0IG0A+tsrQtgN77uJsoozrWqrI6DBqat/BaYfIfeRih
	basW+jVmXtBsQ2u2xb+2br/enIQrTOppnbdsWP9tE9GQCYKIyUrmw/lHCMBq4gOwy0Egdm
	1X8eXNr1WF8BzA35TheUgoJrvCTsehE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-xOqMg-HQMy6SGSJ0qbmXoQ-1; Tue,
 09 Jun 2026 04:18:01 -0400
X-MC-Unique: xOqMg-HQMy6SGSJ0qbmXoQ-1
X-Mimecast-MFC-AGG-ID: xOqMg-HQMy6SGSJ0qbmXoQ_1780993080
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A16A71944DDF;
	Tue,  9 Jun 2026 08:17:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B032D3008B35;
	Tue,  9 Jun 2026 08:17:56 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matvey Kovalev <matvey.kovalev@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH 3/7] afs: fix NULL pointer dereference in afs_get_tree()
Date: Tue,  9 Jun 2026 09:17:33 +0100
Message-ID: <20260609081738.770127-4-dhowells@redhat.com>
In-Reply-To: <20260609081738.770127-1-dhowells@redhat.com>
References: <20260609081738.770127-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Matvey Kovalev <matvey.kovalev@ispras.ru>

afs_alloc_sbi() uses kzalloc for memory allocation. And, if
ctx->dyn_root is not null, as->cell and as->volume are null.
In trace_afs_get_tree() they are dereferenced.

KASAN error message:

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 2 PID: 18478 Comm: syz-executor.7 Not tainted 5.10.246-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1
04/01/2014
RIP: 0010:perf_trace_afs_get_tree+0x1d9/0x550
include/trace/events/afs.h:1365

Call Trace:
trace_afs_get_tree include/trace/events/afs.h:1365 [inline]
afs_get_tree+0x922/0x1350 fs/afs/super.c:599
vfs_get_tree+0x8e/0x300 fs/super.c:1572
do_new_mount fs/namespace.c:3011 [inline]
path_mount+0x14a5/0x2220 fs/namespace.c:3341
do_mount fs/namespace.c:3354 [inline]
__do_sys_mount fs/namespace.c:3562 [inline]
__se_sys_mount fs/namespace.c:3539 [inline]
__x64_sys_mount+0x283/0x300 fs/namespace.c:3539
 do_syscall_64+0x33/0x50 arch/x86/entry/common.c:46
entry_SYSCALL_64_after_hwframe+0x67/0xd1

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 80548b03991f5 ("afs: Add more tracepoints")
Cc: stable@vger.kernel.org
Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 942f3e9800d7..dec091e569c4 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -587,7 +587,8 @@ static int afs_get_tree(struct fs_context *fc)
 	}
 
 	fc->root = dget(sb->s_root);
-	trace_afs_get_tree(as->cell, as->volume);
+	if (!ctx->dyn_root)
+		trace_afs_get_tree(as->cell, as->volume);
 	_leave(" = 0 [%p]", sb);
 	return 0;
 

