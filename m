Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB43F86F9
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921385; cv=none; b=ET9kOmlujQuUxa2vQUT5KvDYOZN5lGg6yp2yitbECkeEtKc0+VHXdlBRvlkRTuoT3+O0khldk8XmetF26oOjUNR1z0s9/LmWWFv9S4SlzCs0DIoEpK4rKICWOJEaulb4pujiNZ8jZDVjsqsX+nYS7c5SBbq5fmvvMS6CP3hvoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921385; c=relaxed/simple;
	bh=k0sf4PI9ZW3nE2GjKWDU63Ui4sPTb4l8B80ssd76inQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgVLk1DW46Cm/4t3uO2/hNKf5JbhifYq6dWqWzci4dyng3g52SYZX1WCuNFEt/UfNuWoQG/mzStfCiBs6ScMnTGpKYjRzkul7luZBuI5g1u4VpA5+nzd3YW5n6763wi1ylQQbaSRUE4tBZnzPOVTh7/WUB4wm/hKNtMsTRvfBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nS+YCYgA; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nS+YCYgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785921342;
	bh=ovvkjEEMZ9zc8BdNIUFbtJs5AQ9gT84Z3eGToJzt9C8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=nS+YCYgA4ZqDo/Yrz0I6myGzGyOTBJur4DC727/7LkfJhBhzc1DcaG/WPZ7+c/QKT
	 o4Rx5/5wtAxwSvLwd6grbgHJ+L8hRjCZyCEln5UUCVP/DmZcVN3crTixVNXfCHCwp5
	 ApbhpcI7/Bu7mj/WwexGRyRBOtjU3Gk9Nge/3FlM=
X-QQ-mid: esmtpsz21t1785921323tc71efb97
X-QQ-Originating-IP: PUEontEjPV6e8K9T+JwUZLwugrk9govsCPsVK/BaNQE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Aug 2026 17:15:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9381523116252572314
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y 5/5] net/handshake: Close the submit-side sock_hold race
Date: Wed,  5 Aug 2026 17:13:54 +0800
Message-Id: <20260805091348.609325-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260805091348.609325-1-guanwentao@uniontech.com>
References: <20260805091348.609325-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MPEeF6PUOsC8YhnXJrMjnQR5j823h4KwxC8bnppIUiESp/5AO0N4hpo8
	wyqVdmfT3nW/feISNTQ8CR74WncasIWn8Yhoz/gdkm6tGty96/PYqaki/m+oKQT4ZR74w2w
	/chnY2NY7xIzqQ2a2m0qKwwZ52vBDZHEDgVF5h/4u53jhhenyNBPD58pgWv5bjNrL3sJrKM
	OrIX8XbLsqKycToBHQILI7uX70RCaOA9bz/qasdJiH4pDXpfm1ZnwY8cPbYCBvEM2g/rNv0
	WzvgZAlN7Ea8X+6EpIoISANK2kmiKtWnXyGFL3ZJCk3eYo+7HNFoD2mtV6uck/XRMaRF79E
	nNHDIPTF4yKNZ8mo/LEGMtkgXGt6NkEqFXYKhkbKRkW1xXBTnoT7F8fpmhWA7XZeyWaU+Uy
	8z/471J1U/wfX9QDyM0yQJTB+AyZXe5zJAnyPXAVp8W0U7RT9dXZD+ST08gPvyjgBjq34eG
	obN/sGQsooHSp/jC0ci+zm/goqWPXYj+Sw9sdSfilLolbx9E6HdBNkXOwkn/WMdYa0CC3Vt
	5SdWouFmp9tb3mSeDhRMKx/wKXyiFQdyy8zhNB7j8gHLoJWZMQfvyP4svrLGIJmUFIueONg
	thQtxvEx15GN5QTxQWbY9iGlNAw2lZ5L1IZkARrpS6E7I9/1CeYGHnMgR1Ma+5LJSxXWTL6
	PW4iZLGnRXfv7hAws0ZD5MrTvpuoWOw3KHLVLjWhhCaldRwDeW5D/f1r3Ourk5WwbN1iJus
	c/bn+yT9GnuYpXWDeZ7TtAFWw2i4hvLpDFbLienaVpORJ1q8y8X96kWHGLTOWYnpy5GT6Kj
	on58V4+mXuVXW3thRX3/c4nz13Wlc5WGiba1HHnGoUm3LFnBnzyJGUG1r0pZ5r2V0uc2nwi
	Jxq9A+bTDmI80JeTvLqoHobOVMZduJAxtkhsKQDOugE1dbwfwMBbBMxSa5JBqj9WYKOfk4i
	eI+684z6y6kCI6P7cXgwQMN5Wqn4bS6CvIlFCIwEftpIe7rWmu0/b6S/N07PTsUSIlcte4P
	LVCivKxtV47+ps9I2SiaKeOJcpbmmRkBJLfswK1nyeZ41yED3cK50TqB8stHF1eeDS+HOie
	S87oZWH00f4bstRJoOYYNdvkrpf29g1AbMKgBong2rAI7DfWWunJPs=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

