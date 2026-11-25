Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608770;
	b=YM3xUjLfYogW0omrYsDKzPiwugSNbXg4fRvnBPCemfAHeq4GjKDjTDfaSLPsJB2N9xKW
	 HJCHGyNsCiqGPtLwkR8kdzZKUe6jYvNGF4+gkDrDRGObpey3AOuWj/xB/A1wOOyb9sbNS
	 XsPElNWI2+r5zMS2cjic2hW+k1Z0tt+nu5aN9tUVbY8DHmsaGXrVKnfn2+nTrprxj1jEI
	 AkoUTnzfFijGIa/87MAS3IDdaKtRcEdFm8RCd/gOXzp/e2Db8WqECifX/QFX3qp3QBud1
	 kctWNJ+Dz9qv4Sg+QOCO0Q+gO92dDiGV1jjOGclqlKJALJNn1jT9E5/ksO70q06ooag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YvZ+MYm/tEerVMyhRfgrUkzK2+6reEodKLZZg+DwbmQ=;
	b=iD3QBo5ELy3m8bWMvRO+wBZeMlMZHuny5+H46mYN3rdsFkZKKI60nPAPy/MiXRX0VBfI
	 rQ8NB9yQpNiExA6OCW2/9d0+HnGs5oC2eTQGlfBxtBfyHB7WBwJQJZUV8y5/MXkBQinRH
	 5D1VtPJathojzdiP+iXnfePNJdrrmezPgLNFmcoluX0XY04E7jVn5ZVK/9KjrWhVB9h4Y
	 W6dVCqSf6YQHyKIsoEClftO188oxHStAe7+5VY/7HJWMZLZH/jfC9eJbATL5qK47vxezi
	 /qUq1Q+75clxTUK2ryEz2MBocETTSCMDqzqWxCQbTPQ1ndDCQ/SUbuhErx33cB9RhUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDmtFYMz;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEF606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBEF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDmtFYMz
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2827371eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608769; x=1796213569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvZ+MYm/tEerVMyhRfgrUkzK2+6reEodKLZZg+DwbmQ=;
        b=ZDmtFYMzXcImZicAXIG8oXjEPLiR1MKbH9dxPWNJwHFEgNeAJC7LkbkdEV9lEelwmU
         Bf49U3MLLDqAC0e28Oty2RTJDeOWsP+YmjsAoGldobmSHc7gWO5cJZuveAtcy7JhEqZ4
         boRSIBrN9dNAjXCblnkl1W6JJqwZSWJ37kwnXRlajuPUIys++GMRUIohsUsBguX5fBbr
         cUZ3JhPeSu74kdpn6V5yr+/ikAMSTynXUa6q8E4wclOwC2bBWc60POoFwnHo3hDgkjo8
         vvXUHGPuCePYsT//3C05yj0GpFNXb8sgD5NOsEoceQ3JpSuQAV+WmRxAdJtfBvwQp6fi
         6sEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608769; x=1796213569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YvZ+MYm/tEerVMyhRfgrUkzK2+6reEodKLZZg+DwbmQ=;
        b=lYGy5+XBG8ednvd2tRUtA7N6kTvnink8tn5g3p2jRYCdvG5k9x/k2M+UbLk0hlsM29
         NbA3a7S81Flmx6TJNgEOUxotyMp/40XMOX2EbZuKUaFfsdosI0HQ3eRezCtsY1Zh7Qvb
         TWYRn3TQCPDDJpEUHU2q88841QnaItQXTlFhnNCvNxv2SpW7ojEdEnDFkvla2XRBV+zf
         wAo84MXfrrH47FNB6K9Sjg8O7fFT29mkgfHaM26zxzJJ6VJlYvJQU9K2U9xi7xeqsIP3
         EK37oFsGgiX4mUEHyi+K8VR0RAmS5NSb3TVvcPdtx4gF4bdHSEeHkDbmqg6FfW9mVALg
         DMpA==
X-Forwarded-Encrypted: i=1; AL+hErGpnAsMLnQSYTl6YOcReg2sjTDQkUCT2ikhsh7oHtLdFfeu3GAnpNm6LDzdrnFFDINapm0xEco=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cfSEMIFk1Nvv503SrPdILEsR9QWDJmte2NFB0CH5HIrzQ6a4a
	gniHlKKv7EtAB5G5Eaa23NM6KOSr67GTowe/JQgPiKR7/SZvdtUg3db0
X-Gm-Gg: AZFdTZeMtHUuPiyU8IcBLw3uJOOZBOrw9w26imhCJ7bbdbNJIqKDcyo4lQH8/y+vbPA
	DsOx7C9xVjaG3bDA35hM4qBRYgn+ZTt3GhroGEzfguhGpGvAWvnB/Rc32H0sfZQApb2qMRA6K83
	YBp3XkD2aEQ7oewF0LEDSJxjJZWmGlG/1PaEZ047oSwXBE+I/jUa1AqrYgTLRLngYp+tKQgFbP1
	CQbYPBO0MoSQk2M2efmG1Uwx20BA2b0XCsZ+pBxFoQQu7Uz7IattXxru61WiegI840Hxxrwv48q
	8cqB6mDdKIkBDYXsx6QCe9IkFwDQdgfbOgXt0AlYJd84pIM+2xiTejLtXuGSEha55LQy5lrE2yR
	9X6x2CfcPU/3gA4vARoDAt61VMCh5xQ7/uPs5CWhSqu00GKU8t38QV/O40GzlMhJ8v8z5u7g/TJ
	X9pE6kEnU4FEpw9FLLyT1nkrAdl/P4FE77RAWElzG1yB9xiVFIz8ChH1wQ4JlZj5B2lCl3ebU6J
	6inr+8E1SfQ+mA5+/VHP66Gj4xygT31lKQzKvRfZcAfoJHj8LZ1jVQJK+yDRwGRhwFvTn9CGGaY
	3f5leCwpNkxjYvKMTfYYgTnwWKQ6arxQj9yoXgt4q4yJQEQWpSADIQ==
X-Received: by 2002:a05:7301:a0d:b0:369:fa21:ba0b with SMTP id 5a478bee46e88-38570847a85mr20043418eec.33.1795608768857;
        Wed, 25 Nov 2026 04:12:48 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm12234336eec.17.2026.11.25.04.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:12:48 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ALSA: bebob: bound the stream format entries to the response length
Date: Wed, 25 Nov 2026 20:12:37 +0800
Message-Id: <20261125121238.1602172-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125121238.1602172-1-maoyixie.tju@gmail.com>
References: <20261125121238.1602172-1-maoyixie.tju@gmail.com>
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

parse_stream_formation() takes the number of two-byte entries of a
stream format from buf[4]. It ignores its len argument. A count of 62
or more can read past the 128-byte buffer. A smaller count can still
read bytes that are not part of the response.

Return -EIO when the entries do not fit into the response.

Found with a CodeQL-based static analysis tool. Reproduced in a
userspace harness under AddressSanitizer. Not tested on hardware.

Fixes: eb7b3a056cd8 ("ALSA: bebob: Add commands and connections/streams management")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 sound/firewire/bebob/bebob_stream.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 5850357cb3da..8eceafc70a44 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -730,6 +730,10 @@ parse_stream_formation(u8 *buf, unsigned int len,
 	if (i == ARRAY_SIZE(bridgeco_freq_table))
 		return -ENOSYS;
 
+	/* The entries should be within the response. */
+	if (len < 5 || len < 5 + buf[4] * 2)
+		return -EIO;
+
 	/* Avoid double count by different entries for the same rate. */
 	memset(&formation[i], 0, sizeof(struct snd_bebob_stream_formation));
 
-- 
2.34.1

