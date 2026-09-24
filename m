Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4184071E2
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244051; cv=none; b=eMgjW01N3hzAqv8RmeN9UpI1ooVnv/45pVtSTmx6RJlC/KtPJfZggUinsKN2CCXVo8cB1dtB/QfaZxkibcqbXjnPT2ZpFc2aEZADNr3PY0gI/qgzGysYulT+p/+jT7IOnYLmXlYC19IpcDwAZ0TARfl6wMv/1ZEMqFdjx5UrW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244051; c=relaxed/simple;
	bh=dszis8Niv47E42Xdhjmyu9YfEidDCYxTVb5wGh2KKns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROMXPu8uN/0UmdvAae5r1Q9rfELkDZdVLyenhje5nIAyGb1B2r61iMXKcsVWrsbGiOow3UcIqLqYnHC0D4tYxDodgv/tWpVctLUi2q8GlOi+93+hLcCS+Bv6sXsg5Y9BfcXueUiCHbivj1vrE+GldLH96yWLQK9tPmr2c5LYVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8/nNUg6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8/nNUg6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so3585605ad.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790244023; x=1790848823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDu5V8VFjj7o7vcgGcrsEHmG2L9tByu/suT9MpcaWQ8=;
        b=n8/nNUg6XPe6Nc69cIIizAbF9mdxa4Aso/uQUJpn383E0KwExDIa9qM7ZUjRsmWJPZ
         px4jr3pGQZRuBi/ICZTpFSTGnO8JoPe2qH/jqfTBte+hRKWjfZFu0eG0Pkig6rvXkVYM
         GVL3JVvnBGIekV9jSEzORi+nIlRBxtyw06yAz3s8KMy5L4cYkdPSA3VutElaFu4hv8dv
         oSOo49J4TggNGgWy3PkOjOD/s1Pb3MdrqUpdcxaggYum5y7Alb+m5vaOVp70uzhGpXmU
         sAEi4nJDSOHv/x+JB+gHWfU/aFNA+CvBdVdgYmKLFTbVhAM1QsZ+1Sp+NpLO9dJMLs6k
         0EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244023; x=1790848823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bDu5V8VFjj7o7vcgGcrsEHmG2L9tByu/suT9MpcaWQ8=;
        b=L+G2A63m+3GupxCojLVgwAJzm4WCtpP9K2rry+Tgc8fDMq5WQH6YGJw5CtmxXd/QNe
         JbXGXNVZDn4H2v6vmQeuqglEuzKHID21w+Co9fppEydxMHJD4rASE3x3FAI7j66K4w6u
         86XyMQ+ozC30hRzFzHSW7WqmWFnj9ZstUqbaJVZunGxR+uAepqir6CkOFIpKF33N7yxx
         6TGaweHRHWZDFDagH3UbFl+iA1xNyrmPd/fHz+2cw2VFF9LlxlMBdYVaNyIe6pVjdxwo
         SvBMleJ8K/b4U8oYSQrZjzPMYP2pWD7jGsNU+bxgW+giVOMUCXYjdAfukQdZcZ1B0/q6
         Gjkw==
X-Forwarded-Encrypted: i=1; AKwUvByG7ms09bJziE42qbXuhxZU6Oyq4VALAycYNztEeiEByGRmsINUV3ZK3O7qIAcW4n2BS/DsSps=@vger.kernel.org
X-Gm-Message-State: AFuF++mtIRfPX4VHjaYy6tVErJAD0lNAe+nCcB9pQn30R4txvjWpCz3S
	RqcWtbrpT0bu2i/7Ln8rESnMeYxVKcN79L2b56m9BprCkmaJ14pCKaUA
X-Gm-Gg: AYBFou3pKAY0or6+OW/MWliChNGPP26oXSQ7QarGRnbr6T6rTP3rUBKdjx77HlF2HxA
	PFJAg4UiTKJcMQquwqopiFfgSwFqb8y6RCNrKUsXuXHCSD+MMTPBzrQiuC15GdY2jMKVMZitT1I
	mMPQazvnMjAFnU/ua5fXUa33z02gmFLdqOdH3Gm6tN5H/8p8exX3+35meC9E1+PYcTeYC0Qr5pG
	j4wsFSDG70o0+L+3GBNSp1WyPL1US68ZtHc5k2pG3qKfDPN9u9uSOomx8drvRsQMJIj7cgONV5a
	SDh3VeEn85hosqh4ZBdF7DekffkcdZV4wFF8ajK9zLIk0uGcTWo2qNlZRyBauyM2wQgnQowGBhG
	SU5sv4QQs01jLLimEnTbdyjaPG4In05tXoiodXlEzSyToSCb7rXOC6Zd0hjvx+s+JXrI1xGfJv/
	Phe3xjyG4ycjIuL/zMCzpYn0E/ElhR868Cndo8z9J/zuteqJ22EWl+vhr/2U+GkAiMRPU6viaXP
	Gim57Bnub0G6i2Tqqx4TkGrBusUpUwpQWza/3Pg/gMF+N7V2IjLgvYOiQHmFXB/qnzNUcHBtKQD
	5P1LNYiZ2A==
X-Received: by 2002:a17:903:17c7:b0:2d8:d4d2:d138 with SMTP id d9443c01a7336-2df7e251f68mr11229755ad.20.1790244022862;
        Thu, 24 Sep 2026 03:00:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516d58sm24409255ad.11.2026.09.24.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:00:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	brauner@kernel.org,
	cmllamas@google.com
Cc: maco@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 2/2] binder: free transaction buffer via binder_free_buf() on read -EFAULT
Date: Thu, 24 Sep 2026 10:00:19 +0000
Message-ID: <20260924100019.3389555-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260919213650.3316812-1-benquike@gmail.com>
References: <20260919213650.3316812-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In binder_thread_read(), if put_user() or copy_to_user() returns -EFAULT,
the failure paths call binder_cleanup_transaction() without setting
t->buffer->transaction = NULL or calling binder_free_buf(proc, thread,
buffer, true).

Because allow_user_free remains 0, the binder_buffer and all translated
binder_node / binder_ref references inside it are permanently leaked. For
oneway transactions (TF_ONE_WAY), node->has_async_transaction remains true
forever, wedging all subsequent async transactions to that node.

Fix this by setting buffer->transaction = NULL and calling
binder_free_buf(proc, thread, buffer, true) on put_user() / copy_to_user()
-EFAULT errors in binder_thread_read().

Tested in QEMU against Linux 7.3.0-rc3 using a multi-process C reproducer:
triggering copy_to_user() failure on a one-way transaction: on the unfixed
kernel, binder_cleanup_transaction() leaked the transaction buffer and
left node->has_async_transaction set to true (wedging subsequent async
transactions); whereas with this fix applied, binder_free_buf() is called
on -EFAULT, clearing buffer->transaction and freeing the allocation cleanly.

Fixes: 44d8047f1d87 ("binder: use standard functions to allocate fds")
Cc: stable@vger.kernel.org
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 2/2 as requested by Greg Kroah-Hartman and Carlos
  Llamas.
- Added QEMU test procedure details in commit message body.
- Added Reviewed-by tag from Carlos Llamas.

 drivers/android/binder.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ee01e6a06631..efff59853752 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5127,24 +5128,32 @@ static int binder_thread_read(struct binder_proc *proc,
 			trsize = sizeof(tr);
 		}
 		if (put_user(cmd, (uint32_t __user *)ptr)) {
+			struct binder_buffer *buffer = t->buffer;
+
 			if (t_from)
 				binder_thread_dec_tmpref(t_from);
 
+			buffer->transaction = NULL;
 			binder_cleanup_transaction(t, "put_user failed",
 						   BR_FAILED_REPLY);
+			binder_free_buf(proc, thread, buffer, true);
 
 			return -EFAULT;
 		}
 		ptr += sizeof(uint32_t);
 		if (copy_to_user(ptr, &tr, trsize)) {
+			struct binder_buffer *buffer = t->buffer;
+
 			if (t_from)
 				binder_thread_dec_tmpref(t_from);
 
+			buffer->transaction = NULL;
 			binder_cleanup_transaction(t, "copy_to_user failed",
 						   BR_FAILED_REPLY);
+			binder_free_buf(proc, thread, buffer, true);
 
 			return -EFAULT;
 		}
 		ptr += trsize;
