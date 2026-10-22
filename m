Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660157;
	b=zc5YikMjr9MvoXXgajnxc07AHXYpZQZxj9w6ERrwqWJJmm/houXybyZ9S64MHUdy/h//
	 w2lBQ9KDvvx50uXQsI5rcutaoLWFPXn/pV/kz/lcwqzvNBXVj4ShOISH/mecVuGM5UmrT
	 PVTnwtpXvdcvnFsd4nsT9IzrSGHzVfsv2qKv2s1VRhnVbO7xZAkP2VlVkx/EidjzkSJON
	 d1LwdSi1GsMj6i6iMR3nT+cOvN39m+2YhXkKExe2KBIGrH6RrK2YqHJaU+Kf+XZDU7leM
	 G2X74M7nMtjTZwkbOGerAci4l9tRHe7SP5F11I+XJBpjRhHlZ2Sq6mPrp3IVrkH312w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lFKRiSem7YLaN/MRPmgMwVevdlnMfUBDEjFcSaNLdvc=;
	b=mr4/jxjRjnRPb1/q4Azh1sZI0NXj6gB6FGjQ6WBGlyQUJ9yW1H+hK3Rkjf2yIYdHIySM
	 aBhA3Qz533bfr6QjCwlpL1+7+jbbnJhcYQUW33ANvce3SRnqqjij5VHsTcweEZk8lcU6/
	 +5lg4Aol67DlrgGt8PMVCQlEddQzcRI00MLn8Qg+9asv0+iAhI/RrJyz1jt9sK6KO3Pr+
	 c8vzou+Tk1G/CL0yZg08QlawcHsOHHZez2IcPTzw8RXKyruAmZ2e5oQAPCgZzYN8k1EWC
	 T8EmQZVdZsYPiGc+rx13iIF+MxktsuBkRwRK09giEObQAfp3lLh2FVJlbkMko/9m6hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HHWowCId;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A73606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A73606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HHWowCId
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1435808a91.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660157; x=1793264957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lFKRiSem7YLaN/MRPmgMwVevdlnMfUBDEjFcSaNLdvc=;
        b=HHWowCIdQ/KaURB5tsdDq7pFAsBgsLRT1B7zfzgXtatXqIkh8OK5/Yte5Pn5g1YUF4
         HwUqPc+eQOpICFOe7hdxe3oVR0KIIgOAHVZYFv+qRTzpz9DdjBHLPcIHu3UnnEKe7pXN
         NIWVjfDZx2hNVH7+Z2UEr+vtoheeQG2IYWrpDKKR2j44Ll6BwfIqlKOmtDKY8xKR5Vb0
         lFU0juowmzC+N2PLl6FtgDg0KJnaxughBdraa3V3eiuRdKpF8mC9J7Qor4aKmot/ooOL
         NVIslYVMSJZJdwK9QMpLyNqzd9Z6ESANo89kuGQDBFDlLh+CnKS/mGSA3EEgyHJIXzrx
         0h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660157; x=1793264957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFKRiSem7YLaN/MRPmgMwVevdlnMfUBDEjFcSaNLdvc=;
        b=qlTz35Msqt4JRNMGoHbx8JM6nd+YPMD+99kP9CNkcJYgCv8eURakIlWssrclHVo/2K
         7ASFlruGjGq14Y435kmuZUlU4ykt9DTuz81iNSjNhADASCTfKl1MxttucHUhaePLPrap
         TllY5FekXFaXRGWCxJisyVPuQDq+R/zwLLFc3vIieEUGjeIoa54AE8gLeABzwzzgQdCY
         n2qmpTEkOq9ljTBUFZwb3O1N2fcNKwg4sr8tq9h/seq8tA83eKiIIJcfAQT3eEeNQrn4
         tq+LXGr6icgdqPkSl5sIkKtf4LMpRaj3fFl7WCn5bEQ2JrN9a+pgCCgNY3I6W+Q/zQuH
         eIQw==
X-Forwarded-Encrypted: i=1; AKwUvBwDawt26QDAPFfA2Hd3COv1iTuUtIxdSH8fWPC+5PTQr6cMMsbK1pXAAB5cSadjdqnFH2CFb8k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlEYW1WRChmMyvSaEzUjWNqZI2cojVcesoSqK49c+hPmkFr5os
	tn6WHk2a03NmNfmrXEOw6JMXmnOMXCowwGzWUkLlmO3rdji/V78gpGT1
X-Gm-Gg: AYBFou0UNI/+PKhdBnaDnt8j5joq9urINLMPwAE54DrxZNSLXsn7ZqEqxUziKrQa3JN
	uJ5s9eH4lHykXkTR5KtnmVVu1VUH9gSXGA78kFB7bL5Vo+2ALWGbhHH2NGWK0HF6iI57qQEQra9
	aMpbPxV/keSu1BAhmNVO91BZ7QlHHqFtg9z22+0ng8bHzDB7/RD38EowdXGVUOjmL1GLJtDtUt5
	ctcCZU781upFsfv9CVzH2oiz9q6+OD0ABnLcMW9BfvxGHT7nDTy3f3ZNPrx8zduBFmd0582gj5F
	hf745yEFaXz4H/okjAA9wKgmzyDdJZkXTArx1YHpU5q6sgqx8s6bWLagmAn+RZTEq6Ygj4+tPPD
	HUrYgEkYyp5+K5wPufFZXZVkVkDRPKmUKCCFrwSa0KL2TCKhAhm6HRTbDq/MSdMYcSGBk3DD6V2
	LTfvZ2BmedNuHxKsCT4UIpbVHUa03FDiyjjiHWXe7TfWGY3Upf9HyJY8B2/Ujn5/QAF2zJyBmIa
	hrTf1JZPXhRMJsboUw9HcRjvuHZ/iRdc9FeiyAX/tvSEoTf71E=
X-Received: by 2002:a17:90b:5788:b0:3ac:74b3:a8f3 with SMTP id 98e67ed59e1d1-3ad86f43374mr3719443a91.44.1792660156804;
        Thu, 22 Oct 2026 02:09:16 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48a573fsm3460469a91.10.2026.10.22.02.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:09:16 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] ocfs2/dlm: drain join handlers before releasing module text
Date: Thu, 22 Oct 2026 17:09:10 +0800
Message-Id: <pm-ocfs2-objects-candidate-0076-v6-12de5f4628f57fba3be3@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The code for a registered DLM handler must remain resident until its
last invocation finishes. dlm_unregister_net_handlers() only removes
dlm_join_handlers from the o2net registry. o2net_handler_get() takes a
kref on the wrapper, but that reference does not pin ocfs2_dlm text.
o2net_process_message() calls nh_func after dropping o2net_handler_lock.

With CONFIG_OCFS2_FS_O2CB=m, ocfs2_dlm can be loaded independently of
ocfs2_stack_o2cb while nodemanager continues handling messages from a
configured, heartbeating peer. If no dependent module or module reference
prevents normal unload, the following ordering is possible:

  Receive worker                       Module unload
  --------------                       -------------
  o2net_handler_get()
    take wrapper kref
    drop handler lock
  <preempted>
                                       dlm_exit()
                                         unregister handlers
                                       release DLM module text
  call saved nh_func
    in released module text

Use o2net_unregister_and_flush_handler_list() in the shared DLM
unregister helper. It first prevents new lookups, then waits for the
ordered o2net workqueue to drain, including a concurrent destruction of
that queue. The acquired invocation therefore finishes before dlm_exit()
returns and the loader releases the callback code. The same helper
covers partial registration and dlm_init() error unwind before module
memory is released.

Skip the drain when the private join-handler list is empty. Early
dlm_init() failures can reach this helper before any handler has been
published. Partial-registration failure also reaches it a second time
after the first call has already unregistered and drained the list.
Neither case needs to take o2net_wq_mutex or drain unrelated work.
The list is changed only by serialized module init/exit paths; a
nonempty list still uses the full unregister-and-flush helper.

Oops report as below:

    Oops: int3: 0000 [#1] SMP KASAN NOPTI
    CPU: 2 UID: 0 PID: 54 Comm: kworker/u16:3 Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy)

Hardware identification omitted.

    Workqueue: o2net o2net_rx_until_empty [ocfs2_nodemanager]
    RIP: 0010:0xffffffffc0423871
    [Instruction byte dump omitted.]

Register dump omitted.

    Call Trace:
     <TASK>
     ? o2net_rx_until_empty+0x19b1/0x3300 [ocfs2_nodemanager]
     ? __pfx_o2net_rx_until_empty+0x10/0x10 [ocfs2_nodemanager]
     ? lock_acquire+0x190/0x300
     ? process_one_work+0x935/0x1b40
     ? process_one_work+0x834/0x1b40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? process_one_work+0x9a8/0x1b40
     ? __pfx_process_one_work+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? worker_thread+0x65c/0xe40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x177/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_worker_thread+0x10/0x10
     ? kthread+0x351/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ? ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf70
     ? __pfx_kthread+0x10/0x10
     ? ret_from_fork_asm+0x1a/0x30
     </TASK>
    Modules linked in: ocfs2_nodemanager [last unloaded: ocfs2_dlm]
    ---[ end trace 0000000000000000 ]---

Fixes: 6714d8e86bf4 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: <stable@vger.kernel.org>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM
---
Changes in v2:
- Skip unregister-and-flush when the private join-handler list is empty,
  covering early dlm_init failures and the second cleanup after
  partial-registration unwind.
- Retain the full unregister-and-flush helper for every nonempty list; do
  not change the generic o2net helper.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0076-v5-dd198d8a9358ad81f70e@gmail.com

 fs/ocfs2/dlm/dlmdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 97bb9400e24b..a7dc3da6dfc7 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -2215,7 +2215,8 @@ static LIST_HEAD(dlm_join_handlers);
 
 static void dlm_unregister_net_handlers(void)
 {
-	o2net_unregister_handler_list(&dlm_join_handlers);
+	if (!list_empty(&dlm_join_handlers))
+		o2net_unregister_and_flush_handler_list(&dlm_join_handlers);
 }
 
 static int dlm_register_net_handlers(void)
