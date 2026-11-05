Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862922;
	b=3yYnKY3JAchQp3DxjhkdMucPA9iHAx6412JL3y0ayGRn+33g9zaUyy6jHZ9629q0fQ6c
	 Ec9uGZMP3E+G6CjzLy7s/8SMw7e3nSaiO2aDHTvdKYmExudiYQbkOE+/W4F9MA6nAVypS
	 VeYriE/CK1q5mMXvLbjrVoSjY5Qm/4LMOe3A0y3h4dMH3tNrhTiE5Me6kj1bkwRketbf0
	 L9wNYHds2jyjlkdNrDu1LeQohCalOzOQCOfSwuQC6YP3SXIr9sz88f16e1IT6Nps6xTQF
	 dSadr1deqAJ64BKx30u227b8gOV42fH7Pj3mQTSpSHZRcLhVHkav5TDWObDGSvfeYKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=SW9ZPipNuscFWkNo5bCucZS2yHxtHk2aYOPHX7h5/6s=;
	b=k1x1xWyc1rLN4jYsWKSckSeEPcjWRF8utBmDcuzzZYdPXuE7Ft2oxW14uFfHsFMqIirs
	 HrusUL4W6NsFdJX4q6s284+degboOeHwA6O6g0I52WfzRJKa+xfNBiZ7shRP5w+V5STXp
	 5Q9cv1Ileu5De0OqNu4co6GvAaqfGxcIk6CkdwjqO/n77Tg4+xG2EB89oErWUDOvQDJA6
	 jJLSMfc8fuebLy9le4xtRU8M4KGjcjtcbENxv8QOVnvM55Wyl/Hi1RropJZYTwJ501400
	 ZZVeSlI2kpy4tsBhchDEsBCN338CIVm0kXfj7RErESj2nMa+aUCUx1lNdYoBh7dqevQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gR3EVBc5;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B454606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B454606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gR3EVBc5
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a1e2485fdso3046160eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 23:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793862921; x=1794467721; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SW9ZPipNuscFWkNo5bCucZS2yHxtHk2aYOPHX7h5/6s=;
        b=gR3EVBc5cwBFGiZJEZhn3p+sOuzdvOSrBVvARK2Q7ODF9k4n8HTazz+zu3CQgwr2Nq
         eeMf+dAHqvSP0dr4/5ZPNxMJUYR9z1nIZLBwjIJuAnhyf88TF8VJg/7Ky8kkqqPIxuIE
         vkmHjbdPpPEX1pEayx/o8z+UOiZzqsyTmSjwPfiDYVvO3TAbhgqc9LgqofOVWHi5zbiS
         7JrKr4MAd7U2sFAYUfUQ3bpzAGgx3+cil8Bx1q71UFnfeuy7po/D6xamRP4yFPCZCoNm
         sEdjdaCpY7+Jw0g2rqw0pDiUS13ZIUh9sZgYu+o0UZJiye0FjEHXXTeGR0Yec4rA70dS
         LzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862921; x=1794467721;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SW9ZPipNuscFWkNo5bCucZS2yHxtHk2aYOPHX7h5/6s=;
        b=FUTT1BkpG8mnr2OvvSV4rLjSqa7hlenMilgYwywYJ6oloZq0dE3A+4cH+JTxNNPZI+
         crqajG3bLkiza7AXVgl0A96M4Qwv5gc2oWJYLgSo5ck277EN7EpqaUSifXRlWrFbhufZ
         8GQ9seDx3CyCoLj3rsn0fodXpd0CWlxAXixhqV1ekYt26cXyuLhWVMKAlnsHggWxhIH3
         4xLaY05stdK6oPakLAfpHL6yjDgO3nBd3h9gBXDynZNb75UPplXZODH+1ly9si7c1fRC
         oxgaNAFBWlQBcx6650ze+LLg4sFA/O42C/8ArUdf9Y7Iu+QR6s4iyGq3Q+ItWGRkHCPz
         UW0A==
X-Forwarded-Encrypted: i=1; AKwUvByLmUTuWXRh6MtAWkM0XqV3pFtubjRf8WdSyNdSBjcZgVtLAIl9AQESPFksli/RfXc2U3PN3pg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qBv0qxL4nnAdJ5Lk50JGkGXbYvinmLkfRzYfrmovP6PGtkfq0
	91Qljh20ILVZFTEAlzUDdOrQ9FszPf5RefPTwbQR+CkT4mRh3ljBE+42MpSzVKc9HOyGomcRAHi
	TZVEmLqTCFxwaoxm3oZv9Cg==
X-Received: from dldyr6-n2.prod.google.com ([2002:a05:701b:4506:20b0:1b2:48db:23f6])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2702:b0:143:5cb4:30 with SMTP id a92af1059eb24-1ac5577508cmr25171030c88.3.1793862920763;
 Wed, 04 Nov 2026 23:15:20 -0800 (PST)
Date: Thu,  5 Nov 2026 15:15:16 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261105071518.1458428-1-stanleyjhu@google.com>
Subject: [PATCH 0/2] scsi: ufs: core: Fix post-reset runtime PM recovery after eef1d74bf88f
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Brian Norris <briannorris@chromium.org>, 
	Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	John Garry <john.garry@linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
suspend callback failures"), rpm_resume() resets ufs_device_wlun to
RPM_SUSPENDED and leaves power.runtime_error at 0 when W-LUN runtime
resume fails. When error handling subsequently resets and restores the
host and link, two runtime PM recovery gaps are exposed:

1. ufshcd_err_handling_prepare() calls ufshcd_vops_resume() while
   ufs_device_wlun remains RPM_SUSPENDED, so the next ufs_device_wlun
   runtime resume calls ufshcd_vops_resume() a second consecutive time
   without an intervening ufshcd_vops_suspend(), leaking core_clk and
   iface_clk enable counts in ufs_qcom_resume() via qcom_ice_resume().
2. ufshcd_recover_pm_error() checks only power.runtime_error and skips
   consumer queue recovery, leaving waking I/O blocked in
   __bio_queue_enter() until another request touches the same queue.

Patch 1 tracks POST_CHANGE variant suspend state in
hba->is_vops_suspended so ufshcd_vops_resume() pairs 1:1 with
ufshcd_vops_suspend() across error recovery. Patch 2 wakes consumer
request queues when ufs_device_wlun is runtime-suspended in
ufshcd_recover_pm_error() so consumer pm_request_resume() resumes
ufs_device_wlun via the runtime PM device link.

This series applies on top of two prerequisite patches so repeated
post-failure W-LUN runtime resumes keep wlun q->pm_only and
clk_gating.active_reqs balanced:
- Message-ID: <20261104112744.1630864-1-stanleyjhu@google.com>
  ("[PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when
  already active")
- Message-ID: <20261029040002.2100002-1-stanleyjhu@google.com>
  ("scsi: ufs: core: Keep clock-gating hold on failed W-LUN runtime
  resume")

Tested: QEMU ARM64 UFS in SDB and MCQ modes with injected W-LUN
runtime-resume START STOP UNIT and fatal UIC error recovery, verifying
immediate consumer wake, 1:1 variant suspend/resume pairing, and idle
clock gating.

Stanley Jhu (2):
  scsi: ufs: core: Skip redundant variant resume after error recovery
    power-up
  scsi: ufs: core: Wake consumer queues on suspended W-LUN recovery

 drivers/ufs/core/ufshcd-priv.h | 21 ++++++++++++++++-----
 drivers/ufs/core/ufshcd.c      |  4 +++-
 include/ufs/ufshcd.h           |  2 ++
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

