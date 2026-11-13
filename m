Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794545712;
	b=CVYYaW8EOjpLtcC3tgd5AWeuqy2In6/b/7POzyjzOkZiXH/cMIaXm6Vnyz+761l50GBb
	 EwFAYLaaLkh1xyn+UYs5PC9Y2/lei7bqSsjZfLDvdtpyZ+FskECHkxAvOVkCbHciyXTgC
	 /a995uOtLuFTIIjHz0tC4+dwYSaJzdcLSA1NKlJe1TIl9lJ7ln4oxifekMvT2gPHTYVt9
	 +XatIY/B3njE1n3xzSmGCwzOGryGahTmTJYC1s9i0XSDc1Fk2EflXgUjtAvjRH3CmdZga
	 zOxZdj4OGBJPg1LmnopGBr0RaZ8EW9RHNZVNqt0xeF/Jpw4VZyTaHHiYHj6sOz+spNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794545712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VTWR5mkpuIgueh87MON9g3ptDUiISJcOv6zs0rvvEGI=;
	b=n7UX5/SfViuKLbGdRZgwQv8Hwa89m48guSbDHkMvpqrL8kfjhfRQrw9EUR9tUAsRyYqO
	 CkRv1Hhna0/iFMCxaACGDpP6U+7oP/saWoJYCHDuK/Ydmhd+WmjXIAvKARPEBSJh85pJ9
	 1IRGb16pPaBYMd4Uo5MOpSCdaugN24osNCNhVPxsqcG2/bDvzglhtTuPcL/6YqV/nEYaB
	 YPx9LYu32gz43ICngwelz/QPL965IAloi2JhJrnCeWq1D8B7r6ajZbj0RTixitbTDBjFr
	 umP1No9ahYllfGU71hwKn54CvXbOgfHMwCExJF2Bv6L6F+u8LU8NDta8F9CMm5VI+ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5Dp50SO;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B282606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B282606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5Dp50SO
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9995ce866so8633165ad.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794545711; x=1795150511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTWR5mkpuIgueh87MON9g3ptDUiISJcOv6zs0rvvEGI=;
        b=o5Dp50SOZkUrzjKbIIU8LlnPQjbFGb16tD2KhJeRlPSr6wee5OnvJ51J9zKJX6C83a
         MG6APBbNkBwKu3WPc4Ygh4ByhnF33znwc5M0bcsbkXnAWe5Lw+XKkpYgAGjJDf/yKqSV
         eUaIYDdSAKsoCDUDEDLnL9wtGr3D/4QdG9FUNQJaW7YnRSRN9gtu1/vpzOBQllMNL2mj
         pxM79K9zH/lil7gcQXc3v4qarmSjXu//xvIJHUg/y+rc31B/pZosOxcBu4DErd6LDGKf
         IM2VatuMQFJdWVBKcVB4RvY0JeTdobbMXFfQu0qqyLXUxPp28zFpNKquw85v+mCDq/8w
         4iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794545711; x=1795150511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTWR5mkpuIgueh87MON9g3ptDUiISJcOv6zs0rvvEGI=;
        b=0wPHUHHBMAP99I/J8381gvtNMzCeRVupH77IgfLGkU9VoARw862P5QEqUR1zbgOYyq
         FW6hwuE2ZmslTCwIMxpQUCb7NIge3ojHk87qeTHT63W7I+xKPE6ORKhuAHrOilF4KNRI
         ytwfllE5rLXhZqo7uzZvkVRE8s+J7RRnSmJIndLrIKI+fht96hFlp7QjHOOsxh6I6Rc5
         SReAS/okM7AaAcDIqNygWkJk6EWuq86Ngzd+eXeamZq7oofBBFeQbGj209D8HVdtWYxu
         EC+iV2v5/rhbwFfmynHxWZsqBYZFBdCA2F+wzA7ZskHW93eIl0AjNbpCqHThJIMgH//3
         DjlQ==
X-Forwarded-Encrypted: i=1; AL+hErGeJWKBFINL9WmzH/Bhbx8vNNdkLR5BEqL7InjCAvGeKvLGFnbzmnYrfR3uzYqgvc6/b3PQitw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9n0LHrRtcKJohuIpPVMV98z3SMQy3v5L9uoV9ijGDRFz6g9RCp
	623hlLKoetUQNWNK2qYKBFOiFI1vIMrXMc8Dr22MRpz3HVoTaPWQa+qD
X-Gm-Gg: AYBFou2qRhO503gRh3btgIbNLhru3TzYwks1XQvCxP1ziSdmX0dqobaAohMhdHkCJXr
	Hty1IqpqmcILVozPsG4V5P8YtIG+ugiDXuAv8gPe7gl30lTiSXB09pqQkDVP/nQg49vbjwisBSf
	j9d8vXOGFYrpvet4zyRo2qtjp+oteMdkMZbwRltBrsr6BjOHGIFVglpaXiWCy6AHuvL14UGCVLt
	CTx+ACp90eeV8VWf+5mYmd2ENBj1lIMf428SqGXUQhDRL41lBX3/y9KC6raktzpdVhdVwzITSZs
	/gRMy0fqZuE2arloz4KPQqJBEhmgEWQk2NOW2eimA/dLId0UjIOsnr3VPXvy9eT0REO/I7o95C1
	9ICuh7Ij6DltwUSnFhd6BCvz3Fgw1Od83RCslNgEup+FkdFVVLsRB0uwsBJPwRH+rHKIBjUmERc
	ez5yrFvnRUHdVAGtsgywChQmBoPRepjWXdq2n7IvA4V5zmibu0pb/0kwRldHlUjsAjt75yCCbSc
	BltWLT//G+/UrqeD8D4TkqqFE4HhfuRScwInaYyaXjxpGcj5XBYt4CAIyOaD6+LLwayeb0RdMmD
	W3jQF0i+jFaX4aOQRmQ6JZDG0tw7Ef61m0qbXBlVlkpXB0Kdknm/14I78Oo/rKYJyrKQCcW2pIs
	KZN+as0dRfNxi53MXNSSuu0BHACvsPVy4+mK6QBUpE6KbkNeEO5ZP5uA2u9fYh3ZF7g3nd845YW
	F2
X-Received: by 2002:a17:902:f688:b0:2ed:379:158d with SMTP id d9443c01a7336-2ee0da98d27mr14360145ad.9.1794545711133;
        Thu, 12 Nov 2026 20:55:11 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee10bdd1a4sm3805145ad.11.2026.11.12.20.55.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 20:55:10 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] thermal: sysfs: take the zone lock in the tzp attribute handlers
Date: Fri, 13 Nov 2026 14:55:02 +1000
Message-ID: <20261113045502.68053-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal zone parameter (tz->tzp) sysfs attributes - sustainable_power,
k_po, k_pu, k_i, k_d, integral_cutoff, slope and offset - dereference
tz->tzp without holding the zone lock:

	if (!tz->tzp)
		return -EIO;
	...
	tz->tzp->name = value;

For a zone registered without thermal zone parameters (tzp == NULL at
registration - the thermal testing zones, ACPI thermal and every driver
using thermal_zone_device_register_with_trips(..., NULL, ...)),
power_allocator_bind() allocates tz->tzp and power_allocator_unbind()
frees it and sets it back to NULL, both under the zone lock:

	tz->tzp = kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
	...
	params->allocated_tzp = true;
	/* unbind */
	if (params->allocated_tzp) {
		kfree(tz->tzp);
		tz->tzp = NULL;
	}

bind/unbind run from policy_store() -> thermal_zone_device_set_policy()
under the zone lock when the governor is switched to or away from
power_allocator.  The tzp attribute handlers take no lock, so a read or
write of one of these files racing a governor switch dereferences a
freed tz->tzp or a NULL pointer.  The read side (0644) is reachable by
an unprivileged user.

KASAN, one test thermal zone, one loop switching the policy between
power_allocator and step_wise and one loop writing k_pu, panics in
seconds:

  BUG: KASAN: slab-use-after-free in k_pu_store+0xd7/0x130
  Write of size 4 at addr ffff8880064e5c94 by task init
   k_pu_store+0xd7/0x130
   dev_attr_store+0x46/0x70
   sysfs_kf_write+0xed/0x110
   kernfs_fop_write_iter+0x29f/0x380
   vfs_write+0x5df/0x950
   ksys_write+0xfd/0x1e0
  Allocated by task:
   power_allocator_bind+0x51a/0x600
   thermal_set_governor+0x86/0x170
   thermal_zone_device_set_policy+0x58/0xb0
  Freed by task:
   power_allocator_unbind+0xad/0xd0
   thermal_set_governor+0x57/0x170
   thermal_zone_device_set_policy+0x58/0xb0

Take the zone lock in the tzp attribute handlers, as mode_show() and
weight_store() already do ("Don't race with governors using the
'weight' value").  The governor already reads these fields under the
zone lock, so this also serialises the PID constant updates against a
running power_allocator.

Fixes: f5cbb182586e ("thermal: power_allocator: don't require tzp to be present for the thermal zone")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/thermal/thermal_sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -258,6 +258,8 @@ sustainable_power_show(struct device *de
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
+	guard(thermal_zone)(tz);
+
 	if (tz->tzp)
 		return sysfs_emit(buf, "%u\n", tz->tzp->sustainable_power);
 	else
@@ -271,6 +273,8 @@ sustainable_power_store(struct device *d
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	u32 sustainable_power;
 
+	guard(thermal_zone)(tz);
+
 	if (!tz->tzp)
 		return -EIO;
 
@@ -289,6 +293,8 @@ sustainable_power_store(struct device *d
 	{								\
 		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
 									\
+		guard(thermal_zone)(tz);				\
+									\
 		if (!tz->tzp)						\
 			return -EIO;					\
 									\
@@ -302,6 +308,8 @@ sustainable_power_store(struct device *d
 		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
 		s32 value;						\
 									\
+		guard(thermal_zone)(tz);				\
+									\
 		if (!tz->tzp)						\
 			return -EIO;					\
 									\
