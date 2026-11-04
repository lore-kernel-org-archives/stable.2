Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799753;
	b=OyOpUXCMMXv1CA7nN7YFQvLxAAgIaiFLk+T+cbLrbosEXJaKyHUvAP9kxd0QxGXR8lM6
	 fbyKgNr+osxZnKGznIrcIWG+CB2FoWLkG/nV7UQbBHGC7JUoSybYFzNTQyoexkLprmtGf
	 K5kk8cBHmLfkLiZz+t0jbntHKcdNwUlvOSxUOynggr0GN3uM48oV2QEyys9/094mZWmx+
	 KUv4Q8PXhydn2OVBhdvjYsv1GyI31npIN0GDomfgN1juBcJBpEHPIVp5XtaTAjqjDleMd
	 5ayliP6kCQcBOp/BhOZkCgmJdi0H5bkal5lfC6sQdIyppIqja/niWwSNoLDcspibXLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799753;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sHI9zM0fvVId3VRn4Uf5gBNG6db+hPltkSATmtz2ro0=;
	b=xgGRbqA2Zfvpgt5BbiHeZ4eCEAKoJsZjha1bYiCAVBtFYR+6/ECFCBC2p25LWzEmDNic
	 QM2qtX3PBhB7ZV+62s8h2ZhkFzhR67uKT9Kd3jf2hcv6VVhr0CaKS7YDgQbdOWPGzIVwi
	 P0rx2okLhR/Ln1dW1ePqYMKEMpddCyhn2uNxeJOVNzMpjQTnmMi52HJZUePBQnBSx8U8O
	 4pEdCHORH7i+8ZBYqVi6T/dhlt4ppxMObhfwaXnGN2BrHSnSYdtPziPwcam7riSuOvDwJ
	 1utBcE53jiUEEc9VOwKaL+tGuaFXB7+nkzaYlC4vgkL34KHYwY/pFjCXpUNv6ZgAwVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LsZkCJfR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3F606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LsZkCJfR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FF81F00A16;
	Wed,  4 Nov 2026 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799753;
	bh=sHI9zM0fvVId3VRn4Uf5gBNG6db+hPltkSATmtz2ro0=;
	h=Subject:To:Cc:From:Date;
	b=LsZkCJfRnURzfowqwmSXz+f4Tn9UCDXaHowfZaGq3iA/yulYPQopEmznuCNGvv1gM
	 ZWh+rlMenCWUBDeoiPmr/qp/0n1J/BT2DVTafrLSOd7+Z0OgVtYGrgXes62suVvc6E
	 YYK4mb1qhbM6naos4t5GiRNDXkL/c9khWf6ygqeU=
Subject: FAILED: patch "[PATCH] s390/zcrypt: Guard domain index uses against speculative" failed to apply to 6.6-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:42:29 +0100
Message-ID: <2026110429-pregame-imbecile-c66d@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7b88e8b6d714cd1b2b6185e2963c8ec4d98542d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110429-pregame-imbecile-c66d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b88e8b6d714cd1b2b6185e2963c8ec4d98542d0 Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Tue, 6 Oct 2026 17:46:02 +0200
Subject: [PATCH] s390/zcrypt: Guard domain index uses against speculative
 bypass

The previous array_index_nospec() placement only covered the admin
permission check, leaving ap_test_config_usage_domain() and
ap_test_config_ctrl_domain() in the CCA path exposed to speculative
execution.

Move the sanitization to before all permission and config checks in
both the CCA and EP11 paths. Hold the sanitized domain value in
another variable so that the later use can choose to use either the
original value (subject to speculative execution) or the sanitized
value (which may in case of AUTOSEL_DOM reflect the wrong
value). Before that, check the domain value to be either AUTOSEL_DOM
or in range 0...AP_DOMAINS-1 and return with -EINVAL in case this check
does not pass.

Fixes: e935cd525af4 ("s390/zcrypt: Close speculative mem read possibility")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index ec6a4c2f9f04..80435fd8e6ad 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -854,7 +854,7 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 			      struct ica_xcRB *xcrb)
 {
 	bool userspace = xflags & ZCRYPT_XFLAG_USERSPACE;
-	unsigned int card, domain, func_code = 0;
+	unsigned int card, domain, _dom, func_code = 0;
 	unsigned int wgt = 0, pref_wgt = 0;
 	struct zcrypt_queue *zq, *pref_zq;
 	struct zcrypt_card *zc, *pref_zc;
@@ -877,10 +877,17 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
+	/* Check domain for either AUTOSEL_DOM or in range 0...AP_DOMAINS-1 */
+	if (domain != AUTOSEL_DOM && domain >= AP_DOMAINS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	/* Spectre-v1: sanitize domain unconditionally for later use */
+	_dom = array_index_nospec(domain, AP_DOMAINS);
+
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
-			domain = array_index_nospec(domain, AP_DOMAINS);
-			if (!test_bit_inv(domain, perms->adm)) {
+			if (!test_bit_inv(_dom, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
 			}
@@ -893,10 +900,11 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 	 * If a valid target domain is set and this domain is NOT a usage
 	 * domain but a control only domain, autoselect target domain.
 	 */
-	if (domain < AP_DOMAINS &&
-	    !ap_test_config_usage_domain(domain) &&
-	    ap_test_config_ctrl_domain(domain))
-		domain = AUTOSEL_DOM;
+	if (domain < AP_DOMAINS) {
+		if (!ap_test_config_usage_domain(_dom) &&
+		    ap_test_config_ctrl_domain(_dom))
+			domain = AUTOSEL_DOM;
+	}
 
 	pref_zc = NULL;
 	pref_zq = NULL;
@@ -1041,7 +1049,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 	struct ep11_target_dev *targets = NULL;
 	unsigned short target_num;
 	unsigned int wgt = 0, pref_wgt = 0;
-	unsigned int func_code = 0, domain;
+	unsigned int func_code = 0, domain, _dom;
 	struct ap_message ap_msg;
 	int cpen, qpen, qid = 0, rc;
 	struct module *mod;
@@ -1078,10 +1086,17 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
+	/* Check domain for either AUTOSEL_DOM or in range 0...AP_DOMAINS-1 */
+	if (domain != AUTOSEL_DOM && domain >= AP_DOMAINS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	/* Spectre-v1: sanitize domain unconditionally for later use */
+	_dom = array_index_nospec(domain, AP_DOMAINS);
+
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
-			domain = array_index_nospec(domain, AP_DOMAINS);
-			if (!test_bit_inv(domain, perms->adm)) {
+			if (!test_bit_inv(_dom, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
 			}

