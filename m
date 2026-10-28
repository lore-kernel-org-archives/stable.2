Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197356;
	b=UnpIY+M+1YgOplyykjri4OHBEOR5kC6iy08IvWuTMx16sUaGG1qMJfisTERTZaWh0v8V
	 Aj/1ldrrGNqrgUaU0HfPzmOxCku6x/Ic2qlPlzk7CuWgt6QoYbDUn3V7S2TomqVWtkK/3
	 tZ/bhsR4pXqvxPU4lXj//75aHNYIM7hrKyzlevVQW+hyAx5lg2xaFbNsaKp6XeOBSn7SK
	 kcTMVPRpiS55fewaGYVIxI8wyKX8a/nvOY8r0dkyfoubTt3VX2NxwXtb+vq0S6olTXSXQ
	 6GNlJnHrYkU05KQsDLjcxzTgZgByiGC5SjVdWS9deErRPr/Ej44XHOsxxHjKDkbtJwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R/mNeciGEDV4oliH8vu2vu4EuuS7Y9Kms2mXuzaoLDE=;
	b=QWAqUE6RpJh4AAELSSxJjKXDMPDHLe0lj3RfoAYTOoE69ePg4E9UU5HJzceUGjM1AZqo
	 52Dc0k1eqsqgEdsBvZgPjnQttyUCBQNFaUeLAy+byD64iSuudIHLgb5p03QaNyosjaX1W
	 G2/1pWjW2w02cjdfe9oTB6j0fcP3x8kKqFW/n0ZA1kiUkEH0D/6km8uynwPEqC/zGXlho
	 mQ3idEteyC6p6ynRrqc/h/g/i7/yUbJPzKWA2gvPXgVWx0lrw8MifdeDpoM66NnA+oX9V
	 UAEppnp959LSLpyCWnTKJKKgz6TEx2u2oEu0PS+m2Bt8owvdhadD38y/4TJTF1cbQYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+B9NVDk;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114E606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1114E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+B9NVDk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so855691a91.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197355; x=1793802155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/mNeciGEDV4oliH8vu2vu4EuuS7Y9Kms2mXuzaoLDE=;
        b=G+B9NVDk35WhIetAeOybgWF5FUaVx4PLG54HD67lQ+AB9SFBfBsLJ5qsiuhIJCKZiu
         E2zE29XFq3TMc4dc4HVw2SsISFGT30LsXCL9Hu+xtBhwOTXru0BJRqd26LmexPZQlRjo
         uEFruBiTze1LG7QV3EkRWIU24AwrEroLcjLJryAPk7GC2viNF2+DuyKqvV8N4xEiGId0
         f1tr0Vcfs5Se9zzStoE14FYUd78LkBnu+GfrnxqtGB1k0SjLtbWi6UCi54+cAJwFRsVz
         /HagYHytdWo2ObgfDZ0nsdduG0hRcGCk4ixMuATQrzPp76vab96/Et9Ishw25yN/L41F
         dDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197355; x=1793802155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/mNeciGEDV4oliH8vu2vu4EuuS7Y9Kms2mXuzaoLDE=;
        b=LT3hQ/Nrfs3h7cCCaIeDuDvw7UiqKiYHP3VahNztrXScX53KKMAXO2HtTyNuaLxLtw
         a3FmkNZ46FSpFqoBnENHRMIP+18nbcb2Le8Kyp0HjH9L/6Le5rApcMIq4GrL0DxQSh+V
         27+kFZ4tmWi/KQLUg2xRQ2J+0EOncdVfGFq8d1Bl0OSa8175f+vHLh9i2VynhunOS6fv
         ga6dyCSY0snuUVFhtKmPbbMVaOCIo7GXzwHgwEXiWWBvsuLSqwCpIxCj/EJ+Eul+xF1A
         izJB3Mv9Oeb3+KvwlwUIhob/j1BGXQRZL8511jXngwMIWNllvG542Px5oPg67AKMxzYb
         16nQ==
X-Forwarded-Encrypted: i=1; AKwUvByAbM0bu/s4gzd0aUD+O7ZDzj84o3wUUCqmz6x6RDSykVc91rYz/NDcC4iT0E9njHD5/8rESls=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFHqibU0f5EJqb8DcHi/De8DtgbYes+Jutz1NDb7fKV0vEkz4U
	qBtR4HSKHfNIFc8u32c6t3C3j0tadFThX1O3pS8eiYatrTYRo8MH6rFf
X-Gm-Gg: AYBFou08KcXoSntZCVZQJ8yjdzKxHL36sfkql191NpxQBZMc6cUUtIzHrh/m+TeXdt4
	Ews30tq8cyONpzOXa8ydpU9Rka2bxoUZO2iYF5KMrysif3fPzfs0eJRupyfSJSFV9EyfD0ryKLF
	Dg/4AzKX5QQYEm8GjU0cqb8qyOvUZ6kfEwkMTJ9UxC9Gr4BJ9V2O3e86fGuy9BDEF501L4tGJ/w
	ZLS4CfmJIVe7KYvGeIdOti7axf5yYe8Zsv/xwf8iGLCcQJskgXn5KIf5LCIWkeq5t2i1LoPhBlX
	rtcoFzUlr3RyUNdum9bq5oJfSTBjuiPF6XuFAvAv0fgDuuTdYKwNBVctwUbnH8qJ1nGypyg3zIx
	VRDIX0ZoyPqoyiNSzdy1+B/44GwkoeNxv1uuy0+8vMuzUqScge438U8QwxxKdvBjQF0v8yb4xdo
	x2SyNFVy9Ml1ZArtSix4Pdx+2Ig0I3tuXyy+VV9dD7v0ZjnYzz71JRr9YCmYqPbtb1YqO2RbHwp
	qKJJduETLcR38s12D1AuWSPbZk0vY0+SnwX2XV5M+iTLXS5hEFyogw1XSgRSK+nMNPH4TyJgWQN
	+qBK0qsYgsr4orP4JoF9wY26MVrQBOm9EnjyEfTEcUVj5ibe/CiNsnsKvaZUbEAk85YC
X-Received: by 2002:a17:90b:264c:b0:3a8:10e2:ad08 with SMTP id 98e67ed59e1d1-3ae580dd95fmr2042875a91.48.1793197355157;
        Wed, 28 Oct 2026 07:22:35 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6453ea6sm23723645ad.10.2026.10.28.07.22.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:22:34 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Deren Wu <deren.wu@mediatek.com>,
	Quan Zhou <quan.zhou@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Bo Jiao <Bo.Jiao@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: reject invalid EHT guard intervals in airtime estimates
Date: Wed, 28 Oct 2026 22:22:12 +0800
Message-ID: <20261028142212.14523-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
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

An invalid EHT guard interval can select the wrong airtime group and, at
320 MHz, read beyond airtime_mcs_groups.

Guard interval 3 advances EHT_GROUP_IDX() into the next bandwidth group
at narrower widths. With one spatial stream and 320 MHz, it evaluates to
264, one past the 264-entry table. RX rate parsing rejects the value, but
the common TX-status validator has no EHT check and last_rate_info can
carry it to the airtime helper.

Reject values above NL80211_RATE_INFO_EHT_GI_3_2 in the helper. This also
protects exported ieee80211_calc_rx_airtime() callers that do not pass
through the TX-status validator.

LLM assistance was used to find the bug and review.

Fixes: 3702a33216e6 ("wifi: mac80211: introduce EHT rate support in AQL airtime")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. A QEMU
KASAN guest calling ieee80211_calc_rx_airtime() with a synthetic EHT status
changed 8 global-out-of-bounds reports to 0; guard interval 3 returned zero
instead of a wrong neighbouring-bandwidth estimate. A real device TX-status
path was not run. A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 net/mac80211/airtime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index a4e1f33c0377..c31540ff42e0 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -550,6 +550,8 @@ static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
 		group = HE_GROUP_IDX(streams, status->he_gi, bw);
 		break;
 	case RX_ENC_EHT:
+		if (status->eht.gi > NL80211_RATE_INFO_EHT_GI_3_2)
+			return 0;
 		streams = status->nss;
 		idx = status->rate_idx;
 		group = EHT_GROUP_IDX(streams, status->eht.gi, bw);

base-commit: 25e73f1d6868c759c8eb56cad4e411692c5341b4
-- 
2.56.0

