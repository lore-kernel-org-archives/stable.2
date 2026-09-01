Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BFC4A3853
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295980; cv=none; b=c3/HGsOdLDFqDsG0RM8bG5Bn6jJrdDRcIEOGkl6hYF1iZp+5beCT26DlekTgTa8UAvux/FME+DsRuvMMisUscgE3JgpZZTpxGv9U+bCj6zPldRRhCmTKIw83/Pj9F+boTZI5ef1HIIT+rmNwkraM6avcWAmw2jfIgOmi4AVcF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295980; c=relaxed/simple;
	bh=GPmeVGMLIoZoIlDJwvRRrzHCCviiWSVdzdWd0kwp7eo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DD3B0TW7GVhJFzrvfm513mSBWx8GcAyTHGXH+j+xMqflWRxzLeBJ9glm49w8gKDQJ/S8IFFi1hbKGO2hc3M1/cidSDr9eOVwNIgj6bYbxuItZGJ3NaTaI8KVDYbQyUC9O0B4/byKHb5LtGJxi7NfftJ7mJZkujOI2mFGq0RV2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m5ecM0yJ; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5ecM0yJ"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d7151120d6so3580455ad.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788295979; x=1788900779; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efterSwzpT8WmqwjvTJaX4ZNpH8DVSU8cX8allgguTQ=;
        b=m5ecM0yJsyCkqUMj/OhmTLDBCeK8fq5schsf/1klusppv0XbQdHhKHewW4Ggp8Ui2T
         ViDRJVyaHxRPmK5MUVAM7BgDdlfD1BG6kTAMMxHCwl/nBs7WtCLF5k6M4tEOHONSRbYT
         8f3O0FXv8hJ20QpEsYW7Fkp6kKkIkzLhb59LMHFxmA0leEq8R6WoEtPnMrFD4oJufCk1
         YwkmoyPJzxDs+7wrehAM7XqU1lKzrP6PUrhJLwgVC35JTXsbKJDGh187joiSm6xY/7xa
         jMmHZvNOUww9OsBNSIOcnIolP1VbavTeHvIpdacG+rKHVL3L3Hvyxw59B/RTyxRH+TlY
         N8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788295979; x=1788900779;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=efterSwzpT8WmqwjvTJaX4ZNpH8DVSU8cX8allgguTQ=;
        b=dqDhSSqlQ1VoBDp9+IAwednAiICRs7rqiQyQz4qaBUXkA4Aw9qcixcybjRK8TzHMgT
         KXO/QNEWz96n5sH5ZITlSJD8JS2f9lRTuxhLedVVCFq7hTbpy8PuxXsMG+u2hsecmtTU
         uWCJtwC2YXGU3NuU8DRE8DFZmRPkHkkSQsNKbwpCUwZeYEjTD14oZ4yB5kU9n0emK2Ut
         ADLhzqdC9n9sKW+su88bR/EfGVxP8GKajlWeqqWEs5aoo3bo9lihyE063HyqikGzBJtO
         wNzaN3SuDQZ1XuwB85OQGTGdr6OCE2Sel8pL1QRVDLpEyF9VLlR7yPnJwyEgnPVIZ3cI
         b6yw==
X-Forwarded-Encrypted: i=1; AKwUvBz7Tm1OooU7oUR78AIXM5y0i1pOak2ovE/NxPdfOCxmfD0lH28/QyIRH+/8EB9n8P9H/X73KnU=@vger.kernel.org
X-Gm-Message-State: AFuF++lgTd2ZTW2mxueUQ6QHvfvIRvfGABUJKCr4TUR2ve4RowZcYNXu
	5Fnll87zW7uDrf0sXvYVef3QvUdZbgbWoEulr6qJePPzEOBbLFQz0L8GyAtSSoywLMTCdWTFnou
	nLrzz+HIKPlUEeA==
X-Received: from dld23.prod.google.com ([2002:a05:7022:317:b0:13b:9d65:a542])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:394c:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39907e4ada0mr17485453a91.17.1788295978602;
 Tue, 01 Sep 2026 13:52:58 -0700 (PDT)
Date: Tue,  1 Sep 2026 20:52:43 +0000
In-Reply-To: <20260901205250.1638304-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901205250.1638304-1-cmllamas@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901205250.1638304-4-cmllamas@google.com>
Subject: [PATCH v4 3/7] binder: forbid vma splitting
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Binder does not support splitting its mappings. Allowing so, leads to
potential attacks that stem from a partial munmap(), such as closing the
tail range and replacing it with a new mapping.

Close the loophole by explicitly rejecting vma splitting.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260901163521.1355535-1-cmllamas@google.com?part=2
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 1b492ed48ea6..185128577829 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6032,10 +6032,16 @@ VISIBLE_IF_KUNIT vm_fault_t binder_vm_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL_IF_KUNIT(binder_vm_fault);
 
+static int binder_vma_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct binder_vm_ops = {
 	.open = binder_vma_open,
 	.close = binder_vma_close,
 	.fault = binder_vm_fault,
+	.may_split = binder_vma_may_split,
 };
 
 static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
2.55.0.966.g6673acef38-goog

