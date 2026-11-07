Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047793;
	b=uWEWH/gdxBsGnp418oIg5pBv7SDLARfkA6JZ2NTNSEUwLHFJZgXCY5k0qFYGLsLZzwjd
	 74Np2QTA7KwL40I5Urii3RmmAOEbSLSf5gAkh36nstiqljIe4n0dRUT+6p1ah8uSvuKp5
	 JjEv70mJT7oOB5u8TNZchhHBHR7aQ16IFiA2xB+pppjLK5Fo78VzVr4/5wxssl4iwQHl1
	 gA3WKIJQYrXbnNLg4QjY+1PRNqQ1NvicTr13TqzsmmeTZVhJrHvS4FULdb8E3jqJApmgH
	 j6ZyFzuh/AEVpg5gzFMxb8n6iYYrP9+PELhblaSosy35FAHWfXqGQw/ObmcvDnJZqLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DicRQISnjWsXtkrnyRK3Nf3NMPmJKBS1RGI5IjxOeZE=;
	b=MIkPqOxToMYGmFwOyM0QTqwS/IpLN7pAoCUJVD4PonyE4/sP0HSAAwcw1OFEaP4IYyhw
	 e1UxP8rZ1UCA9LwnsIixZLSeaOdE6CDWRs8abrlxWrRKEpjMGL3xMWacrjxirP+/iX9/s
	 iOHJ/p6TqccM0HgpgTaDb6TnBf3cfAmxVb2JD4TMKF9An+oZuQtcNelQ8Y5snz/p9XjQe
	 sRFvwl80Q/qX4RCbI+UUjNmATv9Y8lCZ3AG8SzbPProNr6NuPuo5IZrTwpf/X9cKLhEZT
	 hpMaS3oNB3aAs/RcIPoQWtPXZoc4sqT0u4TJ3exdd9uQtViBOC+lI7SEeen9fu3GrXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iBC8dzN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A77606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBC8dzN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F1F1F0089F;
	Sat,  7 Nov 2026 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047792;
	bh=DicRQISnjWsXtkrnyRK3Nf3NMPmJKBS1RGI5IjxOeZE=;
	h=From:To:Cc:Subject:Date;
	b=iBC8dzN/0WeRQdV12BZ8jXu2ls0T+9Cu5GH/ucFTT0PzOZ0vk8itgAPgXbBE6i7Up
	 ttE5WYY2hVgCorwqHTbrj6JJi7YzEaGH4e3JVMn6XBGpZsdWhFff2bJ7CVloNwS7hE
	 hYryvPtcseC0UfPY/3nUrsSxg6HmTWglTQ50+vFpWVHBJ51YgaLWyEP6nl4t0xfq/7
	 U0Lxc4jEh6Ey6RSNO5lMIbteQBZiqiftKyU8ZgWhed4Xm+qfHvS3Olilq9KQ3AG27B
	 +a0SKDpPYtZO9JdG23Mc4weoDjCPiWq/M1yzOLyoe+tdHYMII+nCy525RuH8BtH+iw
	 +Ic2NVgG350fg==
From: Sasha Levin <sashal@kernel.org>
To: xzhangjr@gmail.com,
	mtosatti@redhat.com,
	ycistak@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Fix handling of isolated SMT siblings" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:31 -0500
Message-ID: <20261107053631-failed-6.6-37c1974a0ec4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 37c1974a0ec4ec4624a270291a179c53f8f4fbca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053631-failed-6.6-37c1974a0ec4@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 37c1974a0ec4ec4624a270291a179c53f8f4fbca Mon Sep 17 00:00:00 2001
From: Ximing Zhang <xzhangjr@gmail.com>
Date: Fri, 16 Oct 2026 12:36:37 +0400
Subject: [PATCH] hwmon: (coretemp) Fix handling of isolated SMT siblings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 0f8b916bc5b5 ("hwmon: (coretemp) avoid RDMSR interrupts to
isolated CPUs") prevents create_core_data() from creating temperature
data for an isolated CPU. coretemp_cpu_online(), however, still adds
that CPU to pdata->cpumask.

When an isolated SMT thread is processed before a housekeeping sibling,
the mask makes coretemp_cpu_online() believe that the core is already
represented. The housekeeping sibling then gets no temperature
attributes. Package attributes are similarly not retried when the first
CPU processed in a die is isolated.

The mask is also used to select a replacement CPU when a sensor target
goes offline. Including isolated CPUs permits the driver to retarget a
sensor to one, causing subsequent sysfs reads to send an RDMSR IPI to an
isolated CPU.

Keep isolated CPUs out of pdata->cpumask by moving the housekeeping check
to coretemp_cpu_online(). Sensor creation is then deferred to an eligible
CPU, and hotplug replacement targets remain on housekeeping CPUs.

Tested on an Intel Core i7-10510U running 6.18.50-3-cachyos-lts, with
nohz_full=1 on CPU 1 and its housekeeping SMT sibling on CPU 5. The stock
driver omitted Core 1 after module load and retained its readable sensor
after CPU 5 was offlined. The patched driver exposed Core 1, removed it
when CPU 5 went offline, and restored it when CPU 5 returned.

Fixes: 0f8b916bc5b5 ("hwmon: (coretemp) avoid RDMSR interrupts to isolated CPUs")
Cc: stable@vger.kernel.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Ximing Zhang <xzhangjr@gmail.com>
Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>
Link: https://patch.msgid.link/20261016-codex-coretemp-housekeeping-v1-1-96618c5676b2@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index a9edbb4924a7a..3836beade59f4 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -568,9 +568,6 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	u64 val;
 	int err;
 
-	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
-		return 0;
-
 	tdata = init_temp_data(pdata, cpu, pkg_flag);
 	if (!tdata)
 		return -ENOMEM;
@@ -690,6 +687,14 @@ static int coretemp_cpu_online(unsigned int cpu)
 	if (!cpu_has(c, X86_FEATURE_DTHERM))
 		return -ENODEV;
 
+	/*
+	 * Keep isolated CPUs out of pdata->cpumask. Besides tracking the CPUs
+	 * available to this driver, the mask is used to select the CPU on which
+	 * to read the temperature MSRs.
+	 */
+	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
+		return 0;
+
 	pdata = platform_get_drvdata(pdev);
 	if (!pdata->hwmon_dev) {
 		struct device *hwmon;
@@ -719,8 +724,8 @@ static int coretemp_cpu_online(unsigned int cpu)
 	}
 
 	/*
-	 * Check whether a thread sibling is already online. If not add the
-	 * interface for this CPU core.
+	 * Check whether a housekeeping thread sibling is already online. If
+	 * not, add the interface for this CPU core.
 	 */
 	if (!cpumask_intersects(&pdata->cpumask, topology_sibling_cpumask(cpu)))
 		coretemp_add_core(pdev, cpu, 0);
@@ -750,9 +755,9 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	cpumask_clear_cpu(cpu, &pd->cpumask);
 
 	/*
-	 * If this is the last thread sibling, remove the CPU core
-	 * interface, If there is still a sibling online, transfer the
-	 * target cpu of that core interface to it.
+	 * If this is the last housekeeping thread sibling, remove the CPU core
+	 * interface. If there is still a housekeeping sibling online, transfer
+	 * the target CPU of that core interface to it.
 	 */
 	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
 	if (target >= nr_cpu_ids) {
@@ -764,7 +769,8 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	}
 
 	/*
-	 * If all cores in this pkg are offline, remove the interface.
+	 * If all housekeeping cores in this pkg are offline, remove the
+	 * interface.
 	 */
 	tdata = get_temp_data(pd, -1);
 	if (cpumask_empty(&pd->cpumask)) {
@@ -777,7 +783,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 
 	/*
 	 * Check whether this core is the target for the package
-	 * interface. We need to assign it to some other cpu.
+	 * interface. We need to assign it to some other housekeeping CPU.
 	 */
 	if (tdata && tdata->cpu == cpu) {
 		target = cpumask_first(&pd->cpumask);
-- 
2.53.0




