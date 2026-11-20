Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155479;
	b=X5bhSuz/ph2+tDI15r7r1ZkSJ3GGv9Ij++PQVpvAlNlMfDknWq+d9IsPkKP6VJSGy4RE
	 CEKRCRkYl16jMcv7h5ICn6sgdWCxpRECg2fWKyYEs+ZjJbnTvV+9uKn/hzPYTI0vvL0iJ
	 PBFsR89dmlsFw/0GwqJp/a2Q2p9ppyMEpTonim0522DU8Q5/mbVGJ6nvEHHA9Sxj7YwhA
	 NAuXA7TrR6FFeTf9wbPEdPq7RsvnTPVhwE/IpNH08O++TZuc035L/W15RY9gWyUYt7tV2
	 crAvQ6U+PJ3yWvmhpJva70JpX1c3XkVQ65VprDdIUbGH2+GUW5fDO9pkpQtjyVSz67Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zGvI4qlnDuwkxAknmqETH4wyE0qutMq1KNHulBr9l7A=;
	b=V0ftlvm7PtDcUyRj0g9Zh8AF5qAvadC2g24LE2z8gEzil+DbHbibcPA/4lCBiinAv0X6
	 BzccO/9+CaLRpfaSC2wVQTKlDIfBMlbdiHCEWqvJTm+iqEG5Dd1yRCRn2onF4Zt9m7HRX
	 B2vUMQGj3J6qrX01B5wuSWWkJoYimFRoSm9baH4r6nmqlzqKWYUqNQFuz4Lax5lwP8k1N
	 5PIl3SI0NxhN1lmzfK7jc0QrZ4XcdEIpX5BLjIEmxdub7ibiG5fbVGKsC3/+Zdhmf4s8u
	 K6Jc7JmaV8rQNOFAFfp/Vg9Icr77rJhlgsQyZ5ORZf6b87mAkc161EWUw7TRg/siedw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MPK5Ze5h;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0AF606A510
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B0AF606A510
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MPK5Ze5h
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so1576965c88.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795155474; x=1795760274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGvI4qlnDuwkxAknmqETH4wyE0qutMq1KNHulBr9l7A=;
        b=MPK5Ze5hiqqiwWtgsD6EifjxAluvs/ZwqIJiu0hIyuVCOu06pKhsrqNz5nopfa//YQ
         lrOEM4PfMxB3LV/M08mLO2AADexQ1dROFNrtsSTy6p67ZzhwRWdvXdHHwpGO8TiYuoQ5
         5paolB5ITQhsiaeSpyjbwParvTRtMJtTDdz2O6eLnxF4MxwGYjajyhWHGz3ltp2EI4yx
         6vvSiwNullQPtKS20b/zC/fR6mlaLmta6kSKrfVc/uJU+0soGt5cEjj/WaqiwoWCPZUp
         tj6WfLXTPUrM0X+2+Hh1IsyCC72unW7g6ys1auYOfJS4RxYqHwHDY3wyKiVsqItn4UaC
         o29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795155474; x=1795760274;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGvI4qlnDuwkxAknmqETH4wyE0qutMq1KNHulBr9l7A=;
        b=y9R6/9p6rha63eXENqj+mnm7pwXd2yMwjWtWV+aADsplnHhYBoumfuK0UCHphkhWGx
         Av0Z7bvfc0z4BAgBbWcYnm1nu+Ccv97D4TM7HRJ1KcA1YEPSYwlictgQK/nnMsp+HJZO
         YW8+oIX//ORVaQsF/OX2Vc14PcUWbuzIGrTEqJshl5mH46iRzvpWaLTq9qrBZfyXXLXB
         26pm7yM/qkYp2foxVjkqXIHH8PRV/ktjBO3Frox8X7UMGmECKzkTYhx1v9+eekmmyPY2
         LQwMKCz9yOqgwlq1zkVNeUT+DkRctxHkpiUlIuq38Sdc6HpOtz4ey9FimkcdZ5J/ca1I
         ujIw==
X-Forwarded-Encrypted: i=1; AL+hErGeh2mp3oE8By6Wun1SaUmR85zvul4KmPR+YNejaSkMdQ81WutIwEMXDr5ONr/XEx/tEf8aXTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aPSbFlHKUMWcoUPvGvHYKPvMKrjB8aJ5EVLVmHD/zhpx5MlkZ
	5MOtx1DD5oUHgcg7DyvW0momwjWy8nqpnNLUBX+NkLY2wvV+pSbfyxmw64GUSx+BWzqbFok28jg
	ITFwH5pep7OqbGZhsLWjvkQamWw==
X-Received: from dlbtu1.prod.google.com ([2002:a05:7022:3c01:b0:197:f679:f62d])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7f0f:b0:165:aced:1fde with SMTP id a92af1059eb24-1b5566857c5mr1977449c88.0.1795155473610;
 Thu, 19 Nov 2026 22:17:53 -0800 (PST)
Date: Fri, 20 Nov 2026 06:17:49 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120061750.2973004-1-kaleshsingh@google.com>
Subject: [PATCH] mm: swap: make swap_header badpages a flexible array
From: kaleshsingh@google.com
To: akpm@linux-foundation.org
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, Kees Cook <kees@kernel.org>, stable@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Kalesh Singh <kaleshsingh@google.com>

The swap header declares its list of bad pages as a one-element array,
even though the list can fill the rest of the header page. Since the
kernel is built with -fstrict-flex-arrays=3, the compiler takes that
size literally, so with UBSAN bounds checking, swapon() of a swap area
with two or more bad pages reports an out-of-bounds access:

  UBSAN: array-index-out-of-bounds in mm/swapfile.c:3674:26
  index 1 is out of range for type '__u32[1]' (aka 'unsigned int[1]')

Kernels that trap on UBSAN reports and panic on oops, such as Android
GKI kernels, crash instead.

Declare the list as a flexible array. The layout of the swap header
does not change.

Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org # 6.6.y, 6.12.y, 6.18.y
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 include/linux/swap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4f686709d71f..a3a98dc474c3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -129,7 +129,7 @@ union swap_header {
 		unsigned char	sws_uuid[16];
 		unsigned char	sws_volume[16];
 		__u32		padding[117];
-		__u32		badpages[1];
+		__u32		badpages[];
 	} info;
 };
 

base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
-- 
2.56.1.750.gf70dc682cf-goog

