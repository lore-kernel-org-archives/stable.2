Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267846;
	b=gYrRykGdULfldWlLdQ6CBMjKMYQPJ9GSURredY9Dx5Qci/RJCtOHZZe2O9mb+Jn+SWMH
	 IU8V73PhoAMJwXA8mlRbGPwgEGFldZP2ybZ0Hg+7Ga058XYFW54kBKLdwkCTScPwFHNIu
	 8KACX8ihQY0aOuhLDa1U8sfJ9PG6iJn0KpDH8FD7FEFX8qhtUz2Svq9kvioQFYkuFhp4U
	 Y0FmGOqITRpEDTUpw+RowV/vTU6JWySVdrweJnHxcqmOykXAQKAoPxF1E/Kwvsqp3M0KU
	 QsnIzbg646Cz7pk1u3I+ZJ69M4I1JHI5zQaTtz/4mZ2/ZOMaOO2u82mAu8qs0WxvbPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PmhbxwAhZobaultoBjSu8D2kIdPNPcMCUeuvmcfA7tQ=;
	b=SczGaAjqdxPhydfZ/SYLGkuj9ZI6mcm+2E/h0RlyF8m8q9hFMt8y0hnevYfJNEztAFK8
	 oAp+4LitSGHwTA7lOw33+9ZAQwKsVdpZfIIR1zQHK6aKbjYOlFcOcjuwGGy7V9Kw4dlZA
	 9D9HIkLyxK3pxhFEPXdOAqu6TfhT3mD2wbQdceqEDP3mrwAvuT4xJpv5XEm7xBHU07Uq2
	 NczM8YMHZKhXtjjDo4ImX8km9IypDSVyUhcVgaeOJ7BE3MiTd9TlM3/mFxLShKtG0tIP5
	 nnZYXCIeC9vcEqRb2FLfPiiEao2QuQ+2FKQi5cOcftFw4MXzV/LjK2aDsxNmnKf+wyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxZbf5mh;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB56606A330
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 23:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CB56606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxZbf5mh
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so614467eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267846; x=1794872646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmhbxwAhZobaultoBjSu8D2kIdPNPcMCUeuvmcfA7tQ=;
        b=oxZbf5mhfD5R6tub2yBirdozQyMqvd3vaE6RXMzRunBEPCd21lHXtgxIVDU5jzsXiW
         ly8Xetrfy+Bl5CqNLsBaJdMze/vK6V6vAt2CmW5aTVRO/89IENCVtggZi9/cd8dBmsVg
         St3bJGjNwf3URuHvK0Y43JfSxQR2CVPtyYbxmVZjBOCYM5WfumnsNbmIvtrXpOGnZyX2
         ESUReSh1v4YF3/216ZypQ9FqWhXu0o7ybAOdokOk+Jxi51crLfKmAZXtb0htWs1w6AsX
         Alb7DA+5HWWETI8quK9UDRL6DKiafDlaGs94L5SoVs7ChlwsWEcZifeth8eW/Ra1uu9f
         RwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267846; x=1794872646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PmhbxwAhZobaultoBjSu8D2kIdPNPcMCUeuvmcfA7tQ=;
        b=ycq2iXe8j323Z9xJwCwl0CvELHlKnZkCafTZS0nMBk192D4FZNBqusYDGlSA4YP6SL
         LKEMYoa3SbgJKPvoUXdgdki07zha22b+jxBVB8MYcHtyER5WzFw2D4paHvkHw2N4vp7v
         5Sa2DduQqMsQ4DV4GaHZHHXa4mD3V8OmFqLs3Wd1xx3zncm8X69ftSKA8IsxbgEokD66
         dcuu0rOTNPDBsU1FK5KtAzVmTRLFGgri7JxLrjBP04hXeqkZjC0kQLaWgzBg8GbikGoE
         lN6aHSxB7Vgr6ZQzIADx6waIO6NJXPFA84ozvSerhT3jgTPyoW3RQREPE893sCHbG9zG
         kPqQ==
X-Gm-Message-State: APuU4Z8E4KaqH40h2V0etWiOTPcxE5xPy5ziG3KNn+Ip3Ap5EiQHen9f
	1OguSKVPs8Yszo4hPRrF93elzeIOuthFo4GgK61xTeDL2ceAvjltx9OTTIrCHP9lGbLpyg==
X-Gm-Gg: AYBFou2W+W6B0MTHG8M9lgQvPOIJUxPSnYdxOiMQDOG1P2gCwl6XWvwIxwQrPkxqc90
	hEe5e2CSbKDXaNQxf50m80ecXoAEHZSA5NAwM4lQV9ywGynx68SCpLnxg9EJ1TkCqBeC54J5YZT
	htGcnfPxdc1nF0cyEGTUmvJ7gFWxzrHB5hGAxmWdPpuashWC2bIu27DX791NqUfmK5Ym8cYqFxl
	XL8vS8y40Fd+ssU2FN1taAl9DmUsU2U1HHFnuEn/uoDAu0zvzunF7cAlOr3lrOFPOsT8PCSMOr7
	hnI6oVhYcsHHAuLZXUknH6GWF9t7snuwqcsRe0e7ZpEearEjcMfqsXbhOSdSl9qhJlPE1enM7vm
	86T9p2x9sBqh3iV/holIDGU1soOcOc3N+K4FCHmud3T3iTWJfFwq9Ziue0YZpvVzYxEmKY3/PRa
	/KfTQtodJRwRjVgMG15I0DajlbTXGAsfbuVCkoIw1t43RAnSq+JBZm9Crrwe46OokbTPfmE4bf1
	QiMRdGtLARE+BuqqI+popCNaWbcz9cMZpi1haKUoAAtA6uCw9uQVoDUVZC7MNqnqO9kVCp3TecK
	rN1BolHma92REmOj0E0OqBSfrVe7A7nIPBogEhYIWQJ7kN92sxpOJ7hg1f8XXyXzxUxvTo5eGV9
	ubOfx09HOFbqnwJTdeQL2kjQtl12nyRjo4quByjzCagHriowIqxl6dA7LdpQ=
X-Received: by 2002:a05:7022:289:b0:179:a1d0:be39 with SMTP id a92af1059eb24-1b3b606291fmr998688c88.29.1794267845397;
        Mon, 09 Nov 2026 15:44:05 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b72ce0sm2372807c88.18.2026.11.09.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:44:04 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	tglx@kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH 6.12.y] posix-timers: Accept NULL clock_getres() output in stubs
Date: Mon,  9 Nov 2026 23:43:56 +0000
Message-ID: <20261109234356.76230-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107052631-failed-6.12-5b819071e434@kernel.org>
References: <20261107052631-failed-6.12-5b819071e434@kernel.org>
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

[ Upstream commit 5b819071e4346256c4edbae5cc2095dff25694fc ]

With CONFIG_POSIX_TIMERS disabled, clock_getres() returns -EFAULT for a
supported clock when the result pointer is NULL. POSIX permits a NULL
result pointer to suppress returning the clock resolution.

Only copy the result when a destination is provided, in both the native
and time32 stubs. This matches the full POSIX timer implementation and
preserves clock ID validation.

Fixes: baa73d9e478f ("posix-timers: Make them configurable")
Fixes: d822cdcce43f ("posix-timers: Move compat versions of clock_gettime/settime/getres")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020161121.85042-1-dennylin0707@gmail.com
---
 kernel/time/posix-stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 9b6fcb8d85e7..5a27335a917e 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -83,7 +83,7 @@ SYSCALL_DEFINE2(clock_getres, const clockid_t, which_clock, struct __kernel_time
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_timespec64(&rtn_tp, tp))
+		if (tp && put_timespec64(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:
@@ -166,7 +166,7 @@ SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
 	case CLOCK_BOOTTIME:
-		if (put_old_timespec32(&rtn_tp, tp))
+		if (tp && put_old_timespec32(&rtn_tp, tp))
 			return -EFAULT;
 		return 0;
 	default:

base-commit: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e
-- 
2.43.0
