Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296613;
	b=hoAvj1+aEH/VdUz4Bl1R6Ulve4iAoOVyWSpQOAUIxPpCGGvRp8zqWifUS4UPpd5TXPk7
	 CPk1GiFeIhQkDbC8+Drh++zqbgg2W+tpEN00iRw/KBQyzOZSPbXcHcoy1bF4zC817HoNx
	 uC/Vh43Bphk6B3PxjihwvXTBZa+eDz5kmmARxDf55cKsFx1un72+tMl5OKQDnRTvBsp7g
	 q1wkcNzqFougOkXAssbGlu8eensBB6SSqT11csC9I3FySfc+T+WGIsSBw8oYjR5n/DwY5
	 /kQNfnoe5ncoEn8lam7dtQkum158rjuka9yB12skna+ISQ5BdevcEjQY0zzuONtmnFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D4/7icXEiDdm5+VTPLW6jSFYJ6Ug/L9zL7OUAsP06I0=;
	b=4Lyh41D8g9/9R/C+qWwtpgoy9psoFeH/rA4m9D8BBolkVTgmrJ2T3RpumykY9i9+G9FF
	 55BMxThR7xGFJOZ9xFi1yX5bTfICAxhN9tie9VEYbW7P+hvrWqvMlojK9xGHgQPhGkbVW
	 WUE+iyMuIOMmSh/qNS11Ch1QlWkgrUxE0eMXMo1JbEBNLHKgscJPW1gedb5gCM10/uY4o
	 jhoN/lAetv42TzyhTDoJ4Qh3kO3Eb13L2hH5UKcZoN+ZICmG5TXhTnECpCJOFZjfaKNbM
	 0f2VKYXjN3Ctib85OKWM1PAnSt6NLiyS3EyVXy1UMAZ68qIXcm4H/u9ElvAKUyZPUgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=YstTAhpY;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3C606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C3C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=YstTAhpY
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4ada9579947so1412734fac.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296612; x=1795901412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D4/7icXEiDdm5+VTPLW6jSFYJ6Ug/L9zL7OUAsP06I0=;
        b=YstTAhpYfECJvz6NWl0b/8oXpCgBtesqhziLq+mWKrqypZkMtV6uYX2Dalgq01vFtk
         2DRkMwOO3n2Y0JzUoZabazskckO+k95o39RKhSqhp5AbPXAq8p2adBsc1SsgdTxaieZm
         f81TOraiFiS1Z6F7s4Xo/8YfssHloatbh7tuDicplVP/2vj90SPrg7gCwSQAZmDyaDwf
         kesTOkjc4fkZECi/sHMkH4uMEX8fGuT/qKlFTdE4TXrcqdK8HIAarK+HAsGO7o8lAlWe
         T85lptN0sqndwp1BVL+rCZRXkpixcINqx3WNdA7xreAf6GX4LklJi384Gm8gTD72c4/9
         RSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296612; x=1795901412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D4/7icXEiDdm5+VTPLW6jSFYJ6Ug/L9zL7OUAsP06I0=;
        b=fDfSz1Lec9VFNGupaJfx1BsMcsHjxNJgRKtjfO4kKKcQik3/jf/mMMWMH23e2kZX5P
         IOoXnZwbKwt9PRQwEF2F1DfROTH3gY7wzefvDVzXm0NFnceQuRoMaF+JdbfELGtJXhvI
         sFVA8tPAmHptlnG1aCfP1EGAG3yPUOJvG+qKQCjB/UiDg+Ux+srWfbtX+1eXg4zF3kai
         YCNkF5qyVMsbkjxF+XDTP0kD7s+0g7m+24ZfAfQ5MvslCU/qSVudmU/gqeChPNcTT4X4
         ZeyH0wZM9Fh3Ku4hKez3E/kDUwiOG5tzIgVGEcQnaVKcZ5e9pLjtgalHKgqzyIL0Zfln
         uMog==
X-Gm-Message-State: APuU4Z+fiXlpSbgsAMwxlBRKUxQovFGqtAmOdAHzXMjBHftu7KeKQAlM
	WlkXi6Y6Qrw8VLLlv1TcdC4m4KwGPwcIrBVf83Vu5izBUUG3SqVab6MtN1zZLDYROzg5mqijsrF
	PpSqp7b0=
X-Gm-Gg: AZFdTZdkySXbZEUlLy67TRejD7ZmpejCh8c2JS+iM7b4kUr0aVjQuvCRscz1ND0d0Bg
	YaJGhZ/d9bMKB5J+d5Yw5BZPCOT/Qlo+xmKNn/J7+81nGKk07nIiJ3Btj7x9B/+9AwvJwDozQvp
	H9wDa6OdTTWx3a9sUR0g9pXW9/lhuONXJPRW+sy9YbI5CxiFjal9RpOJFvdGezY3fZHpRIAYcDu
	Y+EDLi1Jl8BAdrXo9l4Z+sBQRyEjVhuO1Y4+Z7RtgLgMtyW5mPaWs2DCkEa7xuoKLsA74ZZwgH2
	wWl/CQmsbOIqV3SUirBwNYJbNUD9SmWG5450WraAB75a5HyP97NEixu9tacUTqM8T6vdrF3t7HT
	T8+9E5AMX/oSLuz2Yb9xN6xuIEgjhWbbDyvfBkCAmML8VzpqadhqWXWtdAO/2Ue75knUCaBx8so
	LQlCNW5Ap8EGu27M0wePZrZTCelmDx1PmQv6aqAtyoPo3zN+uOX8/gD+p0W/hmMeLgN5j9cjLDk
	XNAOcgvJU/t0vhi4CaiLX2mMg/z34Z2h0uEQlwQ9JM9t/uS/qIW2/EYAClyxU1DwpktJJfaDOAM
	p3Me8npaBP4F0hBF06XJ6pvuvM13PIr5MGKrHXxWugGnfawsmA2HqdKZedBEZjrVfIICNHJdZgn
	Q+iJg8J8FuYO8IzDo/PSGyqHLodGgr6lx1URS
X-Received: by 2002:a05:6871:e809:b0:4a2:c175:d339 with SMTP id 586e51a60fabf-4bc821950bcmr6394435fac.39.1795296611583;
        Sat, 21 Nov 2026 13:30:11 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdbb4fsm6110825fac.5.2026.11.21.13.30.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 3/4] io_uring/rw: fail soft links on IOPOLL short or error IO
Date: Sat, 21 Nov 2026 21:30:05 +0000
Message-ID: <20261121213006.1787626-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213006.1787626-1-axboe@kernel.dk>
References: <20261121213006.1787626-1-axboe@kernel.dk>
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

Commit 4d3db66c5363dcf42c3d43ebaea330ac2d1888bb upstream.

io_complete_rw_iopoll() updates cqe.res when the transfer does not
match the requested length, but it does not call req_set_fail().
Soft linked requests then still run after a short or failed IOPOLL
read or write.

Fixes: b66ceaf324b3 ("io_uring: move iopoll reissue into regular IO path")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114072246.741950-3-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 reissues from inside the res != cqe.res branch, fail the
request after the reissue check there]
---
 io_uring/rw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 8c38449dd7da..268f4e923997 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -304,6 +304,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
 			return;
 		}
+		req_set_fail(req);
 		req->cqe.res = res;
 	}
 
-- 
2.55.0

