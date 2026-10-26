Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013718;
	b=4vgCHYB19gfm16OLMjsyJzx0nztbJMtOS9V0px5Uabjzp5t8a1NvbWUhR2wCoC+5Od3F
	 gNoF/FuaIK/tbVXjh7Qjubzod3PcNaCt9yZTifeZuiULCcXtRO4WbSViAjXySoLIGj3MG
	 QqKY55y2X5S6l5HRHLW/JrJILj+e6zZRiLWjcUjSB7gV+C/BdC0npVHZuOCVdb9084v5F
	 w1+DUFEqzqNvLAPLoJREXvNf1OoumROI36rCKCLDo9A+W/KfTFuymGUJ9rca5zoxrX9yI
	 Oi4COGT3h3tmUujt7h+0XClwlr4Cq+Gp6vWkG83S9IKYQ6Rfnse7CVzZ9jh8F52nEeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xZ3hvppsJXNIOs0Q7rs6a6KCMDKrK3IMk+V7dGRWIBo=;
	b=Rqobxkf+Pd+jdXRzREGku4mth92agpflCGBZJvPXegLjPZjdXAN7iKH7xa8iRFbRFIX8
	 cAtgxcrgk1U4AqiIToMDfUPfsWeriCn3Oo1tqSU02vaPnmKY3GQlyZVvaqViraxaNjg21
	 I91jMv1rfpT98QEnpJNJEwHNnZOyhGBkA7gci4KXWVlE+XPgh7kGjPH6COvnYwx7FmijV
	 bkMZ66B5AIxC6BArLiPASrjRNove4yD1iWIHrziGOAPd7qhhHpyb+NPUFkZncOWXtncQh
	 XpG8skIoXSMBYd5Wy6COrTtGIOFZJq85s0vp6X25oRCLpK9YTF1RcK0Fj9aiOstTi8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fZe1YKnc;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70D606A33F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E70D606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fZe1YKnc
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b042c0759so1604119f8f.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013716; x=1793618516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZ3hvppsJXNIOs0Q7rs6a6KCMDKrK3IMk+V7dGRWIBo=;
        b=fZe1YKncduevfg7NRuTy7rSWE+XGiGSVEcRN2B0KUQRf3H0Ky8Xsymf98qiiGW47nA
         T01E+nvTV9OYNFD4pi7cViYa3rciBKhLiwCobizFfV70x5vKYQVU0b2IJDfB+8gbkhZt
         LK12IZWnOk4dH+90/2AW8JyEfrBgo7wAUyIQjghgHNv+/R8f7lY9eIic9epayqPX1kzI
         EDVVMXykiPZqoEqa7ISHSItDHmts9xImVsFym5q8aKW5bwuqb9+1kdj5s7x6P9zlSBva
         xpQNxS+f3VHPjDsgdg6eHhVR1DLCga0yWK6NlLuerecx+b233tOOC4FsbFKFfBOhjWbT
         fBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013716; x=1793618516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZ3hvppsJXNIOs0Q7rs6a6KCMDKrK3IMk+V7dGRWIBo=;
        b=atj/2Bh2xlnql2/r8MHp0fgWcvU1OCQQAYynN9laEHxWqGhcMnN4BK0YXO6KPJF7qt
         JZJS2urpFG8Wf3ZxD9Z8JdSG5rPy0uy1jOHpk5IeuCAkdltdT9oOclqej7DDXOECh+md
         RR/SKCxc+lUjgDbW9PJVOs6Q3bJ3sxQrj+4L0EculFn5dNZB1QqSszzK38dkWcWTZs4F
         Y6VLZXgJ4I0T2RVkWQnLfFnkccUSxc7jt6Kp+aBkZWzA4sR54dGe9h2aPynOBAhDvZeC
         d646hwJ89fGfgAsWYCnvR4pqMRWdmZw2tG8C6eikUARhpxmG+IVGt0+h8zlcL+CAZFFY
         gznw==
X-Forwarded-Encrypted: i=1; AKwUvByyCq0CWNGzvbxnrm0Np38byGWmnz84+HIMPukMcK+3buDIrUvRxuuAuLP4XGlvfBhOgeTjRdg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTI38SmzHQjzG90QN5386JjdQNthuNCfM/nomfhfMfx2fzl5yn
	NS7kSUyoGe/pkNHooXKBj6zSQKYnAjzR8tWHNAgEVvqmNUAlnXPrR48=
X-Gm-Gg: AYBFou0+RDW1d5ZCFvuRUTiV8Di1RmMMAtCl0k1fvhBuJQQYxPi/YPNyYPYtXMjwrdk
	bvGcXOlq+JYhRN1+4FjstuQ31v3HQDIcfFBDIvOf6VjO/mRY6v7NcsRqdoBtjyGRhAb8Pcbg+QV
	YpE6Fd9NGw9QUjMlm9PRUwMeDYraiJaf39FTc4DjoNCUp4C4jBE30V6bWGlyvwO5AF3xc/kV5Cf
	ub2Q8NcHyp9pD27Ket1Fjp78vxUAOb06zh3v3PfxnGnHRgZD4FE+bYsmqKgGR7qx87s/Dp4dY3T
	u0Vz4OaUwYD43Ly4UzsAH3/5PW8wnQacXD6dalsQhPGXVZjUFrM1BnAce5YqeWiuStL+ySYUCE1
	rAu8b8TEo0I+sxAxFVRWy920P2mAgPZpOV612wbf2epf2s5TwMZA3pPOoqaPZ0JCpTNz5fnCbOt
	1FF3s0Im+V7Y9wluP/nUFCIruYbPjPfxdB0LnTjm880k+hk26lOxrrsQTv9+U6LttuxeHCbFRk9
	7ByyJtfieZejSEhV5S6aVK2p2v/4YwvTCQEzGJdyC+c+w==
X-Received: by 2002:a05:6000:160d:b0:48e:35d4:55b5 with SMTP id ffacd0b85a97d-48e545bcbe7mr305812f8f.52.1793013715854;
        Mon, 26 Oct 2026 04:21:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm15048703f8f.56.2026.10.26.04.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:21:55 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Christian Lamparter <chunkeey@googlemail.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Ivo van Doorn <ivdoorn@gmail.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 3/3] wifi: p54: fix IE parsing loop bounds check
Date: Mon, 26 Oct 2026 11:21:51 +0000
Message-ID: <20261026112151.2515228-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026112151.2515228-1-tristmd@gmail.com>
References: <20261026112151.2515228-1-tristmd@gmail.com>
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

p54_find_ie() iterates over information elements using a loop condition
of while (pos < end). When only one byte remains (pos == end - 1),
the loop body accesses pos[1] which reads one byte beyond the validated
buffer boundary. The read happens in the bounds check expression
pos + 2 + pos[1] > end before the result of that check can prevent
the access.

Fix by tightening the loop condition to while (pos + 2 <= end),
which ensures that at least the IE id (pos[0]) and length (pos[1])
bytes are within bounds before any access.

Fixes: 0ac0d6cedf611 ("p54: Move mac80211 glue code")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/intersil/p54/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
index 57a62108cbc35..16614f65dfa5f 100644
--- a/drivers/net/wireless/intersil/p54/main.c
+++ b/drivers/net/wireless/intersil/p54/main.c
@@ -81,7 +81,7 @@ u8 *p54_find_ie(struct sk_buff *skb, u8 ie)
 
 	pos = (u8 *)mgmt->u.beacon.variable;
 	end = skb->data + skb->len;
-	while (pos < end) {
+	while (pos + 2 <= end) {
 		if (pos + 2 + pos[1] > end)
 			return NULL;
 
-- 
2.47.3

