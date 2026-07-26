Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5F1A5B8A
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785079903; cv=none; b=F1wj1HS7eVihYYIS36feev1/c9VOYj4seZy+k2zdLGqmfrLaoOegkbFw9h6PsHeObIAnX3T2AHU2vQOshBJyEk9pYRiyKpu+anZoZjL1E6bvVGadbxwGeUWWGJQ0snSl9Cb8uxPlZegWLD49fnGkz7/F1AuhROykPfq1rMWaejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785079903; c=relaxed/simple;
	bh=c7Pma2i2/+N0DV+POQ+i7P+HjseyUAHIKJYjDdV80zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYOXmH8NX2J8zh07APfch3ftf42LtFVIx0u2SIS8HzGCqcTrn9sxIj4Cyo1o93YY8C5frh/zc632Wh8nx9nhtQ/i8P7LhD6ktPidvvij3y22EXKFqFZRlxekB8IVyIj7z9u8a9NLHiVrveMzZIZQ3QbpmNFSfKNnmmKWbwyh78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=rKiEsjWh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="rKiEsjWh"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1340664b3a.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785079901; x=1785684701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WCyiXiL6v90bExJpgxX0aqjtKCXo1CaNitEii2ppwEM=;
        b=rKiEsjWhnzzAqJLL7OCDGduoudqQ/5GIclJJXbPVLYgTbSGFI2l56Cd2Cv4F0gqGgU
         HZbJ/0UtFmm73THsKxsmzU3cIqaORXSHxg4LlzjFRKJkRjb0qQ0UJxZBybiIe+UXIWBO
         QUSH9DzMvj+V94w3+ZX3T1epS9QlOhPf+35GQGdtG6Fj40Ow2ENXslrmHbDvzy6jlkqF
         39wBku8EqpNBr+aJC1IMMAhxLucvKKBhSO422a3/8KmH0iVwnvOyYEGTiQGn67ExbgX6
         hErEpKJSfSCL2vIXAwsks9nvoC0dPztAukBXZZgHwix3Y7uZPruj5xXxSQML6q+t74zA
         lVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785079901; x=1785684701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCyiXiL6v90bExJpgxX0aqjtKCXo1CaNitEii2ppwEM=;
        b=BxTDLULKu82i4ShxX+0b2ZaVOCVegWfIaxwj8L1wRpNrGNCi0CemJxfCGZ3s9s0PvB
         hVl2MsIn3ZhI8l8r2x/Lxi8CyLhLDdnOhqfbQ4kOI28elQxdGHA2xtOzN1U5dsDBoFiQ
         A5aP+5u8npq16bMvr3gdo1YOf+Yd9D7BI13Afj7Wc8KKKAip9jEFpTPgEzq0DQRqlC9r
         ge6DuFwqpHD42vATft9HxopFoutzUDm1acLlH/wVRA0xnZ5/aAXDRt4OEzbFCb09hdM5
         OZak94YRUEz/PjJ7Uv3poZ6Z4cabhyQe0rQ8Urf+FY4r0u1zgpsXeJ8G9vfAAzMrNacW
         aHcA==
X-Forwarded-Encrypted: i=1; AHgh+RqzIaOWrfXi2AL7y2a1hHFKqM1CrQ7s4gM/JCGhKVYA1vHodaStcxl9ROn1GycO/F7qtn4qhes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9N5dyID5crP3BszsLfZ36C8kRWLjh9tVS6tYK2tZH3PRtYQ3
	UKgqfJgM5oUz6q08w83+5jnW9bQQxfehdCXs3kzktUTAVu+TgyvQifEXLEbAXvSY0gs=
X-Gm-Gg: AR+sD12vgF6HaXDcmApIPjr1bK9UWlm27tNENt5QhRM0/zdLPZppK69nMUgQdS88s23
	AWd3VPspLZGsoiWAx77a4xV3AkdiaRz9FjYs76IaHMqR71lLKpsuud1/nHdqztZ0vsAoETIZAhG
	IyPQkEJOf7IZ0bCZCoKF/vs7AhqbIKRK2ZekfOWEuamnAoWhvn8OK2zRBYECEuA7wY915LuzlLt
	KTudEd1Z3QrMEoQ3/nAypv7SSueAXZilioQQ6y5n6tmdqJELvDLnO5llQZDKrKC1vha9r1smHcn
	QYgPMGb4g7O3tD0Cfb3zVxnyzkIN+7G5Nf9dsBxVvj8tM+9TN+n4DR8OeAR7kTfTVpdlRtL+61S
	dGwGe31GmYSViFNVfbEKl6UPdaj6RYfU302qVPrzVbmhgWPMGpWTxN+krVl9FtXUEg93k/r1kvL
	lMfVRzsAVD0bwBrquG88r5Psrq
X-Received: by 2002:a05:6a21:6004:b0:3c3:daa2:2b7 with SMTP id adf61e73a8af0-3c67df28fb2mr5230165637.44.1785079901080;
        Sun, 26 Jul 2026 08:31:41 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:be9c:ea6b:29a7:6c78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb6622461sm2088301a12.8.2026.07.26.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 08:31:40 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: leon@kernel.org
Cc: sagi@grimberg.me,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH] IB/isert: reject PDUs declaring more data than was received
Date: Mon, 27 Jul 2026 00:31:30 +0900
Message-ID: <20260726153130.934622-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726064628.GA12003@unreal>
References: <20260726064628.GA12003@unreal>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jul 26, 2026 at 09:46:28AM +0300, Leon Romanovsky wrote:
> 1. You should review patches generated by AI.
> 2. There is a need to add similar check to isert_get_login_rx() too.

You are right on both counts.  My changelog said the login handler
"already rejects PDUs shorter than ISER_HEADERS_LEN"; I confirmed that a
length check existed there and did not confirm that it was the same
check.  It is not - 29e7b925ae6d bounds login_req_len from below, and
nothing bounds the length the BHS declares.

I reproduced it before replying.  An initiator that sends a 105-byte
first login PDU while declaring 8193 in the BHS DataSegmentLength, on
7.2.0-rc4 with KASAN over soft-RoCE:

  BUG: KASAN: slab-out-of-bounds in kmemdup_nul+0x43/0x80
  Read of size 8193 at addr ffff8881056a8000 by task iscsi_np/167
   __asan_memcpy+0x23/0x60
   kmemdup_nul+0x43/0x80
   iscsi_target_locate_portal+0x48d/0x1180
   iscsi_target_login_thread+0x19a9/0x3350
  Allocated by task 167:
   __kmalloc_cache_noprof+0x158/0x370
   iscsi_target_login_thread+0x971/0x3350
  The buggy address belongs to the object at ffff8881056a8000
   which belongs to the cache kmalloc-8k of size 8192
  allocated 8192-byte region

faddr2line puts the allocation at iscsi_login_init_conn(),
iscsi_target_login.c:50 - login->req_buf = kzalloc(MAX_KEY_VALUE_PAIRS) -
and the read at iscsi_target_nego.c:1136, the kmemdup_nul() in
iscsi_target_locate_portal().  The read size tracks the declared value
exactly; 16384 gives "Read of size 16384", and a control run with a
correct DataSegmentLength produces no report.  It is reached before
authentication and the length is attacker-chosen.

On why isert is the one exposed: iscsi_target_check_login_request()
already rejects payload_length > MAX_KEY_VALUE_PAIRS, but it is only
called from iscsit_get_login_rx() and from cxgbit.  isert does not call
it.  iscsit over TCP is safe by construction in any case - it reads
exactly payload_length + padding from the socket, so the declared length
governs how much arrives rather than how much is copied out of an
already-filled buffer.

Your check is sufficient and not merely necessary: the posted login SGE
is ISER_RX_PAYLOAD_SIZE, so login_req_len cannot exceed
MAX_KEY_VALUE_PAIRS and size = min(login_req_len, MAX_KEY_VALUE_PAIRS)
is login_req_len; once dlength <= login_req_len the copy out stays
inside what was copied in.

I will send a v2 two-patch series - the isert_recv_done() check as 1/2
and this one as 2/2 with Suggested-by: Leon Romanovsky
<leonro@nvidia.com> - once the before/after on the login case is run.

Best regards,
