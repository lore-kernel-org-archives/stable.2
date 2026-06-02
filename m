Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733082EAB82
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365861; cv=none; b=ABIIXtyyVcHmlPlVPzU1Qi6veBXBUce8UQPIb9uEJ/voKfevzWqjKg6HZyUq63+CKwQCuCDMTDLEalXuKpGMQaLFRC6uRScIW3qJptgG0tXeOdhll3fb4BR7MctazVviGuWUVX9WR5fXBhFFqHrNteG5et6s3w1sX2mXkU5PwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365861; c=relaxed/simple;
	bh=rQr4cgGt7UgoL3S4yiskjSogZfneK2pwoMz5gpD/drM=;
	h=From:Date:Message-Id:Subject:Mime-Version:Cc:Content-Type:To; b=kkIqPL15HMQE4em0q9oPabr3+HmVZen07TSuKt6Gr+mzZCRJWXygrLFhGPV3RaQIdtRU98CPVdYzpZVtksMpKaq42msZBhsJmGDL3VlrGKufMVVOI6ieYzJBgJRO4k6Ag7LzUONV/px9a0sFsdYT0MVtxBuXRF+LHGXE4oRuVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=qxRYHkEW; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="qxRYHkEW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780365853; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Qvjk2VPn73XqElxLFraSfA68CbhnrneyArfCJ0SS8VY=;
 b=qxRYHkEW6WjeRvVLtRZJ7MJeXRMInavGB4QS4MOrU6rarJlrlcx3zaK203ORIjy2oYA3Ij
 XcfkiPommeZC3L8jwb8PMYs7ojAoNego2xVtdl/7oCVn949CVv8+JwY9qBPm4bHz/EIRka
 S5dmH4YI6I+1PSBWQ0XTvWsobBI/FOWhUjfl1L3yjLc8Hl2a0xXAdGvLXWDyB0PKrgmnet
 eBDaD2FNQ6Yy0Cc3q+SxXh9u3ZQi5ATzTVFBP+G56l0+h6Mvqlj3Md+qx9Qf75YNRirE43
 bUBirqtI+DcgUj+MCdVlU+Z7WKBg92MkJwAExjeiui+R8BpdpTDXsLVD4j7YmQ==
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Date: Tue,  2 Jun 2026 10:03:59 +0800
Message-Id: <20260602020359.1444-1-weiguixiong@bytedance.com>
X-Mailer: git-send-email 2.50.1
X-Lms-Return-Path: <lba+26a1e3a1b+dc8de1+vger.kernel.org+weiguixiong@bytedance.com>
Subject: [PATCH] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <stable@vger.kernel.org>
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <weiguixiong@bytedance.com>

When the last CPU of a legacy uncore die goes offline,
uncore_freq_remove_die_entry() clears control_cpu. During CPU hotplug
re-add, uncore_freq_add_entry() still populates sysfs attributes before
assigning the new control CPU. As a result, the current frequency read
returns -ENXIO and current_freq_khz is omitted from the recreated sysfs
group.

Assign control_cpu before the initial read paths and before
create_attr_group() so sysfs recreation uses the new online CPU. If
sysfs creation fails, restore control_cpu to -1 to keep the error path
state consistent.

Fixes: 4d73c6772ab7 ("platform/x86: intel-uncore-freq: Conditionally create attribute for read frequency")
Cc: stable@vger.kernel.org
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 .../x86/intel/uncore-frequency/uncore-frequency-common.c   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 7070c94324e0..f8137ee92e47 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -275,15 +275,20 @@ int uncore_freq_add_entry(struct uncore_data *data, int cpu)
 			  data->package_id, data->die_id);
 	}
 
+	/*
+	 * Set the control CPU before any read path so entry recreation after CPU
+	 * hotplug can populate read-only attributes from the new online CPU.
+	 */
+	data->control_cpu = cpu;
 	uncore_read(data, &data->initial_min_freq_khz, UNCORE_INDEX_MIN_FREQ);
 	uncore_read(data, &data->initial_max_freq_khz, UNCORE_INDEX_MAX_FREQ);
 
 	ret = create_attr_group(data, data->name);
 	if (ret) {
+		data->control_cpu = -1;
 		if (data->domain_id != UNCORE_DOMAIN_ID_INVALID)
 			ida_free(&intel_uncore_ida, data->instance_id);
 	} else {
-		data->control_cpu = cpu;
 		data->valid = true;
 	}
 
-- 
2.50.1 (Apple Git-155)
