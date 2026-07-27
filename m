Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0863DC4C8
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186016; cv=none; b=C3BG8rAlZ0/WKOYn9q2d4qXsZj+s1ZIv8H64ugF+DTRko91f+A2smqGcvW9uMd+xTLZUCOodNua8dbLKAO41VUEj2Sk4MCQxupyZu9HLsX5Zml7GjwUhZO6K9cLjLanpcBg4QQQmPblA5Yr0BsoHgriNr3Vti5g3urowT5vBfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186016; c=relaxed/simple;
	bh=acFxkXi6iovvKFSWGLs4eelSV6ygbb84JY0hBtFLYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqoD2eNgVrR17q3TvCqBq/q0rvbcJcZ1LJj/yzazPtMGoMoB40uKEOvDIZPNv+uHCVRTAY9Tao3Jk7SlOJ729Ty3+5kSC/ODOFSO0svyC8FnpZ3UMlk5+e5uRBlsse4LGcvE3lSlqDzJPf92arqLewmiHaWkRV612r+7dfFRnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqvBvS9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqvBvS9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4E21F00A3D;
	Mon, 27 Jul 2026 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186015;
	bh=hq0BmK1HWJ+J0wANvmtlXQtwbe5T/XdqsPvwk4NSqQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NqvBvS9z2CQhLHErpWAKqWyLdNhM7U3U/mrFgH5V/NBWI2854MatAGSqERW2Rw5tu
	 2m4VQV83zpyelLY9q33Yrf1Gx8nfRUUB0XBw/9sndpPpCAAjWNsbDyXffcad+wYy66
	 f/IpgFrh4uvGj6WoPkmKKAnWnUmgy64SQMLmDU6DxleyoKgHMGYM0jcBIKSncdYaOo
	 mQ56cl3sgZzvNpt0zbCXtzohtiUbUCSmGOfnJKWlckaOX9K6zg9i6K2T3wFAjh2vRt
	 ++wEYdsb7WduEjLN6GgoC2SB4yd5kVQ+InKL2/t8vNc0jRMt1FE1dbgwJNIC5Dglle
	 xpDFAuJUeSePw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] dm-verity-fec: replace {MAX,MIN}_RSN with {MIN,MAX}_ROOTS
Date: Mon, 27 Jul 2026 17:00:10 -0400
Message-ID: <20260727210011.1929439-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727210011.1929439-1-sashal@kernel.org>
References: <2026072004-monitor-wolf-7764@gregkh>
 <20260727210011.1929439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit 82fbd6a3e29a329d439690cd7ccc4162c9cd8db6 ]

Every time DM_VERITY_FEC_{MAX,MIN}_RSN are used, they are subtracted
from DM_VERITY_FEC_RSM to get the bounds on the number of roots.
Therefore, replace these with {MIN,MAX}_ROOTS constants which are more
directly useful.  (Note the inversion, where MAX_RSN maps to MIN_ROOTS
and MIN_RSN maps to MAX_ROOTS.)  No functional change.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Stable-dep-of: 31d6e6c0ba8d ("dm-verity: fix buffer overflow in FEC calculation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-fec.c | 6 +++---
 drivers/md/dm-verity-fec.h | 5 ++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index a8fbf97b97517f..cebcc8fd25d700 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -87,7 +87,7 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	int r, corrected = 0, res;
 	struct dm_buffer *buf;
 	unsigned int n, i, j, parity_pos, to_copy;
-	uint16_t par_buf[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN];
+	uint16_t par_buf[DM_VERITY_FEC_MAX_ROOTS];
 	u8 *par, *block;
 	u64 parity_block;
 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
@@ -605,8 +605,8 @@ int verity_fec_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 
 	} else if (!strcasecmp(arg_name, DM_VERITY_OPT_FEC_ROOTS)) {
 		if (sscanf(arg_value, "%hhu%c", &num_c, &dummy) != 1 || !num_c ||
-		    num_c < (DM_VERITY_FEC_RSM - DM_VERITY_FEC_MAX_RSN) ||
-		    num_c > (DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN)) {
+		    num_c < DM_VERITY_FEC_MIN_ROOTS ||
+		    num_c > DM_VERITY_FEC_MAX_ROOTS) {
 			ti->error = "Invalid " DM_VERITY_OPT_FEC_ROOTS;
 			return -EINVAL;
 		}
diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
index 6f11abb3c7d972..178ecdddbbd310 100644
--- a/drivers/md/dm-verity-fec.h
+++ b/drivers/md/dm-verity-fec.h
@@ -13,9 +13,8 @@
 
 /* Reed-Solomon(M, N) parameters */
 #define DM_VERITY_FEC_RSM		255
-#define DM_VERITY_FEC_MAX_RSN		253
-#define DM_VERITY_FEC_MIN_RSN		231	/* ~10% space overhead */
-#define DM_VERITY_FEC_MAX_ROOTS	(DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN)
+#define DM_VERITY_FEC_MIN_ROOTS	2	/* RS(255, 253): ~0.8% space overhead */
+#define DM_VERITY_FEC_MAX_ROOTS	24	/* RS(255, 231): ~10% space overhead */
 
 /* buffers for deinterleaving and decoding */
 #define DM_VERITY_FEC_BUF_PREALLOC	1	/* buffers to preallocate */
-- 
2.53.0

