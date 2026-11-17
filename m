Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927347;
	b=sLDlbhb6xALY2bVyNgVe5ub5AQB/0/sziPElNiJwnojALTLTxT//qL2lrOxyrloejxEY
	 ivTADBPm3YXnX/9R78i1MuQV2ImcajWlNB6zZP/xaASZLGGc7OuOPQAhMHiW2PtOcRLal
	 T4lryh8xvgR3MOFDl/c/Owy0YhQvIsqWvbnMFiQBxuzUcVbwyQ9x3jAUaAuyJ+622yzRN
	 JEPxchr/OrAJXDcoLrQbherL+Khx48xNm8cU9sfbH3YKR5shT8BIbWm9xb3W1Ozyt8nLP
	 6jAbv4WN8ifp9nNNX6nuV+Y1UuSDQtZPuk6n4PcXb3KkZKAsMO749nxiw1pqzHe92AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4bmBEUjCAH97zZ5eFmCOxc2ZpUnaRfqp6CNkOUudcic=;
	b=UUznNLKzg7C4O6HPAaj61zHTnaR8ZQuOi+39je9EZKoALIPa3BQGB4Oj3TWZDS0WpAko
	 XH4dKgK0LjnAYq7bWe3IGoXxNKeF2sI7Uc566apVJ4L5rqcEf9hbj8T3RkaoAkh4Rc2CW
	 bpmbbGquA34M5QOKFC66NbilCjMJ3oGSaKLXsKS6Sglui4ddtmTm/6SbJT0qyzPhZfyw3
	 QWg01dMRcD6YCM7gzmJV5CWk99fCnL+RCFFSLj4etMChILlbO7scSJ8J951ZJR/oMULCy
	 tmdetcDMGXp00kV6vkfRCvoXEdqIIJwn3X44TPiabMjDdNWylssHn8I8VxciMw2wiKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hns6Y2T3;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382760A2624
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4382760A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hns6Y2T3
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd69954c755so4040092a12.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794927346; x=1795532146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bmBEUjCAH97zZ5eFmCOxc2ZpUnaRfqp6CNkOUudcic=;
        b=hns6Y2T3Gzz7D9tz3SxJFcPjAq11f5XQpUY04kWWVULL2becN13eC6jPxheo1WvHDk
         rqdXYtl10p6n+CpxL7cbLZsiZm6G+FSXIxSrTnLNCVJ2otTOPOmRi10NJkbXX33TXLSz
         +2FjRT6U1uGrGMv8c0BvyiXE1fE6YwbKdAdv/qb81tBKBeIBxOkOf/lmo+7B7nHo1br2
         k6H4cd8xH1niSpXsf3COVLhg5rYPgaOEa21pmcPMR1wUlF5acNv7TjT9xyyVjGPI+4Ub
         +2hfxD67eXfWgCIFzcd+vF9i08bOFpk8BymoHi8gz/ZwYdSfluVLiZRfXyLwvdwPnn8C
         19uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927346; x=1795532146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bmBEUjCAH97zZ5eFmCOxc2ZpUnaRfqp6CNkOUudcic=;
        b=DoPVpLJTZwVOTBDW2krzg3GgD9IpdNXcTsac4OXJxJAPLOEP/hW4P04fTdp4qYg3D3
         D6UqjdEpOWlZGWa6Wr5CtIf8so3Sz41gd/u0JNnDA1o/1/A4CXIi/wk7u8vTKjLEjLil
         wEtwPV6saryq/aHbsD8MgXPh2mHejJDVqkkZN6AWy2LOiHYm/9OIZHl2NAaX+HU/GlBV
         LA/MSgQLC+BQudxsmHHYUe6qHntlprlKE1w77JCdShLxDFtOS1czF+GRF1aQw8MrBhYW
         fFpDEjGVaPSO1Rn/eW9aNvmSLOgW84JTGitmfUe58O9ZMUe+fhjfDGBbL0Fsc6573JrY
         n3qg==
X-Forwarded-Encrypted: i=1; AL+hErEWQMf5AqSrFcqFhwOf3q2RN22zQjbK85uM5e232LvxbrTeJxr/AwmGttaHKrFi2FiZPaWKkSY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+L+qgSOU8E0Hh1wfm5OqMFL2Zc2rjCucCSTQP3p7OqbhsZGm6o
	H4Rw7x9tyo/9j97D3cbw2H6QvxR0zhtOu2fI4l26JUKJweUxs6kvivg0
X-Gm-Gg: AZFdTZeoVDQCd8QgTOYoZt9+bWfo8IcPlqSgsmYf7oHWEdEG7MVsYUFR9OhAaS3Fl7E
	Cn8AfChnGl3sap22jMGjVLePoo6tuikH5xhEuiZkdthxZcRDldgcThi+ATUDICTSu+AIcRf6003
	Bou73XDKSBVIGJC4YwIG0lrvPIW6MdD6Z6LUi9oyR5Qz0YsFGJIoqBhh0o7J83cfqqaz+dyn5Qi
	QpR86rS8AbFbXVA24P4yPFm5QGgCsWood+mnkYV+eCP2cBqcYKQzXmTnYQk3PGcEnh6uhthZVmS
	OphJOAjIjCwg0rx0Qdx3YiIe3LyQvf7Mzl1hDwON9IUDWsZAqHB8QC8Mh/hIZU9IVgRsjhNmFYa
	VB98rGYBAl/XHdBia+zA/wC+Ufhhqu7JwYxqkPu6W9B234uJXdQtkPNwYEmdcdCs97BpAInK0Ou
	8c1uf5kqf/FSY0vqfj9c6Lr3uQQyERme9oWYT7Qa3l31DXvKP/5h0e3mkSIaAstv3a68305dEVP
	Id8fl6B8p4VMMOzqIM23Nsi2wh/UJi2S1Ze+9RVqHxw0M83R426jpmnDJYNYVAk3lYEsC7/kmr2
	Qh7JbQIu7hj7/v4pZoPrwxocboJ2W74rqC+x/PZGw4NhRx02AZ2czQ==
X-Received: by 2002:a17:90a:c88b:b0:3ac:3588:b548 with SMTP id 98e67ed59e1d1-3b1b09e69c6mr14655656a91.13.1794927346406;
        Tue, 17 Nov 2026 06:55:46 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a11c4asm17186465ad.22.2026.11.17.06.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:55:45 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Christian Vogel <vogelchr@vogel.cx>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] w1: ds2490: bound the search results to the found_ids array
Date: Tue, 17 Nov 2026 22:55:34 +0800
Message-Id: <20261117145534.755665-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

ds9490r_search() queues the ids from the DS2490 in found_ids, which has
max_slave_count entries. max_slave_count is also the search limit. With
more devices than that on the bus, the DS2490 sends that many ids and
then a discrepancy value, as the comment in the function says.

The break at the limit leaves the loop over the current bulk read, but
the outer loop keeps reading until the device is idle. A discrepancy
value in a later bulk read is then stored in found_ids[max_slave_count],
one past the end, and the callback loop reads it back as an id. If the
device sends more values, they are written past the array too.

Store an id only if it fits and pass at most max_slave_count ids to the
callback. found can still reach max_slave_count + 1, so the check after
the loop sees that more devices remain. Use one local copy of
max_slave_count for the allocation and the bound.

I found this with a static analysis tool that we are developing. A
userspace harness runs an unmodified copy of ds9490r_search() from
v7.4-rc3 against a fake DS2490. With the default max_slave_count of 64,
AddressSanitizer reports an 8-byte write past the 512-byte array. I do
not have the hardware, so the fix is only compile-tested with W=1 and
checked with the harness.

Fixes: e3fe0e89fec6 ("w1/masters/ds2490: queue up found IDs during scan")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/w1/masters/ds2490.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 3cbff88c339e96..0c792714add874 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -697,6 +697,7 @@ static void ds9490r_search(void *data, struct w1_master *master,
 	u16 value, index;
 	struct ds_status st;
 	int search_limit;
+	int max_slaves;
 	int found = 0;
 	int i;
 
@@ -718,7 +719,8 @@ static void ds9490r_search(void *data, struct w1_master *master,
 	 * We are holding the bus mutex during the scan, but adding devices via the
 	 * callback needs the bus to be unlocked. So we queue up found ids here.
 	 */
-	found_ids = kmalloc_array(master->max_slave_count, sizeof(u64), GFP_KERNEL);
+	max_slaves = master->max_slave_count;
+	found_ids = kmalloc_array(max_slaves, sizeof(u64), GFP_KERNEL);
 	if (!found_ids) {
 		kfree(buf);
 		return;
@@ -733,7 +735,7 @@ static void ds9490r_search(void *data, struct w1_master *master,
 
 	value = COMM_SEARCH_ACCESS | COMM_IM | COMM_RST | COMM_SM | COMM_F |
 		COMM_RTS;
-	search_limit = master->max_slave_count;
+	search_limit = max_slaves;
 	if (search_limit > 255)
 		search_limit = 0;
 	index = search_type | (search_limit << 8);
@@ -760,7 +762,10 @@ static void ds9490r_search(void *data, struct w1_master *master,
 			if (err < 0)
 				break;
 			for (i = 0; i < err/8; ++i) {
-				found_ids[found++] = buf[i];
+				if (found < max_slaves)
+					found_ids[found] = buf[i];
+				if (found <= max_slaves)
+					found++;
 				/*
 				 * can't know if there will be a discrepancy
 				 * value after until the next id
@@ -798,6 +803,7 @@ static void ds9490r_search(void *data, struct w1_master *master,
 	mutex_unlock(&master->bus_mutex);
 	kfree(buf);
 
+	found = min(found, max_slaves);
 	for (i = 0; i < found; i++) /* run callback for all queued up IDs */
 		callback(master, found_ids[i]);
 	kfree(found_ids);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

