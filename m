Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873945372CF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075104; cv=none; b=tfbFRyqs6phDqMNytbSo2T68A4FKm7+5qTpE+sJ+a5BLH//p0WzQPciEiB1blb/WAFihOOOmZgU6rctIHoeFqyf6XhcspgboahW2GX7yFZUmaXuyDFgJXezmDqKKmTUnZ5EF82VPpVNIGgpK2lQQmFw3Q+BxLqcxrmEvwJuDfiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075104; c=relaxed/simple;
	bh=8x9LGki3Mm6yg1UX2KcCGug5EN8IV3Q6I+Aay0GoHs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMm8Q+xvOQh3ZzERD2FFaGsE3cKwwId3Nnlc+rsDXvGApfT6PjNulsBB0q2kBjzhEc1orhEik9HDToKYq4exUicUu7sFH1/eZa3MKuK2aqqa/IHS49Tr417TM+CUR9Njk9WTx/+/SZ12dzMg2l+ohYBK/jNGTwya3NHx13QfWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVxXt3Pp; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVxXt3Pp"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso29844185e9.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075099; x=1790679899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0tPzl6q3NdKOWA7ST6Jpwl3Ovm4ZJT2Alf3xpqegOU=;
        b=RVxXt3PpWoW9eZQ3LOJTQyaPYTqqxvXMSGwj+9z6WzkVFIDmixhUKbWyU4s5+N7QNm
         gwiyGC6oe8pia776E6nBdgW1rxWZyCOTiktwGVnPpkscgZNw+SeoVeJh/Ib3JWdsbR6q
         ygPFjEw3qvijLqDfaMXn/fXuM3rn8C0TPpB5dM0w+1XkHyI1JlZTXD+0kLSGqGMM54s/
         23KV+Mndo2YIk+5ynZ397wYeHq9HPdJhT1g1L9YhfnNU0kS6DcM0RmyKNvKHU5toA8oO
         bn5Ozzzw6y4TSq6cfFepG3dE4H7kHvHMvniIRNQaJHAUtHBNNhGX1uPTDMj8aX33kWkV
         jhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075099; x=1790679899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0tPzl6q3NdKOWA7ST6Jpwl3Ovm4ZJT2Alf3xpqegOU=;
        b=zBtkch9E53zZar0zI0ZCBb0FoJ9fq4Or7NVctqo71XhbKV//p3HC0YlqlwOn/bI/43
         eENC1M1sq+OBZd8Kia4GjpKPhJw64byzBgVP4WD6BiQo/HfLvT0eYfrFIgyeEPd1Tf7M
         Pd7CaMSJuyiVB6IM5eBo4aOHHFIOsd6dccQFxPo5+fcM2186repIU8OcqQvAU/O6ygqp
         a2ZFVg/sCczru55RVnKIkm8NspXW7Ed9i0siO5wSWsC4Hdt5nvHKrRpv2k9AT/NGaeui
         lSZoDbb3pDReiLvmzpBEqQfomN9IkRIG9uwoxkanZTYTvarohCgcY5p5FjSz57xMamwQ
         YJRw==
X-Forwarded-Encrypted: i=1; AKwUvByUpKeU84J7iZK7MQVds+SeRwlwnvf+KYsHml1sCinJ6Hx3y3ObDQAxZgReb25wsCk00sHytfs=@vger.kernel.org
X-Gm-Message-State: AFuF++k7odhjTpexCnPWcKu51gfmHa0millonttfikSJIw2GAYhr1yPJ
	2KVF7ozEUubbXtyyT8/kb1iJZjC7Q2MDUpOQSYj5h9Qj1O4akGcfXjPU
X-Gm-Gg: AYBFou12vTOyzHeSdE9KvoZVQ6g+LvH84YAzJWEnizd5Jb+s72jgBd6quu6lvsgS3vf
	NEoo0YKWuWdNi05MCx9AcOQgTLW7XWq3vHdJ6KH3g/vm4Xr9GIsaV1fMbzc7nt4GF4PihAl14h9
	fJlM9bVg4o17+iXkViFkxOLdJ5TZunR4McP9PByjMRk0kgMhSFvFA5QKecDpekAJ7dbCTICl1D4
	jXP+DoFlJsSPfPBd3AcyYJcR6dJx/WilT5CInbGGeDFpcGvg76Vxhy3hPrnej/afuD3xmuCj238
	C25joenD03obUE0LsOxqGYqIdkzD6L9w8NuAf9rQcoUAxKqcPfdWG7J5xY/YdEAhzRJIoM70via
	1uUE8W9QcgOZk7wUCswEgnRn2IVdZms7VYU7P3Ytrx7c1ESBMlmHSmDBxoBJU41SxLZoldZ4Iow
	jqBMvdJQXa9us/Aqs0bs6SGPa29H6+4cnj0ezvsLF5fc2gu4mLnFu0jeP+J0LVYXowcFnfSdnP2
	lwH5GyGAOo=
X-Received: by 2002:a05:600c:8b16:b0:49e:6777:da79 with SMTP id 5b1f17b1804b1-49fc5736db4mr167769365e9.26.1790075099135;
        Tue, 22 Sep 2026 04:04:59 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:58 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 26/26] xfs: fix wild memcpy access when formatting ondisk rtrefcount btree roots
Date: Tue, 22 Sep 2026 13:02:21 +0200
Message-ID: <20260922110221.1431-26-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM noticed that the inode btree root formatting methods copy too many
bytes -- there's only one set of keys in node blocks, not two.  This
causes memory corruption of whatever's beyond the buffers.

Cc: stable@vger.kernel.org # v6.14
Fixes: f0415af60f482a ("xfs: wire up a new metafile type for the realtime refcount")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/libxfs/xfs_rtrefcount_btree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rtrefcount_btree.c b/fs/xfs/libxfs/xfs_rtrefcount_btree.c
index e2950dbe2068..dcc89b8e149b 100644
--- a/fs/xfs/libxfs/xfs_rtrefcount_btree.c
+++ b/fs/xfs/libxfs/xfs_rtrefcount_btree.c
@@ -617,7 +617,7 @@ xfs_rtrefcountbt_from_disk(
 		fpp = xfs_rtrefcount_droot_ptr_addr(dblock, 1, maxrecs);
 		tpp = xfs_rtrefcount_broot_ptr_addr(mp, rblock, 1, rblocklen);
 		numrecs = be16_to_cpu(dblock->bb_numrecs);
-		memcpy(tkp, fkp, 2 * sizeof(*fkp) * numrecs);
+		memcpy(tkp, fkp, sizeof(*fkp) * numrecs);
 		memcpy(tpp, fpp, sizeof(*fpp) * numrecs);
 	} else {
 		frp = xfs_rtrefcount_droot_rec_addr(dblock, 1);
@@ -703,7 +703,7 @@ xfs_rtrefcountbt_to_disk(
 		fpp = xfs_rtrefcount_broot_ptr_addr(mp, rblock, 1, rblocklen);
 		tpp = xfs_rtrefcount_droot_ptr_addr(dblock, 1, maxrecs);
 		numrecs = be16_to_cpu(rblock->bb_numrecs);
-		memcpy(tkp, fkp, 2 * sizeof(*fkp) * numrecs);
+		memcpy(tkp, fkp, sizeof(*fkp) * numrecs);
 		memcpy(tpp, fpp, sizeof(*fpp) * numrecs);
 	} else {
 		frp = xfs_rtrefcount_rec_addr(rblock, 1);
-- 
2.55.0

