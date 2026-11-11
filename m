Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408103;
	b=4ecETM/CvIMN6CjvXR8stXYF81wQBMAO2idfvMt6ZliJlPgvOxSKJslpPAG5Cay3ULuq
	 oC6dJyh4WxsYk45D5l1fI9YoU2XStf+hpgpFZpQNK+PVBBr5CNi7UArDANCoIyS+V3g6j
	 Yri2+S9ZU5aRFbjEvdo8Le3gyhi+PVwQj6aB/Gxecww+NLFDlc2nsDbgW2/6hEwTXUSvk
	 OQE/Nb8WID0B51rLuO5IX+1vOc1mYIxdL3o/dJdFeOQfwyWA6JTZSNuZX3LWmgS6I7Ucy
	 7M1+UJPeAQVqudwgkTe2IjO90D2NZFM9nOatvrl078KXH5y7R6d0STcv3p4rYXPwT5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408103;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=pALWi25PaiwvAzQ+rk8fhccHyEREP1igMqQCrUiFzbI=;
	b=uhpIrBWLt8XQqDcZp8ZXsd3kodoe3V8hdxrUiJiq68OdchklVNIjmLaliaT0nodpRjse
	 GxCf6IsvVfE2tAe2G8px+1waHZ3I6M+DodSW5qZlhhJH4LR3odJmMAF4ixd6dQSBd+FHr
	 tlZcTCCh2fa1UAeBD/p/gRGSBNl/CVKQeOtojkyNGHv3aF8lz2y3pwjZzhcHayci6TS1M
	 jzT+lPn9LKdotB5hda10koUBdsFtaOU7ahPgrbCIa8PJsaRdHeRHeSmOt1FKbrXGCpw3U
	 7d3j/FeAftCzPRdBcRRVCv+Lgie+LZYBfw32r7MOiS9BbPUihsOtYNjA/PgVgCFQj/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=qpsHuCYY;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E2606A331;
	Wed, 11 Nov 2026 14:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 269E2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=qpsHuCYY
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jPmS3625Gz8XrrX;
	Wed, 11 Nov 2026 22:41:39 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794408100;
	bh=lJs51VmRkrJ/aPe+W6Tb69qPGEvDYZ660PLNVtEO16k=;
	h=Date:From:To:Cc:Subject;
	b=qpsHuCYYdkNZfvk63f8VQtzXiptxpbfgcAl8sjy97EzId+x1zlIIBok/tNbgnj9ks
	 /0KWNDL8Rl1Yp/zg8IfUyLKHD+AvB6WH+ALEUZxeIF74EcRSdCzjHNZZ0M6ZGoeE21
	 GT7AO4ZX957InBnpzsbBtFOUk/5za5OwXgj913f7rFfQHETTa97gtZHrzuGOTyzF0o
	 6BP0OARlwqK9ZQ6ll1zdX/SBI/6SCRkAhv4Fgzd19Xp7l3aEqUNp4DdcqQozz1Q7F/
	 2YKxuIaC/qlQKsnb4wMfKmYQUU6PRWnY9jm7Xl2dsXPQCOZt48FyqZ+nqV17+XBYmf
	 bsRfvzdUvFfOQ==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ABEfVTW094209;
	Wed, 11 Nov 2026 22:41:31 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 11 Nov 2026 22:41:34 +0800 (CST)
X-Zmail-TransId: 2afc6af47e9ea78-5c968
X-Mailer: Zmail v1.0
Message-ID: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn>
Date: Wed, 11 Nov 2026 22:41:34 +0800 (CST)
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
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZXQ6IGZpeCBmaWxlIGJhY2tlbmQgc2hvcnQgSS9PIGFuZCBMQkEgcmFuZ2UgY2hlY2tz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ABEfVTW094209
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 11 Nov 2026 22:41:40 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF47EA3.001/4jPmS3625Gz8XrrX

The file backend computes byte offsets from the LBA and block size with
unchecked 64-bit arithmetic and does not handle short reads or writes.
A host can therefore make the backend report success for a transfer that
only covered part of the range, and a large LBA or length can wrap the
range check and reach vfs_fallocate() with an out-of-range offset.

Patch 1 makes nvmet_file_execute_io() stop at an incomplete submit
instead of advancing the position and eventually reporting success, and
converts a zero-byte completion on the common path to -EIO.  Patch 2
adds a shared overflow-safe range check and uses it for read, write,
discard and write zeroes.

The two patches are independent and can be applied in any order.  Both
carry Fixes: and Cc: stable.

Testing: both were tested on 7.3.0-next-20261030 with the loop transport
and a file-backed namespace under QEMU/TCG.  Patch 1 used failslab to
reach the chunked path and a shortened backing file to force an
incomplete chunk; the unpatched target returned 0 with the tail of the
host buffer unchanged and only part of the write reaching the file, and
all four cases return 0x6006 after the patch.  Patch 2 wrote SLBA 2^52+1
with a 4096-byte block size, which wraps to offset 0x1000; the unpatched
target accepted the command, and it now fails with 0x6081 (Capacity
Exceeded).  Both patches also apply to next-20261105 and pass
checkpatch.pl --strict with no errors.

Shao Mingyin (2):
  nvmet: handle short reads and writes in the file backend
  nvmet: use overflow-safe range checks in the file backend

 drivers/nvme/target/io-cmd-file.c | 48 ++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 13 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
