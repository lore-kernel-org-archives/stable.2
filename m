Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674032;
	b=TiQ12SdaUHAOmVpJlu0gcptZX5ZtxoGbug9oTXk0U1Zzf5PPJ7x2p48NsAxUb0gOQ6DS
	 K87c4/HsihybYWMOhvDwTbR0eb7g9y5R9F4hEzTOrPvs35r2rLqrGF2cMMIfHRskWtxdI
	 JlGan9wgJ5+/O9Z7HwhoEnn5yteAjLYF+4PJJ+Z6VPFJaKu8WtA4ANXPU/UH7ydv/KLZQ
	 SBRkBx9fXvUQp1VnVtLkL2i4pmP6V+NfexVAMDPYHoTfvNfWujXNky3tjBbbt/Q/VU09T
	 6KdjXJm6i1LPOjZIhyUB+W9dtN0d+B0nGX8MdY41kBgM1y4WptroFWj8yWgsE7Rkypw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=VfVQXdw94SFxRsfQ0ilS0OKBJBQQObnDFx3WIPHU/jM=;
	b=MFN7bjtKWLbH/X0gcjdBcac6tqVlCqJ9Hoc27k5PWUMwT6CzkwSDpCss7Ro3mBSsHlKU
	 HV5e/ekIs+1ofFwNiL4aFt9ydPOSClBLDSLPymd86e45+ryWewAWISMYU3fMv0D4mLQE3
	 fDQ8w3hQO6SWt6ZCEiyvwDmvs6qr2xoHP0eYBURptOhA2mimxWzmPDlPYwpMezLvT3QRt
	 8KChgj8UxmALWDfJlhqo15XHoBqxbISAkzw90BZOkuivAcUKY79TPGu5EMFWJS7Wh6Y4O
	 ERaUPJ7Jwy26+as+2HljhxJFJ7iWxfpYblkBbhPScAeCUU2WzgQxuzCZ2i7jQTeT8cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=kbgswiml;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DA606A33A;
	Sat, 14 Nov 2026 16:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 143DA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=kbgswiml
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRfp64p1Mz8Xrr9;
	Sun, 15 Nov 2026 00:33:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674030;
	bh=1Qx4i+kjMR2+scwEqO31goQeFoyzcNe9vD8frdT8MgI=;
	h=Date:From:To:Cc:Subject;
	b=kbgswimlT3UBWvfufvSfUMZgnSodTaXXN6VpbnFsLS7jnQq8ieWQCeDGd6OpT1VnT
	 FLE/eWyn0l3PPYGl7fqsvmqgBVmhOqRZ2BU9CSyxsrLkWda0Wp5SKcsatZ6uLzcwxE
	 ozoIdqB+od4mdIF7cQsVvXuvnFew3sENMIg96Z89USM+D+VuOhCJUk6mAYMbHmuI1k
	 0O8fhjh5A04Ag9k5kXHXU/e0g6IFIpkLxMxylMXBREdpAOPdpQ7ZB/HnQdQW98F5l+
	 uiH7JxStdJiPiGM26fuCSWWddsD7LzwA1qawSwSzmljbWCd63l6Feo70oXTrXVYXTz
	 UW8IJScZG6eZg==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AEGXfQQ081510;
	Sun, 15 Nov 2026 00:33:41 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:33:45 +0800 (CST)
X-Zmail-TransId: 2af96af88d691f8-291cf
X-Mailer: Zmail v1.0
Message-ID: <20261115003345297PJDJduSwIS5uDYxPFRxKJ@zte.com.cn>
Date: Sun, 15 Nov 2026 00:33:45 +0800 (CST)
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
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwYXJ0aXRpb25zOiBhaXg6IHZhbGlkYXRlIHRoZSBwaHlzaWNhbCBwYXJ0aXRpb24gc2l6ZSBleHBvbmVudA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AEGXfQQ081510
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 15 Nov 2026 00:33:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF88D6E.000/4jRfp64p1Mz8Xrr9

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The physical partition size exponent is read as an unvalidated 16-bit
value from the LVM record and used as the shift count of an int. Values
of 32 or more cause an out-of-range shift and can produce an unrelated
partition size. Exponents below SECTOR_SHIFT produce a zero sector count.

Reject sizes that cannot be represented by the parser's u32 byte count
or do not cover a whole sector before doing the shift. Use an unsigned
operand to express the representable byte count directly.

Fixes: 6ceea22bbbc84 ("partitions: add aix lvm partition support files")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Testing:
Tested on x86_64 Linux next-20261113 in QEMU/KVM with UBSAN_SHIFT.
Disk images containing exponents 32, 33 and 65535 trigger shift-out-of-
bounds diagnostics in the base kernel. The fixed kernel rejects all
three without a diagnostic. Valid exponents 9, 20 and 31 retain the same
partition start and size in both kernels, including normal end-of-disk
truncation for the largest size. Also built with W=1 for m68k and i386;
existing AIX kernel-doc warnings are identical to the base build.

base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48

 block/partitions/aix.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 689837deba279b1817f69edd2ce4246604e13564..b01b2c62162ddc0c724a681892f07d9d6f4a5275 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -177,7 +177,11 @@ int aix_partition(struct parsed_partitions *state)
 		if (lvm_version == 1) {
 			int pp_size_log2 = be16_to_cpu(p->pp_size);
 
-			pp_bytes_size = 1 << pp_size_log2;
+			if (pp_size_log2 < SECTOR_SHIFT || pp_size_log2 >= 32) {
+				put_dev_sector(sect);
+				return 0;
+			}
+			pp_bytes_size = 1U << pp_size_log2;
 			pp_blocks_size = pp_bytes_size / 512;
 			seq_buf_printf(&state->pp_buf,
 				       " AIX LVM header version %u found\n",
-- 
2.43.0
