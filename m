Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057582;
	b=b6sDeszjtSVD/1qjfvTw4DPupEbTRL5UN8cK3HP2LI1QYjBoljk7RuzB5LUQFdOQtSHK
	 3rRkZ/kHPM/qbVC6lu+FMCWtHOfZRBFxBlQ1K7QcglZsy7Ni/36LWbayqg1X+zIOM9VIf
	 VXMitID3uJ4rYaNNoTh2eKd3KkjYevR8KbAOgAt+mxgqiQNHlvPP7C+wVFRUDEKzsXz3v
	 qeGfNw2UT1TTFibwnmncvR6gdYGlJYCm87hR6fcf171GyzDREvVWs0+BJStyMm6vimTW4
	 O7ThNYjjLLa/FyH2304yv3uw09TCyQQY4DnRS/PN8LM0eKeF/tpAWCBObg6+5Z5zerg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pb6Ehd7uYd14UlHRaMPgiH3vikGNTgrvIXaxvAgYeKw=;
	b=32pUUWlrU3pNkLPo5EYrJGChuOPQPdkIjMhwRdu3ebAJNkcCwLY4tcj8VwvQphaaGf+l
	 SfQgVbzi4qDmk5iq+bcB/ELza5P0h7/j5ip8kRJG4asHhad9jIRnT1GRn7AQ901EUZBRO
	 2Ne6KdSDr8LGkHAq6clB52xx4/FrWqA0qbmK4qxI5eOH0EbOoK2T3IiVPbeGdxLhqm8Sw
	 JLt8tmf7GVEdGTzP4Q/BMgClxy56oBJECF6AqECvLVdM/6x4poSBrdZ50Mu76vxTO4zWk
	 FdpNXq4e+tSiWu2FwSWbHOqXzcCRO71A1zV7nF6NHUjSkhh9fReYUY4WEW6fgcgTDaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j8MgvJzI;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 13:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4266F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j8MgvJzI
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e3b22e971so777033f8f.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 05:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057581; x=1794662381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pb6Ehd7uYd14UlHRaMPgiH3vikGNTgrvIXaxvAgYeKw=;
        b=j8MgvJzIlC5u/eGD3SeOAa+VFYHM40KLTehszOsgOdgw+NNhCc3N7JgJLzURhJT3aE
         Ra2KSljTOvSaFF6JbvcIVKDL42P3OITwQiY5meNfDvoW6Z7fPWHJTB6qLJWITD1zlS7Y
         Z5z8vaMpXmHeOUqvq6JyyA3l0enUKnr5xs9wtHOtPAtpJnpu5ULDDCTpq8qc5NGhXCTH
         sB8rNxpozt5HlkwqeSveFWUHxSG2eVbzgC2ZRN61x/k7X5WSFtK0lScHnS3TAPX227vm
         1qpX8+a0nwbEn+b7f/bJAHZFJObwtva4u+4uTwk0PELSwKbnb1OiGloul/kI8XaTMAZs
         10Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057581; x=1794662381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pb6Ehd7uYd14UlHRaMPgiH3vikGNTgrvIXaxvAgYeKw=;
        b=ylfKMf3YIANQgvy4orZr717czUzd9PcgiR4Ns1I1ESHaFbauCEx5bxBnk52HWDV/Pa
         VkpU6D9/RXEhZx7UAKZdmj0NAEir+rHn4jhm8hqA+SdVfPbbgGSolsfVxnYiS/9x0h8S
         Oa/Ml6x4IiAWfLp3TBDXnFyxeNAM4ZD3j8SKulznZ+QYTdq4UdI/Zt7SeKDRDZKbaiTn
         x3YFhiXf+OqDSdLqz8TJaPQJwEMCD1cUMjMuBXdMNdN1UGHjT8tuTE1iPtvP+uT2m7Ij
         CAQIOmuXO50gVROxwJ7U24/oAsPygbkFPjARkP5ywW8RYdNi4konNzHfRIAC8cX2bvbs
         UNXw==
X-Gm-Message-State: APuU4Z83nh667jzZ4doDJ1BmmtKjc8fueuv7yLP7JgneV0ZoWagUY1Nd
	5uiacTa2OdRHuGgG7TNb3ZSwyX6QOUZoBkDPvUiQH+b31Py8ju58O4BASuSvBUAr
X-Gm-Gg: AYBFou0kPthCy/YOApX6KZ03NE2SO3vMOG5Vhu0EScTOcvkd9eNPzJO4wnlBIotMhfo
	cQzwHesj0/iQpdmjM2PUt0pNsVSyPcXB3mRSILsfFLXh94+mCjVseRw//wnjAY5lEkWXu5L0yZz
	EbOQJ3AzjbJTdL3ffMB0IX4o9WcDOsqpIhOPYEjbrclW9CrT1xNQbanSkKErTCPTtBU+yyGvruO
	7hktl7oKE/QSpxguDqADDfx7OqHlJSdzmspXUxCBvdIXi2M+RUAF4T6xrlgdUMg/AMOlYDrq0Qf
	ibvF3X12n7BrElqCAgNwk9JQd1owPheFrR0zS4ix8bWYOaAKUb4CoM1PqOv8eOc4VNQY5kkJzF+
	wQ/sZMm4YNUtbi7+HOWpL6V8YMh9neltLjeOF/4hp0AhZYPztwcIEwCUNo48+3PpfwcS3/un6mM
	JYElyeLqFN9f18EAT/HFc/1gXmw6L1HhF3eV/OEXFR7jhEQQr3uxlzzfm1+CXANOTVeJVaY4foT
	AWMupLA62jtLtkhd+vOZuR1WzUMn6S8bKF/bRfgR0KzGd5mFiyWmVgBkXguZTPAifiQRgDsLUo8
	MCwN3PUW9BSIU47DwAPKYfaXGO9uzt3tyj0zHHMT5A4pOehxuSE1vdrtSxOBhNFhJXHGICiFPWH
	+Gy0gpFGSlP35nHW6Dw==
X-Received: by 2002:a5d:64e3:0:b0:492:b1c5:6db5 with SMTP id ffacd0b85a97d-492b1c56e07mr10147191f8f.32.1794057580383;
        Sat, 07 Nov 2026 05:19:40 -0800 (PST)
Received: from localhost.localdomain (bba-217-164-30-115.alshamil.net.ae. [217.164.30.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm9700650f8f.51.2026.11.07.05.19.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 05:19:40 -0800 (PST)
From: Ximing Zhang <xzhangjr@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	linux@roeck-us.net,
	Ximing Zhang <xzhangjr@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Asaf=20Nuri=20Bertizlio=C4=9Flu?= <ycistak@gmail.com>
Subject: [PATCH 6.6.y] hwmon: (coretemp) Fix handling of isolated SMT siblings
Date: Sat,  7 Nov 2026 17:19:33 +0400
Message-ID: <20261107131933.16276-1-xzhangjr@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107053631-failed-6.6-37c1974a0ec4@kernel.org>
References: <20261107053631-failed-6.6-37c1974a0ec4@kernel.org>
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

[ Upstream commit 37c1974a0ec4ec4624a270291a179c53f8f4fbca ]

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
Link: https://git.kernel.org/linus/37c1974a0ec4ec4624a270291a179c53f8f4fbca
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[xzhangjr: Resolve the create_core_data() conflict by retaining the 6.6
index allocation and init_temp_data(cpu, pkg_flag) call, removing only
the housekeeping check. The other upstream changes apply unchanged.
Tested on an Intel Core i7-10510U running 6.6.162 with nohz_full=1:
the unmodified driver reproduced both bugs, and the backport passed
sensor creation, 20 SMT hotplug cycles, and 20 module reloads. The driver
also builds with CPU isolation enabled or disabled.]
Signed-off-by: Ximing Zhang <xzhangjr@gmail.com>
---
 drivers/hwmon/coretemp.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index b8fc8d1ef20d..f679ee62a172 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -504,9 +504,6 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	u32 eax, edx;
 	int err, index;
 
-	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
-		return 0;
-
 	/*
 	 * Get the index of tdata in pdata->core_data[]
 	 * tdata for package: pdata->core_data[1]
@@ -654,6 +651,14 @@ static int coretemp_cpu_online(unsigned int cpu)
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
@@ -683,8 +688,8 @@ static int coretemp_cpu_online(unsigned int cpu)
 	}
 
 	/*
-	 * Check whether a thread sibling is already online. If not add the
-	 * interface for this CPU core.
+	 * Check whether a housekeeping thread sibling is already online. If
+	 * not, add the interface for this CPU core.
 	 */
 	if (!cpumask_intersects(&pdata->cpumask, topology_sibling_cpumask(cpu)))
 		coretemp_add_core(pdev, cpu, 0);
@@ -725,9 +730,9 @@ static int coretemp_cpu_offline(unsigned int cpu)
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
@@ -739,7 +744,8 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	}
 
 	/*
-	 * If all cores in this pkg are offline, remove the interface.
+	 * If all housekeeping cores in this pkg are offline, remove the
+	 * interface.
 	 */
 	tdata = pd->core_data[PKG_SYSFS_ATTR_NO];
 	if (cpumask_empty(&pd->cpumask)) {
@@ -752,7 +758,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 
 	/*
 	 * Check whether this core is the target for the package
-	 * interface. We need to assign it to some other cpu.
+	 * interface. We need to assign it to some other housekeeping CPU.
 	 */
 	if (tdata && tdata->cpu == cpu) {
 		target = cpumask_first(&pd->cpumask);
-- 
2.55.0

