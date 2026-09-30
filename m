Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C381B23EAA6
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735923; cv=none; b=CPT2gjdDvccDe4AhCB/uVy8xnCOgipYkQRvoyHMIbInjps/zKyUdXUwFl88H/dXLOHxn18d5vqkAGNIHSlBTw67OekPW7BgsqMbAMwCo0juN83fMUJNYI3qLD4VxwSc5v72nINvg4VI2DZiI+ffdGJzroCE8RgbW1SNRokD73fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735923; c=relaxed/simple;
	bh=aC0NHjmPEOzJrWatDk5EkWpZjKM9bFPKBaBVqhIUOWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+Z7RmNM4XGtez/zxRm8hYxR92xOYTXCA3vfAxvDQMWz4a+oQdmkFD12wuMBHll91p62oC398ni4bm2QvwBtVUlXUomeHDEebEmkqLOXzaBVH8nOYyTIgtJgO5iOlAXwjBclvDA++hZv0Ja+XrNqiRo5iqMfwZFvSH6UnNVOgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/GdZF2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/GdZF2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FD61F00898;
	Wed, 30 Sep 2026 02:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735922;
	bh=4ZT8sgIEP0gw8s9pvYifjb7yxDYSO37HnBhCiFK3dDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/GdZF2cD1vdgFVwDq9y4wfKsGyc8eiu2rQCqK+nMt0JsAp4UPgHSEi5wqHJOzLAt
	 X+ov8SMKexzcdds2AppDZoJJuv7EOtXtwVDHjuP89Vu1kl1nOq6vlpnHhA3wVPbCmm
	 6GUPLtGXH5e6M3UuGeLj9LG+3xeddFIlAJgVBcxSoRAoCMfGMMXDNAxvvtvTLFGWfl
	 DcuO91UcvZ7WfVDsniQoSa8N0dCTacNl0LBN1GWkiLvceAOFMnrrQMti8s3BUtLvdK
	 0LNE0Fi7QzncD0ZO0ZpEF3Fn6dcuPmEQKj8lU2G9iHtMYjFVOznzZnTDpe7Wxvc7kM
	 8vFwheIQK9PHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuqi Xu <xuyuqiabc@gmail.com>,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net: ipconfig: bound DHCP option construction
Date: Tue, 29 Sep 2026 22:38:39 -0400
Message-ID: <20260930023839.3438256-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930023839.3438256-1-sashal@kernel.org>
References: <2026092954-module-canary-801f@gregkh>
 <20260930023839.3438256-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuqi Xu <xuyuqiabc@gmail.com>

[ Upstream commit e47a1958e12abc3a17b5231a4f21c8f1bf662e08 ]

ic_dhcp_init_options() appends the hostname (option 12), vendor-class
(option 60) and client-ID (option 61) options into the fixed 312-byte
bootp_pkt.exten[] buffer.  Only the client-ID branch checked the
remaining space; the hostname and vendor-class writes were unbounded.

A 64-byte hostname together with the maximum 252-byte dhcpclass=
identifier needs 18 + (2 + 64) + (2 + 252) = 338 of the 312 available
bytes even before the terminating END marker, so the vendor-class memcpy
runs past the end of exten[].  With CONFIG_FORTIFY_SOURCE this is
reported as a field-spanning write and, when the kernel is booted with
panic_on_warn=1, aborts boot with a panic.

Route the optional options through a common helper that makes sure the
option, its 2-byte header and the END marker all fit and drops an option
that would not.  Configurations with short options keep sending exactly
the same bytes as before.

Fixes: 130c0f47fdf9 ("ipconfig: send host-name in DHCP requests")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/7808dfbfa2162dfd0b19f59aff5742d6e0db2abb.1789798023.git.xuyuqiabc@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipconfig.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 986d469651d2e..8e24dc3c326bb 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -649,6 +649,24 @@ static const u8 ic_bootp_cookie[4] = { 99, 130, 83, 99 };
 
 #ifdef IPCONFIG_DHCP
 
+static bool __init
+ic_dhcp_add_option(u8 **options, const u8 *end, u8 type, const void *value,
+		   int len)
+{
+	u8 *e = *options;
+
+	/* leave room for the option header and the END marker */
+	if (len > U8_MAX || end - e < len + 3)
+		return false;
+
+	*e++ = type;
+	*e++ = len;
+	memcpy(e, value, len);
+	*options = e + len;
+
+	return true;
+}
+
 static void __init
 ic_dhcp_init_options(u8 *options, struct ic_device *d)
 {
@@ -664,6 +682,7 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 		42,	/* NTP servers */
 	};
 	u8 mt = (ic_servaddr == NONE) ? DHCPDISCOVER : DHCPREQUEST;
+	u8 *end = options + sizeof(((struct bootp_pkt *)0)->exten);
 	u8 *e = options;
 	int len;
 
@@ -694,31 +713,19 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 	e += sizeof(ic_req_params);
 
 	if (ic_host_name_set) {
-		*e++ = 12;	/* host-name */
 		len = strlen(utsname()->nodename);
-		*e++ = len;
-		memcpy(e, utsname()->nodename, len);
-		e += len;
+		ic_dhcp_add_option(&e, end, 12, utsname()->nodename, len);
 	}
 	if (*vendor_class_identifier) {
-		pr_info("DHCP: sending class identifier \"%s\"\n",
-			vendor_class_identifier);
-		*e++ = 60;	/* Class-identifier */
 		len = strlen(vendor_class_identifier);
-		*e++ = len;
-		memcpy(e, vendor_class_identifier, len);
-		e += len;
+		if (ic_dhcp_add_option(&e, end, 60, vendor_class_identifier, len))
+			pr_info("DHCP: sending class identifier \"%s\"\n",
+				vendor_class_identifier);
 	}
 	len = strlen(dhcp_client_identifier + 1);
-	/* the minimum length of identifier is 2, include 1 byte type,
-	 * and can not be larger than the length of options
-	 */
-	if (len >= 1 && len < 312 - (e - options) - 1) {
-		*e++ = 61;
-		*e++ = len + 1;
-		memcpy(e, dhcp_client_identifier, len + 1);
-		e += len + 1;
-	}
+	/* the minimum length of identifier is 2, include 1 byte type */
+	if (len >= 1)
+		ic_dhcp_add_option(&e, end, 61, dhcp_client_identifier, len + 1);
 
 	*e++ = 255;	/* End of the list */
 }
-- 
2.53.0

