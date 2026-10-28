Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793146831;
	b=fKZLkbb2iOOKcs1L5J+R2K/stEODndApGF/0e2sEvMINO0WTUB9T31vbp1mOKqCa3yX2
	 dmRpw1841Qco89ioxLFJdLMRkWV3v45TkfN9X326UQfnBTR18Hd/TOYymySaAkYEoXgFD
	 GoUY/rm6Qu4luft8loT9qnFaJ45NKxVyj3i75dDxHEAdJOjw6/JXIxdJ20ltIGUQy0Fme
	 KfJP8Qnh7j8Gb1oAoXLWYj5ETcM1dLVy0EWyRkrdIlw6JhGPVn2/fFNKf4Euu6G6Nzrb6
	 k6AMhd80FW6JzCK4MXNzvbE4yLDvml8sRVSqoCVbTWt0iPEZO4PuzbyIIEVXw9EhULQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146831;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ySeCeIUpErYVpErE4W6SOlDRjZS0sOGTZt/5WyOWbXU=;
	b=TIfvB0nXbHS7I+14rtBOsH2k4tVqL4mKzMKVr3NCG5JQIMGrkMakwdkO5S0PNx8XphPE
	 jxIP8UsQdShIokaSTyBful4Lyh6z2VgDfLP3ktkaR/qDrrN40VCwRnyrW/BTe7ad0NdvT
	 lNQ+iJ8OwO5BAa+sD0MaAAaIiLXOQUHwC/ktfJcGNQQEEccIpaHL3sqdNINEIB5oURMu1
	 /hCbb6Ejl+CNahb8pHcrvhpkSt1fM6iX6zhguDwPh8g+CWuAtyd6PPxQcN9uXJyZBoM4P
	 gPqAAsmqjbordFIpXWQAquAC/wBO/tw2tYcB0fIiPanhiLH+qlf9cOoHyN0gwpt5nbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vrsf1Lay;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1C606A31D;
	Wed, 28 Oct 2026 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vrsf1Lay
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793146831;
	b=H3Io0UHu9M/oqI/kQhMAkWK2Q92tn61Y5/qE3CrklEewAeyjU5j9yAsZ6okpyQTWsymg
	 pdYpuGXhiS+YVrLotZ6zxS/yYVmd2FeNTHe8FJkF7iJxX7p2rKBK5vyK7iHk1D9Bdw0yN
	 VeQPnjgCEPiwr8UzTe9K6euSjoQ7N5pF4n9F4zwV2VluxtFr0xbxM4h9XGMPOwzIKuAmX
	 dhdmblHnx9zeFRPYkdIh8lKEyYIhZ++/0RqmLzfrmXBvp5XDKQX+s9Wj666Ioc3RUbL97
	 429vaUFif5ySAvU/IdMk8GJi4lOzRprBkE2hRu0o2dfHQw0qUKQC3wAqN+t+udHYUpQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793146831;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ySeCeIUpErYVpErE4W6SOlDRjZS0sOGTZt/5WyOWbXU=;
	b=R/lbomaO2s6I6KfJV0rnIykH7HoknMFm9tdh0xgokRRTd/q+WX49i+YNeY5HzmRbov4Y
	 mw2foJnjb0xfAco+A9ZwbAbdJZfPDrLk/jqka+kEcthLPjQePqbLq5aTmk6qsSA/dzQ8W
	 haovl/ZBLFfPXyYywjx9aMOLTrv7ifSdwKu7eKPaPTQHHKzqR9FayYEtlFReYMfhMfH6f
	 UXxDHzHYcdR29JfTw1pUUKMfu//KjSHvNi4qGVnpXC0t/FL4+LhMO4ETxme1bV39EesW5
	 hy3mHqopSdC9GGtJ7b6x51VBfvs7mHv8OAyooYqMq8zCRMeZDI5qXdLjXctrXpP2xLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC70B1F01825;
	Wed, 28 Oct 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146831;
	bh=ySeCeIUpErYVpErE4W6SOlDRjZS0sOGTZt/5WyOWbXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Vrsf1Lay/TmrIqKE8SlRXkufI4sx7dB3YkXKveJTct5WWryPQ138LhsMtKyIX0gpM
	 DSCV29vc4kPQoZH6HqGTX63WZ62IDGeURYRbX0PxE3T3xBS4fQBQfQOVakA7q5cf00
	 vuNO1/WgLa5CTsltWNfpz+tC2gWpsXug8NcOGHXP/MYsq0mPuyoCLYJV2iDxU+V4R5
	 DY22En76650vcysRMBByvax6Xi8KyOX3G+rjqSE5KN876Yd8I5fPWYMVsZEiQAFfuJ
	 QK4vFRYRBed72az/ITXQgVn1qfcwJI904VlWwkWbfz/YM7501vB1+jVmFKqVSOFeTf
	 mnh2dF/08DAxA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2C122452EA;
	Wed, 28 Oct 2026 00:20:29 +0000 (UTC)
From: Jez Ng via B4 Relay <devnull+jez.sfcompute.com@kernel.org>
Date: Wed, 28 Oct 2026 00:14:45 +0000
Subject: [PATCH 1/2] thermal: intel: hfi: Disable HFI on shutdown and kexec
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261028-hfi-kexec-v1-1-956234dcfb2b@sfcompute.com>
References: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
In-Reply-To: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
 Len Brown <len.brown@intel.com>, 
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Andrew James <ajames@sfcompute.com>, 
 John Ranzie <jranzie@sfcompute.com>, Jez Ng <jez@sfcompute.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793146828; l=5162;
 i=jez@sfcompute.com; s=20261027; h=from:subject:message-id;
 bh=dv3+YjTvTdGwFlEMyHW/rKlDFKBOFHdfyscbY7G2KH4=;
 b=17IUNS718UtNc8J4GnqlzzXMBBYEwGHFZrL8mq+4fhWeNKujtWmPphrbKZOcpaKbolPjE16wc
 3NPCe3VNhKnADAO4xZ0EycMqO8XWAZXvfu1p59i6sg49FnvQxAU7DMC
X-Developer-Key: i=jez@sfcompute.com; a=ed25519;
 pk=e8QxvBomwv96udVoo4EZvgPDtnl1YbPysb3vNdKi8JA=
X-Endpoint-Received: by B4 Relay for jez@sfcompute.com/20261027 with
 auth_id=1337
X-Original-From: Jez Ng <jez@sfcompute.com>
Reply-To: jez@sfcompute.com
Content-Transfer-Encoding: 7bit

From: Jez Ng <jez@sfcompute.com>

HFI is enabled per package by writing the physical address of a table to
MSR_IA32_HW_FEEDBACK_PTR and setting the enable bit in
MSR_IA32_HW_FEEDBACK_CONFIG. From then on, hardware writes performance and
energy efficiency updates to that table on its own.

Nothing disables HFI when the kernel shuts down. After a kexec, hardware
keeps writing to the old kernel's table, which is now ordinary free memory
in the new kernel. The new kernel does not reprogram HFI unless a thermal
netlink client subscribes to events, so the writes continue indefinitely.

This was observed on dual-socket Sapphire Rapids systems (Xeon Platinum
8462Y+) that boot a Debian 6.1 kernel and kexec into a 7.0 kernel. Both
packages kept writing HFI updates (a timestamp, a changed flag and one
row per CPU) into the old kernel's table pages. When the inode hash table
landed on one of those pages, the new kernel oopsed in find_inode_fast().
Disabling HFI before kexec made the writes stop.

Add a syscore shutdown callback that disables HFI on every package with an
online CPU. syscore_shutdown() runs on reboot, power off and kexec, after
CPU hotplug is disabled and while the other CPUs are still online, so each
package can be reached with smp_call_function_single().

Do not enable HFI again once the callback has run. On kexec, user space
keeps running on the other CPUs until machine_shutdown() stops them, and
kernel_kexec() enables CPU hotplug again after syscore_shutdown(). A new
thermal netlink client, or the first CPU of a package coming online, would
otherwise enable HFI after it was disabled.

Skip packages where HFI is already disabled. hfi_disable() waits up to
2 ms for hardware to set HFI_UPDATED, which a package that is not
running HFI may never do.

Fixes: ab09b0744a99 ("thermal: intel: hfi: Enable notification interrupt")
Cc: stable@vger.kernel.org
Reviewed-by: Andrew James <ajames@sfcompute.com>
Reviewed-by: John Ranzie <jranzie@sfcompute.com>
Signed-off-by: Jez Ng <jez@sfcompute.com>
---
 drivers/thermal/intel/intel_hfi.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 3273b8fe3d4d..8ff094eccbaf 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -161,6 +161,7 @@ static DEFINE_PER_CPU(struct hfi_cpu_info, hfi_cpu_info) = { .index = -1 };
 
 static int max_hfi_instances;
 static int hfi_clients_nr;
+static bool hfi_shutdown_done;
 static struct hfi_instance *hfi_instances;
 
 static struct hfi_features hfi_features;
@@ -398,6 +399,19 @@ static void hfi_disable(void)
 	}
 }
 
+/* Caller must hold hfi_instance_lock. */
+static bool hfi_disable_if_enabled(void)
+{
+	u64 msr_val;
+
+	rdmsrq(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
+	if (!(msr_val & HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT))
+		return false;
+
+	hfi_disable();
+	return true;
+}
+
 /**
  * intel_hfi_online() - Enable HFI on @cpu
  * @cpu:	CPU in which the HFI will be enabled
@@ -483,7 +497,8 @@ void intel_hfi_online(unsigned int cpu)
 	 * Enable this HFI instance if this is its first online CPU and
 	 * there are user-space clients of thermal events.
 	 */
-	if (cpumask_weight(hfi_instance->cpus) == 1 && hfi_clients_nr > 0) {
+	if (cpumask_weight(hfi_instance->cpus) == 1 && hfi_clients_nr > 0 &&
+	    !hfi_shutdown_done) {
 		hfi_set_hw_table(hfi_instance);
 		hfi_enable();
 	}
@@ -593,6 +608,11 @@ static void hfi_disable_instance(void *ptr)
 	hfi_disable();
 }
 
+static void hfi_shutdown_instance(void *ptr)
+{
+	hfi_disable_if_enabled();
+}
+
 static void hfi_syscore_resume(void *data)
 {
 	/* This code runs only on the boot CPU. */
@@ -612,9 +632,35 @@ static int hfi_syscore_suspend(void *data)
 	return 0;
 }
 
+static void hfi_syscore_shutdown(void *data)
+{
+	struct hfi_instance *hfi_instance;
+	int i;
+
+	/*
+	 * Hardware keeps writing to the HFI table after a kexec, into memory
+	 * that the next kernel owns. Disable HFI in every package, and keep it
+	 * disabled: user space runs until machine_shutdown() stops the other
+	 * CPUs, and kexec enables CPU hotplug again, so a new thermal netlink
+	 * client or a CPU coming online could otherwise enable it.
+	 */
+	mutex_lock(&hfi_instance_lock);
+	hfi_shutdown_done = true;
+	for (i = 0; i < max_hfi_instances; i++) {
+		hfi_instance = &hfi_instances[i];
+		if (cpumask_empty(hfi_instance->cpus))
+			continue;
+
+		smp_call_function_single(cpumask_any(hfi_instance->cpus),
+					 hfi_shutdown_instance, hfi_instance, true);
+	}
+	mutex_unlock(&hfi_instance_lock);
+}
+
 static const struct syscore_ops hfi_pm_ops = {
 	.resume = hfi_syscore_resume,
 	.suspend = hfi_syscore_suspend,
+	.shutdown = hfi_syscore_shutdown,
 };
 
 static struct syscore hfi_pm = {
@@ -649,7 +695,7 @@ static int hfi_thermal_notify(struct notifier_block *nb, unsigned long state,
 		break;
 	}
 
-	if (!func)
+	if (!func || hfi_shutdown_done)
 		goto out;
 
 	for (i = 0; i < max_hfi_instances; i++) {

-- 
2.39.5


