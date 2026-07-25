Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7944908D3
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969397; cv=none; b=IyRcVeIcFtDDcVxWycRvJ2beYj1tjTsalEybysAQ90w8KZjMmEJwJ17HzmB63/9qi8E/lyrHbdIqu8UGMqYBIUBmsyFAPpnM/ejxl82hhltqHeeop2GkhPiw1e3Hfpt1Iic2slRfgw4/YtCJfpjDvSAYyz34UZZfT6M6y2YJSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969397; c=relaxed/simple;
	bh=5wbCDtZrp3iGrV7cvqBSX5L1cMn6ozL59j7qNmbBlFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvUppaLYszlSqCmgTqEigPVT1EtsCvzY6sp/oUO6m4srIibBY8ZDfF8OHPC043jsddWSCIGYNWcmwpfYSXNlZXhxjOVCiq7bPr7XD8V5T6MJ7BM39ufldIxreH6C+O51Yp5SZJs3/SUb9NGfUz9xRfSrI3jsgcA2TPb4sxagBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=ucIkn7pr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="ucIkn7pr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc61541f8cso25365105ad.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1784969392; x=1785574192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hVrFE1uT0BINsDxyA59hgmjG595lAs1SmBDuzg2mqOY=;
        b=ucIkn7prAAphz5VvOCHw4BKchC8tQzIwlfgt6tl5Ze6rb/f/5QSfx0VcNM9osj8816
         HwtK67Lh/C5rh7WI+E7cVs3DosbI8gRBIgTS/Hg0NVj4MiAos9SO0IDCb64vZjxShxg0
         aQnHQu1bXZd3mQ8JsU1hcgAuQSKjkfO3Zon9UDfcnnoRf+hDomh1TvtzyiPtIjhaIJXA
         Yzq/vqCXLDonFudxkBJDhC41JQzfu4VzRctLvY0r3oKfHRJBPTb+CDRB4MNSs6v/6WYP
         a0F0TnUkB9Xq/Ogv2F2iUFjyl+5xS+aV+2CFQKW047v1VvwGNcWwqiV3xls1m+k6mmiO
         Qcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969392; x=1785574192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVrFE1uT0BINsDxyA59hgmjG595lAs1SmBDuzg2mqOY=;
        b=HXdjF/NDw+XVETQaMEl3b8W6ZjP1ldyN314kVvT+HqIARXG6sJfdSaTUPwmtKib4jF
         2dqZ0mcdWAAB7FwoRmyMzDhp+Z1Jl+CcX6RmTlf/kF0ymZPtNgi7Z2rNjtQjTusaNGib
         eJmNNhhU1EGbG5HjR+3csvzdUVjoEqGWunw4VSs26WWLEy6JA2YBQwpmzMpyLpFW+cZl
         wOPRJLehU7JYgOQppsG+Q9CRAbNt0LsFyXytFFC675gOL0YA25zuYe04Z7OeCuq/wlNe
         cqgEtFSzwgaej25nKEG/5ObXPtYw9clH6PYPCE3o5aUzdlgOmav74DR0WT6GUy9pFliZ
         075A==
X-Forwarded-Encrypted: i=1; AHgh+Ro3jZ59c1fP38kvEqvoBY3UaUyNj4mLPU5r2RnV/RhfdB7N3nKHea/CrULybJWqigxy2b6Zxd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOXjlgjdgytjkB18gJYzdZ5cfuwHFApYOXpKZD8S2TaYmrIe9
	0d08TvGqbmF0xxS2ywu5ugU15JB7J8Wtoc0OcTYzIfMSxVucHVNE/P0oYzCiqlzskl8tD/jwdv9
	8zneJ1yiGmA==
X-Gm-Gg: AR+sD10v8ltY9+80D2IEnM4j56kEGjvR7QxekS6wMv6YgInsR3uadrFGhLIjmZ+qbdB
	G21/dRsCAM4YFEkih1xqlAQY/2+72MxhHKNdSKqryBsrUpNPrbsBTkQfBRzkE4XMQpU4HrR4nqv
	xnD9Hytjs/qlxkYfvfIheyAJQuijijpTVHfzv6SUJs69ymmdx5WPxmpLmMxjCDWsUtspoevE1AJ
	Uq8nPU4MKzIfWnXZfTG9X6tlL2a/LWGMWYJ0DeY2mOlb2scjnQp95rWYakYIk2MHXsL8AvZlVVn
	bSP+Sff/Gesw01JT9tpsW2eHDa+JaF4rlufqo7hUTebAoJ2npMRvgwqUSo8YHZRXdY5ta6J2qLs
	up7QAAr2AhQpPjaedMOTRZ4mlS3S2elsHGCc8GSHtN1OslezFDjTtSK6/igQtMDPeVXUfs6ltpy
	39DaPeoIzy890uXk1UoJi388rW
X-Received: by 2002:a17:902:e549:b0:2c9:d8c5:d55d with SMTP id d9443c01a7336-2cfdf41daa3mr13200785ad.16.1784969392582;
        Sat, 25 Jul 2026 01:49:52 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:27f4:9b8e:6315:1280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2b8esm7168165ad.31.2026.07.25.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:49:52 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: martin.petersen@oracle.com,
	michael.christie@oracle.com,
	himanshu.madhani@oracle.com
Cc: ddiss@suse.de,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: Fix NULL se_tpg dereference in target_complete()
Date: Sat, 25 Jul 2026 17:49:39 +0900
Message-ID: <20260725084939.694403-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a47fa41381a0 ("scsi: target: Fix NULL dereference on XCOPY
completion") guarded target_complete() against a NULL se_tpg_wwn, which the
EXTENDED COPY worker hits because its global xcopy_pt_tpg carries no
se_tpg_wwn.  target_complete() dereferences
cmd->se_sess->se_tpg->se_tpg_wwn; that fix handled the innermost pointer.

The same statement can fault one level earlier: se_sess->se_tpg itself may
be NULL.  After a session is deregistered, transport_deregister_session()
clears se_sess->se_tpg, yet the isert receive path can still submit and
complete a command that references that session, so the backend completion
runs target_complete() with se_tpg == NULL and dereferences it:

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
  Workqueue: ib-comp-wq ib_cq_poll_work
  RIP: 0010:target_complete_cmd_with_sense.part.0+0x17d/0xc90
  Call Trace:
   fd_execute_rw
   __target_execute_cmd
   iscsit_execute_cmd
   iscsit_sequence_cmd
   isert_recv_done
   __ib_process_cq
   ib_cq_poll_work

The exact window in which an isert completion outlives the session
deregistration has not been pinned down; the guard defends the dereference
regardless of how the command reaches this point.

Load se_tpg first and fall back to a NULL wwn when it is absent.  The
existing "if (!wwn)" path already queues the completion on cmd->cpuid,
so no new branch is needed; this extends that guard by one pointer.

target_submit() reads the same chain (se_sess->se_tpg->se_tpg_tfo) and is
exposed to the identical NULL.  That path has not been reproduced here and
is left for a separate change.

Reproduced with soft-RoCE (rdma_rxe) and KASAN under iSCSI connection
churn; no kernel-side test hooks were needed.

Fixes: 39ae3edda325 ("scsi: target: core: Make completion affinity configurable")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Tested on 7.2.0-rc4 with soft-RoCE (rdma_rxe) + KASAN under iSCSI/iSER
connection churn.  Without this patch the target crashes in 2 of 3 runs;
with it, 10 consecutive runs are clean and complete the full workload
(160 of 160 cycles, matching the unpatched baseline).

To confirm that the guard - and not an incidental timing change - is what
prevents the crash, a build carrying an additional print inside the new
NULL branch was run 10 more times: a NULL se_tpg was observed 13 times
across 7 of those runs and was handled every time, with no oops and no
change in I/O counts.

 drivers/target/target_core_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index fad03a15c969..ee5781d89433 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -904,7 +904,8 @@ static bool target_cmd_interrupted(struct se_cmd *cmd)
 
 static void target_complete(struct se_cmd *cmd, int success)
 {
-	struct se_wwn *wwn = cmd->se_sess->se_tpg->se_tpg_wwn;
+	struct se_portal_group *se_tpg = cmd->se_sess->se_tpg;
+	struct se_wwn *wwn = se_tpg ? se_tpg->se_tpg_wwn : NULL;
 	struct se_dev_attrib *da;
 	u8 compl_type;
 	int cpu;

base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
-- 
2.43.0

