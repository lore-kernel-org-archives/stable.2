Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D973CB2DA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930084; cv=none; b=PErAezN2P1H8I+3GlAq74WbSa4/svxnm+gXop0g5Re3ZpSFBj+vzwOnv7XXk+PaEJ6bbWW1dvlauRx8uUc59MjLwXusKcY+NNlkdDwo4GKljuKrj2ZJgOUI+DfoXOPXY2STf94d7icv23to/8bRhY/4jSF4mTqJFSkQ0W1V9Syc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930084; c=relaxed/simple;
	bh=TBo7jhxyMO/YAshfjQ5ChUKHmcZg5G22ZVOvZ10QeZY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RZHggCu9NrXgPlDuNz5HKs+m1y7/jn6bOJPoEj88TQ4vq3JMUICC0Sc9Zf5ciwQcsDfW356jRz2q2U/88K1L0dgnWfvNHsmuM8VGc42bUtBFP10hIERL2c2BO7JPpTRwCd4IWjUVwOjIEryOufrAUznQ2wpdxZaI5EvL0aD6xeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jwa83+0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jwa83+0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3761A1F000E9;
	Wed,  5 Aug 2026 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930082;
	bh=TT+kakuMGG7fX5UjN6lNcz6njDnHyvnN8scbIf36WXQ=;
	h=Subject:To:Cc:From:Date;
	b=jwa83+0fGzjRuWv1wnCweppl/NW1JVW8V3gAsuUbv9WjwX5pVD24Zfx6SCyqlBiHW
	 707rsmfXiTcjLW8yCYYfLJJ4JYs5qziltUzzHK/zjbiumePfRpVtQy2nUGww0JZMLH
	 Cka59f3RmbRHqddewencoIm2+x+FULuyaTYzzinY=
Subject: FAILED: patch "[PATCH] s390/zcrypt: Close speculative mem read possibility" failed to apply to 6.12-stable tree
To: freude@linux.ibm.com,borntraeger@linux.ibm.com,fcallies@linux.ibm.com,gor@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:41:05 +0200
Message-ID: <2026080505-tubeless-abdominal-afcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e935cd525af4c6ed2e2c6404aa27ca19c7f39ddb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080505-tubeless-abdominal-afcf@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

