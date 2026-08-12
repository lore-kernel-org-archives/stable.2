Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335738DC59
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564403; cv=none; b=NW51qxI0d5JXGAHQ3zsGnKifODfZFieZ/wERBMpuM0x6g05QBm0d3NNnrZJwUMJg89yDPISl3DBJDXkVC72Y+ZvbNv1QOaaXfISmJn36fF3s85g4VWYMsNJR85QPHDdrotLT8K4neAg0P6RKATlPZzNVAxZ0gS/yfCcR2Fe1OW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564403; c=relaxed/simple;
	bh=ZaZ4wC0gUMSxoDfAoffb9xTcxt5C/x/3HPNvtmy+xz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqFe71JgaC+RuScXLtCos+Yz6WKmq12REfFE/h9JBYYM2Ev7/giwUdm1H1y0j62zCv3m4usvUH1Zf7bHlvAdDjvw6jrer2soSeWcPS54D6VLdHM890oeRarDSm1m0flj8I4tmbFNHo9yu9VoBUeK7d4mlRiXUCymP4pXOysA8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEz9tttu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEz9tttu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so12656265e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564400; x=1787169200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMy4p/Vz5vITJwBEwWHcB2Ir0vh7CqPPuQAXsltndFo=;
        b=FEz9tttu0rbo8aV8mHj4CzSDtWmAMrV5iqu5FHwf/yEWfzCa/nxRUQag0SlhGv8BRL
         1NfG1Im5tnCpS9/eepI8OTrFT1yBmGK4FWsoI4BB5whUUYZAcgKf7r3zMxqeUCVm8Awv
         LSlKC5vpN6vk1bfTe2IqBXFNKRsW7M4NiwRICEcZ9uSA0SFBj6yZNa76KRSOTJpbzZOo
         k6t3dGB42H/ADhfzKO9pswZch+93TISQrwVqhHelDXIDsB0xn0/Pni2whE5tppHHB7yy
         0Xq67pR7XhtWB10IukS9vaR/ZA6DEpmGQMtcXfxylFox0OgCA8DsYMXjOOHNMtuMp3LA
         S89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564400; x=1787169200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMy4p/Vz5vITJwBEwWHcB2Ir0vh7CqPPuQAXsltndFo=;
        b=MoQjI5AAqcHS5s8+Xo4L65aztaSI3k5DGvFDos6eo+pCQetTwC6jbyyWpRWwtCnwvP
         p23UysiN/PQqOG8xjYmhXFpKAWf0LJImeInF8igQ6eUjMbolMFMnmX63qXvDkquzxIY0
         EXW0Ga9Hp9xj+OGtBFHSRs92Tg/ncFp81tJhfMsJSm4WKAQCSLdXACkTLwGe6LeAdS+K
         MSj4xpE/ve/HbAyQ5h92yUSxvSJe20ZRE2T/92a73PHoo08BaG0aAK5JCh6ROguZI/9P
         NRTlKFoEmEutdvn/dJrTdcBXF0xfyAeq+XoOPmlV6RIuE8xhbDV4yBTumulEQUKVPG0C
         /djw==
X-Forwarded-Encrypted: i=1; AHgh+RoAY7l8H4gkwB9Lq6Dbilb++2SaOBBTeHKQLRLCLQsh0OaV6zb/aGNgE560IqJenjeuZkGYPdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3O90KsV8wuvOixdRFj6YFtovypqQUQGXYrirw+HCmCfXyTxi5
	3sPrqZbjJL0iQYo9pE/HAzTvVZeoB6Mznu8SCduhA6+i+h1Q/k6A7iXX
X-Gm-Gg: AR+sD13Zv7yMaQ4opVXUSNUX2/zk8A2+2Xa6OzBNBylWw1M5WHQDhCQf7QgZG6Z059Q
	uP3PuUZVpEABtt4rNPN5WJcsTobboCoM4rnztStbzGHEPQtaFhwPSRL2t/Zeya2btxZHW3kc/to
	eUMPXSFVBd/2/dyY9xNE+VmpYc+0Xf9pteOBaiVZFh97LM9juN3s4GfrgGng7lb6yTn1vHKmLec
	rDlWINq7nyCiF1L18jB0znsXgNLDe42Zo/zy6MC1Mhwwnyc4AtDc6IIK/jzvl2kIEGqPOMYm4Yv
	X5NSGjLQppj5SJAVq8ZmEXe7D6Jh9vbgD7Bi3ggz+aV9XvEO7hW1uxuFAo2EEVueD5cUxFoio/G
	Gl4E0Shc4sYZfuacQ9N8FINI47l+XopRo7Rz0h03RModOMfUMQgnNc/RqgrGw8RqimNExMXVkIP
	dLtOI/ZuiEVD37AlabnEzQdjkrPHn35VizPuQfG2XLVUh0UUG3XzoYBRQIEvOUaxGSvlYByedLm
	hIGNmxS7f8C8YNeXXnaPcWw3CVBfNDJi4B2XsZ46TGoGiX7gw==
X-Received: by 2002:a05:600c:358b:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-499821c2ffdmr1196545e9.13.1786564399984;
        Wed, 12 Aug 2026 12:53:19 -0700 (PDT)
Received: from karin-metis-desk.tailaea490.ts.net ([2a06:c701:c1f7:3500:4c98:e58c:bdb:6080])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981abd6desm13145665e9.0.2026.08.12.12.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:53:19 -0700 (PDT)
From: Tomer Pomeranc <tomerpo@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	brauner@kernel.org,
	cmllamas@google.com,
	aliceryhl@google.com,
	stable@vger.kernel.org,
	Tomer Pomeranc <tomerpo@gmail.com>
Subject: [PATCH 1/2] binder: fix leaked fd fixups on TF_UPDATE_TXN supersede
Date: Wed, 12 Aug 2026 22:53:15 +0300
Message-Id: <20260812195316.259136-2-tomerpo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812195316.259136-1-tomerpo@gmail.com>
References: <20260812195316.259136-1-tomerpo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a TF_UPDATE_TXN transaction supersedes a pending async transaction
in a frozen process, the outdated transaction is freed with kfree()
directly. This skips binder_free_txn_fixups(), leaking all
binder_txn_fd_fixup entries and their fget()'d struct file references.

The leaked file refcounts never reach zero, so the struct file objects
are permanently pinned in memory. They survive process exit and
accumulate across invocations until file-max exhaustion.

Every other transaction cleanup path (binder_free_transaction(),
binder_transaction() error paths, binder_release_work()) correctly
calls binder_free_txn_fixups(). Add the missing call before kfree()
in the t_outdated cleanup block.

Fixes: 9864bb480133 ("binder: add TF_UPDATE_TXN to replace outdated txn")
Cc: stable@vger.kernel.org
Signed-off-by: Tomer Pomeranc <tomerpo@gmail.com>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8f2ef1bd5..f70aeb63a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2932,6 +2932,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 		trace_binder_transaction_update_buffer_release(buffer);
 		binder_release_entire_buffer(proc, NULL, buffer, false);
 		binder_alloc_free_buf(&proc->alloc, buffer);
+		binder_free_txn_fixups(t_outdated);
 		kfree(t_outdated);
 		binder_stats_deleted(BINDER_STAT_TRANSACTION);
 	}
-- 
2.34.1

