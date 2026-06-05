Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F115631E83E
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687682; cv=none; b=cnTakHZdHJ93oICwqA/QPwkuOEN48JYXgjZ+psiW/FuBJUf4UInqxx4bQC2VHv2t5BE3/mKtFYqZhiV/eTEIfxvk3BXYI9vIarG5bXCSzWrOKsAeLz2bSB+VCc2XuO6k278QIMuf2dLMI4t/71KJfPb8dUQbD0Dzxo5sNngxX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687682; c=relaxed/simple;
	bh=uavlxKpBnu1z2AfWP/ri3sDSw/Jkg4/IqIx1hbaKN8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK3O0xtmo/IVqaGbL9lAIMCCJST7JT2K8JqJ6qFZ9FLknzoDLfSbh7YFeEANwosA8kBYOsmk2B1RetY0gLJEEm4zxM6Crja7l44Pk6AMSl4ff2xs/6a7XHcMIr8KVlFz8qobWPP6xIiaZV8Ylfy5Kh8dQlUYxg/vTCvGOdH/myA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf5NneCp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf5NneCp"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2d792c8so16480375ad.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780687679; x=1781292479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7EmBr78VIKzfhL2jNZoZNthGw9dJn5fsn71xPmnvio=;
        b=Hf5NneCpVt3StriFFPsT7CWMwVDgKmFePHoSmx+M7RS3aaJ2YKoGwG5f2iQAhTMUCW
         JS9S97PM6krUFrv5RQ8YuoD63A6RosWe3MM4GQA53Tnm+keTNR2ZjNXh9lhM/sGCvnnV
         vonS1yGvuCCPt9TH8W1heymE1P8UXGoSx0hF2C8hzakzQ+dd+GVKjZlTgtqcyVLHPMwu
         qk/dNq0t9f173zaMhga3hTV4gbzd6OSDqTztJ9qZgMsLTaQOKwwEY8okle/6Sr6ZfFnb
         Cqk99n7B5A6OwiUT8lQkSuVZSlfiCfON26XkSvn8KijZI9s0RBUZHHY9I6jUStYkjpmL
         EvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687679; x=1781292479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7EmBr78VIKzfhL2jNZoZNthGw9dJn5fsn71xPmnvio=;
        b=EfJCh6aXjIHSY7W//DQ4lvAR80sd+Jx1dZ6ttMwTBQpyFldREOeJDc+kLuCLd4WB5k
         ezC1eb9ESXrXKg0HoMZp15ubew5i127ceEkOOPAH4edFj7svroCmqx088Zp+t2P6uD4c
         33xWeYMtknlEIA2oYzt2ucD6V7NociTpDj4SYi0pnLDNQqyyNnFhMVfZZ0Qz2W6gOZkj
         Io0JebkqKYSQOuKhhXnzQAKL1uUS8XuX4lx53YuUGlC7GLbsndetDJQjkdzVlTGZzdQT
         1klbS6tGf+D7o0FIDnjZ+dX3VaQh5OtZs9InttCeGx9DQNt6Z58DuhINpwJPvjIG6zd6
         1lMA==
X-Forwarded-Encrypted: i=1; AFNElJ/YB+TFDL13O/iRCIz4Mt10LiBoxY8XCdMwoeLqsL1Ez8zsntBSiCc4GbAvo1HUn3I7CaN8rDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZRLWYY2CqxC7nDwp2WzqIvieX0nFxJf43iJm2q4thbZHn7r4
	7o4/5DtfCM21cV5xYwWuOJZkO2gbrFDXN9jU6vnTQTYFZ+Z08IQBCqTN
X-Gm-Gg: Acq92OE6HVm27d6meHhzUQICpM8k/ARKyfQXPfkfjnsgIMUeu5CY/sf2eCb0VBYYG94
	sdlSegMkuItlwUYii4TyE+3dtaiSbK6RlhatmNOep/A9OxkItylVuK1WkBSmdd6BTbYt+YhmcDO
	JPiG+9uF5Zb0L/ZqJPbpiXEZeebBwVEDY33UZJcLoFCuL1kSwxhs+qFBpGl4jj+6jOB9V1ZedM2
	DFsp5n33PLNnk+D/bhu3NuAuLBCinGdmIaS9fpHXEin4brO2s3wXsI+ePlNnfDgYrJhJof9q8jW
	H85iKxtvPzQ6QTqo5CxGpP1QFY5IfV+M9/s5aYYV9DFcPJcADfaszz5u6i3gLLYJ0hnjWHFJoC9
	1+Ls8tuNw8Z2N8lNIN0+9lKG76otDTI4se8zZi0sCnrCaiSUamQMlhD39zdvuaUXB0aV/rLJuJ4
	2prZOFyoQaBowzg7QBsrCa8Y+qedEg
X-Received: by 2002:a17:902:fe0c:b0:2be:22cc:e227 with SMTP id d9443c01a7336-2c1e78e0291mr38710525ad.4.1780687679040;
        Fri, 05 Jun 2026 12:27:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e61csm102663425ad.43.2026.06.05.12.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:27:58 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	fuse-devel@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] fuse: end fuse_req on io-uring cancel task work
Date: Fri,  5 Jun 2026 12:27:08 -0700
Message-ID: <20260605192708.141921-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605192708.141921-1-joannelkoong@gmail.com>
References: <20260605192708.141921-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

When io_uring delivers task work with tw.cancel set (PF_EXITING,
PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
fuse_uring_send_in_task() takes the cancel branch, assigns
-ECANCELED, and falls through to fuse_uring_send(). That path only
flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
it never discharges the ring entry's owning reference to the
fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
dispatch time.

    fuse_uring_send_in_task()
      tw.cancel == true
        err = -ECANCELED
      fuse_uring_send(ent, cmd, err, issue_flags)
        ent->state = FRRS_USERSPACE
        list_move(&ent->list, &queue->ent_in_userspace)
        ent->cmd = NULL
        io_uring_cmd_done(-ECANCELED)
        /* ent->fuse_req still set, req still hashed */

The fuse_req stays linked on fpq->processing[hash] and
fuse_request_end() is never invoked. The originating syscall
thread blocks in D-state in request_wait_answer() until
fuse_abort_conn() runs, which can be the entire connection
lifetime. For FR_BACKGROUND requests fc->num_background is never
decremented either, so repeated cancels inflate the counter until
max_background is hit and all later background ops stall.

The non-cancel error branch already handles this correctly: when
fuse_uring_prepare_send() fails it calls fuse_uring_req_end()
before fuse_uring_send(). The cancel branch must do the same.

Fix by calling fuse_uring_req_end(ent, req, err) in the cancel
branch before falling through to fuse_uring_send().

Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring")
Cc: stable@vger.kernel.org
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/fuse/dev_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7cd50990b097..b5cc700575ca 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1222,6 +1222,7 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 		}
 	} else {
 		err = -ECANCELED;
+		fuse_uring_req_end(ent, ent->fuse_req, err);
 	}
 
 	fuse_uring_send(ent, cmd, err, issue_flags);
-- 
2.52.0

