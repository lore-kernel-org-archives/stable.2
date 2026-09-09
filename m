Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C70582BB6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971240; cv=none; b=XtSpX9brdkawtun9J/8wt9dfaihBhRpnqlwD9erjudBjoAz41aau3OsbA7i7wXhdixUvd2isYyebgfchCezuBDxhIGzIWxemCNHtPXkX6Hdn0LEMSNEERBwlgFs7nlHAc8Crc1u1HxIbwbGAWaQP+p6s0JGl3ulPycHQHQ3l24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971240; c=relaxed/simple;
	bh=QyMu6quOOA5WlZ8FsnkYuNCoXoZDBzHeULc3dlgCQXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G313a8XjKwF+Nxw8joWT1SWDHmT8T1NTfH08DhtIF9XFAlC1DNERuFO/92skD7i4rcRX4A510R3CQ2p/5AwViwUBxM/L3JUldh6LmozRRmj4TfcqPUE6lWQ7vkT9cbOh6GARDiyFu5K87PSeoSy5UYXnXpNy1a67RSIRu52pKyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9tEYIPw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9tEYIPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4FB1F00898;
	Wed,  9 Sep 2026 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971238;
	bh=YWCh3B6c+D5Y9L0eCmJeXemS2Yfh/rl8qgTI5/N+ctU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9tEYIPwSbofnnfcSobjLDUoxEQTZvCEFotlt3uTcsBo8fjtWSUjR9vzov3qggmi9
	 Vbj4xEKnyhBlHEKdwg5tF4oZLkO7Qc/XAYfCE+IsNsPnnYjKncpK8g8YwG1gfoisQI
	 iepobm3/OfIq2xct1fmfyY5xv7OpwvHrfClXAPqh71mPeE9UmQU+EQLdtIj39/cvYC
	 WEtcjFDeWEoYPCMzx3JgmcIzETi+VK2PYLX35RseDgoj+L58jrAa1b6cRJV8O3Vhcn
	 na33tUEf9iZOQySJ9tn+jtn/hQIRtGbrX0hXOoNCecH1kqlIA1xmwpNHEgDsjx9Eoq
	 5hs8pIUAHnaDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] platform/x86: think-lmi: Use strreplace() to replace a character by nul
Date: Wed,  9 Sep 2026 12:27:13 -0400
Message-ID: <20260909162714.2984324-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162714.2984324-1-sashal@kernel.org>
References: <2026090342-duct-salutary-5524@gregkh>
 <20260909162714.2984324-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 6cb9c8637c672584d4915559001020237840acba ]

We can replace
	p = strchrnul(str, '$OLD');
	*p = '\0';
with
	strreplace(str, '$OLD', '\0');
that does the compatible modification without a need of the temporary variable.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230918135116.1248560-2-andriy.shevchenko@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: 54745d563114 ("platform/x86: think-lmi: Fix current password length check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 58c070198e59f..00d0cf34196d4 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -909,7 +909,7 @@ static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *at
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
-	char *item, *value, *p;
+	char *item, *value;
 	int ret;
 
 	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
@@ -922,8 +922,7 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
 		ret = -EINVAL;
 	else {
 		/* On Workstations remove the Options part after the value */
-		p = strchrnul(value, ';');
-		*p = '\0';
+		strreplace(value, ';', '\0');
 		ret = sysfs_emit(buf, "%s\n", value + 1);
 	}
 	kfree(item);
@@ -1430,7 +1429,6 @@ static int tlmi_analyze(void)
 	for (i = 0; i < TLMI_SETTINGS_COUNT; ++i) {
 		struct tlmi_attr_setting *setting;
 		char *item = NULL;
-		char *p;
 
 		tlmi_priv.setting[i] = NULL;
 		status = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
@@ -1447,8 +1445,7 @@ static int tlmi_analyze(void)
 		strreplace(item, '/', '\\');
 
 		/* Remove the value part */
-		p = strchrnul(item, ',');
-		*p = '\0';
+		strreplace(item, ',', '\0');
 
 		/* Create a setting entry */
 		setting = kzalloc(sizeof(*setting), GFP_KERNEL);
-- 
2.53.0

