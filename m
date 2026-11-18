Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996548;
	b=aWtOIh9IDKhyozqzZmVnjXwerJOf3v/cB7r6nEtxsYi+1WOlG8rKmVrCTD5sHttfyu9k
	 nQCmeGNdr6gcLEhcv3QWeK2IMpCmu42j+eWIZURf+WW5LqroWsWp/bytbjGE5MuFCMeQ1
	 gbjN0cxQ4qlLFzs520o4ieJSU+LNAPkRXp35lw3x5NCWmb4P6PyLLvCrlTWir2mi16IoO
	 +Imw3+IscWvfRUxPijpVsd7H9QQBwBbEzHjYgPEslH0B2YTKWFPeqNetCrlTNc1wP3OPo
	 xubgcx1SrmlZ3hUmDYSzuXHq/28FC5wk9Z76LNkxf8NbjEremJ2OYstXop8AEn2UPwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+B1TOH9oUaUU/yKHKlpMG2Fg0rcqqVsIpnka2NiH2/I=;
	b=XIgf5pjKZx3eQmQVNVMkG9wUYt23LVNFw0QCl/luznkxCFzgRdeKkkew/kHk3VZ5+xlG
	 TF3SYsoQNaJDKGOz3SnPw0aeQNURCPiiVy4jTj+2/nQoPXP1V+iFOFtpxQkgSvy/cODIS
	 8WTARubzdfh2qUO0eqq203sfG+s2m82LskmOq/g+Rf0+MFeOvOaU82l3MppeOkYKIQ85q
	 FJ2O4YHeQ4CFB81igBqbKpTk7cHJkg+qW4V+8XNejwcAft6iEEgRiAX1G2kHlXKyT8dqS
	 r++reQ61se0lCRVZZZ0ZTwf7uQlSRW8pT4r3B+qaJoXTiH3p9DvJmseRIIcZndcpOVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--amitamishra.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G14vOFv3;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8B606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD8B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitamishra.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G14vOFv3
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8c5408e418bso669189b3a.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794996547; x=1795601347; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+B1TOH9oUaUU/yKHKlpMG2Fg0rcqqVsIpnka2NiH2/I=;
        b=G14vOFv3Ujb4z9LNJX6zHgOB/CiwYIy9Oy8Jt5I6Gz3ApMFDg7KvkQ6RdNztHu3C8c
         qziMNmi2uJwjjaGR1vEA01vJ0dWRcsexxdNVY3WbxuuoGZ00IDI5nfaFpfm2TOVvOmEv
         v6GBlsjWXLTtTTxV/GBDpFeJg3Lnac74OjZ1x9PjbqKwQWKRLSbDHwJkWH1Xbwre/Oyq
         daIGMoFrDrnzXyHsjznsigqT+tDVSneoU1pbr0wCyfdQRCZrV/uqPnvH3EesfIHdEkK/
         q1rQAwwD0IsLN3y5YmG2rO3PFMh07S/0ZSqHrTRr1v6g7FbtivSzK02Bzn0XmTaGF8je
         T/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996547; x=1795601347;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+B1TOH9oUaUU/yKHKlpMG2Fg0rcqqVsIpnka2NiH2/I=;
        b=PpD6ttniMkBG93wsR4jgntGulAkCpflKSYzJuK9vuoJT1oLOxaq2eeMAn9Ofc1X0CS
         oNCLJqXrIZ8laYAwgmUzRhMchkRsTF2IAtR8gdeVRdyRk4bxZEQM64K7demeG3LYajLZ
         bsCE4PozhJqnDAGBRIJlosaXiQQHAELVouBGiKFEf7OR/O/e1UPmTdRarXtdCfkC8F71
         H1vEiO4zpUnn3ywzhhPnbSMTuKgFj30VvNqe8JNj4r+s5YCfX1sxHdbmzPA6hYRxT7un
         Y2e6VamRNgAiB5vWkzNdz753Uj1xgM1VYqUKeGoVXktrz/A2qmiMNHBqXqWevjQ9s9AI
         XBMA==
X-Forwarded-Encrypted: i=1; AL+hErF3Cn+zTCfSN7xdvpC+OD5G6MhbHymhQueirhSNQVqA60FLTcj3PtxOIfxP/omqXEfMA06mZZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WUiiwqk+WTw2bcNZLWiTQht/jBOtCPQcbRvNcKjI+1I3Yy9WF
	cuo6FhAWXieM6fyExN0O37W8cIzTi3d+5yzWXKzJciyCKIghk1oSYLJkW5f3mU2LAAS6Yiu75wT
	yRPkDsSoeHCQZICUDd7tM09sPwg==
X-Received: from pfdf8.prod.google.com ([2002:aa7:8b08:0:b0:8c5:fdd3:6020])
 (user=amitamishra job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c8e:b0:87d:ee98:606 with SMTP id d2e1a72fcca58-8c5d45de9a8mr1864339b3a.23.1794996547074;
 Wed, 18 Nov 2026 02:09:07 -0800 (PST)
Date: Wed, 18 Nov 2026 10:08:39 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118100839.3090172-1-amitamishra@google.com>
Subject: [PATCH] dmaengine: dmatest: terminate channel on timeout or error
From: Amita Mishra <amitamishra@google.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, Dan Williams <djbw@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Amita Mishra <amitamishra@google.com>
Content-Type: text/plain; charset="UTF-8"

In interrupt mode (!params->polled), when wait_event_freezable_timeout()
times out (!done->done) or dma_async_is_tx_complete() reports a
non-DMA_COMPLETE status, dmatest_func() jumps to error_unmap_continue and
calls dmaengine_unmap_put() without terminating the DMA channel first.
Channel termination via dmaengine_terminate_sync() only happens later
when the test thread exits, unlike the polled path which terminates the
channel immediately after dma_sync_wait().

If the DMA controller is still actively transferring when the source and
destination buffers are unmapped, an IOMMU-backed DMA engine will trigger
use-after-unmap translation faults, or overwrite the buffers while the
next iteration reinitializes them. In addition, if the timed-out transfer
completes during a subsequent iteration, its callback sets the shared
per-thread done flag and wakes done_wait prematurely, causing the next
iteration to fail with "completion busy status".

Terminate the channel with dmaengine_terminate_sync() on both the timeout
and non-DMA_COMPLETE error paths before unmapping the buffers, skipping
the redundant call on timeout when params->polled has already terminated
the channel.

Fixes: 4076e755dbec ("dmatest: convert to dmaengine_unmap_data")
Cc: stable@vger.kernel.org
Signed-off-by: Amita Mishra <amitamishra@google.com>
---
 drivers/dma/dmatest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 2ae3469397f3..950b7a9e7769 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -852,6 +852,8 @@ static int dmatest_func(void *data)
 		}
 
 		if (!done->done) {
+			if (!params->polled)
+				dmaengine_terminate_sync(chan);
 			result("test timed out", total_tests, src->off, dst->off,
 			       len, 0);
 			goto error_unmap_continue;
@@ -859,6 +861,7 @@ static int dmatest_func(void *data)
 			   !(dma_has_cap(DMA_COMPLETION_NO_ORDER,
 					 dev->cap_mask) &&
 			     status == DMA_OUT_OF_ORDER)) {
+			dmaengine_terminate_sync(chan);
 			result(status == DMA_ERROR ?
 			       "completion error status" :
 			       "completion busy status", total_tests, src->off,

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.56.1.703.gf848ed807c-goog

