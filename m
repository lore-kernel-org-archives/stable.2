Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492085;
	b=eev8s+0yZyLR3NcEfkewzuWKDapL4auoRpqwtvel5G8Pxd955+9TgF1e6rCr72MekcXf
	 5mnvqGsCrIJgl8MsYU4A9gfynuubRHg6cp0BAXmVDh9BkQ9DwWp51CsycWVlHi8R8QjTo
	 6fSH/pWNGk2vhLY8d2q4uKZPjarnjrTycvu2ogCybKcsKTynM0C8LQOb4gp3aK+vXjxGy
	 H+q9P3vikeaQHhEsurmrGgc6gfleuwR9GEqKVmdz7ZcbKddD5+MunWSRA+VzdObBjPtP+
	 E1FOVcUrcYA8/InUxWAk7Ga2HolYhvweK6U9p/8I9Cuy0FL0EGVYI718I544xXJDPDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492085;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=LOCwwsQ3nFCCuQn+92JBgFqZgHp6qjYKUsnX5/E4g/c=;
	b=xk7Fm1XoXqQsQUNZKXxb4tX4+XVVqkKRdj/R2Zn22obVA/KEheCNJ8cITqplBv/sJzjU
	 vKVz4che6jGiO7dl8ROChJGxp7FAPjxVqU4s0G+zFISimpS0f8fyv7eQzfzOLSMSjWA+x
	 J78++IsGsLNRjBEBCiV4ZuSU4pWutAvv/bhcH0UEAEdXt3DzBJns+8iwA38uDYlookYPg
	 kSpAjkZx8Zt8dd8IwMAEOzsji98RL0jzJ6IwG7ijrGwcwS1FIVO+Q+Q1CbpCwnhMgDmU0
	 vtVv1sz1iMS5FmN8f6Xqj4Jop/4ekLU+KOWD1f6PZGUYOF3Ipyme04JzWDebzNXOy5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=r245EHki;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855360A382C;
	Thu, 12 Nov 2026 14:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3855360A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=r245EHki
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQMW22Yfyz58fdJ;
	Thu, 12 Nov 2026 22:01:18 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492078;
	bh=ABaa6UwTzHtZeufAAFYzwS4SgHiNV500JXrr9ADhf5U=;
	h=Date:From:To:Cc:Subject;
	b=r245EHkiNALuAH9Q2pF4Kh8g6LMGCQ7BNNIx7PViaZKYoGklD3pKmCj7HTq2cWPf0
	 lWJEUsbyggxe4pbDBnU8r5IOg/gi+76byJsH3zOAv9QZqPtYbMpfIwQBdHxhQHoEvl
	 hJVJF3YZmHNcT4XjRsUphKEpLpQ+GGMqKjTwzD2LO8XaOipGjsLl1BLMmiSMJZ11Hx
	 9KhLa7QrlRydG8IIL2p99y6mMbXcIF4tOEKPNkbYz4hwYRfi8wC/Xu8XqUHiJWPYjn
	 OAvBL7kPqYy/Ia0hJz+9mutVPnwIbK6p2qbcfT0DIe586u5vRy7gfjl8YxnzMNqHjj
	 LHj7Vty31k3aQ==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6ACE1AkP036927;
	Thu, 12 Nov 2026 22:01:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:01:13 +0800 (CST)
X-Zmail-TransId: 2af96af5c6a92b2-cfa35
X-Mailer: Zmail v1.0
Message-ID: <20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn>
Date: Thu, 12 Nov 2026 22:01:13 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDAvNF0gYXRhOiBsaWJhdGEtc2NzaTogZml4IEFUQSBQQVNTLVRIUk9VR0goMzIpIGhhbmRsaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ACE1AkP036927
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:01:18 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C6AE.000/4jQMW22Yfyz58fdJ

ATA PASS-THROUGH(32) still has translation and completion paths that
interpret fields as if the command used a 12- or 16-byte CDB.

Patch 1 rejects nonzero reserved CONTROL bits, skips the nonexistent
MULTIPLE_COUNT comparison and corrects the
invalid-PROTOCOL field pointer. Patch 2 rejects unsupported service
actions with sense data. Patch 3 honors CK_COND and generates SAT sense
on completion. Patch 4 corrects the remaining invalid-field pointers,
including distinguishing READ/WRITE LONG protocol and count errors.
The four patches can be applied independently; the numbered order groups
the related translation fixes together.

Changes in v3 (Damien Le Moal):
- Patch 1: reject nonzero byte 1 bits 7:5 for ATA-32 with field pointer
  1; retain the device multiple-mode and 12-/16-byte count checks.
  Update its subject, commit message and CONTROL-byte tests.
- Patches 2-4: code unchanged. Patches 2 and 3 keep Damien's
  Reviewed-by tag; patch 4 gains the tag from his v2 review.
Link to v2: https://lore.kernel.org/all/20261111223123952mgPDVsbO8uOyaDWL2KELB@zte.com.cn/

Shao Mingyin (4):
  ata: libata-scsi: reject reserved bits in 32-byte passthru
  ata: libata-scsi: reject unsupported ATA-32 service actions
  ata: libata-scsi: generate SAT sense data for ATA PASS-THROUGH(32)
  ata: libata-scsi: fix remaining passthru field pointers

 drivers/ata/libata-scsi.c | 64 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 18 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
