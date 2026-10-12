Received: from outbound.ci.icloud.com (ci-2002g-snip4-5.eps.apple.com [57.103.88.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91014457AC
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.88.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842873; cv=none; b=Q3HxK5Wazv2n2ABAy1hMqLHLqfdV9rKVESxLnVfCpNCSG5aXpuL894/ZjFs69N8rcgs1wg9OG61VnRer/Yf2kq+kKyLReVSiISHoTp0ECh6koxo4Vd2scVjNnrdZ9TxqrAG08L1OMgyNwegqnGZfDp7UVTx0gfpcM621m/pu8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842873; c=relaxed/simple;
	bh=N1dBN1iiweAEzjvXz5juUyXIXvxH9ewTqEAwbQvbUg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJq6dK1yPKXFkZExo0d2cpwpKbibXefXwiT2LIXM59FkmWQnW9OC0zQ7XYdnw2U/4zIzzufIYqgJ6J+dWMUtXIkXJ50S9DYQQHMVkZ2nKUcYSznivdTt/9nJ4KgFAQ2zG1Xdk0GaCzZ3p2sL4xbk4lUDpUDyabJDv9asTaAJXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Q1s4bxZQ; arc=none smtp.client-ip=57.103.88.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Q1s4bxZQ"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPS id 8A0641800C2B;
	Mon, 12 Oct 2026 22:07:49 +0000 (UTC)
X-ICL-RepId: 01a13228-6117-710b-afbc-3a1d3671b653
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhKCkMFWhxBDUkdXAVLVxQEHkkIRR5aHnkRUAFYHlZeWhdeTVEPDxlaFFwYU0VRH1RYQQ4KWgBQUR1fAgoERwRbF0YDU0VRGRcRUAFYHlZeWhdeTUcfQE1iSQFaGVscQBdKbk1TDw8ZWhRcGFNFUR9UWF4EU1YOQglKBVwHWgBCC0gEXw9FA0QBTgJABkZUClwKRgVZK1sTVRdGCRkIXR0HWEcURw4PGVoUXBhT
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1791842870; x=1823378870; bh=4RNvChQmNx1ZsQjDMrdbwFGeu5n8buJ6kgh5fV9g8d4=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Q1s4bxZQl+i4jQfbc4Uwe8Phh/tc/HpZKwSRaX61+mnRzAhG9X9wcVdle0RSCjmjRjM9P4NLxqIWum6n7ovuIyvvDfQKYFjSCdLhCoddneBg4fCmuIQRT0fv7ghIFHzCqEaeItQoKIas7nPtWRpK9ENVkjogDLNj5Z+O25JOnY4eyCq14QZFInr7rNUxWBF671KtFOASXNR1qMA0EUsGftVJsRpoAHck65RNR0UEPhvp0dlK+QaFhwhACllYdAJsGccJIJP36e5OyTPWwhQOX7eM4BSTCt66UkitDmPaReahsG6rWkfdcjNyUPdf4WQghAtZZq6ArE26DitoPsWlog==
Received: from 252-PC-L.device.rit.edu (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPSA id CC98918001AA;
	Mon, 12 Oct 2026 22:07:48 +0000 (UTC)
From: Finn Zeruhn <fzeruhn@icloud.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Finn Zeruhn <fzeruhn@icloud.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/dp: keep MOT set between messages when no_zero_sized is set
Date: Mon, 12 Oct 2026 18:07:28 -0400
Message-ID: <20261012220728.14861-1-fzeruhn@icloud.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=FJoWBuos c=1 sm=1 tr=0 ts=6acd5a36
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10
 a=UWokjQvqbcQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=4Y1DqYvJFVATt9YQ-gkA:9
X-Proofpoint-GUID: UFaH4ZMkzSVwnaRhiXHg1unmSdFc41RC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4OCBTYWx0ZWRfX8tGDfvLVTEu5
 /eCKjCPFAZ3PUNHsiJtG9lMdT0xINTG5YvIw1F+NTKYoBdS1XzaEOhj/YqobqfVUfv5B4L0uZIo
 ljg8gqUIJyJNFD8qxX1zqOs6btsxtg0zSA8j0+Ya+RLQoVJ5rIwLkuboYpKbiMVOeE9UhVU0MU4
 5ayYR1q3o+vvqlPwCMiDe3WPZ//ZmvVyp4dFf5tyIV8/+95Bm53ulaJq3LBKOVWJc2C4QqZ8MK/
 /HocGvncg/EB/ScK51IefPuT3WlNgRZrhMpL0xOzcRyyjay21XTZIz3T6yJSMzcYy/sXOQCyYZl
 V+SgL9ILd7CX3DWv88oX4tekCMNByptYxjyPUmaXsfcdNPZaP2QzUh4IaknhKI=
X-Proofpoint-ORIG-GUID: UFaH4ZMkzSVwnaRhiXHg1unmSdFc41RC
X-JNJ: AAAAAAABCa9tMSaO86BRh/JsoI4xZ5q9hHxPbgdazF/w/KUUMMSNABkQt2//kzYOF1jYZQfanTaMPKhFZ33ZInURycjHfhnrDRY4sFqsp/2TRrccKblweNpCdfRX1rZoHAXw7narf18KFfltC+JRJqtG2cZ3TEfl5yWvEgtuyLeNTaoCVxeXdgJkHrveZbEeK8TYzv3pY7sffO0NDPQAa0yU/2iA7f5Y2Vmq1YqUiMEwR/1iVOlnpp1s6lf0qN2YqJuI84Hhbo8zFZ/k0i0ktkkIS+EEb8jW9EbvDvbQlE+KButIqMDTJt0SMV+FtukY28lfwlt27z1Uc7xceZ/hFu7xApPUuvUqYhB5G6LW7dbQ7r3gAhmDS76ppuRssG6tzA3JrnYzwv1MAuuwvoPqlfqopXAiROzdpIrYO8+WdeJAKL/cFaqJPg0noUr6diAnrT0o/STLeDzfuja8VWcdAfyImPWAT0ok1GzFWaUoaJvlBrd+rR+3tCPjh1DK9bK0Zvfd3k8UHGjKFh9QRSyB3pRqwoMmOeh4NQnGiron/zsnAGL4PW5kUXQPWuuNFXQZIik2n7RFOwzyN5qQHoeMnS/GMP92R0PbcpDRfs+GZOkghcIpbJhLOgxMyxrJzurrt9+qXubllVm9JT6NOxgaRgKgu7zEhYZfnGqv3s3yyDTnmafmj7jdn1IFzFjwHP9eKZNjtQTmEdAtjF3PKYp/Jzuz0NdyuoVb3z9iXs986IqnOyysViYPbojMLeQBMeR6dpEpNu9hgrkDpv1LFBjQ8qGSgG/blH54UVrvpUHD/A0MJSOKbYYgd0n48xU4PDlpLOpn89hF2HdyQ7WKkGraKk7SMXa02uTHHm1vbK8yAFo1v6+eAf+QSnS5Pf+suHVkqVTBT10Udb5dQF9ciApOphQKHigsM44gWHea13QPU7itMeTjW+ngOM5eCLga5UXghMHPuM+yTemQUb53+i/KKkiEmglM442
 HJ3CqF7kjUdGkCtoewtJiqrpFr9lsp/9oFzXJqdloy7bFp8SDzN11eBXhnS7YCV7wvVZKzZtCXW1RBadTBs6i+BJoGaP5tNLQl1k+i0l7j4qVBJH/V4/XL+XE+PLbQB2zRI//VtBCFZRJQpsXwe+/FYQ2xV2t5dswU8kRhC9Fut9a2kCZmhD8+eo2cH6Xx/z4bBY/GebqC5l8BtQcF6QRBL2Y+2VFM2N3SqoiVIeS5fzyfkhTcoEFKGGn5+dULNwKPGQS3TdiWytSB0KTACHuj1fWpQxYAlUCnSEknfkUFSn3UOw6JeqFN2QvyJvtJ1FNgkdQ9EuT1iT+sqeZrXqqeIQumf+kJmjawqg++zMjJkPjqbfUmg==
X-Apple-Category-Label: MTE1NzgzMjUxMzU6JGNhdGVnb3J5JF9QZXJzb25hbCw=

When aux->no_zero_sized is set, drm_dp_i2c_xfer() cannot use a bare
address packet to close the transaction, so it clears MOT on the last
data packet instead. The check only looks at the position within the
current i2c_msg, so MOT is cleared at the end of every message and each
one is terminated by an I2C stop.

This breaks E-DDC reads of EDID blocks 2 and up. Those are read as three
messages: a write of the segment pointer to 0x30, a write of the offset
to 0x50, and the read. The stop after the first message resets the
segment pointer, so the read returns segment 0 again.

On a Pimax Dream Air (three EDID blocks, native timings in a DisplayID
extension in block 2) connected to an RTX 5070 Ti with nouveau, block 2
reads back as a copy of block 0. The checksum is valid, so nothing is
reported, and the connector only offers fallback modes.

Clear MOT only on the last packet of the last message, as the commit
that added the option describes. Trailing messages without data are
skipped when looking for that packet, since nothing is sent for them
and the stop would otherwise be lost. With this, block 2 reads
correctly and the native 7104x3840 modes are listed for the Dream Air.

The same problem was pointed out by the Sashiko review of the patch that
sets no_zero_sized for all DisplayPort connectors in nouveau.

Fixes: f0ddbb1eed18 ("drm/dp: add option to disable zero sized address only transactions.")
Link: https://lore.kernel.org/all/20260827015758.0B4FB1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Finn Zeruhn <fzeruhn@icloud.com>
---
Changes in v2:
- Clear MOT on the last message that carries data, so a transfer that
  ends in a zero-length message still gets its stop.

v1: https://lore.kernel.org/dri-devel/20261002212833.9674-1-fzeruhn@icloud.com/

 drivers/gpu/drm/display/drm_dp_helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 488fd123a01a..dfa64d20ab55 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -2149,7 +2149,7 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 			   int num)
 {
 	struct drm_dp_aux *aux = adapter->algo_data;
-	unsigned int i, j;
+	unsigned int i, j, last;
 	unsigned transfer_size;
 	struct drm_dp_aux_msg msg;
 	int err = 0;
@@ -2159,6 +2159,10 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 
 	dp_aux_i2c_transfer_size = clamp(dp_aux_i2c_transfer_size, 1, DP_AUX_MAX_PAYLOAD_BYTES);
 
+	last = num - 1;
+	while (last > 0 && !msgs[last].len)
+		last--;
+
 	memset(&msg, 0, sizeof(msg));
 
 	for (i = 0; i < num; i++) {
@@ -2192,7 +2196,8 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 			msg.buffer = msgs[i].buf + j;
 			msg.size = min(transfer_size, msgs[i].len - j);
 
-			if (j + msg.size == msgs[i].len && aux->no_zero_sized)
+			if (aux->no_zero_sized && i == last &&
+			    j + msg.size == msgs[i].len)
 				msg.request &= ~DP_AUX_I2C_MOT;
 			err = drm_dp_i2c_drain_msg(aux, &msg);
 

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.56.0

