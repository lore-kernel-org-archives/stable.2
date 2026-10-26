Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013716;
	b=Egv+jnt/ZjX+dsii5156JxobvjByIpNfhReg5V8KYwji3I+O5Vvl4H8RpIlRCva1gmTn
	 jc/1Y0LLWHsaBKiQFTc4ORweQmglw/xMeopI0+o94ouI1LUE/D9Fons4npkDUPZD8EO0N
	 tCxfQUhj6sPdYTSa6UOrpvXlWNIMX+DiTJunWAL1Gvrlw+vEX1XdFogeNWbM2CSZ6VfHL
	 s0TAlfyk9baV7tiAdhYZCE34Lgz1L3ebOSyRidqJcnLBRBl2gdC05EM6NkqCZ5BGbOu15
	 lH13ORqLv8ANshL40jMQ1CXIYuLWFAtq4bLHjKeE+gPkjhHVFB8u/OPszjz9HhH8kHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ab3qsq0Zm/wtrlV42bZPrMrfiWNQtv9iNLW5xd0R+EM=;
	b=Si2ji1feqEbTxpqA3yusXunA/VDJ6jtqdJSD2+FS+wR6Cd7NR8osaIYspVPzZX+It5Lq
	 soXOHXppj5lUy8NglmcLZriUm44jI4W8Y3If/7RKlva8y230wR5kzWcWJVaOBniwkd+YX
	 OUBZ2YhodEKpsZ8ah7M29DKJn61mlcuu6n3CYIS7uoPMpTCcMI+capk5PVoj05A8ASFVh
	 5dTcHnh1yJMj7F750+VZ5xDsySbuCEuswsEGs0LBh6riV6wYYSL+W1WY/8OlOxbTMPeo+
	 SVDHWnU+7yv3er5oENIlrXA+Nh0Jksll8vSRWvblfUxrGBYA7k80XjAZUal1kVde3NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HdjiHgPA;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B17606A327
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B17606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HdjiHgPA
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b042c0759so1604104f8f.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013715; x=1793618515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ab3qsq0Zm/wtrlV42bZPrMrfiWNQtv9iNLW5xd0R+EM=;
        b=HdjiHgPAzwt2JgdA8b+cpEzFUMRzTseR+tU8GvQdsFatxrRF0b3mVOviRInlkvJdZo
         rCqKmwQ7mFhleew1GAsOe0yU0+VOk+57HdtMp5pMhJ3TVz4XQ/On2jnDmOLuw9SF94BE
         MjFUY1IN7EG37pQud43tdpITRvJo9K4G1Sr808f02MhPzjZ/qy84pm60Wi2Gwcv1I+C4
         5aSTq7PL1gREjfz1DFxHsxduoqSMls3XdU1I6zOyN2H42TGgyyOSPHR35fgB6I4wKvNX
         QzsZdfmokJji7OqFUAyRKIZ3+U/rxIqdF++wwI0H8VmLtP6kVzzlIDao/mMZhb16vlX8
         GBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013715; x=1793618515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ab3qsq0Zm/wtrlV42bZPrMrfiWNQtv9iNLW5xd0R+EM=;
        b=i7cGKJdNs/yFgyY9NGiF+iH/hwDSJ6hPBK08Bu1JN7joTvzjJ4YfyfJ61MoiRapkG9
         QzqnWCI56/9pANVmPXP13lqvZQC4+aWmi9oY7U4+h7Wpfjj6GEAcESfHp8ZHWeLMWKI7
         fVjx+yGuRar6/5JIrbPP/BxrKobVwgXIUU2vYU17IWQ5SIOZgc/yrfTUSCKGro2WjPj6
         LPYuizRQ46/hm8p4gFhEgWRmEPCMn+1fOMWtiFBUo/5F5uUu1jbxhLT9AZkxx0b54I+S
         qDqQIJHuu7RmMS3p3rlqrs9kaWyMrSO30227Obpi7L5qUO5Bbm0wmbaAi/4v5Ql8+7T0
         nHcw==
X-Forwarded-Encrypted: i=1; AKwUvBz3/clWpgU50AIJ5Myb9qm7bHNmTeHokCcqr1bUMWCDQAr3WiOtFpXGFvdBbJVKMOWCsijuMAc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFuPdoVKc7SSYEYlIk2OCOGWHoVrNK98potS9pYxyRB/BxzxNv
	vsqHLSTq4ArDPB+4OcvcKVMiIs1wsmc3+oRMT4vSMWLOIwGwJwypI9Y=
X-Gm-Gg: AYBFou2IRtR8PcYTEYjH/74JHaOMUG6ZSuv666VvYjRQX75oo916AVuZhmuFXSXajYP
	ho/ma8IbRwM1zKwN2F6ZvP/Ci/Bo58+FaLQ02TirqUq3KS6a+TXO8hnnhLsiaAlPpWAPDj0dqqk
	9iyooB1wje+Gosmw7uX/Qka0vTM9amUmSufMxJ6ALfCCwjFEukc/DrnQxPeOqOdVSvFel8ZjJoY
	QCP+jqLcHIJM8fATCc1V3e3DazYDNQTVmpGsbJ6xg1CO1Ug3lTC8C/TDpDl+wc5iB33eJJJVFRK
	a9IJ71jELXG9vj/zzoMjf1axtlOhwyC/DnK4HVvKpFN5D8unOjXosNOV2A5gVlu0EQMRyXoG0EE
	GRD+qckToixyhjLPVrAPlv++y2GzE46YeLRJG1wha+FutmIAoig1myBS/4IcO4TlE/f5o/ND3u/
	sT0wpAZHL93oZziNZ0L1E4IZcwP8ZurtlcSvknsRCydXbJaGYTqQMFzvZ+kcui/H9Y3w+bfC/RG
	Z6V4fAsztNuPUePohv0uMDo
X-Received: by 2002:a05:6000:24c5:b0:48c:69bd:e971 with SMTP id ffacd0b85a97d-48e3eb859dcmr11804667f8f.16.1793013714844;
        Mon, 26 Oct 2026 04:21:54 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm15048703f8f.56.2026.10.26.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:21:54 -0700 (PDT)
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
Subject: [PATCH wireless 2/3] wifi: rt2x00: fix IE parsing loop bounds check
Date: Mon, 26 Oct 2026 11:21:50 +0000
Message-ID: <20261026112151.2515228-2-tristmd@gmail.com>
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

rt2x00lib_find_ie() iterates over information elements using a loop
condition of while (pos < end). When only one byte remains
(pos == end - 1), the loop body accesses pos[1] which reads one byte
beyond the validated buffer boundary. The read happens in the bounds
check expression pos + 2 + pos[1] > end before the result of that
check can prevent the access.

Fix by tightening the loop condition to while (pos + 2 <= end),
which ensures that at least the IE id (pos[0]) and length (pos[1])
bytes are within bounds before any access.

Fixes: 1c0bcf89d85cc ("rt2x00: Add autowake support for USB hardware")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 4d94b7062f440..5623ab11c6142 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -564,7 +564,7 @@ static u8 *rt2x00lib_find_ie(u8 *data, unsigned int len, u8 ie)
 
 	pos = (u8 *)mgmt->u.beacon.variable;
 	end = data + len;
-	while (pos < end) {
+	while (pos + 2 <= end) {
 		if (pos + 2 + pos[1] > end)
 			return NULL;
 
-- 
2.47.3

