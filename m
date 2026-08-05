Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA13EB0E1
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930092; cv=none; b=gNjh15eeGCoUQ2CCjvbgi6r8874rxaCsdTGlHMyI53fhDD07eI3f46dzx3AU+EIrSke1tyro8wiD9O4LS3pi1mYFXwngqIk9wxoGo83+3hqlGg0bJyxkvxbIxUAMePBFNbIssdliBmtD3kOySaLXdrkEts/uOuYVsTpMMOYcwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930092; c=relaxed/simple;
	bh=8+9JzPKawM+0B5Tv6ZwMpJht+Kw+/NpL2UcM454s60s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l8W4m8P4Ki1+3YdUX6+OM2Qg4dQlc0xmpQcxf4HV8TAU8008jcBBTPHqA9XItO6W6ele0bMcG4ZbS2hg4DQjEbzlGlFbCi8b1UsqJPmTi4zNnJUY+F/2eFcf9wEFty4tlTx9Myb59/TiPTqN0zFUvqzN94B8hR3hfIwhKVSmFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NN5VCDEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NN5VCDEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906111F00A3A;
	Wed,  5 Aug 2026 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930091;
	bh=MazO/uAQyD/gsUzjVqckU8SU7UWpSwiX3nrdNUuEre8=;
	h=Subject:To:Cc:From:Date;
	b=NN5VCDEl1bP7XvP5mewouQwFmPkI2kBQ8bjbGUKUKjQL7BeVtgSHTLb9zGAJz9zS3
	 1rM57WS0RIScShKpIckL/64XaiO5ebT5ylhUuKyEbepbyUJyoAsiUItx2wLQ5ZTr+C
	 3O7eOxgecOK7RhkvmECSYk+zQFmHLIEbGvWkA7U4=
Subject: FAILED: patch "[PATCH] s390/zcrypt: Close speculative mem read possibility" failed to apply to 6.1-stable tree
To: freude@linux.ibm.com,borntraeger@linux.ibm.com,fcallies@linux.ibm.com,gor@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:41:06 +0200
Message-ID: <2026080506-bullion-gradation-bd27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e935cd525af4c6ed2e2c6404aa27ca19c7f39ddb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080506-bullion-gradation-bd27@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

