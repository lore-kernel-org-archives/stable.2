Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793318963;
	b=gbvSwOAkoFzcxtlmnjDyrVb4olSH0mPsQfBYV3EFii9P8MEwvYjEEwBnQRRF57S0Z0QW
	 xBwEsQqc9b6gRQzTLC76uiFxdCtz95tpUwAixSXxz2YV/8JEp8a238Pq2GM7/DeHkoKlU
	 jSOAd9+1MqScozBU/nnAYB8b1oa4a7ygc9Ev/OSHiuD9sUJUE9OepG5Esvpn5g/F4e6Qg
	 s1V3H4qQGCuge7PSlf7UvHq2Puhe9CNyD33rliyd8Ww66Pma8+qNWLcWivVxP1RsAmieB
	 5By+TmSdnG7bE5v3/25Nh6CJEDVJnm+nFQL+mfBa6vPrEIMQF2qUIeYsiBeiwvg1Iqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793318963;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PRp80+j4dxgVQreDUCFVgZ0Tk5+EyF6uJ/o0IBrBiaE=;
	b=s9+U1bZ7yoG/LYx1OXanh/lCYpO85VlaGaKwsSuP0kQBCcjYBJun8tGXPYAQ4B7DwSQC
	 O2kR0SuCKtwcacikuBvHOaLdTuRa7yOmbiWPsfwPhztSQCsnViXkYDvTqgc9g3KNRrcV3
	 dsBIVxCnU/SVjpfZF6H+vEYjbKKic+B648Olb5sbF2e3u5k9EzokI+Ahg1foxb4hU3PaB
	 1/WpflObNXczQ2LMKDieS1+E1voz5G+e4td7rbSS3ABzqU0lCavEHjRiyHN/fR4HmxcbW
	 mG+K39tLdeKDp/3/8s8U6GHiEtt5ZC5yFpT6bGSS1LVPnKA3HCTN5q5SxeokPzXELKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm98C7WO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BD606A32F;
	Fri, 30 Oct 2026 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm98C7WO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793318963;
	b=ZwcBaW5K2yTw1/AKBb19CRGe4eqrq/+GOTRYatPDh2TUh/bpfJbOFa5rVKFgPHa22efp
	 NdIDZgv9i47pm8dd0fXD5bWdw76AGYDm6wUiuSpjQZj4TjXBdb/xXAjemwlslbtAx08Dw
	 YCqWfI6moMCduhOEuGE5If3ISWnx1lMRT60XEfJryldbzPrjb2pO2lZtBfRM2zXOhwMRn
	 R1oNXi0IKtaumPGyiFyXiv1MjOTXStJBBZy6vLhlLjmXVccJPI22qxaab0hjbUxMrGVcp
	 3jDLJakns9CLQwydoEefX/ZWHeYII/Qz4ovPRApwKiR5mo8197Y0uEH1vf5lLiy1ckg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793318963;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PRp80+j4dxgVQreDUCFVgZ0Tk5+EyF6uJ/o0IBrBiaE=;
	b=f6RVkhtbT8CsIST9xhxIxh07fiOe2uOlmIUMEBPgIMB/GXLz2D7N1nbp431KArUlCz0B
	 90Pcw9ju42Fl/WZYP2MaHPlrFsnVKt2mD35qwTwPFyLDiAjMQviV35uXTffhFRxgc+qzM
	 cNP+tClLOy/96JzaJiMDtY0gM3bsFJ+XECo8Rn7w5SJlq3+70094NtmcfgqUhl68AnrjA
	 pUUpYtcd7IB3fQVZZjJAhNCBvOYq7HCmlpGooFRRZtvqCFMprUtmLlrxWNC/48HHqZ9pe
	 k8+qtvuL/SS6IHuBXLzG4laILrlBpbjpsA9GHOl8WSiY7WXcHbjM+2Sd4E3v9OgL6Tg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 042081F00A17;
	Fri, 30 Oct 2026 00:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793318963;
	bh=PRp80+j4dxgVQreDUCFVgZ0Tk5+EyF6uJ/o0IBrBiaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Fm98C7WOBFPUuzS+Srb1lOwkQw5xScihv6b89p/2e0kuQfpZhflkcyeeTK1mI9tpD
	 HuHUJSg8qtjaRHveWpZ4hfoStMTYhV7cTlTSCqlpP6uPWZUddYpQ3Qljhdkh49CB3B
	 3XkdPNe3OfzrW+wpgc4CW5cfiPZJCgYj06ryeF5XcKdzxbxttZ5AEmcpAufxxWXFGY
	 fw5VoG15cBvVpf53oZ2jPfM8xawCaVNI/6K6xbB82xZwXEGHnlRyqiiR9H+YOAmUCf
	 Ry431Rg9w3CNJUysE46EhJPlIzvjp/m/TYvmD3S5EVlyV0Y3CLNHAfdCR5bHkEbDEd
	 qkv592TWug3UA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ACD5341E17;
	Fri, 30 Oct 2026 00:09:20 +0000 (UTC)
From: Kamil Chojnowski via B4 Relay <devnull+contact.diath.net@kernel.org>
Date: Fri, 30 Oct 2026 01:08:15 +0100
Subject: [PATCH 6/6] fs/ntfs3: do not reallocate clusters of a partly
 allocated sparse frame
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
Message-Id: <20261030-ntfs3-resident-fixes-v1-6-7b6c857d4330@diath.net>
References: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
In-Reply-To: <20261030-ntfs3-resident-fixes-v1-0-7b6c857d4330@diath.net>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Kamil Chojnowski <contact@diath.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793318890; l=3450;
 i=contact@diath.net; s=20261029; h=from:subject:message-id;
 bh=sBOCx5FVq+GEhbTfofjJvzmOyg91nklfg6iIoMV954k=;
 b=1WWAgWrv1PGYmoA43+pGreW65PTmI8ysXLTMnlFYoa6qSwH2UCP9yNJfJfIS9mIi0GHDz5DgE
 prDKNmz4m4CAgDhR7DALUv9f3tuv0EHtQKoWjebRsHeW88523TejvpA
X-Developer-Key: i=contact@diath.net; a=ed25519;
 pk=G15RQXroUn6f8ud+bOEqlqpPdpLoCB3L3G9XVUf+YaA=
X-Endpoint-Received: by B4 Relay for contact@diath.net/20261029 with
 auth_id=1360
X-Original-From: Kamil Chojnowski <contact@diath.net>
Reply-To: contact@diath.net
Content-Transfer-Encoding: 7bit

From: Kamil Chojnowski <contact@diath.net>

For a sparse or compressed attribute with a compression unit,
attr_data_get_block_locked() fills a hole by allocating the whole frame
around it (16 clusters for c_unit 4), assuming a frame is either fully
allocated or fully sparse.  ntfs.sys keeps it that way, but ntfs-3g
allocates sparse files cluster by cluster: it marks them sparse with
c_unit 4 and leaves holes of any length at any offset.  Linker output
written through ntfs-3g looks like that.

When such a hole starts or ends inside a frame, attr_allocate_clusters()
maps new, zeroed clusters over the clusters the frame already has:

 - the data in those clusters is silently replaced with zeros;
 - the old clusters stay marked in use but are no longer referenced;
 - total_size grows by the whole frame, although only the hole was new.

Once total_size exceeds alloc_size, mi_enum_attr() rejects the record:
the inode goes bad and the volume is marked dirty.

  ntfs3(vda): ino=40, "pwrite" mi_enum_attr
  ntfs3(vda): Mark volume as dirty due to NTFS errors
  ntfs3(vda): ino=40, "pwrite" attr_set_size_ex

Shrink the frame aligned range to the sparse run around the requested
cluster, so that only the hole is allocated.  Frames that are entirely
sparse, and so all frames of files written by ntfs.sys or ntfs3, are
allocated as before.

Reproducer: in a file that ntfs-3g left with a two-cluster hole in the
middle of a frame, pwrite(2) 4 KiB into the hole.  Before this patch 14
clusters of data around it read back as zeros and the file uses 16 more
clusters; after it, only the two hole clusters are allocated.

Fixes: be71b5cba2e6 ("fs/ntfs3: Add attrib operations")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Kamil Chojnowski <contact@diath.net>
---
 fs/ntfs3/attrib.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index b21c913050f7..1bd05639709b 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1032,6 +1032,33 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	return err;
 }
 
+/*
+ * attr_frame_hole - Limit a frame aligned allocation to the hole at @vcn0.
+ *
+ * ntfs.sys allocates sparse and compressed attributes in whole frames, but
+ * ntfs-3g allocates sparse files cluster by cluster, so a frame can be partly
+ * allocated.  Its allocated clusters hold data and must not be allocated
+ * again: shrink [*vcn, *vcn + *to_alloc) to the sparse run around @vcn0.
+ */
+static void attr_frame_hole(const struct runs_tree *run, CLST vcn0, CLST *vcn,
+			    CLST *to_alloc)
+{
+	CLST start = vcn0, end = *vcn + *to_alloc;
+	CLST lcn, len;
+
+	while (start > *vcn &&
+	       run_lookup_entry(run, start - 1, &lcn, NULL, NULL) &&
+	       lcn == SPARSE_LCN)
+		start--;
+
+	if (run_lookup_entry(run, vcn0, &lcn, &len, NULL) &&
+	    lcn == SPARSE_LCN && vcn0 + len < end)
+		end = vcn0 + len;
+
+	*vcn = start;
+	*to_alloc = end - start;
+}
+
 /*
  * attr_data_get_block_locked - Helper for attr_data_get_block.
  */
@@ -1195,6 +1222,7 @@ again:
 		/* Get frame aligned vcn and to_alloc. */
 		vcn = vcn0 & cmask;
 		to_alloc = ((vcn0 + clen + clst_per_frame - 1) & cmask) - vcn;
+		attr_frame_hole(run, vcn0, &vcn, &to_alloc);
 		if (fr < clst_per_frame)
 			fr = clst_per_frame;
 		if (vcn != vcn0 || clen < to_alloc)

-- 
2.56.0


