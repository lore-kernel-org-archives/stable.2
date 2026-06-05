Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2308F3909B5
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679699; cv=none; b=uaweH9euYVdzIDVIRqmS7OOEK6MN4SwdFmg2bGx0CkdJS1M+JDin9utECOWOUePhonXvUMCDDi20FSUXGCSGy6d3vdtblB0TLCmaklBchCnFjlXkrfVEIEhdmHH39NHkYt4hRTzCi9uErtV0PxahTDf3DtS8ScQ6pg2YQqOXIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679699; c=relaxed/simple;
	bh=NZBogo6csdHRo0ECRnQXqFzw+Ujg4cMJ7QOPVWvpRAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bm5FPxXuS0sFtVbYTdivNNvhAgVqPy79C9vR1BKWsy1b270Hb4jdO0x4hbqFK/090lglmL50fOY8hvJT3Bv5HWwO59LbO1b6JCWB2dFigXDjthbZ1xFDpXkWT84qU79dQx6V/jgx5LVPIW2D/SXyduqWAYz4csDUM1L7LNtGuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO4pY9Re; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO4pY9Re"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa5e9a64b4so2425949e87.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780679694; x=1781284494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJIc+ZW4x5FMrpduKc7fLE6NQN1WP6A0QKK3016XahQ=;
        b=dO4pY9ReDpAvPUB6D16MBwtQ0gXcL7va/KkobYmJsZdBzmbRHkg2UieMIwCGW/PLit
         6J9WC6L090tGM3aPUlALnvMZ/1KntOofEDg+dnFOKn/4cjtwYJoOh7ijKeJfIkIEGkGf
         VSMp7jqgFJfEe5apS7lFFXe9KCqJMV5gKUPnseDJWfQWtz3gbDrWEyokbtEoZp7KCzLT
         UzvYZbtjmz9hokzkKeyVt3Pxhj6J0Jw+Umr5ZjVcfWk0kMJ6bVKKmLFhPIMidBt8KUnz
         vyf6CTtJ1fTryPmMA09lWaJD/kQolT50Hl71xZkClobPDkn6nGsmXJDahxnLOWE1EBuD
         flzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679694; x=1781284494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJIc+ZW4x5FMrpduKc7fLE6NQN1WP6A0QKK3016XahQ=;
        b=nlTEvmdteYUtG2fhnOKn+osqAZ5aF2Nm+Ps5ficxBULQGh49y7xy1MjobUE/5Q45VX
         MpnW7MBnca7WFvifr/GvZGOAIAk63A1fPRZT3qOxncRk2riLzZ0QpCW9ccW4Tcg0twxb
         E/OsjtAPMjoW+xt7Qc3cuhkmb09jeXiRvCpaTQXaSBRLbC7U/ok4Ma9Lj+ELXyTYz4KJ
         AkeG+xqhsWBXGx79qTvC6o6tJqX5DdAIsQG7CORCZnQQC6NeEVpJrfKnhtqQ2wS/I2yk
         hm8ivVptHX3pSTvIpltA2vKrLFhqQ0V/qMGxudMA3Usm84lwt9wuyi4PWR6njdDBcozB
         BDOg==
X-Gm-Message-State: AOJu0YyWqc7OIxoqTNZcn7RwRa3w3I+kHwNdxl/BLxxR9qpDxPSElaPt
	eqS7aY+qpt3KmgjUAZTPxSYGA85WLNBnBCVjv1e+U1oRZgqde/69RaXWD60SOqxtOhQ=
X-Gm-Gg: Acq92OGtezJRWgVndw2q58YC0ynGVSr4MiRenaXfI88kbDALo72d9Wo1CdmPY5d2pJI
	ikijHQ0nFh9urVwazVTkBvP+FXBZxfcYAw09nKrLgOAFJHjuLFCx8dQ70e1YzfBgjBd1bBty7ag
	0CZVtL/9O9NfQLHu5XIdx2PaUtCZIdNaudFl7S2ADUddaYg4SdfbM4X+/FBNbVAp4MXllLlLNlv
	8I1HdgSSga4HPE172r2Hr9r+zk2cpDIwZPY0W1+g1trsgDLEdXfzWiSnwHzLcPMieu38t0wYylE
	mkQ72mF8I7kdSDYihG2UaN1KlGTVWl9Xpd/BQi28upSBONuHG5rxvPbECiLFrTNMq67SBmBcI3/
	1URmN0qNyCFpvCKTqDMlyv7N+PiJBn1KW6reNk50Afd20XLqCePiOJ/dXduT3juwfWpr1EzQfa5
	LXamPmxfJdO1ETT/FkjtZEs1SHDFY5o6ER2tQxuj1zWFZ6fJr7VClwUXEFBsCLBlZdiqXv
X-Received: by 2002:a05:6512:239f:b0:5aa:6c05:f0a with SMTP id 2adb3069b0e04-5aa87c03936mr1280571e87.35.1780679693999;
        Fri, 05 Jun 2026 10:14:53 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b991b4bsm1991133e87.73.2026.06.05.10.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:14:53 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH v3 5.10/5.15 0/2] Backport RDMA/rxe task and timer cleanup fixes
Date: Fri,  5 Jun 2026 20:14:41 +0300
Message-ID: <20260605171449.1760-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series backports two upstream RDMA/rxe fixes to linux-5.10.y and
linux-5.15.y.

The first patch fixes cleanup of RXE tasks that may not have been
initialized on the rxe_create_qp() error path. The second patch fixes
the same class of lockdep issue for RC timers by checking that both
timers were initialized before deleting them.

In linux-5.10.y and linux-5.15.y the relevant task and timer cleanup
still lives in rxe_qp_destroy(), so the 1c7eec4d5f3b backport applies
the timer guard there and keeps del_timer_sync().

Zhu Yanjun (2):
  RDMA/rxe: Fix the error "trying to register non-static key in
    rxe_cleanup_task"
  RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup"
    bug

 drivers/infiniband/sw/rxe/rxe_qp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.39.5
