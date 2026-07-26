Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52A30C150
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101321; cv=none; b=mgpK0ipQ6UBg0iEAj0MzvgXIXKrffvwFWYxznp7x/03R8/WXNH4fJp/FcjiLmqBAp3EuotQpI6ap4JUAVLe/jfja1F5ie1CzUlY94FDnKAKgQL98vZEfdUOv424Y2FlqkNa6ApLE8+q8dZKR2y3MJvhAbfokR7vDEObsDMhCq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101321; c=relaxed/simple;
	bh=7RqM5fKGUvV51abOo60fIRlSPasois5PrXqJcSfuJrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhFcbkhe8E3bctMDhCASGViyWKlF6BMtH/ZW/+pFyVU760WYmCmeG5pNfJd2Cs6xvWJZkJZU2IcuWwZTeEtpuDr3rC/ofu9Iz7GDmcbxO+MNiR8RJ7yNH2M1bvnHKyM5ycRu2FWuqqd97eYQkqrGl1Alxy/7fiUPO8ZMDGlveNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTFZNc0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTFZNc0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC4B1F000E9;
	Sun, 26 Jul 2026 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101319;
	bh=aY6moCBotURQLmNKx8kBEnFCLYu2HOiKU+zypHv4HoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTFZNc0XFZSpDezBq4P4lIosTOPGXrFJCV3Gm+9RvtJFj2aQnARa3X4kJPZjBtwW2
	 jhenc7Bfi0imCkK1jmxK2cZ/DJp+b9jmmrGP4w81a6mcwku18LCZpP/RQ/WZZwfjb5
	 1jYwidV4GdehjHk0TDi+HF1GdUoardnU0vPeAr8C8PEMBvhFSQLZuxhJIGlF3lBXjl
	 0wua2MkBDkLNmwgJtuRgmf8FEKEJpHhxI9DTheKr0z5yVtRpXawBD0aFTgCec2RcL3
	 J9VhYvc+77Xng/LRQnkKk5bnLV5BeVtOfQIY7z4gCrSEvnjuErulCIwKWeed8sS7i3
	 XE4+BmvhcyNqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lyndon Sanche <lsanche@lyndeno.ca>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] platform/x86: dell-smbios: Move request functions for reuse
Date: Sun, 26 Jul 2026 17:27:29 -0400
Message-ID: <20260726212730.4016280-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072059-eastcoast-eating-4897@gregkh>
References: <2026072059-eastcoast-eating-4897@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lyndon Sanche <lsanche@lyndeno.ca>

[ Upstream commit 33245680ae565aaa114d726bf407c8ff38e75e71 ]

Move the dell_send_request and dell_fill_request symbols into smbios-base
so that they can be used in multiple modules.

Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
Link: https://lore.kernel.org/r/20240529174843.13226-3-lsanche@lyndeno.ca
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 6e9cab2247e5 ("platform/x86: dell-laptop: fix missing cleanups in init error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-laptop.c      | 23 ------------------
 drivers/platform/x86/dell/dell-smbios-base.c | 25 ++++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios.h      |  5 ++++
 3 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 6586438356de76..eedec47616b481 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -353,29 +353,6 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
 	{ }
 };
 
-static void dell_fill_request(struct calling_interface_buffer *buffer,
-			       u32 arg0, u32 arg1, u32 arg2, u32 arg3)
-{
-	memset(buffer, 0, sizeof(struct calling_interface_buffer));
-	buffer->input[0] = arg0;
-	buffer->input[1] = arg1;
-	buffer->input[2] = arg2;
-	buffer->input[3] = arg3;
-}
-
-static int dell_send_request(struct calling_interface_buffer *buffer,
-			     u16 class, u16 select)
-{
-	int ret;
-
-	buffer->cmd_class = class;
-	buffer->cmd_select = select;
-	ret = dell_smbios_call(buffer);
-	if (ret != 0)
-		return ret;
-	return dell_smbios_error(buffer->output[0]);
-}
-
 /*
  * Derived from information in smbios-wireless-ctl:
  *
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 9a9b9feac41664..636d881c947770 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -320,6 +320,31 @@ int dell_smbios_call(struct calling_interface_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(dell_smbios_call);
 
+void dell_fill_request(struct calling_interface_buffer *buffer,
+			       u32 arg0, u32 arg1, u32 arg2, u32 arg3)
+{
+	memset(buffer, 0, sizeof(struct calling_interface_buffer));
+	buffer->input[0] = arg0;
+	buffer->input[1] = arg1;
+	buffer->input[2] = arg2;
+	buffer->input[3] = arg3;
+}
+EXPORT_SYMBOL_GPL(dell_fill_request);
+
+int dell_send_request(struct calling_interface_buffer *buffer,
+			     u16 class, u16 select)
+{
+	int ret;
+
+	buffer->cmd_class = class;
+	buffer->cmd_select = select;
+	ret = dell_smbios_call(buffer);
+	if (ret != 0)
+		return ret;
+	return dell_smbios_error(buffer->output[0]);
+}
+EXPORT_SYMBOL_GPL(dell_send_request);
+
 struct calling_interface_token *dell_smbios_find_token(int tokenid)
 {
 	int i;
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
index eb341bf000c675..641f18c2f7e6e4 100644
--- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -64,6 +64,11 @@ int dell_smbios_call_filter(struct device *d,
 	struct calling_interface_buffer *buffer);
 int dell_smbios_call(struct calling_interface_buffer *buffer);
 
+void dell_fill_request(struct calling_interface_buffer *buffer,
+			       u32 arg0, u32 arg1, u32 arg2, u32 arg3);
+int dell_send_request(struct calling_interface_buffer *buffer,
+			     u16 class, u16 select);
+
 struct calling_interface_token *dell_smbios_find_token(int tokenid);
 
 enum dell_laptop_notifier_actions {
-- 
2.53.0

