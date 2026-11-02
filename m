Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657796;
	b=aHUw6YAV642/jQc/XJmC2KUPN3U81885oSeIwnHkGs10xYnit35sJQG+d/cD79oTQQeX
	 R5jKHnTssFraSCqfSMjJcKd0rfmR14u41Kcjt0bJ/NIdA1/pgJ9wKT/Xa85FBDd2Hy27N
	 oY2qH+7hwM/p8o/zis4UCEB9Eiz09dUDEujlwuNYV6IYaMgiwmJSR0dgHGtsD+IOQhnog
	 vAaLR2Wva5MWEFYfmDr0LcKc0L9fREa7nzvRK+awNy3OkMTQ24RC73bJqCm7ykOXopv0+
	 TQVVJe7kEBnn62mdYVqn3nOcksJTdAseCLSRQoKsuJ1Wie5zRSLC6IxU+CNCdbdm4LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7RbsrJbC+78XvE/Jv08a1o71KMq3rArHAmE6ml/65NA=;
	b=EIW/b9TJMYWpETurIUcSxrfQOnRD2Spl/2ymFWq+EtE/cA1oodK7oWzMGCl4tfUUuZr8
	 F3SsHW1xFWyf25x9JXrCDHLeKggGxQdbzF0PnRV+5MplRzqlIf8Gvmi/DkKtvp3USm6eM
	 6ajSOJyz70FB4WVAwNd4RY6B16DRAtOnOAIEhdAp3DuGSjTnFDYshLl6qlxQMn6+hrcm7
	 fvPJdg7240/27dzx4Op4LRwPLiUaZ3TG2YbrVqXRBU7uUOKXYy/2HCle9jJi/6Ci8HUna
	 oqKlYv+XNIq0Jb8y93M2iLsW9hr135YvLO3I3vwsxOSV187fLMGUK9GFT9B9xSeamJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I5Cs8nr7;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F4606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524F4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I5Cs8nr7
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1901589f8f.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657795; x=1794262595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RbsrJbC+78XvE/Jv08a1o71KMq3rArHAmE6ml/65NA=;
        b=I5Cs8nr7qtS5Gn4X5tF2GZWTgK0D00M6Sny6nh1ntLNXKZaQ9j4gG38aI7jVPk9l6A
         TT37nNYREAzpwOTqf2xgcB8w9slpGhfDQNhQzWFHt7CwNqMBsAkttf7wrcJIcs+nB4Fz
         MapwBIupvOlJ4atQBMYC/BrGDfpHVVjKmjJt9q2Qabz6dUC9JLvtvcDhC57+0BSVfsNL
         i4ifp14dOU98shscDtw9/LL0Hpalhx0FN0itaBQUalqYeAobdy39dRSBJRpTUp5Pl6R8
         W4SSU6Ua/ciYxrEd8WNp90hxChsEH3Qb2ytlchYf8m4bqohNdjGabk87E1cW02DS6qcD
         e7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657795; x=1794262595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RbsrJbC+78XvE/Jv08a1o71KMq3rArHAmE6ml/65NA=;
        b=o8EbclUktUtQlRBAE1O8HpO8oXB+kR2WmHGcQOvaoHQkC++kF49O+AAy144TCme8gr
         IAIU0mWEh3epCBNcGVb85PzMJgFEg0UqB0a5NVL6RDkmQnIKpJu4BAoc7iDXVZ2RKZTY
         HDoWZcmWmbIKga3doDXHVucAVJUko0HERJR+XKKIKjjudI5br4Sifo5/UbDXVqnsi+DV
         SrNXeGycL1vDLuIU+1cLWEXDfjW+sfrzqZW3woX+a13Dp96e9X1ASI7EhDVT6TwSZGpj
         vOA08LGddZUHXQg4ituCet6X9iS9nQTS0XG4BZZUV9cL48UJTwYRqn7yHGA2IERpff+j
         xBzA==
X-Forwarded-Encrypted: i=1; AKwUvBwWsDqUo28xdxUGN1RXlSt99P07uWnVQf/ZMDWPS2Xy5eXINuk4kGNvcZrhkPBm1jI+PT8diKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CqqiqBzwpiaYiSiyWpnmr3Oiw4Rf9ibombZqCQsN7fEj3FfzK
	n0TjRB6LQCgigfjIOwk50GqWTyi4Bvazh1fPisjkNx5TkXW62rjfgCw=
X-Gm-Gg: AYBFou2/6k5Gk4S6hpoLIOxE6av3uFOakdT0exOZTd2puWYo05sP0cRAEwh3rYrACNT
	ZiE6mfGoe8I+wIuXJb1pZeETRkBaRWoKgjzltjnOrlf1B9yeTWsMk3S9HQPRwAldSNmj5xK2p96
	yKYueS6oLJkk+ajDIMmGKIYftkTMI7WSPVqu3lIPKdE0TcECF9dyg8RlOhowbnpjYK7cKsRjmn5
	fKmEc71eMeIHMnda+EXMaED6zhgvLwa3X3H3evoBTEQ+Pf7sUc75KGgbrbrpKXTrz0MGQ7zT7kR
	z8C/e9616vfT+O4qiif5wGFXR0kIJs5y8HjW7UyBpm9jEqIeNmF5mU1H+/B7reyaPTv8m5TlYne
	Q4FkVTn6eEtyQ/QcqXVK5wayl06BqrI8cbQBg3vI1R8GFxcyQlfwHjlnc2etW3x4DLm7stOPHJW
	ZcbAigPK7v8MtZQ+sS+dQToOoUxAbH9MJfBCwBRmX+UNklMAvRwEZJxtfEq573uwTLFaNUcUsKw
	nI1v+pbSIBfuVH3c2LDIShDLXL5u+iMTTn0JA2UW0ZiTUJyh0leoVg2pLX7HYr1/m0Okp3aBDnu
	71ZWoAsd16Y=
X-Received: by 2002:a5d:64c4:0:b0:48b:9ed:b81f with SMTP id ffacd0b85a97d-48e6e2e768fmr26733322f8f.10.1793657794653;
        Mon, 02 Nov 2026 14:16:34 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e77409821sm17917202f8f.0.2026.11.02.14.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:16:34 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless] wifi: libertas_tf: use timer_delete_sync() in lbtf_remove_card()
Date: Mon,  2 Nov 2026 22:16:33 +0000
Message-ID: <20261102221633.3483437-1-tristan@talencesecurity.com>
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

lbtf_remove_card() uses timer_delete() for the command_timer.
timer_delete() only dequeues a pending timer without waiting for a
currently executing callback to finish.  If command_timer_fn() is
running on another CPU during card removal, it accesses priv->cur_cmd
and queues work on lbtf_wq while lbtf_remove_card() proceeds to free
the adapter, leading to a stale reference.

A prior fix addressed the same timer access issue in
lbtf_free_adapter() but missed the call in lbtf_remove_card().
Use timer_delete_sync() here
as well to ensure any in-progress timer callback completes before
proceeding with device teardown.

Fixes: 06b16ae53192 ("libertas_tf: main.c, data paths and mac80211 handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/libertas_tf/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 411f075b6186a..f518ed48523e7 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -642,7 +642,7 @@ int lbtf_remove_card(struct lbtf_private *priv)
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 
 	priv->surpriseremoved = 1;
-	timer_delete(&priv->command_timer);
+	timer_delete_sync(&priv->command_timer);
 	lbtf_free_adapter(priv);
 	priv->hw = NULL;
 	ieee80211_unregister_hw(hw);
-- 
2.47.3

