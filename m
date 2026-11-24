Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523167;
	b=kdbpWI7G4V2JvxCuKsm5Fhc/13z2TCORyEycKaZslPr77FdyrkNVHmUaUXxG/QTo1CEk
	 eFmqQ383jqVl4CoPsX9LrEwJRDxmpWOLWNr/1h8/rmukeX1H7CRCMCn+xf1dFIvdKo9A8
	 wchILf3tz+GOGrZKwTmzO2y/Ak7sQA7o8Eg293e92PW62dgZiha10rLTs7oURFcIPsUMx
	 3ORLzcyNG99QDmqEQ7YkHdy8WKGZwVxCXvVD4sci/F0bnaAcqxQA/mt4DciB5PU6bLREM
	 GwFdb0XflG1ju8i1wU3VU4vfiwf+OWx78m7HkaV1tXx1o0+mdiS9t+vqu48Hq1lg+uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gt2Xoct00o0UZmPrmLiXkNLZXaxGE333WSwLDI5A/G4=;
	b=qxJttTCbDDP3QlagkrSZpCsakxAeDLtTCHJpsfyuDlXc9Opcm477m6qEOm31iUBYRwKl
	 6bkR5uIXLqAGAlYABf/26NuuzVIwPVDvfOC9sCYeisigytFkd2W5jDPGhFKkTdkvRfs8n
	 Vg5qHXlTaBSb3ELX4wX9Yy68evCLygAYrJdZD+m79Or7nlM0cbjQMiwWVF81ReAuqNxPq
	 kLTupDfyUG5/nvLKad1GM+9wSVSNxFF1eoMx9RQnCMx9Gkyopqy7HQCXhJyvmlpQm9E3d
	 WZ+USHsQtSAgFfwOgJYvUdpHuqUTgI41/rMlYVdYKSOy9zKP7rOrSQ7BaOCjfNy3SqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=UWMC8bMa;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BCD606A331
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0BCD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=UWMC8bMa
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso43014375e9.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1795523165; x=1796127965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gt2Xoct00o0UZmPrmLiXkNLZXaxGE333WSwLDI5A/G4=;
        b=UWMC8bMaLapIJoJXGBN6NoWm4BvQ6r+qGs4p6Q6/V3wRMXR2rk8I/HpxLH2Vx5TRQE
         0aOIasCXpKA//HnW1Tb8oIMmKF27lVEoyMC9eJi8PoXMgN5ZzPZMdvdcDLe/zGWMZ4W8
         1gxztqf3pJkHQm0f425LQI9pZwNriIrTBYwMzwYc5W1Azwbp+pngWHXephcEACJdWvuF
         6yzxHNBCIZiorrbmMpoUlyNawdWN+qf3WgKZRZ+Z9JLsAwIwZtfDg0aM0rRYM+FxuNOx
         2ycGN1Kpqu0E8hNGVDr8jGXfKdkekKEtCBYC3cQIm2Xj6sX86pwKkHwg7ElM6RaPtDV3
         Zdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795523165; x=1796127965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gt2Xoct00o0UZmPrmLiXkNLZXaxGE333WSwLDI5A/G4=;
        b=SE45k5eicaXFosd1BSAZPBHgMfyvAT8LZGEIpgQzWQd7d9QCJBNs8yulBYfLR/gcwi
         1XY5YN4K8G0nnIOEZfSVdx3UIS9WV6YGwcGJA2syBT0e68gjzQy00vR711HGmtu4uq1v
         +t9GfU00/qzOxfhpIoE9rsR7jsfO7nMU0vOG678HIb6LOyV/UkrN/bXYw110QABd1/ja
         HAxQQEAownTICR0RNkdUDoku61ijQaZmT/1Qwg5xFRMwK7Mx0yWKirafdOAQSsm0xoDj
         pb9HzO/hM20pWPpv9TYQ/ULFqjjQfMDZdtDBurzZXFTeJ3YyIW0Jgf0lXSwZ6Eruh/qp
         LLqA==
X-Forwarded-Encrypted: i=1; AL+hErHRp0xyoHfC26qj2aSz0xoq+hCjvH0aYdZXSRFIWYptru8ENiTXw9o69eWFrBZm58mcAg0z4dg=@vger.kernel.org
X-Gm-Message-State: APuU4Z98UNnU9jzWmjM4LbJrKoN8PJTW8qJDTx9HMPO2dF/Qwp4DbYE6
	sqOzr+qVUxc95DigqZ8TcsFizcLu0i19Z4dTU4/fqS10axgapp8nc9Qc3isr8BJoFd4=
X-Gm-Gg: AZFdTZegCsE8ZAGJcq/JYe5HEApTLl04PBAMogDYgs8JwWH2yMyB7/ul2KFfPMfEEqG
	zh/R7VF53qSlLaNuL7qJW8GK5Gwlpt9DoJhd4nrADUPkW3e+jwFGhZm5zr03O/aLCb0B8haVrQq
	kEIHyQSGXGYdgM1d/Fntqe0oetMogYXsiw3RqwpnQVGU8gqWYL38zmOjSQcufppZk9umq1gLwfX
	tagLOKPgZ3nBK2XgOc+a3ml2Z+Il6szkkjvpqaWd8WOPTsyitTedPErYl7wsRlMy6aV/By/i+UV
	v40FRl9MrrN2IDkFqK2zvKCLfRt0/gdcUc3CA8z+iE1UHtsW0maOPvEwPkGK9ZkMv3hHFJCVDHL
	y2MyIyehDZiqycb0aQgi2W08LDhz8AUu5cJhT8ngOeHwGdM/DU76YXeHNyCrPpkyPfaUZnHFB3I
	rh47YATp+O5q1af0klSjOCSDH7qOTSdUJQeqo5OxkS/jp8DGAhQvltbL5aet+BCN79LNxNPy1Ws
	XFQH9U0acKilu2GGsEmWoAorgo538arRLiDPs36v/kAXUdC2HUGquMCzf2pkyrCB3Uxl2c82eCy
	3GLfeEFijfFTiIGLq3xfFvyXYuo=
X-Received: by 2002:a05:600c:1c08:b0:4bb:7757:fe6d with SMTP id 5b1f17b1804b1-4bb88804c5fmr364836555e9.11.1795523165066;
        Tue, 24 Nov 2026 04:26:05 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:8dcd:31dc:bf64:9564])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm423615975e9.15.2026.11.24.04.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:26:04 -0800 (PST)
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
Subject: [PATCH v2 1/3] dm persistent data: put back the reference a failed shadow dropped
Date: Tue, 24 Nov 2026 13:25:59 +0100
Message-ID: <20261124122601.436965-2-den@openvz.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124122601.436965-1-den@openvz.org>
References: <20261124122601.436965-1-den@openvz.org>
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

__shadow_block() drops the original block's reference before it reads
the block, and every error return after that leaves the caller pointing
at a block the space map has given away.

metadata_ll_commit() shows what that costs. It stores the new block in
ll->bitmap_root only when the shadow succeeds, so a failed read leaves
the space map's index root at a block whose count has already reached
zero. Every commit after that shadows the same block, fails to
decrement it, and fails:

  device-mapper: space map common: unable to decrement block
  device-mapper: era: metadata_commit: pre commit failed

The metadata never recovers. dm-era reports "era Error" and fails the
writes it was tracking, which takes the workload's filesystem
read-only. A read of a metadata block can fail for a transient reason,
and one failure is enough to get here.

Take the reference back where the shadow fails, rather than moving the
decrement past the copy. Dropping it later would hold the copy's write
lock across dm_sm_dec_block(), which starts by shadowing a bitmap block
of its own and so takes two more locks, and the targets size their
dm-bufio reserve for the peak without them. commit 490ae017f54e ("dm
thin metadata: THIN_MAX_CONCURRENT_LOCKS should be 6") set thin's
budget to exactly what rebalance3() reaches today.

Fixes: 3241b1d3e0aa ("dm: add persistent data library")
Cc: stable@vger.kernel.org
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/md/persistent-data/dm-transaction-manager.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/persistent-data/dm-transaction-manager.c b/drivers/md/persistent-data/dm-transaction-manager.c
index 7401add01d12..cf203ebb5110 100644
--- a/drivers/md/persistent-data/dm-transaction-manager.c
+++ b/drivers/md/persistent-data/dm-transaction-manager.c
@@ -303,7 +303,7 @@ static int __shadow_block(struct dm_transaction_manager *tm, dm_block_t orig,
 
 	r = dm_bm_read_lock(tm->bm, orig, v, &orig_block);
 	if (r < 0)
-		return r;
+		goto out_put_orig;
 
 	/*
 	 * It would be tempting to use dm_bm_unlock_move here, but some
@@ -315,13 +315,18 @@ static int __shadow_block(struct dm_transaction_manager *tm, dm_block_t orig,
 	r = dm_bm_write_lock_zero(tm->bm, new, v, result);
 	if (r) {
 		dm_bm_unlock(orig_block);
-		return r;
+		goto out_put_orig;
 	}
 
 	memcpy(dm_block_data(*result), dm_block_data(orig_block),
 	       dm_bm_block_size(tm->bm));
 
 	dm_bm_unlock(orig_block);
+	return 0;
+
+out_put_orig:
+	/* The caller goes on using orig when the shadow fails. */
+	dm_sm_inc_block(tm->sm, orig);
 	return r;
 }
 
-- 
2.55.0

