Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108264E235A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408561; cv=none; b=GJqiOXPJGDPrEfgWtaAfJnlS0P7CjFMXpKN5JEC1OtA55LKO+KkpHhjFf/eEiIF33K2vrt0fSrrD9yX/tnHDxGLmqe3fFD6U0FvarOaZWsTnjYoPi5/MQkxhylo6N53tK0XusRhCR62yAMXccbB6stPHvqhFpceBWqAqlHMNGy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408561; c=relaxed/simple;
	bh=8lqV+LxgYl2m/EvykQxnIXKyz1/rsjJbLS81eRPpR7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqJCMoIsvso2hY4+b+l7R+L9DPHUgRCbWL9D+ZePAxj8H0MXQy8QFscH0l+R1Xc6TtHsTp5YRUeln3z3HgArgpvdjEHwn14SS4KWfYCJdwf9lt+FZJfNd8EZsFPWonlyK5Ng+UOM7bglcZZvCAQP2M7F0n94GoAqzcs5pxzFB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYF088GX; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYF088GX"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14394530ec6so726335c88.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792408557; x=1793013357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OBCsG2VdnjP+rQWjfgSi6c+QBBT287exYkN58FtX+/8=;
        b=fYF088GXoA5XyXtn2YtJV+vqgKTDhfmflav3I+obDEYMbZfftHCtpQ4aA7uHAdMxqB
         JUEEsaGq+Qo8Ol1F6bJXNXW4KmJjCWiKPeGlwbKQVRxNI0YUHbFhLPjp+3lvF6NQG2UZ
         7ytXc7Dcow5PULAavGar1MN64eW61yQwdDqSPPlUIL+n39GiTWUDYrYUtnSLPQ9t/SGs
         WSBfkjPlbI5/ss0qQWR/GCE9p3ejZdcirBBIUrWod2B/MaJo5R69BL5pg6cbl3ch0JZv
         mGtrJMnzdFVQE6nX8+Y+NZkLZp/u3VbaERZy1H8BZbCRDOU1o3bydX1og+uXv/eMV6Uv
         Wmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408557; x=1793013357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OBCsG2VdnjP+rQWjfgSi6c+QBBT287exYkN58FtX+/8=;
        b=lECoIg9N9N7oQm4PYs+O2HBXp1i/oEK8Gz7VVn+tbSy0SRm3iVDMecmKSaN4oSdsjJ
         T9EqDTfRjRKRM/2tcCqwCzh9KYjT7JpTHq3u44cyGe/V1z/8RmA/27FiS5QKH1JD/9Xr
         oyq0wRNOIapPNAibDfsmrAJ51EJN9u2kYI3Fe6E46GVAilkfzzCLH86gy8JDCsSM5pAN
         3Zdsw/KJohYWexPUYEc1RIZenKTVKZOy5xLcsw3F1naOckvjJuRGRVwj6tifBuZdYORe
         4OOF3OOF7C4laWAi9CxQ/116Ndu6nDeibgQi9E1dBu2yZgzkciF9wO7Bpm3aUMKVF+fV
         z7nw==
X-Gm-Message-State: AFq9FYJhHgAkeJo6dxfDOUgLGdV0FQVFHSSCS4/RTCCrLqPdnmS5p+li
	4/oqvUtZFDHbwO59buPPrOXP6ktOQV5NeX9zY8duCHt9dAUFiP3GoX+f2GBOww==
X-Gm-Gg: AYBFou0J1kgnZkLq5HKEA3kStoj0bjocQPPws47kRL5z/2YmMVRsuOj0M1zRz45XRkJ
	a2ZKjewjPqvQ8dpV8AtmD6Y/YoSSoSf1yMA1awBzPSUxp7hjs9NQOTEQOirrYrkcwKW8a+48WeG
	fMpN2PVuuw8UIbIvN4uIsdJv5aVN7s4B5WsHZc5KsJCz/2gQ85vDTCHISzWkj2PHQHPuD4NIBH3
	9xZk0VPYzC+QtdbkRuYG2uG2pQMJhsFWS/+XKcLVtIQg+lY+g4solYc2hOzUiCMMiNe8uFn+Qoo
	V6cfeQhSmBgadIpr/a5qMmMOnUONOfuXTbckx5JGK+k3iN91KHs8MqTtYdfTKY5OL3xV7ODougs
	sVkG0U65w2MHTkgBdyLVtHzh+nCdF24GEcZYgOzZ1kfoRpjiwSEltqsalMBA+3UtxQMyHn0TUMY
	7+EbQrZBhHTrYi96kbQ/9bdEvyMoLUJCkiKaFsAa8gdIX/GnU8Z3vlch4a1Y+0YPjzqm516w+pz
	arOw9w=
X-Received: by 2002:a05:701b:291b:b0:160:90a3:ca8c with SMTP id a92af1059eb24-18511ad841amr9702532c88.7.1792408556680;
        Mon, 19 Oct 2026 04:15:56 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm31817337c88.4.2026.10.19.04.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:15:56 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: stable@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 11:15:51 +0000
Message-ID: <20261019111551.2063200-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.6.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
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

Tested on 6.6.159 in netns: 6 connections (5 uploading) over two paths,
then a third endpoint added mid-transfer. Without this patch only the
idle connection gets a subflow on the new path and the other 5 joins
are reset. With it, all 6 join. Same result in 3 of 3 runs each.

Fixes: 642561238c98 ("mptcp: do not fallback when OoO is present")
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 7 -------
 net/mptcp/protocol.h | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48b6e9ed..c63ccb4a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -925,13 +925,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
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
index 825f7701..d70c71ee 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1126,6 +1126,14 @@ static inline bool __mptcp_try_fallback(struct mptcp_sock *msk)
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

