Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542391;
	b=IYyBOcMF59gkTBvCxZyliDO4sfpq25zGG0wx/Ot2Ar9+7dPlobhF/gFej/43PPNikJtt
	 DWr7yPWDmyj9BO+ji+J7Bnl72AEUG7vzE7Y6A/hVd2SVP30QwKnIp5EAnhyj5Z7MSJsas
	 HdyTEJy6DvkhJJkyL3FxlaUHWMfFWqFVScGODPUC2Qj+BF0tntNWdMER/TnqOg4xVJlVB
	 U04R0Lf+VWLNuNYNt4EhfpJU7yKlkJbkVq/DiPPWkpv9GKEF0svzhkshAbCIMbrzmVv57
	 /XFJu9Bd/4i6zJVRL1FnQpNRBgl2ESmLQK9svfRgwTQIJkuGo0SloVKvCKKYcUbKnuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6FzGEAlboCDO+hR7+aZbs5sdkOEtttyfXNAxL54wV1g=;
	b=IwU+6ujit973mWLiss0iO3xnk9jzsUhIu83YmPSTTKJTvA4MOYARVUkNaajG6YpmAqSS
	 9RmyPdFQdN+t56pLxOsgPc0QQRi36Y1Z0dHYks2vb7sPFwaaRH6lu0nGARxJhHQngjqFt
	 grmwofZKJNzHVer7hJL3mR1J0xc4OHC1HrKreDh0I55YMTacphiN/TJxxsEnggmSOLlta
	 VjKZq5NlySLSYfHME44e9M0RstEzPMYcPilIUIPqlIRAfg4q+Nb1KafcCUUBpkuLGR0E0
	 70sr4HLfcexB4bL/gwPs6/PrxPVDvRVd/XwEikTAFRF2KUGqjH1ht678z6alvCw305g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKzSzSxZ;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDD606A32D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47CDD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UKzSzSxZ
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e46e449e8so3119869f8f.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795542390; x=1796147190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FzGEAlboCDO+hR7+aZbs5sdkOEtttyfXNAxL54wV1g=;
        b=UKzSzSxZe/rBogTWMgQUwqoy5hQNNPs3K3wQ4VrW7G+GlN19pr42/QXX5xnRzYk1Ey
         hkf03ENDW0g3vM/Tr5llw2NUSF4L9A9eWP8imgZmwuAU5X/fIHc05bQBpoIcJru5RQ0z
         ek1yC9my/97YtXAA9qC/YqONIXxpU3QNvB+LnhCrbITrRsz2o7vi5dq8kpQ6aSoSVBeB
         K1GuYwoGWbjFIkE1TYkYiKDj1tflfhCll3mCPG6d/gxuBcYyV8cxZzthDjyGglUYikSX
         tKCGkMxyIx0RrY7rAsjwn7ZfhTneF12GzW1CPc9aiKmO8dMcykCyR5CI8nwFxKwvX8dC
         v95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542390; x=1796147190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FzGEAlboCDO+hR7+aZbs5sdkOEtttyfXNAxL54wV1g=;
        b=PHe2lTImizExRqCLZMbFAwpiByNXGbUtv0Sngp1GdK74Q2knMkK8tYf6rHCdQFy+xl
         pt4z/Rn5CjVeGXH3qBoNm3oHFsoRZX707hXPfc6t2tLjCDoazi4bMfXOeFgE0PTrC32k
         hJzkBcIL+NJvnoy/fSzUcAafDB3bbTTsxI2ds1GJao8B2UKTtbKK6eYVwqlGsoZjwJ+e
         YiQlu1iN3c7FFNnIx7TNBou+ORjjmdztJ6oQZ/T4jGl6st5VqVHM0uk5sIAKbx4RznaO
         03ezbp7Y3ok2zYsqWwkexXSGjBSzf0eXtqeqybsjgjGdZnlWCKKY14Qg/QQ1G3oeiCoL
         aYTA==
X-Forwarded-Encrypted: i=1; AL+hErHK653MqyyJz+eESK7QIMfQpNRTpCj2i6E7HrGdOMhBSFGlayfqj8+jSwB7bxgoMMRevBFOVUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/v5t4mCMq2uss4kucojPndc6xP2K1RdKyaktldJL27AxBuFs07
	ILvuVoNt5kau47bXXDw4sYQyGig/a0TYEMCpi8F2EQStKdr5eTSU3Lw=
X-Gm-Gg: AZFdTZe9wr4bOH7ghEP9lVaF5pk4WtvouwTqInLekvB0JfQlC0L1zE/DapFuSKRhZJO
	JAi5bQGhumWqVq6f8PdgRYmvuwGW+NSOOU7I9rwX6LYZQMn9Px49CNXLagvoTkPTIQupvsKdtv6
	iuL63dOhberAkN3WqdOd2crkcsSnnJfas1xGPFWzF0RfwS9r7Oj4cqu4pbRLJtU6sbSjDg4dMDQ
	zXY9P5IhzFoRtK2cHcTlZe2uzzTHl6FITXEEv1SgXvu86aObNA6ff99BNde2j364VZuewrBulfp
	JsqQJOpcUy2iYlNpMXbemyye7J06TN5+DH6Tii7Q2q/TeCBqvLqcqlsl9mlJLW7RzF+ak/TRKZr
	kBZjaZYXVQBlUCkRAcaW106trOHG4fgAOOMs3sSurHBWXnTZey9o/ZDQ0L6IXp7U0tpwtkhVQk2
	5NoIGEO3jw1fK8+PRoJDDhlV0ipnKY8mM6xSXKTO64dyV5Ko99KdbobYdLcp6+DGbdYI6rKwhEw
	LGTG4/Vkhj6rKj3T6GhDE2IjMgWd36CpilnwohxwJrAVkrD+HlXludRMvieM9DFxWxiovZ369oN
	ONJnydJqFWn632o=
X-Received: by 2002:a05:600c:3ba9:b0:4a2:1050:aff with SMTP id 5b1f17b1804b1-4bb8881c741mr366049955e9.6.1795542389475;
        Tue, 24 Nov 2026 09:46:29 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm413261165e9.12.2026.11.24.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:46:29 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 1/3] wifi: mwifiex: validate TID in ADDBA response handler
Date: Tue, 24 Nov 2026 17:46:18 +0000
Message-ID: <20261124174620.1572200-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124174620.1572200-1-tristmd@gmail.com>
References: <20261124174620.1572200-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

The TID value extracted from the Block Ack parameter set is a 4-bit
field (0-15), but aggr_prio_tbl[] has only MAX_NUM_TID (8) entries.
A value >= 8 causes an out-of-bounds array access.

Add a bounds check after extracting the TID.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Chen <jeff.chen_1@nxp.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/11n.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index cef8a55427dd0..7d249508e1a38 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -154,6 +154,12 @@ int mwifiex_ret_11n_addba_req(struct mwifiex_private *priv,
 	tid = (block_ack_param_set & IEEE80211_ADDBA_PARAM_TID_MASK)
 	       >> BLOCKACKPARAM_TID_POS;
 
+	if (tid >= MAX_NUM_TID) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "ADDBA RSP: invalid tid %d\n", tid);
+		return -EINVAL;
+	}
+
 	tid_down = mwifiex_wmm_downgrade_tid(priv, tid);
 	ra_list = mwifiex_wmm_get_ralist_node(priv, tid_down, add_ba_rsp->
 		peer_mac_addr);
-- 
2.47.3

