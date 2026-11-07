Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046311;
	b=i02454OMgkT74x8htxVZYfsSBGhAw8NJ/o1N8CmYrpwih2PiVYKyWRWbgWFJ9n4y/N9+
	 wiZmHlGcvaGGvK43rAIVLYe0uTRfvIIMWYnDav1whTQZ1O6e6TjAH0d4TlpsMKejKDHrK
	 fa6qsrN0SEUO+QSgXzC91hgFo80pD0q4OWbG8LU/J3WoB6f15+KdRG9uTird43lh5SjjR
	 J4C9t9IEyaxivK97bEeu7t/RJ2N4CPEkWu+BAHAIswlcyVjPvP87QX7i+za4pxqIvBzqp
	 wh9i2SWJqzCYLDiTtZxCsgZMbqGNiAD80vYpffjRVD6lgpSrgEOgCikjFptjIcgH54A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046311;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B+tgDg/5nixWbm9iLQkY5+8Qs/CdGSltQyDKZquMnAo=;
	b=ZmRsM77O4jV38INJSaqbEu2GvlhiRpEaSuSAaQL7ObjNIf3C66ascJ8Gw5ViUBfMDnc2
	 /l1E6ZCv4smH9nxIWzb5rT0bRf8YOO7yYgyHiXflBkvkAWZXQlCjacDFV0IuNC74k3Csx
	 dm+1DeCuPOkIEUM7GjK/7UQdc/Bjhvv+Sqa3vNvTgTMHVwFSO7P6ev3Ls02m6X6NikqY1
	 inmYgqavMsJ8Ift0E+R23xGLhjFu9PFDMiQJz1DeDzFelETW1yT2EGc8YvIpgpGxEq8RC
	 NsaKzJRynHB/MmS66N6JvjBanSatqXDe6guDlNiyQna1gG75CgGGYfmMeGa/04ssC6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3sIl1Pp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3sIl1Pp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F269C1F0089F;
	Sat,  7 Nov 2026 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046311;
	bh=B+tgDg/5nixWbm9iLQkY5+8Qs/CdGSltQyDKZquMnAo=;
	h=From:To:Cc:Subject:Date;
	b=j3sIl1PpwveTrq2W13IekLKABcYL0XLuk85H6vzINFNgW+4L68o92vwSnKnMyO4Ox
	 j0rZSeLQCZvZ5lrthhyWxPQdMFk5XpwrtKCSxrxZdZSPjJMy2ixlLJwYTGeSLpvB2k
	 oKADdr826dKxSElGZ/6mYLhFFRgpz9tYrZ6U0LoD3zwEs28QOcrNyz7OZBcDiY6wzZ
	 0rD+j+5uu6BT2/RmB+qWJ5JbY3GScU7e/1EwuBoW/E0ztrzOL6wodYwSo/YAlYnIuD
	 oS1WVcCNW0dhtaY7o8HFp7mo0EWI8QmLEoVVqhpDoyweDnS3t6PIf8PRO1MecFepGp
	 T6a/YC8G9rLuQ==
From: Sasha Levin <sashal@kernel.org>
To: kanie@linux.alibaba.com,
	dave.jiang@intel.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] cxl/events: Test CME counter expiry with equality, not bitwise AND" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:49 -0500
Message-ID: <20261107051149-failed-6.18-b94ba9a1f2d5@kernel.org>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b94ba9a1f2d5c57f2eec67d502bb8fdd1e53c87a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051149-failed-6.18-b94ba9a1f2d5@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b94ba9a1f2d5c57f2eec67d502bb8fdd1e53c87a Mon Sep 17 00:00:00 2001
From: Guixin Liu <kanie@linux.alibaba.com>
Date: Tue, 22 Sep 2026 16:22:14 +0800
Subject: [PATCH] cxl/events: Test CME counter expiry with equality, not
 bitwise AND

The Memory Event Type field in the General Media and DRAM event records
is an enumeration, not a bitmask. The validity checks for the advanced
programmable CME counter expiration event (05h) test the field with a
bitwise AND, so types 01h, 03h, 04h and 06h match it as well.

A device reporting one of those types trips WARN_ON_ONCE once the
general media or DRAM tracepoint is enabled, which is the case anywhere
rasdaemon collects CXL events. Under panic_on_warn=1 that kills the
machine.

Compare the type field for equality instead. Type 05h records that do
violate the spec conditions still warn.

Fixes: cd3b36cfc659 ("cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record")
Fixes: d8145bb8af5c ("cxl/events: Add extra validity checks for CVME count in DRAM Event Record")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Link: https://patch.msgid.link/20260922082214.3526355-1-kanie@linux.alibaba.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836c01a..01341f524a937 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -942,11 +942,11 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 
 			if (evt->gen_media.media_hdr.descriptor &
 			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
-				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
+				WARN_ON_ONCE((evt->gen_media.media_hdr.type ==
 					      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
 					     !get_unaligned_le24(evt->gen_media.cme_count));
 			else
-				WARN_ON_ONCE(evt->gen_media.media_hdr.type &
+				WARN_ON_ONCE(evt->gen_media.media_hdr.type ==
 					     CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
 
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
@@ -957,11 +957,11 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 
 			if (evt->dram.media_hdr.descriptor &
 			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
-				WARN_ON_ONCE((evt->dram.media_hdr.type &
+				WARN_ON_ONCE((evt->dram.media_hdr.type ==
 					      CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
 					     !get_unaligned_le24(evt->dram.cvme_count));
 			else
-				WARN_ON_ONCE(evt->dram.media_hdr.type &
+				WARN_ON_ONCE(evt->dram.media_hdr.type ==
 					     CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
 
 			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
-- 
2.53.0




