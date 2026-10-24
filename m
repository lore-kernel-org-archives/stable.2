Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859349;
	b=rESCcQGVS0Fr/n8nguiVbLiG3y+WjwxZ+/t0giF/SPamlYUmuYYqj5111FYkpLf6u6tZ
	 xg00z9URo70VJ0JRrzdD6gkQZXFRVCsHfxuh2rOyCTQHFKreKJJtclKHa+ncdOm71Dudo
	 0vuo/tPXVM2kJXinmp65pux/GzCwcwGmX2YjYh8sb/s7WMiQBb4Jp4i1a+SCMCiRlOYDy
	 i1QDISIvi8GLlWG5PQPBa6/dMifca6bWfpP1fgR/d1qHYuhKAAvHQUd5z7LPiAJ1aNT3B
	 3iA2lrUNWxNP3z1wENtX57Vd8MIDTFbrxMkDbzNxzaOY+vOCCbw/Z0lfWTqW472/sww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=llsgWckxU6HrF1Oq7gERdngWWd2BM5NRfeUcsEwDim4=;
	b=PGsvztXzvtFn6CfRmCQOY7tjw6whmO3RNSJnCVwSl7PoKkI/8qPLTrs94bimtHDMZh9m
	 5DD/sUYEnMV/X/mQr7lQh2YG7keHD/Bz8FhM/cQbUavPUWpgHOVtVeMmhlP9jWWusvqpx
	 1y342CeQfzVD/65Igus+HSWSzUSUtBok8+QkSemVXT2l6ZTlBhAgrog64LOn84EpyCrmO
	 R9VP6Gp0PAbIKPqcf4x7YYvgYXg0k4NupF244wQfylZf1L0HaSmzcA02CY9g202mY7UXW
	 yMxcIY5SucW2PAtAmLGY+G7ItkK/gl2hk1SOkECjN6N7/Wylc1SZ6/+YVhL7yf6LLMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Nmqafhes;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C8606A31E
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 16:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 873C8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Nmqafhes
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15943c9c005so2432383c88.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792859347; x=1793464147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=llsgWckxU6HrF1Oq7gERdngWWd2BM5NRfeUcsEwDim4=;
        b=NmqafheshdwPak0EWBNwAofN8AZNgmQptxYh3iGuiskd4q9UV02Q5UGh/oeX7f6FAP
         hsww53lS37P3JAtMBHk1Ke30ZUyjQ970syUPgtgen7abOm3OdBvvHzNhQeSS8thBBjN2
         SC3HNizvps20P1by+xoZcccTn9VK6mlBWX86kM9SgLixrnZqkm2a15VPLsC1r5akYpOd
         GbFtf6SAKcIIaCFJLHlyrXE7eppDpukU3KNhEmWL7AFobu0iXnIDJT2TSN8h/2LThiu3
         chbxN23xEius6S8t10nOzv38wj/umbcr/Gbh4ewd8+Qxc1HolXYT5oZhHgwwouOLAZCq
         SWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792859347; x=1793464147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=llsgWckxU6HrF1Oq7gERdngWWd2BM5NRfeUcsEwDim4=;
        b=T319ny2x9A5IFAVEbDufjBsU7QbM/kQD2at3OCfa79LvWlFfvPICjLNqXBT0INUA+s
         6bBwF9EuMFQEDWK1OlatnscBNVBDB+vlN5/LlMk6HmXrlMRXO8RoMN+OBLTjZAYztzPv
         K9fPonfc4gnbIMv0YwhxU8nXQyTIm3lgqWTWBFekiv8Zd07umNtY1MZEP9XlrCIPXSxB
         PAR+ozda8Bhy8Qu13/Z0HqeRFBhrJAR0nQ0c2k9rYe0W40tPuvAU+hRwRJUr83uflErY
         PfcYHQCzVIEUg7k4olAbHDn9F7VJ4p3TmOJsxCTEOl1R1sVMV1GulbkRrAz+N16iZ2ix
         4CSQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8rpH04SL8x5mkNZ2RLJOc5YO6lPC4ygWoehyJatqcW8dVI6WyGlqYQFje45Op5nQItrkYBsQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxOH7H3T1hzD2AN3iT+V6pf6109YsQF41xnjbU3xpGbCz80+3B
	Bl57HI0x34+HSBZJYFqaQ/QlQK2cSPoPvCDg7ypsjbGgqAoR7UDcHDtzY0fQhNTPEFk=
X-Gm-Gg: AYBFou38rNB/terAQr6h7pgtSkhnSkOvnAdLiFbqfLznMnQXEa7F4ZCCEdn3Z2lQ4iE
	yVQGeggwCFidkASydu4VoZTr6vPv1i3QkcWcYB2YsE6mS0sTemdUH9ZFHrrOzK2PE3devrTVG9N
	dJyaqBIA+qFGRLskaREfqHVSL4AgtRssJnnzTSJ6+lOzHxh6y4KpJYm96yCoGkwblG5wgK97yEO
	6wrQrB3k6tpj2HwfycTEN6xtOGHEtv7I/ufdy7Ohq29hkpGgslEC7By0VFBDHTURSw88b4g8dDl
	vGlX0AupQL3gOil6TO1xQPDJWJk5GNrb1GM+LhbA3C8k1iLtsLl8eD/yqkuuwZRgbkyBhJ5cstq
	SkrrCxRJaQ0LeOdb4V0TLsGX3XQzu20GEIhCb+1O4KcVlfK/FpJX9XsRhRHGDp2KWYxF0B9sfnc
	2VwnKMjgkNd2Mnk9dhghKZ+waP+wExkKuQqjaiBMwQhs+GWyhHf7zX9VNrr953x0F0kGqPg4+yh
	i1++pe4Xr09cLZyTjXcOTAX9Pvs1ENaSG+9U67uMCywx+PZrAL+08w/Ay59iiNyhKyESI8L59Wh
	RAos27C1xetqDzb2+nxfMahqZXTqf5hKRgLIeAeP591ocup0a1xOMH9jOQJKwbxV
X-Received: by 2002:a05:7022:220f:b0:14c:aaa0:941c with SMTP id a92af1059eb24-1993fba154cmr5334530c88.35.1792859347154;
        Sat, 24 Oct 2026 09:29:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:dba3:be57:a674:a67f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19a3736d16fsm7192350c88.12.2026.10.24.09.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:29:06 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v4 0/2] RDMA/srpt: fix the indirect descriptor table bound and the context counters
Date: Sun, 25 Oct 2026 01:28:50 +0900
Message-ID: <20261024162852.3528224-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

Both changes are needed, and they fix different things.

A 510 entry table fits in the default 8276 byte IU when the additional CDB
is empty, so the bound accepts it and the counters then have to hold it.
With only the bound, a conforming command carrying 256 or more descriptors
still wraps n_rw_ctx and leaks every context it allocated. With only the
wider counters, a command that sets ADDITIONAL CDB LENGTH to its maximum
still walks a descriptor table that runs past the receive buffer.

The two defects also come from different commits, which is why they are
split here.

Changes since v3, both from the review of 1/2.

desc_off is a uintptr_t subtraction now, as Bart asked.

The room check is gone. It divided the bytes left after the header by the
descriptor size, and the division truncates toward zero, so a byte_len one
to fifteen bytes short of the header gave room zero rather than negative.
A table_desc.len below one descriptor gives nbufs zero at the same time, so
nbufs > room was false and a truncated request was accepted. That is
Sashiko's [Medium], and the v3 commit message claimed the opposite. v4
compares the span the table occupies against byte_len directly, which needs
no division and no sign, and the wrong paragraph is gone.

2/2 is unchanged. Bart asked why int rather than an unsigned type. The
values are counts and never negative, so unsigned fits, but
rdma_rw_ctx_init() returns int and the WARN_ON(ioctx->n_rdma <= 0) in
srpt_rdma_read_done() is a signed test, so int leaves the surrounding code
alone. I am happy to make both unsigned int and turn that test into == 0
instead.

Link: https://lore.kernel.org/linux-rdma/20261022143901.2991062-1-yhlee@isslab.korea.ac.kr

Yehyeong Lee (2):
  RDMA/srpt: bound the indirect descriptor table to the IU
  RDMA/srpt: widen the indirect RDMA context counters

 drivers/infiniband/ulp/srpt/ib_srpt.c | 11 ++++++++++-
 drivers/infiniband/ulp/srpt/ib_srpt.h |  4 ++--
 2 files changed, 12 insertions(+), 3 deletions(-)


base-commit: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
-- 
2.43.0

