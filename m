Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB33C8C46
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930095; cv=none; b=lPVAtefmh1cOQd48i15jpeJ3rtna/tP2OCxubhnKF+dC/K8bpKeN9ikOnqKQzf/teYTYneZj7P7gJxXhEGs2Si/LY9PbLkiysbuUi7is03Jl4Nn/1v/kt8/RKp8lKR5rZCA+Oacm8jvM6WAywAHKljrU6APQx8hUbKU73ujI9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930095; c=relaxed/simple;
	bh=wtxA+3z//1nu4CFo+Nz1dPZlommxTvO+5mRikK4mjmo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GRQLZVYU11rfrd8nS5LYaS+uB8Rq8UiAjfBEgHc6s0wP9qZwpc9HEKLTPubS4R6/xGTCHsHj/tM57H1VatRgdWsJma+XD7qfakqy5dmmhb5su3igZQKj8ovrQrmYNds/pqk7J7+BHZc4WDiOEdn5VVBPvxgDIMrGIIPjC65jb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lgVWj9Zz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lgVWj9Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C9A1F000E9;
	Wed,  5 Aug 2026 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930093;
	bh=IRWquEL7OtsvS5I1/niprkwJvopKgY/9O3b/VtVgONE=;
	h=Subject:To:Cc:From:Date;
	b=lgVWj9ZzqtZKUYhk0DAlDdSCeQPBOaVMmTmtEaC63tA6HoabYCb3jOKqRwoHLMlSd
	 7mi67AIjqi/gD8rggrUjd1tZs9fFSmfA0oVt/3ZKmhKyc7fx9GPwgaJBC+zCzVQc3U
	 6+TEKCSjKkndlXwcf41HgMs+O8/jNLhDQPYIUje0=
Subject: FAILED: patch "[PATCH] s390/zcrypt: Close speculative mem read possibility" failed to apply to 6.6-stable tree
To: freude@linux.ibm.com,borntraeger@linux.ibm.com,fcallies@linux.ibm.com,gor@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:41:06 +0200
Message-ID: <2026080506-clamshell-obligate-3e73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x e935cd525af4c6ed2e2c6404aa27ca19c7f39ddb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080506-clamshell-obligate-3e73@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e935cd525af4c6ed2e2c6404aa27ca19c7f39ddb Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Thu, 23 Jul 2026 11:54:53 +0200
Subject: [PATCH] s390/zcrypt: Close speculative mem read possibility

The domain value is extracted from a given CCA or EP11 ioctl struct
when a CPRB is about to be sent. Thus this is a user controlled value.
Under some special conditions (custom device node used, administrative
load) this value is used as an array index after bounds checking, but
without speculation barrier.

Add the missing array_index_nospec() call to prevent speculative
execution where this domain value is used.

Fixes: cfd68b33094e ("s390/zcrypt: Filter admin CPRBs on custom devices")
Cc: stable@vger.kernel.org
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 81eefdeae248..ec6a4c2f9f04 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -879,6 +879,7 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
+			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
@@ -1079,6 +1080,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
+			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;

