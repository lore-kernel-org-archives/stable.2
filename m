Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE13CF049
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950458; cv=none; b=CH822lYcRdu2ohgjAVY+lAgpCuToCekzrUIUe6XAfJO4a7z7QEkBMewCB2ZKZ+y36qwjYBzshYpIT3ZLgHyKIxcu+YuGBIn/cJ3Ip5863u7nUcVE6Khp5iocRHkzBnD+pxdpET19QX87PJJs6s1Y3gSPJZotGuDE0Mwqv1QTMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950458; c=relaxed/simple;
	bh=k0sf4PI9ZW3nE2GjKWDU63Ui4sPTb4l8B80ssd76inQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jv74t306A/6W2CCUcm+REqhEw5zs0TghYpEqFX3ubMfsD1xjfXzT1Ab1LY7E3tHTYd/MmsI6n09eVn3eD4nDpLUuKogHWgN5WIKh+JfeuXDW7nOTMSEszZjF9VGoTJtgx7+pq0+70m7gPUCql1rp9hIhViK4007Kby5otoBwB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BzWFgffO; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BzWFgffO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785950406;
	bh=ovvkjEEMZ9zc8BdNIUFbtJs5AQ9gT84Z3eGToJzt9C8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BzWFgffOIwRZ9752S40mac7b+lYeKRsF4LuCDFFgLb7R2G09idDUMQSfPhmakydB+
	 D95I9GhfRaJgZlh7n8r6CNGGapKh0C8orYG/JEEsvoMJtO4fhsOcWRLo7qoACipRDA
	 lb2I8kSCZLV1B4k05S84LLN1zrrn74LzCbdz9kCc=
X-QQ-mid: esmtpgz12t1785950386t1a0d26da
X-QQ-Originating-IP: pbrEHl2+sm3e2P+O1/GfgrjuZyojHyXqlDyqOFZs2ho=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:19:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15474457211355195011
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v2 7/7] net/handshake: Close the submit-side sock_hold race
Date: Thu,  6 Aug 2026 01:17:50 +0800
Message-Id: <20260805171742.654530-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805171742.654530-1-guanwentao@uniontech.com>
References: <20260805171742.654530-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MdyWDAxdCPcQ6hX2rnIM0DJu6Mbz4y8UWxL7mKGlvNsboAYyxIT4fPBp
	j9u7CC2sLF2zRU4h46kthSrqRCtJBvjtYkyczKIBlvEIxaztAaQjmDPE3AKX2rJsFJ87nlQ
	Z+ZmYvn+2Z5kSTLYGv3eGsYTFRivp6HJMsJfyiCNaGztIli+xuUM9NNJ5LBnsVwAXsXTVIC
	R5k5XQW0fzT8nuG8dqlzRCYUzziClhyUSeRD8EaK/5NePhonub6JwhR+b9qrKHrE1XqQIsv
	252YF+GqfRdZF3sdHQ0I7/uBy5ywDvq1S1Ri5QVzYyjsXALs1P584UZVuJJ0QWkGZ1H2cBP
	N78I5ERNHtx73wXPtm23xgKiP7t3i95joWjc4vyuqf/WT+wZ2tcUGEx8taygXmp/zZ775K9
	uHgOSkrxgBIwfgCCZJ2yXsx3VE4oYKAFN/1hzvgObi3WuJJZZHh1EBHuI3fnKK2RssUHsJA
	lq0TpeAOgbJhCgg9ofyDJ+Ne2itL0m8lA3XBRg+6akFr5aG6gPbUpuoVmkIVh4/jXP19MhW
	6vNA9wRINaTg47gLD6oTIUHKCiGIqpQ4VWNj34ZKipxN25t/3m+LMhAbxptLfXRPRqrbs3m
	FECJWe4xNtwZI06MPST7AFEKDCq1/5WU1slJo8mFHUGxMtRqMT+/y7qr/5m7nQFhLWSwjTq
	HN1gDBf1K12FZEp+exWzHP8rBLmU6v731UHmKUONpZRk9OHt5xAIidICIyNFu8Oh2FN5FwT
	b2mV5UzFzxfr4gCD0PO7CfE0Q5ou2Ni/51bsr8+iLcNU+tWmkyf8SZK4mk6MwGHp9A6ZLNM
	PRFA4fVrOz/QBeH4V/EUzRgAbUr3MTM6hCe0gAB2WzQ172192ATWP/fkyY9q5NbpCVpzBIX
	E+ll9hdONc2qvjiwKbAS0/Civ5HOqafe55Bxf4IMX/65P4QGMIZcnypS9+Iq1uOthPWKaxZ
	skEB45ruaQ3MQlOt10P0iiHdErYD+yYYvVblQuSUozRWUfUTVExpUrWbqlydRtmzDzJjGUy
	QBTB9wppVYY7KQB5Y9HfHDCjQYIZGNLD3tI3T1MzKjqNLCZymEavHTwcW7kX3umQtF7Wlw2
	weXpwD1tddO89qJROSSSiYWyo+3ECTcJ2ISZRb3frN95imZSRLqPO6oWmAOyLNDDmEft4yb
	MMmMd3Xa+2bRWYc=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Chuck Lever <chuck.lever@oracle.com>

handshake_req_submit() publishes the request via
handshake_req_hash_add() and __add_pending_locked(), drops
hn_lock, and calls handshake_genl_notify() (which can sleep)
before taking sock_hold() on req->hr_sk. A fast tlshd ACCEPT
followed by DONE can drive handshake_complete()'s sock_put()
into the window between the spin_unlock and the late
sock_hold(); on a system where the consumer's fd held the
only sk reference, the late sock_hold() then operates on an
sk whose refcount has reached zero.

The preceding two patches install an explicit file reference
on struct handshake_req. That file pins sock->file, which
pins the embedded struct socket, which defers inet_release()'s
sock_put(). As long as hr_file is held, sk cannot reach refcount
zero from the consumer side, and the submit-side sock_hold()
with its matching sock_put() calls in handshake_complete() and
handshake_req_cancel() is now redundant.

Drop all three. The file reference already keeps each request's
socket alive, and the lifetime story is contained in a single
get_file()/fput() pair.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260525-handshake-file-pin-v3-6-66c616906ead@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 5da98f55b13173c08f003011b76531b25c821c07)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/handshake/request.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 4bf98793491aa..035bb2d7471c9 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -301,13 +301,6 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			goto out_err;
 	}
 
-	/*
-	 * Pin struct sock so sk_destruct does not run until the
-	 * handshake completion path releases it; struct socket is
-	 * held separately via hr_file above.
-	 */
-	sock_hold(req->hr_sk);
-
 	trace_handshake_submit(net, req, req->hr_sk);
 	return 0;
 
@@ -337,9 +330,6 @@ void handshake_complete(struct handshake_req *req, int status,
 		trace_handshake_complete(net, req, sk, status);
 		req->hr_proto->hp_done(req, status, info);
 
-		/* Handshake request is no longer pending */
-		sock_put(sk);
-
 		fput(file);
 	}
 }
@@ -387,8 +377,6 @@ bool handshake_req_cancel(struct sock *sk)
 out_true:
 	trace_handshake_cancel(net, req, sk);
 
-	/* Handshake request is no longer pending */
-	sock_put(sk);
 	fput(req->hr_file);
 	return true;
 }
-- 
2.30.2

