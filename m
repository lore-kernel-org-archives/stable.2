Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66A47A889
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308416; cv=none; b=tyqTyjecnf+oqTjIdKOwlsM/mJHCWsUnAYxyhRQMsndojFVl9BaFN+pzrsTFalnHXAnWpID3M4dtyWymW2ntxBabwAvaulzBtVDOs6LvwR+AMhli+K09YaOa+gZdMn6KSMtmBNldN6MTbB47BrRG9LDdA7sUDqSD6m34xC7DOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308416; c=relaxed/simple;
	bh=jczjUbzDAl6jpxRWnP0Bypt820sjeIHGu2zY1M2ntdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSwDzHYbTD5hMvowl9tAsJ7BvaD/09KmsnPepwyEL4ZBQGIpX/45cMGSOjpXN7TUTIe9yYm3YrlL5CTNwwA2r52PtIxOiCnsVV+xG3xglBACk7i3Nb82iHVbbeXjFf9kX/pUIVYt0fkwvlS3pl8LKR30NX2KASHQfDdUD27/e+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLda/S9P; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLda/S9P"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbb7926836eso620138a12.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787308404; x=1787913204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ocsm7hINWtOwY+nJRxPAD45OZz1hNH2OpiWJbIaIUKg=;
        b=QLda/S9PO9BfJvPsXXp2y+yNk4GH02CsQQc0DlZ6VgW5SEXBRvVK+JycvaGuMzddEK
         pM053/dHgCdBkqlXEFBY6ElFltCOQw64LNsqyZXJAyTsBNdAYYSeoMLSz/Tc4Nw5+egu
         kQhlrFJ1KqDSRGuPc5icEeLyodThOwMKxDUWCH0PCpOvJOvGloUXuaCjYA9FOB7Tv132
         i1Z04J/Sf6O4BS1599i97+LDwnwSa88zotH/8/iyQpHSEhh7nk4BJEYlM+e0Y4Bnad0y
         syNifiUdo1/BrSwMhvWFKucAxFFrx5bk2LaJOjN/rcNrtDk3kwme69+8Wiv7WRSMgd6Q
         4IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308404; x=1787913204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ocsm7hINWtOwY+nJRxPAD45OZz1hNH2OpiWJbIaIUKg=;
        b=haJqhp3OXBgRQYku5b73PQlYp2SG7LGUZjQ9hsGNdmPEyWP1AP1PujEVXRfDorYIyz
         u9xQuDDIIXR0zCw9d0vvVsGp1H6u18+LiFRc4I0qXgAMieKmdd44RYLSt3ZqtSkRuyY6
         9SpbqujFZWtYcNB6NEKy8QdiwriY3EPb2FY/+oRJM4IkRhL5YpBYOPg6jPtepCvpVIEb
         ZifpYZbwvsqRp+eWeyqETC8y8O70SQo68+U5FMFlqoUTru76/4Skd/ML/oTEbgA0idg8
         34jy3/Nf6+sxPv4pEQ0mMJRa157e+EVF6jxvApmzdaZPHlgdaa7dcbjBRvvINXVFiWvK
         X0KQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq8bV24BYKV9GSTwNbgigaQ66JHkTcHiuyq0Bj7oSCqIEv1eZWbfbr92yfNlpKaKZ06FdKHMhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KGTvPUdsKzOgAZ21SV0TPtv5kLXuVgGQ2ToI0elXcB1OYWDo
	nmnh5EoLVLsbOVXDuzV2xXsZRcLn5Wh0cgTUMSxsWxEegKpMNLlYtlwzAItqFg==
X-Gm-Gg: AR+sD10kN0KNkpLPDuIqyO2b5sKhiTsm2veTvyW5NDfNcYI6v4ejgUWN+h5Aoo9UfIC
	cQ0wLyqFMfeAS4+JGBIeXaZNaeJ4OtkHRou3gPTl0+IiiX1dPYwRj2FFlIcP1+TWisA3fuEAfnT
	4qg6ahXoonJQyUB7Ee6XSUZd7CwaRR2buPDuKnpHacU+HHN53J/YbViKS08EHfIX2a+MSC+hB75
	YYD9HRjMMD3z08nuHclctlZIdBhPtCsepMs6DQG3rgLKHMdssPV+W4npdfxuBG42hxvdBt+Qunn
	TpjMwXGU6Vr3/YpX1dcph6yv9yzsYIR/vS5dkEHePwIlIlHnITNorNoB+xTJ3Gjh4RwJrzGpK/I
	fvg+YAMEzI9TCcJTT9vfAFE4Q/pTnV9590B7Yep6/eM30ASZe9w/c8bfAMFTjo3gn20asQFLTZW
	FJb7zYFEUDTWNtoGt+DJwbuNdQDwXV5+oI0yL4RH6+9qPREwuUi9R6X0DKH2oT3QPEnkFE7aRJv
	PGkHy33EfpTZPjrUZAaUpEubCU4wHi6mBwOHotRHlWNT6wpE8/FU7dp42/hKIsIFmCb6XrraDfm
	3m3sNpKdlAywKa2dfVPQ/2nKblnCeayVTD6CjJOXI0egV5KYDIoIKjz0DR82blJjKaN1JdeIPC4
	ZdZ3vj62hLF33WnHg0huDoFYiUpI7r1NK86bgz5h88UM31Is=
X-Received: by 2002:a05:6a21:e081:b0:3c8:f342:132c with SMTP id adf61e73a8af0-3cd3000a342mr9446232637.11.1787308404443;
        Fri, 21 Aug 2026 03:33:24 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm23237958c88.12.2026.08.21.03.33.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 03:33:24 -0700 (PDT)
From: Laxman Acharya <acharyalaxman8848@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] io_uring/query: cap user size passed to copy_struct_to_user
Date: Fri, 21 Aug 2026 16:18:17 +0545
Message-ID: <20260821103317.91437-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

io_handle_query_entry() clamps hdr.size for the inbound copy_from_user()
but keeps the original user value as usize. copy_struct_to_user() uses
that usize and, when it is larger than the kernel result, clear_user()s
the trailing bytes.

As hdr.size is a __u32, a query can request nearly 4 GiB of zeroing,
including on the error path where res_size stays 0. The interface is
reachable without a ring via IORING_REGISTER_QUERY.

Reject sizes larger than PAGE_SIZE, as recommended for copy_struct_*
interfaces.

Fixes: c265ae75f900 ("io_uring: introduce io_uring querying")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 io_uring/query.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/io_uring/query.c b/io_uring/query.c
index 88a325736992..f2b5e19e5af6 100644
--- a/io_uring/query.c
+++ b/io_uring/query.c
@@ -76,6 +76,9 @@ static int io_handle_query_entry(union io_query_data *data, void __user *uhdr,
 
 	if (copy_from_user(&hdr, uhdr, sizeof(hdr)))
 		return -EFAULT;
+	/* copy_struct_to_user() zeros up to usize bytes */
+	if (hdr.size > PAGE_SIZE)
+		return -E2BIG;
 	usize = hdr.size;
 	hdr.size = min(hdr.size, IO_MAX_QUERY_SIZE);
 	udata = u64_to_user_ptr(hdr.query_data);
-- 
2.51.2
