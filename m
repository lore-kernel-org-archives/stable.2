Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B723A564
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123224; cv=none; b=ZccdDYn+J12ZerHgt9+jzvv/H5S9CGoiCfCAbMZRxAB1RmSmdEMrQT9jstJ1hbHafQDAvDx25Re40a049QPW5yEybBTrYzEWLTjujxE1dHjalOQ667/qSnLwK2ugJwME5vSTNM1gr6uabKIrSfa2ouRt9BnfrowKmzUlgoY5e7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123224; c=relaxed/simple;
	bh=R1f53fZVOQpXpGpCi4RklZRTZOgEf4RFVZqHIV1IEjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpfomnheejzuSmEG13KY8IzDzThsBTcrmDbqre24jD0tUAJVWDBmm1FH5CG0zbEtrLo8/YH0+13lnuYVa5cMAx+IUWjSgZF/G3TWIsNZIPUssGHH7u2U32tJ9XXWuahPIOosalRJYYgGe4TVdeWf8B52vgPZiXpiEgt4FJLsLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZIn4Nb8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZIn4Nb8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so422235a91.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 21:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123222; x=1792728022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g9IQw/iWHXUIP0xYQGBwa0OfUNbaaj14Fj4E0JqM4sE=;
        b=LZIn4Nb86Im+eJt/C2Z8tvysgraS2xt11OqHgABFEDtbc4L9UzgX+rkAmvCaf3qWpZ
         YrRQ/G9DWEHcA3jaEQVGVLgo1w6xS4ttOxTDJiarb9APKyqPBovADl9C/WFYx5gjuNIp
         NYxK934bVsZnzU4025+/660RdteqDSkEOjjCLYBYpp75chpAug5MlTcNHiCFHauNf5ee
         xnPfvK2P7k2P9q/jSGzTildbi5YZA/ZMctd1x+Sw+aJdu1TmqCj/gJ7+qoxkkdY/d6XH
         x6jcETDeUjBSd72vBER9PuBgP61DzxNIUd1eDYK4dOCXVpCQ5fk4AbXVPxL3+XP5BECO
         5llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123222; x=1792728022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9IQw/iWHXUIP0xYQGBwa0OfUNbaaj14Fj4E0JqM4sE=;
        b=PmcWhYt1LCIUAyrOKLecMcZpyI+OaOJU2hd93JnRGE2sjbL1UAvnwEzMpcqG1cpgcI
         Z6VshJy4I71BMbJs1oxLPpUK6iqFSxaLqjABxPjfIqbLgXY87r3pgpaIs1Lxy5F4deDu
         KhfizYa9OFLlzPQeYKOqo1x3ThrXdjVOhSXVyOLHP68Tr1lSvdrctbftBYqa+9/R2gZP
         trVEl/ylO6VMmqSt1yiKZ4vfvhClD6B9E3rFRVTEdhQ8mGrl9ENL88pP1ten9hD4zab7
         30t7VPcgvY8pqYYsv099tY3j4N9xgiHF0ZjG115dbJWLOtQLZ/sBq+3hUcj7+kZiBkxD
         p81Q==
X-Forwarded-Encrypted: i=1; AKwUvBx6DlA653qV6KHoixmsvmEYOWmDEVHuKZSa7ANEVivPznuHzW5z16oc0UBHc+t8Btx75qznJV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzobi9QdQpIpaJqixHJr+yLOKJK6kKvJ6PGef97DkWHMg3Mufj
	4eVkToul4n2/Uj7bax6r4DW+mPuDoP75co2IrgA44FuxQw7LzRkzQGF2
X-Gm-Gg: AYBFou222f+eyj2j/3Jp0VFlrC++oWsuynhniQMrGh4JQh3++bsJx0kNNzJ7qKzzFE7
	AyHS7P2NPgl0QDmfoz3+pyKUHJQ7BJrGIvhOTeAnCTcEfL+R1+SxZBGHyvNjkNHYw9FN7T4PV4i
	r/77fgXLWR6tIivP4lMcxUcdQTRnL4wiiNH6YmgbOadHdUvl3SaPog87rMPC8qq4Rv7Kmq4CEp1
	jFMDQXYOhkoowaGGoW1yUTgyhj01ke2bz6JlFl1MmP+fzhaCwGzxVoE1jrNrR0NLTm0p60AeeVO
	yuPDwWxuD5u/CX2PNK5CaJLjyC63VE8Vs9FkxjDbLT9aPd/k+mJmthqGu5IXyF1B9ISmBw2/41h
	gHOsblQW09nbph3xQ9zu9gqobmsQlr+WfYWVfFo6VaXroOCPZXra0HMAggJoywV6+U9HeXOyKh9
	9MPxszG9FhrT5e1OyL5nQR2XOsaFYzSeoEe0+0+/7fOw30qbH+xbZAg0wep+hQ0R2ozofbU9UrN
	qqTTwM895Y=
X-Received: by 2002:a17:90b:3e89:b0:3aa:412f:b0a7 with SMTP id 98e67ed59e1d1-3acbb689d36mr1258321a91.5.1792123221974;
        Thu, 15 Oct 2026 21:00:21 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm7017040a91.8.2026.10.15.21.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:00:20 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] keys: big_key: Reserve the final quota before destroying the payload
Date: Fri, 16 Oct 2026 13:00:04 +0900
Message-ID: <20261016040004.324286-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A big_key is charged a fixed 16 bytes of key quota, regardless of the
actual payload size.  big_key_update() currently reserves the actual new
payload length before destroying the old payload, while the subsequent
generic_key_instantiate() reserves the fixed quota length.

For an update to a payload shorter than 16 bytes, the first reservation
temporarily returns quota.  Another key operation by the same user can
consume that quota before generic_key_instantiate() tries to reserve it
again.  If that second reservation fails, the key remains instantiated but
its old big_key payload has already been destroyed.  Reading a
buffer-backed key or revoking a shmem-backed key then dereferences a NULL
payload pointer.

On a KASAN build, reading a buffer-backed key reports:

  BUG: KASAN: null-ptr-deref in big_key_read+0x110/0x310
  Read of size 64 at addr 0000000000000000
  ...
  big_key_read+0x110/0x310
  keyctl_read_key+0x2da/0x550

Revoking a shmem-backed key reports, with oops=panic:

  Oops: general protection fault
  KASAN: null-ptr-deref in range [0x68-0x6f]
  RIP: vfs_truncate+0xa2/0x730
  big_key_revoke+0xbd/0xe0
  key_revoke+0xc0/0x1a0
  Kernel panic - not syncing: Fatal exception

Reserve the final fixed quota length before destroying the old payload.
The reservation in generic_key_instantiate() then has no quota delta and
cannot fail for this reason after the destructive step.

Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 security/keys/big_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..6aff1a73c7b38 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -195,7 +195,7 @@ int big_key_update(struct key *key, struct key_preparsed_payload *prep)
 {
 	int ret;
 
-	ret = key_payload_reserve(key, prep->datalen);
+	ret = key_payload_reserve(key, prep->quotalen);
 	if (ret < 0)
 		return ret;
 
-- 
2.55.0

