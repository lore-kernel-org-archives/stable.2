Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5D48383B
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392636; cv=none; b=GoPZhWvB4uiQ9cHL91HjJGXQqB+K4yXJEH4UYey8YCXyfggpSzHR1qPEqSUs0F2oQwWeKJRPyCj/Ypy91Mhqu1prxp8A4jX3m/+U35Asq/FD79XWGA1IQJawoC9hPgoZkoSn9I5F6GC8DqGHRn13FkvmlwhC7qenlbxDn0bVjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392636; c=relaxed/simple;
	bh=5Rlziv/VURH/P/cEyWDRx48qF+WbCr4jIknaDmyCnqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdKwPqzSz8t4UctjRwH74SqXdQS5QJwfFv1c1yzb9IJDMPu0BUhibG5xrivKVtmxVnYzJ6xqvEJXhQRmplioBhhMbN01uzbFoezgqlrgBexBg2n0mvcSbnxAp1AvL9eSFV6AtWt8sOA+2krZ0WNsgxBt34Ko24dMj3+0LJbO4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=gra0rGup; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="gra0rGup"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so946914a91.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792392634; x=1792997434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QK6qh5+NKSNYETgjkTPsz31lzea7ZQK2GxBH2To2CPA=;
        b=gra0rGupPLGWFGL16VbpOM1EcGj0hIgtsTFjqaVx4qlBs/D6QZ+RAYKz8Ksqut0sCs
         0XEF7Cvrnv/EQiE9nYWhiUlN4blyi8a966WIv/E/AY8Gs7pN4oCOCaTVwznhU/af/3E3
         crDAdvDyOWGlucQumxll2k2dbJ7ut5dYIcUTf4tFqVzSsgAO0a5stIYOWAuyA3il/nlT
         a8TKB3zeL3S4WkOY3As1kMwkmxGFzScvtnJ+5+GOdDixF9W9z5m8XTBHH32KLiHU2S+F
         Udg49fAaCE/COWXfetHcKOjuWSDmQEoirdsgr/kZ/7oiMoGAGeMJ7vr7zgDQcbbW5Aq9
         2wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392634; x=1792997434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QK6qh5+NKSNYETgjkTPsz31lzea7ZQK2GxBH2To2CPA=;
        b=GzaXCLxYsus43NtC5HSWPuC6Vi8vN5LfGwcprQNAOhlMHd2gGLG2OEsGFmCSLxnHNA
         25aG8sG5ebhnMbzTF8DTWKPBludUhj7Do3ipC9U76rJJuXmx0Tjz4MsqCT2CyElr2m44
         f024QsUcLo8k5GcqtcyO4qBHMYmO+yMuQ/DzyY+UzdXjnSkvS68/DprYjT58+jM9piZL
         UCuAV3ssMvJolcQFpcwk2JQQg1bdMJCNu6e+5KVfPlaa+pQN3ORkTD9hVLx309DN9Axz
         zSEYZKXaP92yvHsFjocEXeXTTG7PmIfG+sk6AGElWZ28chvaEXmYuXgDGU1icnSEAhT+
         tQmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsID2X3E7jAqU7KDdTjFFtOOP6hXWQNn+p4LfAHMK+ZuVOabM17h/dJKX0U+zKI1MTe6faiMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLj+v/SJ40kZVKcZsXetCEgNZSvinuphqsHgn/69hSUOpQfVWH9
	TPue3B2PIw4ADYw9SfaIbx6trtvlq/xgPWTjR78JkeGwAwLBvX63Jl/jqblti3XezJr3p3Ms2H2
	CDzVv
X-Gm-Gg: AYBFou3RtmkcwjUur9Rnv4tYB4kdYyad95hN/9xNqKinE6argZ4X8v49ed3BAnOjpEB
	jdWobFl+vgGXQ8SjvhXZ0TljaFlznAM/dsaXdA/Bz4b5Sm+0NxcpW+yh3/nJ7oDKimbG9wdWaAC
	LzB9EWuVGki45a/bsAOeF8aAPvWSKWlZLJG/79bTglYxWN0wRx50lQ+zw3LM8nHxe4zCKra/cOl
	P9nZo0zrIHtbGXVll+LODIHf6pg/TUUxtgHtZYElZyzTNwPjqVBdutNr17/u08rHAFwV+sEKLMB
	ZsuNmLAZ1GZlYqzV8jM71uPYV/ZJYnX3vm24BsjbLYOJCFsKpwTyAAIZ9xIX0dEuiYyMgFSSSRF
	FK8+S8vKjKxFwq7OjwX2PrQuD/2ErOQxyhKLadR5nkSUhXAQkrZRM2YEOrzWvmJ2aBWo9c0QqzE
	oCq709VL9npxjs1+NM2drSazBJ0XbkQSbb7/XOORL71M+0GAZhs3pLQM62UqQ26bBk+lUjGMAGI
	EpOvQ==
X-Received: by 2002:a17:90b:2c90:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3acef0ff0cdmr5700956a91.46.1792392633670;
        Sun, 18 Oct 2026 23:50:33 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3f3ce5asm5870887a91.3.2026.10.18.23.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 23:50:33 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: njavali@marvell.com,
	mrangankar@marvell.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: GR-QLogic-Storage-Upstream@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] scsi: qedi: bound firmware-reported lengths before they become copy lengths
Date: Mon, 19 Oct 2026 15:50:17 +0900
Message-ID: <20261019065019.537183-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two places in qedi take a length out of a completion queue entry and use it
as a memcpy() length without ever comparing it against the buffer it is
read from or the one it is written to.  Both of the masks involved are
0xFFFFFF.

The first is the unsolicited PDU path, where the destination is a 256-byte
array on the stack of the nop-in and async handlers.  The second is the
sense data copy on the SCSI response path, where the source is a 96-byte
coherent DMA allocation.  Both lengths are ones a target can reach: the
unsolicited one by sending a nop-in or an async message whose payload is
larger than a single BDQ buffer, the sense one with any check condition.

I have no FastLinQ hardware, so patch 1 is backed by a KUnit harness that
drives the real copy helper with the two DMA buffers swapped for kmalloc()
of the same size so that KASAN can see them, and patch 2 rests on the sizes
in the source.  Neither patch changes what is delivered for a PDU whose
data segment fits in the buffer it was given.

Yehyeong Lee (2):
  scsi: qedi: bound the data segment length of an unsolicited PDU
  scsi: qedi: bound the sense data length reported by the firmware

 drivers/scsi/qedi/qedi_fw.c | 75 ++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 24 deletions(-)
