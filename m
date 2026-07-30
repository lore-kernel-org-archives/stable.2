Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950845C712
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439742; cv=none; b=lb859lCzfUmRJvpg3piVgbNChJeDMset16EO5WmCUDHs627Ol38w/t5SkDflBCP6DEEavsNRSz25CAGcObuj3T243vU6ChGQ6ueVO8EfM0YJMTwPAq1C4nC2ABOzJK2S6z8g5A/qQFTyaGFCUwe1M2h9AZ5XrMcCDCkx53ccVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439742; c=relaxed/simple;
	bh=K5WoNgXgQdg9g06mhIzR2r1Me96vNqQOOp5TO8oLp0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRSPUNkrAy1QjdZ1529vKqUNHqKPoe1mrg8Mlub9PBB3xStYEdhAhMCbzGumV2/HWJw72bR7RgbavGeVjn+YGfb9njmvwIwdFsS6y2eyWASTsAr4e4RL7FN6bpNmkqWHEV1Dq4Ce9lah2V+TZgWUWOyVrI99OTShFrTtsUcJtJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWfyuUs5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWfyuUs5"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84e252fbb7bso37670b3a.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785439731; x=1786044531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vg+HKJD//ylZ8IdlpokMPZEfihdlw8kCPM5W3QVcMmw=;
        b=dWfyuUs5rz/on0hEgLMO3WO1t9H8f3aG3StJ3BjDy72Ssdz7wq+/ktrjwxIn+klCWy
         jVvPvjVnjxJfk3JHtcpFXZD92eVXxkVSUUoWDqxUS1FX7QBfZQhMPIWliuSKhreilPkE
         eoIzK/aE8aegRHhjTH5MFbkZtyrCPv+pnYv7xd7dML6gT5MuRvl9yTc6sDSYrfk1COg9
         lyfT6+TXb8OrbK8vvuUuCjVRmcRXehKtQgo4yHCP/vfWDt+VXR7KOCHOEboqpSYgwOjU
         WWQUfFxEMTDKljHoM4+bc//0jBRwWEWTk8UtDXruMvzW2rDWIsK4joYM3wU5tZqMZIq+
         vMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439731; x=1786044531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vg+HKJD//ylZ8IdlpokMPZEfihdlw8kCPM5W3QVcMmw=;
        b=PDmKnyulhrD6aqxTkztmf03HlZv1EiSKX/lg3rGCM68+jY4pApBM23PrW5cTpkYb0I
         VO32tINKX/MslPvrTh9bEf2yW/s/G4AUb6cZlKltY4ErUC//NxU22crW6PFoHKIxaCvf
         +yZsiSlgf342bGkFGLEZWMinAPWCRxy+nCdlVlpgb5jNafMJjtbP/NnJCK0bIzz8+GAW
         YkOjDp/J3DfSsQ5ZCDcsESuDMdoy1elrtv5p2nLcS522gocznhBBXUrQcKWfu0qRy5XG
         4SDRGS4bsemMDQ0qb0+X8oDf/8ZD4De1NDNtlbcraILT9GTJhMw1eWNHIrLq6qio4nKB
         m2Dw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Fp9wq7TVarcXprDis07Ru8aNc9978Rgh1RXGcBRHE5/ocUDNDZMEuwDjP9s74kHqhXs0r/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuspW+IN3sru+w5glghMvEK3ACRJ5hzWuaan+4PnaxAuQ6OdZ
	XdFynJ8ST5Pij5aZFGU3DlguRujRZS6k9g0EkMAntyv4s9H/30I7d9eM
X-Gm-Gg: AR+sD139nDhMw52P9N9e/4z3HTq+q+8qpVmRxFbq0NKw1zUl/40MDoC2sbnq+EOex07
	vnEI8ukflR1tJOL4yHkacBdZVXV9+sIiwoWYKoxDPOe/uuqb1kM9M4WMVQctva8cwG+VKiqY27s
	wr6dQn4Omm6sjJbC3hTXMCQ7o/90uwWGfPA7vXHQ/iF/b2Xw95kqVPDmGE4OiJmkyX2SmCAAb1v
	dpINIMqlNVgufgs+lLp1R9Cz5LA/mE1i4v1OkP6AYNe0I6ehHxp1na8I4PKok6cBzahD20/LhW/
	sv5W+LLKr1FsnxvS/2vMVx5J6cOUxYI8HIIJM8bkvHMqetJ4jWv1JK1yE23bq3bzLm2Lbtrlg7Y
	dIM6EU1hTP8qP/MuTx88yglWHXc7ZELnB1lFsX1yOaLVRjdlWIBWS0SfwUYZS64ENvr/HRPkEPH
	D7fComGEmEP0OlReC2tvLTGhdnKvwtLGD/mvUicNVn/vE6D9u7kxtV21BvRZoo6UWlpVMy81vk6
	yGZr1/q+KsHjjhVwws4qne8Jxi9OMjoHWDMnltdnv6Ny6Xw0VIoarT2mcYHN2IAegzQKpskR+yT
	rasrC2C2KZC4
X-Received: by 2002:a05:6a00:4093:b0:848:5bf9:6ebc with SMTP id d2e1a72fcca58-84ecb9a837dmr1421094b3a.1.1785439730694;
        Thu, 30 Jul 2026 12:28:50 -0700 (PDT)
Received: from localhost.localdomain ([182.220.200.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0054afesm3589449b3a.17.2026.07.30.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:28:50 -0700 (PDT)
From: Kyumin Lee <fyonglkm@gmail.com>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org,
	Kyumin Lee <fyonglkm@gmail.com>
Subject: [PATCH v2] io_uring: preserve task restrictions across exec
Date: Fri, 31 Jul 2026 04:27:34 +0900
Message-ID: <20260730192734.459247-1-fyonglkm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per-task restrictions apply to all rings created by a task. Once installed,
they should not be dropped across exec.

For a task that has used io_uring, the exec cancellation path calls
__io_uring_free(). This frees both the task context and the per-task
restriction, so a ring created after exec is unrestricted.

Split task context cleanup into io_uring_free_tctx(), and use it from the
exec cancellation path. Keep __io_uring_free() for final task cleanup,
where both the context and restriction are released.

Fixes: ed82f35b926b ("io_uring: allow registration of per-task restrictions")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: Kyumin Lee <fyonglkm@gmail.com>
---
Changes in v2:
- Resent as text/plain with no code changes.

 io_uring/cancel.c | 2 +-
 io_uring/tctx.c   | 7 ++++++-
 io_uring/tctx.h   | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 8c6fa6f367e4f..7d7820eab878b 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -660,6 +660,6 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 		 */
 		atomic_dec(&tctx->in_cancel);
 		/* for exec all current's requests should be gone, kill tctx */
-		__io_uring_free(current);
+		io_uring_free_tctx(current);
 	}
 }
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index cc3bf2b3bdbc9..466b7300e208e 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -43,7 +43,7 @@ static struct io_wq *io_init_wq_offload(struct io_ring_ctx *ctx,
 	return io_wq_create(concurrency, &data);
 }
 
-void __io_uring_free(struct task_struct *tsk)
+void io_uring_free_tctx(struct task_struct *tsk)
 {
 	struct io_uring_task *tctx = tsk->io_uring;
 	struct io_tctx_node *node;
@@ -67,6 +67,11 @@ void __io_uring_free(struct task_struct *tsk)
 		kfree(tctx);
 		tsk->io_uring = NULL;
 	}
+}
+
+void __io_uring_free(struct task_struct *tsk)
+{
+	io_uring_free_tctx(tsk);
 	if (tsk->io_uring_restrict) {
 		io_put_bpf_filters(tsk->io_uring_restrict);
 		kfree(tsk->io_uring_restrict);
diff --git a/io_uring/tctx.h b/io_uring/tctx.h
index 2310d2a0c46d9..76ad1ad4594ef 100644
--- a/io_uring/tctx.h
+++ b/io_uring/tctx.h
@@ -12,6 +12,7 @@ void io_uring_del_tctx_node(unsigned long index);
 int __io_uring_add_tctx_node(struct io_ring_ctx *ctx);
 int __io_uring_add_tctx_node_from_submit(struct io_ring_ctx *ctx);
 void io_uring_clean_tctx(struct io_uring_task *tctx);
+void io_uring_free_tctx(struct task_struct *tsk);
 
 void io_uring_unreg_ringfd(void);
 int io_ringfd_register(struct io_ring_ctx *ctx, void __user *__arg,
