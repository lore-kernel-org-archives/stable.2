Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296688;
	b=W5ZhhOkNXGjPCLJpAH0BDznpdI3+8BLQIRv9TxIM1gm9z88vppVvV2K41GlKEUUE0YIE
	 3SqWhRt+FaLGj+Bq6EEzbJkXt5yk7PRokKvqcpQsBH5dADgTBIjv8cB9v6tymqZpF2Jzd
	 gg1vy6baZN3vY/EsHEGDcmyh4mOikfin3FJTxXluQRCM02X+xcoNsY4EPZON2OqjmK6f7
	 GxC/n0J/wRwZYwrTLGPIudK0uHZIoHpCIZS+FLTwHVt/JThWIUB+3UYISsWNetCeDn8rN
	 iudCrnfjQCTahGqhIf0o1MqH+kuHpr2ebwrc4IHBaQmrD2re86BYvBOj6Be8uwGcoqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DsEWEKPZ667fLlA4wITouz/H3FQEAqH5uDyXsTnzdIE=;
	b=koMaZI/v57ietxF/VBvTT1fzS9HvlC0+IkZ7dXvceqTRBNn1YiynzklRbJxUDDkcRTpM
	 p+Qv0GMXNOKkkt+vWsSA3tFy0Sqr84lgMUdeiQtcjSwYLn8kX9CDxJP6QWhOSditl+t3H
	 MQK6xMc7WtmaF4YmUEor91LQwYiqHZ1mWMWBgS7addmfxAXJ0nQXVlU4TjqVT3GIi2bcu
	 /4PkBTC8QhSP2dfYaQGSp+v9QDduIqg68rK5U+QCH1Du0d1yJSnH8p3L01jHFjUUp5Z7H
	 zvNAtkiImR5BLrfdAn5RFvcGGMEzRMH79zncyFKfYMJ2QlUbav427GvGSU5pixVVpmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=ORdwh6jz;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F90606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F90606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=ORdwh6jz
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-862df509d48so1646266a34.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296687; x=1795901487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DsEWEKPZ667fLlA4wITouz/H3FQEAqH5uDyXsTnzdIE=;
        b=ORdwh6jzKQgu9jdwnMyQ85hAafZecEPgMRI9C7SlFVPI7LK8u2Y3pdf4UdakfaDe72
         dqVArYUCq5zK3aVEugtUIxD+4wN8+5J+y747ZVWN/ON+ZMY1IOxW2dXfSlI+uz2IEsbR
         udH4HVuXH9X847LzjtvUs5QfK6f3fRgNqxxIxhnudwEpUm8VFCqXUTrgyrMsW5gwCyZu
         4ESBPC49OdcaE2hxuPM7PW0yND6WbKZBnVN8M5npZc9Z25nUhnkMygPmb1+iM9A1Kl2x
         ioj7DtD4fEgCgXOTG6eQEOxzVNCsjqj+8ucHGvH4Obbwf0WXXilRMRnXv9uDwUlwcxO9
         02Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296687; x=1795901487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DsEWEKPZ667fLlA4wITouz/H3FQEAqH5uDyXsTnzdIE=;
        b=qP/PhZzlMzBRrv0dVItVq/MSmsjz34Pry9rF8xzvDRx6hhZv/KpK/6JSfQ+x7InZey
         HIlS1VngAOVvjQ9nv/KFxZkSxHEVEYmMvTotPvJi/AwqCXkFYGdHZ5k6uxvv/JG1opx5
         Ikrd4ozAkZdll1renY8wDUzmLKLhD8B1s26PnfM6m418Epxp9CG6ApXL//M8qk9XlXQd
         Gh6I9OtltXR6GNcgbvQBAqOyQ/oTe3gdhPE/V0KGMjxr58D+Imy3oQraov5k+D7g8g+/
         p4omCb2OwG+F6v14RPzLLOV797SyxLuYxsorPpPWR+9W94EM3pr87PR1xx79lKEeqFgm
         14pQ==
X-Gm-Message-State: APuU4Z/2UawfK6A/B2yx08TLesuqbsC5klJwPQ/p0RLbEpG0P/o18J2D
	ByOEPAuDjqPZHPFkm1pdOAh3ASrM/sx8upnBc5dSYgxOEVoTXE6i6fDBJen7n95RMOQNxZGX5xl
	M43GzR+c=
X-Gm-Gg: AZFdTZfyPjb2P+pveEl54rTqv7ph2FadyODmdbKzK6oEQjL8UcJRk8mlaodde3qMdGG
	wdPeqiK0+DquWg/wgWqMoVFVtiGz/XN146QZX4knwGCjKwJRR7iVysLr9FU7CBa28wYi3KKunNY
	LFo69LMOrMNjfkoYEEJkUR6muJDworQ0C+KlvzzG6EsHnimCH4ZGIWRkWQkw+BK34y5zJsnOidJ
	rSgjji1Uiozmdl83dxEK63IE0Wn18udbJ4FJTqlnsEdce77WKNFb/ny2Wfpiy7cF6CPvyv+Qkec
	OzTyivywTXmaZ7fahxEJwnVQWvEB0RMVDYhfxh7C1cmZudDuu38EBVZ2mPjhuhmpwK2I4eoqX3G
	gcX47wRaNG6d/SA4vCEAml02f1w8c8EjOS0vATCWCrT1SoDj3UxXhGiZlzxQdbLdNrCQcH/6JYJ
	x6+5h8R9lfljSJ7yIwuiy++rafjDLVNNfdQrO/DcIvPH/oCiPKwy+Hy8A0ue5Uc6NIbmLplPoie
	zcS2VBuOMVOqGT06kJSmrZ9fetEDEYusVecZIbWYl6+dS74Bkd4aLZsGt45J0dIV3JQAmNVrrtI
	/hNFAnflSd0s4MUG13WwFhWD/0aWCvdwkqL0QFDg6Xx9iWQgov06ZmHM81ZQ36xGCQOmL69Jhsi
	Jhx730FkNeG7KyiNOo74jnE4NZroN4bMic6yh
X-Received: by 2002:a05:6830:44a4:b0:845:8d86:9f81 with SMTP id 46e09a7af769-8631549a916mr5941886a34.6.1795296687106;
        Sat, 21 Nov 2026 13:31:27 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 3/9] io_uring: fail soft links on negative IOU_COMPLETE results
Date: Sat, 21 Nov 2026 21:31:15 +0000
Message-ID: <20261121213121.1789042-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

Commit 9ed19503a7b34e1ffb2b81236843204c473b0ae0 upstream.

Handlers such as fsync return IOU_COMPLETE with a negative cqe.res.
The old io_req_complete() path called req_set_fail() for res < 0.
After completions moved into the core, that check was dropped,
so IOSQE_IO_LINK dependents kept running after the head failed.

Fixes: 97b388d70b53 ("io_uring: handle completions in the core")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114041123.109163-1-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.12 has IOU_OK rather than IOU_COMPLETE]
---
 io_uring/io_uring.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 630b306a849f..3f8a0f7e84f6 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1789,9 +1789,11 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	if (ret == IOU_OK) {
-		/* not all handlers take care of the internal restart codes */
-		if (unlikely(req->cqe.res <= -ERESTARTSYS))
-			req->cqe.res = io_fixup_restart_res(req->cqe.res);
+		if (unlikely(req->cqe.res < 0)) {
+			if (req->cqe.res <= -ERESTARTSYS)
+				req->cqe.res = io_fixup_restart_res(req->cqe.res);
+			req_set_fail(req);
+		}
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
 			io_req_complete_defer(req);
 		else
-- 
2.55.0

