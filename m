Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795241901;
	b=hwU5eTNRt4XW9Do3QgHakPjXDvoqEKkeiNIZ6nZHGBHSTtNC/l5mtOsLXrUUwDIYnsp6
	 6HqDwc0Ap4Z5+unf8zJKefv70J2/id+XJGIu5tEvmdKnvY0HftvBgVS2twLdozh/vSlNo
	 40O6dUfQXqXS92K+xmAmTOHfGTWz+wLYiMq2HcUceNqrWwr5s5qPttak6rzIj26r8VBd7
	 UPEMYS2oXBZJNj8cVoDuHASo8vc7hGi2XdLA4HWnROfz87o+1+9Yh/OPtowvbf3+4M+mB
	 glHVF5OGgq1ebD/TWmCQjM7v4qYUxWNYJlqnrJ7UgeqIm1f3YF9rpnLMVpcLqWx+KEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795241901;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cyD+55yTSWllH/V4M00D2aK0PjmiLdG4LzGnKueD4ws=;
	b=sN2YOqQNhF/V3MECLO1DzgrnTQdOdZXmmFdRwJxjuqVCrd1lGxVv/Hixiqvo3G1L2dgJ
	 jt/t+Oe/26xa1fiDwFAzFCcrI1CXikKOn9rsTrN3wCpwX0RUuWB4+yLcWVKvIHFXBOehk
	 xqy9yZh/mRwSD5yK1J86lH9R2u8iev40uHozxW6eMq5n4IYKHklyu2mbww8wkSHaUXWLA
	 2mG80xItu9HAHvNA7i+D0LBqBagvz74l5P2RMpikWNA9MR38mG7nekLMDkj1qd9DlhHd9
	 KQwBFyhguFtZf4poznyxH/BJgyEEGCUKsflCYk9ZhsSu7H3h66F5ilyv8oLgLU/HXKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QH5aCLg3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE03606A335;
	Sat, 21 Nov 2026 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QH5aCLg3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795241901;
	b=AHiX2/wk3Nb+TIyam0cqcr2EcKaWiGS7AzxSb/BgtAKzFOTepwOWZqN/YN6MnA07rsXr
	 SivtAJUOOLvsogiwe3Hyq9qZz4E1uN7PkKZSwNkh8PaNFyHWPEUW4LtCQFGCbiZCxzTqs
	 qBIA4PkslsSBUXjgBxn7w2W967c92IhVIJkw6Dmh/E23sMAx8Jq1/qtX+FNCOFHTiEqax
	 QFmKUs/v7EVlEQKr9ta3eD4tH63O0jxUxbMHrh08LSYA8c5ZmswjzWkKFIzDL45CJxx+o
	 keFLccVTx2jLAiSiAda47iCiGUPkKdJQmqvYqDso8jxz+dumfHrZZWholuCPABuL8Xw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795241901;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cyD+55yTSWllH/V4M00D2aK0PjmiLdG4LzGnKueD4ws=;
	b=CXNARAyr6iwhsQvAKMzVCGuG+lX++7WPtUhOSLcevEemcX05PmUyXyNxM43Fod4v9eFS
	 dg9lvMPqhKbOe+jHgIiBO3tuskykHPSruA6wIsOkWNcR5j8mVHJOoJOdva+EOmM3EJPgE
	 6DcFjm3onMtCuq5+/Z+elT49/tWHekX/BYODvy0ydgC/LwUK7/FwldTbNNzrbT2RZAffk
	 pMBayB2B7IPO/0s3eaP7JZnnTNiIE6eH+YZ8owUjeRkQYFdWsEkwdcaouoKgQF9yp0rA2
	 i246JRvF2eDgk9+bFyr/20EtHkPA30gEPtyyIqSfJvg8JkiSM+3VwOudHlHZqEsJ2wQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7BE541F000C4;
	Sat, 21 Nov 2026 06:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795241901;
	bh=cyD+55yTSWllH/V4M00D2aK0PjmiLdG4LzGnKueD4ws=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QH5aCLg3fSc99xnpitG9jJMs7OS/UV0wTnWeE1Up/N1gqEQJBI8t+3b27CGlRRxud
	 2KSW4HbqFpdjsAMQPFsGuKN7Rt5w9mm/ERO49fnCY/b7tG4tRoFBUixODxodae7bJ+
	 UgPEIxFPro7eisLXWs5BHwzXaPQXkoWURv9lkF/n/ywf+MDRnEGpauEEX1bp73kpgm
	 pFuVbVz6CC4tvauIN8oLW/W7J4FNJ4LdTAGlzpKbqMPcvK2lmnA5phpntXAvOXg3jQ
	 M4w7r1riDmFdTzrpM4+e/kXk1DscHTzbGU8sPWutZfL0HtJGsRlWwZ034BKGVRR94C
	 zvHl11C09d15Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CEFEA4BB15;
	Sat, 21 Nov 2026 06:18:19 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Sat, 21 Nov 2026 08:18:15 +0200
Subject: [PATCH] ceph: ignore a cap IMPORT peer that names the importing
 MDS
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-b4-ceph-cap-import-self-peer-v1-1-9cbc14a6c8b7@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAwA0F8ZORtoO1Hmr4iHNaYuoltINhHG/
 t2qx3d5KzibsMOpWcH4JS7TWBF3DdDQjzdGuVZDCukQYwqY90isA1KvKE+dbEbnR0FlNqTUhtg
 dc1u6BLVQ4yLvX3++/O1LvjPN3xO27QOEUZxBgAAAAA==
X-Change-ID: 20261120-b4-ceph-cap-import-self-peer-c230197b3f92
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, stable@vger.kernel.org, security@kernel.org, 
 Quinn Grant <leograntquinn@gmail.com>, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795241898; l=3029;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=/3Lg5v/cOBVmlJ+Hh/ywgxHY68XitXvI31NKdYtN2P0=;
 b=Xrn1wuHrIpn8W8Cq4p1Heqk4JkoHGwrmCkFXb7IcicSv78cp+r1y90vhRJHPFn6ERr+ThxF0U
 /w6nxw8hzwlDpMF6NwjkKf6oFcWKRrt/fF6te/4NTCxV8le9LWGUcQa
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

handle_cap_import() first adds or updates the importing MDS's cap,
then looks up the export peer's cap with __get_cap_for_mds() and
removes it.  The caps rbtree holds one cap per MDS, so when the peer
rank in the IMPORT is the sending MDS itself and the peer cap_id is
the imported cap_id, the "export" cap is the very cap that was just
added: ceph_remove_cap() puts it, and handle_cap_import() still hands
it back to ceph_handle_caps(), which passes it to handle_cap_grant().
That then writes the freed cap (KASAN: slab-use-after-free in
handle_cap_grant()).

A cap is always moved from one MDS to another, so a real MDS never
sends such a peer; only a broken or malicious one can.  Warn and treat
the IMPORT as having no export peer.

Fixes: 2cd698be9a3d ("ceph: handle cap import atomically")
Cc: stable@vger.kernel.org
Reported-by: Quinn Grant <leograntquinn@gmail.com>
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
A buggy or malicious MDS can send a cap IMPORT whose export peer is the
sending MDS itself, with the peer cap_id equal to the imported cap_id.
handle_cap_import() then removes, and frees, the very cap it has just
added, and handle_cap_grant() goes on to use it.  This patch ignores
such a peer.

Tested on a KASAN kernel, with a test-only hook that turns an MDS cap
REVOKE into an IMPORT whose peer is the sending MDS (the cap pool was
filled to its retention limit first, so the put really frees):
 - without the patch: KASAN reports a slab-use-after-free in
   handle_cap_grant() on the ceph_cap freed by ceph_remove_cap(); the
   client loses the cap and the other client's write waits for the
   revoke forever
 - with the patch: the peer is ignored with a warning, the revoke
   completes, and two-client read/write ping-pong and umount work with
   no KASAN or lockdep reports
---
 fs/ceph/caps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 3f4ac4d94d5b..ac780fdfaeb7 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4652,6 +4652,21 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 		peer = -1;
 	}
 
+	/*
+	 * A cap moves from the exporting MDS to the importing one, so the
+	 * export peer can never be the MDS that sends the IMPORT.  Caps are
+	 * kept one per MDS, so a peer naming the sender itself would make
+	 * the export cap removed below the very cap this IMPORT adds or
+	 * updates, and handle_cap_grant() would then write the freed cap.
+	 */
+	if (peer == mds) {
+		pr_warn_ratelimited_client(cl,
+			"%llx.%llx mds%d names itself as cap export peer, ignoring it\n",
+			ceph_vinop(inode), mds);
+		p_cap_id = 0;
+		peer = -1;
+	}
+
 	boutc(cl, " cap %llx.%llx import from peer %d piseq %u pmseq %u\n",
 	      ceph_vinop(inode), peer, piseq, pmseq);
 retry:

---
base-commit: 6a9830a8f414d3830c584782568d0233be969d09
change-id: 20261120-b4-ceph-cap-import-self-peer-c230197b3f92

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


