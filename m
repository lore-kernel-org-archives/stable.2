Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6553C73CC
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228792; cv=none; b=l++W8imBNlIXNe8wdOa3qJvpOqFzpR5utvw3BDfby5J8r62fDBQvy4AOa0YiQ46nsvsPxgMkUIV9cHIdoqiZXoT0p6zu4YSDP3U6mA+SeJedCv3sB/S3N5C/9v0quC0EJdOGm55u510oZYAe5QV8k88NY0DECq655i4UaUBFtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228792; c=relaxed/simple;
	bh=SExQjCrur+v+PyLSkU1yDERtFPFGGtrMK7eWhrWe9ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StQHjZeazoQC7AzmmLrgw8UWhatblKcZ8PK6Wo4GPMmZWmIkVI+dK6KMQ6VBEJ526yBxXsjYHVkcbAt5UVEN6UZXfaZTvz7SZsI+RrdvQntn5LoABKRmvaFtJ49Z5zerWJM1416UAgCy5An+NpugtnnzNEkLr8l4UkDJ0AHTJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVgh3hlD; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVgh3hlD"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea50db3so793168a12.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790228788; x=1790833588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bayjai1+noq80zp+hzIM4o4hv3AifX1+PlCe73MmQMU=;
        b=BVgh3hlD+XgNggNNswToLOGHnkN5WpX/W7QMHVSPNY9n9DNpcXi8NC+S/gjGBhPfmf
         pd++7JtUwi1za4bwlW3TibNAoJzXkcQ8+buyhjwJCXTOiQD+zL/IuIWXjN5bi6KeYzTW
         xKFXiGnwoCZRok8HsSC22oIAVWOYcI4PWRWcYupgononQiYO+3lUPCDS/edWA/DVSEoK
         Uzulu9l0Z37WH9CBPUz0csJoKQY/iJH1+ROqqDJEmWqYnlWV46MmhPgaBYAOBVM1Pv/q
         O/rB4y2RQf+nDleG8m7NKTrgzIy7/P7db6bnO2brSbIjii7sUVgn1jmKjCJpvH/JKUMb
         vg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228788; x=1790833588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bayjai1+noq80zp+hzIM4o4hv3AifX1+PlCe73MmQMU=;
        b=MU4mAVzKAWnqCcIKCmW7yqE3jLQNkVEVpwbkhdkUOI2HDMWDcxve88sGRnaPtYY9IU
         vYe/J2P77/ffCWLfq9Pk0YFlO/FMlJlrn2VxV2/w7USzY/l1Bk8JnS23h2jY3pESeuNt
         FFcmZUpM0/LhoFY+VdWkyFmSKlygefYQyVZHAOkcEbO0VwIVLWjC2cyoEueyNc4GVwTY
         sxXEwrMfdvuZ6rGjFZ++znpWWW3cDSHN6MVTmXmAmUIQOVEWPjP2JDnNfLlrnRXhhDHR
         aE95UXA0c9eslZl3Pu0nsGxN/+aNaSSa+o5LcQjJJ6w4EMFq64aH7odNRerh5w6J83w2
         B6AA==
X-Forwarded-Encrypted: i=1; AKwUvBxxyvRzfYERtQv2bwu6/nh8LVDBlX7AKvUNHgd/ZxGlbOEKVPK0n8UXmJ0Cc5p7aFqUdXVgL0U=@vger.kernel.org
X-Gm-Message-State: AFuF++kzcsQlDTSm+7fJ5VwIvIl62ZMjamhL+Ih35PzCLeOCqTaMmmcV
	0oRBXEGj+gJ5YRrdqpcymm4guImswyVjPb0HOvXgpLxjPdNYgnyI++6K
X-Gm-Gg: AYBFou3fEmiC8jHl78NJ+gnJytWKieIJCPN5SGhwEyYsgbqvNVFdcgFzrieW7k/ohjj
	AJfIQPV4FT7pQ/kw4u9KvGKlHwlYmkhyd5RQqpgD36VIpdLlgAjEQGAhjEWCKFR2TUKkOOzXqe3
	5aqAOIbg8esScAyumvGPf4xBil8LAYaRgV32KHahbfOMOQ3zBmhazSWU6pm9wP/x0ml1d+hLyr4
	278zSRmWKQ0ktQncZb2/hFNAhigOK/pMU4/mMpqTB/BR4vSqqpg58Ds2bSDXgICqVyBYAzTpjAk
	HQQVoXRGFsknipNnajFAEyjhMCL+jYAWH7JAnS9VNUnSLg3Urbut/Ee9FnmylmLDKpNHPlt8I4N
	6Y+AxWQPxoqHf+l0Wn34kNL4KJwznub8AJcDE+maPVqTkRajAlhSiLU6oSqPNPcTP7QNMGHThaO
	s+Ok2lnAsq824YJbnauzxC8SjBDwstpGa8BfqV7ZK4v1AOe+GPWUn5Y4j5bc8qSsf9ly+AfSwPH
	YzF/AkM0bOl1gu7Kr0QIn1k8j+n3kzv+lKQsBNC8EBclJQa0CZPmz02azrhGAUZbdqc/q7g4Du6
	+Lwvb2Jjrg==
X-Received: by 2002:a17:90a:157:b0:3a0:9c9d:eb1d with SMTP id 98e67ed59e1d1-3a09c9df122mr467186a91.20.1790228787662;
        Wed, 23 Sep 2026 22:46:27 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm2786661a91.7.2026.09.23.22.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:46:27 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org
Cc: john.garry@linux.dev,
	dgilbert@interlog.com,
	jejb@linux.ibm.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] scsi: sg: finish request on error in sg_read()
Date: Thu, 24 Sep 2026 05:46:25 +0000
Message-ID: <20260924054625.2282544-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <69218179-d750-4880-8be0-2ccab7d76a6d@linux.dev>
References: <69218179-d750-4880-8be0-2ccab7d76a6d@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sg_read(), for the legacy sg_header interface, a completed request
(srp) is dequeued from the ready list via sg_get_rq_mark(). However, if
kzalloc() fails, or if copy_to_user() or sg_read_oxfer() fails with
-EFAULT, sg_read() returns immediately without calling
sg_finish_rem_req(srp) and sg_remove_request(sfp, srp).

Because sg_get_rq_mark() clears the request from the ready list, this
completed request is left orphaned on sfp->rq_list in an active state,
leaking its kernel buffers and pages until the file descriptor is
closed. Fix this by jumping to finish_req and calling
sg_finish_rem_req() and sg_remove_request() before returning on error.

This was tested in QEMU (7.3.0-rc3) using scsi_debug (/dev/sg0):
1. Queued a legacy struct sg_header INQUIRY command via write().
2. Waited for completion via poll().
3. Invoked read() with an unmapped userspace buffer (NULL, count = 64),
   returning -EFAULT.
4. Queried the request state via the SG_GET_REQUEST_TABLE ioctl.
Before this fix, req_tbl[0].req_state remained 2 (active/orphaned on
sfp->rq_list) after the failed read(); with this fix, req_tbl[0].req_state
is 0 (properly finished and removed).

The C reproducer (PoC) can be provided upon request.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: John Garry <john.garry@linux.dev>
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Rename error cleanup label from `free_old_hdr:` to `finish_req:`
  since it now finishes and removes `srp` in addition to freeing `old_hdr`
  (John Garry).
- Also handle `kzalloc(SZ_SG_HEADER, GFP_KERNEL)` failure by setting
  `retval = -ENOMEM` and jumping to `finish_req`, as `srp` has already
  been dequeued by `sg_get_rq_mark()` at that point.
- Moved testing explanation into the commit message body.
- Added note that C reproducer (PoC) can be provided upon request.

 drivers/scsi/sg.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 5408f002e6c0..5d635349e06e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -480,8 +480,10 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 
 	hp = &srp->header;
 	old_hdr = kzalloc(SZ_SG_HEADER, GFP_KERNEL);
-	if (!old_hdr)
-		return -ENOMEM;
+	if (!old_hdr) {
+		retval = -ENOMEM;
+		goto finish_req;
+	}
 
 	old_hdr->reply_len = (int) hp->timeout;
 	old_hdr->pack_len = old_hdr->reply_len; /* old, strange behaviour */
@@ -543,10 +545,10 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 		}
 	} else
 		count = (old_hdr->result == 0) ? 0 : -EIO;
-	sg_finish_rem_req(srp);
-	sg_remove_request(sfp, srp);
 	retval = count;
-free_old_hdr:
+finish_req:
+	sg_finish_rem_req(srp);
+	sg_remove_request(sfp, srp);
 	kfree(old_hdr);
 	return retval;
 }
-- 
2.53.0.797.g7842e34a66-goog
