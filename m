Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635522;
	b=l96AWWTr5FgrCs6ynDPCtDnd/SpnBXvTMEoZAVkZuNSObEy9g6zC7l6yJd5RDoVtLglx
	 g0uNc46zjuL3C7HwCg1nh9V/z29ZSxr8KCQ3aYWa+1e/5WxLdwbHgh6hT3ujWqrSIJxNp
	 F8XBYDXuXzahnTDWjzr0a9irK1g1hGOH0WhfATq9miXl9CUyQfvkakJFg8K1PL3KtbFsf
	 MfoEVvITyAG2QvQWHEilnUHYLPXwRngHez4c+r1No3zhpTdyK+K4SiP8THrwEscYBOo8F
	 OvxlG6TMdvnfJd12ibaXeeBiq+qutFaheHibn5Vm0eoQCncHPmuiuj9jLK1WVVIofJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6wTnULH75vJSwiwoODIMLxKb+zlMScOTEx4i9CMk/nc=;
	b=iZI8MvMsSRRzG2Y5goi0fzn2cy4jARQGCQ1+XVcJNaAbNeh337ykkHINtFXemhNr1IAV
	 xodXAeIDcMDcQwNfgD4Vu0fJa6xGiuig8+KmjaSg7kKVGkr9K7MrL1nJPkYvrHuV4gPMa
	 zS+gYzXbKeVv2UBPpoj0KEksLiihEyBJqZtzJHkE4ktZ3czQCEk7B3IezQCrDGO0GZwfJ
	 0D0CwzMe6yS2rVgRAzsyv53AhND3c6+kyu/F/FaNr2pnZmem8pStdzzgPQ9zSMSrGZq58
	 7MP6G9iWnfIPKy+oxVqpOJ2wMXSOLfXhus3WjXQoqfm34T3kZn7uXi1COBd1Qy83zug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k+FCSUCv;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D58606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49D58606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k+FCSUCv
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b5786e099cso4621043c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795635520; x=1796240320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6wTnULH75vJSwiwoODIMLxKb+zlMScOTEx4i9CMk/nc=;
        b=k+FCSUCvDpX4i/W8kPyZVk3YdLizmtnxCmt94XBilrEbAtxCeVAY0AZqZt4CSnwLLi
         NFh9VxBs4haSQhz5kcrOua4Gbeu0Fk3cMgDmu9kMFJqpNA48JBcEFTy8O73hnL6dfM6X
         FXct+cBNtBbtY/8mha1f9bwXKySLUk6pgCUC359CSmkyDlqo5vVrYk5aSZJw2dJLFaRx
         /OZrrv2nu8YQZXVG8G99mW7fiyQS6Ok6WD7UhGvNilS6uH9V2AgOx71VikZtni7Ql6gD
         IeF6TVXz42LTK9s6NEGpIytWKWuoZxFZiJz34oX1uKgyfotGNoEpmEGdegbv8n17iUrd
         scpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635520; x=1796240320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6wTnULH75vJSwiwoODIMLxKb+zlMScOTEx4i9CMk/nc=;
        b=HIZ8sl9yQvZeW7PSV9iJi1KB/baDvjS1xXGidMzJiFpU9Rl9ZjrfVutkNW4BhDDy2P
         Orch03Yj0WHJrHlSdkZbo8YZwR2iGNeX2uRnLdRdN/CGeIDGJwPgyqGK1YYB0E+7KLl1
         JTpvXwMCorNzAarRddHDtPuDZZtRgUtxbOXKkj+OGzHfXY4DNPqa0HOjVxcRGLvGyqDO
         TH0A7kLC17jqwEXVpd31nUmITctBhxTZj4jW4dJQ39B0yoIKhXGvptld7XpU23Vlne2z
         OLCczoKxNvo635p/mF7wLfLhMQLk09u2Q/zf7Yu9t50V0qCfUTK3mbGzs5LjA+yOpxmy
         /ScA==
X-Forwarded-Encrypted: i=1; AL+hErFFfhx3NFy0TRpdkzAXXw2opLJ08RYBRCktCU2gA18w+YlqPH7bqNj7pjyq1P8g/RIKOWZgsck=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1lYhc9Ceux5IFoIxr8F/NB4trNlckMHRalf4vANF2OqHXGs7q
	Lt9fCPT/Wv6IuBkJk2R9Rbbh9VRY09eYQDOoGNZR2ATYMkuFQL0aNPtj
X-Gm-Gg: AZFdTZcGOOePzJ41WDbqrraOa5SWjkBuunVUNyKv8zhpxDZwDzR2hHN1/geSbt89xVQ
	bpsfCRr8jBIn5c8z+aUIaxd95YgB9kGLQ+qLcbGiInE+ulqSiCoJAvW/gYOOk/NiFt49x8KPYoz
	s0/J3Q170Pj/6K1rFNEVj/uNpNS5OAiJTQDmlj+IiR0EJUOdCvw13rbOfUIeiCM9iGzL8JnFTIa
	DSYxiByz2tDhzZab2CrDO/agFrAfeEKrjz/RWbMjM98xLxosn65EL1M/coMnfIJoCm3AJEfIhUF
	Wo74l4BlPJ3NyZSkNX6NO92kFHUaX3mDJk6D0kJ/jWExZQsKeogxSQeYDc38O+o8z+yeyZq+quL
	+zPkOuD1vKVHyENAzL8G+d/7amI0eEOF4fMgDbbxzT3nmHFQBnUPN3PxTNjDd29ekr4cClhf7Xi
	1usUcQn89oQpndvNRPZuuhGFHY02uZMJZ5R7pGvdqAgx2XR5bLqYWQdJ3QIUKaYtK+7ukzcxl0l
	L05ZueWXnUIE9fUuyyy/3CH+1zPWYZTiu9gXOSKlQi/S17SmYnXDGTWvJxZG2OepbZ5djrG3tjk
	1BqOTbQV6LK+5LXiTOs698kJ0vAySvNbV31KqvdyN3dhVY+qtufJGoivf8EWwJ3S6g8=
X-Received: by 2002:a05:7022:170d:b0:1b5:1c22:6fea with SMTP id a92af1059eb24-1b5566a60efmr17005635c88.0.1795635520254;
        Wed, 25 Nov 2026 11:38:40 -0800 (PST)
Received: from localhost.localdomain (wood.seclab.cs.ucsb.edu. [128.111.49.37])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm50810012c88.5.2026.11.25.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:38:39 -0800 (PST)
From: Praneeth Balasubramanian <praneethb2002@gmail.com>
To: Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Praneeth Balasubramanian <praneeth@ucsb.edu>,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: iscsi_tcp: Take sk_callback_lock in the recv work
Date: Wed, 25 Nov 2026 11:38:26 -0800
Message-Id: <20261125193826.3466197-1-praneethb2002@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4fc02402-4ab3-42d0-8dbf-d0a36a125e43@oracle.com>
References: <4fc02402-4ab3-42d0-8dbf-d0a36a125e43@oracle.com>
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

From: Praneeth Balasubramanian <praneeth@ucsb.edu>

With recv_from_iscsi_q=1, iscsi_sw_tcp_data_ready() queues
conn->recvwork, and iscsi_sw_tcp_recv_data_work() runs the receive path
under lock_sock() only. The data_ready path runs it under
read_lock_bh(&sk->sk_callback_lock) and returns early when sk_user_data
is NULL. The work does neither, and that causes two problems.

First, on teardown, iscsi_sw_tcp_release_conn() calls
iscsi_sw_tcp_conn_restore_callbacks(), which clears sk->sk_user_data,
and only then flushes recvwork in iscsi_suspend_rx(). Work that runs in
between processes a socket whose callbacks were already restored. If
the socket is in TCP_CLOSE or TCP_CLOSE_WAIT, iscsi_sw_sk_state_check()
then dereferences NULL->session. With a delay added at the start of the
work to widen this window, a target-side connection close gives:

  Oops: general protection fault, probably for non-canonical address ...
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  Workqueue: iscsi_q_3 iscsi_sw_tcp_recv_data_work
  RIP: 0010:iscsi_sw_tcp_recv_data+0x219/0x420

Second, the receive path was written to run with BHs disabled. For
example, __iscsi_complete_pdu() takes session->frwd_lock with
spin_lock(), and iscsi_check_transport_timeouts() takes the same lock
from a timer. From the work, BHs are enabled. With lockdep, an
unmodified kernel booted with recv_from_iscsi_q=1 reports as soon as
reads run:

  WARNING: inconsistent lock state
  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
  kworker/u10:2/55 [HC0[0]:SC0[0]:HE1:SE1] takes:
  (&session->frwd_lock){+.?.}-{3:3}, at: __iscsi_complete_pdu+0x4f7/0x2420
  {IN-SOFTIRQ-W} state was registered at:
    _raw_spin_lock+0x2e/0x40
    iscsi_check_transport_timeouts+0x4c/0x5d0
    call_timer_fn+0x19f/0x630
  ...
   *** DEADLOCK ***

Take sk_callback_lock with read_lock_bh() in the recv work, as
iscsi_sw_tcp_data_ready() does. The receive path then runs with BHs
disabled, as it does from softirq, and is skipped once sk_user_data has
been cleared.

The unlocked sk_user_data read was found with an LLM-based tool that
checks callers against the locking rules stated in kernel comments.

Fixes: f1d269765ee2 ("scsi: iscsi: Run recv path from workqueue")
Suggested-by: Mike Christie <michael.christie@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: Praneeth Balasubramanian <praneeth@ucsb.edu>
---

Notes:
    v2:
    - Take sk_callback_lock in the recv work and skip the receive path once
      sk_user_data is NULL, as Mike Christie suggested. v1 passed conn
      into iscsi_sw_sk_state_check() instead. That avoided the NULL
      dereference but still let the work run after the callbacks were
      restored.
    - I went with taking the lock rather than calling iscsi_suspend_rx()
      before restoring the callbacks. Taking it with read_lock_bh() also
      fixes the frwd_lock report above, which reordering the teardown alone
      would not.
    v1 and review: https://lore.kernel.org/all/4fc02402-4ab3-42d0-8dbf-d0a36a125e43@oracle.com/
    
    This was found by an LLM-based static analysis (GPT-5.6) that checks
    kernel code against the rules stated in its comments, as part of
    research at UCSB SecLab. The patch and changelog were drafted with
    Claude Opus 5.5. I reviewed the patch and take responsibility for it.
    
    Testing: two QEMU VMs on next-20261023 with KASAN and lockdep, an LIO
    target and an open-iscsi initiator booted with
    iscsi_tcp.recv_from_iscsi_q=1, using CHAP and continuous reads.
    
    - The teardown race: both initiator kernels had a 20 ms msleep() added
      at the start of iscsi_sw_tcp_recv_data_work(), and the TCP connection
      was closed from the target side. The unpatched kernel oopsed as
      above. The patched kernel ran three times with no oops and no lockdep
      report. In one run, a test-only print showed the work reaching the
      new check after the callbacks were restored, with the socket in
      TCP_CLOSE, and skipping the receive path. The race needs the delay to
      hit reliably.
    - The frwd_lock report: it appeared in all 10 unpatched runs in this
      mode, including runs without the delay, and in none of the patched
      runs.
    
    The patch applies to mainline 9ba46df34488 and to next-20261116.

 drivers/scsi/iscsi_tcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 9260b1c9b0e0..6d802b84f7ad 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -160,7 +160,15 @@ static void iscsi_sw_tcp_recv_data_work(struct work_struct *work)
 	struct sock *sk = tcp_sw_conn->sock->sk;
 
 	lock_sock(sk);
-	iscsi_sw_tcp_recv_data(conn);
+	/*
+	 * Teardown clears sk_user_data under sk_callback_lock before it
+	 * flushes this work. Take the lock like iscsi_sw_tcp_data_ready()
+	 * so the recv path never runs after the callbacks are restored.
+	 */
+	read_lock_bh(&sk->sk_callback_lock);
+	if (sk->sk_user_data)
+		iscsi_sw_tcp_recv_data(conn);
+	read_unlock_bh(&sk->sk_callback_lock);
 	release_sock(sk);
 }
 
-- 
2.25.1

