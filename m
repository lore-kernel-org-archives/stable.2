Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829D48BD2E
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040712; cv=none; b=h6j/BH1ucj7UcjbQEHmmRyDhXHs62NBH5Bkz7SUpeZ19W6PN7L59SXakb7+2CEuN+NLDKjNAi+gUQPPeJo6GPZin0r3UymDj0Blvu8rmFCbWcCmDywRCJxMr8asZZaI1ewujQgdLdfDGTuK2X/tuQ3mPkZhrr0EUjj+YgJUFJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040712; c=relaxed/simple;
	bh=gGJjX9Q6RZMmFO+PNexc30sqH7SZknN+Q0lXOWwT6/k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C0reXD7ABA7zMNvl9Z/PwbGinlR2+6HIA6qSEql2hiehBZweGf1sphRNOceHWXk6Ch+kXasiK+nvzvnfVgv/JqoU8DpHY5a32s9MhOLtE1KWEIfP3SrrWh+aHyzYXkyXUO+H9l0HQuqOFSLIz8vShM7wsgNm/Azc3jx4RJJibYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cHvleUZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cHvleUZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25CA1F000E9;
	Tue, 14 Jul 2026 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040709;
	bh=OSBB0wT8SYCJGTKYtwrMJq4Bu9jQFJWVLF5qYMcgXvQ=;
	h=Subject:To:Cc:From:Date;
	b=cHvleUZku9rgAOLlnelZmp2FUcMAZnWF4IqGbrNga2dw1F0cOYCRVmReb3LrwYL90
	 71ATArNTNajPKUBjwkZm1KPnJsaUgWOiwNMnv1vSkyiQ0MoHkMfUR4jZvfwxlkpbEE
	 AdwlLPSSvZ1NHsI22Bov2yYhnjTNJZTj9UnGJ0IM=
Subject: FAILED: patch "[PATCH] X.509: Fix validation of ASN.1 certificate header" failed to apply to 5.15-stable tree
To: lukas@wunner.de,alistair.francis@wdc.com,herbert@gondor.apana.org.au,ignat@linux.win,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:51:43 +0200
Message-ID: <2026071443-crouton-afterlife-63a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3b626ba431c4501512ad07549310685e07fe4706
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071443-crouton-afterlife-63a4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

