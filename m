Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAD2F7EF5
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472752; cv=none; b=D1bFH/lQiGg4KCSOe8bFASnbx+jV+SpPvKZK0tQElSVBDeFaSOYztlNI9FuskA/6zasw2B/3AKbn8t8u4qtrrlsWZp1fevYOZY1te23xrJzMtQmMJmWXXL9nDmXyDFMQOkM9oJnbG9Qi8bkPzFbShiaR76waqiu9sSUAzp5VFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472752; c=relaxed/simple;
	bh=/mUMqmTsmX2aUuRVI19DjRvT24Hk2w9WlfzFFKHoBjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsY7wgLtQLfPxYYXNxptDWfz+x6D9B/aVFDbZf0wucslPEG7vc9DG3CJMriAUp1bC1EWlt6O198Xnojn57xKZvDi8qwCJyqvVXPb84j65MjkX1c77JVLlzUG3sVvcE+zSfBisnkmeDmAnmXfDU7W9WHQ5g5kviQ7rg7VA+nwuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ggcircuit.com; spf=pass smtp.mailfrom=ggcircuit.com; dkim=pass (1024-bit key) header.d=ggcircuit.com header.i=@ggcircuit.com header.b=Sq/mGBBc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ggcircuit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ggcircuit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ggcircuit.com header.i=@ggcircuit.com header.b="Sq/mGBBc"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52f9fc510e1so6837151cf.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ggcircuit.com; s=google; t=1789472749; x=1790077549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkcb0RYR3iR2UL0lCLmkrfDemoqK24I77UVvd5NUglk=;
        b=Sq/mGBBckeYwBffsA4XXEg8hk69O7J6j1sU0eXalcXpQdWLbuTw7H/iR4510Ze84YR
         53Wnn0CgEUOretblCHT7gNOAAGi6NWfoeaDWft8jzZXh5FZ19i5vQZ4F+7U+nufk4Vef
         Uu0drl7zO5xCEFNM+oTNGWdY5/o3e+Lxpyau8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789472749; x=1790077549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkcb0RYR3iR2UL0lCLmkrfDemoqK24I77UVvd5NUglk=;
        b=WKjjokwOgL0mcIBcXu8SirA72oZMBll0BUNay3c88nGL77zbAntZDofFuyv64LJKP/
         vQBknWDa8Q2TUR1PZlAZrWjhf1wpMN5rchLon2WkFAbIRQkXysaZRIjunmAlV5wTOCsq
         eQytBF95nl2BVb5iy/j4TBlzHSGPrFB+v+nEJ/7JR/vrWewt/QknP7QbgpP69NLhRC3H
         CCEhuxfEUaaNVoHq9HxAGutHoIEwdN5qMTo3G52/Trw7ey8I5cDmVzHqWNva2QvI1cV0
         nLT+XV8pl62jME7LBvdOGkdvN/Kwoo7w3UJdwLgIzpysvQPutPQQNhK4Gckqv06mHZDX
         0sGg==
X-Gm-Message-State: AFuF++lAUzngZ2JQLhxJW8vVAWdDbSCBa0k58+b0xDzxkSvmR92o30Gy
	Z/IvZD6PZrQDcJWbZrKFHi8reno3TDBlv5xYHDjErZ9ubm6Ir2Mt0uqCvsOzrPcv/fGNbYevA26
	AtpOwlls=
X-Gm-Gg: AYBFou0Cwa/j6MaYzz19NKCMkh1Fge4g5GEjFYr6r2Om9EpFTnTB29dRYzs8jx7nAev
	Ic2HCx2JOiXEh2Jgo+oxsxIjKS21zp/xq5Z5fSrp74Ci3d/fni683GWGp+iRk5lEciShcqlblzf
	5EBG1djEXRwBfM/B5T+blI7mH01XEH0oANPjiU1IxWaLkWtjWDIAy9oYUsBWNzaiB4sJ8xhg9uH
	Ahnhs2mBpsZ263RLFQyKrnQEkZDIpi4HDaBdHzPN3ku53rcMpt2MntVxaSS4rph8Y/asIdSAm+9
	96F5iQD5h7wUt1ffpq3lRRwM8HZEvdINHSkCSX8pOLsEh9m8y2knFxOr6KX47VkHg9VBreuxTIx
	IGLQM6hLsplvgrKYYN5MT1rzN5WCU2RQLGBOzOnsSVyzRH8ZoXyBx+nuS6ClR/6q4EtWsn72WqD
	wCBaM/ZQJpxnQ38psYbuAuLX1bVLHLDsY8jsD7JprYQt4dkrd9w0BBscCifD7ZLQqVfjuq2YWR7
	NIofcoWA9CmoX02N4NL70GkrFgY4U1iiZ/aByPIktR1ayArS3+DRsyOde9KTXkQwkj8jTgj4UUs
	UN5i0dw=
X-Received: by 2002:a05:622a:1484:b0:530:fbd3:2038 with SMTP id d75a77b69052e-53119ee5d91mr46309071cf.26.1789472749450;
        Tue, 15 Sep 2026 04:45:49 -0700 (PDT)
Received: from 5eef7f0e50ac.ec2.internal (ec2-52-87-229-18.compute-1.amazonaws.com. [52.87.229.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b3dcesm118926926d6.31.2026.09.15.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:45:48 -0700 (PDT)
From: Dmitriy Polomoshnov <dmitriy.polomoshnov@ggcircuit.com>
To: stable@vger.kernel.org
Cc: mlombard@redhat.com,
	martin.petersen@oracle.com,
	loberman@redhat.com,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	jonatan.rueda@ggcircuit.com,
	jacob.pitcher@ggcircuit.com
Subject: Re: [PATCH 6.1.y] scsi: target: iscsi: Fix hang for aborted WRITE_PENDING commands
Date: Tue, 15 Sep 2026 11:45:21 +0000
Message-Id: <20260915114521.8-1-dmitriy.polomoshnov@ggcircuit.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260915091456.8-1-dmitriy.polomoshnov@ggcircuit.com>
References: <20260915091456.8-1-dmitriy.polomoshnov@ggcircuit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up to the 6.1.y patch I sent earlier today.

That mail said 6.12.94 did not hold the hang in 13 runs and that I had not
identified why. I have now, and it changes what is worth asking for.

6.12 recovers because of a second, independent completion added by

  ea87981a0ee8 ("scsi: target: iscsi: Handle abort for WRITE_PENDING cmds")

which landed in v6.4. It calls target_complete_cmd() from
iscsit_release_commands_from_conn(), on the connection teardown path, rather
than from the dataout path that d5869dae5080 fixes.

Presence in drivers/target/iscsi/iscsi_target.c, by count of
target_complete_cmd call sites:

  linux-5.10.y   0
  linux-6.1.y    0
  linux-6.6.y    1   (ea87981a0ee8)
  linux-6.12.y   1   (ea87981a0ee8)

So 5.10.y and 6.1.y have no path at all by which an aborted WRITE_PENDING
command can be completed from the iSCSI frontend. That is why they deadlock
permanently.

6.12 does not recover unconditionally either. It recovers only when the
connection tears down. Holding the connection open makes the hang persistent
on stock 6.12.94-1:

  initiator answers NOP-In    blocked for the full 299 s hold, hung_task at
                              242 s, cleared 1.2 to 3.2 s after socket close
  initiator silent to NOP-In  torn down at 46 s, which is NA_NOPIN_TIMEOUT 15
                              plus NA_NOPIN_RESPONSE_TIMEOUT 30

One variable between those two runs. The report on 6.12.94:

  INFO: task kworker/0:2:328 blocked for more than 120 seconds.
        Not tainted 6.12.94+deb13-amd64 #1 Debian 6.12.94-1
  Workqueue: events target_tmr_work [target_core_mod]
   wait_for_completion+0x8a/0x160
   target_put_cmd_and_wait+0x75/0xc0 [target_core_mod]
   core_tmr_lun_reset+0x57e/0x7b0 [target_core_mod]
   target_tmr_work+0xc3/0xf0 [target_core_mod]

An initiator that keeps its session up while stalled therefore holds a target
worker blocked indefinitely on current 6.12.y. In our case that is a Windows
initiator on a diskless boot server; iSCSI boot firmware that ignores NOP-In
pings hits the 46 s path instead.

So d5869dae5080 is still wanted on 6.6.y and 6.12.y. It completes the command
when the final DataOut arrives, with no dependency on the connection dying.

And ea87981a0ee8 is worth considering for 6.1.y and 5.10.y alongside it. It
carries no Fixes: tag and no Cc: stable either, which is why neither fix
reached those trees. A tree with both matches mainline; a tree with only
d5869dae5080 still lacks the teardown cleanup.

Reproducer is the sequence from the earlier mail: Login, WRITE_10 with
InitialR2T=Yes, ImmediateData=No, MaxOutstandingR2T=1, receive R2T, TMF
LOGICAL UNIT RESET, DataOut with F=1, then either close the connection or hold
it open and answer NOP-In.
