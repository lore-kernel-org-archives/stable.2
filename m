Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965473;
	b=yqCAssdxWC1V40gGSW8pLrxbAUObTLMKSzJXzrz+uf5O9Dixjgk2Qa5yQ0PYLXxw2nKz
	 GNRa2PhkxRzQWoF3lMNYmQlc0lF2xwRgbztifD80pKmC+EGACfJHPbAGwEJBlQmlqJ1ys
	 UkW3tTc7jH//sk0xkHwUsua9udATQJDhthOdaoVpTRrrDKVsVKkSLUpo1n634pxjrqkAW
	 Ofq39lnGGn6ziSK8/0HDT7U7+j2JFenRnHsKfWkRzaSU5WozTzOA5lFfglfKl75fuB4zm
	 2iG474V/WEB9c9LcS639J4cDTWXWD4C9XZHUHI9lGcKdcYjOto86RcFyt2Jnu9Zn9Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965473;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sSpSJ5wXnKKj4djOodlY+VVOZugZ41sTNKQIxuJGolI=;
	b=T3DiriJ5qeANHtLBf2DrY3ZQVytBH6ZIy9RKQ0UyTwm4GMF8fdylk+jbyhk/Q9fcvaC+
	 jJJkqZl8X3ix2KNtWPyt4hG0IpjZnQjTlie4SWpM2eIx4GOPs35vYqoubt05om2oinyei
	 YISs6Z8gCrhgxfgd7CeE3Fn32hEwRz4eOnQDFd/WCaipJhc8fhi1DO1TMH4ns9LNgX/+R
	 v5YupwyB/UbAxu03n8W5QHve9vFOTtvbLKjpZPSsrT79IZ/5F6nFZzPaonLnSuPj7O2e1
	 OUDZ4kn2SYTurZATC2WmXIVYntk85wSolvb5+c7bPjMkOQZnMJlRoEJWi/aDF2tHs9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=igorsousa.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EEE606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1EEE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=igorsousa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99075306daaso152778241.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965471; x=1795570271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSpSJ5wXnKKj4djOodlY+VVOZugZ41sTNKQIxuJGolI=;
        b=G2EMl0xTCJLDbwWqK2XkD8QqjUfPmLzMQHiXNFAq4CNPX8v5VWWhyupoDzO6qJKF6/
         ReZK965EnD7bzNgSxLrcmSR3oxq27ujJCNQYtbcLnIhvTaBx3bxq5FdWevAvYcREkke3
         7/X+i83px/VQNOfF2yRckLM2hfWrUci8TK4MIDLdMCV9ucK+gxdJlMRJ58xDKu1imVGW
         G75uenSClxPkwIqs5bAXG8ZANbNtrWU7a9BR5EEsqOcXSd7xu8k0+mabwWGHA7nd+U3W
         t0O/FQ58aKxcUeZC7zEteSrxZLy71zJ6MqKlp3JCFKa37JRxpR41+ummFEvSdD6ZuXXq
         i8cw==
X-Gm-Message-State: APuU4Z81ox4ve35yKdcV81vHdQtW3sD/EaL0DZIKxjy5/jQarYrHL+jm
	pRRMgDjAsHXDGnAgjq11EmkOqKBDSJ1GbA0qK/bThVmkzm8eEsSCTR+uF8/jAvdG
X-Gm-Gg: AYBFou0QJMKG1fwsTM0j/s3F55Twm76ms+6iaydltwUhgI/9vagu4Ezj0p3beRK9LIF
	PIAee2vVswsD+7IVVVRvX8vcyXG0FTKr2gNltpDlYJPEGUm0s0bsS+doChGoIHScz9sBArayOiF
	ULjoKst2DrIGU9EjWzueiq5NV/sIFuqTxf3l93snAl1p/yxgnHo8ZENFzqlkCz2NPMt3mdHBAFM
	VfUv1cJch8+yu4QI4Nj8pj2r+Ud7+jr+8yZc8RC90QsKwZ4Ufm5AIC64CKDzozk8vYy46vJMrAt
	lt0yNqfb0bFEph4UeYEgTnYmLkoiV8Z23GDwAxxuwVO2u6QgSy72eppI52MLcwYEwc7PracDovf
	/BBP2cf8PqZPx0Yqoe/IUs+tXNFXp6k9pZRUDRYbBDrMLBZjUyUI/+8jgAMox1JgMGUvO35EBed
	6dYeCEChkM4pbk7K8eb3I5NDvWBVI7I+CSLNfNRq+/2OPTCKDiF8geZT2tH4dksb9CY+hKCNRg0
	8G6f2aOhNTPouyxvuWYJvvZwBFGIT+K73q5S91LJMOehj6Np/cepz9Xu+mH7z51ljqC8gOJ7nb3
	wWaO0YW0cBD4XcIRi3585BphIL8=
X-Received: by 2002:a05:6102:e0c:b0:7b2:f3ff:6b34 with SMTP id ada2fe7eead31-7d6ba18e568mr348336137.1.1794965471527;
        Tue, 17 Nov 2026 17:31:11 -0800 (PST)
Received: from fedora ([2804:d59:8687:a500:6418:f958:e1ad:d4b8])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1cb543sm899183241.5.2026.11.17.17.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 17:31:11 -0800 (PST)
From: Igor Sousa <contato@igorsousa.com>
To: contato@igorsousa.com
Cc: stable@vger.kernel.org
Subject: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3 15IWC11 (83WA)
Date: Tue, 17 Nov 2026 22:30:57 -0300
Message-ID: <20261118013057.8994-1-contato@igorsousa.com>
X-Mailer: git-send-email 2.56.1
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

The Lenovo IdeaPad Slim 3 15IWC11 (DMI code 83WA) requires skipping
keyboard deactivation in atkbd, similar to the existing "83RR" variant,
otherwise the internal keyboard won't work unless the
i8042.dumbkbd=1 option is passed.

Added a DMI quirk for the "83WA" variant using atkbd_deactivate_fixup.
Tested on the hardware without i8042.dumbkbd=1.
Fixes typing and keyboard LEDs even after suspend/resume.

Cc: stable@vger.kernel.org
Signed-off-by: Igor Sousa <contato@igorsousa.com>
---
 drivers/input/keyboard/atkbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 019cfa855..8de262d8a 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1943,6 +1943,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Lenovo IdeaPad Slim 3 15IWC11 (83WA) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83WA"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {
-- 
2.56.1

