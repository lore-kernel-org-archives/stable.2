Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5973DE44C
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540777; cv=none; b=ifGhIl9tQ4dWhXSlrmIB8KOnfqah9HDrwrKOIjAb4+zhmHgjmbJ8Im0884qt4YK66miKs2DPnccqml1+hclCaR70naOm3vxxoeSYQh+v+Xo89pOV63f6D35GrG4QJHcQaGVUnvvwB6ZM0hmB9BwBmXUcou8rvPruFHO2ENMyThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540777; c=relaxed/simple;
	bh=DArdENvMvZauhzBuODBJvzWCeC7C/HSPdy/5V1YX23g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piavc/gA0FjChkmrZ7ZMT0Hi4h/roubTiAq4yE2jgZd+f28Yio3oVlaqg/72L5jBMR4IjYO10WnByzslB7/V7jqL/Ty8w0V3dUN/xmCIDuf5yt9NR8dY5bl4V/7lFof7zJxOaZCS1g4R2Av2utmBZ+Yc5mn/Kp2r37hGu4Ov9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKlvhDSr; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKlvhDSr"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1023000a91.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540776; x=1784145576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K434/OKl2jqJkcKKF41UxdXI1B+RJY0uawUDIIMVgbk=;
        b=mKlvhDSrzW/azRWt3iDwP+6phjmVmCMzVuwlhWFsbeCV6zfQJoKozFMIaIqiQVzpUX
         9fPXbdGbBhGUO5k6UTYu+PXOSGhCXGmINBrXoxcOBvLBeG94/3IW+mp51vt8yG6phkyj
         U3B7Jac3HbgrvFWUkohv5JGKR8nYxXDQ5mKhUH5JwO6+4bE8Cot+SvodpoqCav9s356j
         59qnpuuPhNP7YsH2ifOaxdSjiLyhxTaByCWs0C4uRHWipVJu7/nkw7DjpkBK80qH+5ON
         4O4IfkkBCV3q869VF8l276+QU+RDxdGwvu1YhhlbLFX1ktIWJZxrfBoK4Cqq5M6M6xUv
         qEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540776; x=1784145576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K434/OKl2jqJkcKKF41UxdXI1B+RJY0uawUDIIMVgbk=;
        b=VqdBTQuKSv2tZxuYhB4DtVN4pFtFU7g/YVFBPFd/egBthThFzrhJzKEyYABV8bqFtl
         Sx4AyGlTsuGgXkX5QTPnrMfU1zdM5Y9sDhM75pNAxiUjjkk8EJqBV5WWDzJwH0McFrwk
         RtGYb8Wnh9Afls/772nc7fYV9kmJVXjfwe/1N4He+wjynyDlMePgTKB+R10l1odbavtR
         sxa08o7soT2WpUpo86wXjwLNDgxhMu4XjncJwhTbcOdA+gZ4+w1VB8INJ9wKec6uigzs
         azxQypXpIOGgRHoqqtlWJlzSwUbsxG1gEgTE3vsc3Ithwa5IbYGkfNUkPP8Ik8KjFx3E
         F3YQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqv6kTcjfX7x2tqywVH2sAYwIvLk1o+NsyQD26q2juO/x7r+4l+YnabatXihAlaMg7oRf3bW+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywez1NmBIQfwU82lzd9uzaPKeTeN8uwF0F3hhDfsVL73hQdS8QO
	var7xp3sByvXi4LhCFQusLVRsOwvYptH5L5xsQB+Kdzo27yKU79ev4OlT0R/6ke6E29FwQ==
X-Gm-Gg: AfdE7clkt/L7fgOht1wyLuG4+sWIsYd1LqdsWkz6jg2hrVpV1UBuJ62hMLT9mFaP5Bg
	IgbnYosIHCiWxZWQAZ3J9qFazC4QqzqpnLhjSDiUGonjvv9OlZwG3M6A2dastnQO5j4sGOL6G8f
	SkzSqns1XafYR4Q+mKumH27SQcLjbtpHQkAsP6yc8iN72vt7SStZYlgP8rBUgX43xg01x4wd24l
	Tp5BKif9uwtTfP1e/0CdEd8XdNjNP5fX6OcajKqdNu1Lu1HEefdVAXZLFxVxxsXsrcUKJWeQGIO
	WhZ61yH6hNf0ui79lH/OVPJfVT8/JIgDEKmk6moPZaSL72foq6niRYk0pjtkHWPNTHtbPWNxtsu
	VeO1Uy2ja8qnAkEeUJ+wgqT2rxFNYgm2Pxqiyh3Tlu9hgkF6SBvOIjzJpQfmfPpRjdojksl6gSy
	WVgitgoW/4mhPuHElNParAVJ5VwdVEH5sxWsc3egZUGgkmYFQoduaf
X-Received: by 2002:a05:6a20:12d0:b0:3b5:52b4:87a7 with SMTP id adf61e73a8af0-3c0bc8ac06bmr4890359637.6.1783540775513;
        Wed, 08 Jul 2026 12:59:35 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.12.59.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 12:59:35 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaewan Kim <jaewan@google.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	John Crispin <john@phrozen.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/8] wifi: mac80211_hwsim: clear PMSR request state on abort
Date: Thu,  9 Jul 2026 03:59:04 +0800
Message-ID: <20260708195911.84365-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708195911.84365-1-enderaoelyther@gmail.com>
References: <20260708195911.84365-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mac80211_hwsim saves the in-flight cfg80211 PMSR request and its wdev
in data->pmsr_request / data->pmsr_request_wdev when a measurement
starts, and clears them only when it reports completion.

mac80211_hwsim_abort_pmsr() never cleared that saved state. cfg80211
owns the request and frees it once the abort callback returns
(cfg80211_pmsr_process_abort() calls rdev_abort_pmsr() then
kfree(req)), so after an abort data->pmsr_request dangles. A later
hwsim PMSR report then dereferences the freed request in
hwsim_pmsr_report_nl() and completes it; a use-after-free.

Clear data->pmsr_request and data->pmsr_request_wdev once the abort
matches the active request. Move the wmediumd/virtio notification check
below the clear so the saved state is dropped even when no notification
is sent.

Fixes: 5530c04c87c5 ("mac80211_hwsim: add PMSR request support via virtio")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 956ff9b94526d..bc0818b525224 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -3841,9 +3841,6 @@ static void mac80211_hwsim_abort_pmsr(struct ieee80211_hw *hw,
 	int err = 0;
 
 	data = hw->priv;
-	_portid = READ_ONCE(data->wmediumd);
-	if (!_portid && !hwsim_virtio_enabled)
-		return;
 
 	mutex_lock(&data->mutex);
 
@@ -3852,6 +3849,13 @@ static void mac80211_hwsim_abort_pmsr(struct ieee80211_hw *hw,
 		goto out;
 	}
 
+	data->pmsr_request = NULL;
+	data->pmsr_request_wdev = NULL;
+
+	_portid = READ_ONCE(data->wmediumd);
+	if (!_portid && !hwsim_virtio_enabled)
+		goto out;
+
 	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!skb) {
 		err = -ENOMEM;
-- 
2.50.1 (Apple Git-155)
