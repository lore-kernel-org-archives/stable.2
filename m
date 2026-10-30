Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.47.207.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336655;
	b=4UwDisjKssfzKd6dtehbB/hB3uF+TBFJFzSuspf9FYkS+064IljNQwGuD+Ac8/Vd/ne3
	 fEar1NMpVlyJKEtAL4uHTzSafADr3mBuSzxLHjmEaAqCEyTAzVsnvWdBhhxiznxBB+Oad
	 3AYsaYv1yAJ+GUuNNi/a8lMLO48/6XOSwEdcXuZ/DAKr6+yFiMkejAl4DktDG7mJ9fGqX
	 eS+fNdRYn/mylKSdtMzpk/Ri/nuqbpoL7e4cYprPPV19F8eWLd08/IYN25y6X+RsIkacK
	 YPz8g1YLbdOkIKbMYnTwIWxGQhOgYB1pJzlIBSJSkA+aI3TzpH2QWHqp+3j5VB5o2/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336655;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Smtpcorp-Track:Feedback-ID:
	 X-Report-Abuse;
	bh=9MW3clqg5v18pZwU63c4oEVpjzsyxRxNLjxrPy28qGc=;
	b=B/Dn+I58jIIaFEcf8FGem7Gj9dwengMHRDCHarTPNwFXNe+teIIeak6D57UZMGMWr2eB
	 rAQ9rguDzx3NqhMwUTEqLrfyA3eFU7H0D+UlrFj90Rp1n0xL8Vk2MohpZNEapPm0DOxvh
	 plxFr6khYJu+6Q4cnAbDr2ygS23Wr1iiGabIUEtiEQxmWfnGf1hTjmCDsgzoWsQSKRYZF
	 xLCAf6vUswOHVf6vpEdRnQMlRoZsclYxS9/wf1o9U5gsFKSg/4gBFCJbUtpjhn02dCVnA
	 RuWKmJLp54SArZRrTlxpXU+PeuOb4gV9EEiiEMxOMN2jQkAGoNDni1ZZEHsUWTLUWhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shangen.org;
	spf=pass smtp.mailfrom=em879706.shangen.org;
	dkim=fail reason="unknown key version" header.d=smtpservice.net header.i=@smtpservice.net header.a=rsa-sha256 header.s=miusa0.a1-4.dyn header.b=asi4nLBX;
	dkim=pass header.d=shangen.org header.i=@shangen.org header.a=rsa-sha256 header.s=s879706 header.b=ROMDyenH;
	arc=none smtp.remote-ip=103.47.207.181
Received: from a2i949.smtp2go.com (a2i949.smtp2go.com [103.47.207.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B96606A329
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89B96606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shangen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em879706.shangen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" header.d=smtpservice.net header.i=@smtpservice.net header.a=rsa-sha256 header.s=miusa0.a1-4.dyn header.b=asi4nLBX;
	dkim=pass (2048-bit key, unprotected) header.d=shangen.org header.i=@shangen.org header.a=rsa-sha256 header.s=s879706 header.b=ROMDyenH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=miusa0.a1-4.dyn; x=1793337555; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=9MW3clqg5v18pZwU63c4oEVpjzsyxRxNLjxrPy28qGc=; b=asi4nLBXSWOJNOt1ZyIrxhqeS/
	++cgLI0tn9+fm7YrYCAzhfOuuKbAluVjjfVWWcPr0Zvql72jJf8Oiw97Qdw7cVgH42vj+LrQHUMtC
	OJV8AuX/5yMLAu2qRvr4R0imNlvzG1DoaKXBy6YQ9SMAntgrBZNi+c2v0Wtz+E4T0uYtJwBr/H7VK
	PKGw72LHROmrTJWmDgccJcDNfx5YTVfJlHuKCYUwfVmnYZtBgl59QwMemvZEKOYongHl3eqEVE4ld
	vPlO4gRLYM2F9vruJ7ewMT2xt+fj0kImNAzf8LcPjXhc2WO4Qer5xdxzIUj+SQlx5RnlWheaCg6uU
	RuKYa0hw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shangen.org;
 i=@shangen.org; q=dns/txt; s=s879706; t=1793336655; h=from : subject :
 to : message-id : date;
 bh=9MW3clqg5v18pZwU63c4oEVpjzsyxRxNLjxrPy28qGc=;
 b=ROMDyenHpc+SKZoxtn5mME4m/5clowTNI/Mymdi0WF/fA1+aKt4l3MQj/hV2woddL5k0d
 bcfU3bpjlurH2iUTC5QqO3p2Gv8vndCRlgh9TSSuBzVLecd+KqC0FEeMiRulrmq7tTvQhB2
 BF8g1bZP98wS7v4W0kMK6H2M1NqpnomdL9QxCrxO9TGWGopJnbH+zSnkSA1i4zFP6SlldWR
 IDulO8QC/xFhbpdqagnn7wD7tyhOxHa0tX5YhOVAswInupW3dmcs++IAfoiwU42QEHY7Hb/
 QOeyJlnXgMQEsqrY5Q7RdXzHemxj9jM+0jD2K5/qMm+NGXc5zrpS+y9vcrWA==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <sim@shangen.org>)
 id 1xMemR-gL4QGD-Bv; Fri, 30 Oct 2026 05:03:55 +0000
Received: from [10.195.244.224] (helo=sse-laptop.lan)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256:X25519)
 (Exim 4.100.1) (envelope-from <sim@shangen.org>)
 id 1xMemQ-FnQW0hPtGB2-jeMa; Fri, 30 Oct 2026 05:03:55 +0000
From: Shang En Sim <sim@shangen.org>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: Shang En Sim <sim@shangen.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring/cancel: count all requests that a CANCEL_ALL
 cancels
Date: Fri, 30 Oct 2026 00:03:16 -0500
Message-ID: <20261030050319.1448530-2-sim@shangen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030050319.1448530-1-sim@shangen.org>
References: <20261030050319.1448530-1-sim@shangen.org>
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
X-Smtpcorp-Track: oFD2LBAfIGnB.03imJesa8VGz.RH481g-oQaU
Feedback-ID: 879706m:879706aL5FzMA:879706s3PvtaaPe7
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

With IORING_ASYNC_CANCEL_ALL, __io_async_cancel() counts one for each
io_try_cancel() call that cancels something. io_futex_cancel() and
io_waitid_cancel() cancel every match in one call and return how many,
so four futex waits cancelled with CANCEL_ALL give a result of 1.

Add the number that they return.

Cc: stable@vger.kernel.org
Fixes: 194bb58c6090 ("io_uring: add support for futex wake and wait")
Fixes: f31ecf671ddc ("io_uring: add IORING_OP_WAITID support")
Signed-off-by: Shang En Sim <sim@shangen.org>
---
 io_uring/cancel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 79b5c133319b..50a65fbc6ff0 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -198,7 +198,8 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 			break;
 		if (!all)
 			return ret;
-		nr++;
+		/* futex and waitid return how many they cancelled */
+		nr += max(ret, 1);
 	} while (1);
 
 	/* slow path, try all io-wq's */
-- 
2.56.0

