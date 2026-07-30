Received: from mail132.mailersend.net (mail132.mailersend.net [212.11.79.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8408137F725
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.11.79.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382660; cv=none; b=fURYnX6F2twTV1bZrOMUv8pB7G5t7cGbbwxRue7KodVO7GMU/4T7V1RlmuWMBjxpsRRaPwUiTDfdX/eI25oi6xdnaTpmTJ0oce93BKbt5PIs/vtJRBo/bROgAOTwIVADH+N6AGuLAGwEdp/+iFOu61wIQOBbeelMDTkn7bb2sQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382660; c=relaxed/simple;
	bh=JbAwF0ZNHDDugKz48oD9F3ZEqPXPccw6WvlGqwKheWI=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=OyTQoT/nNK9IXFs0LSKeNHrzvEjHwXksKC0CEYYO/rg5V8QRKaaERvKmqMsBFDegwl3CXf7lkE6jfGLwHQaFjRu5iR+sl1z1b2shZoW3GIJj/sBg48tiD8iADile8z68IGDl1NnAknFGC3KrOoH32Q2f2rlcMSNUSUZR5FhqARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=mta.iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=@iusegentoo.com header.b=UOSvp66G; dkim=pass (1024-bit key) header.d=mailersend.net header.i=@mailersend.net header.b=KgU+e4zG; arc=none smtp.client-ip=212.11.79.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mta.iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=@iusegentoo.com header.b="UOSvp66G";
	dkim=pass (1024-bit key) header.d=mailersend.net header.i=@mailersend.net header.b="KgU+e4zG"
DKIM-Signature: a=rsa-sha256; bh=IxFbusL+Lxm7QZTSk2RAjdpD74OZtKPh+my5EFmKiYQ=;
 c=relaxed/relaxed; d=iusegentoo.com;
 h=DKIM-Signature:X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=mlsend2; t=1785379620; v=1;
 b=UOSvp66G65CPeHe/eWmJj4duzgpoF1PZbKLMEscY7ASKHD/xlLkQtcRp1ocT1Bso56Icwbwb
 Pf1SSY7F0WxaZH4/jn43j9CSw75jRrm0QL2RBVqM6gxHjNGWB1kMLFzoPptAxNr6wXvPNDrmlml
 Iqyjlsb/TF12yYFO4wJUrXrM=
DKIM-Signature: a=rsa-sha256; bh=IxFbusL+Lxm7QZTSk2RAjdpD74OZtKPh+my5EFmKiYQ=;
 c=relaxed/relaxed; d=mailersend.net;
 h=X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=mlsend; t=1785379620; v=1;
 b=KgU+e4zGyOX/pRZ8D6Gm5E4V9UVbAAMTWnQKHzGEEaB1Nfvra2nDsKVmOFUIHhx2o1/O1JsM
 iRMwCkWbJIsrZxQk+egr644h7hLb1V8DXEzzcRHJGjUcaU/uNQFrSrrC/42RM6LnCTtanBoPSmD
 LisMK9QLkIpZZoqm6zQa4Uh8=
X-Mailer-Info: 10.AZlZWY1xGd.AZlZWY1xGd1YDMxIDO.wc0FmYsVGQ2dWZy5yalJnblxmLvJ3
 Z.gNhZTYiFmZxMTN3MzNyYjYxYmMxczY0YzK1YDMxIDO....
Subject: [PATCH] cpupower: Avoid uninitialized reads in topology sorting
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: unknownbbqr@proton.me
Cc: stable@vger.kernel.org
Date: 30 Jul 2026 02:47:00 -0000
Received: from 10.32.23.21 by 10.132.0.99 with http; 30 Jul 2026 02:47:00 +0000
Message-ID: <6a6abb242de06296e91308bd@mailersend.net>
X-MailerSend-RecipientID: 6a6abb242de06296e91308bd;6a6abaf13573726b1f217c46;zxk54v8pqnpljy6v
Feedback-ID: zxk54v8pqnpljy6v:MailerSend
X-MailerSend-MessageID: 6a6abb2383d4221bd92cac89
Reply-To: ali@iusegentoo.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

get_cpu_topology() allocates core_info with malloc(). If a topology
attribute disappears while CPUs are being hotplugged, an error path can
leave core_cpu_list uninitialized. __compare_core_cpu_list() then passes=

the field to strcmp() while sorting the array.

Use calloc() for the array and ignore entries without complete topology
data when counting cores. Besides avoiding the invalid read, this keeps =
an
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

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/=
lib/cpupower.c
index d7f7ec6f1..a8ee304bd 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -171,7 +171,7 @@ int get_cpu_topology(struct cpupower_topology *cpu_t=
op)
 	char path[SYSFS_PATH_MAX];
 	char *last_cpu_list;
=20
-	cpu_top->core_info =3D malloc(sizeof(struct cpuid_core_info) * cpus);
+	cpu_top->core_info =3D calloc(cpus, sizeof(struct cpuid_core_info));
 	if (cpu_top->core_info =3D=3D NULL)
 		return -ENOMEM;
 	cpu_top->pkgs =3D cpu_top->cores =3D 0;
@@ -214,11 +214,17 @@ int get_cpu_topology(struct cpupower_topology *cpu=
_top)
 	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
 	      __compare_core_cpu_list);
=20
-	last_cpu_list =3D cpu_top->core_info[0].core_cpu_list;
-	cpu_top->cores =3D 1;
-	for (cpu =3D 1; cpu < cpus; cpu++) {
-		if (strcmp(cpu_top->core_info[cpu].core_cpu_list, last_cpu_list) !=3D=
 0 &&
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

Delivered by MailerSend
