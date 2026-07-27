Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E6345CCE
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195268; cv=none; b=gjtgKfs4iKLpe8psij4mGVcJbulx8Smi8IqiiMYJVzle8LhlOZkwGbJxoUJSY07JKC4HV4RmCLTqllbKsj002a17LQa+YxhykNh1a2M/CIGf7zR4cXbNUspj9BwlNRR8cog9gENE7MLQgz7aTxR4rZA4BheRp9oI+Fpt3WHVF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195268; c=relaxed/simple;
	bh=hWXCpFQwMvmfKBDApZ62Z8e9RhlJHdB2n+bxBUOS/7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic3pdSDa2PLqt7ShsxUbE7zb/f30aIGnBAQHJOGWdFzMu6nPVzeswj1IPWmWw31KclbDOkiQa2tejiIDpct+Ym52J/wOgjAIHi8j2j/kPQv40QrTAPUhPDXcReXyy32HA1votNsKbh/taWnL//4osxrdXA5Omwj5LRtFp7htmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW69P9Qq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW69P9Qq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FB81F000E9;
	Mon, 27 Jul 2026 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195266;
	bh=sS/qLmfsTwC/g8T3/bB/BpSpM89lMSbYz2HazhHs+lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QW69P9QqOikoZQXI5hML122yVQzpapEGefq+SvxtCrz75xcp1jZfjNlw980sb63XO
	 etYfvzevuW361HtOOwbepHQIq071NIUYURaOG5NP39XJjWJN9tMJeoX9glO3/18eeN
	 OUNfpu74qhNs4tDoSFPvc5X98aVuiNJyMwIvSMitFxfIP51FRQM3TNulzbCSzl88BQ
	 JqH820Iu30orVvyiLSbhyKjhsutjPv5Z3+5f7mWOTUVYIOWCBFex0EgzMdaVyxaY+2
	 +I3+snuqBeWn6/vCtARGnnbiORpqh7gJI9RIrIMFKLJva/4+kvzCCmEMoQ2h6Yei8C
	 xQ1wKTsR8q57g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] fs/resctrl: Move allocation/free of closid_num_dirty_rmid[]
Date: Mon, 27 Jul 2026 19:34:18 -0400
Message-ID: <20260727233421.2423844-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727233421.2423844-1-sashal@kernel.org>
References: <2026072028-reverence-sandy-7415@gregkh>
 <20260727233421.2423844-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit ee7f6af79f0916b6c49e15edd4cba020b3e4c4ac ]

closid_num_dirty_rmid[] and rmid_ptrs[] are allocated together during resctrl
initialization and freed together during resctrl exit.

Telemetry events are enumerated on resctrl mount so only at resctrl mount will
the number of RMID supported by all monitoring resources and needed as size
for rmid_ptrs[] be known.

Separate closid_num_dirty_rmid[] and rmid_ptrs[] allocation and free in
preparation for rmid_ptrs[] to be allocated on resctrl mount.

Keep the rdtgroup_mutex protection around the allocation and free of
closid_num_dirty_rmid[] as ARM needs this to guarantee memory ordering.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
Stable-dep-of: 52fce648607e ("fs/resctrl: Fix use-after-free during unmount")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/resctrl/monitor.c | 79 ++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index fcc155eb5cac32..cefa15ce2823a4 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -865,36 +865,14 @@ void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long del
 static int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
-	u32 num_closid = resctrl_arch_get_num_closid(r);
 	struct rmid_entry *entry = NULL;
 	int err = 0, i;
 	u32 idx;
 
 	mutex_lock(&rdtgroup_mutex);
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		u32 *tmp;
-
-		/*
-		 * If the architecture hasn't provided a sanitised value here,
-		 * this may result in larger arrays than necessary. Resctrl will
-		 * use a smaller system wide value based on the resources in
-		 * use.
-		 */
-		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
-		if (!tmp) {
-			err = -ENOMEM;
-			goto out_unlock;
-		}
-
-		closid_num_dirty_rmid = tmp;
-	}
 
 	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
 	if (!rmid_ptrs) {
-		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-			kfree(closid_num_dirty_rmid);
-			closid_num_dirty_rmid = NULL;
-		}
 		err = -ENOMEM;
 		goto out_unlock;
 	}
@@ -930,11 +908,6 @@ static void dom_data_exit(struct rdt_resource *r)
 	if (!r->mon_capable)
 		goto out_unlock;
 
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		kfree(closid_num_dirty_rmid);
-		closid_num_dirty_rmid = NULL;
-	}
-
 	kfree(rmid_ptrs);
 	rmid_ptrs = NULL;
 
@@ -1757,6 +1730,45 @@ ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,
 	return ret ?: nbytes;
 }
 
+static int closid_num_dirty_rmid_alloc(struct rdt_resource *r)
+{
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		u32 num_closid = resctrl_arch_get_num_closid(r);
+		u32 *tmp;
+
+		/* For ARM memory ordering access to closid_num_dirty_rmid */
+		mutex_lock(&rdtgroup_mutex);
+
+		/*
+		 * If the architecture hasn't provided a sanitised value here,
+		 * this may result in larger arrays than necessary. Resctrl will
+		 * use a smaller system wide value based on the resources in
+		 * use.
+		 */
+		tmp = kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp) {
+			mutex_unlock(&rdtgroup_mutex);
+			return -ENOMEM;
+		}
+
+		closid_num_dirty_rmid = tmp;
+
+		mutex_unlock(&rdtgroup_mutex);
+	}
+
+	return 0;
+}
+
+static void closid_num_dirty_rmid_free(void)
+{
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		mutex_lock(&rdtgroup_mutex);
+		kfree(closid_num_dirty_rmid);
+		closid_num_dirty_rmid = NULL;
+		mutex_unlock(&rdtgroup_mutex);
+	}
+}
+
 /**
  * resctrl_l3_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -1777,10 +1789,16 @@ int resctrl_l3_mon_resource_init(void)
 	if (!r->mon_capable)
 		return 0;
 
-	ret = dom_data_init(r);
+	ret = closid_num_dirty_rmid_alloc(r);
 	if (ret)
 		return ret;
 
+	ret = dom_data_init(r);
+	if (ret) {
+		closid_num_dirty_rmid_free();
+		return ret;
+	}
+
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
@@ -1823,5 +1841,10 @@ void resctrl_l3_mon_resource_exit(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
+	if (!r->mon_capable)
+		return;
+
+	closid_num_dirty_rmid_free();
+
 	dom_data_exit(r);
 }
-- 
2.53.0

