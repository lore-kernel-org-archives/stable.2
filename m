Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A0234FF5D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731295; cv=none; b=TMR6u8ZpvBGkm8zZY6UH7ORR/pz4It/opN08VIRAfna6eYdvEko17k3VZSqRL718Ikg95ImjK4m37wu7P/lNNM7xloCA4ZoCshrZcuNcQQrL9noyH+imVknAJXz16R7NGL6yl99gPNL+4Ifxk9BKVYmI0E5Exz4WJGXIgWge4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731295; c=relaxed/simple;
	bh=uJSaxtp9fGetBZvWKqcOKdoGznJkUnbZZi9bdis5tY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0DhHGCPEolPSMlJvnqhkdhS+OhE2HYhZM3R0wa9SkScI3OTowVwKq/n5E1xBLdC8Z6dx76eFxRepWhkh0k5Du8VxPpcvgnQ6VVLUeiyOA5/X/9A8WkKp8myfp/EqnZvytbzVTwGdYTV4uvjdg1Y0UuXEwlBLB8KURKnfAxylvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHWdjiIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHWdjiIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A02F1F000FF;
	Wed, 30 Sep 2026 01:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731293;
	bh=dT+ivwQYg6ET7efu/gV+zA/lgcdxZoHub2y9IWyLfmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fHWdjiIeriTCBDcIcd3Ebs1zIudOQwPMqDcp9OFbgi+KJSzOg3hVhmFUN12WFS8BU
	 yOjgK4OBDUTzUu2+BCwQxoU0Cyu55lf6lTxLTBUDKxLMucjzWukP0+Os8NxXNs9F6B
	 c+reqyoR0SmpbWb4gfTswvqKNrwE9eiTAfS8moSiiBjNxigbbuMvbXEFZHu0KXSs9H
	 dCscA714NPzotvCs+CGNBTnmuJTYeiN5WsOJxylHD14XT/1Otsz7tt0X8ZZuuPKX9N
	 4HoJTyVTqecvQCsr1AXC/GrFZYEShu7DqnYN14EpMnZtR4ibq+9vaBwALUG9FCAn3D
	 xofDQtnz6zacw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] net: ipconfig: Remove outdated comment and indent code block
Date: Tue, 29 Sep 2026 21:21:30 -0400
Message-ID: <20260930012131.3261705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092951-scholar-stillness-99df@gregkh>
References: <2026092951-scholar-stillness-99df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit e405b3c9d4aaa10972525fe2ea5cf94224020561 ]

The comment has been around ever since commit 1da177e4c3f4
("Linux-2.6.12-rc2") and can be removed. Remove it and indent the code
block accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260109121128.170020-2-thorsten.blum@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e47a1958e12a ("net: ipconfig: bound DHCP option construction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipconfig.c | 89 +++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 22a7889876c1c..3febc920228ca 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -679,8 +679,18 @@ static const u8 ic_bootp_cookie[4] = { 99, 130, 83, 99 };
 static void __init
 ic_dhcp_init_options(u8 *options, struct ic_device *d)
 {
-	u8 mt = ((ic_servaddr == NONE)
-		 ? DHCPDISCOVER : DHCPREQUEST);
+	static const u8 ic_req_params[] = {
+		1,	/* Subnet mask */
+		3,	/* Default gateway */
+		6,	/* DNS server */
+		12,	/* Host name */
+		15,	/* Domain name */
+		17,	/* Boot path */
+		26,	/* MTU */
+		40,	/* NIS domain name */
+		42,	/* NTP servers */
+	};
+	u8 mt = (ic_servaddr == NONE) ? DHCPDISCOVER : DHCPREQUEST;
 	u8 *e = options;
 	int len;
 
@@ -705,51 +715,36 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 		e += 4;
 	}
 
-	/* always? */
-	{
-		static const u8 ic_req_params[] = {
-			1,	/* Subnet mask */
-			3,	/* Default gateway */
-			6,	/* DNS server */
-			12,	/* Host name */
-			15,	/* Domain name */
-			17,	/* Boot path */
-			26,	/* MTU */
-			40,	/* NIS domain name */
-			42,	/* NTP servers */
-		};
-
-		*e++ = 55;	/* Parameter request list */
-		*e++ = sizeof(ic_req_params);
-		memcpy(e, ic_req_params, sizeof(ic_req_params));
-		e += sizeof(ic_req_params);
-
-		if (ic_host_name_set) {
-			*e++ = 12;	/* host-name */
-			len = strlen(utsname()->nodename);
-			*e++ = len;
-			memcpy(e, utsname()->nodename, len);
-			e += len;
-		}
-		if (*vendor_class_identifier) {
-			pr_info("DHCP: sending class identifier \"%s\"\n",
-				vendor_class_identifier);
-			*e++ = 60;	/* Class-identifier */
-			len = strlen(vendor_class_identifier);
-			*e++ = len;
-			memcpy(e, vendor_class_identifier, len);
-			e += len;
-		}
-		len = strlen(dhcp_client_identifier + 1);
-		/* the minimum length of identifier is 2, include 1 byte type,
-		 * and can not be larger than the length of options
-		 */
-		if (len >= 1 && len < 312 - (e - options) - 1) {
-			*e++ = 61;
-			*e++ = len + 1;
-			memcpy(e, dhcp_client_identifier, len + 1);
-			e += len + 1;
-		}
+	*e++ = 55;	/* Parameter request list */
+	*e++ = sizeof(ic_req_params);
+	memcpy(e, ic_req_params, sizeof(ic_req_params));
+	e += sizeof(ic_req_params);
+
+	if (ic_host_name_set) {
+		*e++ = 12;	/* host-name */
+		len = strlen(utsname()->nodename);
+		*e++ = len;
+		memcpy(e, utsname()->nodename, len);
+		e += len;
+	}
+	if (*vendor_class_identifier) {
+		pr_info("DHCP: sending class identifier \"%s\"\n",
+			vendor_class_identifier);
+		*e++ = 60;	/* Class-identifier */
+		len = strlen(vendor_class_identifier);
+		*e++ = len;
+		memcpy(e, vendor_class_identifier, len);
+		e += len;
+	}
+	len = strlen(dhcp_client_identifier + 1);
+	/* the minimum length of identifier is 2, include 1 byte type,
+	 * and can not be larger than the length of options
+	 */
+	if (len >= 1 && len < 312 - (e - options) - 1) {
+		*e++ = 61;
+		*e++ = len + 1;
+		memcpy(e, dhcp_client_identifier, len + 1);
+		e += len + 1;
 	}
 
 	*e++ = 255;	/* End of the list */
-- 
2.53.0

