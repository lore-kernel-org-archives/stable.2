Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D641B8C3
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785229780; cv=none; b=oQVWCY/xdq8OTqxe3mpDFUeVtFzVege5i5cb4acsCG2dNg5mmB1HgLu08Vlb6E9KVaITRkcT8hcCqCoBP/nDqtVEYSoxsJdyjHC6FgcxOFNX+LMQz3hY2YSLImxtmkg6C7Cy36tV+uA/SA/LAWQok8/6FdBYESSKBTDjdFvOH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785229780; c=relaxed/simple;
	bh=/myIS9UDVtLxMamx56QhAR/KuoQd4dKDFh1SeQgTmt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFceIACSmlEtS4Z4dRW9zER1ZdBR/iSeN3j4k8jR8H77cJIACP9faz1WzbmGszuWocf/VTlu8OsZs4fqJOb5a5a3cUNGXZpubVXa0ztCggE2NriegXvthaRzMnp81tOkgYmbuR8RFLAfc6y9IY8dlmnmxtqaJOCISv93KUiTztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGKkBq5J; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGKkBq5J"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2627704a91.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785229778; x=1785834578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fhsOgJYTFPT4WrpaQ/dpU3Ea3WUMBkyN/iVdfCKxIuw=;
        b=RGKkBq5JOX/shhovgMAqqnQdMF6UlgNgNqfwPuhPu1UYfkZ4r4rAsxg9Y6ECA8UYeL
         C+wkcqn/LLA7Lk7nCi22sX54QuV4QH1e9WouuvtPLNDNM/7r4M8NZNOQRnBNWmCB0PeE
         +5RYhMR36ycJrxgp1H3go8SvzgavEUcl1JsDNg7nDYpu8LXP1zIwRCHMbJI3ayr4ZO1F
         bZ5OngYjpoptKIKmhR1gQV//7H7eYM1p8qZ5qnXR1QCv5MLZevMs4x04Swb7yNFCdj/N
         3KDqZpYU7v1EtLWkUY2xiLbCsIRrQJuVgYRFhZ8+RkMyNwbW5c+51dPcyFYi1sPvZ4ZQ
         GeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785229778; x=1785834578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhsOgJYTFPT4WrpaQ/dpU3Ea3WUMBkyN/iVdfCKxIuw=;
        b=A5Us9tat9rpK6vDXg8kmARF3NyGOjR4mb6g+wn4+JlzkKwm21QAtUpTq8M36lNDiro
         zjdFbtiidS+oxsomJWHt67oIibch9pTri2ZR1QQEgFtDHOhja6I2WR3YtK7WVGrZMCXW
         /CobIzDNnqG99fmP8gSlsc2mOqpWw2mowXacRfRY+XZgh7Zu6ATbvHWbeCg8xVktGxE+
         k9C0bO9FZEn3pW8UnoiGtzIAI7eSz81LhpCf6Ncg7r+BR+TXhQwHbKDt0VwiUX6/MyLb
         P+cN1mFCR7TKsr76ZbbMsIbgQUqpLm4RbsNkcrSqHdUjGqr8LENTuOZhp8UYkJxQyIx6
         B1bw==
X-Forwarded-Encrypted: i=1; AHgh+Rpb+n7moug5EQLS/ZfolDO/ludlPAU7WCYd6ZCaB1GBpIS0wU5PTUlPNiaJW3VN1i93Zcf7QVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymy0s8in/dX3/QVVmtI/l6P7yL5oGVPajtEApsmpydA7UaU3L5
	0T2EGuM2paFb1oVhKB/Y/Uj9X+AVgucvmG/NDZit0fuhrYskUkytm//h
X-Gm-Gg: AR+sD11hAAmAlwvX2B0NbPdNnNfbUzTt5DkPsUXDSY0DxaIGknBSonQvqZpibpPjsCH
	52bXowi9vFbND0qddu3r4eaTPMyRRre/xtoNVmT1awtJ9j4wW+Odeznq7j2sc13VcOjKJxglF70
	FO08eP7bOTAbRIe0UPxJfBFIhWSpcU5XpK+yYKLiBC7Ynm4OidtHlM2mfqG+gproS5V2bsanNE9
	i+gxPsJVv1VoDv1IH5XyTj6J66Ry5P+cwy6oDNQwm4xBuTnNV54D8krLFMoUJEDHImCKDz4Cr4n
	kUYFbYJ+jljPu6pj1SXCOcdyNuRcxnW8QeXRplLwW6z2jS3rxH745d0W6Cc2XT9MdDM8heiZyL2
	im5Ohl0wOrWIbNvfr1v5l/KaCWU+9zLyV+rE2XX99HQlQOBBwTJq+r5ChOfKMzjNjMPDkoOFMLt
	YKoGTId47Q8zLG/CdhmZ1c2XKcxojRMyGLrQ011YSfpk8CuRrAjEPsqMi2gW71x7Uz2MtTf0d4k
	JfSJdnnMJhBS5if5j6uCERn
X-Received: by 2002:a05:6a21:6083:b0:3c3:875d:c531 with SMTP id adf61e73a8af0-3c8aafbd404mr1936218637.6.1785229778044;
        Tue, 28 Jul 2026 02:09:38 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1285sm44086953eec.5.2026.07.28.02.09.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 02:09:37 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Kees Cook <kees@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: APEI: validate ERST record length
Date: Tue, 28 Jul 2026 14:54:30 +0545
Message-ID: <20260728090930.31589-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

erst_read() returns the advertised record length without copying when the
caller's buffer is too small. erst_read_record() only rejects records
shorter than the expected header before inspecting the creator ID.

An oversized record can therefore leave stale or uninitialized data in
the destination. If that data matches the requested creator, a caller
may use the oversized length and read beyond its temporary buffer.

Reject record lengths outside the supplied buffer before inspecting the
record contents.

Fixes: f6f828513290 ("pstore: pass allocated memory region back to caller")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/acpi/apei/erst.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index bf65e3461531..2fefef65d674 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -936,10 +936,10 @@ ssize_t erst_read_record(u64 record_id, struct cper_record_header *record,
 		goto out;
 
 	/*
-	 * if erst_read return value is less than record head length,
-	 * consider it as -EIO, and clear the record_id cache.
+	 * If the record length is outside the supplied buffer, consider it
+	 * invalid and clear it from the record ID cache.
 	 */
-	if (len < recordlen) {
+	if (len < recordlen || len > buflen) {
 		len = -EIO;
 		erst_clear_cache(record_id);
 		goto out;
-- 
2.51.2

