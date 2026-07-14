Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF069444716
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040719; cv=none; b=dekvkwFygwb1XgnfHFaT9dcUbmr08u6h/MTrLBtEJwX2ySvbvF7W6l+c/6s3/heYij1ksnzT1lySpNZDDV2kmmQxDnjdtG89rONynN4+ltQGkH7E3+m0pCM9x56CRRcQZxzmBzILve5apwFHHHm/8mTDTSTE4TG++AYZaEUqR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040719; c=relaxed/simple;
	bh=FCussJIOjPuS8TP36T2QA1gTvIteYdqF5Mo4kN+gjdI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SEPc2ROVYji9n10ftOTyydm3iWIewZ4cpSkVRNgdu/21TbN+hfO+4jioMtsDr8/55lFOM8WCQ7fuNxFduoIMwXQPcOlplo89BuFCvSFlCc3PBnjPush5R6mkY+h56rAO/Ebxs1M9Rj3Q8GVGqxDutIXX/QvAJp0A+gPkTyyCBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jvfZJ79X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jvfZJ79X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAC51F000E9;
	Tue, 14 Jul 2026 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040717;
	bh=YHA3Z4ccMc5W5z55D/72SeqBhFtP16YfHG0h/MA3AdM=;
	h=Subject:To:Cc:From:Date;
	b=jvfZJ79XbQpfxyg551RknYRL5szklIZNCVxA0Z4TjgSXRc4G7/zdJiU3XKBfJx5IT
	 Opgrk7HqoZxXqvvxR2KkUnBrz8Uo/EvHqZkCZBqvbxk/utxSYNeGTviVrDBGI0Rta3
	 OpoxssOFlli2ia5uY2r2Fz3xtStFDNjllDQ9WpUs=
Subject: FAILED: patch "[PATCH] X.509: Fix validation of ASN.1 certificate header" failed to apply to 5.10-stable tree
To: lukas@wunner.de,alistair.francis@wdc.com,herbert@gondor.apana.org.au,ignat@linux.win,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:51:43 +0200
Message-ID: <2026071443-shed-dipper-bf70@gregkh>
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
git cherry-pick -x 3b626ba431c4501512ad07549310685e07fe4706
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071443-shed-dipper-bf70@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3b626ba431c4501512ad07549310685e07fe4706 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 14 May 2026 08:55:58 +0200
Subject: [PATCH] X.509: Fix validation of ASN.1 certificate header

x509_load_certificate_list() seeks to enforce that a certificate starts
with 0x30 0x82 (ASN.1 SEQUENCE tag followed by a length of more than 256
and less than 65535 bytes).

But it only enforces that *either* of those two byte values are present,
instead of checking for the *conjunction* of the two values.  Fix it.

Fixes: 631cc66eb9ea ("MODSIGN: Provide module signing public keys to the kernel")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260508033917.B5873C2BCB0@smtp.kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.7+
Reviewed-by: Ignat Korchagin <ignat@linux.win>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index a41741326998..0d516c77cc26 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -20,7 +20,7 @@ int x509_load_certificate_list(const u8 cert_list[],
 		 */
 		if (end - p < 4)
 			goto dodgy_cert;
-		if (p[0] != 0x30 &&
+		if (p[0] != 0x30 ||
 		    p[1] != 0x82)
 			goto dodgy_cert;
 		plen = (p[2] << 8) | p[3];

