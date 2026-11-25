Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630605;
	b=3gpBz3nlOUoFjj6fD+4ePx/ToIHkv6DkPB3irqxX1GbshUohmU6fW6qhn4fNU7Yx/7WU
	 nw0zId0BGbnafMpNQoLoE5bth9BxH1Mt6Sj5esUcx33o4ruNhqiTW1R+EaGYVXP4g5iLc
	 zcpTwouqzSxCSrNBpCN+dCrlUSJxGP19v700mh6EQaTl+15+61wkfjyhAeiVknhg6Far6
	 oo/4J/LsNNBq9Zeq3jWbyLPqG3WN8FlfMJKYnX6z2zr24hQAbm0FCYkFqSWOwrFHRVX8P
	 fzK3FtWefHnkPOeCSmJBBRTY95gQubL443tFKqZ9feeYDj4BaGtPvgLjaVTaOP1J4MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xJl3VeU28yFIf7u8OboR3R/WMzTEeOW8WHDyp56+HdQ=;
	b=PdRC+dsKgfefNgMdFqemYM5PZdv6YyCL8YY8VcpGVK9o3UG0q7n6cP0u5lYTgOQqTvhY
	 IFMjNgQGa1qePRcMhKiH0ccpJz7ovkkUCmNPr+BiEBeiRD9R80p9I7e5zV3kB87bBPKLd
	 L+4X+djc/wZ6pnn27itbeFsyXuVYaV//kbwx76Wl6nnWVssksb/6L1ib7qwP+QjMeQ3x2
	 2xZRaq/+sWU7yy6yd+GFnvVIsHplQ/Lm2akmzpz+PazFWWlAN2vOOABukaHpHV8+6Qkrh
	 I1/kyfuLo/gkd4bYzKAcSQnmx4xYGA40C1Aapw7N2+bceUJheubty50vIr8nD/zhvaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBrwGaOC;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46082606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46082606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBrwGaOC
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd69954c755so4465118a12.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795630605; x=1796235405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJl3VeU28yFIf7u8OboR3R/WMzTEeOW8WHDyp56+HdQ=;
        b=uBrwGaOCVRNk9CTrbsLZdNKEAP6Ciz0Wj3NYwmH0huTDr5ZptQFbpLdDrXz6Scq3Bd
         1xiOpjK0kozcVGjxD6/HbCs2yCHxJvSB//7WnkaiZekqSeHEVK4bzkrnRCm88Aj5YT85
         NkMFikeaacU+yac9L8Z2/pLU3z2B3xws+rLK2zjTD0zn0xbeFLiOivyI0TQKJfPzwTca
         lPPDUqetX2hEjOx9YhYwMIdi12HWhrd/Mz37i92a+6kiGjdDyFrENFtk/geb/UnjID+Y
         U4+8Sf7Koht0aVW8w5OO7YtxZUGhpjZluc4xNEi61xuClnnMSYo0SEy9JQyiOucSm98u
         Wbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630605; x=1796235405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJl3VeU28yFIf7u8OboR3R/WMzTEeOW8WHDyp56+HdQ=;
        b=zO1Eo1DyaV2Ow8ZEa5IvoPwzwcwARIxF3fCCxYxftbGDPz0tS1M8wxO9YI2crf8YqZ
         9a78VuXMWKIsEPGNBmtYPTBI+yaYTX4cIC8tJ08u357Ubh2xk+WDjEsQQ+01lNcNA8Yt
         kIA9Mw6uBI8v2fs4t9TGSEwr3iTr2DVkPJ8S+fPvRdMgvqhiQC4N6UK8r77wnGvTmL3c
         zn/xkKDMWZmvq3VG6fJbSmzn5ozY6nhIfS35QQ5rvX/DTLSJmaRAcSIhJbUrWz1RqasE
         Dk26dQ/w1EahvltYkII9Ks5b9zcUsIgVKHIe0CL2KDuCZ/ghnZIfLzIeCOcbMscw4TtO
         prEg==
X-Forwarded-Encrypted: i=1; AL+hErG/IGqVBp+TvH4+HZO32V9pERLdiZLfmQBHckJPvs5lKKwMNK/ChXXu3Q1FQg6rTJR8mE5heuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+i/58MDki6svULEk5XpHlW1dOvs9ZMFf/ZtDbtv5YZa2FrH7JC
	GYNn6BAoRArPZzRVNXwLGXXKFHhEfkVADBd2qE9kngCQ4uqaya62C3Mf
X-Gm-Gg: AZFdTZccpLSgvFoAUxoBE78oQWuiDbK0rRPufMXLehFnzsGDhjEd09QetdPSHfOM8TC
	CkLZKoXgvB2o2a0ggsgVyJhCp5+T0volC/rtybxZFFXdQsBqZJN5nhEVSXnZGqUwyfmoKAjADbg
	4COpwPLL6kvxL7NU9dYDBxpgg6olFmTdT3lmYLIEbS7qOYJrKuwD8uPdhrydOmUyjvl/yT/eqlk
	C6S7fLronxRq2qIbinezmJizokYqRyfdmVjH9NW4Q4Tjh5NrlWS7KB6P3GHXT7mQbMnt3/SUviL
	BiVUbZ7SvIyqNm5SUUvXfCDyhXm8sP/tNSnszRnWtcncF0D0GFknfICK2XG8CBhJTOa6c4vRYN8
	6FS1rLd7SKRMjLkNFmNFfWFCorwCn9YesPrZAUgChM9qjaHTvXBLPNw+3KZbsdxcWWIoI0+B6z/
	SUeDUlSplbOGrmjTZqytfHKZ7/TwlHfadnrA2I4S2zu5aZhtxx+St9fNsrEt71jKKX/jHcCIac5
	qb+9f5A5KGFaHrwtpgaryp7bxeo6K2w3qTYMyEj8HWcy7qo1wKRtmyAhuyAVgFZbl61AQWm3cND
	UXHCNhXmLeYPIKl7LGZQh1cMYbgUwCDuTnic2zBmT4Wby4FPGBXkkNCL8FkC5LgfUOoQ9IwXkqA
	kILcENe8iX7dXHcOWm5gLZKaMBwATFkM4X6mH1HzLwuWu6QgOH8eb337uiRaMcX9vlpuFzC89cL
	U=
X-Received: by 2002:a05:6a21:3b8d:b0:3f7:7e3c:af64 with SMTP id adf61e73a8af0-4014c350872mr21282532637.43.1795630604435;
        Wed, 25 Nov 2026 10:16:44 -0800 (PST)
Received: from fedora (n49-177-87-40.rdl1.qld.optusnet.com.au. [49.177.87.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8cbe173453dsm6163395b3a.25.2026.11.25.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:16:43 -0800 (PST)
From: Ronnie Sahlberg <ronniesahlberg@gmail.com>
To: dm-devel@lists.linux.dev
Cc: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	bmarzins@redhat.com,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm era: stop the worker before closing the metadata
Date: Thu, 26 Nov 2026 04:16:27 +1000
Message-ID: <20261125181627.625466-1-ronniesahlberg@gmail.com>
X-Mailer: git-send-email 2.56.0
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

era_destroy() closes the metadata and then destroys the workqueue.
destroy_workqueue() drains the queue first, so a worker that is still
queued or running at that point uses the metadata after it was freed.

The worker is only stopped by postsuspend, and there are two ways to
get to era_destroy() with it still started:

 - It is started by preresume before the era rollover, and stays
   started if the rollover fails.  The device is then still suspended,
   so postsuspend is not called again before the table is destroyed.

 - It is started from the constructor on, since era->suspended is
   initially zero.  A status request for an inactive table runs it, and
   an inactive table is destroyed without ever being suspended:

     dmsetup load era --table "..."
     dmsetup status --inactive era
     dmsetup clear era

In both cases the worker can be busy digesting archived writesets,
requeueing itself after every step, when the table is destroyed.

Stop the worker, which also stops it from requeueing itself, and destroy
the workqueue before closing the metadata.

Fixes: eec40579d848 ("dm: add era target")
Cc: stable@vger.kernel.org
Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
---
An AI coding assistant (Claude) was used to review this patch and to
help write the commit message.

 drivers/md/dm-era-target.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index ea499adca4ce..8b8b8b3dfa19 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1438,12 +1438,15 @@ static void stop_worker(struct era *era)
  */
 static void era_destroy(struct era *era)
 {
+	/* The worker uses the metadata, and may still be digesting. */
+	if (era->wq) {
+		stop_worker(era);
+		destroy_workqueue(era->wq);
+	}
+
 	if (era->md)
 		metadata_close(era->md);
 
-	if (era->wq)
-		destroy_workqueue(era->wq);
-
 	if (era->origin_dev)
 		dm_put_device(era->ti, era->origin_dev);
 

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.56.0

