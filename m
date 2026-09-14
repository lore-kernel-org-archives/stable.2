Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACA3321BD
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789357791; cv=none; b=ShSMbwwp8rvVsT3DCo+VphjiItlEH8z0gON4ooJ+H94csbfkFaMnbODokOd8N746Qmhzy3dUIM6eDhYFHo77PyuOwSa/8pVe6wt0w90YP3Tua5or7zuKvP6FDHmsEpHgNqUBr5ZWsgGYF4yEC2pKQ2IXBcKTx3hjGKf8WlTBSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789357791; c=relaxed/simple;
	bh=q9WE6+wjyeX7fXhtEn7zhcbfhcZOIuWB1HXG6rwgnXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcJj7ukB86KWZwi26RTg2P0sJncmCApjFzQu6mTqEiduC22aSCN5IkrB1amje11pTuvYxZGPLTNpcjagh7cUj45vsqultZwQDQ03olbAZsemL83pN8Z/Eaz4WZ/dS6vXUOVvXjLZySjk4UUjVxp0O5mon0vXFuXWJPNOdBV8++I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlcIzXp7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlcIzXp7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2dd68a16955so3295045ad.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789357789; x=1789962589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kio+heX6pPEISSE575Nmco9JmkqcOqgMUE8R7TgDTQA=;
        b=YlcIzXp75ndJdloetlLD5acX73t3Ehq4BiDeYDgIZA/vwbHJ8Gqt01PMCKWfnuRsf4
         9XeqkilF9Xq8NOjs7qWgUHtS0F+N70C8vpfxhZ0BjFlJUcW3QGLvwAfNYZ+Pm1/sZQ3b
         LUeW8wFkT96brcD6iqxGpIEhuQvTjhFx9U6OJ/aHH/ELgqyQfF/VGmmPLBbcLlvK1wIs
         SZ4UR5f6TBd63LViiBeMVIQRQdKyjAS4+ThKIL4qsG+OXJ7kzOzUQzbNzX0a+gu/DwYv
         tgs7FLTPpD1Pz+YmJxJdJIFBMop0nrMoMUxDIHOjUUypLw/HB0DtzQRXTdvGdKaOMZYQ
         9otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789357789; x=1789962589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kio+heX6pPEISSE575Nmco9JmkqcOqgMUE8R7TgDTQA=;
        b=PvtNGD7SMC66UrY8tMAPUT1Z5aVTRLSjhu7pTstSrnElaq6Gpic+JYq6w3pHtan/aK
         vYrdoZZgjZeJ9Pd9/2JKkgO05uSDPhCiB7RYlQJRDjKPns4oQ736n19qC9ra0Vj+7/12
         VxtrIjy+1Ms/olnI+h1VvBjwdSX/9B5TPd4JAdgp14wE6moQ/Ijk7nHxfoF1V3RfdZSi
         jUUSNvsYXg5OZiRglUGHeMmCs/KY+b9Na7rcc7dc3Z0svO3JOYA9Fe4n+miWi+8BGmnm
         J0a/xVj+guEfmDzlVWxlBkR9tsD0aZZuCBLAdEMTaupRYH742uPjr8VApjl7tmnRl2P1
         BbQQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3KcPoXvtULYxc8+/jqDPscrANXQWJKZCSHrKt+EVBn/E+8YgVFI4jlDg16ottG9GM208xlWw=@vger.kernel.org
X-Gm-Message-State: AFuF++lNk6FVVYpOcdrqSYfg1iH5bBO9L3whOhQHX6HD4xGH1IaUCJyZ
	7wcjolquFh1Eidzb7hP2uQLGkl81RaOtOS+utbTBX8vIrDAEPqGEpCq6
X-Gm-Gg: AYBFou2HIVvecMDf98kkVZCST0noyxPV/IDc3eLco0yZDDDkEdpStw7pttfec/LrlWp
	drqPPpJ0gefGKY/nZgCKQpz1yNiSii2PrEISd9cGTERR5lMIBsqOcM03aDAY9DDMsDehRarFw1O
	B5Wsev9d3s2SwzzAdWmxHGchKsUhQ7F6vcKItaeOrU7wyZmEvShyAyzZmKyBnLUzh0pgViQNV8j
	fH3MPpTmo0WkEUvg5sDAZBc+xNEQWyCdydeWvqUToQ5ZmbshOEkxlO/BWNb547RrD3knCwbLdh/
	KbbjDThNVko6nnzFmDcw0qdtrq4uNRetUr1Bs942c8YNK4lZSriSZTvlyMDO/G0cv/MwJfEUf/F
	mkvGtEtSrT0Vt4IrGAqmL5CWDNx8tuTILq0KAu/CxZsQ8V6CZHPDRyH6QuAe639rGV4kx0oCE6y
	lI+2mt2sWlKw7qkb2+nfu8G4Q4IRPgaqTW/Ay6Pa37V4BywKdTKgRsZEGYOLR1B3bW6jA2VuAoC
	WNOE2i+tA==
X-Received: by 2002:a17:903:b8e:b0:2d6:ee34:c043 with SMTP id d9443c01a7336-2dd5f16afcemr63293405ad.11.1789357788987;
        Sun, 13 Sep 2026 20:49:48 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfce707sm41361815ad.55.2026.09.13.20.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:49:48 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	r772577952@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: fix chunk number of the first chunk in a local quota file
Date: Mon, 14 Sep 2026 11:49:40 +0800
Message-ID: <20260914034940.4070970-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANypQFZ05tpth0Xc33gmP6jgPnkY4VuezyHcsajV-SqCsmN_gg@mail.gmail.com>
References: <CANypQFZ05tpth0Xc33gmP6jgPnkY4VuezyHcsajV-SqCsmN_gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local quota file in OCFS2 is divided into chunks, and each chunk
begins with a header block holding a bitmap of the quota entries that
chunk has handed out.  Chunks are numbered from zero, and that number is
used to convert the file offset of an entry back into a bit position in
the bitmap. ocfs2_local_quota_add_chunk() appends a new chunk to the
in-memory list and numbers it one past the chunk that was last:

	list_add_tail(&chunk->qc_chunk, &oinfo->dqi_chunk);
	chunk->qc_num = list_entry(chunk->qc_chunk.prev,
				   struct ocfs2_quota_chunk,
				   qc_chunk)->qc_num + 1;

The predecessor is looked up after the new chunk is added to the list,
so if the list was empty, the prev pointer is the list head itself.  The
head is the dqi_chunk member of struct ocfs2_mem_dqinfo and is not a
chunk, so reading qc_num through it lands 16 bytes past the start of the
head, on the dqi_gqinode pointer that follows it.  The first chunk of
the file is then numbered with the lower half of a kernel pointer
instead of 0.

The list is empty when the local quota file header claims the file has
no chunks.  ocfs2_local_read_info() takes dqi_chunks from that header
without validating it, so an image with dqi_chunks == 0 takes this path
when the first quota entry is allocated.

ocfs2_create_local_dquot() turns the bad number into a file offset with
ol_dqblk_off(), which shifts a 32-bit block number left by the block
size bits, so the top bits of such a large block number are lost.
ocfs2_local_release_dquot() turns the offset back into a bit index with
ol_dqblk_chunk_off(), using the full chunk number, so the lost bits push
that index far outside the bitmap, and clearing it corrupts unrelated
memory.

Compute the chunk number before putting the chunk on the list, and use 0
when the list is empty.

Fixes: 9e33d69f553a ("ocfs2: Implementation of local and global quota file handling")
Closes: https://lore.kernel.org/lkml/CANypQFZ05tpth0Xc33gmP6jgPnkY4VuezyHcsajV-SqCsmN_gg@mail.gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude Code:claude-opus-5
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/ocfs2/quota_local.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index f55810c59b1b..d351cda9211f 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -1071,10 +1071,13 @@ static struct ocfs2_quota_chunk *ocfs2_local_quota_add_chunk(
 		goto out;
 	}
 
+	if (list_empty(&oinfo->dqi_chunk))
+		chunk->qc_num = 0;
+	else
+		chunk->qc_num = list_entry(oinfo->dqi_chunk.prev,
+					   struct ocfs2_quota_chunk,
+					   qc_chunk)->qc_num + 1;
 	list_add_tail(&chunk->qc_chunk, &oinfo->dqi_chunk);
-	chunk->qc_num = list_entry(chunk->qc_chunk.prev,
-				   struct ocfs2_quota_chunk,
-				   qc_chunk)->qc_num + 1;
 	chunk->qc_headerbh = bh;
 	*offset = 0;
 	return chunk;
-- 
2.43.0

