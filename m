Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D03BCD13
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792243856; cv=none; b=iS54NZLF3+zGYauObopKxY/JelSh2NFPeYn2uwTh4/qqDlip5S2QwSvchiMj9QOSR/PUV6S3ROTvJMNnnRhDcKV5iOfAi8p3q4UkacQe+cCR9TrXLJwAymL0aO196HMHi+BcDM/xqUnj0EjdrzlPl9x1xpNNxhsnvZWUolPF9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792243856; c=relaxed/simple;
	bh=FQMJxj30Jbh8Y1kO8a4BCGr9W3VcLELopHi5oh2lXiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mw0s/bXqyvtox2zJqYgI8DONpl3xRdUAkzBD0AB9qTrIoFmXVzwbt8GzwaDJyoBORPd5ZhPUSYRW+KK7rKNz4mxdJ2nVgfg/NvNjdcSQMbZWXGJqxlKIbeGHmdRmzfQ+XNx/Rvicz0CtbjRiKG8na3NEf0ZMjdcyl9hnQnNnDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ/9JNdv; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ/9JNdv"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd3310348d2so902476a12.1
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792243852; x=1792848652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7HdD63cIO1sGwME46dAp51tBAKzD7lOoAch50AxvXAQ=;
        b=ZZ/9JNdvROD2022jkf0P/0i9VRnIky1kthf4IBkA7L7MOLg3jOdWIpubmscKhXabhv
         6dmctlfM6BTjwyuXhjWRAyvWfDK2Aj4ThCt+aHkQLPUCMCL+xADpP1szhySA2O7zuDzz
         6Jh4PgmskpQpdb10B0ixrYw/+XxxaJkIAqgws+c2Mv0sBgqdXbPeuEWocFuWutOt2Rh2
         o5Wig1ImLL49XUDwsappFMy98fBewODCuroFcKNyg6UT+Q0uwhRyfunIU9qKBJmbjton
         SSCayQnzFzkTJEaHhiPZTMjF+UADEyRUEhM675S1gwveQtMUhs8txG/nH+Bzh4Pds4a1
         Iw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792243852; x=1792848652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7HdD63cIO1sGwME46dAp51tBAKzD7lOoAch50AxvXAQ=;
        b=uM6quGlizxB1exSE/yaSqBmJVATaYXs3K7oSO6e6DbHZNRo0NSyJMgOkG2d3zKj1aO
         CdvpvSsj+rJi0VHG+vdWkB8QX7kjeP4h5uRFoGEf2xOtIbppU9cbhJ3Z37aNkGxEKZoG
         EwRGS+AMP1NOkMVeonH/2UCH2xzeAV+lB2g8dFv7OKwOQKWYGQfZd3TqkZ/c1CsFHT0K
         +nk9U9UeGgDy69VsPEUoNZfxaRlICOeiDEg/h4LEgtFsbMscOw/fSM7tMIFsh3fW5Kra
         jIBIpozO29zkANBpYBpFu8Bb8r4YLKiWrg6mcyuO6xU8PjlM8KBlfMZUmz84wAzGEVgO
         B42w==
X-Forwarded-Encrypted: i=1; AKwUvBxZ2MYH2bHge01Ah7IjKng7vGmF987xFBVex8QTf/JXGid/22FJGJVWd7R1DDFc6wEsxHEqDhY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1rWlYTl3ye4974kZ+HWfg/hhdHHp2U2pQ8WH2ycQtfKUQxMRm
	b9rFGwoQayK7xmHVqHi1+952q1mQgZWwL1X9gjOjc26xW6wpbzWSlKZ+sj6yiALT
X-Gm-Gg: AYBFou1HlsA08mB8jKOviPA+4QvZX5X2hFosX3fpDokMciybzdDmupJop+L2dNwjb/b
	nrinUkRuVVv1PI53bAFYHfD+Trqtt77xhoft6dsyTcG8DVC42LmdghYLU7SO5uUOkbLsezXhAwS
	M2aTPEQUXV5e34xzwlrHjL8vG0JlJ6rQ42rSNnoguOlETXjL5nQEeBvMaf1GHPg/2deBOFuTYlH
	YrsAVRgbxbdAsLlCmc8HJx8TJrz0FFf0r1/MOFu0pJK6NTdfUr0homON9SAiELMgVQfuPb+rotr
	3qD9es1dcOhY+tZESye2bf7k7J0Xg2ZR00vPBiYmc4binDRlSmiEM5Ha3RY/u1geybN12AYgTRi
	TJdo8mpg75YvMnCWaGusYzh7SLCJO46ddUcciQYMzuPgAqfdySuLOX+5H67wUDdmE4w0uJFTeNZ
	pOLC9P8vVA9Xt8QPvSzT/ezHl4b2Us+QywFBWO/7OnyYhZOfOAEI6CogfnjDD/7BKEVlOt+68Ld
	EGkVuZGWu1Xeuoq11q6fFyHiuQzwB5NGuET2mtHPjORhR2IRsjJhWVsx0wWyNj7XgH5z1VBZ+G7
	+Jf3DxvRrHypZ/2jSNJfsViruE9RtSGgQexHeQ3m0g+p257S
X-Received: by 2002:a17:90b:3e85:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3acef2b4edamr1516587a91.28.1792243852151;
        Sat, 17 Oct 2026 06:30:52 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm14952942a91.9.2026.10.17.06.30.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 06:30:51 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: release SAM task attribute on the abort path
Date: Sat, 17 Oct 2026 23:30:42 +1000
Message-ID: <20261017133042.54305-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A command that has started execution and is then aborted is completed
through target_handle_abort() (target_cmd_interrupted() ->
target_abort_work()), which bypasses target_complete_ok_work().

target_handle_abort() never calls transport_complete_task_attr(), the
only function that releases the SAM task-attribute accounting a command
takes in target_handle_task_attr() at execute time: for a SIMPLE command
the dev->non_ordered reference, and for an ORDERED command the
dev->ordered_sync_in_progress state (cleared, and non_ordered
resurrected, by transport_complete_ordered_sync()).

The normal completion path (target_complete_ok_work()) and the failure
path (transport_generic_request_failure()) both call
transport_complete_task_attr() before handling the command; the abort
path does not, so aborting an in-flight command leaks the accounting:

 - Aborting an in-flight SIMPLE command leaks a dev->non_ordered
   reference. A later ORDERED command then waits forever for non_ordered
   to drain and every subsequent command piles up on
   dev->delayed_cmd_list, wedging all I/O to the device.

 - Aborting an in-flight ORDERED command leaves
   dev->ordered_sync_in_progress set forever, so target_do_delayed_work()
   never makes progress and all subsequent commands to the device hang.

Call transport_complete_task_attr() from target_handle_abort() as the
completion and failure paths do. It is a no-op for commands that never
set SCF_TASK_ATTR_SET (e.g. task management requests) and is idempotent
via that flag, so it is also safe on the failure path that already
called it before dispatching to target_abort_work().

Reproduced over an iSCSI session to a demo-mode LIO target backed by a
dm-delay device: an ORDERED WRITE held in flight at the backend is
aborted with ABORT_TASK, after which a follow-up command never completes
(device wedged); with this patch the follow-up command completes
normally.

Fixes: ed1227e08099 ("scsi: target: Fix ordered tag handling")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/target/target_core_transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 1111111..2222222 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -870,6 +870,8 @@ static void target_handle_abort(struct se_cmd *cmd)

 	WARN_ON_ONCE(kref_read(&cmd->cmd_kref) == 0);

+	transport_complete_task_attr(cmd);
+
 	transport_lun_remove_cmd(cmd);

 	transport_cmd_check_stop_to_fabric(cmd);
--
2.43.0
