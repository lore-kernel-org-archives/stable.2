Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95E2BEFEE
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330865; cv=none; b=dwOE5EILCjRfszpWTSLVZxuSONrGddpUivgB4ksdw3RxXSzc9Hj7dXzhkHmrBYbAr+Vb8B/TDnU0ehyca8bErvTE3jBOBslNv3rmbTT2hk1b9gRJ796YOX4IA55LgK2pGfYd5zyxzkjdyP1cE1qSc5OcKT5qa+r8cbP/VcrUalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330865; c=relaxed/simple;
	bh=AKMN0szB49azcSqo4uiqRatTW6387T8GYKIDqVqi7dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbLMzE1L0NDZQjho9KyVGqSr3xAabQ5rD0wGgV0SrcTbr6EnK0ZapVK48y3228aWGi3PYHOiAumHSvsSbNqgti8KpEv+adJSYDcOKqiGHgYTu7yy6Mi5GN9vJHTGGfyqt3Oe0VlTnRi8+ti9IeqB4dzl2E/zsvYY9cR3BNKz9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FepDpHKY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FepDpHKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780330865; x=1811866865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKMN0szB49azcSqo4uiqRatTW6387T8GYKIDqVqi7dw=;
  b=FepDpHKYtiSCMvmA9x46DBeIaP71vYUl2GR+9oMurvlQmhT8C3EcHFCt
   oF2TQMS9+FS7Awc4wGfcf7ZX3tkU78PaNcf2rgssZ11969LDqWMrG185N
   qcN0e5kjtxREk/oYBzB68fLnPz/J9i4nG2Q2+0F3Nc3KGCbgio7pE2NKk
   A8flcZWlxl8vVzzDE2znL6F9BskA4LyiSRheAndUaSLqwMVQ/YXdNTo5q
   R0HJEHA/75pKxiPXo9KlgGUqQAv1hlu8xFPwh9czfkMyVT2yzk9lkr2/D
   YJcnOTgdRCDRjNQypVTdmfWi4WVxDPTLmZviRaKMWUwge3nEF73Ef4970
   g==;
X-CSE-ConnectionGUID: ZnY5kO18Tb+O4fva/dyhFw==
X-CSE-MsgGUID: u4AB6icQQsmKpDYRkWwa3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="91780461"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="91780461"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 09:20:59 -0700
X-CSE-ConnectionGUID: dmjn0uI7QVyRYIo2oF9DMg==
X-CSE-MsgGUID: Fqd8yWQNQP2vlcwBJV5LfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="239453322"
Received: from akacprow-dev3.igk.intel.com ([10.91.220.47])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 09:20:57 -0700
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	karol.wachowski@linux.intel.com,
	dawid.osuchowski@linux.intel.com,
	david.laight.linux@gmail.com,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] accel/ivpu: Fix signed integer truncation in IPC receive
Date: Mon,  1 Jun 2026 18:16:43 +0200
Message-ID: <20260601161643.229342-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b464b589-2d28-4617-baf0-eefbe14e170a@linux.intel.com>
References: <b464b589-2d28-4617-baf0-eefbe14e170a@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix potential buffer overflow where firmware-supplied data_size is cast
to signed int before being used in min_t(). Large unsigned values
(>= 0x80000000) become negative, causing unsigned wraparound and
oversized memcpy operations that can overflow the stack buffer.

Change min_t(int, ...) to min() as both values are unsigned and can be
handled by min() without explicit cast.

Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
---
Changes in v2:
- Replaced min_t() with min()

 drivers/accel/ivpu/ivpu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index f47df092bb0d..9347f05a2b79 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 	if (ipc_buf)
 		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
 	if (rx_msg->jsm_msg) {
-		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
+		u32 size = min(rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
 
 		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
 			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);
-- 
2.43.0

