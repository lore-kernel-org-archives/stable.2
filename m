Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DC388E59
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956184; cv=none; b=u2Bc2f73t8y+iv26yQJd58i+IZtAWipk7oiittsCP29/YR+UhHtmqwyswW63HrNmPij2grFFbY4PoglezXZX8XruHDmrvBAp6dT8VwM2N+GGFGVTga/BNCyZysrGWmCuAmev8rdpJK0xCx36eZGoeE7APLe/rIthVo4Jgs8lv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956184; c=relaxed/simple;
	bh=pxO70Oc/7Mk7MUgfChs5VC7q9aAXUGXyF0rwI8TudCM=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=gHQgf37hZXHMbJ9ziuMkqcSZg0UO1ESChNMyTA+9+yDajQPJS3bjGhHg7xMYDlAVTNoc4uy/xRX+0j32mHBTmGx1FSCicavpRXAXCQV+Ub0lsCXPMTrXNl7VANWYwc0G5YQm/oXF1mp2nAi19YkjyxhukstspmPTfsZ9FmlJ67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQNMR5ST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQNMR5ST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783956181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRJR2hCY2tQVI4Mc4/g5ZA+qJMCDSGcRxieL1eYGlyg=;
	b=JQNMR5ST4AaaiIlPNj8Ou8ZthURPqwjGyz7ecnG7BkGlnTLtl5bEH35+w1E5NGAEoac5XO
	0mB2q0pUBB4gbVNsj0RtgLIyLVDH+VoppNilEyYDSIDVSWKhhqUOTGoUNytxd0nMkyMivH
	hxrO81hKqm++8iT91CzmWzhDkduyCSk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-4riqNSTHM2ONXUBjMHQeZA-1; Mon,
 13 Jul 2026 11:23:00 -0400
X-MC-Unique: 4riqNSTHM2ONXUBjMHQeZA-1
X-Mimecast-MFC-AGG-ID: 4riqNSTHM2ONXUBjMHQeZA_1783956178
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 565541956096;
	Mon, 13 Jul 2026 15:22:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53017180067D;
	Mon, 13 Jul 2026 15:22:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix afs_edit_dir_remove() to get, not find, block 0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2380758.1783956175.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:22:55 +0100
Message-ID: <2380759.1783956175@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix afs_edit_dir_remove() to use afs_dir_get_block() to get block 0 rather
than afs_dir_find_block() as the latter caches the found block in the
afs_dir_iter and may[*] switch out the page it's on if another
afs_dir_find_block() is done.  This parallels what afs_edit_dir_add() does=
.

[*] There's more than one block per page.

Fixes: a5b5beebcf96 ("afs: Use the contained hashtable to search a directo=
ry")
Closes: https://sashiko.dev/#/patchset/20260706153408.1231650-1-dhowells%4=
0redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
---
 fs/afs/dir_edit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index b3e80c5c434f..01c6265e8865 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -411,7 +411,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	if (!afs_dir_init_iter(&iter, name))
 		return;
 =

-	meta =3D afs_dir_find_block(&iter, 0);
+	meta =3D afs_dir_get_block(&iter, 0);
 	if (!meta)
 		return;
 =

