Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B325B0A5;
	Fri, 16 Oct 2026 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168368; cv=none; b=E6lIEvHSoLY+25Dh85Rz0WIjjr6/x3m30iamoBxEY0Go7syxV3H8KlY9sQPv/W6dmcpyJoGAxJeoeO8GZYzebcE7yb45ricB5/ZEoj1RFlQCwXF8nv4DIDd2Esp7rWBgBhSzudTvMMEGEJL4pGvVudkjp5Z69IPJ1BLKD1oZR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168368; c=relaxed/simple;
	bh=5+3ZyQcjnDR3yuuIMSCId2BZ/pAwcxAcqdilDYJeIKY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=GUg4mXSjOKtI43k661JJPPCDMRm5/Zv0Ks8wiR4kKGBf9VJO5gHoOWOSdByOSk6xRjp1EopkBHhKBKOWeq+ffh+eJIqFgeTULBQcijWLUDz2T0ndotQ5imsDk3TfnjBdW1xPo+0DM6X2HjVLJ8smbc+59AjgpoZUMN1P+7DB9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lZFRgCBX; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lZFRgCBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792168360; bh=WW0pURbzdrk5T1uFlgXzBoltZ2WZpOYrXfpT0JNkh8I=;
	h=From:To:Cc:Subject:Date;
	b=lZFRgCBXOsnV/1dfaC7VXlRVxDGG/ieFLQ58h5LNzYF3609Bd0P+MdaUJWvh3oJDs
	 6Q8ddTQg8iU+CZca6W+wyh6sTxLI5wmsHwdIutvIEeWUaoFcEBXfUQFzq9P6YLqXW5
	 i3sd4OUvBpScFUgFKDf1QqI6qQxkgG0y7+yyd4Lo=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 7DD844A7; Sat, 17 Oct 2026 00:31:29 +0800
X-QQ-mid: xmsmtpt1792168289t064c6x5k
Message-ID: <tencent_46887DB8A24452C3BEAD474A9C664CDBA209@qq.com>
X-QQ-XMAILINFO: Nwte6vbuj0Eq20mYrONgUTmBbxP1gH1TKg1QKTfwhBCOOs+hX9Skh6jFYI4EGQ
	 hWiFnUxAGb1cijdqHkYqqNt81qiQGfVf2WMEFLhXGDuTm7kXU89BEmBK4n1d7GtPkokjvuMdMN//
	 3/y1REwmBcUDuEiTWA4wG587wHiCx379aNfk/xRPtE52dbfGDVOViIjsXrx1gMg/eyNzjJcOwQaT
	 ZB/4nUoIuWnKGJNEOxPOLqQlJFkk8dpfgUG8sLhgDD0MlGqAFy4gyifoe0iw3/LQizKW1CjHQU57
	 2a4gpUNRUum+70dCZQN/scBYqhWUjDNG40yU54QD6RBozyHys93Ljhb2dczhyUMlzwVzPtkWtnSZ
	 7yL5TY7YB1u45UAw75pDIRBo/eTNtkGTw+EYGIGHlJbnUIMks4pnTDOZHS6hRqvKJOvmz7Fa/VLG
	 eReyTPIDyPkCwUpzfewNmSQIh1r1wJZMPCDlFIn3pSoyjCwR83p2Od63pPvu+FwyKVO9ka1QszC1
	 HwY3W/7TwaRWaiATfpzmOmlEuyBTQj04EiuWNfqSkyftEVgXPOkUzSefD/tsEFgcHT3CPwjyMe9P
	 dmKl/oN1xNcF+le46CxVmpT1ky/V6j2VQf96bW4G7659H5qq2CyH9XoZ8DfA1NN0b6pZHgl2QqdG
	 JuuXZy7uQaedxZragudAH5+IbealPu0kc/oqkknO0K7yKYOSuUItNyALji+4KkBAHoXz8SC32PLY
	 9ECUtZD+4kADUi9qhGpyo9tLN3NKDbZvRUa+/ons4IBktFaLLd1NWySwluVLPgPWt9GeocFmv+Yz
	 XqmAiSfvxUHLidzQ4oMwdC2fGl8VGXVxMb7JpO8i83TiYTA50MhG8IDHhD+WOgscK0V0kG1ZZ1YP
	 NSVtpfP6JKoqpOb3xwTQzGDzJvjQsPmYkZu0Sio1nQ23Z1G9xlVgG08acSSIOiwk4ekERl3QK4QL
	 BeQQWAtNiUdVpnEOjw7FZ1UrBzW+enKnXQFMZzsKT8rpLaZd1otXwTzVMIJ/4+DuJsN4EbnAlIwh
	 4lEJn41srvjZbANzuviCa/hvGu92s/cMyB/4a4qzJDFJwJ+TVW
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Guikun Yang <yangguikun19@qq.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix log replay index walkers running past the entry chain
Date: Sat, 17 Oct 2026 00:31:29 +0800
X-OQ-MSGID: <20261017003129.92048-ntfs3-walker-yangguikun19@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

check_if_root_index() and check_if_alloc_index() walk the directory
entry chain of an index header until the walk offset reaches
lrh->attr_off, but they only re-check the buffer boundary at the top
of each iteration.  The chain that check_index_header() validated ends
at its NTFS_IE_LAST entry; the walkers ignore that flag and keep
reading size fields from the gap between the end of the chain and
hdr->used, which is still inside the validated buffer.  A crafted
$LogFile can place a size field there that jumps the walk straight to
an attr_off far outside the buffer, and the walker then reports
success.

The callers treat that result as "attr_off names a valid entry" and
act on it:

  - SetIndexEntryVcnRoot/Allocation write the 8-byte log payload at
    attr/ib + attr_off,
  - AddIndexEntry* compute PtrOffset(e1, hdr + used) with e1 beyond
    that point, which underflows to a huge length,
  - Update/DeleteIndexEntry* read entry fields at the same offset.

Mounting such an image read-write therefore performs an out-of-bounds
write of controlled data at a controlled offset while replaying the
log.  KASAN reports slab-out-of-bounds in log_replay() on v6.6; both
walkers are unchanged since they were introduced in b46acd6a6a62.

Stop the walk at the NTFS_IE_LAST entry so the landing offset can no
longer be driven past the end of the validated chain.

Tested on v6.6.12 and on a v7.3-rc5 based linux-next tree, both with
KASAN: with the crafted image the unpatched kernel reports
slab-out-of-bounds (write of size 8) during mount, while the patched
kernel rejects the record and the mount fails without touching memory
outside the buffer.  An ordinary NTFS image still mounts read-write,
accepts writes and is readable after remount.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Guikun Yang <yangguikun19@qq.com>
---
 fs/ntfs3/fslog.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2956,6 +2956,7 @@ static inline bool check_if_root_index(const struct ATTRIB *attr,
 
 	while (o < ao) {
 		u16 esize;
+		bool last;
 
 		if (o >= asize)
 			break;
@@ -2964,8 +2965,13 @@ static inline bool check_if_root_index(const struct ATTRIB *attr,
 		if (!esize)
 			break;
 
+		last = de_is_last(e);
+
 		o += esize;
 		e = Add2Ptr(e, esize);
+
+		if (last)
+			break;
 	}
 
 	return o == ao;
@@ -2981,6 +2987,7 @@ static inline bool check_if_alloc_index(const struct INDEX_HDR *hdr,
 
 	while (o < attr_off) {
 		u16 esize;
+		bool last;
 
 		if (de_off >= used)
 			break;
@@ -2989,9 +2996,14 @@ static inline bool check_if_alloc_index(const struct INDEX_HDR *hdr,
 		if (!esize)
 			break;
 
+		last = de_is_last(e);
+
 		o += esize;
 		de_off += esize;
 		e = Add2Ptr(e, esize);
+
+		if (last)
+			break;
 	}
 
 	return o == attr_off;
-- 
2.39.5

