Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296655;
	b=2XzM47j58KRkbkNJUiZuyndjz5TDsIqpwLTYL9ERgZR2j52nRSVueL2qdMAXUCNoVnUv
	 mR425p5IDSGVFPTsBbBXwCMZQtZpBxdIBmkdbchFidRgRkqJ1diCypQMYB0q4SqcIp38n
	 PlbAwjrfFtbCvl58cYcMsNuGvvEIxgFnRG83aHFRtQPivpB3+kBtDMloqDlhZw8PvSepK
	 Ptr0O22qolwKC1Bw8zR/6Vu53jrtIMESxz8jEzU99jmZRcg7dKienvpNC4o77AyrZIfZF
	 Le/Sbv16Y9Fdxjx7Cfm61Knmta3IcF8ucjn+HyWEX6CDnnp72VSSzbIqp3x/bs0UzHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A5CrNGSqRDHV2QY2XKXTApavOZfq32B8tfn05etWOFY=;
	b=wIODMkTT+RuWT2W0r7lJCRDxhizH5fFTm+mmKAi4IkR27pea1vqjUg/lMLhl8MlDck5+
	 tIyTFS1MccWamUDHhNyZxHGfUvxG84ZQRPPDzexznRVjb4kdxW8EnnIQ/S7Vcu6AY0VJi
	 XCMb5H6ScWITrhibXkZ0IiDFYpTyBi/Og4uhJZGZJ235JRQplLRS1j9bH4PdYRKpwr9Tm
	 QCrfcth3VLdgoevWcUWbX3HIrSouJ6X6kOIGK8U6vqQMAS6tdG/3Gb/m3vew4pyj77Myc
	 KVU/hYQDOurEKfYxHufqfi0feA7ajzHlkaGPkB8FPtBsaqYHFlY27Z1MHOBc+cKU/kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=n0HxhSrG;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADD5606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ADD5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=n0HxhSrG
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-7190d9bdb2cso1356056eaf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296654; x=1795901454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A5CrNGSqRDHV2QY2XKXTApavOZfq32B8tfn05etWOFY=;
        b=n0HxhSrGZufgKJ6che51Tas8noWOC7I3+0qfBR+Bsq3BSwJoRXSkODEUSXFYQI/e5p
         nY9yHGKYDS4ubCMlfFXMaACny2anb4kMaDCJcnrD+7HT+W7Ya+Vgu7WMBv1/CvUP1Yz0
         tuybQWEvIAkoDzWY84iGhA+Ic2x7K1kbtSUN69iCcnTQ3VZfNnooMmGgJqY1TSvCeGqZ
         hnCN3ZUOJDKv80Tuq8ngvHzawdm5V0SfZgstlhjFmN8UN6WQ3sVkRW5JQBXDd81eDE79
         /gAtw4Ucwuoo5DGdlYDHVDzJmTMyTbrufO1Wd2Pgz87SNQpfqG0tIXFinwGXg4m8UjYw
         m+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296654; x=1795901454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A5CrNGSqRDHV2QY2XKXTApavOZfq32B8tfn05etWOFY=;
        b=x4GaTMl9eJzXNSG6ntVLl/N2Vf9umA3h9ZK/VjFIE7dc57DWXf6F468pIkvbLdWZwd
         adU8MpQOSXNas+QIFCWQB8/bdUmMwEgw4uuAhGlYVEyNvjy/PExV8vCYJuCCPkVMB+QJ
         HLpF0Hces96F0B3mpfRP1OHi17UTm+CDRovAOs3i/aU5gl/7mipmScdteqa0WZwCP7Xb
         xEXRDp/dwYFw3RMYSOeFPh5KUa9SuTSkSOKs6BmVOZhhIvNVFbaMSihaECL/lxAfH/E6
         m0R2dD4IMKGacZWPrF3Rrg/cT5GK9ZMvXVFp4SSfvP8cSz6Gbt/KzY4kxSvDI+q8Zjsp
         C2Ug==
X-Gm-Message-State: APuU4Z/Ep1BhGZYBYDXPB6+zg5svLwxrePCRpTyMOsEPyE8pn91p9ihd
	8lH47aU6jE6H0K9F5J8XUYHCX7x4sFOnL8MiE794xdsnZVO/epjcXDABK9AcMz3wTBo9SSDgg+U
	D/ZArIb4=
X-Gm-Gg: AZFdTZendI2f1BUeAqvPdGjMQ7q800y4VboGSts5HxpfrJCXeD1KVWemYvUIauQrI1w
	52dt92AY4xa0HqR0vRS1wZcPzJMG9eO8zeu3YBntHYbEjP8bGMkPTkDVZtcdrHgvvRTCqWX7wtZ
	tf6i6xsdbVeD2kRwuN+TR4VeGTsFJqpqHUcBNzBHjPxmhcObfj79BkbexOjoi+8GNRjoduSVs+U
	n3bBbxxvV29aTof9sjeZmE7EbnIDHI+SuoBG3QbROfJsD1t/1jnO0J9UC+u8ohcDumPtDOScrZS
	9Q1Y8hchJ7KP4qhbGRQB7kGFoOSmmA0Ry25r8gKn9ZvlIkaeHc8+N8MZO/xJm8TOQOgT7kVq8Yi
	gZ3sKDSKXDaPMkghAtxdkqGuknBDyLKayKE2XDCOM+JlH0JJ/0c1t6YnQJwuVRYjlqkKizRxjoU
	GZfqkKYfB9F3Ve9+tSyquzARmKBmISjBPZK8TGHyc89WJ+BC2/ift/x9q1xuuB0X7ZtdyaqKYpb
	/HdpXTI9qnUh9M0Usnud2Mb2D1oM5zhiGaPIogb41R913RFCKJB80rFC1lebsu9qpYmwl/n0FXC
	u9LtkuYK5/pXYLRd5yls9GqiRq+jr/0k2A4R3qA3hZiGbxRJv1Rbv0IgJbTyWII978IHHiBrzo6
	6c7Z6YSGHwdSTKmYWiX424lEesqjz9KLcrluV8kuBaifcn8cgp9BvFpTq2A8=
X-Received: by 2002:a05:6820:3410:20b0:717:da:ba40 with SMTP id 006d021491bc7-71b394956cdmr4082759eaf.26.1795296654033;
        Sat, 21 Nov 2026 13:30:54 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.30.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:53 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 02/19] io_uring: fail soft links on negative IOU_COMPLETE results
Date: Sat, 21 Nov 2026 21:30:32 +0000
Message-ID: <20261121213049.1788332-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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
[axboe: 6.6 has IOU_OK rather than IOU_COMPLETE]
---
 io_uring/io_uring.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index b14651c187d4..8bbcab4d1d7c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1921,9 +1921,11 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
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

