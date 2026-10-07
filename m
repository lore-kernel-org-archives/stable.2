Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C7E46C4D3
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366698; cv=none; b=RrHZna/D2UJ3zonP/ll+WA02OJSVaWENJlDIoBsNjOwMAp66CcEpta3YvNED3O5SNrnIbe0BclkIx0niAnWZnEd9s6Grcia1hfGgdtEbU4OiqxPvGJSbKRaxnqp7F5R801kLTX9TYdS/drDPHd3eqW5S/ehhqUpdhqBWTzMSITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366698; c=relaxed/simple;
	bh=/Sq51opT+pCTWy3QNnNI3fXGhVvRT9I3pfHWyC7IIJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRJfMhdODavWdyZfIhFAykIvunpbOmubYGv7MWuNvaxTSJkZbjGmuMnlgDQvJXR7In7qx3Dq1zKViczxke9ZGwGnYwfj6rr7KjC59l3Qvq/KEPhz30AFOide6qs38IiODB1/H47iGOgzWRSThrzvVgAQEYLjAPHstMpDG4lbLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqJsciZg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqJsciZg"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1545619a91.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791366689; x=1791971489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=81iw+VezXIuwKODbfw1IR0OLhT5NZkd1eLLqyo8b2hE=;
        b=NqJsciZgmLq+N1DiaW8aEiNqTHuKdZnaUBcZLsxg3hj6Kr/uVMhLrvLgMXjDUAdzxh
         YCRqp8ZuTFim6GwArsPO44cdsy7VC98kF5rqQ1WvQxoRyNbFYQ4HFx3B2zDBWgbhEAE6
         571kUVrpQs7qhy7qeGRhzf2M+8mr0bQdeoOZuRKtqEy8WuTGUgypJ5DLGEMclmhaB62Z
         PmCItA4dwM2KaEBRggNTRexWxSrw8XOTqXHpqxgxeO6TjugZrnwjoQnAuloMEl/Xyz7C
         56AKWrl1NdYFEZZ3Vo6oaLeuL45TFoRaCo95De25XiaARApfvbMRQ4HG4T3CmhaJu9x/
         73fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791366689; x=1791971489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81iw+VezXIuwKODbfw1IR0OLhT5NZkd1eLLqyo8b2hE=;
        b=CQSF0H29HuCbuTkLh/KoBzNaVvPbNI8Lc9v5liE0a02jl76a1XhNKIUUZWEk/wJnJ3
         FClABHax78bfuuZdGE+9rhchU/6e1Kzq6wHijsfGEAGvVGrvUt3Zu/ZnIi5dlhBCHANl
         ELXfqAaihfbffRRvow//3Gig1DaYUCXt7NzvahuoZBUULInRswYCTPrsaqf7otvjPEqt
         IMG/FlN+NecMQ9wj/x1dnSCahl6/hycroxYKSKgCRUyvfH1hyQhcaLuEnHgf6fe0piA+
         VFiapiW+X+xj+38D2E1Gxhg6m449TNUCmCUh8RXG/zDPTrMyBL8apHLLQtzYsx2iZgPd
         GEQw==
X-Forwarded-Encrypted: i=1; AKwUvBxOjdKLncR9LnxXAfUtQjlUlp301XDuS7AAnu8dcqCGvGOTP+lb8QVcb7MQG5Jk+1UQYXdSntA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3APVLpbgMawhoe2AnyyVaWQXOkpI+gKs/pyCYxMDa1Ma4kfYN
	i92t/7mZTHPEt5kH/DsL0fStr3VPssdahpL9PoR/uhhNfHN1KHbuwMgVdsGTv4b+
X-Gm-Gg: AYBFou3zFzw8NiKRwD0h8QrFFpgZim7A+HGHkGkYgdqZynUsYsdBKbi4o9YxYaSuBKA
	pt3aezcS9gZZ9D5SUFpnhgWJP4+zAPTskRDmJw1gTDfZlKw4QMU+fiey804gTwLapkHFgEK66ow
	9/8+Gve/LaohvAUPB0gYnw0j6+Cfz1DkuCk8XHZ0iQAVq3ai4nClpAZtlEgzcxuAxd2WLQA7RPa
	uPOF1z5GqlJGfMHQxxKHLvsJwnqSFLymnWzitKp1qzep+6eyRJiDBLEBlt4KDYEzwvIaavDl+ik
	f5jgSZWohyjWZN+Ws4JBtOFlB2SSNg9meglx06QXGUL9O6bu1Iz4VgizemnT1qEermGUwCqec8F
	sETstNxJA/pi8mdXld58p2OMXux4RS/HKncwuuGmeC2nNf8pmJihuzDwK+Bat98hJONuC10M3rU
	CNg5ri7pFyIL/hjpFIsCcHYFc//PCbl1gaVZ/cQeLsLJ1xxVEfe3Kdkncfm8HuHgU/OS/41tajb
	lZtwN68IGKWGzY75afh0BwN/lhMhVbLDKU/Bjiii/aFLIgp6yLw606ylLDbEetj3BrRAmaW7l2N
	8yjO6Er6Wvs=
X-Received: by 2002:a17:90b:4f87:b0:3a0:e985:9ca2 with SMTP id 98e67ed59e1d1-3a8a13bdd81mr815434a91.31.1791366689543;
        Wed, 07 Oct 2026 02:51:29 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a4a173e9sm1090228a91.3.2026.10.07.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 02:51:29 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Vlad Yasevich <vyasevich@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3] sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute
Date: Wed,  7 Oct 2026 09:51:28 +0000
Message-ID: <20261007095128.1370109-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an SCTP stream output extension structure (streamoute) has not yet
been allocated, sctp_getsockopt_pr_streamstatus() sets the local stack
variables params.sprstat_abandoned_unsent = 0 and
params.sprstat_abandoned_sent = 0, but then immediately jumps to 'out:',
bypassing copy_to_user(). As a result, when an uninitialized user buffer
is passed to getsockopt(SCTP_PR_STREAM_STATUS), the kernel returns
success (0) without copying the zeroed stats back to user space, leaving
uninitialized data in the user buffer.

Refactor the !streamoute check into an if-else chain so that when
streamoute is NULL, params is zeroed and falls through to copy_to_user(),
copying the zeroed stats to user space and setting retval = 0 once before
returning.

Tested in QEMU against Linux 7.3.0-rc3 using an uninitialized
sctp_prstatus user struct passed to getsockopt(SCTP_PR_STREAM_STATUS) on a
freshly created stream: on the unfixed kernel the user struct contains
uninitialized stack garbage; whereas with this fix applied, getsockopt()
copies zeroed stats into user space and returns 0.

Fixes: f952be79cebd ("sctp: introduce struct sctp_stream_out_ext")
Cc: stable@vger.kernel.org
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Re-target subject tag from [PATCH net-next v2] to [PATCH net v3].
- Fix Fixes: tag SHA to f952be79cebd ("sctp: introduce struct sctp_stream_out_ext")
  as suggested by Simon Horman and Xin Long.

Changes in v2:
- Re-target subject tag to [PATCH net-next v2].
- Remove redundant retval = 0 assignment in !streamoute block and fall
  through to copy_to_user() as suggested by Paolo Abeni and Xin Long.

 net/sctp/socket.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index a2235905d2ee..bc5b78ab589a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7568,9 +7568,5 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 	if (!streamoute) {
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
-		retval = 0;
-		goto out;
-	} else if (policy == SCTP_PR_SCTP_ALL) {
+	} else if (policy == SCTP_PR_SCTP_ALL) {
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
-- 
2.47.3
