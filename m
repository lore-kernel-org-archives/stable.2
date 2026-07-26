Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A4D24293C
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077989; cv=none; b=AlgjsImogHhdAI93dxblGbN+Pi4z0/3VXa4X/o35kLUGQkuxIVBSSGDHGuaK/suaQH+vEJxzxb3h1BEVbO3wnAVFfW/jLSg1T5MsbkEFm3cPTMb6qdhJS2sXe5ZVnFOxkA8JlDg4oV7TP9q/p8BnyA0nrhTdIGDSFjewx6m7WbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077989; c=relaxed/simple;
	bh=Z81Et9KQCb4svrySw3fAoBZgNyI7CjfEO+k/cqzuXbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgoroQuYAEQZWNVGiOI0KAw24yaLc/U1sPVC2ISLllOBL28MljqQ4Qx2Wi48IxgSiMMkfl06Eb85aJAQjcauPVivihQ6vsSOEZX/Pwe2uVEQpTq2c8yrg1rf1gOuL3LvvskMOD4EPHPi/8ikuPlQhAu93KMtBPtCSlm5nIYkoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=qWkDcwVY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="qWkDcwVY"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1987214b3a.2
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785077988; x=1785682788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FGDMCesZy1ft/61eesd79fseURXoeAeKC+nY8ZObiXg=;
        b=qWkDcwVYxTebIGWv7nPVUF4tEebuW+FWpoS46jnG+vEkA+r8UaSUjEXf+OKVaumf8U
         Up4L7YaeaCUXmHsUVIMlznxxykDArAUPbzdmcacr7fgOO5cLrEicjol1aZNKOyxz8J2W
         Fpm9+1zx1KN//2aTt+5clTBjwmkidGrnX92xei5jOhZ3K98y+DCmMr3+dzj98/lXHyaP
         k9XWT66Y3S//4LdUKiUEh/Js/rcs5hbO7nqzHbgmt6RNjKQ/YLpUhE8wd7/HCR1vogBW
         eLLaeh4UhDiKK9dy5dED7IqTgeuvqQeab2m3aqkkuyzVnxHR2bu4JR2gjwidteR70M8B
         b5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785077988; x=1785682788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FGDMCesZy1ft/61eesd79fseURXoeAeKC+nY8ZObiXg=;
        b=oWYU92+tj1TmBEbXTY2nUbwOW70wqe06Xjei39URhEKJDiBcXbZLfcJ9achlFGGuBF
         Oek1OVmLvKEcsGwL1WEvNJqcCQBhNwbmhtyB1BJezhJsvJoKpBb+rCnerX6M2nabVCmR
         PEwU73leRTC2smK+6KdSTuvji/K6Epruiigb5cgcYDv1WF7+NlMcMoPJCBxWFdZGfw5s
         O5jgWmxMDd5Mef4hJ/fuAFdKObMGr63QH4tNXm5I8O8tzgwUGIWnEzLnnyfhYtqW8SO9
         kxbHXjQI9SJc0Gow5aFCFLYEYb7KTkUqNEQwVZUlHs+UFbfJ3R2UNWZd0WkhSJejoue2
         cWXg==
X-Forwarded-Encrypted: i=1; AHgh+RrD5D+1DtXAdYPzaEAT+wWn4vrGXpyW9+ERhP+6EH5gEuw589q4ZLnYOeJ9ufa6N2Jq0QiKKlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPKCdZgQ976TNVoEwT1ht6TTTXyTxWCTAhTCBJQIyo/K9foHJo
	P0uziydnTNkPnf0F+vSioAJ4VkxeCl8UJwTlI2YL/Cis4FxDU9S7ewzQd74yi29YPqs=
X-Gm-Gg: AR+sD101C1ot9M1b0RPG/NKr3nC+c5Ak/JkmjeZQCXeMjHoece2docK3o76qJvFZfcH
	CfQV5hex+cfB+5pWnTB1TYte9D7o6cpSnngTkOQ45tpnn5b/Hslmmk8SoDRU3/7/Z0TqOOIthNF
	vKUJFNLqaTK75AvMgVosChYzHqyUcSkWUf2hSz2CPyMmDmlPGvgTqJEcpeJzGDQYoegqXW9Qcm6
	H0gLTkv+FsOOmr9Jo3LPqI6WgTsQJ7GGXcSuQOWTsJVGguJC524FNgHuIbEpMpKHeKrl2oP3Z6h
	Z8DvGiQJx7PXBQCmM+rmjS/xGy8duj9IeoL893gnN+hQ2cd9IcoKOZ6iRdQIANKbcY4ky20Gwu2
	MacHQbWAecFNe8bZjmgoVNbybIPUQ1GZtovpKIjL75j9NDFoloUjp3C/+DoJD6lCWcm0rXWiJKo
	RyD/vH0941ei+ngp6RQin2qL9p
X-Received: by 2002:a05:6a00:6c95:b0:84a:2ec8:fac1 with SMTP id d2e1a72fcca58-84e595d8845mr4345226b3a.72.1785077987788;
        Sun, 26 Jul 2026 07:59:47 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:be9c:ea6b:29a7:6c78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5341d68asm1894803b3a.46.2026.07.26.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 07:59:46 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: michael.christie@oracle.com
Cc: martin.petersen@oracle.com,
	ddiss@suse.de,
	target-devel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v2] scsi: target: Fix NULL se_tpg dereference in target_complete()
Date: Sun, 26 Jul 2026 23:59:34 +0900
Message-ID: <20260726145934.933618-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <79ceea04-7fe3-48b2-91bc-48b208f10229@oracle.com>
References: <79ceea04-7fe3-48b2-91bc-48b208f10229@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 7/26/26 5:44 AM, Mike Christie wrote:
> I think we need to figure out how we got into this situation because we
> can't free the session while it's still in use.

You were right to ask.  The session is not being freed - it has not
finished being set up, and this patch is aimed at the wrong place.  I am
withdrawing it.

I instrumented transport_deregister_session() and
__transport_register_session() with a silent ring keyed on the
se_session pointer, and printed only from the cold NULL branch.  In a
login-churn workload that build recorded nine hits, and every one says
the same thing: the se_session had never passed
transport_deregister_session(); it had a matching
__transport_register_session() record; ktime_get_ns() taken at the read,
before any printk, is earlier than the timestamp taken at the top of
__transport_register_session() in every case; and conn->conn_state was
TARG_CONN_STATE_LOGGED_IN every time.

The window is in login, not teardown.  isert_put_login_tx() posts the
full-feature receive buffers and then sends the final Login Response;
iscsi_post_login_handler(), which calls __transport_register_session(),
only runs after that.  An initiator that sends a command as soon as it
sees the Login Response gets it received and completed against a session
whose se_tpg is still NULL.  The command reaches the backend because
transport_lookup_cmd_lun() does not need se_tpg on the mapped-LUN path -
it uses se_sess->se_node_acl, which iscsit sets much earlier in
iscsi_target_locate_portal().

iscsit's own RX thread is not exposed to this: it waits on
conn->rx_login_comp, which is completed at the end of
iscsi_post_login_handler(), after registration.  isert takes its PDUs
from the completion queue instead, and isert_recv_done() has no
connection-state check.

So the commit message on this patch is wrong.  It describes a
deregistration window that none of the nine observations involved.  I
described a mechanism I had not measured, and I will not do that again.

Guarding target_complete() is also the wrong shape.  In the same window
transport_lookup_cmd_lun() dereferences se_sess->se_tpg on the
virtual-LUN-0 fallback, so a command arriving before registration for an
unmapped LUN would fault there instead.

I have posted the isert fix to linux-rdma:

  Message-ID: <20260726144213.933544-1-yhlee@isslab.korea.ac.kr>
  https://lore.kernel.org/linux-rdma/20260726144213.933544-1-yhlee@isslab.korea.ac.kr/

It moves the isert_post_recvm() call into isert_get_rx_pdu(), which
iscsi_target_rx_thread() invokes after the same rx_login_comp wait, so
the buffers only become available once the session is registered.
Unpatched 9 of 10 runs oops, patched 0 of 10, run alternately in a
single session under KASAN with soft-RoCE.

Please drop this patch.

Best regards,
