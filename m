Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9747ECCC
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449867; cv=none; b=jt9+Vo586E2S1nfGC81j4JjrdDtLNTLaJ6zpcrmapzfpAnhCede5y62LAwcLpUHQ1p//4XtaVT55hvk30QtNqedCYrkl3C9fGDdIHC4D/O3ba3OpLCNQdMvXXzi/hmB0sdzX1tQnkrJfvFaSACk46AG4j6QF7FVUMVyPIYA3gWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449867; c=relaxed/simple;
	bh=Tdkfl83QkxAFZ3k45EW/obferf9lLSc5mOVAXeh6Nwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttOdnIGJZAjCcekKdesFesSK7vgeAHIbJ8YslSQgN+fkHiOmntHb5G/gqUAo9dG1eKJMdjJv3fKeA3QS0sqeft0meG4NoGPrng4UVo3JRO7UH/ak3RD+on8Dqpgl+rxUwsKsqpTA6WXT4B1sWut8P7AFHCmV7YpezEhrLzn0SmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=PJ8ebl6+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="PJ8ebl6+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso6118752a91.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783449864; x=1784054664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdEjxfWmkxjD3D5Jzsct8hZCWkuvv+0nMtcSUeOFAzo=;
        b=PJ8ebl6+t/LIM3Vbeq56jnfxqn+n8MA5nuXV4WBqH0xZyQ9s+5Sr1i3G+4e060faON
         AgfiyVUK+vI1/hdWmdVc8JTRolJ9gYsYdNFnUxl40GEu0u7lVZ3H5wiq2g3Zc2e69Jdr
         h6Y2cnCP7xkByXDP8EasjoxFdIlarAPj5aPdGU/RT9wRB5k3+4dgLcJ8l14sFTd8qX74
         Omi8dneF2gZ4ck8dgvFzOGyjG6dNsPZdu2fe5ln6JPJVqVFV5sMIa59GOjRVIkDsVEyx
         DjG0aQ/KSHwg+G/LWRt/06Y/OkY+4EFuv2ungt4GACJCBrkYIlIu5BxJ4kMmFhBMLhxj
         Cx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783449864; x=1784054664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DdEjxfWmkxjD3D5Jzsct8hZCWkuvv+0nMtcSUeOFAzo=;
        b=Ay3Msmk4GWGWZZMYf0d8kv9dXUWyHObRpEHgS9CDwNtT6vt5hNQLEM5lH8V3Fvi6Mk
         wdF6zkNzcipvWozpGqq5DPEzkB2HMBIjo/z/Dy6BAvRyZa0jsgPHWU7tZXaLQlNQLWHQ
         6XDppDHi5M7Iai4fm2bD3wpBfZ9yYMwaHvTeVj79vSoy5kD54Gbjyn1K30HQJVZvRqc7
         KNcVblytLBebw9d/zVmvDl/5Bg6xVDngTI4j31CJRd5PkEzryhy6usspzI2e9kAz/6Td
         7BbAPsjGnENG0xr3GaV6GiHW7bmrhrhIVgLZTy1mK+sJSVGcgwRhXOlyd3I44wFxeAO8
         7KzA==
X-Gm-Message-State: AOJu0Yy4545tdqCE/YdXilMy8Glz7QHpxNVlHHkGmyYewc8Z4duw1pLN
	csFPjHSdiLLSf1x3PckNrVL0MpRYJDuG9ZQrkF+tSWIJsswMbWDWIN3S48O36HQWjw==
X-Gm-Gg: AfdE7clNlExt3IS2yUDFOoJEXTOMkOWzovhjGKZOJlNMKAET8KD6BebS+sdqXjKjUhK
	zDPq0pJO9E/oA0qtuvNDUCkUe/w2herb1hz4LTwp1YEccsjAuMDKv8dQfyelHHFUdPOPb0GTTNL
	IRI4gc1Db7HEsqJpxwdF5W25tv3sNH4Sb/GJZln0OeSqDuYGlmYzdF33+IqHOwMf/yRhRVW0ilb
	LR1D+Cso3Wd6q3hjjF9/xDscw78LqxPxAogwXjNE6ZSx1GCUWKjqXjl145pp2qwzVO7omF+vvU7
	jkuA3TPiCBA1K1F+A5WH9H9NsaeAceAUrv23EfuBOHcdznFtWFi9j3+EGVtgEg1QMVOzlkxlyHP
	u90VJLA46uPBAyfVq5UwEbIsX0rRp+3Q8MMOcZZUz3WVzMcbjv+JqKBqRRyJrTYGPHfju/OFK99
	Y=
X-Received: by 2002:a17:90b:1c0d:b0:380:7763:3b16 with SMTP id 98e67ed59e1d1-387581641c4mr7188884a91.19.1783449864159;
        Tue, 07 Jul 2026 11:44:24 -0700 (PDT)
Received: from p1.. ([172.56.105.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d12fcecesm1575432a91.1.2026.07.07.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:44:23 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Joanne Koong <joannelkoong@gmail.com>,
	djwong@kernel.org,
	Bernd Schubert <bernd@bsbernd.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: stable@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Luis Henriques <luis@igalia.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v2 2/2] fuse: reject oversized payload_sz in fuse_uring_copy_from_ring()
Date: Tue,  7 Jul 2026 11:44:17 -0700
Message-ID: <20260707184417.3682270-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707184417.3682270-1-xmei5@asu.edu>
References: <20260707184417.3682270-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_uring_copy_from_ring() imports the payload buffer with length
ring->max_payload_sz but passes the server-controlled payload_sz to
fuse_copy_out_args() unchecked.  A larger payload_sz drains the iterator
to exhaustion and fuse_copy_fill() hits BUG_ON(!err), panicking the
kernel.  Reject replies whose payload_sz exceeds the imported buffer.

  kernel BUG at fs/fuse/dev.c:1053!
  RIP: 0010:fuse_copy_fill+0x6c6/0x7e0
  Call Trace:
   fuse_copy_args
   fuse_uring_copy_from_ring     fs/fuse/dev_uring.c:686
   fuse_uring_cmd
   io_uring_cmd
   __io_issue_sqe
   io_submit_sqes
   __do_sys_io_uring_enter
   entry_SYSCALL_64_after_hwframe

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
v2: add: Cc stable and Reviewed-by tags

 fs/fuse/dev_uring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 0814681eb04b..f6127c230dd9 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
+	if (ring_in_out.payload_sz > ring->max_payload_sz)
+		return -EINVAL;
+
 	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &iter);
 	if (err)
 		return err;
-- 
2.43.0

