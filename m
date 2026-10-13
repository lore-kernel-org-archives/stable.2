Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C14F4030
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909028; cv=none; b=mC9P7a+FIsTNwzNZvoXrHdZpNYz63VJ1NuTydPY1TIrXhAIsRaZj7keF+hFTFAw4sa46M4M2heO6f5bRrNmLlNJQhdPWPAeXykcVbrabLP9U8SRMyY/jKuuks7yu6py3XICcVF+9IZX9sa8GrnCQNSp0CR6POMJrmVuOw6qhphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909028; c=relaxed/simple;
	bh=9m7NtTHET6m83f9Mk11W5vw2NZvap3fwY2zve4r26nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXAnU3y+NMgYjnsn/hgjt7XRC34Y68r8qWjz8Mz0slNQXUufgaIBOFvouWPdhH9bGHnGBx+CUnItk7h65cRCRaqVx0tYP1BpsvS4o7DN5JR8N9n62pS0NEvF8I074RFvBxA1Eaxb/f6S4r0gZWSS6/ak7CCkpU/Agp4sz6sV6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igm1WB07; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igm1WB07"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd1006978ecso169706a12.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909027; x=1792513827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PlQnD3vqPXRC6bXv4DWDPrp7sKdyCguQyIZC8BvmMCk=;
        b=igm1WB07j28aCQZqVpjaX3R624Nz2pQOth8j6We+ByOhmftIfEWP4cGdd13agEIt3d
         xDNFenXvhjW/guWsor6u2hloBljzxSide3iFYlLf78UR5AbtuB4hVDG1Pn5yd/axeMxp
         kOCnyX4IUIk/M47iMjFyjeAsT2J6HTs/xONcBiNG4TuJCQ/OqDjTVEhWIKPEIBTEMtqz
         +0/C/H1/CBySZ8nY93aPRykDoDrI5GWvFTG/zH5/UqIARmEtyZkCXs/S2kt/SupHE3Au
         rhzdvnMqfHFNEBeVWIw4FoEE/IR61s861U9OkmNRx7E/yVevqDZK018xB2kSbzk/ECqe
         4zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909027; x=1792513827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PlQnD3vqPXRC6bXv4DWDPrp7sKdyCguQyIZC8BvmMCk=;
        b=Br+kC6c46hkHVGkJ03sUeacwhxT+X42T/amluS4tkzPzNS7hdJTng3Ska1J0kMrdhB
         z6x02HWqUjPjfP+7Ompfq2mopMLVXNtx9G26MYcgPWixxCkaNKQAlWlpTlSdJOtbRgU0
         bmWf+UWkcw2ntNqsWhepsgg4O7svas29374LKRqbQIYyQ4HSia/TetfD23xezIl6hAUI
         sKnkfLbmLJTidzjQMW6ti04lKSvLmUxNIGFsGkaVeZf0yTFK+cqaAAFvrqm0Qv+TEgDo
         nFqCywSqecsUm2E64kZnorxUJ5PRFmt/dH8FmlAMypYiKtRElKlizu6DZYu0VKaoiii1
         +FDg==
X-Forwarded-Encrypted: i=1; AKwUvBye1iquL4bCxkwa2tDMinApuQY4/hKswvxUIbPHsakiQIjkWfXr4OdeInFR2u1uIh6BBIMYnTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7ImA9QNk1G3XJ8TX4ODgx9haIfdm9zjBgV1XQjZPV8l0QArZB
	bB8jA4BKmNF6vyL8pgfraICCMzL5u30UU8pmHM5FE4yOCDkDFVpY9/Vf
X-Gm-Gg: AYBFou0aKdMUyhDsRVjWoMwAzjBxeNOKKXE22DwgiV+i9pU9et5nB5OdTFK248bXzX/
	EyXdqne2i9GUwIfvczGBnBmMUtDEBzXTCbzJPoeDrtiKRVjy8e4miEEiIp3ttqxgwoEh9Oq7Nw1
	4ra1LS8aSlAkwj6Z9Cj69XqqGmb5akRMpN1VmG0CshE8Sga56djfATns2u/JavS4Fa3l6Qx6Bjc
	QnAUjX+Jr/eZ7TxzAlEAIo624ldPsP1LslypGopySwdMFmua+bzOxvhBbxxXKC/GVGQQxVsr91f
	xMl4Pm2DgCT50T0V/NWNNLPNrgX+t9KBJC+KXGAPm9dT4p4YcZFKp36f6SxUGZYTEftmyZD4g5V
	eNkQnaPOcJPyibTwkjVQXUta19F2EEBSGVjl69i0KenM0Dof8HaKmM+UDBhyaQ7SKvr8lhqAryW
	Ldp+o/xgclMf4Lgn/65/nmzI245dIajXR/AJ/+F17rOdKG4437xsnwb9+yceJBccUiEZB6TWe+P
	6M6lTY3slX/8g3kB3u7oFc9XOQL9lbCW6jdII+JVn9mtZXbSL2CQzaKWyrHPHGxbuZf
X-Received: by 2002:a05:6a20:430e:b0:3de:7dd4:e32a with SMTP id adf61e73a8af0-3e16bdae01emr16584442637.2.1791909024978;
        Tue, 13 Oct 2026 09:30:24 -0700 (PDT)
Received: from localhost.localdomain ([119.127.198.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e0816csm6462483a12.7.2026.10.13.09.30.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 09:30:24 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	elic@nvidia.com,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH] net/sched: cls_api: skip indr register on failed bind
Date: Wed, 14 Oct 2026 00:30:14 +0800
Message-ID: <20261013163014.25722-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding a device without ndo_setup_tc() to a shared block that already
offloads records the block on flow_indir_dev_list and then fails.  Nothing
removes that record, so once the block is destroyed the next
flow_indr_dev_register() splices a list into freed memory:

  tcf_block_offload_cmd()
    -> flow_indr_dev_setup_offload()
       -> indir_dev_add()   [ record: data = block,
                                cb_list = &block->flow_block.cb_list ]
    -> return -EOPNOTSUPP
  tcf_block_offload_bind()
    -> tcf_block_offload_in_use(block) is true    [ offloadcnt > 0 ]
    -> return -EOPNOTSUPP
  tcf_block_get_ext()
    -> err_block_offload_bind            [ no tcf_block_offload_unbind() ]

Only a FLOW_BLOCK_UNBIND calls indir_dev_remove(), and the failed bind
never issues one.  The next flow_indr_dev_register() replays the record
through existing_qdiscs_register(), where list_splice() writes the new
linkage into the freed block's cb_list; the callback that the replay
allocates keeps indr.data pointing at the freed block, so a later driver
unregister reaches tc_block_indr_cleanup() on it as well.

The fix was built and the reproducer re-run clean on it.

Fix by returning -EOPNOTSUPP before flow_indr_dev_setup_offload() when the
command is FLOW_BLOCK_BIND and the block is already offloading, which is
the condition tcf_block_offload_bind() rejects the bind with, so that no
record is created.  Keep the check limited to the bind: on unbind this
branch is the only caller of indir_dev_remove(), and it runs while
offloadcnt is still non-zero.

Fixes: 74fc4f828769c ("net: Fix offloading indirect devices dependency on qdisc order creation")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/sched/cls_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a9f54988561f..7acfe71853a7 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -860,6 +860,10 @@ static int tcf_block_offload_cmd(struct tcf_block *block,
 		return tcf_block_setup(block, &bo);
 	}
 
+	/* a bind that cannot succeed must not leave a record behind */
+	if (command == FLOW_BLOCK_BIND && tcf_block_offload_in_use(block))
+		return -EOPNOTSUPP;
+
 	flow_indr_dev_setup_offload(dev, sch, TC_SETUP_BLOCK, block, &bo,
 				    tc_block_indr_cleanup);
 	tcf_block_setup(block, &bo);
-- 
2.54.0 (Apple Git-157)

