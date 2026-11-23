Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452047;
	b=MjAcodhPVi0W+vHyLK8jcI4Fkm55MW+1w7i1ftwREEgD3pqW0hPopaFqf4Mo8f2Oyjt7
	 7dwE+wOwUcQfA+iz6Mx6JiorSoWE/DjTsF6FsFFZ3So0pIf8fJHccCyFpT+zfwywPjcgO
	 or9CgAeHm4QCMt1zuGYcJyEIMki/6PR7NYlxdZDjCScq5LRzEs1EbUHqHtVZzQz5yD4QZ
	 GwKkbLhI/Uqra//OJQerhUBfCOiklgnyCqC5bx04af57jA7Ut9SXgxoZ79quSOCU/NYIg
	 JobriUClv+7oEKblXmsMEAVaErLYFTvMYeQJYXdkOjpMSDgeeLsZq18yO766seEQ1zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=;
	b=gbK1qXnUwAXAlb5xSwPu7u6EAtEG7cpgnmfqTJRsSn0nJXR23p8dXudb7wYtTUc+ZfFp
	 WaNL0F5SEsPjon0KzorK30sZE6z6TfWlABQFiKn+3y4fJWXH7jPpPuKn6D/pv+Y24u8q5
	 m8vLyU4DqunJaR1dDs/ca9HTn+MJAaFvZP1bgJbv1ftK6DbkDQuWUWv1hCHS+9jU0T0D1
	 uCKlbyRn0VCStB1PqASGqk1AgLVtnPzeB781L2TxgZALBCax+vaRjBMIkCy0xexcqm+Ty
	 3WTe7/7SQIyY/KOYTSbkX+zg60V59s6msZB1lmwAt2HkRK6ex2UwuqfnA84yoF+AE4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbpMdQoi;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73D606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF73D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vbpMdQoi
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so5162099c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452046; x=1796056846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=;
        b=vbpMdQoiG9qBH8Tl6U7EVOleFGxsrHTy0mVYXW6H+MRhrHrfwiAVBAdwZayZumctqK
         TjAfKEAnfrjr4j6oEW/cEYCOBj1+AV19XLVfz2mSeSpyi0+JFw8DFQVJXbtbFtagdP0E
         baE/uVWY9vzZstUi/ZpsJ07RzWunWb//7HKrxuNGitcvwHrLPXNwaPmXzMWgE05nLAQl
         sS5QwQMzgs4+UdkcXzbn4Mt8ueUsE5U3xufdoU+dhEZlXnDT4P/6Pgpg9X3SJxrhdr0E
         djNugvM++2GRtA2GnhQMsxjY3VIrtZO8oloUIyWEZKFD/GXznbLz5MwpfhzUqzgwVZ/R
         a8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452046; x=1796056846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5/ZiEeoOQolEtqZd6duqT2B+ydqubbd46Mv2EwUK7A=;
        b=dB+UaPGdyL1OxTSlgZmjFFRchVI9lEo6crza2Wf8h8tTVFFlv0ekQSINkNZVECsuY6
         8Y7v2BS9A8x7aoOvJs0b1xKwWP9I90awwqevnoXqxYr5O+OmcHzTtyIXMgoiDfi5kOYo
         cTKNdZVC+yb3GpGf3Cm57gzZEuWkDO3c1RArciDbyqDfjjiPHMhKatrck4j7yyXWITLC
         xPyheGa5jfOSuiKbjghNk+aaIZ8qt+pXocctLvMY1ZbqvxKg7WuAyPlPc+Sd6TCRD3Q/
         yZTxxGpOqUqgwinAnpPtubfbs61r/OeW4LjOmv70I8iUsAOmpXSC5M5rP4H79sNnvQRi
         ohjQ==
X-Forwarded-Encrypted: i=1; AL+hErHE9tKGTrtq1ZaFXOzNUwzTW4t113UKU28jNRApF6VAtjgnIY/VwKsk1V45U2Fu3x4OzVEQE4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z++RNzF8Nh/dSwyIs95t8CqeqMWoLsLLRF3ZXlYHa/0RalgQtJz
	81GdSHgHJCPsxl3wBWtrmj8SUAeRIraVyrtha8wR+BAhWoQv/gKWrNf5
X-Gm-Gg: AZFdTZdaCUwa7f/Z4I8fCteQu/+byy4afc/sdU1+QfFINp3RA5RlCOjfsG6c+rYoQoW
	LlJ05NpETq65XQGzVrT0L6/7kMe1UHSgj1v5UJuKD56Xg4ltbRiyNMtvckGTdSjEcJf4FEU6vwS
	Y3JKHDHvIcOs5JwD7wZ4M2Nt81ApnDERuwNqLtBayzf7yToaQ0uXMGhWZD4T7aB+BF/VqLHKued
	3iqrri8yvf5PIoaZbgIiA7TmfLk0Tpl8rGmOrKinrKL3h0q47iFpuPVw5rvtpNHC9W7TNPUh3mG
	99SLWb/OHtKCqI0HyVnGO+8y3cGtWPGOOZibFNFx4TV7qqJyh2Dg10tKbQeG8UP++MfB9zmoOwB
	b4u5ef3v5+K9r/6nHbOReTBROHQXus2pCMMDLe6aAawuMO9fU5RVV8GWe+QGZ0aXKHAPZtxyzW1
	WcPjkdMLvUKTCMlJO1VAIyspaP1beVuquCa00p3E25Sw4OTgIagq9qwluiBbugjG+2qpBMdyGBl
	7IvURKj6xj3YUqiuQ5Pd/6433pg4PW2udaZ96aQmov+nWdRpDCf8vGF6KKgbe6bU6a+jTnvJrUF
	+IulfF43EwR0cTx6cw/4Entca5UIBxZzNeicQ2HWPsdaAquBWnECDNIL54J2L9YFAgaDip5tqdp
	pBTRwyBhB
X-Received: by 2002:a05:701a:844e:20b0:1b5:6c13:c76c with SMTP id a92af1059eb24-1b56c13c7a8mr6689110c88.15.1795452045824;
        Mon, 23 Nov 2026 08:40:45 -0800 (PST)
Received: from lounas.tail428e48.ts.net ([157.131.129.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm33225486c88.13.2026.11.23.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:40:45 -0800 (PST)
From: Louis Thiery <thiery.louis@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	bmarzins@redhat.com
Cc: ming.lei@redhat.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Louis Thiery <thiery.louis@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] dm: clear REQ_DM_POLL_LIST on embedded clone bio
Date: Mon, 23 Nov 2026 16:40:21 +0000
Message-ID: <20261123164021.463361-1-thiery.louis@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When a polled bio is split across a target boundary (for example a
dm-striped chunk boundary), dm_split_and_process_bio() re-submits the
trimmed remainder of the original bio and then calls dm_queue_poll_io(),
which sets REQ_DM_POLL_LIST (aliased to REQ_DRV) on the original bio.

When the remainder subsequently enters dm_split_and_process_bio(),
alloc_io() clones it into the embedded io->tio.clone, inheriting
REQ_DM_POLL_LIST. alloc_tio() only clears REQ_DM_POLL_LIST in its else
branch for non-embedded clones, leaving REQ_DRV set on the embedded
clone that polled normal I/O uses.

The leaked REQ_DRV flag is misinterpreted by lower layers. On NVMe
(where REQ_NVME_MPATH is also defined as REQ_DRV), nvme_start_request()
calls nvme_mpath_start_request(). For a single-path namespace where
ns->head->disk is NULL (with CONFIG_NVME_MULTIPATH=y), dereferencing
disk->queue triggers a kernel NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000050
  RIP: 0010:nvme_mpath_start_request+0x28/0xc0
  Call Trace:
   nvme_prep_rq+0x5e0/0xa90
   nvme_queue_rq+0x40/0x1a0
   __blk_mq_issue_directly+0x45/0xb0
   blk_mq_try_issue_directly+0x85/0x100
   blk_mq_submit_bio+0x6c9/0x710
   submit_bio_noacct_nocheck+0x127/0x330
   blkdev_direct_IO+0x230/0x680

On stacked DM devices, a lower DM layer also sees REQ_DM_POLL_LIST
already set on the incoming clone and treats its bi_private as a dm_io
poll list head.

Move the REQ_DM_POLL_LIST clear out of the else branch in alloc_tio() so
it applies to both embedded and non-embedded clones.

Fixes: b99fdcdc3636 ("dm: support bio polling")
Cc: stable@vger.kernel.org
Signed-off-by: Louis Thiery <thiery.louis@gmail.com>
---
 drivers/md/dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1881d8611..79972f17f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -628,13 +628,13 @@ static struct bio *alloc_tio(struct clone_info *ci, struct dm_target *ti,
 		if (!clone)
 			return NULL;
 
-		/* REQ_DM_POLL_LIST shouldn't be inherited */
-		clone->bi_opf &= ~REQ_DM_POLL_LIST;
-
 		tio = clone_to_tio(clone);
 		tio->flags = 0; /* also clears DM_TIO_INSIDE_DM_IO */
 	}
 
+	/* REQ_DM_POLL_LIST shouldn't be inherited */
+	clone->bi_opf &= ~REQ_DM_POLL_LIST;
+
 	tio->magic = DM_TIO_MAGIC;
 	tio->io = ci->io;
 	tio->ti = ti;
-- 
2.43.0

