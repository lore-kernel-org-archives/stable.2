Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008437;
	b=dst94kjd/bucAtPQiNMoIvNluvleClopzQ8DXoDbtTS1pNp4yoZIDVs/1bNtTAAxTh7I
	 EXgav6ZJDM0o1pQFJNJnKCv7eSgtz1b7KHM2LSPA3XavJAQOBLIt3ePlpyF+T5yiq2X67
	 3Pfm4QNy56fcii9rbw8zkginBxGMjfwfXVUuMDMqg/p3S02IPtgf2mpqvk+J32vFYneur
	 LKXz+dQ38SBRaz5l5oa4oBrz8Lo5pl0oIAwBZX3l7BTVvXB3vu5WfnCgoCqL6poCzBNaY
	 fmKVNcspJt8OQ+a5yBqRHjwRn08Lrt7yjWEKN0B1nsJ/h9TUumpvncb1cLSp2gyVybA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kqJV0Ber9SezkC+GcM+NkWNL1RH3m+jhei1cGQjf+lM=;
	b=zI/OZieZ8hx11kkjmywoP/tcVCW55GYmGWmUGczjhfjw0cFOnIkDvjiZUMW5tXv/ERZ9
	 OGNQP+XnbskoIGxMJFmVP+eDqnkXng0BHW+9t+se/ltA0w5h2U/pY/Zc0NZzKR7m4ni4F
	 BUZkuIMk5xLbbPHZJaXc01H9SyK7RGTgzrpqaPwV9yY1y9xtJgjqJzOGpwi/8h/plzsRI
	 xWSFvS7bH7bNzdYJHBf5ubGRserKNGrBDHBU1HLo3NdMlEQ1FrywEKzoKjb+Ll3fcekew
	 QedrWHy1jUsagJVNXVjPtPscgYMHiLOt9Jrm55GHjYUhTMQtftZtZg1o8EwlSO4l3Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wEJl45gc;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB6606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3AB6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wEJl45gc
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-497614c95f0so553330f8f.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795008435; x=1795613235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kqJV0Ber9SezkC+GcM+NkWNL1RH3m+jhei1cGQjf+lM=;
        b=wEJl45gc2y/uOQljIAbl/Bv85O0fAWrwrK2aklF7A4p1YnL5QAjYJFfneB3z78mAMQ
         8M9MXuYdgzZ1PFucna+nKcVxQ/8MDXijf/gSckBRry5s1MaGktYUE7zABoA6SFsdBc0Q
         vs/MnFwdFpglPbieOMZpPLCMZnodsUPOelmCKZkmbK/zNUaXUvTarx0OBxwQ8jqA0QEh
         PbJQupJjK21JjC9zT6XkFRiw0gs4UIg+hwX3JsUN259z5A1PmSZpPZ/zH1VO3gufH0OH
         ovQx8DSvjK5oW8z2BRawBcvRI5PfcB2c+YIt5B++gmD2Rm6+GQ+9Cah3tJtCwnV48Jvc
         hMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795008435; x=1795613235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqJV0Ber9SezkC+GcM+NkWNL1RH3m+jhei1cGQjf+lM=;
        b=tZFD7veuvgoTHh/psnHly3kaCgt+V8Ql2uoqP3qLgEbqsYlqezewH+GoMwypEIDrUP
         FNtQbfWLOZOQ40TBbDVsemTyZ1WNU7CZEN788/o+ktCKMsNWLe38WDW3i1CHR5dzgmrB
         OviMDccGerRLEsZp4BBDrmFEezQ3SizO5oM+Y2dnNOeogzQisKzkHF2jwG+76pJEewAl
         F0j3fme+0hOtffzrWQrSJNJw9DpUZ4l2DnultSmoVilKYff62t8hZU69yHx8wSjg2WkX
         CtQjdI7wszTN88W/6wt9G8MZeSxHFq4AqAIzgixiWeWr3DisbEpD3YVvRY117gtiADnJ
         ++tw==
X-Forwarded-Encrypted: i=1; AL+hErFfmtQZYwoeFWdUUOa61oWUdQM+BCOIIkREC5P7PutalepN6Q+NenB6Un70sf41Mve+nZTVcok=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MGWwqtgNNo6diyz2oB71dTOYTdNA2KZAvVfgLmtu7UqBe3GVl
	PoOWgmR4au1WszTdgv6Ukj/3vIumcE9uJl4ZipShpxZ7C6m6NvPK/3wP
X-Gm-Gg: AZFdTZc7vDE9erweYUAx/pOEX5XMtuwO0t1VTxjwjrvBAbnJpwrYOM73xmf4m/GTD3r
	AFHKGL0xPMdracr61o8qVURlMNp9toxrx9lHv2yqv6MRv3BA2LS13/UfmEOeFq9hv4KZvQTEi4O
	MXY7wdPcq0uvbbdEXrnv6wKQDbReKcJEkzysBz6sn8v+JmNVgtEtZBKcI18fSMIqUVzSUC7X243
	qaAQIARPKtKVNUMUvXV2cegD8Kp43sdyH7IUHYnV5hFks5HhXXI4kHAC9SMnWJJodnXWMvpxsgZ
	lUPn2Fw+xXti/WSJVYa/Rw5EZqsMPs+ZjnGHsbH5QW/qEq+jNwOOMcivQU7vFVeJFvM5hNo7EQ5
	Ey8JS5WLbJZ8pRKkjT80vNi47To4OwlRecaqkAXoYdb5P+G8T8u0YRmzbYaJ+aFZqYORGGgn4yI
	ZZMLEQdaMBtImOhPtMY8Ez5V5yy78zICQtNDJW9OC9i2jyYWYKdN5lsHZu601CznS2grq8Uy6uo
	5OmFnZ1xiHw20TtR75+8B/MZMY/6ej1fd84SMmmasFJozSjJyKVGliaQ2lJyaWJfMnI7F1xUA2T
	wQJsfZ+lKHLu7zByyoIhI7CRYEqy4ad5RlIahf/y2mIGXTdnwq4rrj7mInFqwr0XPCAP+F02HZk
	zg/pL
X-Received: by 2002:a05:6000:3cf:b0:4a6:5a2a:f5a3 with SMTP id ffacd0b85a97d-4a65a3a384dmr5519121f8f.3.1795008435029;
        Wed, 18 Nov 2026 05:27:15 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a650d2ecd0sm5392727f8f.8.2026.11.18.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:27:14 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	stable@vger.kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH] ntfs3: clear VMA_MAYWRITE on read-only compressed-file mmap
Date: Wed, 18 Nov 2026 16:27:10 +0300
Message-ID: <20261118132710.29751-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
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

ntfs_file_mmap_prepare() rejects a writable mmap of compressed files,
but leaves VMA_MAYWRITE set in the VMA description. Userspace can map
such a file read-only and then upgrade the mapping with mprotect(),
writing page-cache pages of a compressed file even though the filesystem
explicitly does not support writable mmap for them.

Clear VMA_MAYWRITE on that path, so the restriction cannot be bypassed
after mmap().

Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1624f9b014e09..a817452ac73fa 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -415,6 +415,8 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 		}
 		/* Turn off readahead for compressed files. */
 		file->f_ra.ra_pages = 0;
+		/* Do not allow mprotect() to make this mapping writable. */
+		vma_desc_clear_flags(desc, VMA_MAYWRITE_BIT);
 	}
 
 	if (rw) {
