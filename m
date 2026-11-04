Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806043;
	b=v4QWYjvTufSTFaZ2YOVzWZzMVWGhLd93Z7kblrKMTMIc96sUzt3eMbpPPktgRxvr4pbi
	 TMus+qvE8A/ecoyehqx5ZFU5jSAgEKFAaIz4Ae+CNUj58eSoslIKfYkh5MFz9QPTrM+WX
	 PQjR+BW1l9PN194hNCMEMdAI+KLkbE2eXnKxbVU/3t5RC2//kHoMF9CVEL+/BuHpxPg4w
	 XowBuJn4kiZZvuvL0QosRK4xOPXNQxmWE1edNTrg3GMN9H8fRfp3qepaoF6IrMhBoCTrg
	 R33eD4oytjvttO6wBldL9oivh/w9ahFo4uXJdLb4vu3ggmHC8YXx5EfBr46EpZf/H/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806043;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SHiodlaN/47Q9sQElac/FcGmKIxlHSOhqHHn7r3qETE=;
	b=HyHmF27qcES01i0okrNUs+xoPdHSyqY8q+iQKJqyVnXmChkuPeWV59Y5d4S7/wYl++zS
	 HllGWq+7uvioVEJnuJt2EwAd/OxqmoblEZpZU4EgtoqVtiWFP/5Q8WnbE28ukxF/IwW8Y
	 AktGUUA7alaunjAzel9kL0OMOUWgBXO5d64whoGYxaZvCUhTHz+A1xj5bNgkJ/vcVaITt
	 axmPVhJbddjOxNjnuOAfNpNnJh/Br+65oTJXMP98PqnW+jFygM4KR59YFHSuegVeEfvNJ
	 6ps9SYSxiGwXJFOzOx4dm/3BzXzasOLVlXxNDYxmCV/9N6+lmaXfD9NaMvXu9/RBwYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b="I9KYYC/e";
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06FE606A33D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B06FE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=I9KYYC/e
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2E364240106
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793806039;
	bh=SHiodlaN/47Q9sQElac/FcGmKIxlHSOhqHHn7r3qETE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=I9KYYC/e+KLAWDoaHEhgolVvi1RNgS3YAtdQC1WfLWpWwGGVnGU0c2hYOiR/F3zUh
	 c6wNGyd1wRwKpM0m9UKXbwbk77qsbe6Y3oeWs4fhQu3r7PkWn1Zt5TvljjXmKT9B3L
	 E5mMDG6V41ORNoxGI+1NelvQ2ciXpdj4QyU7T/V2Xr1am7iMQl2TjfYNzcXHotOe+v
	 m3Zi8U7TMlGuSKJvr7G8PATKXSWubrPD0HT9dkgORmbY++ozHnYhpHh++TAOF0Zv4W
	 SrI/w9jp2u6VV8FUxirkB9wr146WqFAohsjQkPPc+uDhnO/iL3mh16IFb6rzU59hNT
	 sKeTXVvEIn+ng==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKTnw7557z9rxV;
	Wed,  4 Nov 2026 16:27:16 +0100 (CET)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linusw@kernel.org>,
	Yann Gautier <yann.gautier@foss.st.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] mmc: mmci: do not count a data CRC error as a complete transfer
Date: Wed, 04 Nov 2026 15:27:18 +0000
Message-ID: <20261104152657.14909-2-mateusz.nowicki@posteo.net>
In-Reply-To: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
References: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
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

With datacnt_useless (STM32 variants) success is 0 on a data error and
a CRC error subtracts one from it. bytes_xfered becomes 0xfffffe00 and
mmc_blk completes the whole request as successful, although the
controller stopped at the failing block. Reads return stale data and
writes are lost without any error.

Tested on the STM32MP257F-DK eMMC in HS200 with a forced bad tuning:
without this change 5 of 14 reads returned zeros, with it all 10 reads
were correct.

Fixes: b79220b3e0af ("mmc: mmci: add variant property to not read datacnt")
Cc: stable@vger.kernel.org
Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
 drivers/mmc/host/mmci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 416bdb184ed4..10eb0439fc52 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1422,8 +1422,9 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ, status 0x%08x at 0x%08x\n",
 			status_err, success);
 		if (status_err & MCI_DATACRCFAIL) {
-			/* Last block was not successful */
-			success -= 1;
+			/* Last block was not successful, nothing counted when DATACNT is useless */
+			if (success)
+				success -= 1;
 			data->error = -EILSEQ;
 		} else if (status_err & MCI_DATATIMEOUT) {
 			data->error = -ETIMEDOUT;
-- 
2.56.0

