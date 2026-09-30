Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9271E1A3D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735116; cv=none; b=GEI0439CKkyyef9IvnsRTJBbfz69ySmcDyU+l82dq+7WtZJSJW3gl1CAGGRHmacMvzceJ/dfgJlt1CaiPW1gyEiBmmD61OT2dol3NR212TjXxSMY73XapME8fTKAYIBuoU81Egdysn9Dnj4hNz8O//qDWGBAxz6niYzvFjsVXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735116; c=relaxed/simple;
	bh=WK6jgrC8Emp8FUtbG+iHa8GZpFw61pY35hk9juaKvY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=allxnU4Waw6YSIRdimftE02/oHL1mlhfUDp6nwMOZfw6qt1dMOFKz9Uo0LFgICbb4Kp0iTGl+412AtrGznd/NZHDW+8YpyFPZV8u/cijX8pt4SEd3Y/dlRE2RghQUNVek5z5qTHjdhA8Djsxx7SwjCWzu2zVpFrbBruAyH2hr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfcNKyzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfcNKyzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D061F000FF;
	Wed, 30 Sep 2026 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735115;
	bh=TUb3FKuXSorhSBfID+SDwHEZU6YW5+TBbubN4IktRiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QfcNKyzqK3RraXZPGovoNsO5pPtJ9usVejHSnyC2BfuwjMonFeCYZ0Rs/TFxjlIOe
	 yMlltK5wD6fHldkkmsuJHdEKlAQ/wh2f/au77KVB0gTAsj8Obp7ye6lhLnANQT+BLc
	 e5XVGcetdn9WIZ52yptY/adGs98Q6tNnVk1YwAIa6rra72XXtFjfY3ioGVimpgt6WP
	 NZicw3OJ97Q3FdgUI9pQmwaQTRsgKiLssInBfQs59SC21ml0qcOGAKJgEyMFvrF1mv
	 oQ4iqYONKuBoeK7ad7Ag/cysFbjAHnmUXYmE2uLqNQCf3HX3DiRZ3UEXoQ5ow198vG
	 9z5V9l0h3q+xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net: ipconfig: Remove outdated comment and indent code block
Date: Tue, 29 Sep 2026 22:25:11 -0400
Message-ID: <20260930022512.3388377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092953-flinch-greeting-14e5@gregkh>
References: <2026092953-flinch-greeting-14e5@gregkh>
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
index e90bc0aa85c77..a7f5182c97fba 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -676,8 +676,18 @@ static const u8 ic_bootp_cookie[4] = { 99, 130, 83, 99 };
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
 
@@ -702,51 +712,36 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
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

