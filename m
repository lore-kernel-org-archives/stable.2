Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014855;
	b=AqqFMDaUfXZCBglBObu6xksSryUjroQU1GFQI/mSus0SURsOYXjlRSbmUSKKzi1/dB4Z
	 YVHPuXnGDHUsFcLC9tuWxABTD/7YKeoVOn7fxf4uPzpjqaZrJroqqcGfA9tpdJNtS54g4
	 5rglTedKVQF5dAW8iOIVYGosFN5va2qW/jttNEvLr3Z6xEiqscZxdVHw+b+MXD0nTwzcv
	 IQ/dTqGDMb16dF/1xRTDcS5efvFMh9YGDk9lzKgF8TUZN0HhHB6oCMUBWuliTdsmaL/bz
	 Que4Pih/9ASt3oT9Gj8HYCXN1NEypgUtW/S2XAvqYO1Wp5EFR8vItDC+CjMGC+BlSDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eA7Ba+RNhuLv4gFQ3OIw8fIm3ERdVQLD/ZDlb9KqNxw=;
	b=AFNgS4Ih4rHzAEzwr7Q8GbSp15etr2XpUBA+vYtZAlFrRScZkB/bytJeErz9aUI39t0n
	 i53gxrYBkHHcuoI7trKQ4bIoMDwsCjXqc8xxk7Z/nchdZTHMyOgFLZ8PnzSBv3G07QAXe
	 h58yLm7j0hHRLdtk6skkOf7AUFvnwYWX4RfEiZRGemhNbrJxmntmchzlw9/dqnookzwiJ
	 Tn2oep6HdUmJ7uHm89JWzcmCJfaAdO82wnMDckrqXOiSoyxxupexw304GKzBclKut9pDe
	 zypSQQ4cqxJm4mcFAw0a9O/rzKeUguKvhjXxSeBE5nMUOyGl9MiFtz2GksdqW40PcvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfZ43j1d;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD896606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD896606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfZ43j1d
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2efddf749e5so10632785ad.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795014854; x=1795619654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eA7Ba+RNhuLv4gFQ3OIw8fIm3ERdVQLD/ZDlb9KqNxw=;
        b=tfZ43j1dTe3DDhOX5b9+E1mKA+bJ83E2MqjJwzj3Rt1lDEmy7YSYZ6I3inAILi6tpT
         Elm9+yARx79xuzDYKT5eL9WzjZXFEGZjMC5hZ1FNckHgll5mbvU3lujU0rpIZXpeKiH8
         lJAzDx7Kkcup0lSsHL2RtBn3eORk1s9H+Sg4UkbIDY1QOFz1IB/xvsG+2grnG7QCwgKP
         2SYZPj/b4wv5V7P+yqxlscnGT9mjiM/rAfIXtTczUJyoD/TnUalq1OTCMNMUCog5/0R7
         BlR3dDOVhNWD8cO555yvcCWd2lCDC/MCBxN2hJSHjwf2k4uAkxoTfYE0ePs5jdmHH8tg
         d+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795014854; x=1795619654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eA7Ba+RNhuLv4gFQ3OIw8fIm3ERdVQLD/ZDlb9KqNxw=;
        b=BIfamIAbjq7YbbRPaM0guBzbxsJRWB7Xgbjd7IMQWIu3yNG9FMVaXS0Er1EiWW2U+Z
         n+Oo2UDaxpF7EnMTDtioIb7nzFDC4n6nfMlz3bflBlIg0m4yjjuWAnWljl51aD2ezZuR
         nfhAf2byHpXBdjzY96gE/lPqpp9ULOna0HomAa/NRgd2Tj0Amue37fMORnkJDGm7GmiV
         buF9uxnBn9gETzK2I/+iexeAVYZQcWEHe1ygEKp4wdReCVXfUAw4Au211hfMoUH8qPB6
         DKTV11J/oQd9xgQz4N7B0a7XemD2ga4t0D2iUHDj8fFaDp89QZOgVbQhKdmX0BhUvXGh
         dNIg==
X-Forwarded-Encrypted: i=1; AL+hErE8i64F8a82uRP+QxDmFu5LCcp0kIt+b19KsljuHTvC5T0R21rBLCjz6P6BsrYwHJGynlNb3x8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8udsdm5haATjynuwelMCSGYSo7c1hRSbLhS/zxjxamCWlJEnkk
	imHYGzpB51mRH0XASy/IAXCgIqIRuN6/FL7MRbQ4q8uHYOLm4PgTjfYbXgA7GA==
X-Gm-Gg: AZFdTZdWQfYg56jHQdsODuVVCHwPLC3CdqbxLkmB8NbFYOduwMWhv9AapySn8/PkgXu
	daF1aBiqimoARzphkvb8/omhrq0Dt4wIx9X8XDb5OlTecssoA9uxvFQb5loAfauidSnolvcFVLj
	jkaCILoaK2zSRQ7izCPlM/hY+CuMlskKGTTHsl3bEeHENBzCX4Z3+5a75yH1ZFV9pXWF2oXG7WV
	tmXfn4Z4TlZzvPa+EXU14958/QkBSPxpBJtt2fsWyFEq5742D6IWS5arnSr9l5+ahLlAbDLZyLK
	1gD+6R0Ig003JfKf5mK0/1fS439XzMZ7YK1WypyP/ZzQlnleuqt4hSsa4BBiPY2qY3gPujBqtKH
	WU2NAPNdNH3F3WYKfF/yURo76D78ygm+yDEqkfinnwbyG1mNyX6DrhGrEufxI61tnzm9Hyiwsq0
	4qT1kB/ukUCPO0UXmD8GieihMkaHEE8s7TviPOPuEMlZetdn+Umq8HaIIKlcJxBLRU07GCNVLey
	3pjNmjcF76ZO9UnJba8y6OmHiCFtA0jOELF38VDhYRKurVMd+D+i4SnSYyipEk+S87813eYhN/B
	rKieCyp8RITxPRL9b1lBZz6MTJ5L4fiEOt9zyBMxaKewMHxxRenAcA==
X-Received: by 2002:a17:903:144b:b0:2e9:5313:8f7b with SMTP id d9443c01a7336-2efd9b2ebd8mr50434585ad.9.1795014853877;
        Wed, 18 Nov 2026 07:14:13 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6236191sm15251045ad.53.2026.11.18.07.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:14:13 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Christian Vogel <vogelchr@vogel.cx>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] w1: ds2490: bound the search results to the found_ids array
Date: Wed, 18 Nov 2026 23:14:08 +0800
Message-Id: <20261118151408.4001564-1-maoyixie.tju@gmail.com>
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

I found this with a CodeQL-based checker that we are developing. A
userspace harness runs an unmodified copy of ds9490r_search() from
next-20261116 against a fake DS2490. With the default max_slave_count of
64, AddressSanitizer reports an 8-byte write past the 512-byte array. I
do not have the hardware, so the fix is only compile-tested with W=1 and
checked with the harness.

Fixes: e3fe0e89fec6 ("w1/masters/ds2490: queue up found IDs during scan")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used Claude to help check the checker's report and to write the
userspace harness and this patch. Sorry that v1 did not say so.

v2:
- rebase on linux-next (next-20261116) and test there (W=1 build, the
  same harness)

This applies to linux-next but not to the w1 branches, where the
allocation is still kmalloc_array(). I can send a version for them.

v1: https://lore.kernel.org/all/20261117145534.755665-1-maoyixie.tju@gmail.com/

 drivers/w1/masters/ds2490.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index f1d4075075a657..c5d76a5ceff468 100644
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
-	found_ids = kmalloc_objs(u64, master->max_slave_count);
+	max_slaves = master->max_slave_count;
+	found_ids = kmalloc_objs(u64, max_slaves);
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

base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
-- 
2.34.1

