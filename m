Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB45423A83
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948761; cv=none; b=Dt+4238JuBRG7Okoe9a46SY1c4Ln+oiPukGjX9cPASawg4gNe/wszQ7FX4vE3Q8AxbvcXGv+v4FeAkzoy0mZZp/6bKo4t0tcClMLQgRy56nCfje0CxBRKs8t/KMGLubYAWlraHhVLCMy8pbsEnCWSt/kN1nytngUiV1m/Y2qaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948761; c=relaxed/simple;
	bh=V1jJVDI43nwnbgfC5RJK9V+VL3Vpqe0Ys4fomzAHG8I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OqYG1x7tmITP4Hc9PI0APJVBEfGi+47zIfzHgPQ8llmYdvrG4FKCqCd6b09Y+jFYxsIXaG9uhxDc4tO1ojc9/zuPXyy5dQZ/sTgEHq3nYFAYzW3HEQWbdtvdY8baZwFi7H3l56sS/0s39IosRHgRXBunWL4jx2hRK1FjH9grCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kGDdsDEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kGDdsDEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC301F000E9;
	Mon, 13 Jul 2026 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948760;
	bh=z4KyfO8k3akNQ59Fhh3TtQebW/dHbwXgaryR2qIQpR8=;
	h=Subject:To:Cc:From:Date;
	b=kGDdsDEXbhnAWxPCRFz3zytTwy0WIvlggOY1SYpT6MtEKf512tr/xeXF9MRMZV3xf
	 BXLp5B+KQyDQc3M3kNuw71LIIbPhMqngKs3epM+OKwI+vRAv6LebEdGRdpXalcSNTa
	 gJkHTgolqn7/QETc5jBg9Nnl+ionYC+jXYZ7FMsA=
Subject: FAILED: patch "[PATCH] x86,fs/resctrl: Prevent out-of-bounds access while offlining" failed to apply to 6.12-stable tree
To: reinette.chatre@intel.com,bp@alien8.de,sashiko-bot@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:04:57 +0200
Message-ID: <2026071357-shifter-degree-6c12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fc16126cc11d9f507130bf84ab137ee0938c900e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071357-shifter-degree-6c12@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc16126cc11d9f507130bf84ab137ee0938c900e Mon Sep 17 00:00:00 2001
From: Reinette Chatre <reinette.chatre@intel.com>
Date: Tue, 9 Jun 2026 14:02:27 -0700
Subject: [PATCH] x86,fs/resctrl: Prevent out-of-bounds access while offlining
 CPU when SNC enabled

The architecture updates the cpu_mask in a domain's header to track which
online CPUs are associated with the domain. When this mask becomes empty
the architecture initiates offline of the domain that includes calling
on resctrl fs to offline the domain. If it is a monitoring domain in
which LLC occupancy is tracked resctrl fs forces the limbo handler to
clear all busy RMID state associated with the domain.

The limbo handler always reads the current event value associated with a
busy RMID irrespective of it being checked as part of regular "is it still
busy" check or whether it will be forced released anyway. When reading an
RMID on a system with SNC enabled the "logical RMID" is converted to the
"physical RMID" and this conversion requires the NUMA node ID of the
resctrl monitoring domain that is in turn determined by querying the NUMA
node ID of any CPU belonging to the monitoring domain.

When the monitoring domain is going offline its cpu_mask is empty causing
the NUMA node ID query via cpu_to_node() to be done with "nr_cpu_ids" as
argument resulting in an out-of-bounds access.

Refactor the limbo handler to skip reading the RMID when the RMID will
just be forced to no longer be dirty in the domain anyway. Add a safety
check to the architecture's RMID reader to protect against this scenario.

Fixes: e13db55b5a0d ("x86/resctrl: Introduce snc_nodes_per_l3_cache")
Closes: https://sashiko.dev/#/patchset/cover.1780456704.git.reinette.chatre%40intel.com?part=9
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/16137433df42f85013b2f7a53626795cbd6637b9.1781029125.git.reinette.chatre@intel.com

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 03ee6102ab07..569894d6e5c8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -259,6 +259,11 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
 
+	if (cpumask_empty(&hdr->cpu_mask)) {
+		pr_warn_once("Domain %d has no CPUs\n", hdr->id);
+		return -EINVAL;
+	}
+
 	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	hw_dom = resctrl_to_arch_mon_dom(d);
 	cpu = cpumask_any(&hdr->cpu_mask);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 0e6a389a16bf..a932a1fea818 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -135,10 +135,10 @@ void __check_limbo(struct rdt_l3_mon_domain *d, bool force_free)
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
+	bool rmid_dirty = true;
 	u32 idx, cur_idx = 1;
 	void *arch_mon_ctx;
 	void *arch_priv;
-	bool rmid_dirty;
 	u64 val = 0;
 
 	arch_priv = mon_event_all[QOS_L3_OCCUP_EVENT_ID].arch_priv;
@@ -161,22 +161,27 @@ void __check_limbo(struct rdt_l3_mon_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(idx);
-		if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, arch_priv, &val,
-					   arch_mon_ctx)) {
-			rmid_dirty = true;
-		} else {
-			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+		if (!force_free) {
+			if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid,
+						   entry->rmid, QOS_L3_OCCUP_EVENT_ID,
+						   arch_priv, &val, arch_mon_ctx)) {
+				rmid_dirty = true;
+			} else {
+				rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
 
-			/*
-			 * x86's CLOSID and RMID are independent numbers, so the entry's
-			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
-			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
-			 * used to select the configuration. It is thus necessary to track both
-			 * CLOSID and RMID because there may be dependencies between them
-			 * on some architectures.
-			 */
-			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->hdr.id, val);
+				/*
+				 * x86's CLOSID and RMID are independent numbers,
+				 * so the entry's CLOSID is an empty CLOSID
+				 * (X86_RESCTRL_EMPTY_CLOSID). On Arm the RMID
+				 * (PMG) extends the CLOSID (PARTID) space with
+				 * bits that aren't used to select the configuration.
+				 * It is thus necessary to track both CLOSID and
+				 * RMID because there may be dependencies between
+				 * them on some architectures.
+				 */
+				trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid,
+							      d->hdr.id, val);
+			}
 		}
 
 		if (force_free || !rmid_dirty) {

