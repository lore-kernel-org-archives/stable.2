Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16566358D37
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679048; cv=none; b=O1n2mliMNJfGyB7HlFAnVx1bSkoFt7Y0kb0vUKKvNFk4e5C9UTAJJ1WOi+0OC/bSWMEiS/W8izcI+YDz1obAnzkn7nvCbcYbNs6TCZnaDZqQ2sIQWTSDvM7AJOQmllURzCa+BPJjGhlkDrpVvhv/EoEMuCgYA0oqUYCW0K3D3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679048; c=relaxed/simple;
	bh=YtZE1xyk23OmFsw35vKQUZbSJ+FESk2hBRqIFSzm6Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKFvvnZlM4H+Zg8CGD2ugAwOLZwYxD+zUE4KE7D2/COWRZEuSupsf0IGanhJsp0A7TvzmuD6c5f8fXISdkR9vo3A8IhjvpbM2bcXCD7zU4V4vXzaSXJE1TCFUuplmhKWSG9yxRmceMn0k1jSLuwXA48lIkbz2pXwrusw3x5zNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArWgcvT9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArWgcvT9"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3967726bc47so20965671fa.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780679045; x=1781283845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Ork6uYNXL+eeO+phzb3xUI2OLrfdgYyvNm4Wy1uWc=;
        b=ArWgcvT9KiY9SmhPeAmoxZZwK0uT2Qjkp3pcAoy6Rr5EVe1YDlkH+zVsukaxJhyvZJ
         TZaukM+Z0ZmIT+mCl67mCVbMQLTmDwh+9kdZq8eqF3Afh6Eedd4tfk3/mHfF6RovH1p2
         0gLJqz/mYtl9tL73XJFDNSOycwUO/vYq2arcFk4Z6HTabZpaMU+dP6pz0wTB+yJllTqB
         ysFsRGNtuSIgLvi40pcksrGurAUNRgNyb62/2koQVCl9lVAdYjf16TcuiRRyd8cKUkKe
         qdtemW6qcISbDAtsfvSPgN0xcSY5tPWOL/47fn+k664aNqJ/Hgsyb0N/iMMPGo9lMntq
         zeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679045; x=1781283845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9Ork6uYNXL+eeO+phzb3xUI2OLrfdgYyvNm4Wy1uWc=;
        b=ZQRG63877tnSDtVQR0wyA1b1mwv+SGw3Ss8zxs5Ilp58k+Y0I5biL3HtguRfMimXxb
         JqwRglu/p5i9lv6Wx9QEb2va+XAw7Vs4oh2mj/Z82Pv5PYDOVOch0lsLBE9WNE+OEik8
         pUe4osYkKkK6wHRC2dcf0kXFTwnIDUj9r2qhT7q2MeUQkrLQTGsGxqS4YdnXe86uhrkq
         K0Q8bwdgHQjHGycc8pWJYLk0pMl8ae5yYqFziRtPvfeF8hqL98Q9uLc6rpgNx56QoA3U
         dS6MKZ6fPMaTOaM01wSKsjs3UGBXPhwcwR//ortFfnFzaubs0icv3MHyFGY+9PW78u93
         RWuQ==
X-Gm-Message-State: AOJu0Yx49QC5nGxX3/XfvmzKJoWSdxt+L9kUUav6jo4kuAOcc8lXX0wk
	VAgavSreTkboBWvTFlmtGbI7jRK8VqeDYCyCFAZwcbigTEBzVAqMS86sR2StMamXNEE=
X-Gm-Gg: Acq92OFLa8LpAsehzk+0euarhfJ2MtHWn2Xc1jS2FXlKBXDXaSWHjHHmjs7jYHtMyR+
	Z1Xis5pnv/pZOlNCvgvzt52wYJNoeYfGahRiNUBIbpYbETy6OS+QNfsrkqjiCdczDE3apirg68N
	mvI0FR1Di/BURHDK/Dp6UzNllFlTWJIeXhuPacQmI0VWSZxMIoRyHIhUkID5txaX3zOmlK7nz/1
	Bp6kJJuopJzxul/3mew1owVcoqGtc846a/BdWrlkZKpR9PQsO/ls0K1Y3IDOpskAPSCk97Co5zT
	qhxvOkS9Rp5F3ba2lsvD2mQ7GWa+SoBzm2Da9BW5hk+xD51ZgTbDvOO2XPJk7snPfFYRtH7oJIK
	4GVsm5PCBO7w8zkwvsjOoe8c9fktGfnTIm3Ix4oNiO2DiRi3PUEuAMJlv9NIhv1ewiw4dUTWEmd
	ZC+Bc97oS58DseVsTife87wdVYPcgI6j5SIgEE+rGFksrTllvrJNz+X0SE8fcGQPdILcxA
X-Received: by 2002:a05:6512:1056:b0:5a8:8eda:bed5 with SMTP id 2adb3069b0e04-5aa87bc934dmr1434238e87.32.1780679045157;
        Fri, 05 Jun 2026 10:04:05 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac07b66asm26931161fa.11.2026.06.05.10.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:04:04 -0700 (PDT)
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
Subject: [PATCH 6.1 0/3] RDMA/rxe: correct cleanup-task backport and timer cleanup
Date: Fri,  5 Jun 2026 20:03:26 +0300
Message-ID: <20260605170349.1524-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux-6.1.y tree contains commit 3236221bb8e4 ("RDMA/rxe: Fix the
error "trying to register non-static key in rxe_cleanup_task""), which is
an incomplete backport of upstream commit b2b1ddc45745 ("RDMA/rxe: Fix
the error "trying to register non-static key in rxe_cleanup_task"").

The stable backport added guards for req.task and comp.task, but missed
the resp.task guard and also left rxe_cleanup_task(&qp->resp.task) above
the RC timer cleanup.  The upstream fix checks all three tasks and keeps
resp.task cleanup after the timer cleanup.

This series first reverts the incomplete stable backport, then applies the
correct backport, and finally backports commit 1c7eec4d5f3b ("RDMA/rxe:
Fix "trying to register non-static key in rxe_qp_do_cleanup" bug") to
avoid deleting uninitialized RC timers during QP cleanup.  The last patch
keeps del_timer_sync(), because linux-6.1.y has not renamed it to
timer_delete_sync() yet.

Vladislav Nikolaev (1):
  Revert "RDMA/rxe: Fix the error "trying to register non-static key in
    rxe_cleanup_task""

Zhu Yanjun (2):
  RDMA/rxe: Fix the error "trying to register non-static key in
    rxe_cleanup_task"
  RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup"
    bug

 drivers/infiniband/sw/rxe/rxe_qp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.43.0
