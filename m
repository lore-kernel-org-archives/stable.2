Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369457;
	b=03wYQTKlQBZ37lSeIBfRK1FXDBrvhgPXcQlx4O5mmL7DmmomW/zaaQbWbqZBkTQzUPZw
	 rtUq0EhrqeRpqCNPVTEVxLQt/XAflpl+hgt8e2P+5h9MxfjEUhTZIYYB14Jjcg3nCAQNK
	 3MJ+zL/+qarPYXh4GCB0mqVuNzWvDXoV4zTFr859QtLbySzZjWOA33VqzN7Wp56pjuzwh
	 6GLl/s2rC+kyH+FV5OaWYHJ0QGGkQVxxNVG/OLyO/CfTQhm0ETNEQTiFPbn415Rz3tS9A
	 ZxhpvkwNN3UzDnxi/EaNB6KEbzAGvfGVvn+BWGT5/6oVUUBd+uBIt77MQaqWPmq9Fpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SujbbeAcT5VhnTm9P7cyrJPw0Xl22rz2wr2mzBfdmCo=;
	b=PvdGJQUG7G1/QOn0wX8LwlLMxQv0y4iBhY0IV9LtKBUdsIZj74IwCUWBApVBmhWifqAt
	 5jb3f8TB4kXOpBttj9UfwdqXZr43WYv5ouGNCTPQ/4aeC/QcFoKoum5ZACNnosdL647a0
	 A1lTSjru4W5sy3vCy4vytITDvYrEi8+AaZpCZ5M/b94r1SfVNOl4QkC1WR/ShNgEYK7ig
	 WO5MN8PH2kW4OZNLH978eX56MtF9Foulp1xGZZCEDsmX+AbitnwOZW5AaDsdwV/RaZXkp
	 ZOnlprkqsAUja0D4aGwJVvClnsDvFFPpsHyzWaMkFZQJzzN1+ObQvXBUEuyGm3Os2RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SznDU501;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2856D606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SznDU501
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA111F0089F;
	Wed, 11 Nov 2026 03:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369457;
	bh=SujbbeAcT5VhnTm9P7cyrJPw0Xl22rz2wr2mzBfdmCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SznDU501cmm65yRJmW/GuZnIowAMqGmTKW453Ohn5ADe2mebcG5dln135oc/5AQ/e
	 799bjI2vQRqyokRiqvK4CGMnKsOuuhbpOpXvVdgvX/5cXuZ9HcDQFwqKNGbOwKKRdo
	 ZeITtK/zUrzykawAAtyoRnIzFXVhS2nBvv8+kNyCWfX+GLtwZCyp81xdalhKrqZa5T
	 hLxE9G/4Se3TvcRl8TEiER5z5dP4vxM88xzVOHK55KA5mPaTgs/1iswiVEN26CYPrX
	 vtPgEpoMkAIZYsFbFK8sJeR0o2pGOpv4y1R0qBU9/BV2ZqKxIX/nxtEJ2S+3CRpj98
	 jLpQqgoCcDTcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Armaan Sandhu <armaan.sandhu0504@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leizhen Zhang <lzsx618@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] lib/cmdline: fix get_options() count and overflow with large ranges
Date: Tue, 10 Nov 2026 22:57:33 -0500
Message-ID: <20261111035438.1013301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062722-failed-5.10-5d72266218b1@kernel.org>
References: <20261107062722-failed-5.10-5d72266218b1@kernel.org>
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

From: Armaan Sandhu <armaan.sandhu0504@gmail.com>

[ Upstream commit 5d72266218b1c4dd2917f1df2b86f3b0e0a605c9 ]

get_range() stops writing once the array is full, but get_options() still
advances its index by the whole range.  So "1-100" parsed into four ints
reports 99 numbers, and a range like "0-2147483647" wraps the index
negative and writes outside the array.

Stop once a range fills the array, bail out in validation mode before the
count overflows, and saturate the range length in get_range().  Add KUnit
cases; without the fix "0-2147483647" panics the test kernel.

Only root can supply this input, so this is a robustness fix.

[akpm@linux-foundation.org: add additional test case from Leizhen]
Link: https://lore.kernel.org/20261005213945.359905-1-armaan.sandhu0504@gmail.com
Fixes: 22f2e2801799 ("[PATCH] get_options to allow a hypenated range for isolcpus")
Signed-off-by: Armaan Sandhu <armaan.sandhu0504@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Leizhen Zhang <lzsx618@gmail.com>
Reviewed-by: Leizhen Zhang <lzsx618@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted the capacity check to use nints - i without the unavailable validation mode. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/cmdline.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index fbb9981a04a41..aa90d0f8e1f21 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/overflow.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
 
@@ -26,7 +27,9 @@ static int get_range(char **str, int *pint, int n)
 
 	(*str)++;
 	upper_range = simple_strtol((*str), NULL, 0);
-	inc_counter = upper_range - *pint;
+	/* Keep the sign of the result when the difference doesn't fit */
+	if (check_sub_overflow(upper_range, *pint, &inc_counter))
+		inc_counter = upper_range < *pint ? -1 : INT_MAX;
 	for (x = *pint; n && x < upper_range; x++, n--)
 		*pint++ = x;
 	return inc_counter;
@@ -97,6 +100,14 @@ char *get_options(const char *str, int nints, int *ints)
 			range_nums = get_range((char **)&str, ints + i, nints - i);
 			if (range_nums < 0)
 				break;
+			/* The range didn't fit, so the array is full */
+			if (range_nums > nints - i) {
+				i = nints;
+				break;
+			}
+			/* Leave room for the upper number of the range */
+			if (range_nums >= INT_MAX - i)
+				break;
 			/*
 			 * Decrement the result by one to leave out the
 			 * last number in the range.  The next iteration
-- 
2.53.0

