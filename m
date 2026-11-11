Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413924;
	b=kKrVyt2sLeCuGMQuipMIFqsnVEoDPLyqRQCQ20sC7YcjccFagxnbF8OOjzsYZY0VjfAe
	 oUKcOkvjcZk3QkdoGzd1nN00VwfcLb5Mvc8bde23gDEcNupdP/JR2YEKBfRZhFuXagdD+
	 YmTmuFAQIg85JweTP2pxqveFO9PymxcICP+uEG4KRRoE0nKW5XSSym++LFL7O3ZgpLUn7
	 OBQ9+KIquzmlfmBt5Vye0LDzuV9E4sKBq2wWW72aUHO0Aq3Bb4OZDIOHrxIRJg3f79neX
	 v6ANAZvpM67nYbkPDf6gQb9Vh/uqU2Wl8tSh9o/vPWk6UmhR4jSg5OztcLIVz/eqbNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xB2s5ICjL3oZNT6AvTpBrsJtB4knw0Blt3rv8CPT2C4=;
	b=P2jg9ggCtXv+LvMf0yD4Rk1xCzxP/bmbKGvapGO7K6rQE3+bZ1eVky2ukVmuRXTljVag
	 R8SKqb9nnL2TeGaIwHXUxXMc0Nt+FhmA8jl4EdT3LkfWN01n/+CpeRz61ezFsW6UH0GSM
	 9naEuniKkNNV0ssHc4QViQcweoKgxJ94SQwF10XaF5Ssj5KbqD6//Y+q8Val6WXojUe+4
	 3VT2qz5ftsGw6ggGu6NlioIU3rY5nOAJgOTHFM6OVHcFH64+9hgxAaW5lYj1HhApR2ZJI
	 bOvOsosBhjNJz+vNPMc5yOi4Ce/BegGQNvIk3plc/+VHAc3xPWIJk4p4iBuTCVhd4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=TGAaFXZq;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CA60A3822
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 992CA60A3822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=TGAaFXZq
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so25985175e9.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413922; x=1795018722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xB2s5ICjL3oZNT6AvTpBrsJtB4knw0Blt3rv8CPT2C4=;
        b=TGAaFXZqf2Brxuyh2Exohfr7P8fxYKFal37wdrA7UNjI79I0ZnjXdGiL4EJesRtQsG
         D76COQSg5iYYvHX9juvxJ/zB+k/o22jwdL8GzfsubnXIeFFE5hNhq8II71G5Y1CUZYoy
         9fLwoG+YTOnvITgSGe3iZ8iG14qxTwiQMvech6s3ROnxuMCwFR4/Ld/N3uXvTdm8vfri
         czNlMo8XOQGS+MKEsSBlIPtItvNBy74On4GuUOU/awT2qLro+LUpyCGGL2b4wpuOk85r
         2IKdHPSA/uSTx+/F8TwFPeDMsQln3bOiVp77+J1180cNhMl8sMou+OWPwjStpw7HbyLY
         usZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413922; x=1795018722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xB2s5ICjL3oZNT6AvTpBrsJtB4knw0Blt3rv8CPT2C4=;
        b=yyiLbt/A/cn+/kAwPOQIMQNOU4ZnV1qMgDuc/PjXFEYlNzEH9ZzMwyHomWF2IRBpo/
         tzZ13yqhwjmtqVa03MjU24x8vkepmi8Pm9w1HBUjcwSgd+EMcgV9O3+AeHy/8NTDwRQ7
         MPX7BcQ78Z6EpvN1yN9E3u7bJCw7u0qyKdRsVF5BtQ/fFgH5+Q+55lgnwDyrYmvOivj6
         6pwhkTN0dokSkvgnnR+3W29SXJarc8z4QOgosnarphA5kDzUndohzYhGA3u8foNXazg+
         s7EdexofcFeoJhvaYBsUA3/yGpt6UV5p+LCpEAkm2ciyc2lSxjhFYtBO+5oqJ4nl9uHw
         edFQ==
X-Forwarded-Encrypted: i=1; AL+hErGc+/BZ7ZUBLg96wQ17Zp2jtvj13fkMwqdl3xLShcu1AFGQopfjNQW8Fu7jeKyWLQQ3JPK2JZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aB86Dz6X19vs3hMMYBxwoz046AZsI0Sb+AAUmADTwk9cDlh8Y
	EuO/OoRHz64ifyxwi02vs8mPxHPe4ghV2EPrnfYZbail74R44Jw5SN03Io5QmnMcVzM=
X-Gm-Gg: AYBFou0tBcEqUw//JNN3XZxG6qlck/3pELVX5gQGoXHz9M8lXdmKR39l+JsX0MPk5Go
	/Xm2ryuKVQa80BdddVGN/KILIJqZeh1VyV2mlIjM7XEtyYWAQO/Q94t9yNhnJCuvPPuY8XLcdkm
	Mffh3aaOKwfqMG/D4QCq0hUfxTnNhHr+I6UzcjlxhjAaqkotupCoAXfJDd4zEhmM9/x5Cs5lkdH
	jlqj0o32gsw/kKQqZysxt6H40C/Z/QDxW0r5sagO3Wlh8rbzWJffv+b+PcGuKZmrqXq9H1XwXJM
	REDMlkmyBOGv5cG3JkWbT6kp1Ca8n411wBgQ5mVplXltJxE45XbBLnPIA2thReI2sShcr7rqz/h
	3fcXS6tK5bLzj5HzfOxESGsLWJY53LFC+q7n4AiSyp8UZZPVsUQLk1SD6sud03RqFraApksxIbQ
	gWa7zR28eCS07crjwcZ1rRiDCq8JovcK3hiTOb/z2lAH1wla7QpjbTOWkhIejXGQUXtxtXQ+DwL
	Zy+XWam5XXa0yz1Zxa31r8z3vdIPq25Opv/Fo02XM+2nN1PgJhIjdkFsP+m0caW79VO3D+3NTsm
	QZTWpioRgJkrEVFw1mLYdRHkAn0C7XLTgty1+dgOLQ4Df6xSHDVGzxHcctXI87iER9mhhhIXkIE
	E4QPRJ969mvjMQ4hHKrrnfdoyJzs7xQpYEjsja5kW5/esa7zs07I=
X-Received: by 2002:a05:600c:354a:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4ba0935dacbmr52726595e9.11.1794413922136;
        Wed, 11 Nov 2026 08:18:42 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:41 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 7/9] ceph: fix osdmap use-after-free in ceph_sync_setxattr()
Date: Wed, 11 Nov 2026 17:18:28 +0100
Message-ID: <20261111161830.1336485-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

ceph_sync_setxattr() reads osdc->osdmap->epoch without holding
osdc->lock, but ceph_osdc_handle_map() replaces the osdmap and frees
the old one under that lock (held for writing).  A setxattr() racing
with an osdmap update can therefore read the epoch from freed memory
and send a garbage epoch to the MDS, which uses it to decide whether
it needs a newer osdmap to validate the layout.

Read the epoch while holding osdc->lock for reading.

Fixes: 968cd14edc3a ("ceph: set osdmap epoch for setxattr")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 8f97b6448d7a..64ccf70aa3dd 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1179,8 +1179,11 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 
 	if (op == CEPH_MDS_OP_SETXATTR) {
 		req->r_args.setxattr.flags = cpu_to_le32(flags);
+		/* ceph_osdc_handle_map() replaces and frees the osdmap */
+		down_read(&osdc->lock);
 		req->r_args.setxattr.osdmap_epoch =
 			cpu_to_le32(osdc->osdmap->epoch);
+		up_read(&osdc->lock);
 		req->r_pagelist = pagelist;
 		pagelist = NULL;
 	}
-- 
2.53.0

