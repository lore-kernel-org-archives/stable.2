Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932753;
	b=z0q02Dk0eGGHmqRA21yzOrut4noaqdGAnRv0sQ4quN73XUXxnqSfYEolFPg5/CIdoCL1
	 5nVRpKz3MAcNuIAckPCESYAXqRkcvBNdXhftkPqaI2voiUI9AKNPEM6nLG/PDiQZlbIcb
	 4wU0Ow7f+g/H+Y5EwFZI1BNpHJRHs70prsGL0z8/Z79dQWXlrxJMnHwwbifsTxFFcWhO/
	 UF7u2OQcXiTgrvrbVC57rdTyZ7xG7QooIoE8LNyKrftkxK260J7xViqPyEipyDR4HkoZX
	 OUCB/ATqB9iyPgysjZA5+0ckD6PWK7fucINvzLIl97lYWnLaShY8MGpXfX134XFBejw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HqO43uZusMdr88VHr3rYHnsILiH4vYVISOLh6S53DlM=;
	b=3koXkZHF8iK2Nr/d3muudYfdBGWYwUOKiVzmm3f/Gx/eRjp32nHmOLt1eQnxzfpq+I2n
	 lKtU9WNO7QrVq/nHiRumV9KMCLnw2vUIK2JFAjJcwjTwxKWShwTZjCLlmR8yGtb1ImPX7
	 BEoIarKzaZVfgCcoR1BdinCNbzzoGv2z0UYvxlDD0XvpysuvoBTg++Hu3rz+8SMMlMlNG
	 WbE0LQuFzLLY3xkvbEtNQZA8SjzrKJXE+57wEezcL8NtDyOoellibYokscHtQiuoSip5C
	 B3R7a95hAgFsW2bX0/zF5JnrqYaF35L1GIsurJtEjGb5JKpBPCX6k8qlv1cQ/rcs82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhjSzW0K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CF606A338
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhjSzW0K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631101F008A1;
	Fri,  6 Nov 2026 02:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932752;
	bh=HqO43uZusMdr88VHr3rYHnsILiH4vYVISOLh6S53DlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZhjSzW0KZWE2mC3m1OEIa/6D8aBQanb9qwlQFb8vxQP6sCU4CAZHylr3bpYPMsIMI
	 +zIeX+9n82AJrnu/7dM1P0q2xww73K1zgo7Q1gQdFlbAyKo4rmEp3govzw+9yrT4TS
	 /n+uzjUxsGNV3nFSGEarKTi4w3kRwPp8/zM7xoNcYGEsh/7dBGVN/4OU5d2MPXYvQM
	 W8o6+EdTZ0AyGIAD3R1KKXOjTRObqb8cLP4EZsKLEd1vob/NhuW5B9bmIUG3Hs3vAI
	 Sp44okk5eUyDgMZ3hSFZZKd9K+8jaV4cdacnGBaJeN5PgU2wr/EOR9Rh/nvnE1jEpf
	 v2f5EJKhCg5UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] nfsd: defer setting NFSD4_CALLBACK_RUNNING in deleg_reaper
Date: Thu,  5 Nov 2026 21:39:07 -0500
Message-ID: <20261106022849.3786687-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106022849.3786687-1-sashal@kernel.org>
References: <2026110416-cleat-grapple-d472@gregkh>
 <20261106022849.3786687-1-sashal@kernel.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 108969960dc54de673869814c5f37c22f6cf404a ]

deleg_reaper() sets NFSD4_CALLBACK_RUNNING before checking the
5-second rate limit and cl_cb_state gates.  When either gate fires
the loop continues without queuing callback work, so the bit's only
clear site in nfsd41_destroy_cb() is never reached and RECALL_ANY
dispatch is permanently disabled for the affected client.

Move the test_and_set_bit() below both non-queueing gates so the
bit is taken only when nfsd4_run_cb() will be called.

Fixes: 424dd3df1f99 ("nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260526-cb_recall_any_callback_running_stuck-v1-1-310011a028f3@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 9af39c0773ef ("NFSD: Send a meaningful CB_RECALL_ANY keep count")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b9d3e134dc1b4..d2878bf1e7181 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7017,12 +7017,12 @@ deleg_reaper(struct nfsd_net *nn)
 			continue;
 		if (atomic_read(&clp->cl_delegs_in_recall))
 			continue;
-		if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &clp->cl_ra->ra_cb.cb_flags))
-			continue;
 		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
 			continue;
 		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
+		if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &clp->cl_ra->ra_cb.cb_flags))
+			continue;
 
 		/* release in nfsd4_cb_recall_any_release */
 		kref_get(&clp->cl_nfsdfs.cl_ref);
-- 
2.53.0

