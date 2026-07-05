Received: from mail.srv.csmantle.top (mail.srv.csmantle.top [77.93.157.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7231E824;
	Sun,  5 Jul 2026 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.157.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244216; cv=none; b=C9i7mDD0yauIB6Y1ro0cCUV/49rqNn5lF37vTlKDUM9JJimDpS44r9BNUTN36nWVkOiITZHmgKqPtD/KsDzEC0tPrb3LS0virkfknEPmTTqolH568sbHnvQfiC/S6pvMT1PwOglrUVckaigf2NnGYoRsuYxJtc4RLgGcSHv1xXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244216; c=relaxed/simple;
	bh=DYP/fAuTfWaqhSK56kenBZaNNFwDCi7MO9GMC1TyvwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p834Rz3N+16o4vpUahvVc7YXdF1tt0vpvX0a3fy73LVw6qPuJ5nena6Knhz98PIyYPiueFguj4b2dKhalolADZDdiE9JUddRI/D+c7l8wwUj7BsTlwnUtfppKdaDhe65vXQ1vdBhdO26LHr/k40Lw21jbd31lZ3giWhLwrZO0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top; spf=pass smtp.mailfrom=csmantle.top; dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=bHC7lTc6; dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=Z6A4CxMk; arc=none smtp.client-ip=77.93.157.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csmantle.top
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="bHC7lTc6";
	dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="Z6A4CxMk"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-ed25519; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:In-Reply-To:References:BIMI-Selector;
	bh=SceegF9V2UMZyJU5wVXKWyTzveddd4TbiOOhUTBe0qI=; t=1783244215; x=1783849015; 
	b=bHC7lTc616rU//1j/gP5adwKdzZ6gAcAIBdyd40lU46KRbRosWhBVV52szCX53KGUZRizQtGT0e
	thZnuSafmBg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-rsa3072; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:In-Reply-To:References:BIMI-Selector;
	bh=SceegF9V2UMZyJU5wVXKWyTzveddd4TbiOOhUTBe0qI=; t=1783244215; x=1783849015; 
	b=Z6A4CxMkmIh/FsEnT6Br2cnfWRe0grcbNmr3rb/unNVyK/D8CyTfC03K7iNlAIpIOhotmkJaoyE
	Y4vyKupa0IZVqgADk3Fk2DRgv0meV0JR0sAedY923vcrs0c14PXXTapBjeS5D+RVYQWUJbLyJvL6q
	tjoZqqouiu245boKfPQ9KnKEhtG+fU53QA+udgBrLaPDcYvDFI1Uh/gJbw2Gp/kFCn1IcziKVQKM8
	ft7LpYwuM0n3NIh9yu2SItQyDDdm+WfLhMIlrvFu3mIi6UuBgP13A3+BZeU+oUE81MGfFCrya+P7c
	AEApvdx0BnIClpZb1KrVvYc6sh7/FSpgKTD9wtfhJ3sSoD9RxspIaPYS2RPV16cmPxckfuhpRhDiE
	Zr4Lz7yFZRKRsku8iK03s45WGBIW0DNzQRoyE5jEd87VPqNPtwnyHiIEjO6mkCkSZRVmhpsEnikUf
	fgl+hzx2m7i0LLghuP0TxoZDcscRQVbytWcXoRiqjiT7A1U+J0y6;
Received: from [103.167.64.98] (helo=loongcatbox)
	by mail.srv.csmantle.top with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rong.bao@csmantle.top>)
	id 1wgJHG-00000000O6x-2we4;
	Sun, 05 Jul 2026 17:36:42 +0800
From: Rong Bao <rong.bao@csmantle.top>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Chengwen Feng <fengchengwen@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Xi Ruoyao <xry111@xry111.site>,
	Rong Bao <rong.bao@csmantle.top>,
	Guo Ren <guoren@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] loongarch: retrieve CPU package ID from PPTT when available
Date: Sun,  5 Jul 2026 17:36:14 +0800
Message-ID: <20260705093624.1079988-1-rong.bao@csmantle.top>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rcpt-Check: Accepted by authentication
X-42: Don't panic! 
BIMI-Selector: v=BIMI1; s=me

Currently, the LoongArch CPU topology initialization code calculates
each core's package ID by dividing its physical ID by
loongson_sysconf.cores_per_package. This relies on the assumption that
cores_per_package counts in the same domain as physical IDs.

On Loongson 3B6000 (XB612B0V_1.2), cores_per_package matches the visible
core count -- 24 in this case. However, the physical IDs range from 0 to
31 in a noncontinuous fashion:

        $ cat /proc/cpuinfo | grep -i -F 'global_id'
        global_id               : 0
        global_id               : 1
        global_id               : 4
        global_id               : 5
        global_id               : 6
        global_id               : 7
        global_id               : 8
        global_id               : 9
        global_id               : 10
        global_id               : 11
        global_id               : 14
        global_id               : 15
        global_id               : 16
        global_id               : 17
        global_id               : 20
        global_id               : 21
        global_id               : 22
        global_id               : 23
        global_id               : 26
        global_id               : 27
        global_id               : 28
        global_id               : 29
        global_id               : 30
        global_id               : 31

Retrieve the exact package ID from ACPI PPTT when available, in the same
style as retrieving the core ID and thread ID in parse_acpi_topology().
Use this information in loongson_init_secondary() when PPTT readout is
successful. The original division logic is kept as a fallback.

Meanwhile, since some code paths like loongson3_cpufreq expect a
continuous integer sequence of package IDs in [0, MAX_PACKAGES) when
retrieving from cpu_data[], we also canonicalize the package ID to be
filled in parse_acpi_topology() to meet such an expectation.

Cc: stable@vger.kernel.org
Co-developed-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Rong Bao <rong.bao@csmantle.top>
---

v1 -> v2:
- Addressed and incorporated package ID canonicalization code suggested
  by Ruoyao
- Rebased onto present master

v1: https://lore.kernel.org/loongarch/e18efdbb.AXMAAIuqLC8AAAAAAAAAA-ma1qEAAYKJPtkAAAAAADNVAQBpc5ot@mailjet.com/

---
 arch/loongarch/kernel/acpi.c | 28 +++++++++++++++++++++++++++-
 arch/loongarch/kernel/smp.c  |  2 +-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 8f650c9ffecdecdac6bcb324123e222bd04dbcf2..9ad25c642dbc50485ad54a02ed818a34e639f219 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -202,9 +202,12 @@ static void __init acpi_process_madt(void)
 
 int pptt_enabled;
 
+static int acpi_package_ids[MAX_PACKAGES];
+static int acpi_nr_packages;
+
 int __init parse_acpi_topology(void)
 {
-	int cpu, topology_id;
+	int cpu, topology_id, i;
 
 	for_each_possible_cpu(cpu) {
 		topology_id = find_acpi_cpu_topology(cpu, 0);
@@ -222,6 +225,29 @@ int __init parse_acpi_topology(void)
 
 			cpu_data[cpu].core = topology_id;
 		}
+
+		topology_id = find_acpi_cpu_topology_package(cpu);
+		if (topology_id < 0) {
+			pr_warn("Invalid BIOS PPTT\n");
+			return -ENOENT;
+		}
+
+		for (i = 0; i < acpi_nr_packages; i++)
+			if (acpi_package_ids[i] == topology_id)
+				break;
+
+		if (i == acpi_nr_packages)
+			acpi_package_ids[acpi_nr_packages++] = topology_id;
+
+		cpu_data[cpu].package = topology_id;
+	}
+
+	for_each_possible_cpu(cpu) {
+		for (int i = 0; i < acpi_nr_packages; i++)
+			if (cpu_data[cpu].package == acpi_package_ids[i]) {
+				cpu_data[cpu].package = i;
+				break;
+			}
 	}
 
 	pptt_enabled = 1;
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 5d792256bbb99a41d0032add6b5ffacffb20b684..9d148b6e41b488daca71a970e1b75cc18638d564 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -426,7 +426,7 @@ void loongson_init_secondary(void)
 	numa_add_cpu(cpu);
 #endif
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
-	cpu_data[cpu].package =
+	cpu_data[cpu].package = pptt_enabled ? cpu_data[cpu].package :
 		     cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
 	cpu_data[cpu].core = pptt_enabled ? cpu_data[cpu].core :
 		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package;

base-commit: 87320be9f0d24fce67631b7eef919f0b79c3e45c
-- 
2.54.0

