Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956846;
	b=gPTCKb1AbA2x4BHzqwjOZ0WfUfkNY/yKF29w+LKrCXtrvPZf6njVO9rf37LMWtTfBWDu
	 zHyTQeeeg77ZmWcge8m/HNYuRpv7eg0iFghgWA1XWb8nmy1L4w0bkpHVfd4BkhEo+otW0
	 wuXoCiQ+1SwrWr3I46F8IaZBZ1sgIgzopbeyRhauN8swsr8Hz82tOjKdCzMzoaIqx51pD
	 kfbGUEMMQCs8ID5lK8uojb9B60w30YjVjlbPKOFdzRH98ikWBz66LnVMPAEy6nJzj0xPN
	 XRpFPt9xvEvj0u+NZhHjBQ0LqyPJxQ9HofamBrVgqDJuqa69PdPN1KjRTq+VMDnDhxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956846;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zVZn/PHtKTXfIDqjN5+GVy65SE+it2qO3RfBBuitjt8=;
	b=EtsXBBVGP+djA4ekbclWnQuQ/qAlrf8RwocxlAkHt+TFFyHVJLEdDZhpcjUxH1ijNkB0
	 HdJ+ElPJh4qaX2QgKo/VhqfwIKt5N0VFj1qToaicB1i4cQGZp1Ef/UL5lfYwsToI94uMG
	 vhTdYcQK/ufraICkcq71KK6AgRPegBQK2qRkDMVupfkreyXxQWeQ/Myqt+j3MZ1NHMUZ6
	 T7mNecgcZAmZZKv6YcyTUaXKYKNzV5ClQboWkvy5dVeEnNnRdRDq+kD7fNqpJ3hYwWkrc
	 4D/PzAHvuxWhEvulsHbCsPNjrzNgTlzdswh8BCibDxMHDuEwAyzCHX8cL/K4SvoXIbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IKN2FFnQ;
	arc=none smtp.remote-ip=115.124.28.74
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE4606A328;
	Fri,  6 Nov 2026 09:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CBE4606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=IKN2FFnQ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793956834; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zVZn/PHtKTXfIDqjN5+GVy65SE+it2qO3RfBBuitjt8=;
	b=IKN2FFnQyHTTepagSBuuK3wH/x2GAwUPeXHFO75TYtkqyTRQCtLpcYpxPRvG5cDbJMOQfZOXX6H7nbC3B27oApZg0sJxiHxOVESfTHFeeM5oyexmDCoXsnat7y1zFY01pS0xeeEMtO/pzdfcMymlAZZuYIfiR1XcQkrdvGMwUVY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08651333|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.01135-0.00149655-0.987153;FP=5149363861963095640|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023087102;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jyFCtSG_1793956833;
Received: from localhost(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jyFCtSG_1793956833 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 17:20:34 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Ard Biesheuvel <ardb@kernel.org>,
	Matthew Garrett <matthewgarrett@google.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] tpm: efi: reject a final events table with an oversized preboot log
Date: Fri,  6 Nov 2026 17:20:33 +0800
Message-ID: <20261106092033.4041125-1-guozh23@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <73a5f412-0962-400d-9e80-5b9eef92bb8e@app.fastmail.com>
References: <73a5f412-0962-400d-9e80-5b9eef92bb8e@app.fastmail.com>
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
events log instead of appending from it. Warn before dropping it, so
a malformed firmware table leaves a trace instead of a silently
missing final events log.

Fixes: 166a2809d65b ("tpm: Don't duplicate events from the final event log in the TCG2 log")
Cc: stable@vger.kernel.org
Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>
---

v2: Add a pr_warn() before dropping the final events log, as suggested
by Ard Biesheuvel, so a malformed firmware table leaves a trace.

 drivers/char/tpm/eventlog/efi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
index 4e9d7c2bf32e..76860f9a25de 100644
--- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -82,6 +82,13 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 		goto out;
 	}
 
+	if (log_tbl->final_events_preboot_size > final_events_log_size) {
+		pr_warn("UEFI TPM final events table has an oversized preboot log: %u > %d\n",
+			log_tbl->final_events_preboot_size,
+			final_events_log_size);
+		goto out;
+	}
+
 	/*
 	 * The 'final events log' size excludes the 'final events preboot log'
 	 * at its beginning.
-- 
2.50.1

