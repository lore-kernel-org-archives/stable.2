Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296721;
	b=KPlSx5Jl1f/szCMsjjH/WX6WNU4yy6esm3N5Ch+kMcvhf40OwefMzFHAtxkPoiruNAsP
	 8fyDJXlOmo4EKLXPq4CsHhB1jFLiYKImA3EmwIJ+0E3l6R4TykJwKtaVuSUrlF6JzEfxV
	 53qAT5ACyjnIst26Y8xVr6TY/RA1AGzl9idKphmPy2xjNRIMfgU0h5FQb8QNv6urjZGjw
	 YpmaFkjOrVICO3VHvY7ObywYKd7QW6kgxO41x35NM2MGJCUyTkXijq3XdhNLhKWqCCl9V
	 0t8PVx5M0J+85qODmFEjItLXwMvO/yRJn3B9PVv4PY6S2lHQ8NVziLIz6zQ4weOscaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LJ2ik1UOm3MKcvbJTiXhZbWhx/ll4aJfouIJSEhgf0E=;
	b=SkPJYU5nKuAlWsP+OBemQ8l/awPmZXAjYUoT9RoMiLd6OzGZB+oDohw9VLiB+wNDo7nQ
	 0dTmYcC5aUsoztvyJQnFqCVwLPtZz+KdPCJ5L6wzPYqlZYbT1h+AHj7KKcSchFkP+8Try
	 VzcC89tG/CNpmdIJzjJbLsqSovtJaxKaGHknkuZT4V+CEb2Ji7cIT2azrf/Bu9Vl55UIf
	 5tUewt2hEgHRvaRS/7u51vZ4IXe246zh9PIg98xYxtOX/AX5wp0ckpkvtFjhQgczEsRtt
	 dPG61H+RymayVwNL/5RHXRNymgV3bj5L+9WDTsYRZIEkndzLjcvcLp1yNK3uL2I5HXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=UVXRJs7J;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B2606A331
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 385B2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=UVXRJs7J
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4af173320f9so1299868b6e.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296720; x=1795901520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LJ2ik1UOm3MKcvbJTiXhZbWhx/ll4aJfouIJSEhgf0E=;
        b=UVXRJs7J1ZQNzVNFrGS7jXy+eKhvaQKcFPAeIJO8eXAgstTTH8knikWctal6lUOzsK
         uTYarkCDiGbwbbatZtDtJ+J7XGyNlCYQsNO8Fgx1B3LnCmqOrnkcr86lL2u5+OghUVgH
         eBuqPIW6Rwdh7x197Exz0cFudzkB1oAkid4zW2mfDak8d75zRz11SsOqDL88GfZqkNMk
         De1rGLmyC7/3gN/0xmOvCCx9q5wGw/uJFYHTu29pkQaMScyR1/1Rl+2unL+FW8sO3D2D
         19usm4NujYQchaPPqFHlwII+f8VaEnWLUX9lTTuhNTsuxLH8wmq74PcHFsMdz0RDae9H
         2NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296720; x=1795901520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LJ2ik1UOm3MKcvbJTiXhZbWhx/ll4aJfouIJSEhgf0E=;
        b=l2Xta1fceHNxpBDoVuS5VdUDISycQwDoc36F4Moyl1CFAsY8PCW7msn26PNvqvnXcC
         akuro+6vb9Y2Ux+thA9dloXSZtzrtpvOv0IHnzPcmySmSF+luH2COtxCFxNLjEYVfv9L
         8+gwLGzsTRnbPR3lVg7EjPuEbsC/xQ0ms9VpGodTWsEcrdxSr3YuaTqnbzhEImCkS7Q5
         vUVNwcnvanTYOIyzMzBWfFCKSa6M5WqB2I2JB7aG78naDREcFss2Z7Cw2D0MWF3mvpGI
         3rOBq68Yz8fx9h6U4i4GyJ1cnL2Rjk98ujNhHOH7ukacgTRrbeCSZRdWEpnODlGwJ7Ti
         wsEQ==
X-Gm-Message-State: APuU4Z+7ir+AU+MVpJUA0NlbXIhyflGQH1nDcxu+DHEcoCM6ZsFB4rb7
	WP88xHgEYxK5kyirO8wd2B07FYrpD+bjzXK3stLVCFKSmUy948Bc+vLSLrH6EY4XreO/JO7WnQa
	XgRmDHpU=
X-Gm-Gg: AZFdTZeB1p0W4Bt/upenjw3EgrMLk5V4OGe9cmYbN/abEOpg2NgGXYLckRfhNlsjCUZ
	9c1qkfj41sKpnnLEcPn0l0UIRYcOM7ZXkucpRm0L/jCgvkmf5nv3eUiKtBfsVKCl8V7kEHoBW6O
	RvEPjQVeOhtCwwLLtZr8FOOaNKnlMqqSvYZyAc5yEW9eQHOPDkRTO231jQV/Xxw0dxIJzXPsMOu
	GMb1Z1ymrKqB87XTz2UIfZiTXASR78tQvK5MvJpmt4vTBqp8/T40Y24Bxnem18AhUsZbyJzWtN4
	XJ8p2rdGAVLxSTU8A870qPPXacTrqkeEF9BeBoT5D9AjGA4hZRAsodUt8E7Tiyoox0XSN03Xnlx
	yySY+iojiwXj/o6heGj6oPm54PPLaAUh4ulmsrPkh4wgCjV1SOeMQYivAnbZhF48g43SOSGJXvq
	QzD1yLMispQWG1gT1asWXA2ug/rpWBnUuOqO5AIH0aN74oQD6Yiml+0AW9Hzaa1AomwgCZYeTlB
	yhTG2KqE3lcxcItsCx+6oYR+SW5h6DWKRZ9WKMh99TfLPM3Q+8cycqCIITjvpscHI3lXKRIHagW
	TEF0k/RMdpaRNyjdxF3eH9RLcjOEz/fgNR1q2zD4Rd3bUI6IZKOJlDfzkHbe7P0r/tW4ldEko0+
	GrtAgOVuhLSkpflcVueyRw368AR8BLqOpI2X/
X-Received: by 2002:a05:6808:c2bd:b0:571:a186:d6a8 with SMTP id 5614622812f47-57a0a20acc0mr6928829b6e.17.1795296720117;
        Sat, 21 Nov 2026 13:32:00 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.31.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:59 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 3/9] io_uring/futex: fail soft links when cancelling a wait
Date: Sat, 21 Nov 2026 21:31:48 +0000
Message-ID: <20261121213154.1790334-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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

Commit 9a7cbe50dd95594d6fb3c57b8454ace58d8d8d0a upstream.

__io_futex_cancel() completes the request with -ECANCELED but does
not call req_set_fail(). IOSQE_IO_LINK dependents then still run.

Fixes: 194bb58c6090 ("io_uring: add support for futex wake and wait")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114072246.741950-2-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index 9203998654ff..8a85ae20964b 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -107,6 +107,7 @@ static bool __io_futex_cancel(struct io_kiocb *req)
 	}
 
 	hlist_del_init(&req->hash_node);
+	req_set_fail(req);
 	io_req_set_res(req, -ECANCELED, 0);
 	io_req_task_work_add(req);
 	return true;
-- 
2.55.0

