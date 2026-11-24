Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536214;
	b=r74+vt+uroage1m+P1OKPK+mAT/dNbTfWaf4wUA8wDQjmE8/noclKlvMwT4fljuaIpcZ
	 76h3W0+nykEY6SCOQkr0N78xQQpB+iPPW98OOs13PEQka4RwjDFsLFDJSI3FdM/JJGUua
	 D3Ld2v9zDBWTseKUAOKN7WL/XH0hwv0MNJNEWgrKqOVVoPdwxAshm8mpN3gWUUSPwBM7N
	 oUQhnGPnm9He3zaNphW8JUN/n2bjqYaeutxA/UQ992Zxsry/DPaNSoi8lxyxkszk9SXea
	 fciNv3ZOwFxUurBsb+uKqxN+IMCVezP/hJhcBp8c5EP5eD/KQ+UOP5emk5anUt685qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9lE5CNsbjLURqDJn4Mf8mwThtmjmftLz/nA9kmmDitQ=;
	b=JYwHtHwQZ26kUE9ZMZaZiIh2q9SDjVrzoyAZ/PIpkvdESBsTz4NzLFHYIfldgvJN+Tes
	 T98rWAGNtrriFJtA+HmMsKjsq95ZabTz8CAKUem352lA888nw36xU7tXP76CmZoQeCaJA
	 6EM9/AwRo0tEE+H2M5pl1oIOGIwXeaKt+c6uIXIp4L9InaRZXr4e0KIR2P+YDySrT3kih
	 3NOFQgE+caFYbOwo24IvJffDxM2Yi653Y/1CiUb6/xsLcUwhdD3aNVDfXm8hSL+U9PuYH
	 /InsMsgf2kpHMYvjBCROU19w8JhaIIWqYABvsQdSRivUZWa3/GO7Lo0bIjA/LpLtK2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQ1j2fiv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6617606A331
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQ1j2fiv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108441F000C0;
	Tue, 24 Nov 2026 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536214;
	bh=9lE5CNsbjLURqDJn4Mf8mwThtmjmftLz/nA9kmmDitQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQ1j2fivBLLEXRwMTVFvh0vmQRvNOreCdVYIcKhk9IfxZXfHvqbCR91nAuTxnUKPl
	 sXPFm3E+okbvAizZ/jYykTNjA9h9pS3sqaZ0W08KM8Tshryp4x+zvn2S9i5c5/Wr9P
	 QUDPKx6cvnvUBzr/L3LFkLLXrGlEOW5Bgmd+D861AP5kZDpNp+5FSiz721Tb/fOm1j
	 DfWPKyWWaVvzuBOhPuQt1N/O1BlEI4AXCGzXoIU7v8qOxKhhKFSp/Wi64ZY65/A+X7
	 z2M2eHPQhMBcU3Ae+Ceyvxc9XS9TkQA6SWJYHV/+dswAP2wr6MelgXLVRtWLuOStEz
	 xYXJVn14Z1Qyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KEYS: Expand key->{datalen,quotalen} to unsigned int
Date: Tue, 24 Nov 2026 11:03:32 -0500
Message-ID: <20261124160309.4193923-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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
[ sashal: Dropped the context lines using the smb_EIO1/smb_EIO2 helpers, which don't exist here, keeping plain -EIO, and applied only the %hu to %u change in the cifs_dbg strings. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 6 +++---
 include/linux/key.h     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index bb4a258b2c17d..fae9ea3b02d87 100644
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
index e40b5267658fb..26139c3adf62d 100644
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

