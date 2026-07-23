Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9701D8E01
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806621; cv=none; b=KSDq4g8RTjmuKcnnBTptUjeW9v/sOlXYSY28+k7X5AAlnw8avegzZqBaNXunLw0413imCuWzHZ8WpUkNqiXZHA8ZuVt1t4G9inigwG19F/iLCunVjeyw8dXp4Tk9DeLMwutWvgdEzeVE2wuvSULg1OkonbXFn1qjbUKf3LswKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806621; c=relaxed/simple;
	bh=Ri1SubZl2r84GqRR/zmi17BxPZYIzaK1NpznMleIBso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9dWXxG7Z2fzk7HzhVVbKyw6SOKwz+z6vOdcOOD6mkcRTyc7RPWGbWADaw9MKZO2Ly26yDewkZv1wNtGAaaR0pLlchEbGwZBwDIa4sNptByVqkCG01xLoSBMdsQkp8YUDyjHfSr7jIfzxkstGuy3YbSj00BLktFjcLlKLYzLKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467881F000E9;
	Thu, 23 Jul 2026 11:36:59 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get
Date: Thu, 23 Jul 2026 07:36:47 -0400
Message-ID: <20260723113647.3034771-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072001-unvocal-backtrack-aa11@gregkh>
References: <2026072001-unvocal-backtrack-aa11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit fd46668d538993218eea19c6925c868ac0f2630c ]

The ipc_control_data buffer is allocated as kzalloc(max_size), where
max_size covers the entire struct sof_ipc_ctrl_data including its
flexible array payload. However, the bounds checks in bytes_ext_put
and _bytes_ext_get compared user data lengths against max_size
directly, ignoring that cdata->data sits at an offset of
sizeof(struct sof_ipc_ctrl_data) bytes into the allocation.

This allowed writing up to sizeof(struct sof_ipc_ctrl_data) bytes past
the end of the heap buffer from unprivileged userspace via the ALSA TLV
kcontrol interface, and similarly allowed over-reading adjacent heap
data on the get path.

Fix all bounds checks to subtract sizeof(*cdata) from max_size so they
reflect the actual space available at the cdata->data offset. Also fix
the error-path restore in bytes_ext_put which wrote to cdata->data
instead of cdata, causing the same overflow.

Fixes: 67ec2a091630 ("ASoC: SOF: Add bytes_ext control IPC ops for IPC3")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20260609083458.31193-7-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ replicated the single shared-helper bounds-check fix into the two standalone get functions and dropped the err_restore memcpy hunk absent in 6.1 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-control.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sof/ipc3-control.c b/sound/soc/sof/ipc3-control.c
index 3fdc0d854e65d1..f204f91bcbc273 100644
--- a/sound/soc/sof/ipc3-control.c
+++ b/sound/soc/sof/ipc3-control.c
@@ -354,10 +354,13 @@ static int sof_ipc3_bytes_ext_get(struct snd_sof_control *scontrol,
 	cdata->data->abi = SOF_ABI_VERSION;
 
 	/* check data size doesn't exceed max coming from topology */
-	if (cdata->data->size > scontrol->max_size - sizeof(struct sof_abi_hdr)) {
-		dev_err_ratelimited(scomp->dev, "User data size %d exceeds max size %zu\n",
+	if (cdata->data->size > scontrol->max_size - sizeof(*cdata) -
+				sizeof(struct sof_abi_hdr)) {
+		dev_err_ratelimited(scomp->dev,
+				    "User data size %u exceeds max size %zu\n",
 				    cdata->data->size,
-				    scontrol->max_size - sizeof(struct sof_abi_hdr));
+				    scontrol->max_size - sizeof(*cdata) -
+				    sizeof(struct sof_abi_hdr));
 		return -EINVAL;
 	}
 
@@ -403,9 +406,17 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 	}
 
 	/* be->max is coming from topology */
-	if (header.length > scontrol->max_size) {
-		dev_err_ratelimited(scomp->dev, "Bytes data size %d exceeds max %zu\n",
-				    header.length, scontrol->max_size);
+	if (header.length > scontrol->max_size - sizeof(*cdata)) {
+		dev_err_ratelimited(scomp->dev, "Bytes data size %u exceeds max %zu\n",
+				    header.length, scontrol->max_size - sizeof(*cdata));
+		return -EINVAL;
+	}
+
+	/* Ensure the data is large enough to contain the ABI header */
+	if (header.length < sizeof(struct sof_abi_hdr)) {
+		dev_err_ratelimited(scomp->dev,
+				    "Bytes data size %u less than ABI header %zu\n",
+				    header.length, sizeof(struct sof_abi_hdr));
 		return -EINVAL;
 	}
 
@@ -431,7 +442,7 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 	}
 
 	/* be->max has been verified to be >= sizeof(struct sof_abi_hdr) */
-	if (cdata->data->size > scontrol->max_size - sizeof(struct sof_abi_hdr)) {
+	if (cdata->data->size > scontrol->max_size - sizeof(*cdata) - sizeof(struct sof_abi_hdr)) {
 		dev_err_ratelimited(scomp->dev, "Mismatch in ABI data size (truncated?)\n");
 		return -EINVAL;
 	}
@@ -473,10 +484,13 @@ static int sof_ipc3_bytes_ext_volatile_get(struct snd_sof_control *scontrol,
 		return ret;
 
 	/* check data size doesn't exceed max coming from topology */
-	if (cdata->data->size > scontrol->max_size - sizeof(struct sof_abi_hdr)) {
-		dev_err_ratelimited(scomp->dev, "User data size %d exceeds max size %zu\n",
+	if (cdata->data->size > scontrol->max_size - sizeof(*cdata) -
+				sizeof(struct sof_abi_hdr)) {
+		dev_err_ratelimited(scomp->dev,
+				    "User data size %u exceeds max size %zu\n",
 				    cdata->data->size,
-				    scontrol->max_size - sizeof(struct sof_abi_hdr));
+				    scontrol->max_size - sizeof(*cdata) -
+				    sizeof(struct sof_abi_hdr));
 		return -EINVAL;
 	}
 
-- 
2.53.0

