Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B55F419305
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786798267; cv=none; b=N4G75zkzrOEOHwMJoZPPfBqJ4GGIHhAFITH0Bg7ghDaozw4oxgRPJJjBSVNjN1n4vRysIV2Fbkp3/Gupo1lyI1cN/+kbVmfbtXCsEQ+KXhDrZpSA8f/eXzdqrqzorXCgNikfEJIUfMWQBsa0KhR5vGIpX1s9nHo/g0iPbEhK7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786798267; c=relaxed/simple;
	bh=KE6rTX+Q3muQog0MKP2PpDD8qW91yzaqv4URNi2blZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VP04+H8Jf8X1ZEE/C7PO/+LOggzrkN0ju47S/JQkdeyG9h9rNJd+bngz2IoRF54w8CaBwwZky0/dLWcOt0zeumWHf5U+x2eAr8wiSz+RsrzQHJZwf6fD8siHHgMcy+HbY7yScJgJ6xN9S5qOGNe8aG7dEvs5Kma18DepPdJTN/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=CPk3YldL; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="CPk3YldL"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-44856d185bcso1178515fac.3
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786798265; x=1787403065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NthXw1cvoONdGhBW0OtOd2XcLhJSsunw8nyGgyUAdh4=;
        b=mRuZNRmM3saRuLcvIQAfOiVjY8MUXbStfjReU6oGu3Rbb0oKMrZBiE89y7V8CtUr5J
         B8XpdFpKzw//27ve/dTbcNWna0AZqQnkZIChPIcCWmSM7jHDcbhBVzT7UYqqmfF4glQn
         q6MXk5hlhsT9e5t64W6kNxpy7RftUndjFaS9fD4rDbBt+uU2ViSTabFdPm8vUYlP2GkD
         uEYGbGWdyyjLOnQpa0cswTtSWW7wK4ymk2+7M8kkxqbmgM0vC0HxTE/gT+yxT/SOaRM9
         G4cD12u8+O48YGYS8kZa4elrBOQD7ItktP2s80bHFRdM08/oRR6G6KT301Vwn/hA9cy4
         q/rA==
X-Forwarded-Encrypted: i=1; AHgh+RpVppAImmumq1ptINOCBHjce4HIi9I4U5oPZTeLbENgG8UudKid4cfeYMEctriLBPdLSXr0Nn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgC0xzScQoqm3Am0YFG/iiekWvn8RZxDmy3KSinmifK6GL4iRM
	F1WV46k86AsoNjccyCWkz0ANuvzYVcadTJRJcxas6kolQG+5m453s0K6
X-Gm-Gg: AR+sD10t/ucDvZlACPRjM68Q4gcDBdfXiP6EQsFXz7g/tJqThTdzY5bZ0Ez3AfssWky
	dB79+OjDvbmVDwHbFXjOuXBtpLJ2bc7FkHr8FVtTMb9O7xD8dSaNlY6zSpDcDEzePRYkzeDKEW1
	fr/TMykNnJckX9HN0gfw66RDOQN5mcYrwbBqutylz8LbH8mnoCBmtSuS/xBwo0O9P81sepb4wG/
	xcZgXDGiCP+JIMu0qNwg0Iopjf+WMcIufJJuF85J3uuamVibiN2S4GCAVWgerTc17ORZSubwLrs
	CUyGetAVtTvYM4g5iH9OjM9V8jpzW6VbuuLm9/Oqf/5H1vZY7PajIC/3ke/JRqtywk0rdw7FDm8
	KVz7dST9uMIILOAcBKMs1yqfpfOhWIUf7wRfGZZwSPZeKPDEA2QKpPV0Rxffkl/5+qhow6tmpme
	W6YAvz6gdER30qUe8OQ1oY4Zq2BhSDWvbOI/OPSUlxVH4dHbY+Ar0YLISuU30n5mqyD6LSHctw6
	ryjSaDGsb5pkFaKfxEHZQAwoxtYYJnD/BmUzxpcWKFtzit93bxsvvhJft32pcfkMA==
X-Received: by 2002:a05:6820:180d:b0:6aa:e13e:ba26 with SMTP id 006d021491bc7-6b0d69164demr10829049eaf.33.1786798265135;
        Sat, 15 Aug 2026 05:51:05 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e86687f3sm3931954a34.20.2026.08.15.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 05:51:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C2C260791;
	Sat, 15 Aug 2026 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786798262;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NthXw1cvoONdGhBW0OtOd2XcLhJSsunw8nyGgyUAdh4=;
	b=CPk3YldL3RCgL5TmZcIvdBAwuyKz8SYYzju39akKENUry5zZ7k1ivcAmuKnI7IK1nUOome
	1RrKkvfZI9E08gkrsCLUh7Oj20i32cAeHPO4BMi3D83wuPopTUHmlyC9Hc2ruavOlPkOiL
	HW+JHbzose8CNEQvOQzVqXHsA8dtzFhDsmMrI6MChSImD+eModkJrL7r6kh6FKLqMH8bbC
	jmbF0GiMKhiN/wfNs1ZtiUMA/lE2Tw2INWEQQbaiM4atQRrgwDZyS8r7u2VaoA8GO2T1AG
	9CSLuwlOw0yZqeeGlc0ddpPbuokPCvh/Z2zj8nawTg6Ct0czLp2ITsSAjmCAHQ==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Sat, 15 Aug 2026 09:50:39 -0300
Subject: [PATCH 7.1.y v2 2/2] selftests/bpf: Adapt sockmap update error
 handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260815-7-1-y-selftests-bpf-udp_xsk-v2-2-c227473a2300@marliere.net>
References: <20260815-7-1-y-selftests-bpf-udp_xsk-v2-0-c227473a2300@marliere.net>
In-Reply-To: <20260815-7-1-y-selftests-bpf-udp_xsk-v2-0-c227473a2300@marliere.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, sashal@kernel.org, 
 gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>, 
 Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1786798251; l=2951;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=qQmp8P1bskQy6/17jPUYc2um6TvqJkCSlm4/2Y/x6W8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QERbhI0Fsl3IfrWm5pNmGJzkJDRonKGSrxyDcGmHsumgKH5Lxmyeub9wr38+IX7z0Gs5KWnqKOV
 SAB/i3ERjMg0=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 30581eda4a07ff15db623612cac578e81869e96f ]

Update sockmap_listen to accommodate the recent change in sockmap that
rejects unbound UDP sockets.

TCP: Reject unbound and bound (unless established or listening).
UDP: Accept only bound sockets.

While at it, migrate to ASSERT_* and enforce reverse xmas tree.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20260707-sockmap-lookup-udp-leak-v4-3-f878346f27ab@rbox.co
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
 .../selftests/bpf/prog_tests/sockmap_listen.c       | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index cc0c68bab907..1c96a3cf4b97 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -53,8 +53,8 @@ static void test_insert_opened(struct test_sockmap_listen *skel __always_unused,
 			       int family, int sotype, int mapfd)
 {
 	u32 key = 0;
-	u64 value;
 	int err, s;
+	u64 value;
 
 	s = xsocket(family, sotype, 0);
 	if (s == -1)
@@ -63,11 +63,8 @@ static void test_insert_opened(struct test_sockmap_listen *skel __always_unused,
 	errno = 0;
 	value = s;
 	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
-	if (sotype == SOCK_STREAM) {
-		if (!err || errno != EOPNOTSUPP)
-			FAIL_ERRNO("map_update: expected EOPNOTSUPP");
-	} else if (err)
-		FAIL_ERRNO("map_update: expected success");
+	ASSERT_ERR(err, "map_update");
+	ASSERT_EQ(errno, EOPNOTSUPP, "errno");
 	xclose(s);
 }
 
@@ -77,8 +74,8 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
 	struct sockaddr_storage addr;
 	socklen_t len = 0;
 	u32 key = 0;
-	u64 value;
 	int err, s;
+	u64 value;
 
 	init_addr_loopback(family, &addr, &len);
 
@@ -93,8 +90,12 @@ static void test_insert_bound(struct test_sockmap_listen *skel __always_unused,
 	errno = 0;
 	value = s;
 	err = bpf_map_update_elem(mapfd, &key, &value, BPF_NOEXIST);
-	if (!err || errno != EOPNOTSUPP)
-		FAIL_ERRNO("map_update: expected EOPNOTSUPP");
+	if (sotype == SOCK_STREAM) {
+		ASSERT_ERR(err, "map_update");
+		ASSERT_EQ(errno, EOPNOTSUPP, "errno");
+	} else {
+		ASSERT_OK(err, "map_update");
+	}
 close:
 	xclose(s);
 }
@@ -1289,7 +1290,7 @@ static void test_ops(struct test_sockmap_listen *skel, struct bpf_map *map,
 		/* insert */
 		TEST(test_insert_invalid),
 		TEST(test_insert_opened),
-		TEST(test_insert_bound, SOCK_STREAM),
+		TEST(test_insert_bound),
 		TEST(test_insert),
 		/* delete */
 		TEST(test_delete_after_insert),

-- 
2.55.0

