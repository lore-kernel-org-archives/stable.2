Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795371590;
	b=rj6x3fTqZc+jUOAuACcWLkV9xVTcmL7a6YPCTzv7fpj8szQLycE02m9pDZnzb3tkna+P
	 KcGlFANxhKnYMVvjBKPutp1Ope28/LyYg+A7JB81gNP8uLnk6MaGE9gBAKAar1SZaFJql
	 q651/FSf/vwcThXv5NIitSdCpZlOccEm59a+o0Tu9qRi732SONCGXdjiM8lF1ePmAtacL
	 X4n8Py4kcJBl0KTKZiq7/1uCsIqlSqrk5IMOD+iZTPTtcVi7OEhW8hpSeJFa8IEjjxKvb
	 oj8PtPQGI6pvX3VJUqu4P0Uwfxmlw7QnGwIpf8wVVpgij7C5JY+CPn/2hzn8lxpUZeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371590;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+RidziUgx+kZM9EX+B/idvPdGe7SZT8gd5HysQwlsX0=;
	b=Tl/3aaTY2ZVqBtxYxHyPkYb4YYzBQmQC6VufT0948iqkbAUPP4n8QVZZFzlkAwlSMJEX
	 FKRaOBnBibbf33teqpEs+A86AvJRoyGhRnM2LjRTljRnuSKMdsBDcjiMwyuwFApDnG0hd
	 dPAcOr4n0Cq++zgyKMa/Uz8omiLNZpOtoiG2JoKKpoMehut87cF1wfFvBR/3Me8Pqzv2F
	 NDqu7dDYhuAfFhPFZ0Ac8oXimtHroqAXnnvZpFk0jVkYxpHbT+uHYLMrh3s2wv4y2rKUk
	 qYJamyECWg1PCyclCVo0k3eVw4XHaLXBRRxqDqU+6sS1+537qzB0q+yAIhcIrEgaRzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX1D3YJd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046E606A32A;
	Sun, 22 Nov 2026 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX1D3YJd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795371590;
	b=L3yAq7lGfsCjiRwTHSBNAOi+FduQfX5nmasEj+MQMY3PLdiBChSueqwTLycMb3+0SQGW
	 jiZUVeaQnWHmwDnm4ljWb6ggO6xx8u7U7l3Q/rhQaTOO9pUxgvSpgVBLB6EXQJVR3W76l
	 8OKSxtHdL2FZpQHY8CQIJHPK7q6n4ILvnZNjRFaJbtR5wUIAtWIa+UP5leGJSDF1DCPJC
	 aGiGX+jmZBY6YaD72d1DA4/nZ+W5BKwdn/xIK+7yl3tJcADQrKz2IfUxnSt61HPRFCL6D
	 yQMP7FOnBytnqN+7412lx057OyyL7Co2KcsPvIJCABf040bNHvWGN02S5Ooy19x57rA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795371590;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+RidziUgx+kZM9EX+B/idvPdGe7SZT8gd5HysQwlsX0=;
	b=FN2Z4otKNNH4LFhHwvg7fU+pM4U1GEVkFBnV6QxxuBIEfrPegEpFtAnVyl5eV1yHu7Zk
	 U3phW5YI6Sj//D+OSA1Rsg3qHv9H8ZmOWufr7sLu1a1H/O6kG3dVSM+Z6kfv7tOZjkr1h
	 XALGaiD18ZgiMe0BOR1TknEaSh+bGbA8BBJj4AxsNwibkqHNCVzViJrF/mjEkj3p1XcUt
	 i0WWzBWsIK5JMOIDS+47QzO/Fczc8NIgzVNCU/bQbsmD/onhjYQNKDHI5As8SDggRBPNr
	 YUOta00J83IPzngz/agf2pEk/XOSfGohKjjFcEXa/6rtHSqJ3eSBnFjjODlvRIVJNfA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 288F41F000CF;
	Sun, 22 Nov 2026 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371590;
	bh=+RidziUgx+kZM9EX+B/idvPdGe7SZT8gd5HysQwlsX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BX1D3YJddSEKJFDUn21cUQCN3anLtAntRJRcR8gGT8K8clc1vmYFZudattZpUwJ1L
	 qmxLIC17TWD6Qjd7gTlMNAOImWTnnYDKi2kzq4qF3t7knF3tmBtdLcMsixu8TfVPXP
	 lbfEsdM5eqQlglTxJ910hqwwheGhxDdwdIBYWe3r1zZwRYapkZZlmA3oj8qpVw8K62
	 KO4fcW+p+wW2nljj9fS92zI7YG0Pj9U5aRWBm/Jt5cwkyjyebkz1mKqsSqZQhIyYH0
	 wJYKj0QJMmEKP384k2xBYcqH989veSqyqAm2J7SoceOCplsBZYjkHOj+RILJElBKLR
	 vDEDBDDX+Vd0g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA3424C17C;
	Sun, 22 Nov 2026 18:19:38 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Sun, 22 Nov 2026 19:19:38 +0100
Subject: [PATCH 2/7] ntfs: do not consume delalloc reservations when
 filling holes
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
Message-Id: <20261122-b4-ntfs-delalloc-fixes-v1-2-0726f0dce403@proton.me>
References: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
In-Reply-To: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
 Baolin Liu <liubaolin12138@163.com>
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=+jVS4i0N2xYWTOmK5KLBxioqsjuDV8wLrjNVc80eqAM=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmxmIwt55rhdurzxrz5tubPox/O0O+5M5zdeyJpQfz9M7
 FNd+7zrHaUsDGJcDLJiiiwd/2+E+IR8+7QsTqsPZg4rE8gQBi5OAZhI03dGhtOTlRlXSpYckT2g
 sfrTxb6/C2zKv/sfWHZSQHrnk/PzPpcxMqw7sIilTmnpljWeVzZJJn/uL/qVk7VOg+NATPDkpCX
 zd/ABAA==
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

ntfs_attr_map_cluster() always calls ntfs_cluster_alloc() with
is_dealloc set, which makes the allocator skip the dirty_clusters check
and subtract the allocated clusters from vol->dirty_clusters.  That is
right for writeback converting an LCN_DELALLOC run, whose clusters were
reserved by the buffered write, but ntfs_attr_map_cluster() also fills
plain holes for fallocate(), direct I/O and page_mkwrite(), which never
reserved anything.  Those allocations release reservations that belong
to dirty data of other files, and can use clusters that are promised to
that data, so writeback of the delayed data can later run out of space
although every earlier check succeeded.

Reproducer: write 1 MiB to file A without syncing (statfs() free space
drops by 256 clusters), then fallocate() 1 MiB on file B: free space
does not drop at all.

Only treat the allocation as consuming a reservation when the run being
filled is a delalloc run.  Filling a hole now fails with ENOSPC when the
remaining free clusters are all reserved for delayed data, so a write
fault into a hole of an mmap()ed file gets SIGBUS in that case, as on
other filesystems with delayed allocation.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 fs/ntfs/attrib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 4028c310fc..cdac846f37 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5520,8 +5520,14 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
 		}
 	}
 
+	/*
+	 * Only a delayed-allocation run holds a reservation in
+	 * vol->dirty_clusters for the allocator to consume.  Holes filled by
+	 * fallocate(), direct I/O or page_mkwrite() have none and must leave
+	 * the reservations of other writers alone.
+	 */
 	rlc = ntfs_cluster_alloc(vol, vcn, clu_count, lcn_seek_from, DATA_ZONE,
-			false, true, true);
+			false, true, lcn == LCN_DELALLOC);
 	if (IS_ERR(rlc)) {
 		err = PTR_ERR(rlc);
 		goto out;

-- 
2.56.1


