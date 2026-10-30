Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345073;
	b=GOA7KkeKGjkQUvkKFQVREgDljwCEn0CzNprqiojvnRAmW5iozhHCGDMdyRAnLBUb2Gmq
	 rjr/xy/r25ohoxWofyOnUgXN0SW/6eVf99Y1okYCb44pXuZlblQ6H60w399QDSL1yvXfA
	 l2j7QYfbob5ASoZQ2vhPw9I/b73uSZ/STFb6LB0R/LEErAwaZiTg18Q/3FgWIdVzARkhm
	 7/3FbKOims4zRjjRWY5ylXSqXPIFO/Pr28g4H7/4nPeAXhjeq1AsejEvJONfd16TJymlu
	 lMs8PAHN5nv/lTxDktDEJ7ulS+q1BJURac2NI/06lV89nSPUEm/+p/VFf7X20N0Z3/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Dye9QdCfM0buqLNAg1xJFfUVdrOuh21D7sWCj6RNeCQ=;
	b=d2mWIyHMdJcXWPUluRecSVrb123FoZT71N1Rnuznr8CjukR+0mZwVhhH3rMwKR3W31CJ
	 DVnpzsYPSkq7ytFhngIrXTI/3Om9qmcpnT3yIqhrPcuEL9v5pJBR9uq3cO0KDnqJ8r2+b
	 /RHSHfqgCKVQl4suEon2Ied8vxfLFecg8KtyCdFTNor+k8yyeF1m0M72V0MnGw17TltFO
	 WaX1OWFE+giCdTnbcUZOxNGKhcdL6PaW/Ku0TTRTixBylm+BQkamxWQdtNydAU2QduutM
	 wp4p8wuA5Yx+5pCqC3lqXkM6GnWp7V1HLf7bKO3k11XgqL6nEZ38B40Qsxom+xU/lNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shXzQXvI;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2238606A335
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2238606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shXzQXvI
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-185fd3a4ca3so351591c88.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793345072; x=1793949872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dye9QdCfM0buqLNAg1xJFfUVdrOuh21D7sWCj6RNeCQ=;
        b=shXzQXvIBm8gGEnZ0AkVTNtdg3Q59iPHohFAp1GkluBGadwAmhHYE6lViy4+OWE1XV
         BQkxpogrsTnFxlNgYpPMbDPeNrt/x7J0OO5MTfTXUdrzEOMHw50id737nF4CTUt6euLB
         qPhYz/rkeErURDpJVMXQtH9B4oLKzgs/oeqPO62G57k3Bdz0aQ3yP1kVIiss/AXDbSU1
         jHadz93ORva2TB01ja84qlGroFc34GNvzTKo8xPdHehnHKMIKacDbTgGtnxa2gGMallB
         OjQYaqABB3K8+djI4dyzWLXgEeKa5MiIVQXdFjL6vwhLFK0zagIZIixNJX4Qm+N4kHjR
         0rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793345072; x=1793949872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dye9QdCfM0buqLNAg1xJFfUVdrOuh21D7sWCj6RNeCQ=;
        b=fefeSbES8w3vFqRiV2gvSHWTBYDyJV6/5YTGK+4C/dZa7g5YrZr2QbITdKmvNkeHY9
         mcp8C9iS5FY2sCho7b+0+qCEAIpiaTEs3kZ53Uol/+lJLnNmU6hDegQ9lyfEExOuqyz8
         yf0hivzwW5KuSB7ZlyAKezXI1b+HPJ+P7MzkRKec8HHpVUOATi2mnM7MMvT8qaDZ9PF1
         zF9mPweIBr7gYRYN1+pssgEqQN9ZK5G8jZsNXfjTnyarMKzlszwX+k+FFkiPpeYqm8kk
         vNCWPe6xPAoEdjGDdx/Jl3RojpJAltM7OSn9TwsHwR7HXivlZ3uM5H0QaiOi3Y5vNMgo
         KXzQ==
X-Forwarded-Encrypted: i=1; AKwUvBx292qWbo0dL/n1jwbcgSKF4JidKosFTQMS1qi25kcAmMNxQiYm0a7oBxqzA+6pbmAcrmQvi9c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJysb+DyGNbmAhmOrH9ZQYx0/bVQptMah2X5H569V/1IXd0MCEL
	rB/BuYGQv/0HpJBx0sYxhGz8BExAxdxdjnV6bZSQ+eCpPRFGHBhQ90Xs
X-Gm-Gg: AYBFou2wKDZFuCeEkK9X6CrE6npy/dxa0dCm+57NrY72fZ6IG4VNlF5xcDO7w0TtCen
	qnlH9MNdZp7+9Cf1nBEMDiq19g8vqn1OqdKOHz3GfwX1kRxfBaOjqsMtzsy83NrkMGa63Nsfkr8
	iQrQpY40rWNiNWmaxG/SwPE5FGuqizJwJPSX7gFAhCQCMus2fbz3E5Dp64TSBRojHZoWL9ea9lW
	CAjQn2xRJoDUVhTNZ48e3kpKHXYlL5gHsosYpVteFMwIlVoukVxOhAJQQug1iupuZ8kbCSvpw6U
	mS3H8Fc5MOs4RLKNPTkEgVMgxV2mYzQTeBpDoTeVZd88y7uVCnIT+1CU1z4/Er80Wn8locZwudx
	jP15u/+H/TPFs1lJ09ihe4OYk3k4tK4StGYxKhbIZmmRU/ZwD7uwdwS8V/bwih642Vafw8Ez8DA
	0HnzhjuBtdJRcwivoum/ncTHLLNNh3bmPnmO5XSkgZO6U4pJuB4z3Tw1RxaoXwudl7GuTxxJdja
	U4d1bCFAz1rMjXQgGfy5pElgljaimO9b3N7LR87UPaY19S3Hu2c4GlDhfJVMfeQti6l3OqdyVqj
	BxiC+T0HWfvTdhrhS0kQreZ422igRi9UyHpIF7lYWCyH1A==
X-Received: by 2002:a05:7022:628a:b0:14d:c7ae:85dd with SMTP id a92af1059eb24-1ac5bbb917cmr2714313c88.7.1793345071565;
        Fri, 30 Oct 2026 00:24:31 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm4462883c88.8.2026.10.30.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:24:31 -0700 (PDT)
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
Subject: [PATCH 2/2] f2fs: free the quota file name that remount drops
Date: Fri, 30 Oct 2026 15:24:23 +0800
Message-ID: <20261030072423.197883-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
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

Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested in QEMU with KASAN and kmemleak, remounting with "usrjquota="
and "usrjquota=f2fs" in a loop while reading /proc/mounts: nothing is
reported.  A plain kfree() here trips KASAN in f2fs_show_options().

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

