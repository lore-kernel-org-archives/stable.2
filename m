Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D803E317F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540820; cv=none; b=rHqVIogbc/pL6XlEkvlmbWiz0KR4SnIdObz5/2moOZoCkhSIM6FtgSQT+ERsnnJR8V5YZ2zu6xUo2dgy4GRr5DzQxhCU5gT6X3JnQwpgNJ46uAkS9GLBN+pupAks2B8E8l5snz8bVtwuE6OGmeT5h7dHB0XkHQPUQZh7x1OyiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540820; c=relaxed/simple;
	bh=F+lBVtCc74FW2bXar4DlVxLIlEpJjq5enJoyfnmLVMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0itfnhq2z9lIuSEQLSmXf9UkfMFUq2PkYgQOhxNP+MeWD1f82k5c+kJ9YqNwAyvIqsgj0c0DefrST3zHI7iXiCNawym0KCjftiODyIK09i4HKIZtSQ1o5A2LczxXB9qIKeKmiug1NLGu2PXYqK/5TNr6bS7aHzXuYSix8VrX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfZuvjNS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfZuvjNS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c7c61b5292so20906465ad.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540815; x=1784145615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gqxvN87Cdysjugpj1e36xLbJ27hsww7lojnM1d760QA=;
        b=FfZuvjNS5UfNo8BbbsYZLQoihaICnxxKNQv8eyeHpo7bSeov3QZ9641JvSSsQs+hSF
         f3kHqzvm2ddZBdlo6bojRgzeLkVNdkxjuaHjM9FUsrxFU9RgkiEDAr8pc9gD2lW/MuHq
         fjRriNAaiTeJlPAmrZFGOzIuj18yiblqnUiF1hcui/iTpcnUIqkCba68pJgKtHCfKy3k
         h93rGiOoyEIQEFaoyBO4r39vVWbwTp9/LJMXCbgt7Sd+D0n3GdqWWk5ifQ2lwinhHHb3
         jAqDhZHVRaZjMNRtME724UU/VMipqbyQKxX9iMUq8lUdzRmx4Yto0Zc4IvOSIp+ylfAZ
         6Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540815; x=1784145615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gqxvN87Cdysjugpj1e36xLbJ27hsww7lojnM1d760QA=;
        b=NXX7Q8eYPiwJIcIgk6CaxkzIgSYmyyoDxjx2Q/WaUwmvwgrPUxj4Bm3yi7J/Bg/1r9
         5azWWYnvHGS1LMdycAmY1jCE3EOtESL3KHxUBYpLcWb+YydVL9on42kkdsUxHthRQBLS
         t/6DkexZshr6Zsx4IUfyPHgVwvHfFNG615GfW9M4Y0/b72LPnv995+U6d9O+hc96uU7F
         xKWNl8tBGZyIzhGC/NTgmIjmzYNzfT9+nn4J7U1/Ds/+YBMP9F9hoy6rJdXMnA5/SGfv
         yekRNhAyxn9naOanwIs4Pg94NgAmL6W12SsjElCmdrYArdWT3bmb8WkOOrtt9zbg2tKU
         vDKw==
X-Forwarded-Encrypted: i=1; AHgh+RqT1Hy1SYTM0RanwzYc9CFATooXWk9fFiqNQUIkDOazwqZ6mJxhpkK9Q1E1kvE9i1TmH171fvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+lwWF/uptlDSjCmpmtVNJCDVf62rEmMuZGzgJGxJmo77O6WFp
	2snpzqdhDJoSzzhONYSRP/XiEOBx+LjDO4MolU8mgrBvCi72aEpbIxYe
X-Gm-Gg: AfdE7cm3wtZ54ZzCko0SmCI2ge6qJK9rzLzFUivWfCPUgQSjj175FhaIzu4F8Ygk0R+
	U+cQ+TaFgBp//VMuN0XuwWxaA+UNWhF6KLcaA6/TRstyIy3PxyaNbAtN4QLEoPeS6FSYqQoXpva
	95lxaELsMlgsfhkX7ArlhG3GxfA5qh42Rl7MXltY2uerfYihnCcZwzJ+rmCbsVEONoksCqNSf+F
	Xfh9si3f7A0nj3emapP0o1MqMCd7zte+W1MBzfTajjUea/FuqQ0JEGL3w2yPyW02Nv7pdOx8eYG
	s40INjagqXQBA1Mdz1NBYlxdBHCfVjuiKNE4CcQPxHBoUlAJTrabKLBq0SJwf9eLM4wxtRhg1Q6
	gaocwPvv/Yaglk1A+tK7nL+ieIoJ2q4EFfHfXdOQNXeRxL1Ry0ltzwGSsw1/RwOjHR30L5VJh6f
	MADkAly2+iu9k7uUoDci8TmRx++go3tIo6mW1RyfM9LClCSCp0t9g5+fbE+gm2BmU=
X-Received: by 2002:a05:6a20:6f04:b0:3c0:b4f8:bbfb with SMTP id adf61e73a8af0-3c0bcfea571mr5202502637.22.1783540814358;
        Wed, 08 Jul 2026 13:00:14 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.13.00.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 13:00:14 -0700 (PDT)
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
Subject: [PATCH 6/8] wifi: mac80211: validate S1G TWT params before driver setup
Date: Thu,  9 Jul 2026 03:59:09 +0800
Message-ID: <20260708195911.84365-7-enderaoelyther@gmail.com>
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

A received S1G TWT setup frame is length-checked in
ieee80211_process_rx_twt_action() before it is queued: it requires

  skb->len >= IEEE80211_MIN_ACTION_SIZE + sizeof(twt_setup) + 2

and then skb->len >= IEEE80211_MIN_ACTION_SIZE + 3 + twt->length, where
twt->length is attacker-controlled. twt->length can be as small as 3
(the control byte plus the 2-byte req_type) and the frame still passes,
so only those bytes are guaranteed present.

For an individual (non-broadcast) agreement, ieee80211_s1g_rx_twt_setup()
calls drv_add_twt_setup(), and both trace_drv_add_twt_setup() and the
driver ->add_twt_setup() callback read the full struct
ieee80211_twt_params via twt->params (req_type, twt, min_twt_dur,
mantissa, channel). That needs twt->length >= sizeof(twt->control) +
sizeof(struct ieee80211_twt_params) = 15, so with the minimal 3-byte
element they read up to 12 bytes past the end of the frame.

The broadcast path only rejects the agreement and touches req_type,
which is always present, so it is unaffected. For the individual path,
require twt->length to cover the control byte plus a full
ieee80211_twt_params block before calling drv_add_twt_setup(), and drop
the frame otherwise.

Fixes: f5a4c24e689f ("mac80211: introduce individual TWT support in AP mode")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/mac80211/s1g.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/s1g.c b/net/mac80211/s1g.c
index 5af4a0c6c6424..abc338e22e59c 100644
--- a/net/mac80211/s1g.c
+++ b/net/mac80211/s1g.c
@@ -101,6 +101,10 @@ ieee80211_s1g_rx_twt_setup(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_twt_setup *twt = (void *)mgmt->u.action.s1g.variable;
 	struct ieee80211_twt_params *twt_agrt = (void *)twt->params;
 
+	if (!(twt->control & IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST) &&
+	    twt->length < sizeof(twt->control) + sizeof(*twt_agrt))
+		return;
+
 	twt_agrt->req_type &= cpu_to_le16(~IEEE80211_TWT_REQTYPE_REQUEST);
 
 	/* broadcast TWT not supported yet */
-- 
2.50.1 (Apple Git-155)
