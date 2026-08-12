Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E538655A
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564402; cv=none; b=q4Ibv21s3YGLLYCs0yvCsZNbO9xtzby6oE96T2FslQ169E2lzq/NvacpAG0FEWbx53Ydc64py2WAKZ9qMg/trBXBtN+d6HscXD1x1fvvjm/UYDHftWXFI75U9blT0VCuRgclPiF7kwxJBCj7rTInDktdTF9qU1LQLW3c+73YLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564402; c=relaxed/simple;
	bh=gpPLws1+h9xHPMVtLM8Mj1+gP9xwwHEe1Vdib5Sfixg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+j0LBTlbDBVCi1SKG5dWQPtgax2A+J7q/DN4++w55uKPK7+b+oe7y0Lbj257w5LBGbBGh90a0vtVBZP5U+IN0h4JRxWTQVdOWJDHDdmi62CaqLtSxlA/8Rx40W6kWP3UfmX9hPwIcB/k0P7KlLD8wYVALt4/kK0LIscloI49AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu+MunGk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu+MunGk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so16400585e9.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564399; x=1787169199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q4GDf4yjh9uyISnUKMYp4de1+6HkxuZ50urGemRxIzI=;
        b=Yu+MunGk/BlWOCXVzRC85/+SBs06mJsZD6PGyRSa93htFTIHzBC6LCE1+2DCmrsOus
         OyfwUvPRjbcP1VSEj751n19ExxKCF5D6AXLwHz07oarzDJgB9Ow53KVzgxwnd3LbnN6N
         q4Z+Ny47h3e+hTk8+MdqCTdzmEaMiA4L9Zq/1xZ+JzrN7gSChOJIJtButvc+SZu6Anw9
         9j+RyXfAZb3qPxLzU1uNDDF/P01rot6OEbHBcEalTs0c4gqgIb97sPX0PfGQqRiNUUo+
         X9EPR56F1Qg2ClQdsbNsGP+8zB2hTdbWgDcyJpl4iIJxSDM329AJrdbT32MW1SC2z9mY
         iEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564399; x=1787169199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q4GDf4yjh9uyISnUKMYp4de1+6HkxuZ50urGemRxIzI=;
        b=nEqX3Q9VB/jaKYLR7YaNXZ5nq2JMqlHbpmDB51mOO2gPDgYCNFoY7ll1j9lyW3gAkG
         GkTg1EhS0EHcDhPCNCd4HFviuEmJWuf/jx1PU/SRJkIgTYNq5Af0U7Ss1NcgK322YCGk
         xiWao78ZSU9WAyLuIv7Dkrz9vTp8K31xPzzoaz5ujllQLDV2co7hO3bws3zFWzVxwdbZ
         hOz+tC688JIZaWRkUckOhdTl0S+BXcFd62iOVL/YrWI0ttzpNscpXuO/za6Sr2mjJyg7
         pNfW90vWFKTePZOrnoaFrxCFdx2BZnp6E2iXPxHKmPwaGB5/157S2XbYOBCAOv366O/i
         oDKA==
X-Forwarded-Encrypted: i=1; AHgh+RpLNw50oGgFnADkXyP0/s5n7xeqntvassHuooCTU/X6/T8Xk3jC2Ri/bwSaeA/zHbfLVktFRUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvre/iQyESO21ZXcSOCS1uCRw2mMAMJq0z/YBeHUtqXOC3RcfB
	9VJoDaYyDNPEJ7rvZodDYtxFGv7EPD7JzQopr4Td0fhl/u3ZpxqOVUHH9TiC84QN
X-Gm-Gg: AR+sD10x9I6hXEWj1UM2lYWykPCbRX7ZDlpHU/tau9MsGAcwrtODxViKqYHzyMaBBjG
	oPR0ix0f3hwF/R4QR/AA6NIgqPncRrdUzbhKYEZbOFhuO4hz2z+j1J8pI352hs6OWCKlFL5TS8R
	LcQX+N7W+sb9cADxeNJAgtDgWF7fFLhmGv7oVbNxMQbWDYOM6lGD262Ygmg0lcp8wswRiRz4fRe
	MWixciS7y8xdOoCnKaqlA/Yf3po5zcDRr2Bj8hRU+u+sl0oYyl3iBxN12rOsd6qiBPXiSR3rRBA
	p5eeiM6sYjgn6vZiJK1zXbEGT1gm8vJV7AV0wXYI4XG8SwJw1Xydg1Lm+VWJADJRuHtRJAHRz6r
	68Or2tuPmhQ+RMK9aKkJVn9EhN58b6f2tL+8ynOAWJ4xKpFmPCbUUUoxv947p4xrAYaEDvolSlA
	cGWbYzoVwNKyouNu64AyqkRhx68AsZxDM0WlSO4w/UztyCYwofNet+lxvluQ9txfyFiumxOUSle
	yWWl0FmifQVuvq8iqhgVlbY4E1IXxBYip8xcW+RsFXyp8vecA==
X-Received: by 2002:a05:600c:c054:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499821fa293mr503345e9.15.1786564398538;
        Wed, 12 Aug 2026 12:53:18 -0700 (PDT)
Received: from karin-metis-desk.tailaea490.ts.net ([2a06:c701:c1f7:3500:4c98:e58c:bdb:6080])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981abd6desm13145665e9.0.2026.08.12.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:53:18 -0700 (PDT)
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
Subject: [PATCH 0/2] binder: fix TF_UPDATE_TXN supersede cleanup bugs
Date: Wed, 12 Aug 2026 22:53:14 +0300
Message-Id: <20260812195316.259136-1-tomerpo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs in the t_outdated cleanup path of binder_proc_transaction(),
both introduced by commit 9864bb480133 ("binder: add TF_UPDATE_TXN to
replace outdated txn"):

1. kfree(t_outdated) is called without binder_free_txn_fixups(),
   permanently leaking binder_txn_fd_fixup entries and their fget()'d
   struct file references. The refcount never reaches zero; the leak
   survives process exit and accumulates until file-max exhaustion.

2. binder_release_entire_buffer() is called with is_failure=false for
   a transaction that was never delivered. Since binder_apply_fd_fixups()
   was never called, the BINDER_TYPE_FDA handler reads stale buffer data
   as fd numbers and closes unrelated fds via binder_deferred_fd_close().

Confirmed on mainline Linux (6.8.0-124-generic, binder_linux module)
and Android (Pixel 8, kernel 6.1.124, /dev/hwbinder).

Tomer Pomeranc (2):
  binder: fix leaked fd fixups on TF_UPDATE_TXN supersede
  binder: fix is_failure flag for superseded transaction cleanup

 drivers/android/binder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1

