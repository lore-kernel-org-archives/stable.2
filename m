Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999765;
	b=Bn7CwVPoJn7iJ6bO111AmhjzMDAJAswjHvJSwYP9VpztekkXGlXOMEO1PV4opwRn5n0F
	 irT6foCtEK5PesHLHVg9PkBceItan2QJHDCxvGdufEoFpYGDQqadfAzwWB5smnHB3PG5t
	 y0BsoWjdclLUv/8pmbXY690n3zscJ+we7QdEJ26V1SFRxrMfHcxROaRcqp3TZEttpgySL
	 xvgtTwlMDz7ufy9qqTeTebRnBs7cvE2oCV+fuG7NVTtjXJ4m/8j63jrDe6jzG8I4l58ne
	 vi2pgJvJqYEFwUJGhOLjt4+aTbM9kpA6qcFz2NR4GwkRfEWvW8IAzAMy688Hauywzpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XGgLe6XaIIl8o25hJ+WttFhbBRlV7LsocbjP/nKKIhU=;
	b=riAXbwpekDGDcDQ0K7eLKivok1Iwgdkl7epEB/XE7lp1cmsmdO/kUPU+7RNwXPBHB2a/
	 JBvwbYMcJj5G6DqmQsL+mtXl3vkFdu6bf5xacGkcY6mPI1vxA0PHNoaQkwsEhGfPEm4uO
	 aWORARNOei+56aP1nyzsliZWoMRLrMaf4yxPEoMhUsX7V4fqBJwVXgYHzgqKmn7AiINvr
	 wjDC3V6EPqpbkHK/VL8O3uS3mdkmzgAdGo7JatkbS6qsV6m4v2/3ojoCRsrgvx07OTGao
	 yqsr4oJDWS4eVkNz8POroVK0wCCcxn1GrGvV6xf+NJGuIQvuMM4Y20690Iy2jHWvBpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=lC7thfXM;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BDC60A2601
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84BDC60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=lC7thfXM
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so7712185e9.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1794999764; x=1795604564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XGgLe6XaIIl8o25hJ+WttFhbBRlV7LsocbjP/nKKIhU=;
        b=lC7thfXM6LfWZjtCvzR7ZvcaydeBRHzgIf17Ri9/vSEtywhJEQ2kwuwEOhfrjLaqlc
         A7rAZp1Or+2jWvdh8NEUbuOJoKiFYkNxonrSHWaQHwaxr7D00uaNQdoL77FwT5QQBkkQ
         QjrsiaejloGjsOrEmvGH/GwndAhjxR2MNpNAL8Fo2F9Vo7dekiDPb+X2YCv7MF0YfXu1
         b+8apt/QQTUnAQ2HI5obzcS0cNLZZh323vPlc7u/qiLp+xSyAxiM+Vvw6OBYpXuW6kZg
         QnxKGVnWUNmwEJDapv7H5CN9MSlv0PUjMcwhUWEJN4rA8JP05LufKqZH5WNwE4Q8Jmm9
         8SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794999764; x=1795604564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGgLe6XaIIl8o25hJ+WttFhbBRlV7LsocbjP/nKKIhU=;
        b=cMmyPn+x+PWDcD93rGwr78F29HwPbqHw5GOGi8r8M2qacz0Xky90TYxHpHuq17B6kM
         yV0DCqaeNS9BdrxjxnSQkslm/PsLJEmheeOFX64Qglpv113QBNmo+o3O+ZKkEc+bt8Rr
         CisMb+fwUwevRgsklZgDwBN3dLGG2f3SPNlAUKuxkNHBcJW5TPvla9JCJPWb6ltD9zOH
         j4ielPturabiyDdPIUJtKGjPLyFiHouUiA5p11cogygaO5+Dg+pn/Gbye5BlKFY3c8wL
         yQRgHGPN9cXFXwlst+Y9SZeyBYDMLNXIxy5C9cTo2krPqeM1MwLIf4eh9poSPap8EN/x
         zQcg==
X-Forwarded-Encrypted: i=1; AL+hErEcAVIHs2pETBVZTDPg9GukpFuj2b6Nkce5rFAKkKy9C74iIk0aSJqwOorQTsHH6mnfioExTtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cHw5OgAtY+w1LMjLfmA7yuyFpKbiEvP6xTPVeUBTGZSSji7Au
	VekraGC6hTaVHxS4bxNMwtDndpie5NyQ8FAzAjGlq93bR5S2nv4iafi+XTvZc05YHmY=
X-Gm-Gg: AYBFou31HrkagTzWgNI02YJEqiuVtOO99ylAbMtVnZnKNu3AYWocsQ1+bl+NXdAmtHN
	W1/a0dFGL6RpFzPunysLTwmd8r/IpkYxWDbf/4c51B+35QYZq3Se5DziC+rFN5tungtUAZlB0Wa
	PEPQDUV/tImbpmT4EjJH4lXtfyPgKmZZCSj5m1ayJ3zJd6nw8WuQDGK5fDLgPID6gOglV9sKrms
	1WHO8+6OsYLa7DI66o6bmkN6uekPy+iMUdnharLZhYO1Cs+m+fV3bhz60zF+Otb81wEYhsYW4ps
	wZ0PxJIJndr4L8KeVNeIcDJOr6+x4Nu0+N9CCJ2iTBm35sRuUd6H1SFNpAyCciJ+EK+auOHj1m2
	o8ApW1/Ld6TV6lt/tX19aYr7d5FZ5AsxCQ4FZrtGS9LD+UHcvNBX/Q5/HST+UhE8C6D9BOCITbA
	XF6VzuizaXBIh6on+JogBXsXwF/zRyhPse1VsfVwI9QXMpADkSwsJ9m4h4TEBeuFZaPNeKyGXk+
	QVeupW/KtpFwmbnrRqT2dAu6udzb0UiYUnlAlrqT5qFwC8wD/NTH5JMHKcd7X+yr+4ivTC+qzTr
	HZmT1uwlC1p30Z5JtXQzGjCg+eGsG+E3/cQkFbQFGr8/T5Kl
X-Received: by 2002:a05:600c:a54:b0:4a7:6bc7:f778 with SMTP id 5b1f17b1804b1-4bb7da4616dmr42094465e9.30.1794999763742;
        Wed, 18 Nov 2026 03:02:43 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:8c09:3cc3:6efa:ac1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm3943277f8f.52.2026.11.18.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:02:43 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev
Cc: bmarzins@redhat.com,
	thornber@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	den@openvz.org
Subject: [PATCH 1/3] dm persistent data: drop the original block only once it is copied
Date: Wed, 18 Nov 2026 12:02:37 +0100
Message-ID: <20261118110239.2910290-2-den@openvz.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118110239.2910290-1-den@openvz.org>
References: <20261118110239.2910290-1-den@openvz.org>
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

From: Denis V. Lunev <den@openvz.org>

__shadow_block() releases the original block's reference before it
reads the block, so every error return in between leaves the caller
pointing at a block the space map has given away.

metadata_ll_commit() shows what that costs. It stores the new block in
ll->bitmap_root only when the shadow succeeds, so a failed read leaves
the space map's index root at a block whose count has already reached
zero. Every commit after that shadows the same block, fails to
decrement it, and fails:

  device-mapper: space map common: unable to decrement block
  device-mapper: era: metadata_commit: pre commit failed

The metadata never recovers. dm-era reports "era Error" and fails the
writes it was tracking, which takes the workload's filesystem
read-only.

A btree caller ends up in a different state. dm_btree_insert()
publishes the new root only on success, so the caller keeps a root
whose count has dropped to zero, and the next dm_tm_shadow_block() of
it finds dm_sm_count_is_more_than_one() false and writes the block in
place instead of copying it.

Decrement the original once the copy holds its contents. A read of a
metadata block can fail for a transient reason, and a single failure is
enough to get here.

Fixes: 3241b1d3e0aa ("dm: add persistent data library")
Cc: stable@vger.kernel.org
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/md/persistent-data/dm-transaction-manager.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/md/persistent-data/dm-transaction-manager.c b/drivers/md/persistent-data/dm-transaction-manager.c
index 7401add01d12..159aac9da07a 100644
--- a/drivers/md/persistent-data/dm-transaction-manager.c
+++ b/drivers/md/persistent-data/dm-transaction-manager.c
@@ -297,10 +297,6 @@ static int __shadow_block(struct dm_transaction_manager *tm, dm_block_t orig,
 	if (r < 0)
 		return r;
 
-	r = dm_sm_dec_block(tm->sm, orig);
-	if (r < 0)
-		return r;
-
 	r = dm_bm_read_lock(tm->bm, orig, v, &orig_block);
 	if (r < 0)
 		return r;
@@ -322,7 +318,14 @@ static int __shadow_block(struct dm_transaction_manager *tm, dm_block_t orig,
 	       dm_bm_block_size(tm->bm));
 
 	dm_bm_unlock(orig_block);
-	return r;
+
+	r = dm_sm_dec_block(tm->sm, orig);
+	if (r < 0) {
+		dm_bm_unlock(*result);
+		return r;
+	}
+
+	return 0;
 }
 
 int dm_tm_shadow_block(struct dm_transaction_manager *tm, dm_block_t orig,
-- 
2.55.0

