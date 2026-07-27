Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA43CB54E
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785186014; cv=none; b=tlBJKd+zQh3JGBqLv6fy0T2cnKcUutojcToiasRqO+nFPsRLuF+0ACMTlHk1PsOjKZ7SsuQayzBLEplgzUq1Tg8uwvP2nqjfjB8hImP7MB/cWOgPqnOMDl8SO8mY9qpmvVwGWFYuY9FiyaSzc93ltHaiVk7FMWO/Y84fmZpRDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785186014; c=relaxed/simple;
	bh=pzjXaAvzBZ5nSuH5R6DcMlMjSy6XdEpd5u/uYgcRtsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk8A79tRzgcgq5jWL8j8asBBaEeAQG5IyLrFIfp0B2eCrOFM94QGYYXbTkVzmCiinzfkDMmRJIbrK2LPVYwKn1DYIwR/jTYdmmE7JTf994RiDjXfiTfHvooM6y3F/LQBMd6YwoZlwJ+0I9xkFf50d5AyeZJLPRJXOh5Bp3CG40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8XyzhKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8XyzhKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD261F00A3A;
	Mon, 27 Jul 2026 21:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785186013;
	bh=Ffx/2UUQ/FVkoqjEfDv2kbhlktlMIEUV9JQM9T8tNgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y8XyzhKM5+l11xmem1qi79H0RdXkhk9sok8LqbYMisqtVN9wGetr2G2uNURhU30CC
	 OrjFBAchPuuh3Rw698PhzoOBZkkreQJUFBZvWT1+E1PuZFEi+2T6ZeRm+UxCTuBykW
	 Jq7wbIOpCGk23gQqvOxQJk1mUtVYXcMkqwfwsIaH5lxUdU7FUuPdiXsjVKtb820eJ9
	 AuHbeSwSjTnCjk4HW5kTCKZfmt+FIjM3Srss2VPZAUiBy1SzJy4CEa1+VyQtAXGeXA
	 8VuiGLORzZTwJOtuK3z3gpn8OsoeqpRFRpDfMdHOh+x5FQ3hcVuqsa6oil5/UlM2bT
	 AAIuRW6lISK6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] dm-verity-fec: fix the size of dm_verity_fec_io::erasures
Date: Mon, 27 Jul 2026 17:00:08 -0400
Message-ID: <20260727210011.1929439-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072004-monitor-wolf-7764@gregkh>
References: <2026072004-monitor-wolf-7764@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

[ Upstream commit a7fca324d7d90f7b139d4d32747c83a629fdb446 ]

At most 25 entries in dm_verity_fec_io::erasures are used: the maximum
number of FEC roots plus one.  Therefore, set the array size
accordingly.  This reduces the size of dm_verity_fec_io by 912 bytes.

Note: a later commit introduces a constant DM_VERITY_FEC_MAX_ROOTS,
which allows the size to be more clearly expressed as
DM_VERITY_FEC_MAX_ROOTS + 1.  This commit just fixes the size first.

Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Stable-dep-of: 31d6e6c0ba8d ("dm-verity: fix buffer overflow in FEC calculation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-fec.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-verity-fec.h b/drivers/md/dm-verity-fec.h
index ec37e607cb3f09..6f11abb3c7d972 100644
--- a/drivers/md/dm-verity-fec.h
+++ b/drivers/md/dm-verity-fec.h
@@ -15,6 +15,7 @@
 #define DM_VERITY_FEC_RSM		255
 #define DM_VERITY_FEC_MAX_RSN		253
 #define DM_VERITY_FEC_MIN_RSN		231	/* ~10% space overhead */
+#define DM_VERITY_FEC_MAX_ROOTS	(DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN)
 
 /* buffers for deinterleaving and decoding */
 #define DM_VERITY_FEC_BUF_PREALLOC	1	/* buffers to preallocate */
@@ -50,11 +51,11 @@ struct dm_verity_fec {
 /* per-bio data */
 struct dm_verity_fec_io {
 	struct rs_control *rs;	/* Reed-Solomon state */
-	int erasures[DM_VERITY_FEC_MAX_RSN];	/* erasures for decode_rs8 */
-	u8 *bufs[DM_VERITY_FEC_BUF_MAX];	/* bufs for deinterleaving */
-	unsigned int nbufs;		/* number of buffers allocated */
+	int erasures[DM_VERITY_FEC_MAX_ROOTS + 1]; /* erasures for decode_rs8 */
 	u8 *output;		/* buffer for corrected output */
 	unsigned int level;		/* recursion level */
+	unsigned int nbufs;		/* number of buffers allocated */
+	u8 *bufs[DM_VERITY_FEC_BUF_MAX];	/* bufs for deinterleaving */
 };
 
 #ifdef CONFIG_DM_VERITY_FEC
-- 
2.53.0

