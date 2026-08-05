Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E233D332C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951796; cv=none; b=jaPxa4FKGhsNGYLiQWu+mD2E3GEGFglE5+gW1VzmRIYr6mcB0JCGyg+WCDd0yy3jhP9PTGUMGkEm7YMv4X1ZdVAjzUH+ER+C3BcFh1RbM3sdS0Lk2qYf34ORKruuzDvar3YFV4vCalseYL4pKzZeju4qfLEwS8o6EGggDp/bRGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951796; c=relaxed/simple;
	bh=NtbA3nT+BDnarSakTVXAQ/B1VmLu4L1CwXpFjpEz9MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXvPqa2nfRFTvGHgPktQ+aMhai8JIOfBEJu42QMbwDItWemA5lvDL5zOpwUlNQ6nO/dCsjkA2gAKn22qKAFhi8kCzAljT1+0MH3epS2OW31rjbc8W86/xJ3rmwGhsNT5jNk0alc0eB+ciSPqxiqzkM9w7nqWXHRRWZqViMcvAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hfvD5oqt; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hfvD5oqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785951756;
	bh=hYKw0rhacOrtof/zFbCsvY+JRVNVxCJ2heN/dYeMKkE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hfvD5oqtSpIGRbD4V+3Q0DXI1Pe2wLfWhi67TjPMVOdY1UmJHkbcFFlWEZQTvQ1+7
	 efwtl1mTmtwhPzAnlfD1m3XbpWGq5jvixRtZg88IBgcFNzKDDsSQx5MYPKU43b0/mh
	 n7bW2DWMMv0CumIxdUldlWal2F489s15vwvTRJQo=
X-QQ-mid: esmtpgz16t1785951737t7ab188ee
X-QQ-Originating-IP: FKYEfQAQZklbWcCJ7x/ga03WhQq6qBElMFELkB5CGD0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 01:42:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9123870159283595259
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.18.y v3 8/8] net/handshake: Drain pending requests at net namespace exit
Date: Thu,  6 Aug 2026 01:40:06 +0800
Message-Id: <20260805173958.660310-9-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NJL+bfc5gN/mwmnhP2uJMkeQVzixI1/gA9JFte7lOVhvR4bvGPmobHn0
	UUcgi5YpiVB59VkL4Advi6i/wa148yKEfBfgxZth3edhPlfJ6e32ro8YBFJ1S9Mwib6UhbB
	lrhBaJXtTiYobhPiOxve2z34iTEpHAdPmUItdVTg3XgsT1pCkU2GtAp9lWG96Z/eriHr2AJ
	+kJdcuQT7/vFoBLMjd2fmjmIqCKo/EKInPw7t5yrCzxOkgntYZBzmn5HfUe6ZTyyYDcCHtu
	HjYPyZ1IlrrZrzgtTnaodp+kYgRiOKS4FJ0j598jiHeS6KpdTVDGZktNdb1/Yf+eeuU8enL
	zx4EayNhK23oITa1njTSKS8Yti+ebgEXL3RXR02bz+7pX6UQDHODHMENmS5c4Uj3AohNB66
	F73Kq9gMVA73MNotsWkmACJVYhEFEoKa0gYUW8IPjvflvv+u/xQY5bV7S+Crl0TVoIOSXO2
	ORlpnhO+W9a/6CT3iOXmR1rR72Y6JgbKGtZ85Gkzn6yaBswNNNDOn3vucI1NoVzKSUeA/Jm
	8+fXDVts4WvrF/cSkDFjO4C8/9d6lWsGVKLda/M4EmGp1e+74UZX2Q3Bh6n/Bb6GPdHjxO0
	stLINe9d6qwJwL8WgeHD5uRwbz8kZVPP4tJpUiUyv1N5GzoP+vRLzEuTWWsKdoW7HzJxRr+
	ITjIW+Et/I8Mmj81TvgF2zVM9VemEs6G7/bhJQRK2re5dfU4Y2KEoEst00BnOG6pbMk7rC2
	XfKkFiUZcA4bPio10Vm5Kzijerwj5QminU6/XcTa9FsfQP0MIaOvdLJhODcS0BF5I9LaAvj
	wkoMfU2gs/8q6LYuANXtJh4xxoBlf3DITpgNgTd+Mc+/QV5mLZ8X4eLakdIWmgrcMbp45oD
	WsS4RM0vC0amxsXhV0CQu8PTA5EZkotVNddqJPOJu9jYYRdECaTY/f6T5JHpjg/wEhJeInl
	hOun+4Iev6QnDSTKO9jEVpNcljpa0/eM0QjFJ74StqhAdJj3MaqI+9keKObIrF4zpTzEmjX
	ojURc/WV7O3uSqq/K6wmv7D9fatupG3YqvBR/aG+a/onsgDYF17ESM3GuWIW9xOV4Jmr79M
	LKu6xlMChvYCtrUWhLxk0oxezg6cWWWrA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Chuck Lever <chuck.lever@oracle.com>

The arguments to list_splice_init() in handshake_net_exit() are
reversed. The call moves the local empty "requests" list onto
hn->hn_requests, leaving the local list empty, so the subsequent
drain loop runs zero iterations. Pending handshake requests that
had not yet been accepted are not torn down when the net namespace
is destroyed; each one keeps a reference on a socket file and on
the handshake_req allocation.

Pass the source and destination in the documented order
(list_splice_init(list, head) moves list onto head) so the pending
list is transferred to the local scratch list and drained through
handshake_complete().

Fixing the splice direction exposes a list-corruption race. After
the splice each req->hr_list still has non-empty link pointers,
threading the stack-local scratch list rather than hn_requests.
A concurrent handshake_req_cancel() -- for example, from sunrpc's
TLS timeout on a kernel socket whose netns reference was not
taken -- finds the request through the rhashtable, calls
remove_pending(), and sees !list_empty(&req->hr_list).
__remove_pending_locked() then list_del_init()s an entry off the
scratch list while the drain iterates, corrupting it. The same
call arriving after the drain loop has run list_del() on an
entry hits LIST_POISON instead.

Have remove_pending() check HANDSHAKE_F_NET_DRAINING under
hn_lock and report not-found when drain is in progress. The
drain has already taken ownership; handshake_complete()'s existing
test_and_set on HANDSHAKE_F_REQ_COMPLETED still arbitrates
between drain and cancel for who calls the consumer's hp_done. Use
list_del_init() rather than list_del() in the drain so req->hr_list
does not carry LIST_POISON after drain releases the entry.

The DRAINING guard in remove_pending() makes cancel return false,
but cancel still falls through to test_and_set_bit on
HANDSHAKE_F_REQ_COMPLETED and drops the request's hr_file reference.
Without another pin, if that is the last reference, sk_destruct frees
the request while it is still linked on the drain loop's local list.
Pin each request's hr_file under hn_lock before releasing the list,
and drop that drain pin after the loop finishes with the request.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260525-handshake-file-pin-v3-8-66c616906ead@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit ea5fe6a73ca57e5150b8a38b341aef2636eb72f0)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/handshake/netlink.c | 10 ++++++++--
 net/handshake/request.c |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 21d6cbd52fcdb..3fd4fef9bab1a 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -201,13 +201,19 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 */
 	spin_lock_bh(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
-	list_splice_init(&requests, &hn->hn_requests);
+	list_splice_init(&hn->hn_requests, &requests);
+	list_for_each_entry(req, &requests, hr_list)
+		get_file(req->hr_file);
 	spin_unlock_bh(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
+		struct file *file;
+
 		req = list_first_entry(&requests, struct handshake_req, hr_list);
-		list_del(&req->hr_list);
+		file = req->hr_file;
+		list_del_init(&req->hr_list);
 		handshake_complete(req, -ETIMEDOUT, NULL);
+		fput(file);
 	}
 }
 
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 035bb2d7471c9..d4a3a50f8a3b5 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -163,13 +163,16 @@ static void __remove_pending_locked(struct handshake_net *hn,
  * otherwise %false.
  *
  * If @req was on a pending list, it has not yet been accepted.
+ * Returns %false when the net namespace is draining; the drain
+ * loop has taken ownership of the pending list.
  */
 static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 {
 	bool ret = false;
 
 	spin_lock_bh(&hn->hn_lock);
-	if (!list_empty(&req->hr_list)) {
+	if (!test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags) &&
+	    !list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}
-- 
2.30.2

