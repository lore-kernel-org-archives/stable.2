Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C57234D382
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140447; cv=none; b=BRtm4Rrxkk6QhgOjnzlCjsKwZuePjlAY/C9bSkshr1Se9CifxlTvjW60IicS9XVDl1YJ9cVriW3eFKPvV1gesd/8QYbnA3LsLiuQbsGCOQ8vIP8Roq8/NxrUO9reX7ulexmjm0WWTdcaCPFl7G6SkdJJNiK2H9yagMnb+GG7roU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140447; c=relaxed/simple;
	bh=lxJ9/R+nPocJAVyK7ncDpSazd9bCHXPMmaMpTjYhrIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IhUKAeFbRzBFRiPG1qp9qFi5ajiPu5h3sS4++EJIPUmnfpE+LzLnae8JESLXEtJew3JBNT3w5cg15gABDhdP9mvuwSsv9j0cZDwcMerWkOe5D13ZEfsxpDZNwMkkz/T2w63JiZP3POfBFvV+JBV62o8v6ZLmGgM9SEM0u27pCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DSAwTYht; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DSAwTYht"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b63bd2030so73863406d6.3
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792140444; x=1792745244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBhmuSMaG4Pa2MSUzOSH5FgUKD63s+LESTxgG06O3FE=;
        b=DSAwTYhtVkLiKZR4HzGQ8sEOxcdTU/lsY7UW7HzWEVpEdhi5EOa3LMZS6Hvcelez9o
         Lh/lsKgs0V2yAZmLY8Wc+AlHObKi1JSurbcujZlMK3gZooHmCqgIdEy3PgAgH7gTmpaB
         7fhEDrw7vChLbp/QnqyXhwwtp7Ce0ACC1lNJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140444; x=1792745244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBhmuSMaG4Pa2MSUzOSH5FgUKD63s+LESTxgG06O3FE=;
        b=WO9LB8yWAsJ2sTr71W1ceOe6qOaQ6ixEeUBHvrihDGDLr4ikVAMm5o8/ygGBK1HTAH
         FWY+qungPfTDxBFfeKhMQmUiDMGfP+d4GL04EUU+El9zo1s6x04EB/p+dmIlrAPQuahu
         wniZdX3sMdiPLOxfwJAPnhpZbotKxc3kzTSEanTnXWkuMznyhrVFl7y9XpiFPHn8d2oU
         9RoMJ7OroBcVRnYVVvRssAUrWxt+gHY+4jFLOU7rjK+4W8e44NX+n8qKwQr6+9N1LHCl
         DhZA86JIbAR4tMFO8baHCL4tQ/fSge9D3YBbxXyZbzmwAsRSOrka78f0I3CMZS5py7uy
         ItGg==
X-Forwarded-Encrypted: i=1; AKwUvBz4LTVaHtQ9MCPCDVhE/J11XIxsxI1OvTWSCHopaxCnLawuZSEH4YyDuOqPyGJtMmss0grqaFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYISjjiaRNVF5a7p74NL1SXfjLLLaQN5DpeGDGeFVXjpmQr0qiwn
	75kptSrLIYETf9A3ua4ucKedTdxpnjheXv7sRo/eZqcsB9cZScnz5MBd78LpLN/xgCFchUnVCXY
	xUMc=
X-Gm-Gg: AYBFou1ETgefj+u144e8AqnkJCDfiXBu6cfyLKd0t0HiFMQWFQhhIG0QNh76L58wLwq
	1gm82fTLeOBEdU+UiRlTeeNgXp+cXTenyCMdEezKyXpsyIh2uBVSa6pBtsRWVKW3tnsJ1P1TAoJ
	hSEGgtis9hSR2nqa3vF9916pYSHZ5uTgksn055+SrW/wrmJE3HEv9kapZ7GRNSmv21yt/1KmGrV
	d8SHi7bHVrPn9TYzyW3Bmdm8qhVjEHEF363vASGj+wMrNoEWnifWsLGOgpp2IfBMVoQTXx6+47H
	p24NdqYlbIn2JWEiCgSeFlTT11bHlFWu+88gECLQn7XUFdRAVvXzZ8QBHSIEIZRhtYrSczHJ6rd
	xKRvdxVI+xj55ZAJvkMdg5FQvuBY6Q52/tvkMLkeithEiJelK9edbbjV725lr5pMR8gUW4+dGmG
	XKrw4uqSWtllhpjxwDYDchToooTc9ddasggqHH9ESIlcrb1Qt3s11nOSuJQevbQEOxS39ImhLrl
	2kamxO/OtS0sl1eKkWDgQB5BZPAIAdcQvBNfFsPXkJT
X-Received: by 2002:a05:6214:240d:b0:91b:9136:d303 with SMTP id 6a1803df08f44-91b9136d5c9mr213297676d6.10.1792140444130;
        Fri, 16 Oct 2026 01:47:24 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm17863946d6.1.2026.10.16.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:47:23 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Patrick McHardy <kaber@trash.net>,
	owen kwan <owen@verialabs.com>,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net 0/2] net/sched: sch_teql: fix transmit-path regressions
Date: Fri, 16 Oct 2026 04:47:17 -0400
Message-Id: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two independent sch_teql regressions on the transmit path.

Patch 1 makes slaves_lock safe for the hard-IRQ-disabled netpoll path and
for PREEMPT_RT by converting it to a raw spinlock taken with IRQs saved.

Patch 2 fixes a use-after-free when a lower virtual device consumes an skb
but returns NET_XMIT_DROP rather than NETDEV_TX_OK.

Jamal Hadi Salim (1):
  net/sched: sch_teql: fix slaves_lock IRQ deadlock

owen kwan (1):
  net/sched: sch_teql: fix use-after-free on lower qdisc drop

 net/sched/sch_teql.c | 49 +++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

-- 
2.43.0
