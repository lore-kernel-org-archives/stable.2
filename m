Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532412;
	b=US1aCAR3GbfWBZaida6o2aLaT8lCAWaFJd/Lx4D2j43ECSra2zDr+eeUJKVzXmf6mYap
	 QP3BtszNQ2Wg8RQE6ka/PErufbTkcVWKPRvSoQmgAEGbliqTUbEHb4Srk1qPg5Dcl6h+S
	 /GuQYXzncreZXyUGayiIrBGtowG1tD1WDRgZV9+GzgaI8rA/e91RrtmUv8BomyRPCaVz4
	 W5QfEFYD4qmoUOiZxX3qXkG1GN6N2xG2230U6oynEfN+OB8dVPGC30A+Wtl5oVUmDezvF
	 CGSZpzbIoosPAscAGh+1+yKqqbDDMjf3tbgeUwh0OHKLVsr9bBVE3SU46KDjUhwdcDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532412;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JIFB1PQV5c9AfkMvm09rQEkFcKqgDEhblNZJR42E2+Y=;
	b=ZWPj35P7HnHDNcVZ0Y4SK3pGWG1T41w+dk7+6NLnsEsR7vRjsKlsM/ww01tPtdmcQUAM
	 p11F8sesuYsA42/jGbbaBKUVjyJEwoxseh5FD50irwKhbElhrC1bhG8CKYNYX/5/MAq22
	 1+GaFxGmL9RKqpqMtmbnwyWlZ08XKhZJbMoaMDVjn5LlN1TfbiXx88fECRumpi7X3UeBQ
	 RfxaBls6q4iykHO9fvBQWi5zsbOF+9WDDVjxeIjAs3Wr6hw/QRb75Q+p08Uj5BUqfKyRc
	 5Mm8KMw/Q1MlmZScAFBNR/YxQgpA9monWIm4x3ufqyQAq9KbI8OY/6Ah1qZ0/7+9zZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1lFWg+Vi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564F606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1lFWg+Vi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0BF1F000C0;
	Tue, 24 Nov 2026 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795532411;
	bh=JIFB1PQV5c9AfkMvm09rQEkFcKqgDEhblNZJR42E2+Y=;
	h=Subject:To:Cc:From:Date;
	b=1lFWg+VidlhwhlDuxtKY/yxLYRuDvPKAUAvmneKslxThIP129Uax3gtXqvLA37yvR
	 icj+L3Fl1/ioJFEeAmVk56IxbynC6ZXcGBoULrN36H/vpZl3bKCxeyoT+DsjtaYp3m
	 UIDN5nLc48DpP78R78qM+kaNGBR7OSc9ltOqzw1Y=
Subject: FAILED: patch "[PATCH] KEYS: Expand key->{datalen,quotalen} to unsigned int" failed to apply to 5.15-stable tree
To: jarkko@kernel.org,dhowells@redhat.com,ebiggers@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:00:12 +0100
Message-ID: <2026112412-cymbal-makeshift-835c@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4a65eaf146f0d10ebaa88cfaef9c3b24f93766d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112412-cymbal-makeshift-835c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a65eaf146f0d10ebaa88cfaef9c3b24f93766d9 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Tue, 20 Oct 2026 20:43:19 +0300
Subject: [PATCH] KEYS: Expand key->{datalen,quotalen} to unsigned int

In key_alloc() and key_payload_reserve(), key->quotalen and key->datalen
can receive values larger than USHRT_MAX.

Example:

  keyctl new_session >/dev/null
  owner=$(keyctl newring owner @s)
  keeper=$(keyctl newring keeper @s)

  for ((i=0; i<16384; i++)); do
      key=$(keyctl add user "k$i" x "$keeper")
      keyctl link "$key" "$owner"
  done

  awk -v uid="$(id -u):" '$1 == uid {print $NF}' /proc/key-users
  keyctl clear "$owner"
  awk -v uid="$(id -u):" '$1 == uid {print $NF}' /proc/key-users

Because key->datalen wraps around 65535, the quota refunded upon clearing
is truncated, causing quota bytes to leak in /proc/key-users.

Change the types of key->datalen and key->quotalen from unsigned short to
unsigned int so that they can carry the full payload length without
truncation.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/r/20261020174325.2229448-2-jarkko@kernel.org
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index f9f61c758a75..346899da91eb 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -385,7 +385,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 		goto out_revert_creds;
 	} else if (sidkey->datalen < CIFS_SID_BASE_SIZE) {
 		rc = smb_EIO1(smb_eio_trace_malformed_sid_key, sidkey->datalen);
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
 			 __func__, sidkey->datalen);
 		goto invalidate_key;
 	}
@@ -403,7 +403,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 	if (ksid_size > sidkey->datalen) {
 		rc = smb_EIO2(smb_eio_trace_malformed_ksid_key,
 			      ksid_size, sidkey->datalen);
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu, ksid_size=%u)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u, ksid_size=%u)\n",
 			 __func__, sidkey->datalen, ksid_size);
 		goto invalidate_key;
 	}
@@ -498,7 +498,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 	 */
 	BUILD_BUG_ON(sizeof(uid_t) != sizeof(gid_t));
 	if (sidkey->datalen != sizeof(uid_t)) {
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
 			 __func__, sidkey->datalen);
 		key_invalidate(sidkey);
 		goto out_key_put;
diff --git a/include/linux/key.h b/include/linux/key.h
index 115db6e60254..5a6b335c1efa 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -216,8 +216,8 @@ struct key {
 	kuid_t			uid;
 	kgid_t			gid;
 	key_perm_t		perm;		/* access permissions */
-	unsigned short		quotalen;	/* length added to quota */
-	unsigned short		datalen;	/* payload data length
+	unsigned int		quotalen;	/* length added to quota */
+	unsigned int		datalen;	/* payload data length
 						 * - may not match RCU dereferenced payload
 						 * - payload should contain own length
 						 */

