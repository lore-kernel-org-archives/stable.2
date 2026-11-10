Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273998;
	b=vDvGhfBmMuj1XyImefTkDz6XfLMSw/O4wKLYXB1ojroCT32AkbmP3BZjB8++/PxullSd
	 iDH26UBtefJlbV9MGc81tn/lWiFARHYFhG2aqAxA+Xfj/D2w7oRzXDpkPj1S6miu5Ruj8
	 Xx6iZJvsGAQRuX1czuNQXlnOYgrUP/E0GuP1U2M+/VKbroedK8j6fHYhGsDWt3XCF0lQw
	 8bkII0tEmSiIaP3XnoRYr2ttuh9y0ofSP3fUkqAQOaEQYp1gnlYVZGtyu74Xm98nX1J48
	 XqlUYiKssG6L06JcG2QKjsDRaTDFXdBS9LBjxhMUUTt6Hnfj4G2lYoHWQOmj/zGl2Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=k1pPcTzBEnbu5RmIcTr/zoSADNiIq9xKrJsSJ92q9rE=;
	b=Ogl/y73K8N0lmojJsw0TqCf56KdsYj5TxcqUfAYTU/nlurjUegvQ6ZNMtuwaEai5ZK57
	 YeuEQLccwXtqQLYdZDvQDWeI6MqBogM/bVOVOUlz0avfdc9wfl7x6oajzKNc7M9xn7zSi
	 01CAnkyy7nalVgo5BQEIVLrcDdr9egtvpE81XDfz3zWi6i3p3esV8tLbSzliDDE21WOYf
	 xGDxZ9Au/wCm5TBbIspZrrQmsxT/geqKlhfZ2qjYgkX4wa2FUFJOiIpOoML30po4BIeu2
	 poYpm9zVwrvFDXmGWZlESQG6WKhpgp/x/u+TpIJX17MS1xoF6cLxOElcDaAvfDmGnvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9rb0AWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9rb0AWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483281F0089F;
	Tue, 10 Nov 2026 01:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273997;
	bh=k1pPcTzBEnbu5RmIcTr/zoSADNiIq9xKrJsSJ92q9rE=;
	h=From:To:Cc:Subject:Date;
	b=c9rb0AWS3uPRRLzt3bE8aeagbZZCwWLyc3iJ8Dt8TUWg/eXNB8IsxGayCQfpJ5lxg
	 0ngY0IULkc+YCzkoRtTCm4qcByvOEvmlJ51R+orVqIBvPWFvIiLWcds8zxTiYYNcRp
	 HBy4m8fAFofLJskKj1xYGE9pwXMaF/saSiQQ3OmJ1qtCZ02G9tBcHojQqn8V722ein
	 lAlA7O/fGd0iPubmQ+bfTZXMgnWz9fYxpj2/D/yJFCs5xiyMSxOMt5GmDM9Ov4DHld
	 8gIs6ioSbL42tznAxcuPFBg0b01KkxuWhgBS3qTed6pgfa3nBs1EFLv24J5Xq5y0Zt
	 Sw51eRNTp2GDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net,
	sashiko-bot@kernel.org,
	ycistak@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Check for NULL platform device in hotplug callbacks" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:36 -0500
Message-ID: <20261109202636-failed-5.10-0f9c7ed3b500@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0f9c7ed3b5009a037e5533eac03a0d4d45ecf1f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202636-failed-5.10-0f9c7ed3b500@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




