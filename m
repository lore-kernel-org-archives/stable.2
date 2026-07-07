Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFD3B71B8
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462110; cv=none; b=VXCeCp3dKyIf4IfBIKbQs1Vi0arMgNRfwe7jFgfiOVo6mrgJpHJ+V5cUKgEUKQ4zx+1S3kKyUVgZxR/bnHycLJP0VVlT87Q/jQ7pO6+vE3Z1JaLoFZ7PsX8zPCBsGfiHmMqk70FwHzfC0iLFf/R/OBA7n8qbRy5FbwmMFXisD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462110; c=relaxed/simple;
	bh=D+X3YsGJQPAG+YArlXUucHzgWYaeRVUvFG6vKuZQdTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWcqLcefymBOeT4AUsUlj1RT/0iPWBGgjpYzCD4BgcWcTokR7B12zlH1CIGKHrwAjvSgtWns77gVj/id5LjBRCOtSi5w4+SOQcS8ff4RG2ZkyjV1godvC30jdRVJPZpGIXsKlsH8FiGvkjJJHC3plAlGKeDit1uPEYhWs3CGhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=SvsVYU3f; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breiti.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b="SvsVYU3f"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45fd464d51fso18097f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 15:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783462107; x=1784066907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0Y00LTtFUh7icGquSYtKTdqm4NPmTd3M/HSxiWVIL0=;
        b=SvsVYU3fKlvDhkft/5a8whv5ilLDfuzwhgf/QTGRmmGHrpG0R3qEJmVlR2shOZHPKZ
         i2+aVFS6V90BxPRilUbYDqA+YtCN+bXb2zqbAUwAsg1PmJZL3ANyNAD2DQ/r57mGqMT6
         e9TL3plnMAAUM3MdS/74HcWYdhQbX0fN/Ecug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462107; x=1784066907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z0Y00LTtFUh7icGquSYtKTdqm4NPmTd3M/HSxiWVIL0=;
        b=h/5Q1WZ1ypvXR72hiW7fKyMNRJqdiswBzAqsuFTxghVjLjsHrz1/JRqbYKPO+BhHpN
         QGQ8XW/Gn+OFS075SdFy0OajXRjl9KS6aaaPx5yRnKimTrXQzcBV4MwdFABfQuhNUkl3
         cuekJeDUSFSWCIiFIbXAsk7qyZW3PQXTYFtgUemlhtqFu8imsBpClRb4x1LBWHseM+cl
         jqjNjT9clNgOg9yLTmMZhDkIcAArh3sIS3xqCxAdFLI1lOQ23bvdxAZXabMko9aFAH8a
         5lJc9M20a0+9gZbDUVL9fwf3T2y4NEkHOFGUiVsIdh8xWjBMQP2rdQGIPH5VL2Zp6+y9
         gpMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqi74HnOyChoZRzRvI59z3haoyaHRemT4o5h4lOHzOTgOnr5nIjrsSvkhzkszY8aHeBJKhde78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlisZu/iBWNiyZYeL/BzC/twRJCJBtpB6lyJ1mAd8fpw51988b
	fdHmnTKi5u7JIAn+vgYXZ66LAKZ5Mm6b6TGpHMoplhLjGgFlpV5gl15d4e6mCuEwycyzWUVBaQ8
	ViRXesiO5
X-Gm-Gg: AfdE7cleIMdY9LkbmTNqPN7WtDMNeIUl4w485Qc9cwV2eIHbM3VVYv/xezMCPJ3lSR+
	0DRkZtiDBVMFT7S7ZumtWlbplmp+vVZ1v4SW9mMrSV1SStPCGHCc0k6mPwpdKzWMJhgDAhUpA7M
	0AT03CvxQ+O5h35QO7siLedSmWa6MJmDBn1y3/bfq2t1wVLaPHw1dfxOBULJJvb2U21S2KOZGfr
	64SOcu15qKiONAu7YKEyAVJMt6cuUj+YHWYBvOmmwhWYVZxSUy9YPgt0tZW2Ulw8TvoyEk42Lz3
	8e2wbz7SIjvLrN4CS62EpNa8zwyAVJrKuEhlh0SeNgBxdEhLchjpFhDyzguiqDV0sQ1K6PwUgLO
	EZFmFIJJU1EqVOZUipWbSalXK/S6cLWxI2scgtxxJGkIRpc8PpkW8OAZsdQsKYAp7jlYKrvTsTN
	k3+s6fUPnX2KWTWXbGWmVNwiOiaDdOeF7T+Nmu72neVD3ASoDrtA==
X-Received: by 2002:a05:6000:1081:b0:466:6ed8:1e1b with SMTP id ffacd0b85a97d-47de665b919mr6903538f8f.21.1783462106858;
        Tue, 07 Jul 2026 15:08:26 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm38025856f8f.9.2026.07.07.15.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:08:26 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	bre@breiti.cc,
	bre@keba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	yong.liang.choong@linux.intel.com
Subject: Re: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on unchanged mode
Date: Wed,  8 Jul 2026 00:08:14 +0200
Message-ID: <20260707220814.109028-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <abd431d1-2819-4dc9-97f5-8e2b2ceb2658@lunn.ch>
References: <abd431d1-2819-4dc9-97f5-8e2b2ceb2658@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Thanks for looking at this, and you're right - the runtime case is the
more dangerous one. If a genuine interface change (SGMII <-> 2500BASE-X)
happened at runtime while the disk was live, reprogramming the shared
ModPHY LCPLL would disturb the SATA PHY under an active filesystem, and
a failed boot would be preferable to that.

Two points of clarification:

- A plain switch change does not reprogram the ModPHY on my fixed-PHY
  setup. mac_finish() only runs a real reconfiguration when the
  MAC-side interface mode changes (e.g. a multi-rate SFP moving between
  SGMII and 2500BASE-X). On a fixed copper PHY the interface mode does
  not change, so changing the link partner / switch does not trigger
  the reconfiguration.

- The runtime reconfiguration path is not introduced by this patch. It
  came in with the Fixes: commit a42f6b3f1cc1 ("net: stmmac: configure
  SerDes according to the interface mode"), which added
  intel_mac_finish()/intel_set_reg_access() and the PMC LCPLL
  reprogramming. v2 will only read the current SerDes rate back from
  SERDES_GCR0 and skip the reconfiguration when it already matches the
  selected interface. At boot that suppresses the redundant reprogram
  that breaks SATA; for a real rate change, v2 leaves the
  reconfiguration unchanged from mainline.

So for the runtime case you are worried about - a real ModPHY rate
change while SATA is live - this patch does not make things safer or
more dangerous; it only removes the spurious boot-time reprogramming.
The broader question of protecting a live SATA disk against a real
runtime ModPHY change is pre-existing, and I don't have a board that
combines a multi-rate SFP with SATA on the same ModPHY, so I can't
exercise or safely test a guard for that topology.

Given that, I'd like to keep this patch scoped to the boot regression
and leave the pre-existing shared-ModPHY-with-live-SATA question to the
maintainers, who have the hardware knowledge to decide whether a
stronger guard is warranted.

Thanks,
Markus
