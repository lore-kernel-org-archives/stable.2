Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D251B3AEB49
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560017; cv=none; b=eiOdO23vkmw52tE4ImZPEB0O4QBRtCYhW032zbYFZml+cEkuXmEtezS2CP+kTFNmcZ7SvzRaZc0UGJ3K7d/o85YFiv4LKtFeF6fomyhrlXjui5wxuPmX7rIZRlIFgUWNIP5zvGYDVC02qFnJQ5cmjSzm+W/gCAWa1ZuSx7O5Txw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560017; c=relaxed/simple;
	bh=lYyIoNF3fWmkhnHE9fSVPTTMtQXhuZGIpVAThKlsbYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haV0451R+4cQZCbM4WfnKsz+dVQjMnwhLWy6XdraNeMOEBrPmtA0LYeWrAF5K+eRcQqP/vVPhl7KdP2mGVyc06bLpObf36brPCr5N8OysTm623UMGDYIWXusVt408jQ/x+gVie7JExN3pVRRtrNfM18Xd95D3xh7ZXFb4fPI7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONptO+Hk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONptO+Hk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3409016a91.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560014; x=1788164814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rvwvU2fx//eAu2LlByDRKWPs/wkyAhNxSDJe0aj8Fuk=;
        b=ONptO+HkIkqGtGSA9j3czxC5mMrrqnApH5l0HQrqyrf9WC9uCN2PT+MtTAVlSK/Z2y
         8grdFUZbfIDZLU5oeNIjxLP33oAJs3XfFjDAIRoYqUzVN+EizqfUTfICuprm8WjJ36Lu
         kn7vdJ9tqTJVOXsjnoD30J3GaAmLGZBXGYLHUVqzYiMnfmF7GI0WJTXrbC+lpx4pcsfE
         d7j+TlrNui9IMmS05KhuPYOwjrcp0MvKyJ2CqLnKu4Nve/sd+oMwtMT+uP1S2H8wflpy
         yi0HmleX0PGooYySZd1QVx5FPkyZsPZfcWjEqcpNj8wgUvcjBcGy77VkeTxTeu/iHCMx
         BCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560014; x=1788164814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rvwvU2fx//eAu2LlByDRKWPs/wkyAhNxSDJe0aj8Fuk=;
        b=XxnSONaFys8LGRrV8GAfP+XWXGWBpmmufxkozImYNKZlKEDTNQrDN6YuU89fGtCoSD
         Bxd/TT2TuQLeA/MuCEj/j82CPkIau0YKz6wyLNgT7Vcf15WZ0+F3mfs9qi7AyrjHkX6g
         Zrvymwk7sp5D6G1C5uSxir/n/uZJIMJhzP7ZnAuCAyNdqb77DAIiHPKPvX72+E/1X7J+
         MJ0O95GL6RVXeVgYBdMnZZ765+M+cVlFNN6EIVdp9ln9SWQQnuqF06wiL78KB/tZLoVK
         synvqB0gUXwTV53obaMjHxEI5p/sQXEgNilkHEsy9Zd2PNqtFkLlnu/CwvmHTD9ixfpq
         KPng==
X-Forwarded-Encrypted: i=1; AHgh+RrX1iltqjJPtYpwMnZXWMcYFyFBMzP1XBlDUQHlk0d3OIzka60KNTjp6VpodvhX4+MAvk/LSXg=@vger.kernel.org
X-Gm-Message-State: AFuF++njYDOFMpcanwqn/O36HfKFSw18IeJx55Ki0rxwUYmtjjguJqDQ
	/wqh04vvqmICEizBDDPKO66VHxyAEj13KCQdupBWoRMLtB3sA/C+3mv2
X-Gm-Gg: AR+sD13HYEn2rSUml1zixKPWdU1rgRW6c8B5LZ/OhD9penT7rxpf2ioqHpH3uK6yDU+
	M3O+9/7BfLlmvJjCr8S485Ip3xzQytLzcAAHEvpcFJwPfVxu6a2vOSSQ0pCPIznU2P1e8uuJEIs
	X3oznszwmP+YJHNpD4Yj0Q9hBreTDvUzqGAI3ByvcV8U9XMn8jxfWip2atbPiub3DayVsQzOGYy
	s/0XMkAxpw59Jaqm9S/WSbtMeOvA+Vk9nytx9HQbS2HriD1vWqwIGIKhkNJDD3qGPoZFqcldZ53
	RBRrpg84FKCCWNAq3AyHwwQ06jJ3XRSdSGOTPXA80fzRjDeK0X5x9M6SetHqM8RosBtIItJiH1h
	CNNfXPUlh/q8ffzQW5OJ1UFgLkXmIhMO6QtVowzqr6FmVq1MhVF53urNdwo4WwvvWO88zt1d7if
	XQCtngZYkEWq6VePiaBpwef+ATB20q/9Rn5iShiLWdgcvkK50GXmByaYHyBFIl7ee0WvYHjMDv2
	O6ubKwFptwuMWntvZXCBrrPMgmOXSDeCGo2xUU62q1fjAA9I3sSJKE8iiSI++3OCQ3RuTYTosJ9
	r/f/0WfLKROldwNnFpgrSx5yWgg7u+r3HUhG1agCoQZ3e6hR/sixF9w9TVIa4eIE7/s0i9XmDdT
	l4djiaYhKonJGo3a4dP1cEFIf71dHlr7wH5eRrIqI9s54SAQ=
X-Received: by 2002:a17:90b:5347:b0:395:a7eb:a4d8 with SMTP id 98e67ed59e1d1-395c3a4bd22mr48059051a91.14.1787560013592;
        Mon, 24 Aug 2026 01:26:53 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0dd3sm25994595eec.7.2026.08.24.01.26.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 01:26:53 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] soc: apple: rtkit: free syslog buffer before reinitializing
Date: Mon, 24 Aug 2026 14:11:37 +0545
Message-ID: <c14026054a393b581d3dd91a618892616424e202.1787559303.git.acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1787559303.git.acharyalaxman8848@gmail.com>
References: <cover.1787559303.git.acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A second SYSLOG_INIT message overwrites syslog_msg_buffer without
freeing the previous allocation. Free the old buffer before allocating
its replacement.

Fixes: 9bd1d9a0d8bb ("soc: apple: Add RTKit IPC library")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/soc/apple/rtkit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index a3fdac8f6f06..1886f7eba77d 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -422,6 +422,9 @@ static void apple_rtkit_ioreport_rx(struct apple_rtkit *rtk, u64 msg)
 
 static void apple_rtkit_syslog_rx_init(struct apple_rtkit *rtk, u64 msg)
 {
+	kfree(rtk->syslog_msg_buffer);
+	rtk->syslog_msg_buffer = NULL;
+
 	rtk->syslog_n_entries = FIELD_GET(APPLE_RTKIT_SYSLOG_N_ENTRIES, msg);
 	rtk->syslog_msg_size = FIELD_GET(APPLE_RTKIT_SYSLOG_MSG_SIZE, msg);
 
-- 
2.51.2

