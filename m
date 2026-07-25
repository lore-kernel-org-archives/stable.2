Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F423F23B1
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784998727; cv=none; b=k/Oq0MOSaz3xnjhqqUrrsGpoeLi1FRR6o+BMsd1AeEs6oZnQx3c4qTaYBr1ltynigrgpurNKR6ERIfZ0qbs8X+8fEa8q7cMTcRDNEcB6L/L+AwxYqnVdlBWMpyU7U12EF3Uow37sGKMYeHW1JowjvWhbqTwWsGm35SRqkguxkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784998727; c=relaxed/simple;
	bh=LWPaSRdTaK/zLOcQpiD2kptFzcCjeBzXpfz1b58ofxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r53XwHABkGRP5KSWJVMV+IVoNW6P2U1jfOfIFtMzxnjdljT0rieRP7Nt5MB2MKAsilxKksnv0iD8xmswrAYsNjA7F3Hx8F7bNhvDqAiUY0XilQSszt5z9AgMVc5fcnWc7nnlCYEtawvvK4qrYHjqd74II8rMkrDby/cRCWsiLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=CKj8sXzn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="CKj8sXzn"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1124741a91.0
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1784998723; x=1785603523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0t/YY47ENH5SCQReYb/C+fGrbKDzqPxbSclegiFo9uY=;
        b=CKj8sXznyw8csB0bbGHMa32FEnwmZmrUsgIXovVOsyxxDsjEA+vE0nCXQJrX7+qg+X
         a2xYk99PJ7XVdvFLcMRw34qIkvgq3hCbYD0vWCrUP7fFQWIAnG2EPUMHWwnPY3zTBIYu
         r10/iMxxEQ1gLjB3Uw+dzbFkP4wGHLdei8Mjz/iWGvylywFg2z8DBXyXpIsi4iSsHiTn
         VERZKQyPjEWcx93WAVEsjw9Mkmz/zEdeo7kgdwEdpVBJzddaBANlHcQsNTBwgTucMp32
         05PieZM8oLimYO5VRLYVeklzcMUGNdS519JES89yhhA0NHTfuF5zWkcSUQVUoB8rgOjU
         8OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784998723; x=1785603523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0t/YY47ENH5SCQReYb/C+fGrbKDzqPxbSclegiFo9uY=;
        b=EDiiNPzLeys5yVyeJs0I+KVY7KMz4vwGPosiyxfudafdzTUqfdAHcoFy/ayGUy7jQI
         Oq2fsughrd73ZU3kakrxFKfzP3aDGmYl4AMdiSnbp2EI0pkRio9J1tkIKQct3q5wZTde
         4CIBNv+BYa4KqcBNmmrQKnSZHBpWsBUrZ+l7mMj0a59d9mrxvgI1y8KaA6FiVeVDgSod
         ceT8tCtCylPTdJ1NZ/g/hdPzqkv0clODl9n0CJziwn+nLg9efnJOtmbFIZPgFUNMGh+l
         A9WCBcA6zeqXgVjSUW785uJHnJ0C9nG2IY/Y+4zA9uBg4DG4L+SgJFAaMSYfolS1gt5k
         +nSA==
X-Forwarded-Encrypted: i=1; AHgh+Rqxb7d+ClOi/mNXJds21tR9UWrrBjagw7ZKgSsAkElULpBM7jEj5Nxo1uuDcyk+J8QAgxNuSJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11JZ9ss0KJwDi3Qx5FLQZ8X/h/pN0gqCzUfMXqb2I2vySNjO6
	JlQRsl2SKziWfMg+3AcO6VFLEI+hUDbXYDjHbaTnlmaYTLFx4ZVAeA4bkzrqwlrdDzw=
X-Gm-Gg: AR+sD11mJ3iF5+KBODD9dsNgXlZJW+kX8z74IYiZbMENIma7IKqS0CMctIw8JfnG3W8
	MpJGmY064wO036HWUaHv7UT5iJxq14v3Q7In29M5z1HNt7eDaQ4dUixetHqLGCriDed3iMjz4W9
	yL9t4vHrhEWCLmSmvrBwU8RlixRcYegPHCNmpP6xcZzdCmu9SnTK2FDbQr8w7Bh+8zi8QFBn4pA
	FVq4m8prtazPmSnzhSI8KKImb6gsM20RNXlkANCRBSsZ1Rf4kSZLnpQ6Va/hLowe9RqXVHvpMYt
	7CCIsCUMUpWam6fcirOVxJZV2svVsF4KV3fZFwGntcWQMqEbInBFmVBlWv0+vgkW0HiDp/+FGxr
	pdY8h5s0Nv58MnIDd8dX5drPluY/fb5S0F65rNgJacwX0Jhej9zY+/iiY7vaKSx7zcJ0B46CeLo
	x3Jb+uHSZ/YAmnnk16ert/V7N+8iL9oet72vM=
X-Received: by 2002:a17:90b:4b8e:b0:38e:2a4:cffc with SMTP id 98e67ed59e1d1-38f2961561dmr3186543a91.25.1784998722983;
        Sat, 25 Jul 2026 09:58:42 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:27f4:9b8e:6315:1280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f058118f2sm1814967a91.1.2026.07.25.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 09:58:42 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: martin.petersen@oracle.com,
	michael.christie@oracle.com
Cc: ddiss@suse.de,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: target: Fix NULL se_tpg dereference in target_complete()
Date: Sun, 26 Jul 2026 01:58:18 +0900
Message-ID: <20260725165818.769963-1-yhlee@isslab.korea.ac.kr>
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
read is lockless - transport_deregister_session() clears the field under
se_tpg->session_lock, which target_complete() does not hold - so use
READ_ONCE() to keep the compiler from re-fetching se_sess->se_tpg after
the NULL test.  The existing "if (!wwn)" path already queues the
completion on cmd->cpuid, so no new branch is needed; this extends that
guard by one pointer.

target_submit() reads the same chain (se_sess->se_tpg->se_tpg_tfo) and is
exposed to the identical NULL.  That path has not been reproduced here and
is left for a separate change.

Reproduced with soft-RoCE (rdma_rxe) and KASAN under iSCSI connection
churn; no kernel-side test hooks were needed.

Fixes: 39ae3edda325 ("scsi: target: core: Make completion affinity configurable")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---

v2:
- Use READ_ONCE() for the lockless read of se_sess->se_tpg.  The field is
  cleared concurrently by transport_deregister_session(), so nothing
  prevents the compiler from re-fetching it after the NULL test.  The
  store side is a plain aligned pointer write under se_tpg->session_lock
  and is left unannotated; happy to add WRITE_ONCE() there as well if
  preferred.
- Retested from scratch; every number below is from the v2 build.

Tested on 7.2.0-rc4 with soft-RoCE (rdma_rxe) + KASAN under iSCSI/iSER
connection churn.  Unpatched, 5 of 10 runs oops with the same RIP
(target_complete_cmd_with_sense.part.0+0x17d).  With this patch, 20
consecutive runs show no oops.

To confirm that the guard - and not an incidental timing change - is what
prevents the crash, a build carrying an additional print inside the new
NULL branch was run 10 more times: a NULL se_tpg was observed 9 times
across 7 of those runs and was handled every time, with no oops.

Some runs end early with an initiator-side login timeout from the
soft-RoCE rig instead of completing the full 160-cycle workload: 4 of the
20 patched runs, and 2 of the 5 unpatched runs that did not oops (the
other 5 unpatched runs time out after the oops).  The rig behaves the
same way with and without the patch.

The BUG_ON(!se_tpg) in target_init_cmd() and target_submit_tmr() can be
reached by the same teardown race on fabrics that use those helpers.
iscsit does not - it calls __target_init_cmd() directly and has its own
TMF path - so those paths could not be reproduced or tested here, and
converting a deliberate assertion into graceful failure looked like a
decision for the maintainers rather than something to fold into this fix.

 drivers/target/target_core_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index fad03a15c969..0b292e386691 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -904,7 +904,8 @@ static bool target_cmd_interrupted(struct se_cmd *cmd)
 
 static void target_complete(struct se_cmd *cmd, int success)
 {
-	struct se_wwn *wwn = cmd->se_sess->se_tpg->se_tpg_wwn;
+	struct se_portal_group *se_tpg = READ_ONCE(cmd->se_sess->se_tpg);
+	struct se_wwn *wwn = se_tpg ? se_tpg->se_tpg_wwn : NULL;
 	struct se_dev_attrib *da;
 	u8 compl_type;
 	int cpu;
-- 
2.43.0

