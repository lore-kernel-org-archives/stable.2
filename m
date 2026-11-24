Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536454;
	b=HKfUGzbt9zKPU3eqlvmK00khVTaqy/vgWX3fV6SzQdOuf/jNcLsZiKBape4Ov11fqXJ3
	 ovW1BcMR+pZ/Danr+glIB93IJkghEj7xUwtzJxqFhWwxLpcteaMEFI077yFEseCVIhJI9
	 5W9YGGm2HVq3PC1mzbOMzpdZp0EKWZUYaYg+5nN/Rn1yZ3lbTRfoYjBt1xYF++6kWOedE
	 rNl1A1i7Rdlm48pS+uMbT3OSYd7jSAjG/BPOz/EUzvWAgdE2IKj+TzhUmqXeWRsIgi6EY
	 fiG8qVAy8gC7NtXHawoTI/zDpEBFBXrlyT8Mu+7TX3xuirj+bqM0AdXCO3htev+HRHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+9/g5SZto9ipxEcVx0EqRbaeWtugkagxRV4TVah/SNM=;
	b=eNG3rD+pz4jyY/IgROTtts0UthNs3OgZvHiMQweb1xLsTRVxk99SqnwQsTUvWC8arjct
	 w/B3yyjp+mJVLyWURy7dtxy2gnUdZyXH70nWWAfj115Eo0UYduB+nHfEgt1DGPHdqXksd
	 8b5h8stjiXWLRLHy7fPSMtPshgwbjfZmAVzf4CSAHFVHNoJj6tT6TwNwCVYEMBMpdWY3W
	 usX4bVry3+IsEXWpXUCsoBIbVCodYHs5IL2N8E0Thnhbp+2MdQUJoeu3kiCs+C34Kw5wP
	 +uQ1aOVJC/k1tcMa+/JkLZEsl/sIqWf9N/tUKFq+SD2YIr8y2nZM+bwytJcA6vR082w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxhejyqB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 42DDD606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IxhejyqB
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8D0081F000C4;
	Tue, 24 Nov 2026 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536454;
	bh=+9/g5SZto9ipxEcVx0EqRbaeWtugkagxRV4TVah/SNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxhejyqBoh0QbbkiiazfWmgujfwPFFnjsfIS3u6tB8Evfb0bV0XN9CHghcPGoLfZ/
	 U7eE0u0ZTC7Oktt9lEmQ82IpN04uoQFjyAK1+fFWR9zxmdZ+FllI9JIi1ppFRdsk2U
	 bXq+UwQQfe+5rrqeFqaRR0JSGfLaeTU/WACzUwxtryXrZluhNv+VsYGQSei7Y3RNEn
	 wrlPOA3ZlXnBsslNINjjAPanbW9HuSQJ5/OH/SomO+IFzROBjpnx5iOWNE24qBJVRk
	 /ZrDRFZOxhFXecI1oSKo8m6KYrDKuPqMywJmTMTHqmLKoVHJ/86H6PwO9o1qp2mtMe
	 wGQuvwqUHys3g==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18.y] KEYS: Expand key->{datalen,quotalen} to unsigned int
Date: Tue, 24 Nov 2026 18:07:17 +0200
Message-ID: <20261124160717.1574876-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026112410-magenta-immerse-769f@gregkh>
References: <2026112410-magenta-immerse-769f@gregkh>
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
---
 fs/smb/client/cifsacl.c | 6 +++---
 include/linux/key.h     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index bb4a258b2c17..fae9ea3b02d8 100644
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
@@ -430,7 +430,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 	 */
 	BUILD_BUG_ON(sizeof(uid_t) != sizeof(gid_t));
 	if (sidkey->datalen != sizeof(uid_t)) {
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
 			 __func__, sidkey->datalen);
 		key_invalidate(sidkey);
 		goto out_key_put;
diff --git a/include/linux/key.h b/include/linux/key.h
index e40b5267658f..26139c3adf62 100644
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
2.47.3

