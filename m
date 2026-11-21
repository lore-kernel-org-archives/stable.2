Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296705;
	b=v3xXJlVKLYUcmC6940R5KSvI/FL+MWv4ko1hpV7RLnVPMwnQ9o8EAFYKkdjNWKsrzOkj
	 O/G168SR/GcWWLSYjeEiLFiMjhvU79DCUd4LmCg+WUousbl0+JeNgYdrkPn7qrBg8Y6QG
	 7Hw1J/npDdD/MCji6GE4YNslWsJ6GtL+FLpwwSDI0dZazSJW5ATQzOgnEip4UTJnQ4Cgd
	 Oe9q6dYHk20cx0tdRBp8y1XI4NdDNO6MjhCFlIRG8rBo6iIglVEl9obHZffO8sSaJ1rrH
	 i7JSV353Dga1FtMuv+4MzAkwQQaaxeRLWYd6gntsmsaGQl1bhwbS4OR/9XJCYQ6yn2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AlZliGV21Pfbn5adqbBiR/1lnKgw5vwILbM3uHvr/H8=;
	b=RCs+HmvYzQaZoiK5etaRh6xf8+xNwvpiXQGE5TbDbCinvBy0m+3fN6dFTKAgJisMLwz/
	 mU5JAQP+ggAJf3jVQVxH+wmOPB2nDXdnCV9dnoS8asTTkah1Rh1GBCohVxS2MCXv1YWkw
	 Z1Kx1Y7p7MvLVWzPTsrw8Klcml14M3LhPs8Z71Sa29V8W8bMlrOc/J6bR/+EzDM5tkrpR
	 1oWGS4sgWpEqiPM14qmNyVYzDIJz0UTEmhDRbVgJSZuMvkRm/PYRRwokyROFu/6rMt5fB
	 prTcSS4kCFFRZ21sOPMD33GHLOzuzXZI6+lzesR7wgn55Zpaufpmwq/IXymb48uQbag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=jGiSkfuW;
	arc=none smtp.remote-ip=209.85.161.45
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23794606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23794606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=jGiSkfuW
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6d290b10a35so821457eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296704; x=1795901504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AlZliGV21Pfbn5adqbBiR/1lnKgw5vwILbM3uHvr/H8=;
        b=jGiSkfuWO7ylpUg0DqN8aH1BSP9Db20gnHQEl6YrfX91FGT5AHLLrOhU5/VF6r3W1T
         YhURKdBNqoSF2E8JeTVXsEHJNpBrG3+leHR6TNuxGxzfeVICOGAIntZktTF8yHCGJilV
         pmdX9EP1IMJBWnNQmoxjE5v3MfoBCxUpF2zjDOOkv8pNdwDFLxAUAkjJH1o7fzCoBvY5
         uFSTVqPvZIhDkic/7HaIZswFTxN1QEQUIpx0Kegdpz/pKKPvX6JTHRkCSErk8T1rTOUs
         Fovprtv9EOovVcsFFcL/9GZb4NzgKY72SkkCuaxofi4M0+gGgRVR9uhc1vgSnUwuSHMw
         8Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296704; x=1795901504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AlZliGV21Pfbn5adqbBiR/1lnKgw5vwILbM3uHvr/H8=;
        b=SHm2bukEtYEJ9Wz80SrcNR+aSGbQ2jK5om3N+GdVP9Bd3d5GGsTN+Mnxl+o2IVkVaB
         8bjMVN3wNbgZRc7PqAefJqgl6OwctUsqvAiCroD9gP+7cK3mkbvgrlWCc2jCLR+FI+/Z
         AbfTikxfab7elYxSbxTHqstqM5GWCU9hsn2EqGVUn81DQMin5dbaVUcE+gkg4Ag+AfQH
         KlWi2Kqu3TWfPIYjvjc9VMasfvP68YubKWd79VzgtrjaP339U+oq8tT9IQhs7e3uBNC5
         rV8Xp9tJjznFi97c0AhnSiRrOky7uvEjrpj0be01Qq52O3XqBaPYKScQ8UKmYsuE0Ovw
         Livw==
X-Gm-Message-State: APuU4Z/EfXlnEYKlG0H7dBOk0rMolU8YF3KC1h3zz7HjKwx1FZ0TsONm
	EFxFAc4r2z8bmAA/zJWnay2YLZq26YZUIlf8/BOD/L1Q/pG2BZ96ZTwh103PYYxGtpWMHHEwU32
	Ljnu/G6A=
X-Gm-Gg: AZFdTZe2gMryZGKJOl+J0ePy+8MJkAgEjkXaTq/yFSkTq9XPkAX/dsEFyqSUiwS5EQW
	gCxpR/mLbtJwXSBnHvRi0UNyVgnzpyW0+bFs1yH27rn4n0mytU1cj8DbFwZ5uin9boGLF/472SZ
	d4xSEWrELARFgiY3VbfQE5x79b4E94GEqQbSOXAXpMs4qE0Y4yNyinPiMayqDIrx3rgzAF2qqzA
	MAnUECoHIxv9H6/6RqzrNAmMKKkmZPYsQhH5Pt3CQYtYTL7IDSmlWdoUqqUrRCUieDbGkQUkgAQ
	utk7J5vWxumuWXUh8rdft5yUykr4OG3vRaXSemkYDG4QYFdloIZFlIAWQEXU/VpQeoRG9kzDQLy
	PngrRo1Ir9OORrUCtDkXbr4+pqPgs/diNQM2SpugIvzM545L0FkGQbYyxYBTEa2gb0zLFz0RlVK
	8AcrEyv+VYKSf/CW8l05Q45EuL31LDeq4TpvpB+79qv2peO+dIY+yVK8AwOUAUurupOCLSOWlEo
	gK7k8tmGEydcIRCTGyY39KM/YRS7BOAn3WYfg/Ywflb0KHT8HysLrQcWPqKhLKJY75sBvCmqDB0
	OSubAhwxywIXFk5wmwwLlsS2FLjTyV9PH4OWeMXepRO+laBBJ3gpsOVcKi0WB+anH4fWWVOwE1O
	5RvfWTypehTYfBlx6LCxKPbB8i7Q0XiDHNDAzXFSg8qa6DD/UCi63/hJGrw==
X-Received: by 2002:a05:6820:8598:20b0:6f8:a519:d930 with SMTP id 006d021491bc7-71b39480550mr4192296eaf.34.1795296704060;
        Sat, 21 Nov 2026 13:31:44 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 3/8] io_uring/futex: fail soft links when cancelling a wait
Date: Sat, 21 Nov 2026 21:31:32 +0000
Message-ID: <20261121213137.1789687-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213137.1789687-1-axboe@kernel.dk>
References: <20261121213137.1789687-1-axboe@kernel.dk>
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
index 6f756de08705..5986ce2a121e 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -104,6 +104,7 @@ static bool __io_futex_cancel(struct io_kiocb *req)
 	}
 
 	hlist_del_init(&req->hash_node);
+	req_set_fail(req);
 	io_req_set_res(req, -ECANCELED, 0);
 	io_req_task_work_add(req);
 	return true;
-- 
2.55.0

