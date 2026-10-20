Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460356;
	b=wZVNDTNmIJfXdC3xcZ+uk5xcy3hYYicGC9rWzOtXVDm4w82n8nm8vQfgqtWQXHJ7NMla
	 +ar+To+UBkb3v+0F4uG1lgIasOsX4w1wl9Alpu/LnPgSTi8PNv9YJziljzqhzYqvszCxc
	 HyImfTOwuQRG16k4OPWQ3ynx7bNLKmzPiVzEhsGIlG3Dc7vAo5zsjX+q5sD2RB5M2PiSz
	 YNIYiuyVIAnGsoKsHQCioGu8h0SFGTdBlHBX06AcmX4YI7AI/UVFclKKDcFACG3nJNZUn
	 cTraQHARkxS3rETbXNmNE2Ou6MY3bFmxmcm9HtUwqG0DbVVnMCTchnlkBImSyxTs1QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460356;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TpOcDanqp3rIn9abLro9OQpPg1gNWZfVCMhkHN8HKsM=;
	b=Rf54OucFNxF+evHuxK4RHikVpmDb3ftk/o3QZ+aBOrRS6G+PQ8vt5SMr4HzT5ZTYnOym
	 +hapEa2wiiGXjVQ9spbWR1/o31WRNxvFeReqgpANHx0lApRPHFDil+Woci6kcY0wueaKt
	 CYDpu4HeNC5SLwFsZ6Vdva8mp/Im0/rhmGfiHt6rNPsJ6nlxRcd+NW71MUtv5Zb9r4IwQ
	 XGTUa5jNCCmwBF+ADP7mNRNdr1TyScBg7cIJknypkfE8awt4pnjVowesIoMjvuJ2J5Nv8
	 g7Ya76m1PLy0YdCAOZT9BiZI+uYLRduhtDzN7P9cVHbRzQ647jt2bfSkNzMuXpU9TNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeahyHQ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DD3FB606A31E;
	Tue, 20 Oct 2026 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeahyHQ9
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 09ABE1F000C4;
	Tue, 20 Oct 2026 01:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460355;
	bh=TpOcDanqp3rIn9abLro9OQpPg1gNWZfVCMhkHN8HKsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WeahyHQ9D2VUPXyIBe8tQx02cHkH7XcOueNccZW8Yx4WMZ5zoxpZj7l/q/u3UVVyq
	 i1HPE9jGGQT0D6UKTPLpU0qGKwDiEofo3tW0uqHsl2HXAVFBgC7U/9lDiaTmW+7uUJ
	 I6WugYHcO84booCy+G1mkeGmDmF5dA4S4v8BaC4oI8dyXvIMS104URqxIcAQMUhHl4
	 H1z4xlqkGsXbpzzlr5+3PizcS+PUaEZU7mFCFNIOgFRasN0e4rqRkKsTS/j3qfhgoS
	 2BEpumoiwJ10oYYLm9uhWYJoHRPFvyehamMQ/Oi3ZOEswUOZMPkq6qFzcfvQMlVXEN
	 /7mHzSQQgS1XQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v3 1/3] KEYS: Expand key->{datalen,quotalen} to unsigned int
Date: Tue, 20 Oct 2026 04:38:55 +0300
Message-ID: <20261020013903.1244157-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020013903.1244157-1-jarkko@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
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
Assisted-by: LLM
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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

