Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47E45A2A1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444396; cv=none; b=fgGUxgzKQvOkJF3k7wxVHIPwKCuGr3rpNyDTDep79F7r1Wh0Sa2fEdxGA6iJnGJEaYhvMijVGjjpYhgfXVrx5V1Nt/jKIHWy5zXQOQ0FXmW6J46i/F1dJJgdCo5LsT1D3ptYP5Y9a5If48FQUnnNvs9rLjzsVGOnnlYBMCAT1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444396; c=relaxed/simple;
	bh=AZ23zauV5sTFOVfcN5vbXt1RB2MccMrzA9GNR21KzNw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B4cJfCNZr7HEYwy6N1fYeP2lfBKn1OPH2Ahoa/qC7Whdp9qNyYcUERLkg7Lptwm0yedkt+g8/zCj3cckdz47f8v2q/GtZTyvtyTkyKMLxveG5TxbxWMtoEYeis9U5NJdzIC0fbAT+c9fBlaMy5d2D9R+fKiSHT1PzUML9OodkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2gQYgZxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2gQYgZxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581A41F00A3F;
	Thu,  3 Sep 2026 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444385;
	bh=3Vsvl3IWg9U2OO26QtnnSvTl7yg/9K3uDLOS/CuqpuU=;
	h=Subject:To:Cc:From:Date;
	b=2gQYgZxv8VAj4BZYEmqkgEFpwhrDT+I81UYuSe/doF2eTS3f5cKJJ1f3RA6qJ2fMQ
	 vFDpfTnn/Wb1nvf3xJdOY9HMoW6EOJvIUlnI4/48eThENSX7kTsc7ycLs1I9lUKRQ0
	 JCMnu2WbykYxPY+/oTtbSb7pmUORLwVNMtKsIYFQ=
Subject: FAILED: patch "[PATCH] ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+" failed to apply to 6.18-stable tree
To: christian.loehle@arm.com,rafael.j.wysocki@intel.com,sumitg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:48:09 +0200
Message-ID: <2026090309-negation-laboring-bb8a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x df5a1d4a8cdfda20eb2581a85e81c7d436866534
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090309-negation-laboring-bb8a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df5a1d4a8cdfda20eb2581a85e81c7d436866534 Mon Sep 17 00:00:00 2001
From: Christian Loehle <christian.loehle@arm.com>
Date: Mon, 3 Aug 2026 21:35:29 +0100
Subject: [PATCH] ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+

When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
calls cppc_get_desired_perf() because some platforms repurpose Desired
Performance to report actual delivered performance.

ACPI 6.5 defines _CPC revision 3 and lists Read/Write as the Optional
Attribute of Desired Performance. ACPI 6.6 advances _CPC to revision 4 and
lists only Write, so invoking that workaround for revision 4 or later would
require a register read that the interface no longer specifies.

Make cppc_get_desired_perf() return -EOPNOTSUPP for _CPC revision 4 or
later. Use the revision retained in the per-CPU CPC descriptor rather than
the platform-wide FADT revision.

The _CPC revision may still not accurately describe the implemented
register semantics. If a nominally revision 3 platform implements a
non-readable Desired Performance register, a read may return zero and make
cppc_cpufreq_get_rate() report 0 kHz. Treat a zero read as unusable and
fall back to the cached OSPM request, just as for a failed read.

Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")
Cc: stable@vger.kernel.org
Suggested-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260803203531.1268651-2-christian.loehle@arm.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 53d09ca98f06..42aeb749ebe0 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1316,15 +1316,30 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 	return cpc_write(cpu, reg, val);
 }
 
+static bool cppc_desired_perf_readable(const struct cpc_desc *cpc_desc)
+{
+	return cpc_desc->version < CPPC_V4_REV;
+}
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
  * @desired_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -EOPNOTSUPP for _CPC revision 4 or later, and a
+ * negative errno otherwise.
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+
+	if (!cpc_desc)
+		return -ENODEV;
+
+	/* _CPC revision 4 no longer specifies Desired Performance as readable. */
+	if (!cppc_desired_perf_readable(cpc_desc))
+		return -EOPNOTSUPP;
+
 	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6fe0e972952a..80893844353c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -836,7 +836,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	 * value first as some platforms may update the actual delivered perf
 	 * there; if failed, resort to the cached desired perf.
 	 */
-	if (cppc_get_desired_perf(cpu, &delivered_perf))
+	if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_perf)
 		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);

