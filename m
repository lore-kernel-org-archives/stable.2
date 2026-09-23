Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF93C10B5
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145816; cv=none; b=lvbN8CFqp3VgSc0iU7hbWTS2DT3zpSPHgi50N5AE6WvHjJsWI3tccTTbrBEK2tASQyCdz3sw7eajrTHuyOXNBf08uxFGOb7QzRfVhBLfOe1T4sU2y7zkhoVFAhf5eFUJAWoMzt7vYgStEo/DwOQRvCMRim+3tgxY/D+lcCRqf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145816; c=relaxed/simple;
	bh=xR1/NeQX09LWnchhSJVuQ4BnNu/6StOlNDyMewUEQSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/E5BkHKajv9D/iDB2aN6kMwmwP8HvC4qRbMVbTvm/uVSgJbewfPTkBBvVGV4BmYLH6P92C3qBIVeYtklNq/RLiuZk/qTQlKEZKowtjZ2qc8/LR/5QPoiVMMBihnOxxdYLXHYrtdmXfCYuRL0BoGjXYEpE8RN6qyGHfUuhSUM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaLM412a; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaLM412a"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39666e7c9efso50701a91.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 23:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790145807; x=1790750607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FQdfqiVzHOdi7EyeynQ0dghVkDzzyRlpExwCwSwjPJw=;
        b=YaLM412a/JQIxO5NQM3h0M9A+YSeGws8quxmpM+0heun6ScE/o9z4hdL8ftXQXjjsR
         6LgDcMhlYxc7Bv9upgmAbGscjwaaRojGRAtu2CzW/IAk8WDiA8PcK2SDDRbh9zRLjTM0
         EjTRzvTouq7TikSkxa1jdC+NvBNqlY7ztMnDB2PBETw2846FstH+fCqpn3Dq/KWVjG0c
         weHaX+eHQQhg/+GourQ187dlul4ZjCmvT2b+b/3a9BO3q+CcwPr8Mc9enQ+zFebX90wo
         A8O+7zEONZfw13VDHxWrY6kOh/sSxNrTqL2GB2orSsFVvcWV0OcjgLlFOEHxBiKlB4pt
         K4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790145807; x=1790750607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQdfqiVzHOdi7EyeynQ0dghVkDzzyRlpExwCwSwjPJw=;
        b=qjlKb2AAG3NkPu6l6fw3Z4gmVvUqyjSKtsPqZvt7Na+mOfyyZ0Qc4Rloa1zz5ej8r5
         kzpcvQxuzk1WsHe3jBcF1i7kn8P/vPCA9y89PfzoiGzezJDhbCZyCQYzG7+pWCzRvauB
         ZgS9HmIV7SiVZaoYkM1NRYCLTKlfqHAXoMSVZlpJig7q6l8lQ+ouanuzZkk6lPPfbJoU
         gKWA7CyIU6zCXRDSt37wbNvoSeHwb8ruOzzenNFggY3AoYW1Jsrr3iH5pQrXVA+VRsF7
         0/Zm+6zAhUolVsKzPjl90XjtRO/bgxwg6gxkF0aPnMbbLFTdH3b8VpYCsQuNfz+Fr/O3
         xclQ==
X-Gm-Message-State: AFuF++lXf86KByvQKO799O3/SY+BQ3BM6skc4LHW0WTD+bgGEkNrx1o/
	3+7GHuAoug1ZuO3Ywgdl2FFkPi1IHJkq3nP+zKEly1WTwnP1uM5yVdLhnSjZbe7Lh8I=
X-Gm-Gg: AYBFou2T1rtdOYpGCfFeOe9E4hUs6qp6Dz8PNmXlDULZrYi7l0qZJrCpYgG4gVZxrsk
	XeH4lAdx/iN8A2dFM74n5FCI7HNeDyPTfbejgkDlmBl1/NfmLO03mzngicpQDDsQ0o9+S8oJPJV
	FDlIHAck4B2/SlDMiuxKol2cvKJh95LoHYp1w3EVAfPFXIGjwQ34M90mrUMjtQTK6WY8ZOxlWDH
	wwSPZDw6bEsgXwfmBLuecYfDbp/P8O6g6tvhazOqn+WnkcmAbUD5owYt+7Rvb0Mwym8WnDTHLxo
	xgbcuoTNjJrpEL6Pc9nHDtJ4uPs4tlneexn2a77f0WUNno5h+9oQn1AeBWl/tXTKr1lVqGi79pU
	2+Qv1VX3Lo9TroZIxi7ryz+Vf19aLnKJKLlyF7CDbW/lO7U1Tr05l1l2H5P8Z5qx1Zai9cIb+0S
	eDFTVzsj6PPQ+0Oqr368Ukm1bUvGThV6LDcxY7M01r5vUG/yoeDKAmqMl3HoJ4ooIG+w==
X-Received: by 2002:a17:90b:564d:b0:39e:4546:fb1e with SMTP id 98e67ed59e1d1-3a07e7e4d13mr2618891a91.4.1790145807481;
        Tue, 22 Sep 2026 23:43:27 -0700 (PDT)
Received: from archlinux ([138.199.21.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc32086sm3227338a91.13.2026.09.22.23.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:43:27 -0700 (PDT)
From: Chen Xiaokun <shinnkka1@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	felix.moessbauer@siemens.com,
	gregkh@linuxfoundation.org,
	io-uring@vger.kernel.org,
	Chen Xiaokun <shinnkka1@gmail.com>
Subject: [PATCH 6.1.y v2] io_uring/io-wq: Fix memory leak in io_wq_create() on success path
Date: Wed, 23 Sep 2026 14:43:15 +0800
Message-ID: <20260923064315.195997-1-shinnkka1@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ This is a stable-only patch for 6.1.y ]

Commit 657ca82526d0 ("io_uring/io-wq: inherit cpuset of cgroup in io
worker") was backported from upstream commit 84eacf177faa to 6.1.y.

In linux-6.1.y, this backport introduced a temporary allowed_mask 
variable in io_wq_create().  It is correctly freed on the error path,
but is not freed on the success path.  As a result, every successful
call to io_wq_create() leaks cpumask_size() bytes of memory.

This is a 6.1-specific backport issue caused by the differences in the
io-wq implementation, so the fix only applies to 6.1.y.

Fixes: 657ca82526d0 ("io_uring/io-wq: inherit cpuset of cgroup in io worker")
Signed-off-by: Chen Xiaokun <shinnkka1@gmail.com>

---
Hi Greg, Sasha, and io-uring maintainers,

This patch is specific to 6.1.y.  Commit 657ca82526d0 was a manual
backport of upstream commit 84eacf177faa ("io_uring/io-wq: inherit
cpuset of cgroup in io worker").  Due to significant differences in
the io-wq implementation between 6.1 and later kernels, the upstream
change had to be adapted for 6.1.

Later stable kernels do not contain this 6.1-specific backported
implementation of io_wq_create(), and therefore do not contain the
leaked allowed_mask.  The corresponding upstream implementation also
does not have this allocation.

Therefore, this fix is only applicable to 6.1.y and should not be
backported to other stable kernel series.

upstream patch: https://lore.kernel.org/all/20240910171157.166423-3-felix.moessbauer@siemens.com/
backport patch: https://lore.kernel.org/all/20240911162316.516725-3-felix.moessbauer@siemens.com/

Could you please queue it for 6.1.y?

Thanks,
Chen Xiaokun

Changes since v1:
- Reword the commit message (clarify that this is a 6.1-specific backport patch)
- No functional changes

 io_uring/io-wq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 0c3de2fead81..f1bc212309c8 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1221,6 +1221,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	wq->task = get_task_struct(data->task);
 	atomic_set(&wq->worker_refs, 1);
 	init_completion(&wq->worker_done);
+	free_cpumask_var(allowed_mask);
 	return wq;
 err:
 	io_wq_put_hash(data->hash);
-- 
2.55.0

