Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794777020;
	b=umEflpvSlIcHKhNzqvcZxxICKyqkSsjUxwJubY2x9ASWuhy2KN8lB/UfcxfR+QH8il6e
	 G7pPhdl87dq5Ed9dVaCaGj6BjCDiL1z6TzTIq3GSKMaTJN6lzJVaL1V3km/CU4vsrrfRE
	 jOVh9aVpe44DwkrxucYfoBmlxFM4e0qk1sbPF++9S+b2WfrpIIbxf1OSrFBbhKmn1KLGV
	 gbwycz40KdatX2bW+TIZDOyth5GMjQe1wMQkHZe3G2/q7qKjVFBVNVPOeYsVeE602l+jH
	 ML0P/rMu4KGgCS7sOmVKaGuwdLlZ+NU3OkhPmO6h/Vn1z4M595IxJdduxcC74rNkPpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794777020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/ARd3XR21b98dC+E0q+y0HBDJ/Q/aPk0xOOUSlTPKys=;
	b=3HjpZf6BTpnItlw/9dJIxz0viO1e2JjSN0yAzfer3fYaflSn82PDZdIvh+DagNmtvQpM
	 JmJfuZeZxAUsMEz10a5bM6+vqSiS0yDxvR+U/FSRmDD9cfA7ShIU6CgOaVYpsPISGozeQ
	 04a6zBSTmx31awts0ZsNHU9f5dgpPlRo1W1yY6PSuf6MTwJAHoVeoVKxamH66nP8fdbsf
	 78Y9cMM4+jJ/lU5kmPxSNVMZlsZgfYRfssdoryMmsCzIT0M6SQHRPyEeEZ3Tr3LUMjbec
	 ictpW8I7sHb+J1/E1DPV5VMbsqL6EeaDDZkAPSB0Ru4y5peLTNmnfx3v41Ekt1bEfBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zov0bB1B;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC38606A331
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCC38606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zov0bB1B
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1249590b3a.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 13:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794777019; x=1795381819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ARd3XR21b98dC+E0q+y0HBDJ/Q/aPk0xOOUSlTPKys=;
        b=zov0bB1BeWYlvinho67CCGeV5prFtKbwWE5DLx9OjQ9i5m0s4tKX7fcbk9OnyZxscj
         iiIZn1Pe0QEadl9n0hXFATr+CIi22CgXmZ+ZvhSGE/YNbvnwoYW3b+jMhU13p3BSIjrq
         Iws/Wvp0ObtM3pHjNj/727/xUe2atB+gxKGMqJsexyGvTKRsfsQ8WfCAAmrbLe7lpXJj
         OuF1IhLuRSTcEf9foqQkIJ9H59SqT/4n8tm/GfxFgyj2JKwbvMnwCrhqWZcx1uhj9eRV
         CuCxJaL5IzARj3qrtmPtHCb8HoBRC4gsCO6tTCGHZ3alIWAb9uFhQ/SnTJ+dOYlmYvOe
         oS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794777019; x=1795381819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ARd3XR21b98dC+E0q+y0HBDJ/Q/aPk0xOOUSlTPKys=;
        b=L7jLd0X7QPQTfYYQBayrvwwVbUocf9JzUp/RE+OgAVSuDFrHWRyOSIaC1mNeLTUtv3
         aHbq9Sc5Jz9Tj2bM5gPaUbE2A6xW9w7bxwmuROAuCSO87wj4XnSjSgoR1Mfm6zd4MDbm
         i38LSCM3Ij6WaJ3mqGsbBWuwX+nTet1XyRGEntN3eIzoeDuMXmLnEOBISjHpAE85dBAZ
         cDKDXPdtTqXm2AeWenxOTeCJSKZZfeS2ENRowlkzXA/sRZzS5Z1yrmVSoApyXr5la5XX
         LOcUhTIUPTSnoSbWSzwy+YI2ycsb0/RrQ7xH8QXVE19phzbg2XIJsBk/aTSqH5OZy5Fi
         W+Wg==
X-Forwarded-Encrypted: i=1; AL+hErG3t+LjTZoSuNfJuusFhwTzULJ1mexlnHbNG5ICRgXNyj4U3OBxJ/IcllvtD3getzPNQ0NS/Sk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/m6pjvqH7x26EYUtgZyoFvT9DJnSiaeuxNZYDS9z4/CRKQFQKu
	TBK1xg4Rdf0U6XT+EczBhnaaamC6nq17T8uHthNnyIURx6sXq1zALe+G
X-Gm-Gg: AYBFou2nTjNVV6M5xLWMhsI2j1tsRPWiT8q3PcEfZo71MaOdnfnmyS6WDJdhNP157wh
	ZEVKsCPp39pAOj37wPW/uUl9vL+7KxraT9fxqNR5JtVwh+ol0LIaKJjdp81kHen6SgK8M+3RKIW
	tZKL+ykjnbnjjxG/ZpElhQfuH47ctjHXvrDFht2EX34p4a/e8tcKVGu7BGPdEXxSIdkueurt2Li
	4ab6WI6zpgn7VekJXcHnZt68jYfpGhCCoqq4h419Puy17TNljWeDPgJyarhuUfXxJcVB9Eo4Qyz
	g8WAbIbcFYFVCPt2pOLJm7nXum5fzuEuD5Vx/roswSlgueCa6oIOEc0nVkSmGEHYbq5o9m8WJnr
	OwmF0TDBRfbj8XICA9MAJUHHgQYCLDkGkeTyDUAIGmGfL3Ee4h5P7DXEjUcJ3C0zkR0BITjdjQs
	jnmzXG60ibSPYtWZWnqAIq57crBVwxtl9EJMy9f+jh1V8p1N16rPG9RaifHEHcWaqbeEJvavfxf
	RE/kZdWt/DfrsghPk+6W57CcnZvxqsi9aDSxJhmcNbww7CObOCqivc8nBWlL+cJYOW+uQOHD9nj
	r5Q0ysoMHvorgZoYrHUItc8driHLlMAgeTqSIifpcsrgGNeQew==
X-Received: by 2002:a05:6a00:1a89:b0:8b1:e8cd:49cf with SMTP id d2e1a72fcca58-8beb619b3f3mr7131715b3a.22.1794777019150;
        Sun, 15 Nov 2026 13:10:19 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6e7f5sm2892615b3a.25.2026.11.15.13.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 13:10:17 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] fanotify: zero-pad copied event names after an embedded NUL
Date: Mon, 16 Nov 2026 06:09:50 +0900
Message-ID: <20261115210952.2140036-4-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com>
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

fanotify_alloc_name_event() sizes the variable-length event buffer from
the qstr lengths and allocates it via kvmalloc() without zeroing.
fanotify_info_copy_name() and fanotify_info_copy_name2() record
name->len in info->name_len and info->name2_len, but copy the strings
with strscpy().

If a qstr contains an embedded NUL byte, strscpy() stops at the first
NUL and leaves the trailing bytes of the allocated name buffer
uninitialized. copy_fid_info_to_user() then copies name_len + 1 bytes
to userspace, leaking uninitialized kernel heap memory.

This mismatch dates back to
commit 929943b38daf ("fanotify: add support for FAN_REPORT_NAME") and
remained after commit 0fdbe845534f
("fanotify: replace deprecated strcpy in fanotify_info_copy_{name,name2}").

Switch both helpers to strscpy_pad() so any trailing bytes up to the
recorded length are zeroed.

Fixes: 929943b38daf ("fanotify: add support for FAN_REPORT_NAME")
Cc: stable@vger.kernel.org
Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
---
Note: default FUSE mounts report a zero fsid (-ENODEV on fanotify_mark()
with FAN_REPORT_DFID_NAME), so this patch was runtime-tested on tmpfs
with FAN_REPORT_DFID_NAME create and FAN_RENAME events.

 fs/notify/fanotify/fanotify.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index c25cf5c1fc70..4a1f14aa4974 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -225,14 +225,14 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 		return;
 
 	info->name_len = name->len;
-	strscpy(fanotify_info_name(info), name->name, name->len + 1);
+	strscpy_pad(fanotify_info_name(info), name->name, name->len + 1);
 }
 
 static inline void fanotify_info_copy_name2(struct fanotify_info *info,
 					    const struct qstr *name)
 {
 	info->name2_len = name->len;
-	strscpy(fanotify_info_name2(info), name->name, name->len + 1);
+	strscpy_pad(fanotify_info_name2(info), name->name, name->len + 1);
 }
 
 /*
-- 
2.43.0
