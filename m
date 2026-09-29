Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E143C13E6
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674638; cv=none; b=tEHT1IPNB3tYdcGHoCiGA1J1KrCOKeUm2PlrXphjP9rrocvwYXQsgKAzFIrQBu11MV/rvmMR3SGfp/mqI1BW2S1//nHSNwKb6CybunyKogwNKx0/iHPdDrS5va4pULIRvBSsQpbdphn2nKzAky8SkGKG4qzstSkyoE2YhT3xOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674638; c=relaxed/simple;
	bh=1p4w7oypEH3IU/RaVtuFsq89PGebQaC0xl0alV0SrCA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TFD8CADBDJGFZpykLRH1lTQ1VNLVUz2Zkxqt0CG2z5x3AIqss6b3Y3unnjS5CECvHlXlGGrq73IIbLfxs/1rXOvl31bfiILWugSXJ2z6WQaU+OQtlMcla8efFOJkR+1IDnUeewrxjMY4tAr28Z1JjPBrVbosAuqcNprQa6c/Qa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XJknJkcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XJknJkcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854781F000FF;
	Tue, 29 Sep 2026 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674637;
	bh=X0A3z5XQPaVRX67T27MqqxDRitUWJzjNdoOKc+mETnc=;
	h=Subject:To:Cc:From:Date;
	b=XJknJkcl2A4YErZe1R93PjJZ8p+7eU5LlqPnwKHbUR6AH7PEn6vTACB1nIwFOcLDA
	 /8phvzSk8LK0v1YN/emscBibdu+BQdCtG0r0YapFvcWmcCE//VHNTXoniLfqKszL4z
	 YdFqFRo9KhUSGxcKkpm5e8vVZkJ2v9QppyeAeYOU=
Subject: FAILED: patch "[PATCH] net: ipconfig: bound DHCP option construction" failed to apply to 5.10-stable tree
To: xuyuqiabc@gmail.com,horms@kernel.org,pabeni@redhat.com,vega@nebusec.ai,weir@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:36:54 +0200
Message-ID: <2026092954-module-canary-801f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e47a1958e12abc3a17b5231a4f21c8f1bf662e08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092954-module-canary-801f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e47a1958e12abc3a17b5231a4f21c8f1bf662e08 Mon Sep 17 00:00:00 2001
From: Yuqi Xu <xuyuqiabc@gmail.com>
Date: Sat, 19 Sep 2026 16:45:27 +0800
Subject: [PATCH] net: ipconfig: bound DHCP option construction

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

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 155db067eaec..1b8585404a41 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -676,6 +676,24 @@ static const u8 ic_bootp_cookie[4] = { 99, 130, 83, 99 };
 
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
@@ -691,6 +709,7 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 		42,	/* NTP servers */
 	};
 	u8 mt = (ic_servaddr == NONE) ? DHCPDISCOVER : DHCPREQUEST;
+	u8 *end = options + sizeof(((struct bootp_pkt *)0)->exten);
 	u8 *e = options;
 	int len;
 
@@ -721,31 +740,19 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
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

