Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817813;
	b=Vc5dFGSxgMKI/fQXh2IwrxMUHtKranmCX7mvbgb1B5ySlADSGsnVeXXkJlg5QsSsZ7R+
	 4Z3q+rNH2Ws2ti3VnSMWKIgov7JS1ulhRqwbV23uvbymDSJtINGZmVajSG+sLAx3m4V2t
	 Qbz6791O0JNgwErfkLpkmuwV0YsNrOuOli8g/WJBxKZayeTlZgwkVUBBnsGGuQhkM+nfb
	 a3Kkqp4vqZZ2DFnOEOsfCWPGrQpEkyZhsUYKGU5Z1IT5zYHOXv76SK0ouJwEoUPJRA/Lp
	 gSR/TqOcOA08BS/DyCyNNB5q1DLcrBTH7OMhfC+i/NyuQwagX39EvZwAjhryTSqTHeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wp0CE90G41jrqAKIR3rs0DMr5HgDqhlY9vi87vb0bPA=;
	b=r4UJeQ0uVamcGAxWR7PkxsPlDjsq1/IBFBVdVOg0HwRwNcYa1GFSOgD+b0vQ1IzoxNz9
	 SmC8jRlkzBp2FXuEkATQZ/8KvJVI/tOKAios862bxylKqpWimn1rbELYzXcVpTXpjW8gT
	 0BDTZWuVj9NfHXavPkaf7EJdahZoktzDk6yXf8FwZ+YyvjT3qVn+kf+yqhZDs5n5pdsJV
	 O4r6sQNQZWfABLqCeCc2hgN5dZEcOhH8EHIVF+WhkSmRsN5uBS7xKYMpa2Tu9/VBb7Mpz
	 vpq4t/0Bqd+LmJFkr3q1DvURurvAOkRBKN/CIC6H2VNTmKQZ2GVxD+Wh5WkRR39Ps/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N64g5BL7;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DB606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 765DB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N64g5BL7
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-84e513877a3so876685a34.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817811; x=1794422611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wp0CE90G41jrqAKIR3rs0DMr5HgDqhlY9vi87vb0bPA=;
        b=N64g5BL7zZIzS31k6jGLmlFqLdlZBCPfzDA4zfbYp9Gu1GITdQQP4UoItRje1J9JrJ
         ao6LfC1TTmBELIZ2OdwXpGrixV0Yi2wmvxVkcuI8ZuHy+kJ4Py7wiNxlfGfHckngXBbb
         EJfop/H5TUylYxK8H48YbkjurOr87xf+/mOjVskHLB6Vcv9a/LWbixuAK0JNi7XmnJAN
         q63FiCTdCg8CdspYqe32lSUrQdOGrQEUaTlezcjHBcVD6x3RCC2WV4IvriBF73+2N7uJ
         p2nydOMMOs8grEE1NEd272UvVBckEFHgLyh7LygnupSoutZG7scMv91MFwpdlpM/TIIo
         dYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817811; x=1794422611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wp0CE90G41jrqAKIR3rs0DMr5HgDqhlY9vi87vb0bPA=;
        b=NsYrX4+fTNBZIg9E+wry0J3TPexkQ7z+2q9zGldAuOdgYMssjmZg/1uWYqdAc/YmUR
         D65AswS+WbuZ424UjEbJzs50DGEQOmJGOTnZdA3IofSpfVTYvhkvEkkesMhZBJmCI7zi
         Y6R/bUYnVe6HDpNO0gmPp3dAAToC1b2TZalUAm0vGL64a5c4MRNcLT1HCj+hYeP94uPr
         T5U3KbYinaexyRB4j4gilDwZje73OwYeWvuLXRMVsUqAxnw/rEq2yPQ/1QSEB/EqPJTH
         XYakJ6WwyEujCDPntZVYj1DCi8mfJKQ5ncLNFG4qXT91P+wUzUI10DB+00jyQ/h7/N9B
         7jrQ==
X-Gm-Message-State: APuU4Z8Zo8STndyPVJay3f1NDecCfOv0VyRMeDczw4HN+X9tw3MCn2QU
	2aW5JI57uuAsqfadjFN2ELjFhfNaThDkMUI68qfZ97PaJrxuGls5VpH0A99VnJWMZ4VwB97ar5a
	Y6RZS8Os=
X-Gm-Gg: AYBFou14Hb4Wr7P6nzwdJ5nMvcHgEABgbo/CmXdSVhNwHckokpss7i2xXb22qthWTy3
	/kYX00QrOMcZeoYhnPjPFpLn1dHs1CK/9NkMDhVr7jGQC834YF+bJJA4gOo/0ZnWv223J13HCf8
	NyXqTzvr6V4g/2GpheRFj2j0xuXGIJrDpEuJvLojPhYI1TOkgZQEs9qSpA5SOmKh+BDe6csptCA
	zaCYWsr/qQTaQZLSeuriEKaOxPgfaIOYKTKSgFGJFxSQ4tHwczigIm0x6ozq41P/Ruu1/rDtKn4
	YxYgNwqr/8y+k0syoWa2CzzPFnllaENbhw7uw67YGL9NRxvPeY63r3CC8lJtSSgDbp8WATby1vj
	UhYDp3mxcyYfuoyP8Yddy/4deYdh8aZwh3v466ygdh2J3wFzn3x1yCTujIgFF0e2oUbd9w7mCBU
	B78vsTeoth4CkhZBfYH/k/tGX/eAZl8Dz8Svz6ybw08VM87WLr5P5TjTFoGwmUL+pC3zKYWIRpn
	54jhP4lWzSVLSV/iBaBLZ1pmiBARlZquaE4Ppr6iofzFNiG+QBKPyeeM+ovL+JBl9b3QvNF1le2
	2SPAFmJ2nmgGIW6GaLoWfxiJIQ9mWhI+8W1hFDIIxcBkIoZuCNs4O/5q+doVlNEI/xB09pWoPw=
	=
X-Received: by 2002:a05:6830:270a:b0:844:53b7:9890 with SMTP id 46e09a7af769-85f0586542dmr197900a34.8.1793817811143;
        Wed, 04 Nov 2026 10:43:31 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 1/8] io_uring/net: keep recvmsg buffer select length within MAX_RW_COUNT
Date: Wed,  4 Nov 2026 11:43:21 -0700
Message-ID: <20261104184328.516206-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>
References: <20261104184328.516206-1-axboe@kernel.dk>
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

Commit 18d3f56eb6e6500a65d81cf265f0fe74fd9ecab6 upstream.

io_recvmsg() takes the transfer length from the ring provided buffer when
sqe->len is 0, and such a buffer can be up to 4G. min_ret is an int, so 2G
or more makes it negative and the (ret < min_ret) block is skipped, and the
oversized length reaches the socket layer unchanged: an empty socket then
completes with 0 instead of arming poll, and a short read is reported as
complete. Clamp the length to MAX_RW_COUNT, as io_recv() does.

Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
Link: https://patch.msgid.link/20261023112209.87979-1-chenyichong@uniontech.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 has the older io_buffer_select() interface]
---
 io_uring/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/net.c b/io_uring/net.c
index cc25cbb27e5d..86a18814c628 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -805,6 +805,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		buf = io_buffer_select(req, &len, issue_flags);
 		if (!buf)
 			return -ENOBUFS;
+		len = min_t(size_t, len, MAX_RW_COUNT);
 
 		if (req->flags & REQ_F_APOLL_MULTISHOT) {
 			ret = io_recvmsg_prep_multishot(kmsg, sr, &buf, &len);
-- 
2.56.0

