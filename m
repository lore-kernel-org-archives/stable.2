Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403896;
	b=w90c7G9yk4Up29PzjV6NQdZpePBp0IJ/WFxx58cKL9pqWzYELU20dSnYGgRggUGW2oem
	 uY5EZpE92j2hw8HKVaUioJmvkoQNDC+XYGPl/gXhr3aUD3vSaBy64m01j9KNZWzcHdfxU
	 kXQA2rnwTv9HG+XxB2uIa2fqODjfVQA0JB0/3j8GYZz3N2n59QROqB/NrMUFsrp3n2qNY
	 hKBAX0OM2RG9+iCreeOrr0dZiN9344arK4u+SHIv97MGdO1heBCI7nnWzbaKf0CKN/cT0
	 np9zoIVKOx67ce7v/qpoah23MPuC35X55Zm6Hbj7XcmN17UpgLK8py+7cfeTMrbifWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ENPGEJQjHDmi0YXc71Juxw0DF5443i7C7rtlAkvii2U=;
	b=nlja44rJvV1JXM31zioZu6ZfI2Z8RYzW+4UvQ92JE+EOWJqL06cmtGbiyYdul3OGqksw
	 t1RvNlWPMwIxzDN9TiTpUNlpY5jRZ8q8j/0Au7MKy2jNZQMrTAM1KyhyX/PiAVM4W+5zv
	 9UOZpaV3hxxZQsVSRroBmxoD1rGb/xITMrh4gW9iK+G+9Wl7Lnblt4LWuA9+wO+iuFUr4
	 2gT4wdQIWYm58KBZuNJ4zhfdqr5J+ECciec0yN5wCsOoBE5+vS9GbII+JYrgrrrjIE2cE
	 7k54I2l4YNIwg6vpNXALV8Re+rvnyaxT4CbAwi7gjwoaWNUWGuADxcTjypZxQkpouvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=ydriti7z;
	arc=none smtp.remote-ip=209.85.208.99
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64502606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 23:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64502606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=ydriti7z
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso1736833a12.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 16:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1793403894; x=1794008694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENPGEJQjHDmi0YXc71Juxw0DF5443i7C7rtlAkvii2U=;
        b=ydriti7zC8uEtFrWzYDb1hmakiggIIPqyZubmQU3J5TGQfdMUBxqMCjS/7PGld049C
         PIJXQpd3EPFL36vZE6F2udfB1t05qSE+ovPBVmYlQrlHpSQ55Lsqa2MCmzqNPh/a80Ac
         BUiLE/kV6gr51kv4AuSQjItwP9IN+vcPj179bJjj0dKzPCU1B8GWZzM54JSsGvH/qm4l
         SodEgcZXYiC8TKZzUXknTkCF1YSVmFMZwymRrfo0CdcigMJnCjHY0Qdl20GhmviAsod1
         zr2WcqnCg9SM59uBUwjf/vujnxqU80D/Df9JZ3iYmi2S1rHJDtiKjxhgvKxkn7zkXpA7
         Fo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793403894; x=1794008694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENPGEJQjHDmi0YXc71Juxw0DF5443i7C7rtlAkvii2U=;
        b=1uq+b2qDCnrAT726Gg6vMw9horpj8aUX9yizuvqPu0ucQ5uEiI8A7+1JGvMSo0r5zy
         FsWlQdfyGERYaVID25S2hyMg40CDx22psSRc9sJrcZuMm/RvqdYnqILvDa3gNHi0io7Z
         8EZFMbsy/EdeReH+zNYH13FPzUSxydiyeJMxO1fCU1qFszBxY3lq/y1x6eudM/zsVkp4
         heZRsKA/1GCX9lYOxNaqAxf7p09iGNAPhFUelif073yClLINwOZEdAwLfoWKL6OdRWeH
         svningTrhu3LkWtC36M7o++BTXqvAyj5ZV3w5ruzWjqp+jMJ5xbRv4nWXXrdRhyS2dva
         8ezA==
X-Forwarded-Encrypted: i=1; AKwUvBzVFHFgTpAUPygWymnPJZlxg9q6hdebqkWkrOKJ8+gsQkCc38x6uRGpzHVwK6Fo/Nis8CIyu8E=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5C2jvRIJIEOI1DaNbyXKiTIpnHSKnRGeST85+sG6Dg9xK1M32
	WKUfIB7eBUhChqpaVFfhCKA2gbaaZnHsxxrk9WwSd1MeLUP4xaG5Xy9C5g4ykIpdsZTWA0HEZDU
	WaLTs+s3JAdgwu6Klbtkqa5jhRbrMS8r2LPTP
X-Gm-Gg: AYBFou3AzjvbeKET4+Ss0J1/hHXLLfvH+LmFdj0SYQwMBpHZz4RGs/4HXIV2t6YOncq
	QBIEyAWfy6cu/9MONjCFvyI5YOqF85uc6p+D4U3gSXTfXl0zeBLrLkw8l0BoyEjkhtrgIUMZPia
	6XPP0ZC5yytNv+VfvfOo+63/Ntdru/pZDMIL8/27tYSyegUY465Q0A5obM9m53Mh05NJ5+kIpId
	DcT4O1X3S7dfQfLkxpQFN3vbvntZRuHY4jSqpYOYnpvTLhVBrhvrHUVivHoQYyFly3N+bX9t6Lh
	Rw7sfjPBQTWMn3cIL3A0oH9BTqSJ7Q7UkgSx4+spHIluvjtE/ULWz+pLv2Quj9Rj8U6wmQ9DD2v
	mLn70i4mwvabfRaEC2lp6AP6jkOkWu5sgLgTJBt0=
X-Received: by 2002:aa7:c70b:0:b0:6aa:f14f:5571 with SMTP id 4fb4d7f45d1cf-6b4d5ee0692mr2076001a12.45.1793403893737;
        Fri, 30 Oct 2026 16:44:53 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 4fb4d7f45d1cf-6b4ec9f672esm196010a12.14.2026.10.30.16.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 16:44:53 -0700 (PDT)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 403993404F8;
	Fri, 30 Oct 2026 16:44:22 -0700 (PDT)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jon Curley <jcurley@everpuredata.com>,
	Eric Badger <ebadger@everpuredata.com>
Subject: [PATCH] NFSv4: Prevent indefinite waits for out-of-order OPEN stateids
Date: Fri, 30 Oct 2026 23:44:22 +0000
Message-ID: <20261030234422.2367263-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
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

When processing an out-of-order OPEN stateid on an NFSv4.1 or later
mount, nfs_set_open_stateid_locked() waits for stateid updates to be
processed in order. A five-second timeout is intended to prevent
indefinite waits when preceding updates never arrive.

However, each iteration calls schedule_timeout() with a fresh
five-second timeout. An update to the shared open state can wake the
caller without satisfying its ordering check. The remaining timeout
is then discarded, and the next iteration starts another full wait.

Under sustained concurrent OPEN/CLOSE activity on the same open state,
repeated wakeups can prevent the timeout from ever expiring. Some
tasks can remain stuck in update_open_stateid() while others continue
making progress.

Compute a single deadline on entry and pass only the remaining time
to schedule_timeout(). Once the deadline expires, take the existing
timeout path rather than starting another wait. This prevents
wakeups from extending the wait indefinitely.

Observed on Linux 6.8.0 and reproduced on 7.3.0 with 96 concurrent
O_RDWR|O_TRUNC open/close loops on one NFSv4.1/TCP file (nconnect=16).
Ten workers made no progress for over 300 seconds while others ran.
With the fix, all workers resumed after transient stalls.

Fixes: c9399f21c215 ("NFSv4: Fix OPEN / CLOSE race")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
 fs/nfs/nfs4proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1018b03c1cbd..f2cb8e788c017 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1722,6 +1722,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 {
 	DEFINE_WAIT(wait);
 	int status = 0;
+	unsigned long deadline = jiffies + 5 * HZ;
+	signed long remaining;
 	for (;;) {
 
 		if (nfs_stateid_is_sequential(state, stateid))
@@ -1756,7 +1758,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 
 		if (!fatal_signal_pending(current) &&
 		    !nfs_current_task_exiting()) {
-			if (schedule_timeout(5*HZ) == 0)
+			remaining = (long)(deadline - jiffies);
+			if (remaining <= 0 || schedule_timeout(remaining) == 0)
 				status = -EAGAIN;
 			else
 				status = 0;
-- 
2.53.0

