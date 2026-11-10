Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273394;
	b=rRGtHnEAEzDqelNgl3I1qz3lb8B6lhZklqErbY+6Kz9/LWYyK0CDx+L2c7S8kAqKe10K
	 zzqkDvQpZj1N2lD6OXdw/YDDaXYiYUCPnmLjC0VClYmLQ9KP8nMiZTQDmyEPduwHMmDIl
	 JhgdcYB0SUAGRVvcsQhVbfcZEx0X/zidMDoLod3+Pf59CVbXAsktKtsHOvuLUEX/Fqymu
	 kR6f9gPPglA0GMjw3VjvEUQwAOIh9RyCi8blsyIOSfMqqJYZzersSwKJXYUY4hGnyCUVX
	 keerKvb6Ym3OYiwnWhMHkprm/Dsu2AcVVbocRy7BCnjryf7EV7Lz3y3dssEdqUggHug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=B/BfuOoJ0PvLnfMeQA8EixaAkVWfyc0HsrjLgdNUMhk=;
	b=pccNUJujH5pqagSYQUVZgc4reeUf+OCHJEnVqvI0sVHHPXZEzfCoYI3yT/IEBsf73LCi
	 kyp0o6UVVmQUKG9gWX84E13pmQtaUQcApSTJXuv1MAxJWv41HD4ADG6JLAqP72+mgXnHG
	 fifKHgnXpDL3CtxWRsnTA7pR4XBkZr4H9CKtN1Bh4KAe6BDu6ncTv4cozbGzKb2VQBLhn
	 27taAJ/YYUic8JPqooZWvTayQY7PWz5sTdGqpgu0cPA5FLrYYuk6XeCpgnRmHyCZl+Ya7
	 05+GWvWeFRqOuQjC8+4eZEvDmkN/dftXoDoAHbJPF30waMt6G2S8MT+YRuXCoN/RtJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYljIn4G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17178606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYljIn4G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B641F0089F;
	Tue, 10 Nov 2026 01:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273393;
	bh=B/BfuOoJ0PvLnfMeQA8EixaAkVWfyc0HsrjLgdNUMhk=;
	h=From:To:Cc:Subject:Date;
	b=ZYljIn4GZWrRCRLPkZV7ZKL4Zux91oGMNmK32oLDQkxRdGcP+A3R/VIVGrLX11yse
	 g3ardFuUMFT5LYXC7EOjp+SDm13uvA3i2r2M+IWBdWeE70f0rAMe5nj+XtSV59wvi3
	 0Rkud8h6jLmn110ApAaWdMy4EiolHEHb1VsOhjQmddNdQOwSm4nSo6g0szJZyjbRDA
	 70tNW3ObWAoJ4Wk4zVpx01uv3+somYl4l9lWt6QkTEBED3MHgxy+6U/d08J8oyKRYs
	 Yc/T4ZrZD2G/N6jr5r5Q5P1CMlWu0LYLEWl02vgy5wI15g/p4mQ7aK4eBvkZZgHcJ/
	 zIARnbCkdNobA==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net,
	sashiko-bot@kernel.org,
	ycistak@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Check for NULL platform device in hotplug callbacks" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:32 -0500
Message-ID: <20261109201632-failed-6.1-0f9c7ed3b500@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0f9c7ed3b5009a037e5533eac03a0d4d45ecf1f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201632-failed-6.1-0f9c7ed3b500@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0f9c7ed3b5009a037e5533eac03a0d4d45ecf1f0 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 31 Oct 2026 03:08:08 +0000
Subject: [PATCH] hwmon: (coretemp) Check for NULL platform device in hotplug
 callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

coretemp_get_pdev() returns NULL when topology_logical_die_id(cpu) is
negative (such as -ENODEV or -ERANGE from topology_get_logical_id() on a
firmware/hardware APIC ID mismatch) or exceeds max_zones (for example,
under asymmetric or anomalous ACPI die topologies where
topology_max_packages() * topology_max_dies_per_package() is smaller
than the logical die count).

Commit 6d03bbff456b ("hwmon: (coretemp) Simplify platform device
handling") pre-allocated zone_devices[0 .. max_zones - 1] during module
init and dropped the NULL checks on pdev in coretemp_cpu_online() and
coretemp_cpu_offline(), passing pdev unconditionally to
platform_get_drvdata(). When coretemp_get_pdev() returns NULL,
platform_get_drvdata(pdev) dereferences &pdev->dev and triggers a kernel
NULL pointer dereference.

Check for a NULL pdev and return 0 in both coretemp_cpu_online() and
coretemp_cpu_offline() before calling platform_get_drvdata(). Returning
0 in coretemp_cpu_online() ignores the unmapped CPU without blocking CPU
bringup or tearing down valid thermal zones on other dies.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 6d03bbff456b ("hwmon: (coretemp) Simplify platform device handling")
Cc: stable@vger.kernel.org
Tested-by: Asaf Nuri Bertizlioğlu <ycistak@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 3836beade59f4..eb74ecd12310a 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -695,6 +695,9 @@ static int coretemp_cpu_online(unsigned int cpu)
 	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
+	if (!pdev)
+		return 0;
+
 	pdata = platform_get_drvdata(pdev);
 	if (!pdata->hwmon_dev) {
 		struct device *hwmon;
@@ -746,6 +749,9 @@ static int coretemp_cpu_offline(unsigned int cpu)
 		return 0;
 
 	/* If the physical CPU device does not exist, just return */
+	if (!pdev)
+		return 0;
+
 	pd = platform_get_drvdata(pdev);
 	if (!pd->hwmon_dev)
 		return 0;
-- 
2.53.0




