Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711692;
	b=moDECWDqwXV/G25e8TzckQDBDInpTa5jHTjKKGtSe9UHqhXwg6uOiBrjJLQhKci6HjCu
	 e5GNa9I1CitQvS483gh6XcpWrYYft4OPwYw9Li0b2dqCFk3WrokM7UecoM0pgVh6crBAQ
	 BgJbOxduDwUDyBw24Cs0RHPVKczkl77aTeJgl+uM0a1cNSfUuocoltvo0AP7rRgcs3sU6
	 jpoSUDj5Cx5ZeQ//m+hZJz5V7L52BavIh2pwjnoS52rddXalR0TpMoAuKqWjg2YEuHFl8
	 SOOZm1w1mNYVE+almUN5+4XDfFT9Gh2EtwiER9ehL5O4EMXyT9NGGe+o76mLHU4B4vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/DdO+c8hhRiuk32rYy7zj2DQMaJ9+qPKp2MrlWUvMn4=;
	b=zIwgGemPmOrZfbh3xkC+/rGdQStBL4VDnEiEdXWpIlgaKS+U+Y60fhXIQbhSzR8J7hdJ
	 +dGRx0AvYMpvg2AqmhDmF8JXdGUrnoKFlYxGL1MYQ8FLDDYAIxHkhqoH0q0PWNcocxlQt
	 4crvjK6fGQgUhJeLbEnB4VpVAtAbsQERzTkZBVhZbZLegJDStwOcocypyc6hpEZStnHKr
	 vxbxUldFpYydQiuQi4DzOmoSVvGmgQSC888LpXhm7MpD5FJ7ilWccoi7Pu/uvMfmvtxXs
	 0wF4l/wkjZfaOLZnlinYvg3PA19WUeiFyijJCF43PFDjnJ0vSvYfPH0PP71ZEj/8zyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=viVoHylw;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95204606A331
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95204606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=viVoHylw
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so7738387eec.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793711691; x=1794316491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/DdO+c8hhRiuk32rYy7zj2DQMaJ9+qPKp2MrlWUvMn4=;
        b=viVoHylw3O2xFHrqITHTuVW143bD5XvorRJEgsNje3zvK778fq/JxiCAd0hYnQSmqK
         cR9EDjemET3qN4azii+Cuk4YhfXECn+TXjGbPug1c2iObS7GKW6p8sHPMs8m+zcp/4wx
         ndrdxflaa266irios+ucQKW4NSEhRJIaQ0dM/RDT+UjjziuDK8iNygd4SouqNNSki3Du
         hwM5Z/OzPrRyG6JxKvq0qgUgESFKehUTkliaA4Kc8taBqCu4ttdXPKVA1KQ7P7nB5/hG
         MYsNmBviZ9Jzzz6BBsPxlVs355pApxDzgadbKPJPWbKkve6pteZPTIQe6k8mBOyVmPuH
         9y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711691; x=1794316491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DdO+c8hhRiuk32rYy7zj2DQMaJ9+qPKp2MrlWUvMn4=;
        b=JJ6qJb4kjPN1zlv8flZKWJMDBxQlVQbU9rbM6/VMmDrfTkvVGX13oT0Z0ftjUYCJK9
         IEJe239kLdl8QUYzz/OYg+ywrf40NJUKohgbPUAoFeKpmFEfTxksaxE0l9vtLV4DdLCN
         O9OE18M2MgcM9i34r8NUpGm/zI2tD0oI3ZCk1Wg7ilWvkauDJD0de8TjxGUCzVIjOnGH
         lA4fNw+eMSGW/5fmZMXjWmA0cui2tRlKCbaptVUG+Pc+z58IFnwT73RgHurEX4Kmiy1C
         3m0JKlY7aGA0C+tjaXXXFnO7kHtrHO2bIl3NOfrdF8qQjVGQ4mvymKxRp7fjlNA1rArH
         oRdg==
X-Forwarded-Encrypted: i=1; AKwUvBwSOZi5IDSxh+8RzhW6GnLM2hjtNLtJETu9gFY11QjfrW5+XXDa3R3Rm7J5Xb6QDTrwO+xiPO8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4P4vXW/aO673oDdBON94kXJBooUUA8r9Zh9xOUUkSmkVr4Edb
	UpkE45W7tejD5V55ebKYvZZsya/s/PIrponpMvaiQmlLpjG//btT0hAS
X-Gm-Gg: AYBFou0JZi1KjaHVYy44kT5wA0WpSuhVxfnvBbJE4RvYqzNtzZfAiMGRWrnA4tIRPrU
	a7qdEhT31cIxXAbJpRrSfWrTahLwmWDGKDk1Aal6GkOvDukcjUxapRZJ8i/kg5YfzMq01oqKn72
	qg13Am2PkKwtrSq5POdZQPamblONdcW5uhViXkmq3LK8K6MDyeCUcQS5tRdcDkOfWovTejv+rGw
	usSNw5UiFCSg18I08A5+Z8NVMWznHfcL03z6VqdnxmERYEEQTm94T54fdk+jgAWP/h52Cd8UIbD
	3DaKVC/OLxxlHeRrrcPCCJ0ACkjsbW7jTge9YNWyQcaRSS65c5cM29Cy0zmjToZcM6ashVb1x3y
	PmhH6mDDBxhxWbfNOLyPEXsRnGeVbP46VjcrTIvzWUamaS37huZh02OTqOE6wiQjyQBKqOU5Zdq
	FwK+Qp0rAhrdoC5e7TK05cbL55YLsONXGCgYdZ6wH5Mr3o1AiD3qC0tJovFZK9mM6IcQIsK0lds
	zT5APFPJW3Nok8c4StUzewu2dT8yWoA4fV2KsygDOD6LAEhuh/UqKVDEk/ejZPQq+3Gvni+NrIF
	lqUEJPN5q8BdGnrANTXzoT8hwMF3iU9cGgaJp7TTYW027vJGnjuLm29eoenxx8nHKQ==
X-Received: by 2002:a05:7301:db8a:b0:36a:279:c93f with SMTP id 5a478bee46e88-36a423fda77mr19551196eec.33.1793711690526;
        Tue, 03 Nov 2026 05:14:50 -0800 (PST)
Received: from arpith-debian ([2402:3a80:40d:48cf:34b0:c816:2853:c60c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm55335792eec.22.2026.11.03.05.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:14:48 -0800 (PST)
From: Arpith Alexander <arpith99@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arpith Alexander <arpith99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: ljca: Don't require data in write replies
Date: Tue,  3 Nov 2026 18:44:35 +0530
Message-ID: <20261103131435.21838-1-arpith99@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Commit 0fe4573c822c ("spi: ljca: validate the response length before
copying the data") made ljca_spi_read_write() reject any response whose
payload, as announced by r_packet->len, is not contained in the data
received.

That is right for reads, but the adapter acknowledges a write with only
the packet header: r_packet->len holds the number of bytes written and
no payload follows. The reply is 2 bytes long, so
"ret < sizeof(*r_packet) + r_packet->len" is true and every write fails
with -EIO.

Where the Intel Visual Sensing Controller (IVSC) is connected through
the LJCA, as on the Dell XPS 13 9340, its initialisation fails and the
camera behind it is lost:

  spi_ljca usb_ljca.ljca-spi.0: transfer failed len: 256
  vsc-tp spi-INTC10D0:00: SPI transfer failed: -5
  intel_vsc intel_vsc: error -ENODEV: init hw failed

Only require the payload to be present when there is a receive buffer
to copy it into. Write acks are still checked for a non-zero length that
does not exceed the request.

Fixes: 0fe4573c822c ("spi: ljca: validate the response length before copying the data")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Arpith Alexander <arpith99@gmail.com>
---
Tested on a Dell XPS 13 9340: with this applied the IVSC initialises
again and the camera works.

0fe4573c822c is tagged for stable but has not been backported yet, so
it would be good to get this in before it is.

 drivers/spi/spi-ljca.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ljca.c b/drivers/spi/spi-ljca.c
index 8fd001610f67..b1babd43adda 100644
--- a/drivers/spi/spi-ljca.c
+++ b/drivers/spi/spi-ljca.c
@@ -109,8 +109,9 @@ static int ljca_spi_read_write(struct ljca_spi_dev *ljca_spi, const u8 *w_data,
 	if (ret < sizeof(*r_packet))
 		return -EIO;
 
-	if (!r_packet->len || ret < sizeof(*r_packet) + r_packet->len ||
-	    r_packet->len > len)
+	/* write acks carry no payload */
+	if (!r_packet->len || r_packet->len > len ||
+	    (r_data && ret < sizeof(*r_packet) + r_packet->len))
 		return -EIO;
 
 	if (r_data)

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.55.0

