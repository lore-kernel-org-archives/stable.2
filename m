Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630386;
	b=e9PvI6sR7ug4v/Pu2kk1HC5Ixd3a+9xWm7y44xXxzYFNNzS10JKaAekT4JVR+0yfwEV5
	 9VBnefab5zTzCQotevfxuoZxm9M06Jd9gYKWj6JEyMA7pZvo0soR9gZWtW9q29mEkxa+a
	 Rd+llXhJlm+D4UzPhb3D6m5J1C9aM82ifB+mjGtuyxq+FdTd57KzixEzpc51kE9vSQlrg
	 f6dPRBPMB22Rmlljxi3yM7t9iev2PR83/Be0wlzd6CXC2oiGRhL6ua+IkHCiynQOiHDMx
	 F99DMOzeiUikBNGHeCnLCSRXf1y9V08eGzckeGDF9Cva3QV0o9rpk5PkttPfhfkgl0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630386;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dxMh1IMUfSgGZxrDJrCbREMQWNNuqvA9kejvZguz8J0=;
	b=sxBwDIF5fb+5lJNqvB46I58lfvzITs11jp5RoTJ7JbTiPp1+UTV/4Wp0uZq8hkYU73ET
	 hcUT5K0b4wMFAagZ0nKy+lwPsjZ887sPieo8o7vFeKIF4lzlHaILi/7sosH3r50Bbil9y
	 cnNaLPDnUxZtK/DdD+Tnpi/yNNnwjqEmiX73YAbCyKl9iBPSFZ+e4oqHzGz3MIsEoRt5q
	 Ov34Ukq3d2lFezU824zIUXJ6Ks5MZK+zRzMLXd1ftlU5nrRClglxhgcHw7Eet/lRz+M8j
	 p4xLZEpPa58EthFbJjq/7R9onNc2Z1ODIkr9/6djvkoQrB3IWvwvKj08zDSil3Tx68g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3+z8U12;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938860A260E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3+z8U12
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309141F01805;
	Wed, 25 Nov 2026 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630385;
	bh=dxMh1IMUfSgGZxrDJrCbREMQWNNuqvA9kejvZguz8J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3+z8U12+vF2ynqWRKw1mnnl01whsJr83OusdGJLrZbstwtmOFeDRUdiixQJNoh+r
	 rbXIDoevMOcZdkFmwTkXPCm5KGFBmCi6iEUXtUf4xyXzrQmRX7oS6gEkMVi9xIOuxF
	 /kGiWsVeHMDkR53ODGYnXS1gITj99ZSj8P2dgwsM7ksAA8DZva8OImvUtvWGYoeReg
	 kVgQjsBYNcfNG36dm6u7Layq3Hhzfo97u90/sJizwKzQU4tDdE2oAZ085m3SUHjTEc
	 8iHdyN5Lh4WQB7SndfSDZGyvdUUKQoBgH3BhS3aP27agRZ62KmRsUZftQERW2dQ6m8
	 F3yMwEBInkIjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/7] s390/dasd: increase printing of debug data payload
Date: Wed, 25 Nov 2026 13:12:57 -0500
Message-ID: <20261125181227.1137399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112516-snowbound-attentive-b141@gregkh>
References: <2026112516-snowbound-attentive-b141@gregkh>
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

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit b49e648fcca7e420c4ad670a548e19f0e8531c30 ]

32 byte are to less for important data from prefix or
other commands.
Print up to 128 byte data. This is enough for the largest
CCW data we have.

Since printk can only print up to 1024 byte at once, print the
different parts of the CCW dumps separately.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20221123160719.3002694-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 25cdc1f63227 ("s390/dasd: Re-initialize RCD buffer with "V1.0" before every start")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index a209ef79bb043..62f06ade2de1b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -5541,7 +5541,7 @@ dasd_eckd_ioctl(struct dasd_block *block, unsigned int cmd, void __user *argp)
  * Dump the range of CCWs into 'page' buffer
  * and return number of printed chars.
  */
-static int
+static void
 dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 {
 	int len, count;
@@ -5559,16 +5559,21 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 		else
 			datap = (char *) ((addr_t) from->cda);
 
-		/* dump data (max 32 bytes) */
-		for (count = 0; count < from->count && count < 32; count++) {
-			if (count % 8 == 0) len += sprintf(page + len, " ");
-			if (count % 4 == 0) len += sprintf(page + len, " ");
+		/* dump data (max 128 bytes) */
+		for (count = 0; count < from->count && count < 128; count++) {
+			if (count % 32 == 0)
+				len += sprintf(page + len, "\n");
+			if (count % 8 == 0)
+				len += sprintf(page + len, " ");
+			if (count % 4 == 0)
+				len += sprintf(page + len, " ");
 			len += sprintf(page + len, "%02x", datap[count]);
 		}
 		len += sprintf(page + len, "\n");
 		from++;
 	}
-	return len;
+	if (len > 0)
+		printk(KERN_ERR "%s", page);
 }
 
 static void
@@ -5660,37 +5665,33 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 	if (req) {
 		/* req == NULL for unsolicited interrupts */
 		/* dump the Channel Program (max 140 Bytes per line) */
-		/* Count CCW and print first CCWs (maximum 1024 % 140 = 7) */
+		/* Count CCW and print first CCWs (maximum 7) */
 		first = req->cpaddr;
 		for (last = first; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
 		to = min(first + 6, last);
-		len = sprintf(page, PRINTK_HEADER
-			      " Related CP in req: %p\n", req);
-		dasd_eckd_dump_ccw_range(first, to, page + len);
-		printk(KERN_ERR "%s", page);
+		printk(KERN_ERR PRINTK_HEADER " Related CP in req: %p\n", req);
+		dasd_eckd_dump_ccw_range(first, to, page);
 
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
-		len = 0;
 		from = ++to;
 		fail = (struct ccw1 *)(addr_t)
 				irb->scsw.cmd.cpa; /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
-			len += sprintf(page, PRINTK_HEADER "......\n");
+			printk(KERN_ERR PRINTK_HEADER "......\n");
 		}
 		to = min(fail + 1, last);
-		len += dasd_eckd_dump_ccw_range(from, to, page + len);
+		dasd_eckd_dump_ccw_range(from, to, page + len);
 
 		/* print last CCWs (maximum 2) */
+		len = 0;
 		from = max(from, ++to);
 		if (from < last - 1) {
 			from = last - 1;     /* there is a gap - print header */
-			len += sprintf(page + len, PRINTK_HEADER "......\n");
+			printk(KERN_ERR PRINTK_HEADER "......\n");
 		}
-		len += dasd_eckd_dump_ccw_range(from, last, page + len);
-		if (len > 0)
-			printk(KERN_ERR "%s", page);
+		dasd_eckd_dump_ccw_range(from, last, page + len);
 	}
 	free_page((unsigned long) page);
 }
-- 
2.53.0

