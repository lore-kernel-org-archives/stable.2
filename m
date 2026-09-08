Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513423D7DF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831507; cv=none; b=mWtCL5e1CBW0x0LkZzoS9m6wykqf/jhp8CLBakjep8C8lmM3oU8di11qoXbcgWevTTuxZFDN0KvewOQqQayfUtyVZMbmvdMAAuTXuXYIcY398nW659jnkHfsh/OWpDQPzEnJBOElEWUl1CxMPKlHmIsnZpjm3GqopgJHMNUjYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831507; c=relaxed/simple;
	bh=cjb5kqNzFwUk9IyDyC4HfmNyL4diYrynr6xUt1UwFlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3BvM4bCgPOEGu5SF5Y9S8ubUWsk0BDLivQPBL7w4hUUUj15RrFK62lqWHbRcwMhp2ZQSfG0O7Djder681DkO9MYBgyie1DAmBOX34m9QYQ+dldIaSIKh+LBD1NJ0HlVRJB1ukM8CeJ2do2jRx10es5Lu7Irl6mK1OZ7x93lH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba7nqhL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba7nqhL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318381F00A3A;
	Tue,  8 Sep 2026 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788831505;
	bh=V8th6lJEigmPcJNCv+ZolVYeVqw1lok5QMddkGmlZsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ba7nqhL4w6gF6P2bG/YpfvMvvxO667YlKkMtPRVnW3O9ESqmNXSFme+TnWJiX2WAQ
	 g3wYTXehXFIWolmnrhjq0bbfYp4H9eVbAz+9s5TJHp5wwrfR9/g9f1CC1tu4gaO2zd
	 BpDAM6oRGoD9AbxfP6OXm+HtU2g5dOQwo+Heb4BmqpNZgQr1KlrPtYfDDIoQgWZCSS
	 V3ah2aT6V3RhnOtn/tem+E/QEZZk009gcymPIuLTl/HEvRp2JsGW1kYK0jWmyg+KV0
	 giL+bOdbTZBCgvdk5su2+eLmAkE7hLyt1616h4Y684+bPU56SrGIvHvfHfRZUrGYIu
	 A3m5v5bo4uRPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rong Zhang <i@rong.moe>,
	Avraham Hollander <anhollander516@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] ACPI: battery: Use kstrtoul() over sscanf("%lu\n")
Date: Mon,  7 Sep 2026 21:38:22 -0400
Message-ID: <20260908013823.1787474-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090357-tweet-veal-37b7@gregkh>
References: <2026090357-tweet-veal-37b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Zhang <i@rong.moe>

[ Upstream commit 57346c4d78d38b357dbe9ef16d3f63bf4610c039 ]

It is more preferred to use kstrto*() to parse a single number. The
function family properly returns an errno on error and is the correct
mechanism to parse data from sysfs.

The number base is set to 10 in order not to break the ABI.

Tested-by: Avraham Hollander <anhollander516@gmail.com>
Signed-off-by: Rong Zhang <i@rong.moe>
Link: https://patch.msgid.link/20260718-b4-acpi-battery-notification-v4-2-599c8ed1072f@rong.moe
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 9e409f1dff78 ("ACPI: battery: Protect all properties with a separated mutex")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f5e0eb299610b..605c47efdf06b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -668,9 +668,13 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 {
 	unsigned long x;
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+	int err;
 
-	if (sscanf(buf, "%lu\n", &x) == 1)
-		battery->alarm = x/1000;
+	err = kstrtoul(buf, 10, &x);
+	if (err)
+		return err;
+
+	battery->alarm = x / 1000;
 	if (acpi_battery_present(battery))
 		acpi_battery_set_alarm(battery);
 	return count;
-- 
2.53.0

