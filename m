Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407504;
	b=f1mxRiic/Csip9FQ2GjO2BqA7bE3kYgwpNZRl0R/0izhlG5VZN6vzkwwjtaxJA5Ws73w
	 UH8di1mf/eeGyjsJH0aLr27EWS8Ex8DavhUKT4KyOa6h5nONFI2h5Gt+6sRWTzNPfBjeE
	 nadO1wDVgNjMd1x/+F2Bel6jBPBdWJcMTCr1m7nTf0nW1EXLLoLjtoKV4y0LuDkZ4OzoM
	 b35u2nYZwur/1mORTE5vuzM3SS638W3q1WwwQUtTQnA6+ucfl+j6tVk0+JQa2nG056hqO
	 TQKEJRsMM8IvnH4dc/jOa7SKXoE9wD7SN4ELVFuqH53c6dcb6bc3JylHUJZRkg59QZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407504;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=k3GqkpF5iyUVctU1/1Wg6hNtTxm+pAZ/Y9JlWm0GLxg=;
	b=09obibkfxfEIyhcJiFfZlnB+ZJMdNpQXTbmCT3HdFoOoRLYvb/Lpk9lzDVHs0ipOj9E0
	 6BiybolcEd0VSRPaWAuQ8X8eM1ghiMmJwOo3+G72YP5ypLGOnn6WZNGmmCYwXpiF4o3x+
	 TCG4Ler3WjaIvX5gIqEGwZHZ6BTbJMfSvK44QCAwXCx7YXbd3M865PrT9rgi9eP6YdXqk
	 A5Fa2Bq+w2OAjCBSkyaSRKLHu4uNDfLVWyzNbPCC2ldQK0bREBA3h+ONOeDdvt0G2HPTc
	 a/QEGLvJDeA7+KJ18kMEhqaLLcWK3+RGG3L841EN+lAyvBaAFTqjF/lZE6p8ABF8fhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=zmdJUOVO;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E860A380D;
	Wed, 11 Nov 2026 14:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 048E860A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=zmdJUOVO
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmDS6SDWz8XrrJ;
	Wed, 11 Nov 2026 22:31:36 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794407496;
	bh=/6ujqmY3stzuOcN3MfIOUSRPKNj3+BNN/I2B02iF5gQ=;
	h=Date:From:To:Cc:Subject;
	b=zmdJUOVOlLLLlQfz+4BwPmSgJHW2sqTr/KcB7EgpC1GoKH71Jg0Yv8b8gFDjPgXXG
	 92t+XrVAlB+JcZBZQI9qQHrkmjBY44eFmhRbj3av81QQEfTENLpeDQQF+1ZvfMZRJH
	 Cp39m8G20OwfC5jr7iHeYKCEUcMr3DLBNVjVVM2ixQ+DGvDoGDXWK2jdEpZbDpBVgV
	 qvQriZCJ1hBvvvzwEZmnbLiFaYqgXJJ1a7Ae63BRTZiUIoxDLlvnx7uukKUFA2nBml
	 g4eXpNp4aG8FhqsuQydd3OGhSHMj9MjhsQXqwjsBfmxC6n/m9PyHoy/esKNIgc0FEL
	 hl7jfL/lPtLog==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ABEVLwZ088953;
	Wed, 11 Nov 2026 22:31:21 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:31:23 +0800 (CST)
X-Zmail-TransId: 2afb6af47c3bb0f-53a08
X-Mailer: Zmail v1.0
Message-ID: <20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn>
Date: Wed, 11 Nov 2026 22:31:23 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvNF0gYXRhOiBsaWJhdGEtc2NzaTogZml4IEFUQSBQQVNTLVRIUk9VR0goMzIpIGhhbmRsaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEVLwZ088953
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:31:36 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47C48.000/4jPmDS6SDWz8XrrJ

ATA PASS-THROUGH(32) still has translation and completion paths that
interpret fields as if the command used a 12- or 16-byte CDB.

Patch 1 skips the nonexistent MULTIPLE_COUNT field and corrects the
invalid-PROTOCOL field pointer. Patch 2 rejects unsupported service
actions with sense data. Patch 3 honors CK_COND and generates SAT sense
on completion. Patch 4 corrects the remaining invalid-field pointers,
including distinguishing READ/WRITE LONG protocol and count errors.
The four patches can be applied independently; the numbered order groups
the related translation fixes together.

Changes in v2, following Niklas Cassel's review:
- Do not interpret byte 10 bits 7:5 as MULTIPLE_COUNT. Skip the CDB
  count checks for the 32-byte form, keeping the device-mode check.
- Move the unrelated invalid-PROTOCOL hunk from patch 3 to patch 1.
- Keep patch 2's code unchanged and add patch 4 for the remaining
  PROTOCOL, FEATURES, COMMAND and sector-count field pointers.
- Generate all diffs and indexes from Git commits. Validate the exact
  resulting blobs and include observed field-pointer helper arguments
  from userspace function tests in the per-patch notes.
- Keep the Reviewed-by tags on patches 2 and 3: patch 2 is unchanged,
  and patch 3 only loses the hunk moved to patch 1. Patch 1 changes the
  MULTIPLE_COUNT handling itself, so its v1 tag does not apply.
Link to v1: https://lore.kernel.org/all/20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn/
Review: https://lore.kernel.org/all/avI7-lrzsRL_Gz75@ryzen/

Shao Mingyin (4):
  ata: libata-scsi: skip MULTIPLE_COUNT for 32-byte passthru
  ata: libata-scsi: reject unsupported ATA-32 service actions
  ata: libata-scsi: generate SAT sense data for ATA PASS-THROUGH(32)
  ata: libata-scsi: fix remaining passthru field pointers

 drivers/ata/libata-scsi.c | 64 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 20 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
