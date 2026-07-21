Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F884D90B0
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646460; cv=none; b=bUA0mbtHBFs8zgLsiIzkI6+zYnVXPB6FpBvu8yfWL/CjmEhyfbhVI02uhUvDuwU4g1zAmC7WIyxTDe9RUUHLh1YLHozinsnKKYivzqLSW84+UTQvNB5QchrUUuAicODTfhxg9UFy6U56TN2xeLL6pPE7ToJsuNmg37DH2dSynZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646460; c=relaxed/simple;
	bh=zGv+ZxbIKhMULgXJZIcfQf9Yr4bxNo1Zqmmu0qUQ28Q=;
	h=Subject:Date:Message-Id:Content-Type:To:Cc:From:References:
	 Mime-Version:In-Reply-To; b=bjlTyWQ3crnZEf10tf694qlPZzywU/26tq1FjeVJCJbNbUSV26OQRl5HieZGORgl+z6/OX6LMErGbOxGoCqTAK3T0y9xgHw7nFqYHHQI1hDsryhjsDh/EYfepQus/AMJUnw12UT+PuIhOfAvRIBol/8xvzizdqmKYg3OEa68pfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=m3LvUV4d; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="m3LvUV4d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784646448; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=2RbBOq1Kwr4ihKn9qjdSSDPQpYDoY1RBbyj60hJpC5s=;
 b=m3LvUV4dFp19Ngb0LE8ffkiHAvzER8WWnNQQWj3koCXCncv09qE51HVhu/DbBpFd4LvUaB
 Rf6DNLHjZizxyT112Qjh6IqkUr5hJ+l3F75C6M5ucnZKN40zIdPynPNK6hOylvqyuy6XZy
 I5DdsA9EEoMmSb5JYIMU1045fVZJunaruil7ocueZoC0Qa8HWY/Hzy23rWKAsvdlcU1y6p
 fX/9jekubZ5h6tJHDsn3YAYGbyqeRm8ElvWm34ACR74vJLt4PgH8kxc5YgeMwVeNb4k5nS
 WeAr0PN8DECfhRBtjGndbYjbxeCZ+eW8pksT3HRvXOg8aJ9D2ISChBqPvct/Tg==
Subject: [PATCH 6.1.y] platform/x86/intel-uncore-freq: Fix current_freq_khz after CPU hotplug
Date: Tue, 21 Jul 2026 23:07:15 +0800
Message-Id: <20260721150714.46115-2-weiguixiong@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a5f8b2e+9ef15b+vger.kernel.org+weiguixiong@bytedance.com>
To: <stable@vger.kernel.org>
Cc: "Guixiong Wei" <weiguixiong@bytedance.com>, 
	"Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>, 
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
References: <2026072030-ashamed-reformed-c254@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026072030-ashamed-reformed-c254@gregkh>
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>

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
[weiguixiong: Adapt to legacy uncore_read() and create_attr_group() flow.]
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 .../intel/uncore-frequency/uncore-frequency-common.c  | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-c=
ommon.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-comm=
on.c
index dd2e654daf..88316ceb4c 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -197,13 +197,18 @@ int uncore_freq_add_entry(struct uncore_data *data, i=
nt cpu)
=20
 	sprintf(data->name, "package_%02d_die_%02d", data->package_id, data->die_=
id);
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
-	if (!ret) {
-		data->control_cpu =3D cpu;
+	if (ret)
+		data->control_cpu =3D -1;
+	else
 		data->valid =3D true;
-	}
=20
 uncore_unlock:
 	mutex_unlock(&uncore_lock);
--=20
2.39.5
