Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296611;
	b=0tsuKrEkNZ8Q7fphVw24E6mg3abr3/W+J/Lp0u/CawQLFAlRKWVC44AQKBXpRe3OUfgk
	 W11w++GXBCGW/QKzC1CGjT9Rk+6DGLEF8as+2V+Shz4dC10bshFnhpPWkRrUJSWiie1j9
	 DPLu6bpyPoi32W/T3YhrqAUv+fFf/nHAaPH+Qc4bd27OkbL+RDAZFMD6pwUXUxorM0uqz
	 ObwXmk7WS14intC+Pk/8Zhbgrhh45i52oSejheO281stjhwhORLtDy7Zb4dva84pMIwgG
	 vdxuVUqe+RueK4LnVGnidtCnsxRcUv7bYtcbkQDxLQVaxLGxZwEwJdnG8NAHxUt3bYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aHVBDvWOmwailV99bZ/NEYeAuF/ktJvS28MBzAqThNg=;
	b=UC4OlOQC9yjoXfrt+A6f7IT8kotz14thTXpa2Dh+Jbp+bvBNa3f/UaODs5/EJCSNUxtS
	 Ha5peX3FCzUjN/cWUXNsqGIxKpauJcnALbjQgkT3A4a1qik3t7gEG0croxZ02sMyO9btC
	 TjJcwicLcpw5sEOK/qK+1gsu5fcc1+0Ox0zngXIublET4BE5X3a7wE1wwGFTARQCOXMA8
	 EDfjbcf/DCbSHB9m5QTLu7oh9tJeQmS8ygfyguYqzluUvvDrHw4WiIHC9SvXf4BCRp1cI
	 jrLbT9PxSfQ4FrOVKiqnMPbbIjoJABf3+jIIKMnCJGrdwaeRNeo2TytV0BmFOgbv14Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=O7Frwc9N;
	arc=none smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F74B606A336
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F74B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=O7Frwc9N
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4ad60ec5eaaso1920537fac.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296610; x=1795901410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aHVBDvWOmwailV99bZ/NEYeAuF/ktJvS28MBzAqThNg=;
        b=O7Frwc9NbhuN+si0vW9RwwXZhXBFNwdh6NHlq0Z03749sxKkHsTF5S1NdLj7JABCMw
         O1FAo7dwrCtAeON3KyPMu3RbA1yzwWIJNZ+q/gR7MvtiKukx2Vux+hgHOKx1dJI48UV+
         y1BpEqMyCskXuVmhNKWqbe2nlXb/Ia/tHd/umZWuZVNXEDEymGgmTH0ZNGHwKw2/6pRi
         opNCGdLRt3iAFlWgYuExUU1xqb8davFFuF86jti1lTT+bfcwlMDyxHMvUAGMPeecC1TG
         VYGtb5qDmfe3kOjyg2ZSoHGd3q9fXqJkIEZanDBLX1yFWu4Dn8U3BcgvCvW5625bZ5E0
         ezkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296610; x=1795901410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aHVBDvWOmwailV99bZ/NEYeAuF/ktJvS28MBzAqThNg=;
        b=XtEHYM+7ZeUC839wa2Cpa6L9H5MG9fiUmsRuBH81mNiTvvYjNjEmhZdzkUBxYirYK7
         ssX5aUaxoyhviYrAFB1IPU2Ke5bFPPk8S/nhTgsGEFT0+MAHAqv60Hy4ayJ0R4xxUKV6
         HwPT+k7kyoypbr6EW2JHILM2c5bbTsjsbxcumHOmXKaJSRRf1OixeEmN9xQtmFU2leA7
         RsHapILQA/MnpEQgae9tozNqFBPUtG5JPbyqHmHae6tWR0l88aMPhoHMuOkw1RDfSo08
         xVhVT3041waE2HapCcgVLRztlM9dipJKhKAaYJnz+JwE53oOixVhBxwdyhLHmZ7DsnvC
         uKJw==
X-Gm-Message-State: APuU4Z9O7GztTYhXQ2ZReQySuRZEl+r68fZctRm2IMsng9F2vGTErlHd
	NThmN5FrjAYLDDgB5YIVqeKmMHhzuEJ9gclNuJXzIRsUTVIoTfEchMHb4w7m08lNr8yOI5Sh7Ef
	Jrr6+Hts=
X-Gm-Gg: AZFdTZcuBCmC/3ZzYHq2uHp8bDBuxXUNuin+Nhpk1uJhfdapUDH2Prw5i73Kc0ASDx+
	xJJSUj8Ef3rO/CPKEZ4t15BblQxv41V5q/ciIpUBoM/CoHzmfa/QLO3hPaMwvmtZOrQziTfcAnN
	Z4DFWU/ho99Y6OdL8dfPoJz4ntJ0nMC4lEfwQZh6otDBbjXeA7kzNF05HxJyqX+hlPHnqCshq42
	taW7kfBsHnGZNl3Lpgc0NeZq8n54UOP8PoPTXv4vIKWQi899ARVl0Ozdx9gAZ2uG9xUMK7vSmWK
	1dRwHdsb/gyfD5EsJmOQ1aeVycuJdLXEb81RisgWG1UkZZiVg+lSy0NtHyO9jr1LDdp54oNh7si
	15f25nBX8wdcK1brlIXqzd1VNGNNz88oqBEMxORUIuyOag4ylOtKUajHlsSqTehuQ3WM0vX4ZIb
	kxTB+phxcNQG18rHFD5KzubzhGb/FlBVq92RoEaJG0Ing41rimrzWaQ5gTOz2rr67xZO1mFTrlG
	yu3bngiGR3QYfh7du3DjqDsYsaDXRgxU/ZeoaQtcr8wCrMG3iZ1fAiGjdFVpSyawjezucZKCA7B
	3qslwMreowdX6GGnuQ68SkGApKYGIQBPCw6JZ+bBiNeDQpqvHRGJnBtJAwJjJexqULX5b4sbXKJ
	cleVJBlw7dFAEtwWWdIIqtWB7vXL+zPduZeTF
X-Received: by 2002:a05:6870:9382:b0:4ae:2a8c:e9b9 with SMTP id 586e51a60fabf-4bb3adb6b8fmr4843661fac.26.1795296609979;
        Sat, 21 Nov 2026 13:30:09 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdbb4fsm6110825fac.5.2026.11.21.13.30.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 2/4] io_uring: fail soft links on negative IOU_COMPLETE results
Date: Sat, 21 Nov 2026 21:30:04 +0000
Message-ID: <20261121213006.1787626-3-axboe@kernel.dk>
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

Commit 9ed19503a7b34e1ffb2b81236843204c473b0ae0 upstream.

Handlers such as fsync return IOU_COMPLETE with a negative cqe.res.
The old io_req_complete() path called req_set_fail() for res < 0.
After completions moved into the core, that check was dropped,
so IOSQE_IO_LINK dependents kept running after the head failed.

Fixes: 97b388d70b53 ("io_uring: handle completions in the core")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114041123.109163-1-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.1 has IOU_OK rather than IOU_COMPLETE]
---
 io_uring/io_uring.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c59fbe6905de..cedb21c1295e 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1756,9 +1756,11 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
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

