Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3B3CEB90
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951773; cv=none; b=U1N7JLQ0PA5ZBjr2taHvb2klJqkaYmenvW2cUOcWdkEytii4c18kYMNxHVwf+WN2+f+BI8PRL8iKKlA2JJiguIcHwyFntiR5G7J+4EC6SS1Xo1/KqwaQmJ78j6jo8s6WT1+IDigXdNnUcnDTooIlhjb9WqRyrmcC6QIw2hVStvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951773; c=relaxed/simple;
	bh=k0sf4PI9ZW3nE2GjKWDU63Ui4sPTb4l8B80ssd76inQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSgp+wiMitrmS3y3y1QYhhbA5rX+EINPhFgxsqpRhLQluWdGu4SLvC865vAWUTk/vLjDvc5p+XV/JGAB15tzQ2KHoIBocOwt9nlXHE6dMJQ84a9QK8EcnNL7MlWpwRzkpg58d54Tte9ZC4TQsgooVwv6rgj7bFFtfXrVFw0npas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Mq+XgX/3; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Mq+XgX/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951743;
	bh=ovvkjEEMZ9zc8BdNIUFbtJs5AQ9gT84Z3eGToJzt9C8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Mq+XgX/3VtQRUHRHBpYErE9kLMwZQvDkjyTk/IQ/a42n+B4NOu+3fatI3whxXI6Xn
	 3MDV+kDTFsdaz4tyh9QtHxnie8ArfQMpaN9mRlfRjr9Kclmomwz12MgwizroF5vdGp
	 ej4eRPOyktkxVsdwweIeb4Ku1meEpXUOIplM9thk=
X-QQ-mid: esmtpgz16t1785951724t12a92dc8
X-QQ-Originating-IP: lwtpqX4AbX0mChotZn+/jpYAdc7vao8q8SacihbxeXo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:41:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15321042400468748063
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 7/8] net/handshake: Close the submit-side sock_hold race
Date: Thu,  6 Aug 2026 01:40:04 +0800
Message-Id: <20260805173958.660310-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805173958.660310-1-guanwentao@uniontech.com>
References: <20260805173958.660310-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: My4+YjZZQyJCX3Fmkr6TJb7JlYJaqA9GZAfB6aSrMx3kA7Yk2w1TFCqi
	uxIDVBiUWx7bZfMz9IU+sTxPzpR09vFDj6aBo0e9If/hjJePanIJgjkyeTRC4VXcHP63avy
	v1WPeiaVm/XyBY8eaMhWq0wffc6mCXFH+jReOG5cycQJa8iG/Q1kAisqz6+s2EhU4DocTwo
	cQx57AQGYgDi2w3ARjk7ghTBfupa6KFwQz9sCKT56Ka8F1QnUHWhzQeGZEYZC+9ZMLe+mHb
	gsfjs+eo3IAgX5blscuICA954c8wDcycX8pLP8rgOwWx6MHhGz3uXQERLWtjocZam09bjVR
	/4pez3kmuTuhMfpyvaVQpzYyRK3V7eqQh+rpUVya3EFnp9kx+x6dkY5SBY0lIU1UF3rA89c
	qawI+BmEGyvRVAc2cE5fBj2BgYK6koVG6RCShjYAB+iWKqGg5lPXsUh742HPAgJXfguUuN7
	vebXhw764zkr3znOdOvc7TPl6NCFjuSX0ujC/tn4wTiYIuY1a9jLA4u3aDiSpHQKSsMGNz+
	dnKfY/Y/YVopmTKQ3SCA7n2OyZ5ot6N0DjMYcey9nEWmbE1d3E+2g8JCPL607Xa5TKTxUef
	w4ihSJlP1iM20Ek5cfEgmyQGUw18BhsD/ulFEAKZppE8A5reeXO53jKouU3IWnSfRMwEY0g
	JI65+vyx/L8ErWUabs9AZmkZkF6yFZxl9O+y1jKGpx5EthKGI8QkBwPu1wlOR4TZm1DViFj
	DV3iew5KB+vb63hCtF6rFe/SJG6ZnbvmZkCok7qfUPSbyXY5UXpf9NSmZVo0CWAr6wDGmqj
	2f7VTYy/pE1WPv3NZDNjqnjscL1HeXzAzTTvm7KfMM9o6cE0Rm0Ub+rpaHpBw6t5+mIKdJz
	0ERi4+l/yLHDEk4XrOOAmbKnMp0ofAWK3CCX/DePkYhMx0BUyrCxo8ydCvSYhVux79tBShI
	jAlfcpce+Xn31cU6XDFSNKzxLHME4l7NC3/cCznLpgeinoOvhP1ZB+2+KfzD0O9FjI1zWVZ
	26gaQlbNTby29Njqg1EOYmH2GftbvSArIWsvsH+7I1HJaivSGB3WFwdcxSOytcebTybxgyO
	+cVeO2xqMW1u9iZJx1McJhd76Eag6tsHvc1VQbWsdgkhkNvy2IL+Nz0aUUFNm7lUE4EgbGJ
	QBtVeSaq46P2Yu2P6eHfoMhqHFcXSDPfdLdvDUWsC4gCf7c=
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

