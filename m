Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134B14CA280
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646480; cv=none; b=oSxndnlQqo4D9ejkfBnbp5UoMnGcVSk5NgZDp37pcBUsRe1qheSph4w8OuW3QxPg90paJCKgtH3K963Sh6S/Kc88P62XoYhDbZRzYfZHr5/bdhzIIV8BKxIXe8nq7+ZD5ffI05L1uZK93JV8G+IjTBG2vZNgj76THmkTIDHSscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646480; c=relaxed/simple;
	bh=gm2jOPStbq32/mbAPJlAsOpDjpz2skZzAiQfSqpB+e8=;
	h=Cc:Mime-Version:Message-Id:To:From:Date:In-Reply-To:References:
	 Subject:Content-Type; b=dXW06E2QuGqrrutFov5s3gUCQOtdUD1JjYjksfF6A3PEs3zqu9JJkJPsCYmfwnPNx1bBNpOe8KkSZ1WXfcvf0+tJxT5CX9YukDlCNfCUou7dB3GZM/xY8nJeQZxJz9DzS7+gkZWTS7n4kMX7hxfyTuXhlV4ohHr9//Y3vFCDzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lxIOxhfQ; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lxIOxhfQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784646464; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=p0ZgvsGQKvayJQq+KCh49kxQgFcdkyYPkCoBPb3jghs=;
 b=lxIOxhfQJY+GU+oaVcUvgs+CFKW7hvbxexg1QcJbmzVDhogXXQpiSqlE9Uvg0ZUp006xhD
 Bu0LnT/Aencrq2VywMqZQMgcIhSFSsR2iWa68nxo+ejovc/5R5gT8UeaGgqhOq8t6Bj51X
 AtKxRg2Ehmbzh3K6cOX/9EtdyEhBTfbBhf362wCW+6i4e6QuLSJTyfpPj2xThp8/wg+Xpy
 bNpTGtHZEWzYtnI6ienGOZrA2qiUEhWIN65DyN4VWF5EQXcQj8Jm9qaMUWsRuhSxbd3cho
 7J5zJCk3UBbBgzmgYE4hd/aleDEBI8rGy1R/ULC9iG7tyxiYAMo0OwI20hmHuw==
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <20260721150727.46546-2-weiguixiong@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.50.1
To: <stable@vger.kernel.org>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Date: Tue, 21 Jul 2026 23:07:28 +0800
In-Reply-To: <2026072030-guy-reborn-3b8c@gregkh>
References: <2026072030-guy-reborn-3b8c@gregkh>
Subject: [PATCH 6.6.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Content-Type: text/plain; charset=UTF-8
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26a5f8b3e+1ea9d2+vger.kernel.org+weiguixiong@bytedance.com>

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
[weiguixiong: Adapt to legacy uncore_read() and instance_id naming.]
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 .../x86/intel/uncore-frequency/uncore-frequency-common.c   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-c=
ommon.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-comm=
on.c
index 33bb58dc3f..b362e0170a 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -238,14 +238,19 @@ int uncore_freq_add_entry(struct uncore_data *data, i=
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
 	uncore_read(data, &data->initial_min_freq_khz, &data->initial_max_freq_kh=
z);
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
