Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85E4B0480
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060264; cv=none; b=KYgTlzuBX4q9sxA9KJb68tt6GSRVAhhTCQ2mzVN7ZnLZ6i3v81q4MCHvZH+NqsUQQdp7mVY98T3jl1iJNOeZx9ydT/bRksfihfLBNYbRwf1el6KPpWqYg6Uobn3QOih1RmgHe4UCezb3jp21pmTisl6bOAaTrejKo7nxe18MM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060264; c=relaxed/simple;
	bh=Ql00Gi/e8s8Cd29IU6YwV4wqY3+xR87GYOT9JJAAcV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CG2kEX36kVtTVUamJup4oOl+XcO5LZLcaeKDlT1TvrFbePdrZaomUPsMAxVimvpKq/8h93BEEE0HQKDTO4Nh8sVoRtO8Yk3jXbGXH7PINP6IUeeJtiMaCcfnd10wolqwtLqWNfY3JfZEeGc3g8jv5HzHyFzCm6gLlWI+/2K3hYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pb2g+u36; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb2g+u36"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e99ef0902so158097485a.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 16:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786060262; x=1786665062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jn5M2DPxWkJRuSOq4XRDkDeVAclvZgLB7USjbXRxmNs=;
        b=pb2g+u36qzatmH24RdEXd0BPAB1TXR2UywaSh1mNK4qEatxFDA7o6Sh6N5zzn165Nk
         yGav3rXApxbUTpJs9GK0bC0hs7F5JPdUqwDxz6jQq9hVcSoPhWDorvsvvBKXNKLsFZ1i
         x4VneSYG38U0Q08xrz3kvapN6g3/jDJUkjv2o1BPcMvrtot6IxCIsePJMkfZtyRLnJLJ
         C/5M3JgxxqhJqtPESjvM7ysIsLl5BcZddE2jzS7vKJPPjx2E18li+jH7v3C1wG7u0I4m
         NzDCi7/E4hHW9m9NvsyU29+mqW6Xd8OTDAk//zfTifs82jgr2QS7ZtITeRP873qnFvWX
         7CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786060262; x=1786665062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jn5M2DPxWkJRuSOq4XRDkDeVAclvZgLB7USjbXRxmNs=;
        b=UtSABOW8T6BR8Gav2x1cTb/B3KldMJGCFSJ0dSAJTK1n/zqANbHOXF0lGLyTPcdeMr
         s/3w3lSRNmJ3Zh2ch1YjCBbF86WJ6zBcAWSbwVZS1RmXeMNwRuv6vDMEktRh5DERCEG7
         cSlchcMHgYxJRW6U0VwYcTurOLTvJ+3w0js1dMOQkZSkl6xTZd1HTPVqKqGNlrQs2xaR
         QcGGlCMzytimJuTfZTOjoKxqYaP0+5i7hCOslgzFZA4aGDz5uDvXKSf9O0ifukV2tAgq
         i4Ap6kxcucG9f4iDjZalQuvJ2cKruHQD4YtMNwHsFFDQB3fAsabmu1e+g3AQ0hN1dKkC
         i+Iw==
X-Forwarded-Encrypted: i=1; AHgh+Roo0zRsLKxVSCP8d0UH4RWInGs+yHJYptnPOyv8/q4XlaoYMIgSavM9JGasYH+AYUHX/ywFJUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJ7B9MnIkxtawIpo70Ad1RCT6xv4Y4mS6o6aOWJixBCrrR7EE
	6l04bwkb/QRkKJu+cyzvHUgbHQ/7ppWlajbnh6osYyvdRtpdlN9ULdHg
X-Gm-Gg: AR+sD1239caqs69mPdkVyYQ/88vgXS+suyio5zYTDKS8iqFBNYEtTfmzVSNi/Swqp3I
	FVWhQyQrI4TXX/BrDrfJ9td2rGxixH6WzMXG+6J0AgkZekltESy5OJfjqLHZu4+6KLe9WxGTGJz
	5HJ4i8Yo/iPYXxE7pzr6uXZqHfznC7S86Ed2TUff5B/4G86SQDk/CV7QkOMnVbgYg0/F9IP0NBJ
	Hp8SDE4Uo3gRRAMs4aH94+ArRgs2t3fgSbwONj3O59UxcuAZSHGU0wy2mTFgjD7N6NsOWWxw3rc
	+ozs72uPHINIqtbihFs/JCPaHLnoKWnRAHqmT0odLpVhebL2X6DJMxRUoOX6f6Zh94hJ7+BGB8F
	UYMcaqVgZ5beebV1zHGJmT5irsSnbeWxSCcVzl2EowbE3RsuiWllr0zYt1SRgRa0Q0iMDv3Oe5K
	IGDURGN8FybDHZypa7HlvevtkPZNMW5Oybp87/qCf6ZyjxQ+tBAEiAEpsKFnMl4WMCWXTISSwuG
	4FNAtzI0mG+R79gZze5Ubkql4EhC0nKC5JIOwMr6mZo7YewVAbA3lw=
X-Received: by 2002:a05:620a:a2dc:20b0:92e:8aed:4785 with SMTP id af79cd13be357-936490e7a4bmr1535882085a.25.1786060261714;
        Thu, 06 Aug 2026 16:51:01 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e258edesm25793285a.32.2026.08.06.16.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 16:51:01 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abelvesa@kernel.org>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] misc: fastrpc: fix use-after-free in fastrpc_map_attach() error path
Date: Thu,  6 Aug 2026 23:50:54 +0000
Message-ID: <20260806235056.456341-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

map->table is set right after the attachment is mapped, before the
len > map->size check. When that check fails and jumps to map_err, the
error path manually calls dma_buf_detach() and dma_buf_put(), then falls
through to fastrpc_map_put() -> fastrpc_free_map().

Since map->table is still non-NULL, fastrpc_free_map() repeats the
cleanup: dma_buf_unmap_attachment_unlocked() dereferences the map->attach
already freed by dma_buf_detach() (use-after-free read), and a second
dma_buf_put() drops an extra reference on map->buf. As the exporting fd is
typically still held by userspace, this imbalance can later lead to
premature destruction of the dma_buf and a use-after-free.

The branch is reachable by an unprivileged process via
FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
requested length, before any DSP invocation.

Clear map->table in the map_err path so the fastrpc_map_put() fallthrough
does not operate on the already released attachment and buffer.

Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3a49384586d..d6be951d5538 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -915,6 +915,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 
 map_err:
 	dma_buf_detach(map->buf, map->attach);
+	map->table = NULL;
 attach_err:
 	dma_buf_put(map->buf);
 get_err:
-- 
2.43.0

