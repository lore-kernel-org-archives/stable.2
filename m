Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413926;
	b=GCDm5AEmzUzXOqcXjFw6wpLEvW9oYi/zzshJkm3c4ZySS0bdRhmoQuDCJEdtGsEql4BA
	 ryyEbFjp2iYz9HJ/PPkLNk5W/Thc27VKW0JneAP/juzNwZwsGiH4HFAkM6NYzyQ5WPoED
	 LKqv8/l3gYXqnvU9keXNEmV2JdtCXTGb/2zsK8Jer39/O5xNPyRyrOA16W3iNvh8Ex0ah
	 I/cY/853NzoSshBrIy9G65wZx9lfeA0UsyGmHetcGh2b4nlEheTVcGHMDRuY/5tjoJl5p
	 Yui2D9p6erl0BgSh3zH0unrhhQ49CsQ6/ElI+IOV4ak7uMLbjVVc1WiT2ijDtNB2QlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zHAbfUofqZjzoaZj66J2AEb1qG75/hMFQRjc/fK5hjg=;
	b=pml5bRjHdoZ6hA8MCgAOf0YJjm8xQySk7L7F8O5K1P/D1Z16i9giQdL4z24zEk1r4G9D
	 ZygxKiN4SsfDOuxMSbzE3Be8qY5yFUzaQU1o/LTQ8IG/kkXNi2CZlTPkz0fHeQ0Czvku2
	 6Rr74oZYzd/hKxolFHP1M8sz3cIQbP53lxdsxVrq44kvEpZ3ymzjTPYlYALcK6BZiwQBU
	 ASoSIdkILIDwL/3AwtROjJXwRndhm1sYg9aOq5s/vFU5isznkfOILqUWDKP2FOLojBhpx
	 RrgIiFOkZ1onuG0Ry50Gf+oYrt56plARry0BrzHqXLSIfZnxOQzKfGpNj2pHriD3kig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=LcTx5C4X;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698660A383E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0698660A383E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=LcTx5C4X
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490f38e9688so2671135f8f.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413924; x=1795018724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHAbfUofqZjzoaZj66J2AEb1qG75/hMFQRjc/fK5hjg=;
        b=LcTx5C4Xz1FOa9eEWojWoGvMhDB2PhsCg6WivIIm1qYMMM8rfWlP/5meHeI35+lpZh
         UgorwTqXUHZkiDIlL7fM49fxcp5ENfI69dgARVMXoCgVEr8NC/5g4qJ3htMsWhAfyDP4
         x8m+KOzu3OPC8zo7xY3/fFfgDV95pGxjTRd8XVUZeCoz9xj1GLrzp4WoEIIXURb9CQNc
         MncoR2uje0y7Nh8z6w07tungs0ceMkn9TOCxfo2n+/W0OeDqJN0TLE7dbQ2kGcaqb+uE
         P+4W6DBBBheowZgoNWkwgPpF47xiwNALjlaQ+Ew7teA6V8ztu/nK1qXJzZz79bV+fQ7I
         gVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413924; x=1795018724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHAbfUofqZjzoaZj66J2AEb1qG75/hMFQRjc/fK5hjg=;
        b=PkwYUJ7mrgLNEclxQtw6wVg9M5BWfNv+UTTxNzJjdwneZkLhC5sSyAI1DdaybyPToY
         4QEOQcGffOF0v4c2Mji2WQFmkf0ldiWYGsz+iVphoMl3tLlZ/p4yF2IMotE3NvrB3Xsk
         GTkevXDDckB66gGfSgk+rWbCbNhtzJuQZpCvBW+02nGzNBewiXWThDvnAfCDsHTAGFaW
         JwjU4NKTvJhsL8HepLAdrSaKQSUVOF9ATIifXeivilpwwLl1B7bRBeEbTUXSjyDsYr3d
         TpBFN7FZ/nBkdJjpasPQkwEnjsoQpplPYydUnuKHBeM4PwKOwMqcSML5eH9pllYHe6IE
         pUdA==
X-Forwarded-Encrypted: i=1; AL+hErFU/8slryoshyzBROkQtmMKjMAb9YylW9f4FEUdc2ARSJtydCcM1g51hhA/SrhqGOkuuLBGQU0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+je2n2UrPaEfXWpAFQkg3yXd05hPzaeit/earFNAemRlyvuYoM
	N4q5i5/lAZmhhMa6DsGclORp5T06l53cmKycy4qrSuk+VVgVAUuE6zzPjulZjYK8/iI=
X-Gm-Gg: AYBFou0BuQq2xDba76GHv/mtiEw5uu2BzaIJFrBq5FGvxVl64OqonLI5u3MY4440XlE
	K3QTMh7iiYR8sm65VlnWp9cGnqPmoBcI9k/Y+BW1N3Ml4mihuf3dgOmeIuEzAqvWbw+I216FsxK
	4wVzodlb5yCAb9MNTlMwlrXYwJU6+QetWO4IgjPRTCmrZly5EIc7EiJUe6y9h+/WJ6k33YuYNJ7
	YsnETxjHEqQe1eGYbSe1+GK+pVAsgmRGnvFpBMJwBgQ3mJ6hUTPpU3pYAcHn3Byb/YwyZx80WEH
	svyJl00OLAxvnC+PgKly8F80Z/vhcQVDVVXjN+IGDPv66GlJYufeV/OE0kBg13D8YW1oXCgcW1V
	p1C0pyEdz//7l1OtG5sKCjUFLE9RJzSFzaVkknRmrnujaC6HBJukmVBMCmbnpzOxe/xVAYB8YKH
	2A1oL8AtzgvJnf95/CKeKwLoS1lHLfIMGSe4GNSjWHsdNL0HRAtZlFcOjeUiuhHarZbJooJq3qe
	5HT+UGzMXrEPswBggM6sc7xFDeuDYXLpna3TETx44SnRS8TzcYudVLLnnYZV3nG90XuwJhpwVl5
	3o8May6bchjimeP56ewshnK2qQuTdHAH12maqfQaTr9IhRz2xgbtbTgVDkHPMVQJPs+hf/AdKSB
	FGM4lFsgsuQa5uem60V+uGlfkJtl8pQ==
X-Received: by 2002:a05:6000:603:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-499c7648566mr5495254f8f.13.1794413924411;
        Wed, 11 Nov 2026 08:18:44 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:43 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 9/9] rbd: fix osdmap use-after-free in pool lookups
Date: Wed, 11 Nov 2026 17:18:30 +0100
Message-ID: <20261111161830.1336485-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

rbd_spec_fill_names() and do_rbd_add() look up pools in osdc->osdmap
without holding osdc->lock, but ceph_osdc_handle_map() replaces the
osdmap and frees the old one under that lock (held for writing).  An
"rbd map" racing with an osdmap update can therefore walk the freed
pool tree, and rbd_spec_fill_names() can kstrdup() a pool name that
has been freed already.

Do the lookups while holding osdc->lock for reading, and copy the pool
name before releasing it.  Use GFP_NOIO for the copy, because reclaim
could issue I/O to an rbd device, which needs osdc->lock while a writer
may be waiting for it.

Fixes: 9e15b77d9af3 ("rbd: get additional info in parent spec")
Fixes: 30ba1f020221 ("rbd: make sure we have latest osdmap on 'rbd map'")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/block/rbd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 96743c059d98..d287c4882ca0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6001,14 +6001,21 @@ static int rbd_spec_fill_names(struct rbd_device *rbd_dev)
 	rbd_assert(spec->image_id);
 	rbd_assert(spec->snap_id != CEPH_NOSNAP);
 
-	/* Get the pool name; we have to make our own copy of this */
+	/*
+	 * Get the pool name; we have to make our own copy of this
+	 * because ceph_osdc_handle_map() replaces and frees the
+	 * osdmap
+	 */
 
+	down_read(&osdc->lock);
 	pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, spec->pool_id);
 	if (!pool_name) {
+		up_read(&osdc->lock);
 		rbd_warn(rbd_dev, "no pool with id %llu", spec->pool_id);
 		return -EIO;
 	}
-	pool_name = kstrdup(pool_name, GFP_KERNEL);
+	pool_name = kstrdup(pool_name, GFP_NOIO);
+	up_read(&osdc->lock);
 	if (!pool_name)
 		return -ENOMEM;
 
@@ -7100,7 +7107,9 @@ static ssize_t do_rbd_add(const char *buf, size_t count)
 	}
 
 	/* pick the pool */
+	down_read(&rbdc->client->osdc.lock);
 	rc = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap, spec->pool_name);
+	up_read(&rbdc->client->osdc.lock);
 	if (rc < 0) {
 		if (rc == -ENOENT)
 			pr_info("pool %s does not exist\n", spec->pool_name);
-- 
2.53.0

