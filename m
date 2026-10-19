Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427906;
	b=EYrf8xQZtY+EPeJ3EfMHeZB1Y6s147zJKX438lb+BUatqT2T2mpredMPjHAWtv6xVuHY
	 6cZjb2EiTP9beM5qoATtvKcBfLgZDQF+eyZs6DmIpGQ+G0S8MmZNR4WLWds01tmRrKMv2
	 Dbey+xeLnHPvjHIJ7Oe6JuE+PVDd6fSY58BMblMWSOcZY+CuZ4C5hZyliMuh/tgPfMuh4
	 olMdW+7oEVfUgUJyde8u7LujMahsKTMJYLbGqgSBOqlkWrcXUU3s+A1obXs/pdTTlID2f
	 ucOhnPiGNyUFuGhrBBajxJrcdwEJJWh27vhNuTcCwBiy6pauf+4NWkn1CP47tPw6S7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FigEJHOTXcmrN6GdEEhScAmCCjRdv5trAdW++5AKErs=;
	b=oexS8cdrjx31ARNGY1TbGmeVqjt6V2qJbXA2UfV/3HjE453e5B9AcFEMRi37/3sOvvlS
	 Fs9PU2CV0z3Y36LYqxyDiAFiPDoDLdEgSFip0qFkhLo2jQC9Okv23fQ3crEZW5Vp+WUAU
	 L84rmTgWQK2F7PEWFmauRcaIuFsfwpMeEG0a18wFnGp7V5O0M33uChmv67Vyd17IrhvtA
	 UchLLloxz6hXuvKCvdghcEA1tcEmMfHR3tx1FrJA6+Lg1+qw1Gf4dmBWDn60FEJDguUZq
	 Fyl62LkZRghlUpK+isFqZOsHGpFlaYfQjEnvIrt8UcdoiM64Z9+q09gO4OMxGkVtLDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r+xBEuMw;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71E606A321
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF71E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r+xBEuMw
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so10549375e9.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792427904; x=1793032704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FigEJHOTXcmrN6GdEEhScAmCCjRdv5trAdW++5AKErs=;
        b=r+xBEuMw1pPbynNijN2smEhoLWsXKecTVaNh1oCzXiNQPK31mbEXywlrqLExpUGzzX
         vuDJgYx5eLBvFXmi9TTFT39sDvbMK6I+b7h7E6xbi5MBNZ129r4EwBQ6Yx1AHaIpekai
         Wrx8Z7CzRKUX9ZOz/O6LPeylEMqUQF06rRW6YDoOEaGV16DYRoFKQi/qWdsLHrTi6Y2r
         uJMtC39Jj/yTesn5Nc3i4jT9Y1YHsYHjZQMJ7v5CtGzH5HcH5GV2qxRxCur9WhzMTRSl
         kj5CXRlxBiNU9W/nGvnGxT6+WnaE+TqrxXIwvYzZCAv5bdwEXi7fjtU6Hu8qc93C2y54
         +2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427904; x=1793032704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FigEJHOTXcmrN6GdEEhScAmCCjRdv5trAdW++5AKErs=;
        b=16BWX7l3JtxJSUskaIw4oGY2YFqncjRBx8p6O/7Z0WnsNOo2TIsvEOAC2od/Ipy4FI
         FQYIn/P4H8fxr1wuXQ+zceVF5cKJpTM9/csgeZK87ryNCfOZWmTyuyssgldDWWJtgLHS
         LbSW+lLqVqN20WTGUlxRCOnHu/EPPrIrm50MmpNjs5shbuo7rwkMsTfEcoQFOJ8K5ogS
         TwWa7Auqsg/czm/jpiHLDbii7YuY35NpSgJSHewqmvGjy2e/Ri+ijNrZcnNfMdWVxQXr
         yRoe/3rT0sNPJ8+j9d5TkAXwkfqscXK+nqZJPuSZaGFZK3i0GvyWr8SBM0eru8UeeEes
         n/wA==
X-Forwarded-Encrypted: i=1; AKwUvBxcAXQlscc9IGDaQbPr0gHl7D/GU2P5ftSEw/Nj+caG1ZP192nZZcDBY5GhEuxtBo9uxnFriO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKk8/KqjDAZgPgr4JbduRYME5e28fN1seWjcchHpCc0DZyz7pkZ
	4GiF1s3YBwCGyb4ZydOotlyp1ycvIsCJlFK9f74DNNgvAWKfZRpz/zswO+Iv
X-Gm-Gg: AYBFou12fs4F/8mFj/uXMkgoHLPn0iq1fgrh157vuwF2pabPVqyq1taaUm73Zp1b8Hn
	mhGQXfifF7/29kY3ie+jCn5ryse36t6cl03UaZz9hmSfDwIA0avF/ms0FNq/4Y5mkUSEMlzPig4
	Xhjp7J2BSCcJNSoSRXGSxwjPOHWugDUGrQfl+VbnyKkiQLCysfXSaWXodqYFFsMnoYc1FjyDL2c
	UeZr2wfGSTq9hJ2Sfp0lhcC/F+EUxcd4MRHBmnsA+58eCuCM2P8oXopw2X7Is+THk3fJeYd3pcP
	tcBMfVt3x6gq1IMA8rZrQ0bV3ui/oum4/xBJkQAI26h+LvrNfW2pxyAAkNNem4+3EebHtvCvaKg
	Jct9ey1BHyY7uqWFGywQ0TjZ+2B0xjnxtJ63SQnxvIq/x/9h6ql3hmlPBd/eQuZcurfTfh9VXTo
	YFb6j3vrNzxZbAYPR1OrteOT8opoPnCJ6TCbZ1dhc=
X-Received: by 2002:a05:600c:8709:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4a1d75e6f32mr170196745e9.5.1792427903791;
        Mon, 19 Oct 2026 09:38:23 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d32412sm3752065e9.7.2026.10.19.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:38:22 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] scsi: ppa: cancel delayed work before freeing on detach
Date: Mon, 19 Oct 2026 16:38:21 +0000
Message-ID: <20261019163821.659714-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

ppa_detach() frees the ppa_struct without cancelling the pending
delayed work ppa_tq. If ppa_interrupt() is still scheduled or running
when the struct is freed, the work function accesses freed memory via
container_of().

Add cancel_delayed_work_sync() before teardown, matching the pattern
in the sibling imm driver.

Fixes: c4028958b6eca ("WorkStruct: make allyesconfig")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/scsi/ppa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index 8a4e910d5758f..7f4b2a4157725 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -1136,6 +1136,7 @@ static void ppa_detach(struct parport *pb)
 	ppa_struct *dev;
 	list_for_each_entry(dev, &ppa_hosts, list) {
 		if (dev->dev->port == pb) {
+			cancel_delayed_work_sync(&dev->ppa_tq);
 			list_del_init(&dev->list);
 			scsi_remove_host(dev->host);
 			scsi_host_put(dev->host);
-- 
2.47.3

