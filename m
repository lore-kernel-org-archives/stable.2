Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874792;
	b=asFA0COHDoJjvpxG74w/Ixs0YJR2x6DJdShk+x5uAM2VnkfGy77OH79XEdUe1qnmLsFH
	 JRT6mEEbprXhDztiQif91u5w82ZT09lX72Hod60NS2rODIBLjMjkrlKMyJfCc0ePQlhGP
	 V1nJrHJc3n5ctLuD0EQhmr2fTzDfmu+dLX4rdMW4yIyImliDn8Lucvv/IGUoVyyMGrUST
	 J94cHXfysxES64zh2LRYFHW4s3KRcxewj/ni2w0qwcHKGqZpzzvuKBjoC1No4/klJswc7
	 taXSvyBMAx7qanQ+VbJMtW+W20l8zoawTJ54h3/vS8q8wyxW3ZWEwCuRqSTqzNZSZhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OW9iVuHkIi0uGMCb5+4kVxSMn6nqDiy+SCxTvwwwbsk=;
	b=HV/1SAi49eukCLaEcc/aCiJXpUqhjfiP3sKpL8KSdJBXH4KGrG/xEkwJqMDsS7wHnivi
	 4FbNcYglpq7Xbev1RnsjRPq1/5K+FrPIF7kYsCSgiuDepOKLysYgGTMhj9ischPD3Z3hT
	 27ah3M28OYG6hrAM8WFPezZYClCHLQl+ixj/3CazVNN7z3Fo8rUwkSiCJWP5dIszVzGJo
	 zmcUc+VWwxVX+T0QdJhTJ8/301D4O3HS/O44VNs+p+cbZQPERdMx1jKXr7ZuInC2ZHuoT
	 RsfFspawgolDlnCB2iIWnyJdjPlM6eVWSDp8QHF6nhxYBQUaBjd3wZE0Nw5itiRiRFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0+D1Mcn;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACA606A33C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 14:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AACA606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0+D1Mcn
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso118829636d6.1
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 06:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795874791; x=1796479591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OW9iVuHkIi0uGMCb5+4kVxSMn6nqDiy+SCxTvwwwbsk=;
        b=M0+D1McnIblrhRrp2kLKdAcCGAQTJxZp2eJaA/DYlU1hVHRoDK2kVBt9aCjHVWNz+m
         Cb6UgiOXaYF1KlhoUnP4qR9SUCTvpLBNuQnkDpzl9FchbLlpZwNkOC+AD5hETG3TvKf7
         /kDrzMpMwA0v/LFFO1fkyqRL4e+Ypsr4dYYbBcd8+zl7kZP8T2cOwK0Z9ogilwxVgmgA
         Fyv1rFxxE0VQjkWhw1FM0FNUwvDe3kQcpxiirk81ivqTrMSqIAqQ8/uvWzlaK4dUObIG
         VIcwJz7JkWLJjvvV2SlvtKDuXtCxOnLYC7TM897ADTP2kWmV+JK3GWiENaJUKpbPx8jN
         uUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795874791; x=1796479591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OW9iVuHkIi0uGMCb5+4kVxSMn6nqDiy+SCxTvwwwbsk=;
        b=TPOc48j+7FLq4eSlV7dHTs9okel2DN4hq4vqbiAT/DkzTUqBd1aMzf8vWb8wbUS710
         JN75HrLVDCPb1bLqpwZwxGIH5PnHq/v1H1yhb3K/tb85pJlXH1JO+3gZC1vSf2IYmIXJ
         ptzApktgJ5BwZbwhmEVRgfBgfnXy2FIUj1kB6ocn7wZglyD/9rBcMREDYtLuN8q34oiu
         Mse2IvsEQKGzka201OiQTLlm5+GwJ3ngH/Cz5zV/oCS+hSnGE3IVIstTuT1HgLbvNA0d
         5TqqTTz1CR3zD9TrSREJqh4AKQMEqnWfSaYcw32n3TavjFXpVfIQ1qlADM3SigpchkWr
         rTcQ==
X-Forwarded-Encrypted: i=1; AL+hErE4Tb3RWfn0L8EWgaQ0RCDRWyFSuuBYAgK2s5WPbiGEGWfamqrT/zCHdSksEXa9S1dvTsJE8iU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HEp7zYOWc2HxZVQmcaS6/JspD8q4jasTcbzA0uaiQyGFBeoAR
	uOm0kpE61zDFvYphpyM90Q0350P5W2+iOdEhbUUC0eJILWK9TqCVorkW
X-Gm-Gg: AZFdTZcpVx+LbphO6AR3KEPAh5e401fgbiF2dB/XAtBs/9pwtWCte9eBb1BqkHIzYtS
	goxSXU5Jo3otlUzDUhgg+xuRbLAMPLlzxkEeY/eW0a2YOB172+pMetejHY+GpObIAtgupOHt1G7
	EdTX5zyH3OtomjelxxSapNYD5lNEjEc/8S1UsEj/kq36gP08K/SNlNla8ziuzDdJOp977kq51kh
	OitY+/bx1BApIwHVL8/14niXqfYe5tOF4KNKczuRD9etWGW8z5AF1h8/9EICeZwcM6k2u9oii28
	ofbXNZNVqDTFv4liEcG1iVbKXymoZsvrQ2QvzjJEznrYCbSx7IHqDCj/yfy8Wv1jViC9wW9hGLi
	ZOJAbmrCpiwm9we3/I1wJTwnd5LIOQFbaP5mF0n603+QKPqgbdgiPcKZc4R/eBuBbYRw7bgB4gq
	7QfrFLLeQySY1Mwv7r0TUnWfYyiqrqd6ln3j+/eUyyaLq8HhS6hJlKgXUPrmuGLHmqMTiWIygRO
	vuweltxWw/wFA3GG8MvutqmsTnkv+1Z4fwGHSteG1AclVBNJMUMw92Lyzulieyr0guvDylCD3+X
	B+PDu95TTgzRdG+1Bz0JUWwwMcrWuKONf0oUMgKMk34avq/LKj+/uo2RzPJH3acqTV+znDgOOPR
	5kUzg
X-Received: by 2002:ad4:5cc7:0:b0:921:e08:1d9d with SMTP id 6a1803df08f44-92134b93acbmr546792206d6.49.1795874791266;
        Sat, 28 Nov 2026 06:06:31 -0800 (PST)
Received: from localhost ([138.197.109.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a08552sm241627116d6.34.2026.11.28.06.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:06:30 -0800 (PST)
From: Nikolai Dokutovich <ndokutovich@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nikolai Dokutovich <ndokutovich@gmail.com>
Subject: [PATCH 2/2] selftests/namespaces: check that listns() rejects a non-zero spare2
Date: Sat, 28 Nov 2026 17:06:23 +0300
Message-ID: <20261128140623.19-3-ndokutovich@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128140623.19-1-ndokutovich@gmail.com>
References: <20261128140623.19-1-ndokutovich@gmail.com>
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

copy_ns_id_req() rejects a non-zero reserved field.  Extend the error
case test to cover @spare2 as well as @spare.

Signed-off-by: Nikolai Dokutovich <ndokutovich@gmail.com>
---
 tools/testing/selftests/namespaces/listns_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 538d60f908b4..c52b02bd416a 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -667,6 +667,17 @@ TEST(listns_error_cases)
 	}
 	req.spare = 0;
 
+	/* Test with invalid spare2 field */
+	req.spare2 = 1;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (errno == ENOSYS) {
+		/* listns() not supported, skip this check */
+	} else {
+		ASSERT_LT(ret, 0);
+		ASSERT_EQ(errno, EINVAL);
+	}
+	req.spare2 = 0;
+
 	/* Test with huge nr_ns_ids */
 	ret = sys_listns(&req, ns_ids, 2000000, 0);
 	if (errno == ENOSYS) {
-- 
2.43.0

