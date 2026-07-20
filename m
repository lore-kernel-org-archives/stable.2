Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80588432E68
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559830; cv=none; b=KdJ7Sn14xJBUACa+hU3yskRrg5xnjNrsY5GgbRYTdQslqR0qx9mcvOCV5dr1axCABdo1xYKsyKd6ToJUchqCNrBNM5hq8Ddyqzy4m4w4zEaPJRqWiz/XqfPP99klczXViUjW+02tedBUzDD9bHEcSeSOAuudtZAVFwuQifCyN8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559830; c=relaxed/simple;
	bh=HZ8IeTVsFu1Pn6OQNuKwpO9aSawJ73gPCxTfxMD5aR8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LFdkXQXvOw95lJVcnWS+kfFXN5WL/KDwbFo6cscEQYWAuriVXZcezjT9/boK0/GyUg9+yngoQFUUP2MjFzoR5o1LWwgJjsoEWCS4LKzz/56wz2biwn7oYihVnpbYEXQOlKeA4Qlr6udsfG2dKT3SoxiKjLY2r8cEBc0gc4+i6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ruw+xpXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ruw+xpXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B335B1F000E9;
	Mon, 20 Jul 2026 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559829;
	bh=yjTs+efapDIyZA5se2wEbL14WRk8aVDISWpfhZRmlFk=;
	h=Subject:To:Cc:From:Date;
	b=ruw+xpXsBeEFxJmeUF9ZF4ZETCOjxk1qoP8C0gekFXziLpwqjk+eeCTgWp20SqKUd
	 wV64qzAaUWNy/+QxH20L+X2FePFsn626EXzfAau0CuGxuJ5EiVsGc1Ee3t1XADTRHB
	 CTwpxqLURrbEo4cnW8OZvIE8D7A7U5oasqggwQt0=
Subject: FAILED: patch "[PATCH] platform/x86/intel-uncore-freq: Fix current_freq_khz after" failed to apply to 6.6-stable tree
To: weiguixiong@bytedance.com,ilpo.jarvinen@linux.intel.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:03:30 +0200
Message-ID: <2026072030-guy-reborn-3b8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6b63520ed14b17bbe9c2103debbd2152dde1fba3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072030-guy-reborn-3b8c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b63520ed14b17bbe9c2103debbd2152dde1fba3 Mon Sep 17 00:00:00 2001
From: Guixiong Wei <weiguixiong@bytedance.com>
Date: Tue, 2 Jun 2026 10:07:52 +0800
Subject: [PATCH] platform/x86/intel-uncore-freq: Fix current_freq_khz after
 CPU hotplug
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260602020752.3126-1-weiguixiong@bytedance.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 3b554418a7a3..4bcafedf68ef 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -285,15 +285,20 @@ int uncore_freq_add_entry(struct uncore_data *data, int cpu)
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
 			ida_free(&intel_uncore_ida, data->seqnum_id);
 	} else {
-		data->control_cpu = cpu;
 		data->valid = true;
 	}
 

