Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777277;
	b=EgEa8+FprT0STB8WHsJE2Py97UOT8GpOQgIy6ZDw0KEUJF/Jno7T0a/iZGX3JVixRWTo
	 SiMPm9GslX3oL/Gj2THgjcmuHWRAhgJws9xp71m7vLegogIVob81MGQSFQDcBrt3qevCE
	 Ypmw+pnEuPbXS2s/ZbmcwmxLnaeJY/WYZq6nvfF1zoPn4tCd1JC/ZqQ4YL9h13vNgr5n2
	 VGH3Uo0bRFIYs2aqxF/jlrUN45XrqZlVMTFHyi6c5NtzHfxiNoooRK8JZ2H4HR+yrIJGR
	 SgN+vTuNCCLbmtxZEYbjtjp1qP4bLjb1ghDfmVYLxx/PIw8D3WFKpQsNzniDJPp8aEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=truzcLzI1/fzEeSBbN3XZWCls+HY9QGypr22D9AUbNQ=;
	b=oo60zK5rnhy+TpHx8RL6ZbHbvTosyihPNaHtuMkNotrJCbCElsUIkOvlnNo5U83e/qjy
	 8Yq4hrGraiErJlvCfipxeNlcMUt5//iC3V9vY76ENiIZqton+KgL86OiERceJ3hOFdlH8
	 +jYrJw9qHdpFszWXEVrZnsfD//dVjDt8KaXYlVfbIosE56x/3x71Z5ydaJ7a+C76yxKuN
	 aMe6qP2Tc3r5kjBBTq7BkfCgizFZxpNG/TZji8RXlDkJA8yGP7vBbCN9Bxj5EOrwSXREO
	 7KMY3nkwvK4RTICpp1uXCYzuSglxtwny7Mn/I/gAVX4XCjP1UD28EsVMU18M99nXjzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fwq7HXJ3;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149F606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5149F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fwq7HXJ3
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a808f09021so8275141fa.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792777275; x=1793382075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=truzcLzI1/fzEeSBbN3XZWCls+HY9QGypr22D9AUbNQ=;
        b=fwq7HXJ3055YN84gik4gwErUSx/7NlBw6Abzp7HJ7SZ23AouCbTUXRGUqc2YRPxA5D
         Q/qIsx0eCtwq71y6UROQO0s94tvRyE+o74UOkoy+20GzDVNrwSXdjg87lmRwDEvBYiug
         tHGiLyCKPP/3PH9Sw4QYDFCiSlRfzjIG8RfHuw6EbRyNcPLrA+BfIyKrfH98Gy8gXqvl
         wk6jHPWeSSETItc++bdi9NftMuVAfrgCRxT0lLWpK3WofE4YWnKwVh72sTQ5mabdAMbQ
         PbBH97IAH5Z5WQGB+BKC76trV8vqsUTa4inKJA6J/sz04L/tAO872COL+f9CDA8AnLje
         8EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777275; x=1793382075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=truzcLzI1/fzEeSBbN3XZWCls+HY9QGypr22D9AUbNQ=;
        b=kWa9R8vug09Yiby2aWkv3Xv88xT60SGDoaS5gbSyJv46HgQl40ecnazzest581KyzQ
         djG+zgfQcoaAdB9fAEWqPoTqq84oBNDAMoYJOQJhjvgDxggM5vuD7yAmeUxAW63h1dHg
         fj4OJ00lw50AYeWyJEmfFhS5BKCvE+aEMteTWYgvPwkwDTLCuquwRvvtkC0ZXQqG5Azr
         QaUxxAM8RRAGlaas8xmIyAFG0PkdzFgANn2Dvo401m8MIezPLAdkrGKgye3PVSxtuqEn
         gQvRhWCPN2ArPegSTiNyTqGkCkXWYzUmjh4Un8RRV7XtrcunCtcc436msQ53lVMwJICW
         xEpg==
X-Forwarded-Encrypted: i=1; AKwUvBzYV0XYALx695ctWwMPy++5JqcBFz4T90oMflfYweV/PiubXfvwrvmTNzCE5/7Irkb3zW+EJjA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyPuu4OLoVQEJGn1I1lqKl+z6qe5EbdEEiP8V4xI9M3m1+Dnj7
	vpX7zb5HPapSsBCRWFkemxRmwrburoQCC4E5PpozNiFXjvTEH7OuwTKR
X-Gm-Gg: AYBFou0ptGfAH1FRsuwTMcGCM3WloCqC8sncYtkiM1PDPQpdtYB9USVtFiq0pBw+28f
	mdFyXjpvIGizfbE/gqtdLLrLWzwb4wObXnu4Y778y2k2RJ+7hYwp6Cwd5Zgm+pHK802E6S9Qv6v
	IPM+tQJc5uqZ4GPRvL79uXf/LncTNUx5ps9ot/NMqjdD4QaeWUJonflxcU0ToLufIGJwNzlmwOH
	NrtQTMr/DpJ3/HW5P3noeMCp8W26JwsmOk86AaVtHi3TmtW17FEOINRdHOwO7u5wp6ok8Qbug7V
	5NIvKroGexxelmKb3qMluMtlzhAwrLBUX/ubJzFAtP/H2YOjLNjylb970TbegYY820SznlNc+FU
	bsr7kfez8Ta/6ZvX9p0iU5E9GSsOnkC5vA0wrR8gQAD9U1599M0uzQLs8ytju2BI8nig6vc7Cuf
	P9CbtPKKIA/TOydYhhn5WAbRIAFufwUbOihmtn7kmb82HNobhFs/9HRaLvobNW0m3h8rJcTNhHD
	KFbzsPcWPrvQiVxNWjI/yFW7QeNA7lRcBPPdNg2nQPPQ2UXcwJzKf3+/+Pnc+A1jt/BLzoE/9RC
	qB2ptCHjiOKnWhzEt8xGBFWDziJYJUf87dPMIPbTjthBX+g4K2NDTzpAXLH2i50VxLn9aBKkBgK
	jH6sadQ==
X-Received: by 2002:a05:6512:3984:b0:5be:32b8:e32c with SMTP id 2adb3069b0e04-5bfb0b3e2c7mr1148573e87.35.1792777275127;
        Fri, 23 Oct 2026 10:41:15 -0700 (PDT)
Received: from x870steellegend.lan (95-25-165-240.broadband.corbina.ru. [95.25.165.240])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb670e8acsm59975e87.15.2026.10.23.10.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:41:14 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Igor Putko <igorpetindev@gmail.com>,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: [PATCH] usb: core: hcd: cancel giveback work synchronously on stop
Date: Fri, 23 Oct 2026 20:40:15 +0300
Message-ID: <20261023174015.54793-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
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

When an HCD is stopped/removed (either during module unload, driver
unbind, or an error path in probe), pending URBs are unlinked and
completed. However, for root hubs or HCDs with giveback done in BH
context, the work function usb_giveback_urb_bh() may still be executing
on another CPU after __usb_hcd_giveback_urb() finishes.

Since the caller may immediately free the struct usb_hcd via usb_put_hcd()
after usb_stop_hcd() or usb_remove_hcd(), the running worker accesses
the embedded giveback_urb_bh structure after it has been freed,
triggering a slab-use-after-free write detected by KASAN.

Ensure all giveback work is fully flushed and cancelled in usb_stop_hcd()
by calling cancel_work_sync() on both high and low priority BHs.

Fixes: 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH workqueue")
Reported-by: syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspotmail.com/bug?extid=a5b220cacb0618384d5a
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
 drivers/usb/core/hcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 8e8a5f59b319..0b7d30900f7a 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2787,6 +2787,9 @@ static void usb_stop_hcd(struct usb_hcd *hcd)
 	/* In case the HCD restarted the timer, stop it again. */
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	timer_delete_sync(&hcd->rh_timer);
+
+	cancel_work_sync(&hcd->high_prio_bh.bh);
+	cancel_work_sync(&hcd->low_prio_bh.bh);
 }
 
 /**
-- 
2.47.3

