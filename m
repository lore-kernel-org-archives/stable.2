Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEF3546F3
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291070; cv=none; b=kkkOuYiejeHInPR1LF4d1YM2v5ruNFa3RFj4hddMOlhKVnaT22iL6+Fg+iM6Bk/Y/rUIel07fq5nm+hjEc7V4Os/dS/dnf2aCobTbLtpdotX0syxf5fjO/PyHLeA1Cx65QjiJ08dWZZYzSkEOUulHcGyPZvcgE6FhmyXCnFfVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291070; c=relaxed/simple;
	bh=U3cg2HZXuMvptHjkBFTYt5bfXW88OFJuT/0Bf1xnlX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI9JDmKlDTsquAn9x5ueYb6JKidPkSUcs/V65MErDoe4s1nA+6TzkC7Xy0akq4PIMr/YXxxz2NOekeOSSUOzAjM9NzrNZrZU/aVJhBwPXsUbV8TetXFulC8hRB/rlfYJv9R/2n/mfQizwz/3D/+6GNErM4nt9ndtdlCRAQMNKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1bvlaze; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1bvlaze"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso2434345e9.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788291067; x=1788895867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VQGtLovN51OKFL0wAwiQ9djvDcePQibjWbjxoUKoFt0=;
        b=F1bvlaze4fUDcyxrNAXR5kgD4XWHmni+LnDjWrkGAKVuKo0J2ErgvAe7FFicUnfTL8
         pCWZXyn66o38v8+svAEqWBqhaXm77bjOkcftR1NA1AdojrGw5DDOqPGZG8R8F416NZq3
         MBAIiowQgs7RA8FiIWz776V58zneSmekASV8qE6zS1+zYWhkUT/8hiGiIc3RrsIymu4p
         WepdEw3vMJ10k1fzKL+MVBtNZA0iw458m1jRvBvUjECcCzDfYQvh5tJJvseA0CBvi6Jo
         4bdqxxLKuQJGZFlxX6MWQiE50JNgCwRcDALfhuZ1qjxzcCSs7wEWruTOOSB2XEjw4EBI
         ne/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788291067; x=1788895867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VQGtLovN51OKFL0wAwiQ9djvDcePQibjWbjxoUKoFt0=;
        b=H7bTj4RB6rEi5KNROhdBK91WXLudLJM171gdJn/D7i90ZHfp4Nblf6owaWiGZ5wUHo
         by7GWjSsALIBLZLrh3eHPwEsNCJ0cXBdbD/yFGj6RvXj0WzXk8oIg7jQf78EyUZDyeZ5
         L7fbiCqMqwUOmTuWYFMNOeu9CzIGOF5igQhy2txK27Af0F2E/r7IhYGMJiHFpAgqcoF8
         gEQlX69AkURWD/sl48iT7r56P2hXaZ8Xv7zl0EUNFopq8fZ6NPPinc1SbjL05MXb3sww
         8W/fKsFT7rq8xmTY5Bi8vmuXGr7c2PicfrlDTNgKNHf9YQ7Q879HhTv93VsYizj5Nvxk
         SDZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxTTaBNWStE+ZoCBRo0aK1b5cB7isl9/sPQBFtGG4Zsynsn6zvRmXGsj268cCPtAxEebmqhnM=@vger.kernel.org
X-Gm-Message-State: AFuF++kEWFXhd6Sp8Ni8qbR9rTIsSS3IMuQzRZ8QklcrbbM1g8FBWwFS
	GxlywIvTdpQmajCLo2B9USXa3ka35I8dhjZIt05TBSnWwc+uSI9nX0Uj
X-Gm-Gg: AYBFou2251PDZAW+QdCA3+iDV6HnmAB29O1nhbC6QzHVyw91exGaH1xmtRnlHLSoLOX
	SlZJkwFLTHdnHLPfdjRzcoTxS4IDZh5p0WYPRHJAsiWOM4ujZGUAQQ05pIeX7g7RuNtJ0Jj6bR4
	JcYNgqRLra0lt28dRNGmfazpnv97SyCfYXrY6cMuFmMsVZhpAZ218SxsU+TYkUeu9Sq/GLOvVCc
	Ne1BirhOz5qUD5BpXhQNnYP1OoGQ23vd8yrc7I1b4ICsD7g7279+BDkqbDcls1YWOWA3fptJf26
	gR4/wNRiVsfkGPPbwqtIZDjtn2mb4XdjWQn+ChvfxymOqfljBPa0Y7JrwV5CXY1/TodyDBb0rXF
	lQ1zUpNbZV8pzxt5vREDa+uZX3o+XbNAhSkbClU0Cn+sIzIzaPaB4jXDBvcRw4SEWKEFYUD9A+3
	KzQ1qZNfXYNpw5xmV9p3w+YF7i00PPnytH6IfTfvWWBzwfl9M+SordAqsBWXQUjm8ffTeeoDChb
	fr4xayobeY1K1WK3wGVZs1KF5I3tShdqXm/qsIR7LXl3tBkWsDkjiDUuUv9qBr6gWYggsGU11Lo
	GBWlMkVqsh0SZyIH
X-Received: by 2002:a05:6000:220d:b0:484:3d1b:7871 with SMTP id ffacd0b85a97d-48449f367eemr962710f8f.19.1788291066529;
        Tue, 01 Sep 2026 12:31:06 -0700 (PDT)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7315bsm1113106f8f.7.2026.09.01.12.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:31:05 -0700 (PDT)
From: Orgad Shaneh <orgads@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] usb: octeon-hcd: fix the FIFO-flush timeout computation
Date: Tue,  1 Sep 2026 19:30:27 +0000
Message-ID: <20260901193100.1352110-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827175703.1549-1-orgads@gmail.com>
References: <20260827175703.1549-1-orgads@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cvmx_wait_tx_rx() computes its 100us deadline from
(u64)octeon_get_clock_rate - the address of the function, not its
return value; the parentheses have been missing since the
CVMX_WAIT_FOR_FIELD32 macro became a function. The cast makes it
compile silently, and the resulting deadline is effectively infinite.

On a healthy controller the flush bit clears on the first read and
nothing is noticed. On a controller whose PHY did not come up (for
example when the reference-clock configuration is wrong for the board),
txfflsh/rxfflsh never clear and probe spins forever in __delay() -
observed as a hard hang with a soft-lockup splat on a CN5020 board,
where the board watchdog then resets the system with no console output.

Call the function, restoring the 100us timeout the code always
intended.

Fixes: 3e195a80e096 ("Staging: octeon-usb: Replaces CVMX_WAIT_FOR_FIELD32 macro with a function")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---

v2: no code change; added the Assisted-by tag for the AI assistance used
    (Documentation/process/coding-assistants.rst).

diff --git a/drivers/usb/host/octeon-hcd.c b/drivers/usb/host/octeon-hcd.c
--- a/drivers/usb/host/octeon-hcd.c
+++ b/drivers/usb/host/octeon-hcd.c
@@ -578,7 +578,7 @@
 	int result;
 	u64 address = CVMX_USBCX_GRSTCTL(usb->index);
 	u64 done = cvmx_get_cycle() + 100 *
-		   (u64)octeon_get_clock_rate / 1000000;
+		   (u64)octeon_get_clock_rate() / 1000000;
 	union cvmx_usbcx_grstctl c;
 
 	while (1) {
-- 
2.47.0
