Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAF4CA297
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646496; cv=none; b=QvZbO01Pk+/b7qgznInAX5OsS7CyGt3RijzunEZpl7johs1ZZhqGRSdlIS4KNbcZEZ36J0taTtr/YwpkZz6mipY/SVywqDa1Bo2T6MBv1lGYdSK0chKMgfC6DpvgAtVTEqtdKbOQY85+0p0ci4MSWgovBUzy2gNdX67xXmNLxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646496; c=relaxed/simple;
	bh=Mt8uxDwH+8TbCZPX41uejsZSw+kL2Q10CmjR89VebeA=;
	h=Subject:In-Reply-To:To:Cc:References:Date:Message-Id:Mime-Version:
	 From:Content-Type; b=JIerQ9+u2ry1RXTWsqRisq+kbwtjUDwaACOoo3p/z5lBTRnPp6PqOrf2ZJxZwd4SwK0L9oU/4CgylrbtfEh9HvfQGEGPbYsClEbXEK9Pb0IofP5JZMQwzpjt3uPtq6A06amfJbpQ854ILwtjQTu6zYhOsTAEAZLOqgKfAYkPqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jD1WJ3bX; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jD1WJ3bX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784646490; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=7jupb9/qA/1iUMyPg/DToCbmY1q9JhpM5VUE2Q4EmiQ=;
 b=jD1WJ3bXr/jZUtwJuxwyO1DUVSs/8NXiHj/uJsUZ9FpCMyHOBxkuNebgROPHLDZ26hko6Y
 Mn6hqPjlqVXL3RF/K7F5cFPCIWwm0ajLvmFtfy4oNVCcmFSFsj4Cr0NW5gSLyXfJmMk7Ht
 WeMv7PwKyqzW5VHqhXYVPO0zsrs955hpVqWE6AajE0OmZNE4s+imDgkEdfpIFgoP663UfM
 g0OAV+QdRvRQOr/7eY+xj8sWDFfBlmSxFyOrlPLYj/IkL8/TUqbsuxvT4YVxVullAi28Ow
 SR/GWI+Eo/PvhtcJ/dAcKbLshtij5XeicBs9NBJQciqamxQqRiskxM1D3cHyDw==
Subject: [PATCH 6.18.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2026072029-underline-borrowing-0222@gregkh>
To: <stable@vger.kernel.org>
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <2026072029-underline-borrowing-0222@gregkh>
Date: Tue, 21 Jul 2026 23:07:57 +0800
Message-Id: <20260721150756.46921-2-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26a5f8b58+9d54af+vger.kernel.org+weiguixiong@bytedance.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.50.1

commit 6b63520ed14b17bbe9c2103debbd2152dde1fba3 upstream.

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

Fixes: 4d73c6772ab7 ("platform/x86: intel-uncore-freq: Conditionally create=
 attribute for read frequency")
Cc: stable@vger.kernel.org
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260602020752.3126-1-weiguixiong@bytedance.=
com
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 .../x86/intel/uncore-frequency/uncore-frequency-common.c   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-c=
ommon.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-comm=
on.c
index 65897fae17..6091b61748 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -274,15 +274,20 @@ int uncore_freq_add_entry(struct uncore_data *data, i=
nt cpu)
 		sprintf(data->name, "package_%02d_die_%02d", data->package_id, data->die=
_id);
 	}
=20
+	/*
+	 * Set the control CPU before any read path so entry recreation after CPU
+	 * hotplug can populate read-only attributes from the new online CPU.
+	 */
+	data->control_cpu =3D cpu;
 	uncore_read(data, &data->initial_min_freq_khz, UNCORE_INDEX_MIN_FREQ);
 	uncore_read(data, &data->initial_max_freq_khz, UNCORE_INDEX_MAX_FREQ);
=20
 	ret =3D create_attr_group(data, data->name);
 	if (ret) {
+		data->control_cpu =3D -1;
 		if (data->domain_id !=3D UNCORE_DOMAIN_ID_INVALID)
 			ida_free(&intel_uncore_ida, data->instance_id);
 	} else {
-		data->control_cpu =3D cpu;
 		data->valid =3D true;
 	}
=20
--=20
2.39.5
