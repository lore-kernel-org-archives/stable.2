Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075070;
	b=31bfE0yi0kPu0bJYug3JHnFyLOkOuNP1SQf1EZYqkaMLuVxaHC9EA0+geDUAbzfIfrf8
	 6cLylyJJPDkvqKb0yE+8uVKbh89Qa+mwQAFX3cnQ+9+zJiYrXFJHY/pXg5rjfTBs/ShhZ
	 Kt+sTToEtN6KRBzZDERdL+1cgxb2lDw9aodq1ixJsSMz6ClRj/ld88mRxRVMDQpxfBlZ7
	 98cfpiByxtH66yoZ/F8c+6FextgRKa+OzeQ83Vx+33DTNAY9kR4FAmOX2bGYsuQR9DKJE
	 TgAax48+XsL5tMFm/0hh73MJz6hQXuNzRS/zqjmNkihxnDFXukmGvvjrtrBT8AlgMzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=54XwvnTRZEcAZvG4/CsgVJ6fnI4Exs8l1O0OeDpAayY=;
	b=amw2Qs8c1K8GteqFWX61Z6JQ17jOK/TBtNbPQQKauod9qAvjS0WibbHE1hqenJBQ3g4r
	 saK5uiS8ikakYMyp/p2JwO7wWHFWpRZSCGHM8IUL/GiUAj2TTP8vI6s3Qk/k2WxdCQkHs
	 eiWh5b4feyGFliK90kEPWKfeqQVf+DmxCp1uLSScft/rtR3gNphyfNlcw/7e6eXYlqstx
	 JGFMDhRh2RVDppT82EuuWcLBmNoCG9RT4hHezxzbYDM79cIkVmhhat/gPFyfjU+stjw6n
	 hIbSlq0BXzmTGqpG/TRY2N23V163sJVgmzDXPGg5gQWrlFRK3hASPC0H6acxhvRoZlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bu1us5l+;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78E606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E78E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bu1us5l+
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-492f563d1c6so687883f8f.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795075068; x=1795679868; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=54XwvnTRZEcAZvG4/CsgVJ6fnI4Exs8l1O0OeDpAayY=;
        b=Bu1us5l+m9et2LjpRBEU83OjvlwVzVU/tCX1OZB8FKp1V9vmlQH9DlfXwUjA4krTbj
         brUCQq54mMSUJZVUP0qjSqEReWeAigPEvgJpmskrc57kfM3icLp5ecJRypv9mqc0mWhz
         PM7a5EVU/X+ZMZ6/H8QTcfhUaz9llKID4WLMWmr2zb+zwuLQBHgZyC5T/RMmZlzfeYa+
         3bddOkRTLlDXG2FjQ7DuKkTVHw4/k4AIbO9NncTJeB0naw42fIKzwnb9+5vP8tVcOnE8
         BwgUwGmNorfdpIVJzQai93RgCPG/3nhWspHs/zvwgy65nU7lPJlFo4SziCP8mCooVyuo
         cMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795075068; x=1795679868;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=54XwvnTRZEcAZvG4/CsgVJ6fnI4Exs8l1O0OeDpAayY=;
        b=PXrwgXb10artCreRonWQpa4XkH1UQO64QHHKGg7UIzGHG84/Dyywq74PVs6eIDld7y
         upi0YG9QsWbVPVqD/JEpIJlWY/yhtDuyYIK7xH2oL2Lg7xflCVso0dArt1C9zNTnTwC0
         wjuZdUjF7T2xyPTLAHZ6OrrwMOuX73sN6BPGubMs86pgdFpfY5aZYa+2DI3pJD5t16oT
         lYSIw2loilNIUgNjWIiShw6ImSrPTs9khhp0p3rLgCePPi5pv+Kt3QbQJtO6AlizPbg/
         l3N2HC8gGLNjNzcL6y6cPARBxaHDH2DmaR/afQNPr2AyAzYK/Js7CkMJB6DnXOsWa4ZD
         OAlQ==
X-Forwarded-Encrypted: i=1; AL+hErEDhyxBHkvpH6FZDCGQXCWpvJ3REkKHFKkVvgxOdSGFVJSMehVdVw5yOapUZL2jWNyR77k3M0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IceqJiEV9ZmmImHNnmNj71AaDp24OYtpSEo9XyA8Sjmzj4SVP
	iq6RuqyNWLndQ5sYeDY3yi66/evyvLCoMxkeHpl+8agqafeGnEIIMjMg
X-Gm-Gg: AZFdTZdpXj9wG/a2aRaw3TFEfAfZznYeKH6Y7q06/7UnLC+7B1OCqNvhwFi+qSTi52c
	CzTyujiVY29ZZiaopvLIpLcq3NrEcD0buUwTNf6++TT4Y/5vnAgFsioLZEvONWBLtWKW5TUGb91
	bnTw0sIrlhuaGA6U2XbRFaESMnDShEfuSL6re5Kq3F3kG+7hNpeTv7r9dadW+mN9/h8P7wnbV/x
	Y8nw3VwO0oHwBPx5cYbx3gAI5Jeqwpr+mrAQGjUXg76ov+iQIXiQN4H6C3D/xJoMeMk5f+fdTDm
	YQl7ODicZG+tUpOl9kjhxuyzUs0ftA4RbihJjUb4qkmGAXOGYg+nQNZnm8k7NccR5dgqso3FUFR
	DiIoNG1HSoM830WATvJVOlhjrjzqdt69M3+PZbVo4xLOtTZWFlk6aHQ5Osmo4S4CT+WTmuW3rhh
	zFfrRleF5KZe5KG+LoqXmfs7Vs5d+zapr1+Pv/MHEXebQCkCQ+IzSReMZ27jQRzU+S/dgCxNDO2
	dLsSV2LDm/PLva7mik4jeLxbqltdh36TnkR1PB5LMxyROV7mnfR44z11oyCTn6HdxXyfsIXu7p4
	TEYopdKzy2XFYocIijF50CsSpr5tEnPToOoNsCeb1iFW0ut1Sy0asKNy9Q==
X-Received: by 2002:a05:6000:4555:b0:4a4:7328:21f1 with SMTP id ffacd0b85a97d-4a63ac6be9fmr7344622f8f.24.1795075068411;
        Wed, 18 Nov 2026 23:57:48 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a654a8c411sm9450116f8f.16.2026.11.18.23.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:57:47 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 19 Nov 2026 08:57:42 +0100
Subject: [PATCH v2] mtd: spinand: set request type explicitly in
 spinand_{is,mark}bad() functions
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-spinand-set-req-type-in-bbm-functions-v2-1-4dc4f995dfad@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNTQ6CMBBGr0Jm7RjKr3HlPQwLWqYwiRToVCIh3
 N3KDVy+L1/e20HIMwnckx08rSw8uQjZJQEztK4n5C4yZGlWKaVqlJld6zoUCuhpwbDN8eNQ6xH
 t25kQBYJ5UdclVUYVlEJ0zZ4sf87Os4k8sITJb2d2Vb/138KqUKEtqq7Uub4Zmz/6seXX1UwjN
 MdxfAGt2xLY2gAAAA==
X-Change-ID: 20261117-spinand-set-req-type-in-bbm-functions-34775e6c14e0
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

Commit 701981cab016 ("mtd: nand: Add a NAND page I/O request type")
added a 'type' member to the 'nand_page_io_req' structure and updated
the request iterators to utilize that, but the spinand_{is,mark}bad()
functions were not updated by the commit. However in both of these
functions the new member is implicitly inititalized to zero which
corresponds to NAND_PAGE_READ. This is correct for the spinand_isbad()
function since that uses a read request to get the bad block marker
bytes, but the spinand_markbad() function does a write request so it
should set the request type to NAND_PAGE_WRITE.

Change the spinand_markbad() function to set the request type to the
correct NAND_PAGE_WRITE value. For consistency, also update the
spinand_isbad() function to set the request type to NAND_PAGE_READ
explicitly.

Cc: stable@vger.kernel.org
Fixes: 701981cab016 ("mtd: nand: Add a NAND page I/O request type")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/log/192383 # See "**Investigating `req->type` in NAND Write Operations**"
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - add stable tag
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 18bba02fbd31..35bcb4a8861b 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1105,6 +1105,7 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	u8 marker[2] = { };
 	struct nand_page_io_req req = {
+		.type = NAND_PAGE_READ,
 		.pos = *pos,
 		.ooblen = sizeof(marker),
 		.ooboffs = 0,
@@ -1148,6 +1149,7 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	u8 marker[2] = { };
 	struct nand_page_io_req req = {
+		.type = NAND_PAGE_WRITE,
 		.pos = *pos,
 		.ooboffs = 0,
 		.ooblen = sizeof(marker),

---
base-commit: 760d2efe91a84363d25c1051a10572242e75fe86
change-id: 20261117-spinand-set-req-type-in-bbm-functions-34775e6c14e0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

