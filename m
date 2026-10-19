Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786E3559C9
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408572; cv=none; b=kQBMZDcYTvU/4vzbKeFt2LEcx40LYhnFOir2d6eLPGDcXCf0YdFYTBIbQD0Z7AENdZIYhyC06giLHkrix6p+FwqdhDEFGolG0Gbbr/lo3UrqjnoLG+2vSTCM/YnVNP5mICqpYhAYDO242EPzXWsaXSo+pkj6PmX9xSbnyvBPao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408572; c=relaxed/simple;
	bh=iz8BaEglKzNiDaqzpo32rmLdGATYVIwM2YXV38QpGII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcGklAE1aLfqVs0vVGNioKV/3zOYnJ1634kM3dkcXaSgkA0E7Lf6X6qBuNprvz0NzSZPSi3280a2txH+onmDdl6fMahElrjyoeMDgnIY3Dfy5anSoxZ/6DSTlQLGnGqkb3b8UiT780rjPOWsmZfZ/MyuEbsXviIMrOPjZgrR+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb4fMSJM; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb4fMSJM"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-354ba08cfd1so3561165eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792408564; x=1793013364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wzzVad7uWaphIKub8ka4ND4kxhHIf8Bz0Lzltgz+Dmc=;
        b=Jb4fMSJM4B72AR3Zkhg+Xs5MJ0RXVphZGCvekTxNYWxRismcsJLECMTGcUyp7XXVQF
         iu+45pSauCiZSK9JjKk5XX0ydGt0cXDSo1fvux9L30hzXdX0aNvwdOTaX3jam2fo44OU
         OSEeiwiDuHXytoAvnt1Yy9+zCjV6nys9GIlS/jImNrHOHuU/thnXPpJtE523/I6yXhPC
         l6BrsfPCz6zhfq7k1PD9Q+K8rpdGEEZ3R3HtX2fh1M6/U1JcDMoZy6Apk5hBqF82Prk4
         ogq8hEqeaX+N1lDhItTm4/uv7vdsdkAdmx6BwQMuTyiof6cOKfTFsj8jRug3JF9hHllR
         jMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408564; x=1793013364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wzzVad7uWaphIKub8ka4ND4kxhHIf8Bz0Lzltgz+Dmc=;
        b=uOqRaR1nVMoh/6VgzLIvHxBRhDY1TVDkvVR4UAZPi/4F4xBH4reFAIAqAaYAnN45iv
         EOZjc3ZKnQ5PRYVQLXy3RWkLcTbuk95uYnRaNqsEeRRKCKM9QvAHC8TvlUPbonl7BUqT
         9nvMSMxDclRVv40BxVs8iF5bQBEJIEuMeDQa8XT5zsRo0Iux4HTTvoqWM1MNedvStWEF
         k7V+KINVxxz3NxCXnNZxiQ67aLQDDEItVR+eCeXbalLCP8+32+oV4sjVD6us57EahHV7
         WGM5qptTCDWvBEC6ccxPN/0ijutnULhEw/JnBVeuanoAn9NQHCl/+nOB3zflls5dTsd3
         FkKQ==
X-Gm-Message-State: AFq9FYKWnscGHvlTLoWGHD8LOFObxW5o0tFH1HQE2QzNHsMWsBQ9z/wf
	kQE0BdBOw1gSEpMLsKkN2na3c3VlQy+TdQZLnkFkM5OjbjXqzQpKWhqjYOYcGA==
X-Gm-Gg: AYBFou2MckbzejqZvOjbb6u4w1IrMk4lUl9hsYLxutgGodLMBJOAaff5NA71+IjDa1l
	cTvm2tjJMciHz3KiSoBVTwnmCP5ANCrziFaWY5PRw/+MvLLY5deyy20TG11qC1t3E3/jeVTMHX0
	LpZKRlgmObMScSmYRRM8/5ELX0x8KaBytZ66kLITQkefu8VuDUigFA3tHLJFpVmWFI1gtxVyGic
	30HyzWhz69e0YaLFrlr+UdC1GG6ZHSopDcU6oyX1HYqnKO8sa23IIjqtkEO4cfvQ3aBZm9jcjak
	vjwc4U0YJh7fnSN08e+gGhTekr/HgNVyDIKYM5O/1eD7j0xBB/spJVrGsQPxeqMBY3sR6DkLz+4
	KodjkiTQ+1hzIdgecJR7zW3m2DzwdZzTgIg+xxAsUfgppR3rXEYuvJg2V0MxGd/td8srkiZ64TH
	Ng+gS4FoZOrzlzDd/fWPK+93IUe7ZiOXEeAi6poyv2Mfvf7zyURmZGMm7fKuLrtLf/HFSUw4+Vp
	l0pOuo=
X-Received: by 2002:a05:7300:7aa1:b0:351:5cb5:53f7 with SMTP id 5a478bee46e88-3619e926244mr11216707eec.3.1792408564054;
        Mon, 19 Oct 2026 04:16:04 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082f7f6e0sm35689068eec.27.2026.10.19.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:16:03 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: stable@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 11:15:59 +0000
Message-ID: <20261019111559.2063342-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.1.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
fallback when OoO is present") put the out-of-order queue check
in __mptcp_finish_join() instead of __mptcp_try_fallback().

So the fix itself is missing, as fallback still happens with OoO data
queued. Worse, the passive side now refuses every MP_JOIN while its
OoO queue is not empty, which is the normal state of a connection
already sending data over more than one subflow. The joining subflow
is reset, so such a connection can't add a new path, and a path that
comes back after an outage can't rejoin while data is in flight.

Move the check to __mptcp_try_fallback(), as upstream does. On this
branch that function is in protocol.h.

Tested on 6.1.190 in netns: 6 connections (5 uploading) over two paths,
then a third endpoint added mid-transfer. Without this patch only the
idle connection gets a subflow on the new path and the other 5 joins
are reset. With it, all 6 join. Same result in 3 of 3 runs each.

Fixes: 9074732c1caf ("mptcp: do not fallback when OoO is present")
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 7 -------
 net/mptcp/protocol.h | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 10be901f..cc0d8a19 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -932,13 +932,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
-	/* The caller possibly is not holding the msk socket lock, but
-	 * in the fallback case only the current subflow is touching
-	 * the OoO queue.
-	 */
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		return false;
-
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1de257b8..39c1d823 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1004,6 +1004,14 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return true;
 	}
+
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);
-- 
2.43.0

