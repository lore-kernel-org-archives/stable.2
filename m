Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605979;
	b=nmp9k7Qz1NpF53PBhsZOaEXKSqGN2HbNIJKF/67yh17h6UKJMDDYK9xNhwzW1yrtxzRn
	 MfnkkCcM4xun84OuOObsKvHbR5GnFYSW0IiL/elQ6+hixSXdYRHKrUmhdik0zn6q7GJus
	 Q5K5/vf+Zyab3dam08VqlnQmX663YVB0pdMC7OB9Zc4V2M5EGNPzxTLT8uKhxF2MzZGM0
	 SK3apQdUryvIFcdGVwU5+pmdDezDRU8ph+LIEsbDZN4eQTrtWZkR+lAdMtRFqjb93Kj1/
	 IWYyJxHGBPMXiA2TqNkicDzvHeROBvm/2Klputn99vKU+UTYPozbiSGTMCc0B2pF6fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605979;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=m5mzVAb/rwtpPFFBSSMTr1Df9IXPxTYSCGEuaJWH2Zs=;
	b=P+JD4wyjDs6g+3cQjc7FBC1aSA306XVHUiPuxilFN5pYuG32/4mny6FK19e2xbt8SQ5v
	 NaCMwPJH35OvezHokZC/E/gvW/XggYFVgGI1dId8u75W54hhXcO2C28zwgr9DKsKimLmP
	 HVQlHEA+wKt2/+8uur7nVyR7bWYuuP1OWO0/Yreq98KA0wOCk9u6NZEI2h8j3qZAf6yQC
	 nm2blbxhkJKMmqHWAdpWsPRJwVFY4FFF9Yad4eSpxLsaZtauApGqUZz8uKI1UXTbDKs1R
	 H3gXW1tUIL/VlCikj0aAisW92TwVqr2SpAmkbrikDzX9RpdjXRKE1ig7jGE55dZs4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IBIUltDX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92750606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IBIUltDX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5891F000C0;
	Wed, 25 Nov 2026 11:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795605979;
	bh=m5mzVAb/rwtpPFFBSSMTr1Df9IXPxTYSCGEuaJWH2Zs=;
	h=Subject:To:Cc:From:Date;
	b=IBIUltDX1OFWPGCrkXpynfzmtaedAXzO5UtNYqJDdXMcYEOYzOhSRY0ZguAzxLkJJ
	 Twr8minzkoACboAn9kVUB8mtPUrczZjO3VrpECacrYfLV8U38wnAQI6F2QLCo0Ypuh
	 BJe75ZP7LF5t0Zy07w1Tx7oVrRnajCQ+JUd7pen8=
Subject: FAILED: patch "[PATCH] smb: client: compare owner and group SIDs using their encoded" failed to apply to 6.1-stable tree
To: pkfxxxing@gmail.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:10:21 +0100
Message-ID: <2026112521-annex-reformist-fa2d@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a2dabe73ea05ad3b3f8e1cc08fb2e7c2ddc5564b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112521-annex-reformist-fa2d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2dabe73ea05ad3b3f8e1cc08fb2e7c2ddc5564b Mon Sep 17 00:00:00 2001
From: liuyong <pkfxxxing@gmail.com>
Date: Fri, 6 Nov 2026 18:48:36 +0800
Subject: [PATCH] smb: client: compare owner and group SIDs using their encoded
 lengths

populate_new_aces() compares owner and group SIDs over sizeof(struct
smb_sid), including storage for all 15 possible subauthorities. Received
SIDs contain only their encoded subauthorities. The comparison can read
past the security descriptor, as shown by the supplied KASAN report for
a 44-byte descriptor during chmod.

The input SIDs have already been checked by sid_from_sd(). Require equal
subauthority counts, then compare only the fixed SID header and the
encoded subauthorities with memcmp(). The count check ensures that both
validated SIDs contain the number of bytes being compared.

These issues were discovered and fixed by Qihoo 360's Tulongfeng
multi-agent system.

Fixes: 0f22053e811c ("cifs: Fix unix perm bits to cifsacl conversion for "other" bits.")
Cc: stable@vger.kernel.org
Signed-off-by: liuyong <pkfxxxing@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index f9f61c758a75..e420943bd3d4 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1134,7 +1134,10 @@ static void populate_new_aces(char *nacl_base,
 	 * updated in the inode.
 	 */
 
-	if (!memcmp(pownersid, pgrpsid, sizeof(struct smb_sid))) {
+	if (pownersid->num_subauth == pgrpsid->num_subauth &&
+	    !memcmp(pownersid, pgrpsid,
+		    CIFS_SID_BASE_SIZE +
+		    pownersid->num_subauth * sizeof(__le32))) {
 		/*
 		 * Case when owner and group SIDs are the same.
 		 * Set the more restrictive of the two modes.

