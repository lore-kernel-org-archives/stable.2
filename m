Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC103AEF21;
	Wed, 24 Jun 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285721; cv=none; b=NIfhz7DmpAKaUUTO8hAH44WrFje0ohhwCoqjBajaL/Dd8DRllqGlSEvQFTTwAYrtuqNNoCTukmyT9iZO5k4wWl2KYYiFpBxRRV/iWZrk7KuoIqQl00S1t4HZ6+1Y8gyC/gc8YwjcCDNlQB/rdlgnS1HVVG5xvcCRNWdM245oKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285721; c=relaxed/simple;
	bh=gMg4cJ1lc++NRxcPRk2cYtFHfIOvtZA72w1qrvkSCA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1C1RXOnHDRZX/yIk0uMtLD3qG6CBFE2Z079YD9qPAcZ3iJpblca+YQJZS1Nlgq/KcI+hK9yZeRvC8iV3Bi+R4HWXEVzMeIgFmczAo8DZxaOIkswvRH2/P+ysS8CEmpUyPXViU46MwZ8fgLcdVQwnqzzx3gX39hvjjFepGBvWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OoIZ3WFJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OoIZ3WFJ"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 53B8B20B7166; Wed, 24 Jun 2026 00:21:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53B8B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782285709;
	bh=+K6Bh3hIZ0daDgho/IIaZdeJRXdcwIKYv85ESXlxElU=;
	h=From:To:Cc:Subject:Date:From;
	b=OoIZ3WFJ9urIb8zKJk/SKAcq0vOaTbS9Ka59q/SZKLvuSPnD2i640TmETgUIXnfpa
	 CU4qGxrOwRQPl9x4jjO937bz+n8448IBdwIx2UtcdxBnDgNBsVuRTj9A2B6AmPSm1j
	 efH4ukfIac81kARf9E8UZMkcK+JQOdYSLRvC+gdk=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org,
	Yury Norov <ynorov@nvidia.com>
Subject: [PATCH v5 net] net: mana: Optimize irq affinity for low vcpu configs
Date: Wed, 24 Jun 2026 00:21:35 -0700
Message-ID: <20260624072138.1632849-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the commit 755391121038 ("net: mana: Allocate MSI-X vectors
dynamically"), all the MANA IRQs were assigned statically and together
during early driver load.

After this commit, the IRQ allocation for MANA was done in two phases.
HWC IRQ allocated earlier and then, queue IRQs dynamically added at a
later point. By this time, the IRQ weights on vCPUs can become imbalanced
and if IRQ count is greater than the vCPU count the topology aware IRQ
distribution logic in MANA can cause multiple MANA IRQs to land on the
same vCPUs, while other sibling vCPUs have none (case 1).

On SMP enabled, low-vCPU systems, this becomes a bigger problem as the
softIRQ handling overhead of two IRQs on the same vCPUs becomes much more
than their overheads if they were spread across sibling vCPUs.

In such cases when many parallel TCP connections are tested, the
throughput drops significantly.

Fix the affinity assignment logic, in cases where the IRQ count is greater
than the vCPU count and when IRQs are added dynamically, by utilizing all
the vCPUs irrespective of their NUMA/core bindings (case 2).

The results of setting the affinity and hint to NULL were also studied,
and we observed that, with this logic if there are pre-existing IRQs
allocated on the VM (apart from MANA), during MANA IRQs allocation, it
leads to clustering of the MANA queue IRQs again (case 3).


=======================================================
Case 1: without this patch
=======================================================
4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)

	TYPE		effective vCPU aff
=======================================================
IRQ0:	HWC		0
IRQ1:	mana_q1		0
IRQ2:	mana_q2		2
IRQ3:	mana_q3		0
IRQ4:	mana_q4		3

%soft on each vCPU(mpstat -P ALL 1) on receiver
vCPU		0	1	2	3
=======================================================
pass 1:		38.85	0.03	24.89	24.65
pass 2:		39.15	0.03	24.57	25.28
pass 3:		40.36	0.03	23.20	23.17

=======================================================
Case 2: with this patch
=======================================================
4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)

        TYPE            effective vCPU aff
=======================================================
IRQ0:   HWC             0
IRQ1:   mana_q1         0
IRQ2:   mana_q2         1
IRQ3:   mana_q3         2
IRQ4:   mana_q4         3

%soft on each vCPU(mpstat -P ALL 1) on receiver
vCPU            0       1       2       3
=======================================================
pass 1:         15.42	15.85	14.99	14.51
pass 2:         15.53	15.94	15.81	15.93
pass 3:         16.41	16.35	16.40	16.36

=======================================================
Case 3: with affinity set to NULL
=======================================================
4 vCPU(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)

	TYPE		effective vCPU aff
=======================================================
IRQ0:	HWC			0
IRQ1:	mana_q1			2
IRQ2:	mana_q2			3
IRQ3:	mana_q3			2
IRQ4:	mana_q4			3

=======================================================
Throughput Impact(in Gbps, same env)
=======================================================
TCP conn	with patch	w/o patch	aff NULL
20480		15.65		7.73		5.25
10240		15.63		8.93		5.77
8192		15.64		9.69		7.16
6144		15.64		13.16		9.33
4096		15.69		15.75		13.50
2048		15.69		15.83		13.61
1024		15.71		15.28		13.60

Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
Cc: stable@vger.kernel.org
Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Yury Norov <ynorov@nvidia.com>
---
Changes in v5
 * modify commit message to align with fix patch format
---
Changes in v4
 * Add mana prefix on irq_affinity_*() in mana driver
 * Corrected grammar, comment for mana_irq_setup_linear()
 * added new line as per guidelines
 * added case 3 in commit message for when affinity is NULL
---
Changes in v3
 * Optimize the comments in mana_gd_setup_dyn_irqs()
 * add more details in the dev_dbg for extra IRQs
---
Changes in v2
 * Removed the unused skip_first_cpu variable
 * fixed exit condition in irq_setup_linear() with len == 0
 * changed return type of irq_setup_linear() as it will always be 0
 * removed the unnecessary rcu_read_lock() in irq_setup_linear()
 * added appropriate comments to indicate expected behaviour when
   IRQs are more than or equal to num_online_cpus()
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 78 +++++++++++++++----
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index a0fdd052d7f1..e8b7ffb47eb9 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -210,6 +210,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	} else {
 		/* If dynamic allocation is enabled we have already allocated
 		 * hwc msi
+		 * Also, we make sure in this case the following is always true
+		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
 		 */
 		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
 	}
@@ -1909,8 +1911,8 @@ void mana_gd_free_res_map(struct gdma_resource *r)
  * do the same thing.
  */
 
-static int irq_setup(unsigned int *irqs, unsigned int len, int node,
-		     bool skip_first_cpu)
+static int mana_irq_setup_numa_aware(unsigned int *irqs, unsigned int len,
+				     int node, bool skip_first_cpu)
 {
 	const struct cpumask *next, *prev = cpu_none_mask;
 	cpumask_var_t cpus __free(free_cpumask_var);
@@ -1946,11 +1948,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
 	return 0;
 }
 
+/* must be called with cpus_read_lock() held */
+static void mana_irq_setup_linear(unsigned int *irqs, unsigned int len)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (len == 0)
+			break;
+
+		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
+		len--;
+	}
+}
+
 static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
-	bool skip_first_cpu = false;
 	int *irqs, err, i, msi;
 
 	irqs = kmalloc_objs(int, nvec);
@@ -1958,10 +1973,12 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 		return -ENOMEM;
 
 	/*
+	 * In this function, num_msix_usable = HWC IRQ + Queue IRQ.
+	 * nvec is only Queue IRQ (HWC already setup).
 	 * While processing the next pci irq vector, we start with index 1,
 	 * as IRQ vector at index 0 is already processed for HWC.
 	 * However, the population of irqs array starts with index 0, to be
-	 * further used in irq_setup()
+	 * further used in mana_irq_setup_numa_aware()
 	 */
 	for (i = 1; i <= nvec; i++) {
 		msi = i;
@@ -1975,18 +1992,51 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
 	}
 
 	/*
-	 * When calling irq_setup() for dynamically added IRQs, if number of
-	 * CPUs is more than or equal to allocated MSI-X, we need to skip the
-	 * first CPU sibling group since they are already affinitized to HWC IRQ
+	 * When calling mana_irq_setup_numa_aware() for dynamically added IRQs,
+	 * if number of CPUs is more than or equal to allocated MSI-X, we need to
+	 * skip the first CPU sibling group since they are already affinitized to
+	 * HWC IRQ
 	 */
 	cpus_read_lock();
-	if (gc->num_msix_usable <= num_online_cpus())
-		skip_first_cpu = true;
+	if (gc->num_msix_usable <= num_online_cpus()) {
+		err = mana_irq_setup_numa_aware(irqs, nvec, gc->numa_node,
+						true);
+		if (err) {
+			cpus_read_unlock();
+			goto free_irq;
+		}
+	} else {
+		/*
+		 * When num_msix_usable are more than num_online_cpus, our
+		 * queue IRQs should be equal to num of online vCPUs.
+		 * We try to make sure queue IRQs spread across all vCPUs.
+		 * In such a case NUMA or CPU core affinity does not matter.
+		 * Note: in this case the total mana IRQ should always be
+		 * num_online_cpus + 1. The first HWC IRQ is already handled
+		 * in HWC setup calls
+		 * However, if CPUs went offline since num_msix_usable was
+		 * computed, queue IRQs will be more than num_online_cpus().
+		 * In such cases remaining extra IRQs will retain their default
+		 * affinity.
+		 */
+		int first_unassigned = num_online_cpus();
 
-	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
-	if (err) {
-		cpus_read_unlock();
-		goto free_irq;
+		if (nvec > first_unassigned) {
+			char buf[32];
+
+			if (first_unassigned == nvec - 1)
+				snprintf(buf, sizeof(buf), "%d",
+					 first_unassigned);
+			else
+				snprintf(buf, sizeof(buf), "%d-%d",
+					 first_unassigned, nvec - 1);
+
+			dev_dbg(&pdev->dev,
+				"MANA IRQ indices #%s will retain the default CPU affinity\n",
+				buf);
+		}
+
+		mana_irq_setup_linear(irqs, nvec);
 	}
 
 	cpus_read_unlock();
@@ -2041,7 +2091,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev, int nvec)
 		nvec -= 1;
 	}
 
-	err = irq_setup(irqs, nvec, gc->numa_node, false);
+	err = mana_irq_setup_numa_aware(irqs, nvec, gc->numa_node, false);
 	if (err) {
 		cpus_read_unlock();
 		goto free_irq;

base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
-- 
2.34.1

