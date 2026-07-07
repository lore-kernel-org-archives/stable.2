Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE1436BF7
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443569; cv=none; b=jGGiD97u3zeaxNWySkvLB4dIAfgueDmVwr6ErZpnsnRyPU9yP5R9z7JtDDQJ9Cw1QPzNLHYgLyTc5evWc6Tt2OIcYgXBmSG3W1eIi4a8AMF+L7Gi2P49O/px2BH7o4GqJLY1MdXoxNiw2seoRXs7XhEAUdQVwJlqhcfRDhro8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443569; c=relaxed/simple;
	bh=nUUN0xPWz7q2RyvUCKORU7VqMpHCgFB281JF3872N24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqtmqURerrNmJp1BB69NWZ74jQFCh8qAB5TnA4P3vnc0vHFtmdEY0D5xYWGPJk4N71Er8QsLoJvaOeIwJDINuIAPT7Ur6qBEEOGRSlJDLWLttfSHTXPVl9d9c/7KwenfmVSv+ZHt+dJilI3pJPnFwz63+SZMrU+WBC41V5muYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuBZQp97; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuBZQp97"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-920f33347f5so219169185a.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443566; x=1784048366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXrrKa9i86QRbnd8WzAz8n5WCs4Qj9PVK9gVjYwwX4I=;
        b=XuBZQp97fCN21qhSYUd3Ikv/WqP/EV4C4Scjrzwt7OV48cLuevXOAtcgJBThJ4bRIZ
         WWMdxtMXInMfkUTh2hn1Ek2H5eS28NVADBgcNxIpIUXUDGF+hHIrnGVnkJ85kcFV+M1Z
         Mie120JmQcfY+a+0iaxBsrE8RC07ijoYKXLRw5swfoKtB4902Y3TXw/1d/PHINg1wx0I
         dL9KFWe77GGbiwdC04Dd+ZouxbbusTJ3Q5kC3ohK+JsmowZxiU3gJzompLQQCX97Igrt
         R1RVzy6Gtg1UmJ+ec1QB4J9LedOl9GFbDn7+XVfdpqP5Nn+T9BW7rYgzSlBOmZDfyUTt
         1LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443566; x=1784048366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXrrKa9i86QRbnd8WzAz8n5WCs4Qj9PVK9gVjYwwX4I=;
        b=pgD6mDol2nXBC+vIA7l8KFOmShq7DNDsSnLYRncyu8vkyOKqu1f2U3cp+0D2lUSG7k
         g+BeWZ+7cYcVS6B9E/YIsPeU2CHNYf19Q0ANR8jM7yr3DgW6MqJyawrar4sR3YAP/x5E
         z+WRA/TE6WDInVi95H4R/pjkoyLkHzdJbzL+F4eidH/pxsdG/73nXnkBx5Pt9ELg72pM
         OViUto7YWJo7GxUTvytpXuGi1U+Zc7FzkIVZhUhld0AERJ09y/4wxZN4eXjoQoU8btdr
         AzpPAOmFJJEJnqsoSknAIHI93dxi0U8lEIq6GC5EOOsPT2I6MhK6iOcoEEBBuR1opOjt
         nafQ==
X-Forwarded-Encrypted: i=1; AHgh+RofvG+4eVWCvvgoq4k1fFOVdfDucPT59t623QPP790HcevfvR5ysngxoBQ48gvwyD+ueBdP3rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSk4vtkwc+w4kg1/t9bEKlodRlphc+jG3AQjvmJoMJHsXZhkP5
	KL2/l4lWJx9UsHZ1xzRnVrABTTxckYoyxmIueQaeMt2PcMnxKp8ptpiJ
X-Gm-Gg: AfdE7cmQF2G3USLr6CyHqwXKcHJ8OoIFPryty4ZgZcIfiBh9nhT5+7t4QEv3Ta5Fik8
	Z674DidDqP9fexJwgklCNLPWJwlCiRkGdG6ww9MBLmw4o8GIk6teKeksaAHQOVfazoA4ebrammi
	b+6E8rMm6IzdvtJ2os2p6g6vDtrOtljjKjeR7/t0VSfItmFVl6VmxIfd0Lpaym7M5+g+/KMsuId
	GFOAUOcSO5MO0Vl2ZKGJCHnyPSGrc3Iaq15z8Hr8EuyNkh0nMh6v2V953lM3qTDpjCoGRt0X+ba
	nEpxxBeuLYQcsI3piiriZolIvONKOoYqR6lYDesMSOFUElzig0TymJM5LX/j5gY0uSHbnfkcKh5
	6wfNrDWca6uykFhiJw2HCom3tm9RNAyGyhzRdIGYjiCyrthrdckz9uLKa88LUe2EIrnyT3ppDxP
	IN9KAcgSBFjnSW+T6pOYTPBSensi7A06Wrw4v5rugFXYSSQojgvU6mcYaoO3+8Aw9rSDLQYjM+F
	pkROq08kAhu9Ue+ZysYkkhQwzHNsGIw
X-Received: by 2002:a05:620a:2711:b0:927:25f5:ee08 with SMTP id af79cd13be357-92ebb5d59e8mr731266985a.43.1783443566238;
        Tue, 07 Jul 2026 09:59:26 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bb91adsm1209145385a.20.2026.07.07.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:59:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	XIAO WU <xiaowu.417@qq.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] tracing/user_events: fix use-after-free in user_event_mm_dup()
Date: Tue,  7 Jul 2026 12:59:10 -0400
Message-ID: <20260707165912.2560537-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This replaces the earlier single patch "tracing/user_events: fix
use-after-free of enabler in user_event_mm_dup()" that is in the tracing
for-linus branch; Steven agreed to drop that one and take this instead.

user_event_enabler_destroy() removes an enabler from the mm enabler list
that user_event_mm_dup() walks locklessly under rcu_read_lock() during
fork(), then drops the enabler's event reference and frees the enabler
without waiting for a grace period. A concurrent fork() walker can
therefore both dereference the freed enabler and take a reference on a
user_event that the put has already freed -- two use-after-frees, one on
the enabler and one on the user_event. The enabler use-after-free was
found first; XIAO WU then reported the user_event one, with a PoC and a
KASAN slab-use-after-free (write) in user_event_mm_dup(), and the
enabler-only fix did not address it.

Patch 1 holds both the enabler and its event reference until an RCU grace
period has elapsed, by deferring the put and the free to a work item
queued with queue_rcu_work(). The approach was suggested by Beau
Belgrave; it supersedes the enabler-only fix.

Patch 2 adjusts two user_events selftests that assumed the event is torn
down the instant an unregister returns; with the deferred put, DIAG_IOCSDEL
can briefly return -EBUSY, so they now wait for the delete to take effect.

Verified under KASAN on x86-64: the race faults on the unpatched kernel
(and panics with kasan.fault=panic), a benign serialized control is clean,
and the patched kernel is clean across repeated runs. The user_events
selftests pass on both kernels with patch 2 applied.

Michael Bommarito (2):
  tracing/user_events: fix use-after-free in user_event_mm_dup()
  selftests/user_events: wait for deferred event teardown after
    unregister

 kernel/trace/trace_events_user.c              | 39 +++++++++++++++----
 .../testing/selftests/user_events/abi_test.c  | 24 +++++++++++-
 .../testing/selftests/user_events/perf_test.c | 26 +++++++++++--
 3 files changed, 78 insertions(+), 11 deletions(-)


base-commit: f24ca6729076623c9a0547ecc71e4fc1c4b65c3c
-- 
2.53.0

