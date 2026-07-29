Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408042D73A0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 04:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301080; cv=none; b=iD5SEwKpUnz84PNs1wELPg38+yM/2uYiAnAE0a5fwYqx4XRDD2cVUS9p/rAHIKtqoQsj7VHIvCEIHG1WRUhP5bWQGlpGeFm1Eutd3bSL7Bpzl5kGtLxn8386qqeyF+Zle20sJsQE9XvsYRnCsum2xuEITe2vKxR4dx4f5lK6rv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301080; c=relaxed/simple;
	bh=Nr7F7IzDDEAehlkrU6KkC7ObuFVMftM4VNaGNdKZ0qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYH+mOd/ibQzZihOeiLknMjZONhxkq2A6HhM0d978azgUoW3LEO5xhe0w8x+AGzYG8axycmZTqGdCS/699QXWxiAqT/JFju+PDrVbW4axdgjwH+ZFEqiArTJNhz228aYgRMm7o+qqz7TzGvBZA9UGdln7oFiZoLRaJbVfgckaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c+2fSa7C; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c+2fSa7C"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso1136799a12.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785301078; x=1785905878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GX6ZQNuH3dxPli3WpAJMtLnJrmTWVzHw28ifTrGxnhc=;
        b=c+2fSa7CMmmfGb3UciaI6dqn4I5SHHR/ah/MmZAtd6O8YPnNSymFo8/2brGq/kyYl1
         TbRflg6tzYVzWkWl7b1SLbJVhi2baJY98N4wePiSwLVutCuDRrha7SdzVdvLUBQGB+2F
         7gsh7WYfrZMY+P3VZpDzmcWuM4IxPlFltkxj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785301078; x=1785905878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GX6ZQNuH3dxPli3WpAJMtLnJrmTWVzHw28ifTrGxnhc=;
        b=NI0NXpJApO94Kr1Z34EsyXrwIcLNQ4oSVXHihdZFXNDx+zGghrSMz8jRBl4q9kXLik
         C0K3BWPOCvfI7r1RXzH+ZU8Q6P/4hN82sAn00qu6+M4+yQ5i8Rfvzru2HImdRaXHmaQQ
         whu2ezSE0ueoXUFYq/LNrgtQCdBxB9218zbvGISKKXHE2wQX3AER46pOR2HaD2KAIKhp
         ta80iKRdM67KhFRA60saUWUJfhlNAkWX8oaV9LwrMcd4BUAgszRwjAaCmlwB6MlO4Exp
         v8z8bLu3wJesXL2AaQZ9CSOgCLIx2mASQ7Rpp+gp3T49UzoGtLyTmz6VLTWmztN3Ol9B
         7/yA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3KTizEEIwdTQyNdLnQyKyzyGYzkFfVOXJH1LT+l119BcP6+MvdgpIugdfrc+pwyii9UozPEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPvWwutfZQgWgMhQosWKYr/GKCazxj8OiiEtrZG3U0XC0a3iT
	Kow2SFYQrRskhxrxk+2uOyRiQcDpuOuMboaQa0Fwfo2++ZavcYvYaz2OUk+vgr0BHw==
X-Gm-Gg: AR+sD12Fgw3QF5VIv4q8wCN10spzD2QtwtBoVxuYVfFg6phbCV0oEMZhb59OYuaWIwt
	Mvh8agpJLQliN/cVKGiP8EEfsyI+RdBwj2aoWj5zbquo9/3vjA8noQwNUyvmtEDMDlgoMwtT0Wx
	9OZsjpHeYWy6IgsPH3dgsjaTBEab+3DXO32fHWZjWXc4LWJuN/fLrwfE+Tb9VFHWl0EjG7pylZK
	s8916VCkAvwG9aM0oEe+1OM03KCz1yraWqidL3r2vQnPI+E5g1uPMcxgjtgue64rcCaXfhUTc8j
	dmdlkB/z+hf+6lZI/nMNcbA8Vr2aWUGQyuLEpQEe8FExzQnHdxDNdHbUQcVDRQ3x0FzXSfHtKn7
	PGxtudr/kjpmlhYHQPGejcW1SElFqUzTzUTNHWNOj2R4QLjtsptNMKiRtqQ7OvilOzrS/fHtP7m
	QkqAedPsmYf9Y9wvlg3V2svOKiec/EhMXWMma9LKiC15rWivVv1v1Og7SI7K+r9LsHkJpIocL+2
	/Nt+e8IiqQea6hDT7rvQcCudT4OUoAbc2IOsXQz37QYk3SnR0s=
X-Received: by 2002:a05:6a21:494:b0:3c4:2c6a:6143 with SMTP id adf61e73a8af0-3c8e47d990emr911497637.33.1785301078465;
        Tue, 28 Jul 2026 21:57:58 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:65c1:52a3:f6d3:37dc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba63c743sm335183a12.26.2026.07.28.21.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 21:57:57 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Haoqin Huang <haoqinhuang7@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] zram: validate deflate params
Date: Wed, 29 Jul 2026 13:57:36 +0900
Message-ID: <20260729045745.775973-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729045745.775973-1-senozhatsky@chromium.org>
References: <20260729045745.775973-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must validate user-supplied deflate winbits before we
pass it to zlib_deflate_workspacesize(), which triggers
BUG_ON() if winbits value is outside of valid ranges.

Fixes: dc75a0d93bd5 ("zram: support deflate-specific params")
Link: https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang7@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_deflate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index f92a52a720d1..b3f7d08b49d9 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -24,8 +24,16 @@ static int deflate_setup_params(struct zcomp_params *params)
 {
 	if (params->level == ZCOMP_PARAM_NOT_SET)
 		params->level = Z_DEFAULT_COMPRESSION;
-	if (params->deflate.winbits == ZCOMP_PARAM_NOT_SET)
+	if (params->deflate.winbits == ZCOMP_PARAM_NOT_SET) {
 		params->deflate.winbits = DEFLATE_DEF_WINBITS;
+	} else {
+		s32 wb = params->deflate.winbits;
+
+		if ((wb < -15 || wb > -9) && (wb < 9 || wb > 15)) {
+			pr_err("invalid deflate winbits: %d\n", wb);
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
-- 
2.55.0.508.g3f0d502094-goog

