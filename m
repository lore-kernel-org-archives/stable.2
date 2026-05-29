Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE23B635B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097610; cv=none; b=NdWLu4Uto2qw7ge76N00SeEkw2sbMWEt749KqXif7LSMagGJ1PdImcQ91j+ecjG1XfIuvqrBCt4zQVzhaqEIxcTLTBAGgFqMUSlDdBkckTlhVkRDptR13zHnfue7G5+XQdxlzD0kMhS+IEeX8r2npUuR1jXDTA8afyvHoim3TDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097610; c=relaxed/simple;
	bh=wW7U8pjvNLCogfsTF31JpYjCnHPEDsJNjqr0nve1u20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B61uNKbNfVOekOD6+n1WPZMvuegtaZjhQGYopPwJVIaT38h3cXXC6d1ifH8rszCnsWOF55Q0ZAlzX6e3VbdaQyE0ZqfuE1lpuYkYTak6iPTPR3FR+TEmuvqyuajDi+dX19i36MXMsWgaRx9MqfTw2TmAlYTWfVff0HpHg3w9vrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzVjB4tU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzVjB4tU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03971F00899;
	Fri, 29 May 2026 23:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097608;
	bh=N4uhUikO13T8zmSXuJfL24ns1Sg7o6hA1SZ02WYtkis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lzVjB4tUV1yABb/3A4pOUaLvE3G2r8IRqW0VFsGBCpIl28s/2a9mPibPOTtzsniz0
	 zlV7nPyklWEkAWi7bey+FihiJYKfkxkyyItkhUjJEb9Pi5svCqzVG0k6L5w7yKh96H
	 fvSplD+8elM5VX2/JQMXUMIfz8ljriESKlfLoSz7zMljpva742MjbLFU5zRuZ+SD58
	 4MiBhCEcaAzDTzL5zQR74rPLQ6Ms+x68ZcNsnf4+F2VHiirIuL1IKJsw8h8bJaT95d
	 qq2KEZPPQy2JX5MZeDYki32nvZAUr6wJGHzBVLmEgPutE+3RbQLvOlY2Ncvzf8clVC
	 vjltK62PPtSow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] qed: fix double free in qed_cxt_tables_alloc()
Date: Fri, 29 May 2026 19:33:25 -0400
Message-ID: <20260529233325.1901920-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529233325.1901920-1-sashal@kernel.org>
References: <2026052809-snowfall-thermos-6a66@gregkh>
 <20260529233325.1901920-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

[ Upstream commit 2bccfb8476ca5f3548afbd623dc7a6980d4e77de ]

If one of the later PF or VF CID bitmap allocations fails,
qed_cid_map_alloc() jumps to cid_map_fail and frees the previously
allocated CID bitmaps before returning an error. qed_cxt_tables_alloc()
then calls qed_cxt_mngr_free(), which invokes qed_cid_map_free()
again.

Fix this by setting each CID bitmap pointer to NULL after bitmap_free()
to avoid double free.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime reproduction was not attempted because exercising the failing
allocation path requires device-specific setup.

Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Link: https://patch.msgid.link/20260520070323.2762379-1-dawei.feng@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 8fc8f428266a9..2585d36b94f2f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1038,11 +1038,13 @@ static void qed_cid_map_free(struct qed_hwfn *p_hwfn)
 
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
 		bitmap_free(p_mngr->acquired[type].cid_map);
+		p_mngr->acquired[type].cid_map = NULL;
 		p_mngr->acquired[type].max_count = 0;
 		p_mngr->acquired[type].start_cid = 0;
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
 			bitmap_free(p_mngr->acquired_vf[type][vf].cid_map);
+			p_mngr->acquired_vf[type][vf].cid_map = NULL;
 			p_mngr->acquired_vf[type][vf].max_count = 0;
 			p_mngr->acquired_vf[type][vf].start_cid = 0;
 		}
-- 
2.53.0

