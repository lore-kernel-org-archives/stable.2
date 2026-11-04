Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817894;
	b=HAgn/ih8e9oo3ihJPCFR6RAbicLLvav/HAwuOtzM1MN07jGjXveHmNsKFkWm8rGqKjWz
	 wgQnLeRi0oW8sUPx7HxgGxR80zGIrDOPYHlAVrQIUQK7tLeL2AO1ael4n02J3PDI4oq49
	 yRkFzVdQYpzVl3KdhNc3ELMdZTrOwC7pyTZXQp4CCbq7HKea9mNgXYUtWVtk5snhC/QXa
	 idhDDPRG3S+Riz8XghX5EC0+iazwqX7bWI/6sZyJwyc5WHlmbkiyqBYuz29fPERaEaSQl
	 nN3JUisNnYmS50cGXpjVJVnDN4NuKFId7gtPkdcYCNvquctkfeMkwASr+f9jKLGGnMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P1DPOLy3kEcwILwkeLCBAYKkyfI2QoKJVRe+IyvsiLM=;
	b=KybrGv3MifLYepoUvLsnV7jHEktmNuGb7HZlJT7HB19o8+G9tiZJJbyzFuh0g149cYLg
	 YbS1pJSFepnCk+pzWWP7KiomegzRA2Q1re7rdQjd7LUC62x7bpddpQz8m03hxSP+B3jWQ
	 vtNuvGnKMxqAjTkCCV9VBbBPqMGsZWD2csh/PI3gKojJk2aNjdPMQI+0jRE3KhCKJiuba
	 TnxUdx2zZYC3JcnGZ46eCubQfnPFp0d5/8xZ5rwkDWkY5/m5L/6E2hNH2H2koBHLnCoAu
	 sLRGumMftSZaQyWTeJSIAWwzQDMk64MjtvOIfS8u0qB/zHa0r2zuSjFS4Cjl1VfsDhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="h/IGU0bL";
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAC606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BAC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h/IGU0bL
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-70b875f6f1fso958744eaf.2
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817893; x=1794422693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P1DPOLy3kEcwILwkeLCBAYKkyfI2QoKJVRe+IyvsiLM=;
        b=h/IGU0bLdhMiSo/ZMz7aXTIv/lguMsOGmvgzao9SKHe3eVMsDMZqam6L3h9cUxTCqn
         dwKjrqpKjuwqkJ/Oa7jSfZu2DpgEzgM8K49weN7p24r9Wsnqr9OGMz+J8qm/3UdXToX9
         iKDYY5WebGv1XmRtUdGaYFcamhqUpPZ8JOdlSCGzxm070oyzesi0gIEO9jLhZpusIdzD
         M6DPE8jtAvYW+Imulc+yQVg3JolsxCL5n6tKCkVRV4lyYFxPdlW4V/H8ylI+j/jCbiq2
         rYKFbO+cQPBqhZ8XcQFzADQBaAZg9ecOvyLWHnxmDDi8oWK839L5V3+qmzsK0WPzYE1Z
         bdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817893; x=1794422693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=P1DPOLy3kEcwILwkeLCBAYKkyfI2QoKJVRe+IyvsiLM=;
        b=V3wDDPvOTfEbsZhJ7fFovhAg7u4bMXruNaFhFuuy3+CHBQPIQ8PRa2t27EsEHLR63C
         h/TgJvqG4/GP4wpSJex0r8tSglG5QCsB3ryC1VxQtojU2iKouuyBC8t4QCBEHZUrlzID
         59lbzl7jATg6NPkKq+q1pBsG4+L/n+C/bgwBSZZ9ggThhX/8s4w7MB8W+1ifL9vob5Uk
         YHifVEOeHxH9c+4mvPQpn2Unk7QnkS87Ta8AXJf6SisYkHwjKEj7o2FLDm7qR3/tkC2E
         fmGNi2+GJ/C0d+p1aGIJZoKfK59IzJiiA2aq976XCNxZOqny5kY5GWVHBjWbBiDeOALS
         eZVw==
X-Gm-Message-State: APuU4Z/ZbItqYyq3zIxsSuWzfhmI+NdKkHQGdKK8D2h4n3k9nj5iMm8I
	m1l1d0f3NzilpIcP88wZrozbGM9OT2QdGHtI9+9Kk7lZ34rq6O5aJRlkiMjRWZuWaODeJnmHWfj
	csFnPGDg=
X-Gm-Gg: AYBFou0X/Gy8WgiuYx7GS5wW5M3/V5QANo69dUxVWhbHythu/8blN7nGr2eNKjIbk+M
	xh2zXPcrdNg6mI4gzWprGParYTSXZ3TRc2vnL7Kv+SPBIaBtcdUYfyTZGFmFYb2qNuvLPZS/Rna
	tGvZf4pOASL0drUUkMNIWCS0TEPf9aCAggJHggcLs61SofSz4V9qXwxhWByuTpVYT8BhZZWO+Wv
	wYkpnXHr0c5PMPaY290XXP423hBnWT21BdOjw6IQ2ewnnqKDDIM58Le8x/5Uar94f8A5Ws+JihA
	Cuh5yBGMxbZMRpqVMmIu3xxy5AB1GD8bJBlR+9tiaenNlDoMaEEPqoOknYC9TcjDRXsUP2anBmw
	IKMLTK9nN1nf1yBlIRLjtaOmrZdeJlJjaV/h0pgFmzB/SQffSu9D4UrnitiY4/8D0fDAtmV2pJj
	Z7cGojix56Xzfq3bWJe7hszVYjFpDxpzLSSmhOXy4bpxX/bJmRLY+pt/QyL/2f8mefk+jkgkZbJ
	BXQETsq+NQUnSTZIyeeD/AUZSL7MNqfMgK31sATVE8zLTTdIQxlvGdRvEh4e/8U90RCZkFf25pC
	70yFOctNt5uKUVACUml8RBx6uOq6T7DywWqbqdwgw24fp128x70HBg659Vqrw1cIvFiGqpPunQ=
	=
X-Received: by 2002:a05:6820:162a:b0:714:b51d:f512 with SMTP id 006d021491bc7-714f29470demr10982660eaf.17.1793817892790;
        Wed, 04 Nov 2026 10:44:52 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.44.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:50 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 01/16] io_uring/kbuf: advance head when a pickup empties the buffer ring
Date: Wed,  4 Nov 2026 11:44:32 -0700
Message-ID: <20261104184447.516768-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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

From: Yichong Chen <chenyichong@uniontech.com>

Commit 8742f4b5a472c347fe568a73468a2d9e4d630b33 upstream.

io_ring_buffers_peek() flags the request with REQ_F_BL_EMPTY if the
buffers it picked were the last ones available, comparing head to tail.
When the loop breaks because max_len was exhausted the buffer was picked,
but head is left pointing at it, so the flag isn't set if it was the last
buffer. A bundle receive then retries, finds no buffer, and the request,
which has received data, is marked as failed on account of the -ENOBUFS.
That severs a link, and ends a multishot.

Fixes: 35c8711c8fc4 ("io_uring/kbuf: add helpers for getting/peeking multiple buffers")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Link: https://patch.msgid.link/20261023091711.83481-1-chenyichong@uniontech.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/kbuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index c9641b6ccc8f..abf44f5dba26 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -326,8 +326,10 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 
 		arg->out_len += len;
 		arg->max_len -= len;
-		if (!arg->max_len)
+		if (!arg->max_len) {
+			head++;
 			break;
+		}
 
 		buf = io_ring_head_to_buf(br, ++head, bl->mask);
 	} while (--nr_iovs);
-- 
2.56.0

