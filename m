Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538265;
	b=Nvh4so9DHEp90PfY4rvH+0c12WjSAS8mmrNSwtXZP7kP2Ux0rh5+dAvyt7RA0UEaFvMR
	 7UW2fbiv4RUR4nMYiERFC3+bih4RdlIO6hE39gvMtOAZvjfru7iwjDAMJBDff9gag9Qkt
	 gGamnAoxnefLGOOcz3c5fFKWjEutRITqtiqLXViyp+bUP611xCoBlYSDUWnm8Mr7kuf1I
	 Cvkruitacr/yYzizuvuNIIknuzNEZil2HlB26tw/8w2EytfM1hlceUeq85HBdxqrAcmY2
	 FEY8lx80v0Z4h0OybMwhQy4Gu0Wkt1qSCjvmvBJyq0dFbA9upxB4AOYIjppUxVIKTdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+ff7BInrBH6z6xaJ3MprcZltj75NB8Zj15t1YfVZgdI=;
	b=iGpDxt4HlsRdwxSftlkIASHpk1CTxtFAgHf7jh+mIHwJFza9ohZrG7E7NGm4KVH5q71M
	 UNLCmWrqI77doWvIp82wo+12gdowpG9CeeV1uVZClVbaBqWQ4XF+rSQBvT00p8okPL5ga
	 00nuSF6ryPLD3KgVlGJvInoZdZ7Z6QxqVMygHF26D7MexCX0tGR+uDMntg2dTibqgcN28
	 pVldSFW0OdQSE8oe64X9zCZ01PdiRcDBKTETs1yFEio7qZJpRgSh3ff3J4F+6JwJGqzjH
	 U4AIOgoN/+pR8ayGkd3wywTUjrj4nH2HmXopLGqzxpgiMpGwQB1jMHYh4tlNdJkAb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IDNzSbkp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17E606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IDNzSbkp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4032E1F000C0;
	Tue, 24 Nov 2026 16:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795538264;
	bh=+ff7BInrBH6z6xaJ3MprcZltj75NB8Zj15t1YfVZgdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDNzSbkpWJKPvBJKhwJyHnokbvJrmR/foPUmSMy8y229htqW7Cj0xo5VJETkFn7Hk
	 ZZFY6Vf0Yf011NWB8VRdzyM5KLn/NrccFA+IRhf/hkCCqiBX6BZYUf4ZYkr8BKKC+j
	 TIWqytp5vqXn0QjOai9r+sFEX4WswNI7uCxiOg6Ojynri8ilOVhha1nNF+cu5CoG5y
	 CDP9Gtre4iYjaUeDq69qJgCZvmszmrCSw8oijQSgRzNLzY5trMUIYg2CWMKUqWG7gy
	 jo/eGwgXdNL5+TbxNVRlQ4B7NXKoqAFfHGFObdDBT1Fnm+cpBDhqWs+BZabgx2EaYD
	 yEmGC9aJh3Myg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KEYS: Expand key->{datalen,quotalen} to unsigned int
Date: Tue, 24 Nov 2026 11:37:43 -0500
Message-ID: <20261124163726.1348363-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112411-grill-gurgle-4850@gregkh>
References: <2026112411-grill-gurgle-4850@gregkh>
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
[ sashal: Replaced the smb_EIO1()/smb_EIO2() error-trace helper calls with a plain rc = -EIO since those helpers don't exist in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.c | 6 +++---
 include/linux/key.h     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c3165e4893789..c91a80c55f8de 100644
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
index 1d0732dd5c539..09677683abea7 100644
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

