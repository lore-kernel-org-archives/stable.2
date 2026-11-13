Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592591;
	b=hYWMI+0H1QQUVg33o0B9ZeTVtuOsGrEVibLcr3PqrmFOZEFLQrBU73DPivV39ZNh+G8J
	 BWLLVezePu0+6YRamzM0CKd/BIRAFzOjqVAQOe6GaQIKCiAk9BoxIITrrOobu+kn0mgCT
	 gjkwHMBJNbI7GUYQoDKDxxnkD0mDeA1JRiTIJZqpEmoDG/qYhDSxFkS+VcP6slrMzgk3M
	 x1+Aksg9s+8T9FNZbDHO5kAUzamdxsElyk66ZsdRCgPH8026lYG3RcxtfG9LMqD/tsenW
	 ObIXWGg+Gtu4/3B+sUK/K4XLdq4sF698U0Z4gjToZRlJMTBzV4JJO7Spaz2gQ0pWVlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592591;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Ww3xBEc/Ftu34wF7fEI4ZgMgSExTshcrTMxN7NwKrkE=;
	b=O8EfB+gP+7Faf+yDlGVYV0wfmChJF0xa+VouqmWFwS/DVHYxNHRtJQSW606ctkiL10JF
	 hZqOVEBG24W9oNkD9Hsv6gUCV69EePWWmZmKmsCiHSkLaWvlrWOOlKVGEDd7mrNZbVCSs
	 O4WBPYaj067tuK2RgPguDRXPHNovC0bCdQ1b6m7d3cdXT/QhwNlgBjq6deJWVidyr/hW5
	 Z5Lv5S5gL5LtLM8CGGFLK8d3aHqm9NlOiWZeap16EvkHedBu9g9oJbqLBNYCIYptanlvp
	 28XBpxnppWXZQQw0P6RpXqjAZUadkXsPmftYurzgZNjSJrq4H+OLGXFbnN60Ea9cqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=yH9VYALO;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5603606A8A7;
	Fri, 13 Nov 2026 17:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5603606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=yH9VYALO
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4gv5fryz51Sp3;
	Sat, 14 Nov 2026 01:56:27 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592587;
	bh=tEe6hs4dQKTYrvtjgxxzfXbOnfFabk7Yn4dXeTEv48c=;
	h=Date:From:To:Cc:Subject;
	b=yH9VYALOP6nMkOE+HnFnCko7wMVSRKnuERL0DBUr32J1Jv2hee/+IlS95NJn18ER8
	 H1ImxlKZSRBYxAKBmAeqK70fFrAm7GKXs8Jyl0/2MLVPafNdk9WfC7dp5DVJ8l09lA
	 QsrkdE+PXvUqKdzVywJWZpxCo/Ts5ouiOiVgQylyiLueobAdcNpgAHzdjSjML45LYt
	 WmtvGKsHw1WcecTZwJivO2QuZBXi8RBFzSqqsAx3aNhVDXfSBkqmbSLSCMxdjqS8DW
	 XY2H1qpZnKzGaAbNjgvHZOmukSbNBXNeaDmlcbbzpRG/GDWp0xAo7D7JtjVDxmw56Y
	 YHFxuobgg5ecg==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6ADHuIKW067205;
	Sat, 14 Nov 2026 01:56:18 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 01:56:22 +0800 (CST)
X-Zmail-TransId: 2afb6af74f460e6-1402d
X-Mailer: Zmail v1.0
Message-ID: <20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn>
Date: Sat, 14 Nov 2026 01:56:22 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCB2NCAwLzRdIGF0YTogbGliYXRhLXNjc2k6IGZpeCBBVEEgUEFTUy1USFJPVUdIKDMyKSBoYW5kbGluZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADHuIKW067205
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 01:56:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF74F4B.002/4jR4gv5fryz51Sp3

ATA PASS-THROUGH(32) still has translation and completion paths that
interpret fields as if the command used a 12- or 16-byte CDB.

Patch 1 checks the reserved bits in byte 10, skips the nonexistent
MULTIPLE_COUNT field, and corrects the invalid-PROTOCOL field pointer.
Patch 2 rejects unsupported service actions with sense data. Patch 3
honors CK_COND and generates SAT sense on completion. Patch 4 corrects
the remaining field pointers, including READ/WRITE LONG count errors.
The four patches can be applied independently.

This resend only repairs the transport of patch 2/4: the final context
line was dropped by the sending client, so git apply reported a corrupt
patch. The diff content is unchanged. All four patches now end with the
format-patch signature, which keeps the blank context line in place.
Sorry for the noise.

The previous thread is
https://lore.kernel.org/all/20261114014754440R7cZjW-DgggyExZ9u5t_q@zte.com.cn/

Changes in v4:
- Patch 1: follow Niklas's correction to validate byte 10 bits 7:5
  with fp=10, leave CONTROL out of the count checks, and retain
  READ/WRITE MULTIPLE support. Correct the comment and description.
  Split the warning after dev, per Damien's nit. Extend the function
  tests to cross CONTROL values and byte-10 reserved bits.
- Patches 2-4: code and commit messages unchanged; retain Damien's
  Reviewed-by tags. Patch 1 needs review again after its behavior change.
Previous version: https://lore.kernel.org/all/20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn/

Codex assisted with the review changes, descriptions and validation
scripts. The updated code was function-tested and build-tested.

Shao Mingyin (4):
  ata: libata-scsi: reject reserved bits in 32-byte passthru
  ata: libata-scsi: reject unsupported ATA-32 service actions
  ata: libata-scsi: generate SAT sense data for ATA PASS-THROUGH(32)
  ata: libata-scsi: fix remaining passthru field pointers

 drivers/ata/libata-scsi.c | 70 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 20 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
