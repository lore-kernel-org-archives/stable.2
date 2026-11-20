Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181770;
	b=Q9nNVWF1LPde5KOBJpG6Ny5msYrc3/TyVhxG02qNw9dKvGvQL1HonEwm3LvisVHs84Ep
	 GpkBSdHZQsiWCFGnaMHnDD4kWde+3xii0+3hnf6a4L4CYzaVUDttw21cXpKKRnUYoiT1d
	 Zo8yC+lNbErqdzIbUng2gmTFBJhZVLo9YfGlX2iUK/NuZ4Lrue1HRTn0olnMDGv/dtjBm
	 65AtFHsgsVwLvG8j+a69zOWdRK7vRt1i7H0FqWG2djU96KsuEt+pthv8hqL6FiidiOM8f
	 vynmLAspYMOC7EKDhK3NKkSu7PppKFqMbq5e5MWayqHesXNA7Z4ga9ceT2MYgtPZGXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/vILFpTBKVy7hMrZddb0IwK/uJclDAZCWjwJQwnPh2M=;
	b=AbZRqTi2MstkWULtoZJeXfHBogg4VqJw57Ag5LjH4irXET7onkn7jNVLZs40U/cfShvN
	 gbhd50O0YeadIVjqenAs2Sbx0kAvLjuGLlcwTJ7CNS88xekABYiNtWV4EWpw4n2hO/GAB
	 Ix68gHyg2vrh73QbKdXWiMhurG3XqXNDlg4pR5xb0ZLHpp+R/F8Q0uLJZY+xMEnpy/WFJ
	 sL2RvdJ6i/nbj3nLYLj4z3F/ZVTTCs2bJYxsSICeoVpYWzlptwkkRJlUB9VR1yiKcMyJO
	 e5CTjD2DgRLtgkePxXKLRMot0QGG/MnrdRyWspDUAjRZdghAWB2wYa7w7nlwgY9qX4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqD2brcK;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06A606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F06A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqD2brcK
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f04bea9a93so4199335ad.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 05:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795181770; x=1795786570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/vILFpTBKVy7hMrZddb0IwK/uJclDAZCWjwJQwnPh2M=;
        b=rqD2brcKpq+QbkzaX7aG3WpNJUL8fYl4ejHYirlAC7PRiN6CrdvcI28LAGmbeOwc/Q
         z3sEQUIcCiqsbmLHZab82gKslwp7lJIHgRgckWkZUg64PhcSlZb8qWTVteiXjsUZ475c
         kT6uKp8KSzVcatL+BCoQhQ+CFFu/opAWIfqcWE9gdlidDSoU8Xcoe3ocQw4fruOvznzO
         tSr6vdjHOeNjJpEiO0/7Jmsmkh49bMgrP1oQncGlob1BGHVDtHBU6hvA5/ZXWG5VU4RZ
         kZUlF3Gq/X1EITDJhIPx9ugiY0kEda1Rdd8wuryECc8P3PEhLH2Y1ltzFyO7Ot/FOvgR
         q6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181770; x=1795786570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/vILFpTBKVy7hMrZddb0IwK/uJclDAZCWjwJQwnPh2M=;
        b=W6AgK/EM3sprzXRdqI/dmjLHwYiKDorMM8pG625kJoqR6qK60jUPKh1d9X/+AHlfnz
         deHLX0IyNKzrKS+AZOqT63h4VdrR5TN6WvgkpsxaMTdM29ATXOWpaX9cKHwdJsARS+Jo
         aFJUvtnGPnFPxqeQgt4J4Emd9nO9394wulzpTvyaWxIV/PDdIZyQhkZipfBT9u3o/ljD
         KPSzuyN2wcIpGoUFjslvFxX4U8kbwLkwXkByKHC/PXe6swU0/XNURVASqXOp0AU/7/VP
         ztTuGA1AdVtu6LLc+Ocbs9e/exWnBDTXROUV9QocGWXRUvvbxnwRFuQEML9uw5etyHBB
         r5fw==
X-Forwarded-Encrypted: i=1; AL+hErGqc2Ri4XpSjhm5QxishWbB2Pme+JADC9gO9dEITpPxmE58vuvh73DMRYWhUo5qm0XxfyyUCSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Xpp4L2Ibx4usynnc233UVIoHES8KhakEow4RTpE+772wZCQy5
	tlUV5pAUB2VfYibX0yR4LcD54OjfRvZdsL2D3NmW8bLCGJwMAxcWe+Yt
X-Gm-Gg: AZFdTZcBIIXYTcUxFQltD8vAFwvYIIw9tM3kkKsz4Dimng7vkGhg9r9M/B3QpVxEZgS
	ssD/xvNvxUJuY3AiTs2wvK0r1v3g7JioI+sq9K9v8Xcoix1fO5MAHYroD2tmNkJahCgpCrcnPbw
	RE3mfb+164Ec5AjK7KoVXZgv0z7FNo725oIaOyHTqzgQHUw0rQ6R9AyOChVmKrl2VDA6iJayhWz
	rH6f//Ph8ELoyUVZ8uxE4DLujNkDi61ahbXVtlXZMttvvNvP94qwIfP+yxbJ09fxJCgcQmtRJ7s
	PEW0aJJ9WatL73Oo+c3kpE+W0iCvc5S5pKV1rr4ZfYA6jza2/OL/rmKihCELaAiAcGpthao0oht
	sc44a4SjHLFNwkquEC5G3ddylvetPR5iLNXsQoKeeErxJzp74myk3JvPwTLDsW2PgOZFAiUCcjL
	rltdpCW16z4WoCx4/9YYcRNkpBScMfV5IOESEil6P3Uwp12BrK7PVRJXjD76KRbGHc/kPZ/Cy0E
	LsVDFXVqNiTLxoBQaez0gJu+o0baxUUJIxBvJo+8Kn3pqb2yxv9wIY795LUittLHTqO2Ul8iOuu
	wXMGWP4umgWN3jubL4HtC8r082KZTvrqaLcxBGl2l0kbnQ==
X-Received: by 2002:a17:90b:2688:b0:3ac:ffb8:183b with SMTP id 98e67ed59e1d1-3b41c97ab4emr2678585a91.51.1795181769634;
        Fri, 20 Nov 2026 05:36:09 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm7557362a91.14.2026.11.20.05.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:36:09 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH 1/2] fs/ntfs3: allocate only the written range of a hole on writeback
Date: Fri, 20 Nov 2026 21:36:03 +0800
Message-ID: <20261120133604.427285-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ntfs_writeback_range() maps from the folio to the end of the file with
one ntfs_iomap_begin() call, and for a sparse file that call allocates
the holes it maps.  A page stored through a shared mapping reaches
writeback without a delayed allocation, so writing it back allocates
every cluster from that page to the end of the file.  Only the page is
written, and ntfs_filemap_close() later raises the valid size over the
rest.

On a volume with 4K clusters, map a 4096-byte sparse file MAP_SHARED for
100 MiB, grow it to 100 MiB with ftruncate() and store 8 bytes at 4096:
97876 KiB are allocated instead of 8 KiB.  With a 4 MiB file and the
store at 2M, the 2093056 bytes from 2M + 4K to the end of the file read
back what their clusters held before.

Map only the range being written back for a sparse file.

Fixes: 099ef9ab9203 ("fs/ntfs3: implement iomap-based file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested in a VM on 7.4-rc3 (20eef29b7c84), 4K and 64K clusters, with and
without delalloc, with the free space filled with a known pattern first.
The numbers in both changelogs are from 7.4-rc3 without the series.

For a sparse file, writeback now calls ntfs_iomap_begin() for each
dirty range instead of once per extent.

 fs/ntfs3/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 45f894d182dd..535a2b0804af 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1181,7 +1181,11 @@ static ssize_t ntfs_writeback_range(struct iomap_writepage_ctx *wpc,
 		struct ntfs_inode *ni = ntfs_i(inode);
 		struct ntfs_sb_info *sbi = ntfs_sb(inode->i_sb);
 		loff_t i_size_up = ntfs_up_cluster(sbi, inode->i_size);
-		loff_t len_max = i_size_up - offset;
+		/*
+		 * Map up to EOF in one go, except across the holes of a sparse
+		 * file: iomap_begin() allocates what it maps there.
+		 */
+		loff_t len_max = is_sparsed(ni) ? len : i_size_up - offset;
 
 		err = ni->file.run_da.count ? ni_allocate_da_blocks(ni) : 0;
 

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.43.0

