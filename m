Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439079;
	b=mI7zrrr1AjTt1zZB2tB5y7VR7+ebyE1rmI890EJNSGu/uX35D4tNgi2OFzpjIK71Y9rs
	 6EIkwt97SmVV0NhUtMXEQUiTqjGUA6u1BAKTUbudyrcdw3ohfYDJePeBRplTI0T9NRLMa
	 RiG/nBlH6DjyeuNwdvUUn5nhPXDWTbxvNxb9uZmc6REksAAKZWEAbzWSdb6QT49+q/nyq
	 Lx7oD1E+QxcJ6seA8tChXe4Qf7wfwXqHgx118KUOw03t2byRTku/J6xFY9TAiUftBjBu8
	 nJF80WqbX0R2moI28dYgf61xdHpnFSDhFqIunGnGrhYlIFtGjcEOjQgYSQAU9zGjOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hJIlttWx83H/gH+IsCx67p64peRkehwpXoU8dYayss0=;
	b=UbkTbx5kxoYZVfavZJ+lbjLBsZxg2AZxDlNw9453EzkJaGLSWHpPibwJvW6ncAhbBWv3
	 ZuEykrvAMzFJMlu5SogCrNPsgIUg6AcrhTp31QcBvGT+BtJlSuCrC4Cct+AEsWz1xjfpb
	 YMmH1DvAqg0CclYykF4R0RPkmNp1Xx8TIAvhKTPFzqsAst9+dHeopb9YpLqxPtMXCSTWS
	 tYaj0b9DcGlLzC+cWg0M3kpP6N0DBavUL1Hvjh2UI8J5OkeO/xTt2Q+2L01IUjVo5Ib7E
	 wb2sVz6EVcfIghstk26opg/cvDgW/HVmAzDl3WEoo7vDSDiVtXOXCR0EUzfLa15WcBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YI86hYX0;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F04606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71F04606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YI86hYX0
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so4827241c88.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439078; x=1796043878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJIlttWx83H/gH+IsCx67p64peRkehwpXoU8dYayss0=;
        b=YI86hYX0JrIzb9tJVaXByzsMwnjIJFc+ssFurL6mYsha5tUcwst2aa2iQqHJf+7VLm
         DvAxfmLkTBroPGTIZjX7hWBpLwXvX8L57NApSea8k88FhY2M4cVLtbWOpTB1zdx2t+00
         0Y8Z6gocOFPa8DuFJFDe5LAbJQ60ja6efEd7UG2CQt3fEBfoqeIoY9inchBEFW4x3Jaa
         sBU+ezs2mpnGpdkncSR0IGEAUiG7iiggQYKJ+gFOsd5O04zx1/ULVut7npnYUNZnQs8p
         V3HA5s2YNdeWh09YjaZF6tnA027ApwfLxeBvlylB4/cnBvlk92cOXVkNH4sscW7OEtjK
         auXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439078; x=1796043878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJIlttWx83H/gH+IsCx67p64peRkehwpXoU8dYayss0=;
        b=V1SXqHRw8r0ZUqSfagb7Fcp6mX5xsKtAso6+O3YqmBI+8sVKHxFpz0CzwtfQOMg/B9
         UgBn3F9UEnWXH0ugGUx151+wb8wExUbVCzXQZ0PDw/qkXCYitj4S2kxIXGLGtoOy3KVF
         ByR9s2KSniZfLvLEJQUGIn+gyyg1wmtmwFj238HWCnyPz9H1y/uYdzZVSmJiDMr7pkWk
         /X30o/LRHCMgNAgm/LxAXytGQMa6OBNJCYtjPg8PToe7/YrX05Clbvg8EJUP6grASLit
         /m5hMHKKJTn4CUF2bFGFkUCawpNZeQSNvwses1OmehZV8OzeltkXy+hNeRuLKAqvhLnb
         R+DA==
X-Forwarded-Encrypted: i=1; AL+hErEp5mI2xrgQnw2NpSbM27/mHdn+pqqGre6Fy3JYVMuhkKmYZgrD7xWk97UpZbTxhP7nykTh+/E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+t26o3hm50LbE11jfmy2UhSrNPV7e0lxa/j90XTJpoF+bZIlSD
	WvosufCGBQ7D2xC6aBIiTAZEPGDtrO3MffNdPD3n5mQebuBVk+eGkyTH
X-Gm-Gg: AZFdTZdmvYgcuSOkACPq4Xv86Ckto13VeGJvAw4MHTiPWKfuw1fxs0/xTfpquONOPiB
	1Cxa3HFv+APl7SEdAOoRDbe85p1JtqFu+s5c0voRRJ+rT4TBwImIC5u1bnuFRiNHiJO7F9uHvV1
	CbTacGYUKAPNG1wI3BOsWVRaalLHS1OpUKQShqylgIyc1KuDgO6lvkHGHD5sNdHuXKXva+63SvJ
	6Vq8QY/sJJbRbx2LuV6e+bVbV9JVN5jDoQQfyVieSTIulK+O9zICT3YaFXYnQ1gw1b2p22NmGVD
	6Ni2TUK+mo0oADJpaIwQycvvin2RDPve+xk+CtzWg6APVoX7sm+BTUJMFcSAMfVGleS+AlwEOUX
	ywPufYAm4/bU+5iL0QxrTmV1TYbmkdYUYB8/P3oeA7arXW2Dvq9COs5rsIda0Db8+aZQ324zOza
	fPEgWOj7SApgg0KQQYs+gNTHglw4dv++Wvgf24naaoVOAUQv9HVYMlp3sreL7+MhrlANtMAtZNw
	8AiHXiXWEimRfqewL61XIjra0mjhKuM6Hyo5Kg/U/m8bksSvnCsFTDIC0Ztg7j2seVkfAXno9Wl
	KaQpVNl+iDwrFW9grWS1QUGgknFwmKBgMDIOs2THKaFz2WOl8z8t9w==
X-Received: by 2002:a05:701b:450b:10b0:1b2:4e2e:d95a with SMTP id a92af1059eb24-1b55e06c4d7mr9933460c88.2.1795439078312;
        Mon, 23 Nov 2026 05:04:38 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm40262666c88.14.2026.11.23.05.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:04:37 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: mwifiex: bound the RX reorder index by the window size
Date: Mon, 23 Nov 2026 21:04:34 +0800
Message-Id: <20261123130434.2841777-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_11n_rx_reorder_pkt() reads and writes
tbl->rx_reorder_ptr[pkt_index] without checking pkt_index against
win_size. seq_num is a 16-bit field of the RX descriptor from the
device. If the window wraps past 4095, a seq_num above 4095 can pass
the window checks and give an index far past the array. With a one-slot
window, which a firmware BT coexistence event can set, every accepted
seq_num other than start_win indexes past the slot. A single lost or
reordered frame gives such a seq_num.

Drop a frame whose index is past the array, as for an occupied slot.

Found with a CodeQL-based static analysis tool that we are developing.
Both cases reproduce in a userspace harness under AddressSanitizer,
which reports nothing with this patch. Not tested on hardware.
Compile-tested with W=1 on next-20261116.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Fixes: d219b7eb3792 ("mwifiex: handle BT coex event to adjust Rx BA window size")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

nxpwifi has the same code. A patch that adds the same check there is
marked accepted in patchwork.
https://lore.kernel.org/linux-wireless/20261119095214.186808-1-guohongyu@cmss.chinamobile.com/

 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 06b005525078411..54fb52be963aadd 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -616,6 +616,11 @@ int mwifiex_11n_rx_reorder_pkt(struct mwifiex_private *priv,
 		else
 			pkt_index = (seq_num+MAX_TID_VALUE) - start_win;
 
+		if (pkt_index >= win_size) {
+			ret = -1;
+			goto done;
+		}
+
 		if (tbl->rx_reorder_ptr[pkt_index]) {
 			ret = -1;
 			goto done;

base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.34.1

