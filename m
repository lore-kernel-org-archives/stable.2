Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0FA52D2B0
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868274; cv=none; b=Aw8i+njM2ck+OJIV/kIPTYSbbFIOlraeCASjhE47ZtM9Mz3yF4jTBYztTveSQF/a//e1sXplPITti1p7X/hr38a3xHSVY8ngHVFOHdS26K44arQJ1nXcS45L0GKUmXG2SMh5/3NgGVaWCIb7Dme/eYwgL48FG2sQ6bg9rcqyhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868274; c=relaxed/simple;
	bh=EavnK2MUhLTzJIA85SZ1Eo0JzD4S8oE0HLiNucPkKcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwhEp4x0ux/5sSpMJ2rtSWODFLhfoh7c94AqWVsGbHXHkLQFxGb2rkdR84M/vdzi4pzTfznu/W3ynD84Ssr51h1EeZoh1YVf/aTLkGOpKtG7gUm5ShWrGS9gqG1GvOTXwjKScavQzNx8HdczM7Wl7S+ZBoL+yT+sKohOOBYG00s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnNev8H5; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnNev8H5"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so44245325ad.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790868272; x=1791473072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Y6BIYyYm7Gvl6mucwoueNVR9MeyaUsWWNYIgQ+XrLM=;
        b=NnNev8H5HcpkmmoOMBmEr9mMz85j29WCmm5lSdrVt0fLcyZtUvvj2sTGQZNGkMkV8V
         YxKPqo34uBaD3/S9Urgv9McrbZfuZZ5ro711DQHauBXoWfnxkzY0DorMvJV+Uy0yfD9w
         5L9MDfT8XgBTzRk39i9YRANTyAlcwFvvbEOwIweaXBMJwYtKx9YaZfE6A58z3Wss1i44
         0vz8h57fH+wk628GNCZ3drx6xEx0O9+XOL6A9anmpIu2WSgjwdQs2I7gSXLObBXMEcsj
         jI/I6argiFntBRFaAJZJ8jb4t9p9NqPhcql5JDwLeeEfqkg66bipbQytKDkDB7adTx8t
         T25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868272; x=1791473072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Y6BIYyYm7Gvl6mucwoueNVR9MeyaUsWWNYIgQ+XrLM=;
        b=flv17UR6pNWJ2TBdpEoS9X5nwZH8GHdUZEaSn/i3mNvafdyD1WD7T2nFcdg0UBnj5a
         dR/hi+yHa2tFCs5u905pYVrRLHMoFmhmJolOsVUQgmxFYYj/MJq1TB0r/k8XnwH573iT
         JR+PI2tazY2Ca25LGOHdgeIuD//7edK/pGO1lA2S9FM9p1XMrWJ+somT4/AabZPtH6R5
         JC5Sb5BtXkaXbAXRKXXYVPPPSVxemGS3afljFZU58MV2LWc+zm965sTHwUj7V6A6YjLa
         s/Cq9hs3WTEyHR5cI3WumzS7xFiF/oQCOaRnwxiTFIKf5rqzMz0rybkdFBzqdL8P//50
         Nhgw==
X-Forwarded-Encrypted: i=1; AKwUvBynDWqACBD9MBJ21jbmBVPH8b0hG4MBs3zEyWkrY275cnQK9yrufp5UMigW9qivA4Jki02Pdak=@vger.kernel.org
X-Gm-Message-State: AFq9FYIU4zXyKOfbmeK9qtMc88JbDnkNibb2GqS+jblfhyDQbU89eaar
	v40IiU5sEVO/8K3WuwcBfYDyIyh2od6wzfgFg3U5WO7Bp0rUwYdN0eOd
X-Gm-Gg: AYBFou1h1qzAfvnciNKy9CO1KlHhiNZqN+S1/L0bBpZWT8ywySP2FLOEEa9MWRWc8mh
	v4CTGP6QkUZ0POEtIuzsKjMBEP1wEl2eg8MyNBYCzMlgJFSaeeF2S0C5+Stzu1Lu3IImY4gjaAh
	IP+V9F0Mruf4FuOz3zbprX3FGGq1lBt3KYklXx9KiPlOzMRpTVsA9XGdAZruQGgiVzsvGcaRSyj
	RJvxIk4cbHhum3o/Rrbn0nwo1jfVSDl1tcnsOVgPWi56zpnoOmQdIlBLs9Q1QjySAVr9BGgYpKZ
	IS668jC+jpaE/pMoDPMtqFzcZ4puJxaEtqA+TdZLw8o5KXVEgC7SpmGbl2v1sthP7ETve9vMnl8
	Jy0kV2a7Q8iU6BIgfw8OXY6y3dEQ9J1Kg2iesJSQ2r9WmF5G08a1qHo3lvb8tpN5oIEFxTL3OxC
	JCo4q8mYTGZldqLnOVtKY1ODuUEaFVFp5fU5EWlLhtE/hEf9oNCsyGmr9tVc7wA2eqsKjSitTrC
	RbJt78yBQ==
X-Received: by 2002:a17:902:ccc4:b0:2db:5f8c:b81c with SMTP id d9443c01a7336-2e2e4a1ffa4mr42170075ad.19.1790868272046;
        Thu, 01 Oct 2026 08:24:32 -0700 (PDT)
Received: from localhost.localdomain ([112.171.72.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e3005848a5sm12639105ad.8.2026.10.01.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:24:31 -0700 (PDT)
From: Youngsung Ahn <ays511.kr@gmail.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org,
	Youngsung Ahn <ays511.kr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/rxe: reject IB_WR_REG_MR from user QPs in rxe_reg_fast_mr()
Date: Fri,  2 Oct 2026 00:24:26 +0900
Message-ID: <20261001152426.3259522-1-ays511.kr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930182126.2510559-1-ays511.kr@gmail.com>
References: <20260930182126.2510559-1-ays511.kr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IB_WR_REG_MR is documented as kernel-only ("can not be issued by
userspace"), but nothing enforces it.
rxe_wr_opcode_info[IB_WR_REG_MR] sets WR_LOCAL_OP_MASK for IB_QPT_RC,
a QP type userspace can create, so a user QP that writes
opcode = IB_WR_REG_MR into its mmap'd SQ ring reaches
rxe_do_local_ops() -> rxe_reg_fast_mr(). That function then trusts
the ring-supplied fields:

	struct rxe_mr *mr = to_rmr(wqe->wr.wr.reg.mr);
	...
	if (unlikely(mr->state != RXE_MR_STATE_FREE))    /* deref */
	...
	mr->access = access;                             /* write */

For a user QP wqe->wr.wr.reg.mr is a fully attacker-chosen pointer,
so this is an arbitrary-kernel-address dereference (arbitrary read
confirmed, oops). No existing check distinguishes a user QP on this
path.

Reject IB_WR_REG_MR for user QPs before dereferencing the supplied
pointer.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Youngsung Ahn <ays511.kr@gmail.com>
Assisted-by: LLM
---
Notes (not part of the commit):
Reproduced on 7.3-rc4 as uid 1000 (arbitrary-address read dereference / oops).
Present unchanged in mainline 551c722f4080 (2026-09-29) and rdma for-next;
note that commit 2dac7006b9fb ("RDMA/rxe: Reject IB_ACCESS_ON_DEMAND changes
after MR creation") recently touched this function for the ACCESS_ON_DEMAND
flag but left the pointer dereference in place. Compile-tested (KASAN+RDMA_RXE),
not runtime-tested. Per security-bugs.rst this is public and a reproducer can
be shared on request. The Fixes: tag should be refined to the commit that
added rxe_reg_fast_mr() when preparing for merge.

v2: no code change. Resent as plain text via git send-email; added Cc: stable,
fixed the author/Signed-off-by match, and added Assisted-by: LLM.

 drivers/infiniband/sw/rxe/rxe_mr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 71d9ea477289..3a914c243829 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -777,6 +777,10 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	u32 key = wqe->wr.wr.reg.key;
 	u32 access = wqe->wr.wr.reg.access;

+	/* IB_WR_REG_MR is a kernel-only op; a user QP must not reach here. */
+	if (qp->is_user)
+		return -EOPNOTSUPP;
+
 	/* user can only register MR in free state */
 	if (unlikely(mr->state != RXE_MR_STATE_FREE)) {
 		rxe_dbg_mr(mr, "mr->lkey = 0x%x not free\n", mr->lkey);
--
2.43.0
