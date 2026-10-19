Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560503F6C2A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414546; cv=none; b=hNbLNKETTiYN9PPvPr1oGXwChs46kjhrb23oUBM0+gMAaixDWAHxOueKi/8IXRHfTv/PC3r7QkZsgYVBJ7u5rcFXPQdyuh2al0yEzz8y/p7MrxfnnKYHYrnUjY8W/otTZsy1FrjYuI44k1FQhZiek+EdBupqZ/agzHHNAPfOCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414546; c=relaxed/simple;
	bh=V+hQCe8wq71h7sYDfEQ0xdrVW9SKws0wJ1GVDHpJzKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCL+hzqTBs0xjDb3dP3dFtnqYV8BsUFMwsKc6ZYYCAImXRdzQcz8KSMPJJvMCr2Aoovwy6/6ztwSGRnyap/LWn0lo/6YTVp9YS4udIxwnaKfnQlhZc5IghiC4EiGlTZzbNi6JK25Ct3LkRn5SYcoj7KLcsIBqB3jt8DBiGu85Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POZyB+Ee; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POZyB+Ee"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15354aa70e8so1089842c88.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 05:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792414544; x=1793019344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhYB8OWrSiu0aZgB/NBRTuM36QWQSaDbi30LsYAq7Sk=;
        b=POZyB+EeCDc8fEZROzQFHqzWCbN4Mlnaa52WaNbVOuDcijDPsPDVClZpAFjNBIz/+p
         Ok4vwkc1liHheXbUIImFeU+86hSOYsyRniQg1yKlNPqms/D/5Zl42KCIIqUx4irxneRn
         XXhoh6b+G2ljcMxL3N6r5WtiyCgIwiFOfNhuaAv3gXLGF7k4QQtqOtrSQ8V4VcHNkLWU
         5PGxceFwTPNhf6KQoM8vAHBEhvYT0K+97a597tqlyN7jEk7UQuaADwIE7zPsxz5/SrKQ
         98RhgiXLWkQjbZOPNlCobITIaVXvEfofHR6eWegyOwDGIa6nrqLMraqZBEfXjZ+QwxS/
         AkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414544; x=1793019344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhYB8OWrSiu0aZgB/NBRTuM36QWQSaDbi30LsYAq7Sk=;
        b=UfeWYb8FcUChyhjxoRe7KYTQoYHD3zIoH3b/qt4QPjbTFxPRdFpZVuO8zU6wer4uAt
         JGq1RBNqo9zt3KUvDkr5tl214ud2oZpuvwgr+0rOA3iV7hddElkGyqegfqBv4uA5xFp6
         cUn1A/W2qyCgEFUH6d5y/2gGVwL2+OfYd7LuZZDVKfhU5XUKqF1tfxm8fGcRKfUe1zzR
         k9FMFhWvZ2ifWWSMF2JRcVhSVGlMr2GLXmwL0ghPSZUq/kNn5vgY4yI+ZspmzzXMwu18
         QCPRltVywxrakqkGDu+LUIujHxPev69k4v7doz8D+1dAPvt7+hnCdhn9qqBFPpVKFSpX
         rSZA==
X-Forwarded-Encrypted: i=1; AKwUvByFxJGkzBaxNwGHr5PSH1mqWZm6uVLJFSGiGThhcVdNZAvtqgLx/YmYBsnjMkmhGIOFd2X/R6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUy5jGkj2FGOTm4xX2u09Lz2bm8O7aOn0uggI9i611zu3El7nq
	e4oszR2QsgYt8yqZtgiwS3yhu+J5u0wv91hNphJNQmqapbd/+bs6LfVQ
X-Gm-Gg: AYBFou3wtxoon6tVFRxVA14ATSS/Zzuzat+7r/FLaj3Wr2kaFXGvePx2z+BCRO2+OqP
	B5N4Btm/cbh31PA3DDA8yl2o9eCfAcMSHyUuD346M0RA0UIFJ2FtvCm0PKiVEj121SqLNFZgdAv
	XhFmV4rJUDfcTT/nr9HFYYudNkd6Zu+7nguug9GvRpDT6DXFMlWAQUwB7T6HEWgoZICS+MwPEhO
	rrGaw4ZcjDjhwAwb1OJHqSqGAU6aobbYSYz2lyFPeCfqF7RXxCfv6ahF8ldNiB1sHIiYn3B5LK5
	3GheujetqkflTkAA2zJ88vD+WjYypEm+pTBWcD1WzZE/4zxRGZ5DFCcOwPhHqj38eFTI9uH5QVt
	UwCDsDZZ6ljViVEzCvO9prVCeDwXS/aZsOeBp5KJCm5ffx73Nw8WLu2mqj6X4kb2tAoEv2I+wr7
	calt18fnxfGbAncgx8g3PyGyk028E1eqV0Cu/+tlqEJ/qb5dXSQRck5Bu9IkFdkqYb8ALv2g==
X-Received: by 2002:a05:701b:458e:10b0:151:5d01:9316 with SMTP id a92af1059eb24-18512f1d08bmr11058121c88.23.1792414544393;
        Mon, 19 Oct 2026 05:55:44 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:67])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm27988120c88.5.2026.10.19.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:55:43 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a2e50fb40695811c2dab@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v3] greybus: operation: close the race between completion and arming the timer
Date: Mon, 19 Oct 2026 19:55:38 +0700
Message-ID: <20261019125538.20451-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gb_operation_request_send() sends the request message and only then arms
the operation timer. The host driver can complete the operation before
add_timer() runs, e.g. when the transfer fails right away. The completion
work then calls timer_delete_sync() on a timer that is not armed yet,
the synchronous caller returns and drops the last reference, and the
operation is freed while the timer is pending:

  ODEBUG: free active (active state 0) object type: timer_list
          hint: gb_operation_timeout+0x0/0xc0
  WARNING: lib/debugobjects.c:629 at debug_print_object+0x198/0x2b0
   kmem_cache_free+0xfd/0x6d0
   gb_operation_sync_timeout+0x1c7/0x270
   gb_svc_process_deferred_request+0x5f3/0x1150

Keep sending the request first, so a request that is cancelled or times
out is always one that has been submitted. Instead, hold an extra
reference until the timer is armed, and delete the timer again if the
operation has completed by then, since the completion work could not
have seen it.

Fixes: dbec27298b0d ("staging: greybus: operation: add generic timeout support")
Cc: stable@vger.kernel.org
Reported-by: syzbot+a2e50fb40695811c2dab@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a2e50fb40695811c2dab
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Changes in v3 (after Johan's review):
- Do not reorder send and add_timer, so a cancelled or timed-out request
  has always been submitted. Hold an extra reference until the timer is
  armed and delete the timer if the operation already completed.
- Retested with the syzbot C reproducer in QEMU (DEBUG_OBJECTS_TIMERS):
  5 ODEBUG warnings per run before, none in 3/3 runs after.
- v1/v2 armed the timer before sending the message and are dropped.

 drivers/greybus/operation.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 7e12ffb2dd60..f3a65e693133 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -766,18 +766,28 @@ int gb_operation_request_send(struct gb_operation *operation,
 	if (ret)
 		goto err_put;
 
+	/* The completion can drop the other references before the timer is armed. */
+	gb_operation_get(operation);
+
 	ret = gb_message_send(operation->request, gfp);
 	if (ret)
-		goto err_put_active;
+		goto err_put_send;
 
 	if (timeout) {
 		operation->timer.expires = jiffies + msecs_to_jiffies(timeout);
 		add_timer(&operation->timer);
+
+		/* A completion that already ran did not see the timer. */
+		smp_mb();
+		if (READ_ONCE(operation->errno) != -EINPROGRESS)
+			timer_delete_sync(&operation->timer);
 	}
+	gb_operation_put(operation);
 
 	return 0;
 
-err_put_active:
+err_put_send:
+	gb_operation_put(operation);
 	gb_operation_put_active(operation);
 err_put:
 	gb_operation_put(operation);
-- 
2.43.0

