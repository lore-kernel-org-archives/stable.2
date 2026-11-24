Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537271;
	b=tvUxM8Glc/5KC50REMANhvgCCXyefyBLM7NPi0ujyZcfVU0WobKAEcfj53Aa2LHeZpCo
	 gJmwMkVzGrAw1wCGuw9TIPodOWyK9oBYx42ytSMo3U2/dx7bECrMF38ySJaQ+ERmaHWoi
	 kV/NKLblCW5Wmjju7JEbRWN2CIAjjjvK6U4b75plBiNfgF7N13HSAOaoy3qjf80VDXw6P
	 TVBfBD8stL7k3NbFhSV3s+KGqeO58pbepsnYT9RF8hTwZxnwfKYDXheUm0j/Zo1PnZDQh
	 BULoFqOcC/N7aNTnIlmzKtkZvL+oNkqwMgjlovrtNYT6MsZGPDjI5IjEDRb93mfnV1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Oie0KvEbG74bsGSSDfQlRVdUNkHoDzQ0ZMIFmkabVfg=;
	b=n43ERIjG6QxY6sOnfLvsf6GyqyOANDLde7uEO/ZI+Bhu1c4jg8B0pmVAjjkDYWLDTOwB
	 gO4LeuSZRPWlWacM0kbFoJompE7zv1E0KoUe83RbTNMhJ2NMmp7rYeEn7cilJ5i8yEq2+
	 I4tuVRRfpPlImf18j63QIwuGID5QV3Oee/txDgQBtNdq2djCRD99xuizvbHFKWlbApJNV
	 wl8wx/Fez737DvT1CSugylrwyk6A2VfD5y1CUlS88Ebmtv/NJs/zX64gaj4p68aPoMyBh
	 t6VSS4Q766mTrmPcOY//xfwCQLX73jpauNsKDT+/2W00GeeLGgP8kkWpGZROt89tgQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4CBcYwq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F5606A330
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4CBcYwq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EF71F000C4;
	Tue, 24 Nov 2026 16:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537270;
	bh=Oie0KvEbG74bsGSSDfQlRVdUNkHoDzQ0ZMIFmkabVfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4CBcYwqEEwFMmOe6/6e//soRO9ozrCQ1T5bZNIn/rCeE+MyGkWTGkTcL0HnL6UV+
	 M5qinDMcppr8IcqDq6GHGNLNNvN8h4FowIz0TiA6DjBs4wY3jya21PDEVfReIJaZ3L
	 BOSYKi6FMjc6bKCnxtsoR2uV/C/Eao8Gq99BUHQ9qydn95ideGPhCmw4RZgntvRqv1
	 A+1I7Y+Fbf3/PlswpP+SIWXLnnSOBh4EM0heTsh0bO9l74uSDCQdGhjf4EtlKoCQBG
	 nBifmqhuISU90sdNjVIubvFTFoUI0ugXVc0CFoLT/nkQcIqa7ys7YofbnNkXqwijBB
	 x7gQ8pFSGxFsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KEYS: Expand key->{datalen,quotalen} to unsigned int
Date: Tue, 24 Nov 2026 11:21:08 -0500
Message-ID: <20261124162051.905744-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112410-pulsate-scariness-57af@gregkh>
References: <2026112410-pulsate-scariness-57af@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

[ Upstream commit 4a65eaf146f0d10ebaa88cfaef9c3b24f93766d9 ]

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
[ sashal: Replaced the smb_EIO1/smb_EIO2 trace helper calls with plain rc = -EIO in the cifsacl.c hunks, since those helpers are missing here. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 6 +++---
 include/linux/key.h     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index f41db45fd7e7b..5fcb3b13ecb53 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -319,7 +319,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 		goto out_revert_creds;
 	} else if (sidkey->datalen < CIFS_SID_BASE_SIZE) {
 		rc = -EIO;
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
 			 __func__, sidkey->datalen);
 		goto invalidate_key;
 	}
@@ -336,7 +336,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 	ksid_size = CIFS_SID_BASE_SIZE + (ksid->num_subauth * sizeof(__le32));
 	if (ksid_size > sidkey->datalen) {
 		rc = -EIO;
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu, ksid_size=%u)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u, ksid_size=%u)\n",
 			 __func__, sidkey->datalen, ksid_size);
 		goto invalidate_key;
 	}
@@ -431,7 +431,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 	 */
 	BUILD_BUG_ON(sizeof(uid_t) != sizeof(gid_t));
 	if (sidkey->datalen != sizeof(uid_t)) {
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
 			 __func__, sidkey->datalen);
 		key_invalidate(sidkey);
 		goto out_key_put;
diff --git a/include/linux/key.h b/include/linux/key.h
index af9d22150e719..23fb011c7a9a8 100644
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
-- 
2.53.0

