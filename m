Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38813A543D
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259145; cv=none; b=dwNhOyvioKFbHA2T919Z0ivPGZskJdTcpApwQqFKE9QCkYG2VmmdOF39hNnUloKA7pwlJ/LLzIYyqKgWtB4gyAxKZudxB3LjLzMXgUdPIrJmQqVYYZJ9l5SQF02q2QiSc1zYyXLbCJjEf9o62qYVlhLDIq0SFhS8myxA+xluN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259145; c=relaxed/simple;
	bh=58q35gsm75VKjrJGnslFmDrQrS7HP7Kcow/7DGjQSPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VF4G0w31WHMC5xJ14kDhgXzlBypHpuW9vqz0+VaMQGlzYN42X3KIVKYN5WwJesSwkAog0eFreiZ3JcYyy6kYSFVztj37qVWZphMyXgrgGFEVf+envNM8KhjCC+Q9m40xslbdPTYfAvDmvqJthUPb1rQBKCiXd+Tf42C0U4mfnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StPDADHd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StPDADHd"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso2497520a12.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785259144; x=1785863944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/O2Zmu2kurByR3i9KxvOYezmFQ5bge2p+dh6NK6wa7s=;
        b=StPDADHdoL7cFMf2WCvPhu6ajg4/dr2V4oxelRb1GK4jnmbmB2OtNkvkHOgQt089Ca
         fOVyEITqXUEK4haJozy5VAd7yhvxDvGWyabcqav8M2+NutmI6MFOUso6lb+cPKiB41aZ
         Z0mJ8GT9XRFRdNhU7VJr3uwebrfGIZWVSit4fqTebHzW2Ley4kg4SkEefw3/WUkBhxg+
         9aoLYIFHeM+WKN2iJ5swG606gsuU6tB6F/23RtJO2bb1gSujtqIVQOHnzOA1DAVybJ6y
         U+xKVn+J2AvuSLQfH2nL6suZQVfNNkLsTnnPSWZMTeAD1NquZ1JVQsEHkKiQYRcfW2NB
         GVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785259144; x=1785863944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/O2Zmu2kurByR3i9KxvOYezmFQ5bge2p+dh6NK6wa7s=;
        b=Eb7tLwY2r8h+1F4mYt8dDf5wT62LT7ZdZSxDMr6kUX9u6B7juQIi/EXIts0fpbBnoh
         yhZFCUIW3B15f52o23s39qmuCBeP4/nOZaBLzC6SUXoRwT369ii9q1Ugd6vSPt5IZf8X
         wtnpMj6SsIB8T2iufJfN+aEtjsQPkrK4xeGqNVsvJjvIiTA6XshJNsI1IqXmtvApXh4j
         Lr0Efsl0Jxf7S1ykqgP1t5i3p4tOmYz/ijEg0GmlEbKm+CCaaO90oyRSNSpLxUGSu+Pr
         Mbx1nvzMkfDdKkPh3U0ETCp8CkLzU11cU5IkzfrIO6RqF3B5u0JjkFnZ7YhF3IKshjnb
         7C6A==
X-Forwarded-Encrypted: i=1; AHgh+RocAsJbMO9N0rBuxOEYbuNMT+8CfuZCSQOr+OOyHnJtPHa8BWqwNUGunvXF8K3g9Izvp4qAsjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCa3Tqy+b3kT9nnm78+x7lHNGiVQ9tKMlNts740039MbJhq3/4
	HeuPxPWG3AGIC51B+Dxpujd+l2OS2SoXuaJkH/RBReVRviKyWyQ2x1ym
X-Gm-Gg: AR+sD12ZO7x4C4gNrD9AON6rwdoZxjmTdoIIb1/iwkpwN//nmmPdIcm1ZIrDl9tGuAz
	uwTtTu5g4NhGZhv5KcruMauUXtOXva+C2qsCONiImkA7hhs52DfvY5L6GgKkL1CIH9wlDgXwzTS
	TAUNu7EtU1TSOgTIVgv2eil193WlYgiuktOpQmgFo4oxqoeg9hB7Pu2P37WA7Nu75ZvwCFCBwrh
	EoLMeIwuhKgklpm/ScthDg4771+jVsk6lU9JYkrcQ2g7rsFysEn9ZbyLiM6br6g8dh0Bb7Uo3kk
	zk+K6Pew5aYEfMJdmwd2YqI6dqSSz2/WeY3JteL/lpCTcGAj3ycFfT+zfyLF32oD5GqGmUs2Wqz
	irCioCreeBjuXpTmMPeqpcnEHWSdl+/OSvJucEkuXuvM3rfHMbxGBu7LZwa4n1rlcHGR9B0ejAT
	aLqhdkf1Qe999NrNHBeDfBxyMTP7XlrgVk9a+HH2hmi8FoGqphrmjhUAq5+gXOctk1Ji6FPIehU
	eP7lVHeTF5NMAn15mPTFypR8hNCznXR/HhO
X-Received: by 2002:a05:6a20:7344:b0:3bf:f795:f0f3 with SMTP id adf61e73a8af0-3c8ba5f61d0mr3924584637.54.1785259144024;
        Tue, 28 Jul 2026 10:19:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:e192:4a0c:2079:ffb7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7262c23bsm649379c88.1.2026.07.28.10.18.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:19:03 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: kees@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	rafael@kernel.org
Cc: bp@alien8.de,
	guohanjun@huawei.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: APEI: reject ERST records beyond the address range
Date: Tue, 28 Jul 2026 23:03:56 +0545
Message-ID: <20260728171856.60833-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ERST reads CPER records from the firmware-provided Error Log Address
Range. __erst_read() uses the CPER record_length field to tell callers
whether their buffer is large enough, but it does not first check whether
that length fits in the mapped ERST range.

Reject records whose reported length extends beyond the ERST range before
returning the length to callers. This prevents malformed persistent
storage from making later pstore reads allocate and copy using a length
that was never backed by the ERST buffer.

Fixes: f6f828513290 ("pstore: pass allocated memory region back to caller")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/acpi/apei/erst.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index bf65e3461..2ebe212a5 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -862,6 +862,8 @@ static ssize_t __erst_read(u64 record_id, struct cper_record_header *record,
 		return rc;
 	rcd_tmp = erst_erange.vaddr + offset;
 	len = rcd_tmp->record_length;
+	if (offset > erst_erange.size || len > erst_erange.size - offset)
+		return -EIO;
 	if (len <= buflen)
 		memcpy(record, rcd_tmp, len);
 

base-commit: 62cc90241548d5570ee68e01aaba6506964e9811
-- 
2.51.2

