Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729742A144
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448920; cv=none; b=h2dkFsKsuFXkCeuhb+l10nhqS7saN4UgwLGmUiI827r2tQJqZV8kwDJs3FeDWGM2JnVnBBMtj0RLTDmTJjweZbd5fVsAXi3PAgR6McqDYDjbehGjHJr+UOMSx+LLAIGLw4riALnZuMH9MrjpYIzHRf3wZORG0xmTIkQpkqkTgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448920; c=relaxed/simple;
	bh=+otw1eq6KyhMTfaoPWbIHySEFgArc9xKFqFzMJEX5lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz/qTRLUIlKPELiKUYPWuCzPRH+gfx8ExWcRpVPAgZLgqgyNcME1knSR3dXZ+Lf0iZx2Nmetzr5R+DIWFTkep0/knRk3IgrXeg8wKV+9eKv8Wg59qpCqlij56nQ1wSJs4FU5NiYmCyfrlZVPxGSf/damDGBDXF/xqF2cfIETO+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyNnUwRc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyNnUwRc"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954aff6088so25748925e9.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786448917; x=1787053717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7GBaWQ2WYLq6Esgqzdu5T5UPODeDao8xF4/EzY0gw4U=;
        b=XyNnUwRcChb9TMe3kz01GW5IITe5ts8r9FCC+Whp20teKyu1qMPA4OYSB3n40cyc+h
         n0Ae6PpM57rDBuStXBk6dEBOs5lLO5fFgnhzmgJHuyqf4BquGmSjOm+LdLXLIijio55j
         RPe83bTdQXVodtCK6xidqFx+2bgpx3UZC/7gmg9jWG5kEVgizMMFN4wEEZgzsKoOh3s1
         BgrezF8qeMZaG6lRYYTNUGPIm+RMbJ81HGtFa7zNr/nroA+yqLTfB4RygZikqe/RvKBm
         m6nipX1Ip/j1xSfa6Dhi6GoN24OxqzkKsfadVxXAxUg9fKPOnbfrseEPjpiDe+1AOGVg
         VgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448917; x=1787053717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7GBaWQ2WYLq6Esgqzdu5T5UPODeDao8xF4/EzY0gw4U=;
        b=lzMH6syUYW3hYcXUsu9T5ctF+7ozOkzGK6p5gI1Txx9RJcSitCI10XeAXj/QO3lmDl
         9iqK4rWh54HaBYVJL7L38+q3ewW4DD16O5uEoEb0+WtMSaWXBqje1/r4ukzqSomDZNpm
         xDEXMYPuIogJrXpc5lcDCTHSmNR9Bjg9ngJWPTXqSqsTsrn11pVQDWG2b+JYSfC5YgyI
         vxFM+fPWzsSBzXFgSUOi3Z5uVit1cBeMWxpm+A3TVwO4X/fW6ZGF8hY1/SFTUzguvUYz
         jcb+V+wvjXCpr5HSzDaUHt14TY5nzunNz7K5u/izn0p/k43Bu1VmLdYizVS8ddaQ5liD
         D34A==
X-Forwarded-Encrypted: i=1; AHgh+RrAji+dTCIWBp1ZG9su1+D3mCaI/c6CjtORaVe7vF0L85Rj9BGb1RyuCPqcstbWoKTjkqrA0b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsW9BikxWjgOyWFW3RdMrnWPlGvx+WZcPYXg+WcpuZGcUrisjk
	LBQQhyPtyiEiV9WvPNn+K4u4dVYblnE+BYsi3fdHgu4kxp03v8PJgsIt
X-Gm-Gg: AR+sD11VjsxPZEbCAX54HQ/LcpzbEc24DYMCvHIQG2pxQWtw6+EQLjV2QUOgBG1wjjq
	vp7VRS1/XyAKsE9ohCwvaj0n/jGIzWncMWiKVrXEykmqTco081Zad3vmBBp0OLPWJsW2c9S7f8P
	K9RokGgySYsWJL5s5VEe418rLGVnQsvD1aVMIhpYsT0hf3/oD7SkxRabyFyj2EUekdze8+ZIpyV
	MpFAatWqZ5PRFx/lnEHdyUIsCOFruc7qnD+4LhCTx4GCZODj46pxMxoU5FEVbkMew58Lzcklv77
	0a9wuJ0b9XqSMZpiwuhYLPJEiuaGTX17So4CEcyPAADzrI87ClrShRRhkvTHyOjHJeWRCnzWd/M
	gtWalZ2akUa4exCbHYBSagNE0BCqtaCq3f8uS+/FkuCnyPWgYqRFCqJ+6n2giGsO2Uoyu7LB7kb
	F6EUToFq/lybxB0tnzZd4pLB3q2FRFmjxOIm7hoJBWQooXtTwMJavzN8bRyiKa3bX6SgrpCLOuG
	hGciYMF0nhqZSIu2LsmEg==
X-Received: by 2002:a05:600c:c4b7:b0:499:4d4a:4990 with SMTP id 5b1f17b1804b1-4997840200bmr41295815e9.3.1786448916394;
        Tue, 11 Aug 2026 04:48:36 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:cc3:6030:41cd:1906:c1cf:983a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a716833sm3403105f8f.28.2026.08.11.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:48:35 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Jie Luo <jie.luo@oss.qualcomm.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Georg Seema <georgseema@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] clk: qcom: ipq-cmn-pll: keep the CMN block bus clocks enabled
Date: Tue, 11 Aug 2026 13:48:31 +0200
Message-ID: <20260811114831.85417-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805193638.15327-1-kuncy7@gmail.com>
References: <20260805193638.15327-1-kuncy7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recording a tag that came in off-list, so it does not get lost: a second
user hit the same hang independently, on a board neither I nor anyone in
this thread has touched.

Georg Seema is bringing up a Cudy P5 (also IPQ5018). Without this patch
the board hangs during boot; with it applied it boots reliably. He found
the patch on his own while debugging that hang, and gave the tag on the
OpenWrt pull request that carries it:

  https://github.com/openwrt/openwrt/pull/24653

Tested-by: Georg Seema <georgseema@gmail.com>

That makes three IPQ5018 boards from three vendors - TP-Link Archer AX55
v1, GL.iNet GL-B3000 and Cudy P5 - where gating the CMN block bus clocks
after probe kills the boot, and holding the reference fixes it.

I am not repeating the earlier arguments here. The bisection of the
fatal access is still on my list and I will come back with v4 and a
corrected explanation once I have named the register and the code path,
rather than before.

Thanks,
Stanislaw
