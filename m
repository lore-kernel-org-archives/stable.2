Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1332A3E5
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267842; cv=none; b=Hum75p5NHlNCpjr3JwlnHiD4faoI5MZxtP5EgDly0jT8vECAqnK3b3YTS2vPl+MXsIN8hOyFowLYfkJg2pXQg9BZ0ljwNA5cppPyiUliJsWQhSHXQmPa2tH+oUGJ+1Jel026hTt6pWri42yT00ENQQqvfx3bypeiYo6Jny8VtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267842; c=relaxed/simple;
	bh=wpwSdnc8ViWaKcy4Z5gwphrkLrE/cVkoAo7ActZVzjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtUEOySH7AA474fUuL/rUnM0CtmkiZnd874gwd31c6VAsjfpEc5ng9L+oypm3WSgMKrMsgmVSFiy0UFwJbMreV++yPifZbU8HjFPSjquCiQTH3iSYqLII4sggpbN44CgF+nIx8vdArKWphdZ/pCdFfKjb4TxuMVstnTjCWbtrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB46gVRJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB46gVRJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788267841; x=1819803841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wpwSdnc8ViWaKcy4Z5gwphrkLrE/cVkoAo7ActZVzjQ=;
  b=lB46gVRJMtaCrUgv4IwAKzx9tIlU9xZIlwya6aJeSKxFWUjDAr7bGToJ
   C8csgWeE3On4zPnUw41/gAvyOkl+EbjA5MrpOZB/V2FHlqu8PEAwOYnos
   ifiEsnxh3apfKRnWh+0TkmMwQKT0imPvgMbYO6i+rRQpwvY4u/SgnXb30
   cXM/AlKifjJ94/y9CoIxPF1CtvZczwQSfs0YquhKOea+Wn0WGDpzs6ejk
   1KZnGpTMV2gxgEQSBPPvL3DPRebxES14ek9GsnbsC+kqxUloRoKPgn/gT
   ZeF0LrEpx+LVO91W7tGkrhtcGDFas+R1IdWenlGoiYVElTqhan6M4x1nt
   g==;
X-CSE-ConnectionGUID: f/4AhCLbQHW+e5g786l+Ng==
X-CSE-MsgGUID: xsvRCnn1ST++OflREA0obw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88706326"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88706326"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 06:04:01 -0700
X-CSE-ConnectionGUID: 7wbFWFWxR2i3YbtleePvwA==
X-CSE-MsgGUID: pklKA3kHRA2J9mcvi2enAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="271029722"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 06:03:58 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	karol.wachowski@linux.intel.com,
	lizhi.hou@amd.com,
	andrzej.kacprowski@linux.intel.com,
	dawid.osuchowski@linux.intel.com,
	stable@vger.kernel.org,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH v2 3/3] accel/ivpu: Limit firmware log name prints to field size
Date: Tue,  1 Sep 2026 14:57:49 +0200
Message-ID: <20260901125749.404338-4-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
References: <20260901125749.404338-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
Content-Transfer-Encoding: 8bit

The name in struct vpu_tracing_buffer_header is a fixed-size array
populated by the NPU firmware. It is expected to be NUL-terminated,
but nothing on the host side enforces this, so printing it with an
unbounded string conversion would read past the field if the
terminator is ever missing and expose adjacent bytes of the shared
tracing BO through dmesg and the debugfs FW log output.

Print at most as many characters as the name field holds, so the output
never runs past it even if the string is not NUL-terminated.

Cc: stable@vger.kernel.org
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260827102339.281799-1-dawid.osuchowski@linux.intel.com?part=2
Fixes: d4e4257afa6e ("accel/ivpu: Add firmware tracing support")
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_fw_log.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_fw_log.c
index 4f9055aa9d33..9eafc42120b6 100644
--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -69,9 +69,9 @@ static int fw_log_from_bo(struct ivpu_device *vdev, struct ivpu_bo *bo, u32 *off
 	*offset += size;
 
 	ivpu_dbg(vdev, FW_BOOT,
-		 "FW log name \"%s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
-		 log->name, log->write_index, size, log->wrap_count, log->header_version,
-		 header_size, log->format, log->alignment);
+		 "FW log name \"%.*s\", write offset 0x%x size 0x%x, wrap count %d, hdr version %d size %d format %d, alignment %d",
+		 (int)ARRAY_SIZE(log->name), log->name, log->write_index, size, log->wrap_count,
+		 log->header_version, header_size, log->format, log->alignment);
 
 	return 0;
 }
@@ -123,7 +123,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
 
 	if (log->wrap_count == log->read_wrap_count) {
 		if (log_end <= log_start) {
-			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);
+			drm_printf(p, "==== %s \"%.*s\" log empty ====\n", prefix,
+				   (int)ARRAY_SIZE(log->name), log->name);
 			return;
 		}
 	} else if (log->wrap_count == log->read_wrap_count + 1) {
@@ -133,7 +134,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
 		log_start = log_end;
 	}
 
-	drm_printf(p, "==== %s \"%s\" log start ====\n", prefix, log->name);
+	drm_printf(p, "==== %s \"%.*s\" log start ====\n", prefix, (int)ARRAY_SIZE(log->name),
+		   log->name);
 	if (log_end > log_start) {
 		fw_log_print_lines(log_data + log_start, log_end - log_start, p);
 	} else {
@@ -141,7 +143,8 @@ static void fw_log_print_buffer(struct ivpu_fw_log_desc *desc, const char *prefi
 		fw_log_print_lines(log_data, log_end, p);
 	}
 	drm_printf(p, "\n\x1b[0m"); /* add new line and clear formatting */
-	drm_printf(p, "==== %s \"%s\" log end   ====\n", prefix, log->name);
+	drm_printf(p, "==== %s \"%.*s\" log end   ====\n", prefix, (int)ARRAY_SIZE(log->name),
+		   log->name);
 }
 
 static void
-- 
2.43.0

