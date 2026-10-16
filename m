Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931439F188
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117220; cv=none; b=dnG8bqtm9nJPcvgeNEWWIZAmZ/WOQavhHODbgesJ6raBr2QznWtBrNlLsfNRjJNGqsFlXVpvEALTizQQfS0fFay0KrLzC3zfQtWwDm1LkmJAreB1U5XlA4Lfm442HtKNZUM+dqMn6+pGXhL4OX3kp5Nb2CuVKDDI71a54H/z9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117220; c=relaxed/simple;
	bh=xGfc8hkwQ1JzAZbx3cw8pks2pYJ+XRlDMgDsnChrvZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA/bYTqf/vEnkQgzjSMc+uSNM9oWEjHgQbpQ475HexC3S7F/m6nXfPoC4ehxK1jMfWVCoUeD0eBJ3u6URqDg62QNRRG+Hr9mYvAF2INZ+sQjqTGOGU/HDx+XgUmnVzVSoMxhEVfcHcOp0MQ+x3zc/NWYzfkm8sA6GLMZrK6XG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=AMxzgrU5; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="AMxzgrU5"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15ea896ddc8so3900033c88.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117218; x=1792722018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIkNKmu4tNSbGV5T07Rx97zRUQ3kfDdV0Kwy8SxGUtQ=;
        b=AMxzgrU5Um2cY/sdHPnv6OI9SVONYnMSqpBBKinHSCfhox+E/iZtlxxhozLbfziSmY
         VazFM2+ZGmbhDsWoqdzfAbd6nH6AY3GDYNbvKFACuz9Y5OJfhfjnTaVtnP8eig9/pMp/
         R/bI1Kh/Shw7ZMOdciMQ7SKN+5MzXleXuzsweSd2X6EEEJSj878iqVl6G1bue8yJH+X7
         /5sKwUQhzvhJr2uWyUK00hsw0KEjBpVg2RrrWm9EptllrmnVJxMc7XTlK9w6beSoEHQi
         1O2lkQGMTlzab1PmMTVnanfV7ORmTlP845sLOeN34HtdHyjByNwk3RjL4k7Vq7AHQLUA
         OWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117218; x=1792722018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIkNKmu4tNSbGV5T07Rx97zRUQ3kfDdV0Kwy8SxGUtQ=;
        b=dvrhcq1n/bgcknm2bBCtt+fEvDPMZVyr+DgeAQnq0miEuyAoSBH42f3RjoiQaE+qyy
         vqQxGgmOxSgvM7bpG/NrqZa/BERsiWiHn5NEaNjHrbY64R1FVh8kwaUZLXHqOx/+Ivb7
         XHBC0ilmyDXBYFNb7vhiggg/F7ZIdsMWfbgI4GiQNS5Mwrm1kN99ouW7H/Zp5qoqYkwL
         Y31l8Q7X4GG7nNBNSJ8YpsUeMR0hj/XZhBu3si1OuR3ZWY7Xfnz05KG7XGcik08fhJIx
         FKKjQg1IHk7rF6MS6l/VCSiHwNlbzDD1advkvmc0/e11LWoXRzMJxKb3455p1456LM8H
         ESlQ==
X-Gm-Message-State: AFq9FYKXGyEDh8k06bf5EjocLyZA0pkPa3PYr2BSQ4XV+8406flKCZqO
	O+HZ/DuiQd4GEeeln4kjxIPhLMoOROnDmmhamlKOrh8+BodqTaJmGGCZNg6LBun6FiayY8Wegoe
	1nnIN9HiXlg==
X-Gm-Gg: AYBFou0q9xA+GnRe8jEPVXUT4dS2pnFM4gBE4QZYdUv+kKeR+0rCbR91kMqxAZCY9Cx
	onZF/lmEM2AFQR5krNrlMf4ISWzn1pWQTKcuc9G/JgfSu35NWjh9ACTX2w51qg8gHstSNM/+hNz
	2+lc+7Q4LVhSKLh5DDaZIl107n37aZQK8alfz8H5O9eQ2wZUMrIcVLJffP0VHCAYS6W/tiDlf4Z
	or4L/YCQH80oj1l2piM7sUWhoTYE/n1s7SAj26DkQUzwQvZqxSKRVw1MKVlODIkpuE55deSLOaf
	Gs6mvDol0qX/sJEWyjNim2c8cTRi8hkn9m2Q9DB+AB6UNy+MImajxEbRPtnK73hmomozfR17Rjo
	N9Z0KBtkvqcxUnPaeCVGJRRV3vviX+27iS416Ptlt66Q9IYIRg1YuarhI0+a6OSmeLEWnxdkaOJ
	OYpH7vpqkFRoLi4UML6qojfdq8c1O4+xGJJBdF8eSOyuWzgoqa4bOMVKrSUq6EbIixK6tWnDXPm
	uhhzIE14vAE+zuAhU+ZdyLl+lBv+CqDxuMiXk+7TUtJnkc+R/7ho0uObFGa0jU6czJ0Lg==
X-Received: by 2002:a05:701b:2403:b0:145:152:b547 with SMTP id a92af1059eb24-16a56ab0d40mr26503724c88.1.1792117218235;
        Thu, 15 Oct 2026 19:20:18 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm1434734c88.22.2026.10.15.19.20.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:20:17 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y 2/2] bpf: abort verification if env->cur_state->loop_entry != NULL
Date: Thu, 15 Oct 2026 22:20:11 -0400
Message-ID: <20261016022011.16938-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016022011.16938-1-artem@trailofbits.com>
References: <20261016022011.16938-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit f3c2d243a36ef23be07bc2bce7c6a5cb6e07d9e3 ]

In addition to warning abort verification with -EFAULT.
If env->cur_state->loop_entry != NULL something is irrecoverably
buggy.

Fixes: bbbc02b7445e ("bpf: copy_verifier_state() should copy 'loop_entry' field")
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250225003838.135319-1-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the corrective follow-up for
CVE-2025-38060 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/verifier.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c00113e691955a6c9c6caa56007ccf90ce9b87d8..37abde03f174ef5c0a47317d9b9d19eeaeb0ccd2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17562,8 +17562,10 @@ process_bpf_exit:
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry))
-						env->cur_state->loop_entry = NULL;
+					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
+						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
+						return -EFAULT;
+					}
 					do_print_state = true;
 					continue;
 				}
