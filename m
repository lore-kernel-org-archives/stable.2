Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929801;
	b=txrhQ4l6rlRPX7LXTUdEwW0HFf9//qebivMQU572bBW1CiKQAt8ebIwhzPIWnOFQClpq
	 dMuqzSW4FLWucINv7GElaCnN/x6XI69supSyjCz40hWpfJp8GEMGIghedXilbv6/TO7xT
	 iQck7yPb4d2EdTHHl/69GCswUK4qDaV43dxCFy/kC3aw5bE+Pfm9wZS4/HG29Gcaby4+8
	 oD44BOWe0fAr2wAIqqjhoXHVdaZ6YtGe82b93EpaswiB2x5H/cxuicqy6MdzV0P8bx7YL
	 yPyWF9SlrffovF8SG2/8ku+Z7Lws0DpsztsdzmfDbZFvLaKr5q5Ko6Q95moBoAszX9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929801;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H/qHA7rf1ZTV4JhcQgLtjZuWs62/Xe7VfiFZAPYroDI=;
	b=DOPDTWLDxvlIDdyfqWkOHnQRZ4fH39y7oYScW6vQdrRvi8t0gZu2fqsAjlnJOtUBZrkT
	 TArx3svd0fJWKW3Ev83VVJ+hv1KHXDpel79tjYY6DQJxCsqLH4kCangwQQB3txT943DDd
	 xqcbEx2CkvxMJPD1DwlspoqVUki8pSgu2TrvXlt5RcabK5+tkfb5GDPvkd8at+nc/mlyE
	 aOViVX5h0x9/LheVdtqrfDjx6xNwZ70ADqi/kTn5ho3KE7svo8pJ5ERkBhU/5WzsDEQyf
	 GF5rmBLqUf+99m4+nGTGen52ovjrN1ktqKCubmwhOz8iV7uzKmjj94SK10zDpHGAnZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DkAmca34;
	arc=none smtp.remote-ip=115.124.28.124
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96230606A33E;
	Fri,  6 Nov 2026 01:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96230606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DkAmca34
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793929797; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H/qHA7rf1ZTV4JhcQgLtjZuWs62/Xe7VfiFZAPYroDI=;
	b=DkAmca34STALPhCNhEYOM8JIIM2PCgV1AxRP7G9AnUkWqfPbxlpTe7nshwGvosiWvDac5XIfyUXzxsUplkr14+HRViy/G26UL1BSwL1fzOvkgz3AwR0BkOHHW3nqRU6l6FShVuJyHlfTuM1WYpI6Q0WkxhFB5MBR0ZKoq9aKb6I=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08443414|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00732284-0.00217209-0.990505;FP=16678578770593529432|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jxwwjNJ_1793929796;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jxwwjNJ_1793929796 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 09:49:57 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Ard Biesheuvel <ardb@kernel.org>,
	Matthew Garrett <matthewgarrett@google.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tpm: efi: reject a final events table with an oversized preboot log
Date: Fri,  6 Nov 2026 09:49:56 +0800
Message-ID: <20261106014956.4129904-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
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

The preboot portion recorded in the main event log is subtracted from
the size of the final events table taken from the firmware:

	/*
	 * The 'final events log' size excludes the 'final events preboot log'
	 * at its beginning.
	 */
	final_events_log_size -= log_tbl->final_events_preboot_size;

Both sizes come from EFI configuration tables and are not validated
against each other. A final events table claiming a preboot portion
larger than the table itself makes final_events_log_size go negative:
the subsequent devm_krealloc() can then end up with a wrapped, too
small allocation, and the memcpy() that appends the final events log
uses the negative value as its length, running far past the buffer.

The boot path has no way to fix up such a table, so fail the final
events log instead of appending from it.

Fixes: 166a2809d65b ("tpm: Don't duplicate events from the final event log in the TCG2 log")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---
 drivers/char/tpm/eventlog/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 4e9d7c2bf..0a8006f3e 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -82,6 +82,9 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 		goto out;
 	}
 
+	if (log_tbl->final_events_preboot_size > final_events_log_size)
+		goto out;
+
 	/*
 	 * The 'final events log' size excludes the 'final events preboot log'
 	 * at its beginning.
-- 
2.50.1

