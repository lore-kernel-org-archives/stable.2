Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587017;
	b=X4WNQCOtb+DytTt7ltaKdkjX+uQMq5H9hbq2kgQGBZ3gy1NmeO97c55ho2av9br1+4BK
	 x/1/SfP070ccrpBmnB3cwgya+pXcez6601obpLmv5IeKg6nFBYhmzSCV8xscS/W5TBaiU
	 Zu7h2NzwBhZTtjK0xf8HWtll8IDspHAGaLA6JfJoIWn2Is8FMRkO90ZJuSFal3el3j0a3
	 QWuAlxcqlE9uDDLQh3b5NCjp49RoyVY5D4+UH3b4WKbOJaHlvsJbm/UfsS0nckBCl+ZEz
	 QmZiWV4ZFOmrnJHLNg+pO2TD9OOzM5yHQLtz8V4M1D9ljT9YM8fShJd4gYRtjAyNdlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qe3yX42ERgMuY66a5xyz0Wt6sGlKrpiqgPCE7n4UY4U=;
	b=R8fOFtmkutcE/lK1MRJDQ7IeyWWZHS+W0cIr6z2njMaBMLHFdiN6+SeDQdL9WolNTaP8
	 WYq/QIvnsrAz+KzAJWbbybNm/rRHSmoaN1tth8k6/J87/aG/1ya1cmQpzoTRPsrf2y2Hv
	 tA+B8lWohA2eSc3PdANSjIChoNlfYN78o48L1bdc7bbb1x9UydunIGq9k8xIKQd0bnoyC
	 X4f60UVPwdj6ViI8cyKqx/R8yQHCcMFwMjPW99dKL1EQiZBLuxnzPK33b/eWdcmrNjo66
	 G+vG+9ddzOKidFgewR5ln2A/NhmSs0xvRKzZAWSkOjP54XngTSjgDEZ+9M2Gx4w9SQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n42sqdy5;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE37606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EE37606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n42sqdy5
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-89d6bd67045so1153410b3a.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793587017; x=1794191817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qe3yX42ERgMuY66a5xyz0Wt6sGlKrpiqgPCE7n4UY4U=;
        b=n42sqdy5eMQVeWPpn7Lfz0ahp8g/I3FH4BtP5jKpMiI9/EP7uecT495p0eMLWxd4Eq
         UIXLOMeL1UlswHvAIVlGq2Mh01d/DF7MeUfAJbJAeQnnJDECJtpR9IRepBKrDkzOsUsj
         XxX3srNOEDn1f+UQ3QAZYIidZuvK+Sg/dA6DGa7no7zcPIzS2gD/oGFVR7gUSuPIQH0X
         YpBeWOYoBHcHABX00pRiUFF9u6poHkUW2XNpRTuyUm8hMZgzs/e0f2QF3iLZhQsYuUh/
         jLfkXIUAmHcToND7VI+SROXbt1sAm/At+uYa4IiaLAQYZlWx5g31XyOLc1NbBrinuNBJ
         RH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793587017; x=1794191817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qe3yX42ERgMuY66a5xyz0Wt6sGlKrpiqgPCE7n4UY4U=;
        b=w2EDGiEW4VTAH2XzJZukPUVNN3OxLSYDl5suvCrpkH7huqozXaUQrIb367wN9tbHmw
         GiJVNDhuXJ5At0XSM37FrHsJWiywSou+DjkJhflzUpSgIPWuyD4YjP854bsTVPOWWi1Y
         5UCLuBihuL+oaMTzA+TZv9/oa8Tj+iko8O2HAFyzUfaGqs+lezyaoRTaCViPYmi0pj4W
         my5vzUL7HAgt4RdZ/l6vIwUvZifA2WWDaxHxIBPDA7JgdSzTxjjUAZCDiWaAhAJzanFJ
         mK6toTrQrRUuD86qlebLVau6CK8w9g7O2iNETXr8KreVKoRSjGggxMVlfa2zjHjBSlky
         YcWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJCrQTMewLAc29aOautKHd82cECpLwaSXkkpnlY/c8faTzi0fB0/aRkFQQwYeG8myyVhn/G6o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mMdnWA0qB8ZF1pgwnI4Wk/1+XmMg2Q7VgEx0KRoDC7xitNe6w
	3OeA2ZlvMn8IpuflTEPBbaK7Zj6Fnn52I2YKg9QAX8aSDISan9X6cRA2
X-Gm-Gg: AYBFou35p8HDBw69F7pCM81Lqsb8KggNeXB1kQh8dDbe7lpS+Aw03PGXH5ZXfCAz3qQ
	jW3MXZziMfx4n8VoDrWpBPn/Nlb+LnfeOZObm+kHSXpPFLpE7cLmO0J7WTJ7AUspw4uA1u+HLpL
	Mm2BsbX/he/V3dbE+ECDS6KAtOTGsueEd9gQfFEMqcrrm24RWv00YJBT33vqX7MUws09JicnYul
	2zCrJ8D+WW8i6ivXM+CF5YlBlABZ3pUhJLgdoPDuu69K4LsqfkvYqvtNKzyJEqcWOThBGhOzpFx
	iw8fz5OC2SKi8J7kp/pRxsZYJrDZjDAi1w+DsRI3SXbkRcYMOwnKwQWL4uxFij5dJ1mnTyqu/bq
	TdvFFix1llm+dQp9xmIOu8a0kwZfyA/MkC6wzKG/tUkiWVATMnCf6An5UnfBBSVNQP4Vwz0WkML
	rC9g/Lju8gtspPyPEWBWT6a3iVBQSJcQu1eElnGdA/5VOb5vVZuWxUOytm7ZxtdEwHKaPQPkr0P
	5ub+qLxWc4LZMj6cvSuz6k5ZDzIt/LnGMRluJOPX8LMqfRCcPLpXxEK8idByWOmUIZ27mR5ej8E
	Xc81eOCy3mnX3jvP7YMcmYFXjCvbRVpaLlesRzjg1S6K4Q==
X-Received: by 2002:a05:6a00:2e1c:b0:8a0:2d72:17c3 with SMTP id d2e1a72fcca58-8a9be681283mr5322129b3a.15.1793587016620;
        Sun, 01 Nov 2026 18:36:56 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8addc705868sm167812b3a.35.2026.11.01.18.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:36:56 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: lihongbo22@huawei.com,
	sandeen@redhat.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] f2fs: free the quota file name that remount drops
Date: Mon,  2 Nov 2026 10:36:47 +0800
Message-ID: <20261102023647.1084979-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
References: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Remounting with an empty journalled quota option such as "usrjquota="
clears the name, but f2fs_apply_quota_options() overwrites the old
string without freeing it, so every such remount leaks it.

Free it after a grace period, as f2fs_show_options() may still be
reading it.

Fixes: ff11d8701b77 ("f2fs: fix to allow removing qf_name")
Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
v2: Corrected the Fixes tag (Chao), added Chao's Reviewed-by.

 fs/f2fs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 510df7998c18..d86ab25fbcc5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1646,7 +1646,7 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
 	struct f2fs_fs_context *ctx = fc->fs_private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
-	char *qname;
+	char *qname, *old;
 	int i;
 
 	if (quota_feature)
@@ -1662,7 +1662,10 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
 					GFP_KERNEL | __GFP_NOFAIL);
 			set_opt(sbi, QUOTA);
 		}
-		F2FS_OPTION(sbi).s_qf_names[i] = qname;
+		old = F2FS_OPTION(sbi).s_qf_names[i];
+		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
+		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i], qname);
+		kfree_rcu_mightsleep(old);
 	}
 
 	if (ctx->spec_mask & F2FS_SPEC_jqfmt)
-- 
2.43.0

