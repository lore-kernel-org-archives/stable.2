Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379739;
	b=Ef7y8LhpFJf1av3AzeCylqnpkAhnEbyqvhKdWk6Xcm0o8EAYM4MbTGu7TL2X+2vrN0T5
	 4De2eibjSOOl/N+ykn1XnIiW5INVKNBUQyxaEyEZIpB2c05iyPpaDhYAzNGkBqENK/Ycr
	 KiRbU2VwlCettg0bSStU5pbtydOb63Qc+cLatmCbfhJp0fbHrleAx6c6eGE/ohSXeyacD
	 Kg+ve/JIBx9vU+IRlrwv+9Pf9YPGisRPlvPrdoGkVubHMndNUHMsxZgLz3zov80CQQfrS
	 bWFd3LA2QXmOfJ0QJ3RSZ8KCK0ss83FRO3I1FgV+hVwJor0aKc6d5JcqmOUfrQsLUcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DjmaMCyxv8Ena6C7c0oF6VUANWs59PuasugELu5d8U8=;
	b=hX1H+Ds+0clMn1pHCDJlSfckkKoyQ2Qao/3WBItAZtp31bzlbcwWftCCwRvQZlXO7P3T
	 vMCF4scNjsQAEyNdYWAWCEGKZS8IwvQ7BFX9iAdKfGuRTEPlbgm1lMIH9Ov/9xXKhuS1n
	 BP4TsNqWG30anwJxKlwBLJHSW3pButcvgui1KJZm2Ny45ibqPpLHlTGsedhAM6CEYGNGP
	 igsomfFumtUIYkiNVkkejOvnF/ijvnpFxTMirBw8dULO+FxPpHqWGaQTbXuSeDncntp0m
	 4ILCFgzNIOtI0IR+l+oV5IKgeObZShHa4J/GXgaz0Ty+NjAhWSNRwD5owDb/7aTZEzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNlomR8X;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD9606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46FD9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNlomR8X
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-181516de561so874530c88.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793379737; x=1793984537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjmaMCyxv8Ena6C7c0oF6VUANWs59PuasugELu5d8U8=;
        b=oNlomR8XYfdaGIZ0fNzyFvFBY7tZnMR6M1Wx0jw2tFD0JK3Z4pm106L9tpceISwcF0
         woTz/Hc3NyR9RD4pE1Ogt9sVCI8BtlVdHcmrIC5TTR9kqmuGFStn/90MJ3FoZ+xq/vGH
         6YMGfm/Dp7wm6e7VDj07uCNrCgsXjRefn5D46pRISiBIhp+zklLFG/2GBK8Y/9s/Kz5X
         RoVZgjvQE1T0NP51hGzAI49sKZp/S5nHLhVag7W1gOVQo5Op92n3aejcwqJRuMTrQfNS
         MtHKVRE/rSfOJZiBYRWxmSfnNeFJ0dMsmtWrJ7w4ZmsXLH80/BoKP8OFZqFOlU07eWFi
         +3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379737; x=1793984537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjmaMCyxv8Ena6C7c0oF6VUANWs59PuasugELu5d8U8=;
        b=hJdenFfcoF+mix9BvqzEjLSPHq+fWblFrJ+drdLEGBSLJPxATvKo9DMaUaTtZoRDRi
         pimf9vFu1JoTIb8SGPibYvJvLyiPl96g3u+3dklNkbNtnvESLaklaUw+XC8SjedCpgS3
         DvPsgmH7u2T6VWgoVkAN50KKzIr3LQJWkYmrgaJn9ySXvFIeHfySWqBcO7nFA4UQ2kdd
         n31H+IYFeHiBZSrm3GLcHtNcshDd/YY7hCFvybhKfe7n1IpVRvp7Tv6dxEupZIACg93V
         qBQhQPuvogjzMc5xSC6vFMF+ZVWj4O8fYmH6pNG7A8Qf1Jh8a+9q2dDyF3s+4bdPnu/Q
         kKJA==
X-Forwarded-Encrypted: i=1; AKwUvByn/uIE6humTQVFLwa/XqM2pzol2qSHQOQm38lNqpDLX6P7jIGAZzj060pnk9wYgw2LnREp024=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWUQN/Re5rLhfhTv3vpAlG4e2bMvtoNSHkU8O7K81e//fq6Z14
	0kwryCoBJseD/jaWiD69WJ5AEPkJxrcsMnA82aANNgXY15QmLHmeDHme
X-Gm-Gg: AYBFou2UVKUr0dtQdeEmixXrnzxfpUrteBRRr0axC4MUYWnvw+eibVlnZEl1uEMs2UM
	l/U7Hm/W7ukxSHbRrIZfzmbK9NPMXh01vNlfnN9ccqZ+VtazAysLPej36wTOqTdn06V5cuGqgzD
	18rc1wdep54MA7oLupYgR+/ykC5HkuZhUrPm6BechF2vQiN2QQognqMQnDFaM9/iZtEa/P59ldh
	UTLge/zGuafXdk42i7K6uk3uma458AmhypSG7iThPFtXtt9UnIqICetL9etH0QW+fhseOTX5l2C
	CMP3+cd7g10ruIFxpNqgY8xSnE/VRa1wF/TkS+2hY9D+fzCj1uRwwrv4lpBDYQLwAQzzOVhzcCZ
	eeQJf76yAYpqlW2Pt3OR7GfdiLU2gS176fHmTq//hqbdPYihhbqMf+wuyoSXKJIkanETiuL5Xzj
	Z4clNmDmYI0kLvKil1dISseDBNrz4zfYzTpbqSD++3/79ipXb+2mmBBKKaEMJvS+eFAa8n6vkje
	VCojEh4tzks+KYkxthfLeNIeab4A+TkAKwuMozZuZEHCgeyABmeDmx8egZIjRy9JfZ/Iiit0t9l
	UkJNKmSyz6Jpbynj7nlEjZKe6Ipwa27DKIxH1Oe46sDg9jLDqZon9aY0
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id a92af1059eb24-1ac5b027fbfmr3148575c88.13.1793379737104;
        Fri, 30 Oct 2026 10:02:17 -0700 (PDT)
Received: from bridge.. (deps54-26.deps.ufsc.br. [150.162.54.26])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm8113659c88.15.2026.10.30.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:02:16 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@kernel.org,
	nilay@linux.ibm.com,
	wagi@kernel.org,
	kanie@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix use-after-free in nvme_tcp_free_ctrl()
Date: Fri, 30 Oct 2026 14:01:51 -0300
Message-ID: <20261030170151.49844-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
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

nvme_tcp_free_ctrl() reads ctrl->ctrl.opts to know how many queue
mutexes to destroy. When creating the controller fails,
nvmf_create_ctrl() frees opts as soon as nvme_tcp_create_ctrl()
returns, but a concurrent open of the character device can hold the
last reference to the controller. With CONFIG_DEBUG_KOBJECT_RELEASE,
which delays the release, every failed connect reads freed memory:

  BUG: KASAN: slab-use-after-free in nvme_tcp_free_ctrl+0x38b/0x430
  Read of size 4 at addr ffff888005b93740 by task kworker/2:1/51

Keep the size of the queue array in the controller and use it instead.

Fixes: 2eeeaa9c1ff0 ("nvme-tcp: Validate the queue state under the queue lock in the address attribute")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Based on nvme-7.4. Nilay pointed this out on the nvme-rdma thread and
suggested the same fix:
https://lore.kernel.org/linux-nvme/1408da28-a55e-448b-b493-d60fd5d20524@linux.ibm.com/

Reproduced in QEMU with KASAN and CONFIG_DEBUG_KOBJECT_RELEASE by
connecting to a port with no listener. Each failed connect reports
three use-after-free reads without the patch and none with it. Growing
attr_qid_max from 2 to 4 and 30 resets, both under I/O, still pass with
and without lockdep.

 drivers/nvme/host/tcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a8e94e4866db..d11fb52ce1a2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -204,6 +204,7 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+	unsigned int		nr_allocated_queues;
 	struct net		*net;
 };
 
@@ -2861,8 +2862,6 @@ static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
-	/* the same count used to size and initialize the queue array */
-	unsigned int nr_queues = NVME_TCP_OPT_NR_QUEUES(nctrl->opts);
 	unsigned int i;
 
 	if (list_empty_careful(&ctrl->list))
@@ -2875,7 +2874,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
 	put_net(ctrl->net);
-	for (i = 0; i < nr_queues; i++)
+	for (i = 0; i < ctrl->nr_allocated_queues; i++)
 		nvme_tcp_exit_queue(ctrl, i);
 	kfree(ctrl->queues);
 	kfree(ctrl);
@@ -3269,13 +3268,14 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	ctrl->queues = kzalloc_objs(*ctrl->queues, ctrl->ctrl.queue_count);
+	ctrl->nr_allocated_queues = ctrl->ctrl.queue_count;
+	ctrl->queues = kzalloc_objs(*ctrl->queues, ctrl->nr_allocated_queues);
 	if (!ctrl->queues) {
 		ret = -ENOMEM;
 		goto out_free_ctrl;
 	}
 
-	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+	for (i = 0; i < ctrl->nr_allocated_queues; i++)
 		nvme_tcp_init_queue(ctrl, i);
 
 	ctrl->net = get_net(current->nsproxy->net_ns);

base-commit: 89480d137bf0d943a82c64f86ae2407a15276b5e
-- 
2.43.0

