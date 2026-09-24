Received: from mail-pj2-f32.google.com (mail-pj2-f32.google.com [74.125.227.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E679409632
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244038; cv=none; b=kI3LBASq1Crr46TO55GW/GPAE1msrcRGfLhlBDWV+T/DCPNCApfTDXNw3HrrXSNa58/bFU5Y1ZMT4M1OMJC0+IAsXjrviTzCsg/FxJ+2mNhCjAEohh1mw8mBGRkp/bB/8z5ZIbSpabchYcSCFrNzdXqllrAnBuRwwMOeilCodq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244038; c=relaxed/simple;
	bh=ZooIw2NXmAULWJuKoapaauNHvCQH06h1cYnr4qHA9dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzHSYGVEaFa2ZFKdGqxTfGtUADvrFTy9hJx1WCGHCHZadVxydkkS/LInfyY6aNbFMZxalk3W6B9DTL7OGg84E9UGapLdLW0/YQy6uKIQzL2JqbNrGmFAfXseJjpxnZjYkT4w8cdgAkp/SVFKA2IrvpEoL6lucV59qx8QdRDB0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc8kXbis; arc=none smtp.client-ip=74.125.227.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc8kXbis"
Received: by mail-pj2-f32.google.com with SMTP id d9443c01a7336-2d747f05ffdso8366755ad.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790244024; x=1790848824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PNcv7R2Cv9BHSyuhVjO6vXYIN0OaNo4GYPMek76PDQ4=;
        b=Vc8kXbismZsY6yavCW3hNVoMd3O7mjrCYpzwU5xDhv5qoBdXFkDFRH0UwgOGEfbzeD
         vfIwDYdTB/KTak0pokvFMqFoxxWt9qciEU0pAWDId0krVOXTwAlsLaExVZs9SeaEn5Ye
         mSANnz5uB7N21I/8HgWhaIxGoUA8QvUHjBAF5YwpEZgHWmV1JwYhTx6BXwcLsV7J4QRU
         HYxp5BdssF9BRgZpBfPOh84YF8xc8y4u18I6bMW3ym44xV/OLA8GiHGHegsO7UAzh9WD
         XpSi9S8D6nrDGZXjC8qnh54RmIsSMRBXPQIld5XsksSBXhiwVHnLJinqBGEXAIUB3Erl
         1hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244024; x=1790848824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PNcv7R2Cv9BHSyuhVjO6vXYIN0OaNo4GYPMek76PDQ4=;
        b=WBG4lZzY5BkZPgkSXrg7TjvdBXVm/paSZa48isdT8Lwv5ifbJV7eDn0ie/tFwLKxwA
         eZL05L04s1AkYlIDA13U0oiGORYlPYxyh/ZioKdYHwyuCQvjBisFAjraUuZ7PSjj4dNh
         4WfRE3rTYn1Xu/di7Vow5gMToKPhdMuuoS2hUEtk/57eNwJltuXHeRW9nahfZQK9eYyH
         Xd3U4lKBSvfHxDcz3PgtyFPpBuTk/ygCEKbNDRRK+stmK2nV7BuAyR0P71KBqD1zYVVB
         7WcFK5seBL51WSl7otWTpYUIDL7AJmEZ9nb9NuLkYGJPlG5OfdNHvtFsAXqo3DVq9miC
         e2LQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxGW60vqpzvfv5WHGsiU5D71iIuBFAfeIXv2a7uEASOcFes+jVcJlGPXAABLLx7G2MzcqApLs=@vger.kernel.org
X-Gm-Message-State: AFuF++lucr8b0H3Xm5Ny5PTZ9xk3oqt4C/NJLMPxjln9QYwZ9m1JDnma
	0oXIT3r2SnlEexQatbKkvhTZUlhvZ8UmviPOZ5wJRuFqI2VFjO+B1/sM
X-Gm-Gg: AYBFou3j9LWqk4X6gxlx+Bz0YwCprLHPySoOTt6pZN+BofyRe/4WFJqLQd72LC/XMiU
	waQwovUCZuD3Y2ZQIztryUg86k03zg6aYKZ8AxELMlc69g+hg3Pfwr4/eGHCZEdskwE1zi179+p
	qBHl2G/ZAvpodrpJQnPzgpslWpZvGrAJLx1JsjQNtyuvy1EhYEpyX4oLY6H8iN7aUEQrpWBXFBt
	MNqZ6u0PasuUMfm8XYphYgMbLbLaCm4DQyOQoTjW+JwOoAsRAhSjyOOQ9ZDbpZqxDnAsHJXB7hl
	dmUUVLd0IM4MBml3D7fh6GjD924dvtgzOxwanp72S0tp099OcZlJI+qyok+IG+r3kIX+6wRcSXK
	qPk9mdvY9wo2cG8R+6QZwnl8hyZEBGVTmL2ESbpSC3+AITg7VCGAm8uEJqdpb1hDXV6jN1LnE3p
	fM5x3r3SnlNFRW2HmUuLZO4/8tTVYOdszjcNFPZiFFjsLFLo2B5tb0ayDxdUushPnDNRzWUIomw
	i8misYxjQXCLK4ydL34gTuXLe1RCbzYmdmLZsSmcDGgyQdGf8/jrcDqRQP4uRhstv/z1UziqBuT
	O6QZHppV0A==
X-Received: by 2002:a17:903:32cb:b0:2dd:c100:80b7 with SMTP id d9443c01a7336-2df7e6681c3mr18526985ad.50.1790244022009;
        Thu, 24 Sep 2026 03:00:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516d58sm24409255ad.11.2026.09.24.03.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:00:21 -0700 (PDT)
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
Subject: [PATCH v2 1/2] binder: defer fd_install() until after copy_to_user() in binder_thread_read()
Date: Thu, 24 Sep 2026 10:00:18 +0000
Message-ID: <20260924100019.3389555-2-benquike@gmail.com>
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

In binder_thread_read(), binder_apply_fd_fixups() installs translated file
descriptors into current->files via fd_install() BEFORE put_user() and
copy_to_user() copy the BR_TRANSACTION / BR_REPLY command to userspace.

If put_user() or copy_to_user() returns -EFAULT, any file descriptors in
t->fd_fixups have already been installed into the recipient process's file
descriptor table and removed from t->fd_fixups, even though the transaction
failed and the sender receives BR_FAILED_REPLY.

Split fd_install() out of binder_apply_fd_fixups() into
binder_fd_fixups_install(t) and invoke it only after put_user() and
copy_to_user() succeed.

Tested in QEMU against Linux 7.3.0-rc3 using a multi-process C reproducer:
a sender thread transmits a pipe write-end FD via BINDER_TYPE_FD in a
one-way transaction to a recipient thread whose read buffer spans an
unmapped virtual memory page, triggering -EFAULT in copy_to_user(): on the
unfixed kernel, the pipe write-end FD was prematurely installed into
current->files (polling the read-end did NOT produce POLLHUP); whereas
with this fix applied, fd_install() is deferred past copy_to_user(), so
the FD is not installed on -EFAULT (polling the read-end produces POLLHUP).

Fixes: 44d8047f1d87 ("binder: use standard functions to allocate fds")
Cc: stable@vger.kernel.org
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 1/2 as requested by Greg Kroah-Hartman and Carlos
  Llamas.
- Added QEMU test procedure details in commit message body.
- Added Reviewed-by tag from Carlos Llamas.

 drivers/android/binder.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fb9ff072bd6c..ee01e6a06631 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4705,7 +4705,7 @@ static int binder_wait_for_work(struct binder_thread *thread,
 static int binder_apply_fd_fixups(struct binder_proc *proc,
 				  struct binder_transaction *t)
 {
-	struct binder_txn_fd_fixup *fixup, *tmp;
+	struct binder_txn_fd_fixup *fixup;
 	int ret = 0;
 
 	list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
@@ -4730,19 +4730,25 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
 			goto err;
 		}
 	}
-	list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
-		fd_install(fixup->target_fd, fixup->file);
-		list_del(&fixup->fixup_entry);
-		kfree(fixup);
-	}
 
-	return ret;
+	return 0;
 
 err:
 	binder_free_txn_fixups(t);
 	return ret;
 }
 
+static void binder_fd_fixups_install(struct binder_transaction *t)
+{
+	struct binder_txn_fd_fixup *fixup, *tmp;
+
+	list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
+		fd_install(fixup->target_fd, fixup->file);
+		list_del(&fixup->fixup_entry);
+		kfree(fixup);
+	}
+}
+
 static int binder_thread_read(struct binder_proc *proc,
 			      struct binder_thread *thread,
 			      binder_uintptr_t binder_buffer, size_t size,
@@ -5141,6 +5147,8 @@ static int binder_thread_read(struct binder_proc *proc,
 		}
 		ptr += trsize;
 
+		binder_fd_fixups_install(t);
+
 		trace_binder_transaction_received(t);
 		binder_stat_br(proc, thread, cmd);
 		binder_debug(BINDER_DEBUG_TRANSACTION,
