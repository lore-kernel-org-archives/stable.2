Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B236DA1D
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787495191; cv=none; b=Z03vVF98dfwfiadYiNa1iocRjDZwn1rYd1SFlZciYijDdMQBbUEaU83Jz4BR9dZCPsX4eH41v8u3lnqb5fLT4udEjtRFbgea6OVBMJPEcQ6QP2frBZiShZxf33WHGIUE/93GLWmD5SzW78YVNh2sHEHX0konVYCS2+h00Jqib28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787495191; c=relaxed/simple;
	bh=HROw/c6Y0BlXY0my7bZMyZmW2RvDTA+v5z0vY+JjSzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ic/ewha6ayrnga4S/haCi2oerR+39yVXzof+enPRNPOOSar1PqAt4TDOg6Y+1XUxX3sfc+irc3u5P0wgI7MwzAy/kStn3MWdkGXEFonn/gc4yRaOUgVlI+L+eDQM9tQSk596iwFyMxfa2+RRZKU3/jtA2L/Ucs5u0AuY7//Euqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7bXSfaC; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7bXSfaC"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc2c6e0688so14530595ad.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787495190; x=1788099990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nc2OpDByISqZ6cUjaeCWgnfFVc3xyfspITbujS5lcD8=;
        b=X7bXSfaCIdw+lkGtwjsHX0Gr6uSP68xugtONC9k9KTo7L0Nt/Kfkg1Klr76ajfq+br
         b9Zt+RcrKKen5ZC6i9RMHYaAguBd3ZqKPkOpNMZfTCWd1C6ObJa3OiCUw2z1Vg8D/FtP
         rkiPb2uLtXQaafO30s7yTH7Vu+meQHMOUfruXkvc8j6UTjNd8KEe9gk2Qz1aK2vSZCkU
         UQD7TRVoucjccpl4Qz4vk0MF7NJHNoe1vnVw0eKGNcn5I3SeeF1SeajfpCeGyy8wj8Ns
         Xq49hyCDEi/ftcIJojfuhDncNExfIQd0eVlwUkipzAF52ToQYB1mDK79qSfdB9+uRdbP
         KYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787495190; x=1788099990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nc2OpDByISqZ6cUjaeCWgnfFVc3xyfspITbujS5lcD8=;
        b=fO7bzalCEf0eC3ffUrVIJGQLMcdsD2A1vwEcI9zprurKzbStFsY9fob0nDdb+bqrcL
         SQOrOSRWi7gLg36kTMz7tbEFPPs81yOK1gMSbMhN3poPIwnTjdn1CmSSBKCrQYkdetov
         /ix9Ypdfpotekmy2/RXZQRRMBkxkQi9l9DzH+iX2kKq2m3x2ObHKFq19p4eI/lkkjTgs
         mWlGn4TSm23r9qznb2/Qa/VHKPFiY+9KfMz9f+DWE6YhBOjFsX6UPG3OZYj0Cs/18S2O
         +KnyxMS2MiHysz1yQ22ioPgcEXCGsIe2RtmOwQA/yFiTa8/LQtZQnxnyCaJIz9s0e2zJ
         4yWA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+PZTZToEnGJj3LBtoitxf/rEc9RQ3nsCMy8X2xYNXB9Od908+L1R1jXYiPd+H+/qtGuVNRq8=@vger.kernel.org
X-Gm-Message-State: AFuF++kJlumgIhGAxrhNO65tx6jmKss0ttorWemp+NNEjRSDKNuHfvsb
	y4kZuGsYDw1T9rWEQR+IdfdlaLYgIt5VT19vl5rSaykeWWRKuwKfOhZw
X-Gm-Gg: AR+sD13547LrHeLElSAMb6bA5QjKFXWpTOMfqZV2MALMeceK7JGCkgjMrKJr5L2SZj+
	KSHKp6EmeHDYPQrGsgQvTqFquw9hln8S7+nOnelzMEcR+01HB38B0IZ9qnxyXtK97/xA7gfpfWx
	dqQaCGECDKna7ngakHwNSFv8IPcCXmfSDnvNUwks+0uVDEZ1IFKms6FE7x736THpmKNc2gLZe4c
	EjdEXPzTgkPT8TYuN7b49exZMlcYR0VfQzXwj5uwBZSiHukEjGshqY0rJE26wQiRShEBo0znFkJ
	3YSYgBl02SMaPMfngWIJGDK+DW8WnO+eg84LQ4CP4y2AGN0XP96cSzYNaKLWb3ocvBmr+UIErpi
	oxhOSNX+Oimmw8kxeFND7bxWAeBy4YAw0zwpsNxDmyhLxEFWxSug7poFlARCHvpSu5LxgeQ9sOt
	AUPFTPIIZ+k3xxsRqau8TQ8tNX2VbvcCIgL5APKpjqMgRQIVH6EQteftKQrhH3ygr5eVrrZ+m9S
	Ppt3u3+eg==
X-Received: by 2002:a17:903:1a28:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d64adc3f0amr374069365ad.4.1787495189979;
        Sun, 23 Aug 2026 07:26:29 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([2409:8a55:94ef:8231:5513:5a56:ca01:ec16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676895799sm9847435ad.38.2026.08.23.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:26:29 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: skbuff: reject invalid pull bounds
Date: Sun, 23 Aug 2026 22:26:20 +0800
Message-ID: <20260823142620.126424-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_maybe_pull_tail() subtracts skb_headlen(skb) from the unsigned max
argument and passes the result to __pskb_pull_tail() as a signed int.  The
function does not ensure that max is at least skb_headlen(skb).

This can happen while parsing IPv6 extension headers when an skb already
has a linear area larger than MAX_IPV6_HDR_LEN.  Once the parser needs data
beyond the linear area, max - skb_headlen(skb) wraps and is converted to a
negative delta.  __pskb_pull_tail() then passes that negative length to
skb_copy_bits(), where it can become a very large copy length.

Reject this inconsistent bound before doing the subtraction.  In this case
pulling up to max cannot satisfy len because the initial check established
that skb_headlen(skb) is smaller than len.

Fixes: 1431fb31ecba ("xen-netback: fix fragment detection in checksum setup")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c82a147..33022f7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5838,6 +5838,9 @@ static int skb_maybe_pull_tail(struct sk_buff *skb, unsigned int len,
 	if (max > skb->len)
 		max = skb->len;
 
+	if (max < skb_headlen(skb))
+		return -EPROTO;
+
 	if (__pskb_pull_tail(skb, max - skb_headlen(skb)) == NULL)
 		return -ENOMEM;
 
-- 
2.43.0

