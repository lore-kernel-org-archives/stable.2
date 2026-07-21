Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A73998A4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643492; cv=none; b=QaO2ueoAx0d/783+xp24Z2q+qwg8K7i/aF5Zowz87P4GnEzGGz9QwaU5FWu4t0hkLOsXXfJAffV5WT7VnMsZCEKHM4Stme4KpVSn80aghus+adMHZeOeHM/R/BG+RlY8G4U03wyFaOqxNKF3PNXjIEvimU+ym6jKbyUIuMA/J80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643492; c=relaxed/simple;
	bh=gEjN0uI9YII7lRFmyaYGkz0Fi0JXh4QKLzhdPW0lYck=;
	h=Content-Type:References:Cc:Subject:Date:In-Reply-To:From:
	 Message-Id:To:Mime-Version; b=YWupGUHMtwAs2EaEz08HBOEExiyD/8kQ5hl9XfXhGT6gdQab02Mc+rtLDK5ZkleP3WH23HZO+exgsN4fle9fz+wLxmzcoewvupA9Xa+AKOVwJtWSuKcinJNmZ8WtB6EuOIQ8sPIxmxIMmhAvkMpaup8fNb7/6uVowN7kaWuO8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eTrvbmGZ; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eTrvbmGZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784643479; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=CZsVABQ5SRnceG8H1DwXtiD3w3I0tva6PZciMHzdQSc=;
 b=eTrvbmGZeMA2dLl8z20dgH5EUN+umf8/7+af9pGZ20PJw5/WO8aPAaq2Xbb5xkB5YdAFlD
 iHCdRY7X/2mRgkyTTS3NAcVtwFKFAtWB05NDoGZP2ALsUwIx5X3ZTy7rm7ZidnQF1QJf7r
 CeX5jBgA2Kp7UYGVdF+UV2ClT+fY4zrdeYM8yQS+L9U/q4w6XxOwSZhl+NyIe4PcUS2DbO
 9i/U9bMiWyFZQqd0i/9cR8I/5Ac3N7JO8tJ6V6wclfc1FyJG2xoOR6t40nJx5elzp1ub4n
 MePqHFznOiORUaAyLfBMjhchDUNO8Tpum1e/wyFSDyao8xJIoIUXEpvjmjR/PQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2026072029-unburned-worshiper-06cc@gregkh>
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7.1.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Date: Tue, 21 Jul 2026 22:17:44 +0800
In-Reply-To: <2026072029-unburned-worshiper-06cc@gregkh>
X-Mailer: git-send-email 2.50.1
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Message-Id: <20260721141743.28158-2-weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26a5f7f95+975dc3+vger.kernel.org+weiguixiong@bytedance.com>
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
To: <stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

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
index 7070c94324..f8137ee92e 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -275,15 +275,20 @@ int uncore_freq_add_entry(struct uncore_data *data, i=
nt cpu)
 			  data->package_id, data->die_id);
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
