Received: from gz.d.sender-sib.com (gz.d.sender-sib.com [77.32.148.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8D331EA8
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785377307; cv=none; b=O3tC5pxQKeXNGobt19CHWwoVPB7XYYK4niRurxJtPq3TsLcloM9JHVhrT2s96OvBeHFcOwgEez7/nxQ7AhNFmD9TetD3+OgFmjIc7lY4ueqQ2CIgFEJX5aALd4RIDF53CJ5s4pTlKIO1Z/E0c6Sdlq4/AsRky3xZnhQdd52tZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785377307; c=relaxed/simple;
	bh=3hkjjuYyVB0m6Smk6gyUHDlUV6Fkp96xJMOB63LpOms=;
	h=To:Message-Id:Date:Subject:Cc:From:Mime-Version; b=MhcqeIGnoVLdDa++m7tICZTTbc9ZwNA6QBnJRtGJzj0L8wlCFsYE+exvtoF1q1wc1D/KI9WR0d5XpTWWQHG1xt5uCHW1djGyxwoVgnkFJ4UC37DgUk7iyrhxgeCUg/b9+3yZdr+5JEaSxbQgC5PwIFZOsmmyqNYDVtDBBWU8UQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=gz.d.sender-sib.com; dkim=pass (2048-bit key) header.d=iusegentoo.com header.i=@iusegentoo.com header.b=Az6SE4c8; arc=none smtp.client-ip=77.32.148.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gz.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iusegentoo.com header.i=@iusegentoo.com header.b="Az6SE4c8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iusegentoo.com;
 q=dns/txt; s=brevo2; bh=p2VWfSLGy3p76kgbgNzYvWemU/FLLI81tuSv/+jIUVw=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=Az6SE4c8E2mn6pKA2LhAK+aCEDlmOAyzPZJ2HpQh+mGPDnYZg8Mp+G0ukajgJgyB7gDwEOm08K6d
        yFXCIrjQwP8EYTSnItDrn4699CK/F2sgESZvwGj7+fvT2cBl+5dynHXUWYWDIlftqMWOt6Qki9eh
        KxsgVbLnLy3jzxvFm0qCMZVMqH6HEhrChoTyP8+tZpuuK3+lG4ROaikVHynExUaHbQK/iohvGhca
        oLGtPm7T3/PPRea1zAqkSpFjQVnMotc0UDPC6DkRBPHLacL5NkiyS4naXaerz8LTG1gA+xrAGBsJ
        1i/MFCIOgBj1vmBgfVu3F8WiMvxXeKd8DDA7+A==
X-CSA-Complaints: csa-complaints@eco.de
To: "Shuah Khan" <shuah@kernel.org>,"Thomas Renninger" <trenn@suse.com>
Message-Id: <84e94595-f16f-414d-a5dc-5c057e95b460@smtp-relay.sendinblue.com>
Origin-messageId: <20260730020703.15163-1-ali@iusegentoo.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-Mailin-EID: NDgzOTI2MDM4fnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNzMwMDIwNzAzLjE1MTYzLTEtYWxpQGl1c2VnZW50b28uY29tPn5nei5kLnNlbmRlci1zaWIuY29t
Date: Thu, 30 Jul 2026 05:07:02 +0300
Subject: [PATCH] cpupower: Avoid uninitialized reads in topology sorting
X-sib-id: tkaY6x1D6KKSQ5U5Swjhvqi5FG-BHKRdL4GkwHKPMPfnmnR4ZrmkVScdiWk5PYWtnVw46jSPc4yjbFL1Wn1Ue0UfiEaoxGl-cA4neNmVK5-E__mZ9x5n1oC2I-28QyxtsEhEIj10HVMweLgSIep4M1T9fiqY37AS5fPvE10_4hl4taIjYA
Cc: <linux-pm@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "John B . Wyatt IV" <jwyatt@redhat.com>,  "John Kacur" <jkacur@redhat.com>,  <stable@vger.kernel.org>
Feedback-ID: 77.32.148.26:11609595_-1:11609595:Sendinblue
From: "Ali Ahmet Memis" <ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.54.0


get_cpu_topology() allocates core_info with malloc(). If a topology
attribute disappears while CPUs are being hotplugged, an error path can
leave core_cpu_list uninitialized. __compare_core_cpu_list() then passes
the field to strcmp() while sorting the array.

Use calloc() for the array and ignore entries without complete topology
data when counting cores. Besides avoiding the invalid read, this keeps an
incomplete entry from being counted as a physical core.

Fixes: f89cb9cba7a2 ("cpupower: Implement CPU physical core querying")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
Tested with a two-CPU topology mock that makes the second CPU's sysfs
reads fail. Valgrind reports uninitialized reads before this patch and
no errors after it.

Build-tested with:
  make -C tools/power/cpupower NLS=3Dfalse CPUFREQ_BENCH=3Dfalse

 tools/power/cpupower/lib/cpupower.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib=
/cpupower.c
index d7f7ec6f1..a8ee304bd 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -171,7 +171,7 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	char path[SYSFS_PATH_MAX];
 	char *last_cpu_list;
=20
-	cpu_top->core_info =3D malloc(sizeof(struct cpuid_core_info) * cpus);
+	cpu_top->core_info =3D calloc(cpus, sizeof(struct cpuid_core_info));
 	if (cpu_top->core_info =3D=3D NULL)
 		return -ENOMEM;
 	cpu_top->pkgs =3D cpu_top->cores =3D 0;
@@ -214,11 +214,17 @@ int get_cpu_topology(struct cpupower_topology *cpu_to=
p)
 	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
 	      __compare_core_cpu_list);
=20
-	last_cpu_list =3D cpu_top->core_info[0].core_cpu_list;
-	cpu_top->cores =3D 1;
-	for (cpu =3D 1; cpu < cpus; cpu++) {
-		if (strcmp(cpu_top->core_info[cpu].core_cpu_list, last_cpu_list) !=3D 0 =
&&
-		    cpu_top->core_info[cpu].pkg !=3D -1) {
+	last_cpu_list =3D NULL;
+	cpu_top->cores =3D 0;
+	for (cpu =3D 0; cpu < cpus; cpu++) {
+		if (cpu_top->core_info[cpu].pkg =3D=3D -1 ||
+		    cpu_top->core_info[cpu].core =3D=3D -1 ||
+		    cpu_top->core_info[cpu].core_cpu_list[0] =3D=3D '\0')
+			continue;
+
+		if (!last_cpu_list ||
+		    strcmp(cpu_top->core_info[cpu].core_cpu_list,
+			   last_cpu_list) !=3D 0) {
 			last_cpu_list =3D cpu_top->core_info[cpu].core_cpu_list;
 			cpu_top->cores++;
 		}
--=20
2.54.0


