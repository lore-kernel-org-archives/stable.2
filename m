Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.11.79.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841225;
	b=UiMmRTo34SeGWQ/K5b0TefFyAfHM67XYDFdkL/u8FZpeVaDkw2ynYGzX6/1nT7hxdKfu
	 Tg+sNX4eRt4x51PQbaf1jh3COLpOv6msWVwAFdtqYkquDGU149Yr8KhnogFQpuH3cv+Vr
	 P18QfocSoHCDzIsYQWdrdN852H8L+1hdSRZ5mw8Tqp9uctKDZZ6CYmE4aFWm8fnW4KB1z
	 +k3P3Sd7niyzLnb4C3vaTYQ9wtfCZsclFZMTiW/i0nFCM8tmKZXC+dTnEc5eBYA4PoBlv
	 4LYPzGgE2HDp+ue3Yo0a5gzAHeSRUaU7/+T1AFz/1/PR1/XOd6eWk5lnbwtAHUzHDcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841225;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-Mailer-Info:Subject:
	 From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:
	 Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J1ePy/7DtRjSH/7YiNDxqRZYlYA7Rkm9Xz1sKnQwiPM=;
	b=5VUr+YRnxztykNBKvLViDGMqCbq+SybYPkbi+GFRB33YovNpwL28o0nJ5CUz8+8c+UWf
	 jpydT5oo7zTomWqg7+QyPCCLNOC9DDvN8TEbal8ICgwvm5fh5g8JN3B8l7ZX2pSkp4m7G
	 49EukCjx6J/4sCHpiKuCFcfrsMbH16JvGjoOWqGbyfAFfOmk2X9r7pKnofrVr08Nkt+ag
	 j9fXMDsXZj2kOw8Jm4XgiyL6k4x949TjsZTZoqIwdO00HhXz4h9Yw7Nf+gmI8YQQ0gqno
	 gyW8KtD7myitV/jce2cIg2G2nLQMwUPAmc5LkKjyAdopmMnInm00SFH48dbBfAkLeWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hatchling.org;
	spf=pass smtp.mailfrom=mta.hatchling.org;
	dkim=pass header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=rubWqIAz;
	dkim=pass header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=bM3IyCUx;
	arc=none smtp.remote-ip=212.11.79.133
Received: from mail133.mailersend.net (mail133.mailersend.net [212.11.79.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73F606A31F
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D73F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hatchling.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mta.hatchling.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=rubWqIAz;
	dkim=pass (2048-bit key, unprotected) header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=bM3IyCUx
DKIM-Signature: a=rsa-sha256; bh=J1ePy/7DtRjSH/7YiNDxqRZYlYA7Rkm9Xz1sKnQwiPM=;
 c=relaxed/relaxed; d=hatchling.org;
 h=DKIM-Signature:X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=mlsend2; t=1792841212; v=1;
 b=rubWqIAzyHZRcrfOqV9Hn2AwClEGuB5FLNa8pVkxjHo2AWK+ncCASObO2NwKt85sHVGa48+z
 HIvHjFjj+TMcFdFOR8V4X57yxGkTY1j6uz2Er2yNquLIleMfm8bJgCyIds3nn/L4feREFJ1UJ4p
 MizL9+6EoimM/BQXFMFbj2Qg=
DKIM-Signature: a=rsa-sha256; bh=J1ePy/7DtRjSH/7YiNDxqRZYlYA7Rkm9Xz1sKnQwiPM=;
 c=relaxed/relaxed; d=mailersend.net;
 h=X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=ms1; t=1792841212; v=1;
 b=bM3IyCUxqcaKU0YJqnyuZltSVbL0G0HaMuoLkZpdaYnmIp9IjpumUYGcdV1K7AaTUsSVhnL+
 KV6qGkx6zDyJtOexZdwN2HVwafhZw19ZgD2RgTpRcZ4KW1v8d06kG4iPBjh9Hp2tFHiGIPFxV1v
 husXjsN8s7RhplUsNVucukWX3nazIKea2fv2cPGzavJzxauJeZt2dwd0yiDzI3+z6hGaj3eDTX3
 vsnzqtN50b2HbQbbkQigM+4NWV0WBIOFLONk6mnDWfC7I0hPMilCejVcycMWkLsdOLuuq41qQ/T
 b8yDDa+WwPqWAeTjVtInayFMe+hkHXGJenHw653DFBwUQ==
X-Mailer-Info: 10.AZlZWY1xGd.AZlZWY1xGd0MTN5UzN.wc0FmYsVGQ2dWZy5yalJnblxmLvJ3
 Z.gNhRGO0YzNlFWMyImZlVGOmRjZkdzMzYzK0MTN5UzN....
Subject: [PATCH] fs/ntfs3: fix SEEK_DATA/SEEK_HOLE on externally compressed (WOF) files
From: Senjin <senjin@hatchling.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Senjin <senjin@hatchling.org>,
 ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Date: 24 Oct 2026 11:26:52 -0000
Received: from 10.8.11.244 by 10.132.0.99 with http; 24 Oct 2026 11:26:52 +0000
Message-ID: <6adc95fc18a0ec50f30273f6@mailersend.net>
X-MailerSend-RecipientID: 6adc95fc18a0ec50f30273f6;6ad8467ea12bfee8f4fd7336;r9084zv9678gw63d
Feedback-ID: r9084zv9678gw63d:MailerSend
X-MailerSend-MessageID: 6adc95fb646700d215d33fb3
Reply-To: senjin@hatchling.org
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ni_seek_data_or_hole() only treats a sparse cluster run as still
containing data when the file uses classic NTFS compression
(FILE_ATTRIBUTE_COMPRESSED, LZNT1) and the run isn't aligned to a
NTFS_LZNT_CLUSTERS (16 cluster) boundary. It never checks whether the
file is externally compressed (WOF, reparse point, Xpress/LZX,
NI_FLAG_COMPRESSED_MASK).

For an externally compressed file, the main $DATA attribute's run list
is not frame-compressed in place like LZNT1: it is one continuous
sparse run end to end. The actual compressed bytes live in a separate
named attribute ("WofCompressedData", see ni_read_frame() and
ni_decompress_file()), and ni_read_folio_cmpr()/ni_read_frame()
reconstruct every logical byte of the file on a normal read. There is
no real hole anywhere in such a file.

Because ni_seek_data_or_hole() never recognised this, SEEK_DATA on an
externally compressed file walks its one sparse run straight to
EOF_LCN and returns -ENXIO for the entire file, as if it were empty.

This silently corrupts anything that trusts SEEK_DATA/SEEK_HOLE to
decide what to copy. cp(1) on a modern coreutils probes the source
file with lseek(SEEK_DATA) before falling back to a plain read loop;
when that probe comes back -ENXIO at offset 0, cp treats the whole
file as a hole, punches a hole of the same size in the destination
with fallocate(FALLOC_FL_PUNCH_HOLE), and never calls read() at all.
The result is a destination file of the right size that is entirely
zeroed, copied without any error being reported anywhere.

Confirmed with strace: cp of a WOF-compressed file does exactly this,
producing an all-zero copy every time, unconditionally (no large-folio
readahead trigger needed, unlike the page-mapping bug fixed earlier in
this series). A plain read() of the same file, e.g. via Python's
open().read(), decompresses correctly throughout.

This is not a new class of problem for this driver: ntfs_fiemap()
already special-cases is_compressed() and refuses fiemap outright for
any compressed file, with a comment noting that "cp -r incorrectly
treats compressed clusters". bmap()/FIBMAP is also unreachable for
compressed files, since they use a separate address_space_operations
table (ntfs_aops_cmpr) that has no .bmap. SEEK_DATA/SEEK_HOLE was the
one remaining place that exposes the main attribute's raw run-list
layout to userspace without either accounting for external compression
or refusing outright, which is how this went unnoticed until a plain
cp hit it.

Treat an externally compressed file as having no holes: SEEK_DATA
returns the requested offset whenever it is inside i_size, and
SEEK_HOLE returns i_size (the implicit hole at EOF, same as for any
other file). This mirrors how the already-existing LZNT1 case is
handled, just without pretending the WOF run list carries any
frame-aligned structure it doesn't have.

Fixes: c61326967728 ("fs/ntfs3: implement llseek SEEK_DATA/SEEK_HOLE by =
scanning data runs")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Senjin <senjin@hatchling.org>
---
 fs/ntfs3/frecord.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index a8b696d..d77465d 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2910,9 +2910,32 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni=
, loff_t offset, bool data)
 {
 	int err;
 	u8 cluster_bits =3D ni->mi.sbi->cluster_bits;
-	CLST vcn, lcn, clen;
+	CLST vcn, lcn, clen, frame_clusters =3D 0;
 	loff_t vbo;
=20
+	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
+		/*
+		 * Xpress or LZX (WOF). The main data attribute's run list is
+		 * entirely sparse: the real, compressed bytes live in a
+		 * separate named attribute (see ni_read_frame()) and every
+		 * logical byte in [0, i_size) is reconstructed on read. There
+		 * is no hole to find here.
+		 */
+		loff_t i_size =3D i_size_read(&ni->vfs_inode);
+
+		if (data)
+			return offset < i_size ? offset : -ENXIO;
+
+		return i_size;
+	}
+
+	if (ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) {
+		/* LZNT compression: compressed frames are embedded directly
+		 * in the main data attribute's own run list.
+		 */
+		frame_clusters =3D NTFS_LZNT_CLUSTERS;
+	}
+
 	/* Enumerate all fragments. */
 	for (vcn =3D offset >> cluster_bits;; vcn +=3D clen) {
 		err =3D attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL, false,
@@ -2960,8 +2983,8 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni,=
 loff_t offset, bool data)
 				break;
 			}
=20
-			if ((ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) &&
-			    (vcn & (NTFS_LZNT_CLUSTERS - 1))) {
+			if (frame_clusters &&
+			    (vcn & (frame_clusters - 1))) {
 				/* Compressed cluster in compressed frame. */
 				break;
 			}
@@ -2975,8 +2998,8 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni,=
 loff_t offset, bool data)
 			 */
 			if (lcn =3D=3D SPARSE_LCN &&
 			    /* native compression hole begins at aligned vcn. */
-			    (!(ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) ||
-			     !(vcn & (NTFS_LZNT_CLUSTERS - 1)))) {
+			    (!frame_clusters ||
+			     !(vcn & (frame_clusters - 1)))) {
 				/* Hole in sparsed or compressed file frame. */
 				break;
 			}
--=20
2.56.0
