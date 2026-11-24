Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489090;
	b=495rCy5XLN0VYebktazjnF+QUaJMC+VRUDH8rubuYtJdTr6RReBaHDJLlfsy4LEVqKkt
	 pqSfDjfe8s42yyHDSqNYpiKcP+N9dowq25ly2dPoaAF3VygOa+2Sh/aDwny/cldysWio+
	 +XrjkkJBT7IdlPMzmWaJlApg/jPg5vRQdLLWBnECfSc9dxTk9n5OdvDJS9Qge83duPoEY
	 NWbd9m2fbVNwro9IRkpPwUMXsQZwK9IN/W6J0LW+oaXnhXILc9SuvA6RDU5MP3K3A6EdC
	 XrMQtKSP3eU3qEV3B1vM+Y89Qb/UjugC4EltIt1f/RIA+OoifH327ilIGZm5zQXIpUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
	b=Rp1w7lz6eVf/XKtXd1jhOaQ64OMVv33tR+zTNIAqeNOd+BVZ/VBItMWigG9mAuczQ7FC
	 H0rkr8zVtLqjCGbSk1635VHoG3jXNDZBBusae1YK+ILSv4b4SgCRVhfgCfHT8JCYjC7wO
	 CN145sATbiqtt7nZHpzYc8GQQUdD/erLOCSJRzX0WTnuUZ3nR3Cqnq5k/ht6vBfDxI8bd
	 xfGHCXMgxx3MORLM7mw1s6Hc/d9+YrHymjDFrv3MyVWZnr6vptqbp54qeIg/ZxXQX2IJ3
	 5l1P6i0lkRKakX0Tjvx+JaI85RH73F8+tKXJ3wMOjW0tYSrEHZlG/mtRUNi7BIYYazg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuqElge5;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9CE606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B9CE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuqElge5
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3b411059cd2so906842a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795489088; x=1796093888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
        b=MuqElge5ywtfzHq35FtslzC0hNsAzaejU1E3w15IRDL67GoXUJEVd1UciPryn+W6j/
         AS6vLAdUSzJuhweHqzFvtsDTmqWz+rzVXViNm3hCfMRw1/6/WFln7DYh6w7gH4ZxZ5kE
         WVIcz7/jncarv/uz8Rzv0MXitgIY7U3AxFhyTjJH3l7BqCjjWPJQJLUbinj+gXE9Ice6
         pcByujUfFzq6RbnXQEWF0mBvdCb+gP6sv1bmNamAYjH0KDL1UHqR77Ta7yItgmXCdJDv
         jlc6w9RpY7oMrBKaIkdRDNFnVJ65j+8D/qoJcGhNMxb78wY5MMmCcF27LcitpWWpMU94
         kd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795489088; x=1796093888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yur4tOxm2ygBh4jOsPulqFe9YZgZ9r4tQ95a2ZsCDLs=;
        b=w18kR5TVuO8i389A1SEmBXjnOivGTkLcW7LPKZUS/7o/mMR7ZiP6QvIt600yKzCTjS
         z1Sqnz8Zsyzc/hb6luGy5HaTWFhJHT2n5omlj6qff4h+/1gpZUZg5CnVYdQ8DS3l3nSm
         a3LYDeDeCd00g/UdSuZdzO/rN9JQZWGPFitDkqxHIRoEfoFEZVr3nmYg4u+VI01xTAup
         XHwiPMTKjdLnOHdS8RDvrlgdhlhZJRAPpFDROBHZukoj1gk6XF+8NPTx6RiGVU82vnl8
         +/qgQEJZX+8fNgWLEfBXm4USt+BXlGVpk+GvaiLr/GHGvd9hC75Qvdn8XobdFuMXwDsS
         YjTg==
X-Forwarded-Encrypted: i=1; AL+hErFo7R46Y3aCKDKPhYmKgdFdbWPxzSyUeQfxLH6SV6mIhszFbU86eztsI33Ld3HHHYngVZer67s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NaVwITzIe3E/yhB16esHpFdhzOivhzySGxofJwLG8hWchg4RV
	QO23KDTnCQ+oOrGP/7V0hVZHhjwQD3j/N8lq4Cfje1b5eoHutBpxGh7uXqnCKM6nX558Pg==
X-Gm-Gg: AZFdTZdEknHTj63XKfIcLmQdY3cDjEbne32X8mAvt6wLtAQ9R7IL1t7ouYvc9AfJkyD
	Dqa15VMfnbG+goqa/ovuA37kbaCIoXbXlPjzJVmQo9dyXR5Jf/GmBbRNsZtdFgjIRK6CKBjsrUo
	WSmKYeKKDMuOjZDA4N1/QN6Al9bgzJjNeF1MQpYvLDyBWHgHXD965sLOm6rCCxYMeTk+FgnCAC2
	ZDqqbCn7BiPn8vVKGNUiiun0eKghIkuwr+INC8Fu8s2BiCTd5h3TSsLzxcX3Vrws5mMj0j9VgoA
	m+rfSmO1m1MRCxIlOmBR3ApjIgd4xCnUZ/jATR8rH6NzLnVpUDgqGn5NWX1XSzaiU05rLn9GsQ8
	wXpSyIrjqgCsw6s2sTT/sk8XwimUgZgnidBr1ls48ia9+tcmDcUnamugSg2n40sCe6HFFx51Z4b
	J6cOURUX9Fn+IQ4DUqBZJve43xf7cZd+fgRpg9nVoWSnJTtia0NtKvFr6eJBauNfqP8cZM0Xed4
	pjFdYV7v9FR+4NQqUdJx22UxlOo4BfD0sw2lPItHVFxFDaC8MzIZK+tk2T/Ng0f5/pYRyi2jmBd
	m6a+WHZdUWCoxsq6P/7BZZEdJ6/qBvnRnWyewPunDD1GsUHSH+OsnAb6dlpLjwplZpIhqU/bgQ=
	=
X-Received: by 2002:a17:90b:2792:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b41cb0c476mr10628516a91.49.1795489088382;
        Mon, 23 Nov 2026 18:58:08 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm25195844a91.8.2026.11.23.18.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:58:07 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] keys: fix crash on big_key read or revoke after a failed update
Date: Tue, 24 Nov 2026 10:57:59 +0800
Message-ID: <20261124025759.39344-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

big_key_update() reserves quota with the raw payload length and then
destroys the old payload before instantiating the new one.  For a payload
of N < 16 bytes that reserve releases 16-N bytes, so the reserve of 16
done by generic_key_instantiate() charges them again and can fail with
-EDQUOT once the payload is already destroyed.  big_key_destroy() keeps
payload->length but clears path and data, so the key stays positive with
a stale length that KEYCTL_READ and KEYCTL_REVOKE then follow:

kernel BUG at fs/open.c:1145!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
RIP: 0010:dentry_open+0x7b/0x90
 big_key_read+0x141/0x280

Instantiate the new payload first and destroy the old one only on success;
a positive key's reservation is already 16 bytes, so it cannot fail.

This issue was discovered by Tencent CodeBuddy Security.
Cc: stable@vger.kernel.org
Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
Changes in v2:
- Drop the comment in big_key_update(); it belongs in the changelog.
- Rework the changelog per the review below: the quota is released by the
  removed key_payload_reserve() call, not by big_key_destroy(), which only
  drops path and data.

Link: https://sashiko.dev/#/patchset/20261123165443.4092852-1-bsdhenrymartin@gmail.com?part=1

 security/keys/big_key.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..aa3e82ac93ee2 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -193,16 +193,24 @@ void big_key_destroy(struct key *key)
  */
 int big_key_update(struct key *key, struct key_preparsed_payload *prep)
 {
+	struct big_key_payload old = { };
+	bool positive = key_is_positive(key);
 	int ret;
 
-	ret = key_payload_reserve(key, prep->datalen);
+	if (positive)
+		old = *to_big_key_payload(key->payload);
+
+	ret = generic_key_instantiate(key, prep);
 	if (ret < 0)
 		return ret;
 
-	if (key_is_positive(key))
-		big_key_destroy(key);
+	if (positive) {
+		if (old.length > BIG_KEY_FILE_THRESHOLD)
+			path_put(&old.path);
+		kfree_sensitive(old.data);
+	}
 
-	return generic_key_instantiate(key, prep);
+	return 0;
 }
 
 /*
-- 
2.53.0

