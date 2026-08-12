Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3C389105
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564405; cv=none; b=UOFi2i1pYw1BTQlEJqw5eO8Ah4Iccj6vl6tzZ6DQOvu07jhhNH2Pmp0mCjXOr6n7q/eyfONQQmxyuM8ppmGeMxv6Uqf5c56Z+nLuZC1wQBig/U6+NrWNuCv+XzcwSDTkBMESxLqpToMU7pjq7KHn/7kfbhiQUNMviZ1Yv4ZDCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564405; c=relaxed/simple;
	bh=1W8e4wpZPZLzut4w0LZHjkVlCWXXUAeFpfsFi1oFnRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lv/fpSGgMIDQjXAfAEgkhNDfdwNodSj+eulrP6reftYwXq/fs21FMu6Or7ZASZbbOV/IrLFTzlM9MGtrLoDbnSGDalmJ7bConGQMOa7qe30x35fImCkeRqxlVMv4cMG8Lu/47AA15knFssWinFkYcuDxQNGGfPIiFmGAR/P2WyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doUeMkQJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doUeMkQJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956869750eso8367285e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564401; x=1787169201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8WtQptPrNpuEEvK66rg9JD+38qbFTV5CtL/lpUnjhw=;
        b=doUeMkQJ4LLKpDzTP5nXoFnx8hSSq1AXjc3de27EAZod7eDASNA1DDrcbTHcpgE0CH
         UXec5PdUnzNE2Cb5NB31RTz9Xd50HoVs1o0S0Rs8oqJrRQZwfZvOy/tRVr2MKt++rnFw
         Vg9se0vZJV0URqneTjdZx8jHt+q3xZ7ks6zTBNaUogTnC6zTH4F0OovMVrIbgTuNTZ5k
         BkRYOwuslUVF+g2vcaE6JJ3+XOnZg6urBSMEUaPhhVXcDQevTGo6JZIFOyrp5xZpFLzg
         FUxtCTx4Ck6wJq+oCxqJ+9FFx7d1GvQUq2LjN1O7CXT9MsfNI0rmpo4mfHKMv3+vrO4K
         hN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564401; x=1787169201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8WtQptPrNpuEEvK66rg9JD+38qbFTV5CtL/lpUnjhw=;
        b=jWD8DPV0ImYMXy6uPCcf61vPkhO6rgg6tZNeVts0sqCXi3j1CSnBC1puMhZNC/GC8u
         CG8GuMci4qCBTMc1sH5v6c8Y2fidztE64BNADcqnMYF4731ij5s05d/Ef4rdaX41aNa0
         MwCFGyP0+6RVnA9sHD0SmI3OCseuIGOOXLiBw+4aVXiHEC5auZg2b8YIn5jx1HDR6DH3
         bp6mPWCDFaTSO8tu3hmOSwmWueZEMKRWDP6uYmJ0NVFSUdQx8Fji44QNgk9rqFQP48Wz
         RonHdfzu0WmTsmvhRduyTmDq0BmTNTx4CGiC9FNOiyhijbYKVL2gyeP3w9JJnVTfm3fP
         Ka+w==
X-Forwarded-Encrypted: i=1; AHgh+Rqzh3i9LhoQJSoPXHYh/YXI/VimWb2bp9ewSmgCrs5F0mcDPISRZLEh2KIKW0wSxLh5s6rUC6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqEQHPNA7cl3DbdFVLdYLYPnymd67MrTFz5cjQ/Xg4vHMjLG5
	xYUyqB3og40NTAKgGUF84j1iM8S0FddkzNM1igmc0YdDXBzmS0QGh+/A
X-Gm-Gg: AR+sD107Jyzy7G7kahQru4M9gTlt+J1Vnzhwng09rK0bRO03S6QMSzbhc8lcUWP+GeJ
	YJl81cIvAy6P0091rgeJ19PMKCITC/Yffv4IuOBO+16m4RdNcM2nz09HRUB3I9pQxFQTzB7SdUa
	bMOc71Gq8QWBkervfoxkMy+12kweZlhPkBe3pW0wPtTEslVOMCcjjOwochwyuIcwem5bED46s/R
	g+ZtufRqed5v00J+hKcnkN88xYC/NlTMSJdGvGA7vGqCEJAsA/QNiPgvaZ1KuRdXLpY5oA6F1UR
	vACyI472gQ0gmbxSllIkAYPR7YK7+o0SxAz3GkX/aaOcTECzQEaZcONRjuRaPEhQjSHZs4kFCq2
	8QM6aw2G9n/xGrj7juyr9hOAaBXDEWp9JFwgGZt+JSWDRy6SiWIj9dYLsfLZpcrcIFyMV/bz8M9
	Ob4JPxNxKQUsrx+1ai1PmgvfVsaXej2WfxRvmWS0+/in4HvaJTTjGqLlQCOnilF8QwrQAmjH6zc
	xrGMU1SKIWVFT60IrPB0y8C3PTNmSdxvE8mSm0T9ZkjIH2oRQ==
X-Received: by 2002:a05:600c:c177:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-499821c5be9mr1430455e9.4.1786564401398;
        Wed, 12 Aug 2026 12:53:21 -0700 (PDT)
Received: from karin-metis-desk.tailaea490.ts.net ([2a06:c701:c1f7:3500:4c98:e58c:bdb:6080])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981abd6desm13145665e9.0.2026.08.12.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:53:20 -0700 (PDT)
From: Tomer Pomeranc <tomerpo@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	brauner@kernel.org,
	cmllamas@google.com,
	aliceryhl@google.com,
	stable@vger.kernel.org,
	Tomer Pomeranc <tomerpo@gmail.com>
Subject: [PATCH 2/2] binder: fix is_failure flag for superseded transaction cleanup
Date: Wed, 12 Aug 2026 22:53:16 +0300
Message-Id: <20260812195316.259136-3-tomerpo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812195316.259136-1-tomerpo@gmail.com>
References: <20260812195316.259136-1-tomerpo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a TF_UPDATE_TXN transaction supersedes a pending async transaction,
binder_release_entire_buffer() is called with is_failure=false. Since the
superseded transaction was never delivered, binder_apply_fd_fixups() was
never called and no fds were installed in the target process.

With is_failure=false, the BINDER_TYPE_FDA cleanup handler interprets
stale buffer contents as installed fd numbers and passes them to
binder_deferred_fd_close(), closing unrelated file descriptors.

Pass is_failure=true since the transaction was never delivered to the
target, matching the semantics of all other undelivered-transaction
cleanup paths.

Fixes: 9864bb480133 ("binder: add TF_UPDATE_TXN to replace outdated txn")
Cc: stable@vger.kernel.org
Signed-off-by: Tomer Pomeranc <tomerpo@gmail.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f70aeb63a..bc8bc9ee4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2930,7 +2930,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 		t_outdated->buffer = NULL;
 		buffer->transaction = NULL;
 		trace_binder_transaction_update_buffer_release(buffer);
-		binder_release_entire_buffer(proc, NULL, buffer, false);
+		binder_release_entire_buffer(proc, NULL, buffer, true);
 		binder_alloc_free_buf(&proc->alloc, buffer);
 		binder_free_txn_fixups(t_outdated);
 		kfree(t_outdated);
-- 
2.34.1

