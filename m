Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1604CA26E
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646490; cv=none; b=s386JWHHldjhOFhohygr/XLaipMf8ab3uaHrKqgPejNKGB/CRrspV2efdWiHZOJt9MrNkDAzjTEqDxvfqZqE0UM0aS3EHc+JKYN4ksN4gyacApULOjcBztrNIoysqlG9likMsEF7BUa/777w2Y8ulDQUsZVo29ZFoDg+8oMh1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646490; c=relaxed/simple;
	bh=fWgnrkRSzV3iTJaKxD4MbMZU7Wz2+UF2Oy45+HAIfUs=;
	h=Date:Message-Id:Mime-Version:References:From:Cc:Subject:To:
	 Content-Type:In-Reply-To; b=migIN97AbGozqnVOufOKogs419FUQ4LHtwWTXAiqgHqRJG418X5JN+tLlFbM0X+yW10GrVNpeQbToyWe+iuBebGcPyIxcAi1tclGSIXed4oWr9n2PLKIUipQ/z+LyYQiI7NITUKL7g18fttW5qWW7F6REOmAw6RaEQu4GEh3mMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H4MtF7WJ; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H4MtF7WJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784646477; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=chb98wWyV6M5j90U1EekJ7rKwOP2hJpNlo5H4flsFXs=;
 b=H4MtF7WJl+C8Q9EjYQ3nmLFvuzbj9jILB3jXRYUD4C9uzdIe54V7rQ/lQuXhrzESqNZFam
 H3sUJhYvTFPL3vNbZJmdVPK4StoLEOy52/jWl/a+/buOJ2euyC3kGOXPL2Zl5Wxj4cMA+V
 Wbq8CnDGzZBG1Rh0Nm1ceXsH0Abyl03F3lPoTjCqgZEaqotc+zGLLecL68PrQcDz3ZGcDY
 S8uYppOCm1qdsVH2laHzk6Bzq4ShC6KPC9lD5mvF467I3RzYJnm0GudN4hKCcV1rNI4Da9
 DyPmCgRe3w1ZqXC6UBOACXn3J1Tc6cw9F7RC7+gDxs+f8RPJbI2faleddJSJUw==
Date: Tue, 21 Jul 2026 23:07:44 +0800
Message-Id: <20260721150743.46717-2-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: quoted-printable
References: <2026072029-algorithm-overbook-efa9@gregkh>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.12.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
To: <stable@vger.kernel.org>
X-Lms-Return-Path: <lba+26a5f8b4b+d88574+vger.kernel.org+weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2026072029-algorithm-overbook-efa9@gregkh>

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
index e22b683a7a..2e4e2bcc3c 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -240,15 +240,20 @@ int uncore_freq_add_entry(struct uncore_data *data, i=
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
