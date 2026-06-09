Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A93749F0
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032600; cv=none; b=buup9col/m6irWsCLN/GV6M4futvGFwaTb67+vzYQpHT92vZ/qlQVbo1JBQzrXFGTHpwRm0q8w8gcSyO/h0L5UZewL2vAodWBf7jrwv0lF6pXOyFgKba5YdicDiKpoKeuvxDqDISxt/t2e/LIpg/8VqkrcZaLadbfPjOTzzm2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032600; c=relaxed/simple;
	bh=s47chH+7dbbusMA/MN5x38CVsFfZbgJp5yTUf8mjmwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QGZAp4mL9cAKwVYgiL53DwEzGrTRMRKLmcV6Q2Z6C8meC5B9RkdHt+3Ld57eqdWEGFkrOXx8PGp9xmN5nBhIoF0MgmYb/dwyMyyI3aZDl0KgmEUG9BMsiL5gEwhkywuZW8IQ7DXnLQnB8HCquEwg6OX2fK6JO0y04PiFsxmjgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIxPJxw4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIxPJxw4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso47008265e9.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781032598; x=1781637398; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P+YB5MFvXAxyYtTivGfLpgXtTzsfwDJulefAeKshzoc=;
        b=QIxPJxw43B7NPBNJtJ9PCOq1asW10X0ESinoWJFki2OY74XQG5QXcRxjapQPNLUjUx
         1way0LFN1D1p6N08S80h1DFUYjtitnDjEYMHD4LE6q/xbUXZkgGBPk9y9yXCuK9TjPRE
         +QBBwAdoxAKgngqWrGgKpmPnWDUnP1Oo34VaDj4gw8QcUMSNpH7icIlwNUbXCTHnrkEY
         WWLMe6lKRZmB/Zt1jJnVaw7pPlM29RMRUfK+xFzCHgxrQtV9sTNl4AeoJ1XbRTBia5W9
         SyZmkxgggyTo3IiM9vWJ/2KCh+XQVb+hvxtGPMxyADdjXhiSvwlxvRMkWG5R+ejBKgcB
         YlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781032598; x=1781637398;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+YB5MFvXAxyYtTivGfLpgXtTzsfwDJulefAeKshzoc=;
        b=ozjJALkxAnM9h1xSkGbWRStp8QfR0QAnSskuRiYp2HEdpYqzB2OmowwSv0X4ygNm9s
         oGGtTztNRPXgP1wZNmqHeqDKyEB2jX+wtGlMBj4vcNJ9KSm/tIsgRVZY9a/STvTWbnkI
         ZIv45uG+2sG9ibb2uD/bxgt4tNWKKsvV9Qf6q5Rp+apuI59IELhANZpFYHVJV/QCzGVv
         gk0RV0MvxZa33PULyHw56ZrN+kwLMluoMbWtGDyAZp1e6cTNVRyzyWWZut+7k04WOaFs
         Wx7DNe+Hb/vmRnUB8kVKAz4K8IWJ53NvhTLUEQqo3mvcZmBbSHwMV7zlFAuxlPz3rSDY
         LYLQ==
X-Gm-Message-State: AOJu0Yxgd2uV615TkkcUkb6NtBrwW2lT6XnuMjABfBHbCTIscXI+eNXH
	MhZwu/mjFa7BljwCsGhMfpdykqDAw8FgcGOPTu7O838lJSbDzIDGorHd
X-Gm-Gg: Acq92OHPBqrWsElJs67y7Mps677VTgyjAbSSjy5b/dBtrVmgFnoGDd3z0HYPksoMNqA
	hjv04BozdpE5PCDU+uiso9mbsRZ4nPudigcgImxJI8jFtOCuVE4BYqbAUoedaZy444F3Xq6PLPa
	ndRgEzujWARMPDDKPhVO7wb82xeb2gjV7kzXZp6uW8iVIQMxpNbk1tMGv8OhH5t3pQ5x21UuemY
	ywRwD6f/K+yIcWpocIG6eUnSYSyag46nZFlEQ5ncW7X8KkYCcXQpYuymGixcmYaS4QaD440sqWN
	HplzlZEEb0s5cV3tatuKh1BgITJ4qeasA98cadZSbwMpsJd/eoy0b9bKiPmiAuj3bBnS5T3mciC
	VGAMHsuGsz4wOnJCc/py7qk1VSkI30kzJZPbxq9S5x8oU9FJDK5igfOg/E0M96zVIvpcG9mhgB5
	INo24YYvqA2Fpt+bwPTa7HGIfRBMlVBDWeR3ZSNGDdfxNatZkXYQ/m/MDjBcC3KWmOOpmucA==
X-Received: by 2002:a05:600c:2182:b0:490:da23:1d50 with SMTP id 5b1f17b1804b1-490da231d7cmr20326535e9.3.1781032597363;
        Tue, 09 Jun 2026 12:16:37 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm114809389f8f.27.2026.06.09.12.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:16:36 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1B65EBE2EE7; Tue, 09 Jun 2026 21:16:35 +0200 (CEST)
Date: Tue, 9 Jun 2026 21:16:35 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy
 reference in pskb_carve helpers") to 6.1.y
Message-ID: <aihmk7GjOP0e0miV@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in
pskb_carve helpers") was marked to be backported to stable, but AFAICS
there is a small context issue, to make it apply cleanly.

With adjusting context the change applies, proposed change below.

Does that looks good, and can you pick up the change as well for the
6.1.y series?

Regards,
Salvatore

From b1c88a1281e42a82958d802aaf82026253858b95 Mon Sep 17 00:00:00 2001
From: Minh Nguyen <minhnguyen.080505@gmail.com>
Date: Tue, 26 May 2026 11:12:39 +0700
Subject: [PATCH] net: skbuff: fix missing zerocopy reference in pskb_carve
 helpers

commit 98d0912e9f841e5529a5b89a972805f34cb1c69d upstream.

pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
the old skb_shared_info header into a new buffer via memcpy(), which
includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
Neither function calls net_zcopy_get() for the new shinfo, creating an
unaccounted holder: every skb_shared_info with destructor_arg set will
call skb_zcopy_clear() once when freed, but the corresponding
net_zcopy_get() was never called for the new copy. Repeated calls
drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
TX skbs still hold live destructor_arg pointers.

KASAN reports use-after-free on a freed ubuf_info_msgzc:

  BUG: KASAN: slab-use-after-free in skb_release_data+0x77b/0x810
  Read of size 8 at addr ffff88801574d3e8 by task poc/220

  Call Trace:
   skb_release_data+0x77b/0x810
   kfree_skb_list_reason+0x13e/0x610
   skb_release_data+0x4cd/0x810
   sk_skb_reason_drop+0xf3/0x340
   skb_queue_purge_reason+0x282/0x440
   rds_tcp_inc_free+0x1e/0x30
   rds_recvmsg+0x354/0x1780
   __sys_recvmsg+0xdf/0x180

  Allocated by task 219:
   msg_zerocopy_realloc+0x157/0x7b0
   tcp_sendmsg_locked+0x2892/0x3ba0

  Freed by task 219:
   ip_recv_error+0x74a/0xb10
   tcp_recvmsg+0x475/0x530

The skb consuming the late access still referenced the same uarg via
shinfo->destructor_arg copied by pskb_carve_inside_nonlinear() without
a refcount bump. This has been verified to be reliably exploitable: a
working proof-of-concept achieves full root privilege escalation from
an unprivileged local user on a default kernel configuration.

The fix follows the pattern of pskb_expand_head() which has the same
memcpy/cloned structure. For pskb_carve_inside_header(), net_zcopy_get()
is placed after skb_orphan_frags() succeeds, so the orphan error path
needs no cleanup. For pskb_carve_inside_nonlinear(), net_zcopy_get() is
placed after all failure points and just before skb_release_data(), so
no error path needs cleanup at all -- matching pskb_expand_head() more
closely and avoiding the need for a balancing net_zcopy_put().

Fixes: 6fa01ccd8830 ("skbuff: Add pskb_extract() helper function")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260526041240.329462-1-minhnguyen.080505@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[Salvatore Bonaccorso: Backport for context changes, as 6.1.y has not
511a3eda2f8d ("net: dropreason: propagate drop_reason to
skb_release_data()")].
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8bc4b26de5e5..b91e2e9f1096 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6242,6 +6242,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			kfree(data);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6386,6 +6388,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		kfree(data);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb);
 
 	skb->head = data;
-- 
2.53.0

