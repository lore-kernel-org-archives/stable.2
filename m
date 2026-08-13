Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E73C8C5E
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658428; cv=none; b=PjCaGo6cFEUFOSEyq92eiAzXDPLYqybeKHfeIfmB5a6Mxq76mgTBmdOWbFaKhv0K/u8HhW+n5GQcuh3vc1b9pGj5z3Y0xv2Z31e1FRkE3HCwpiS/hntMWsFCVfu4RD7jf5h1ed91ivSYO17axgFqTjDnauuIbw25h5s7O/9xeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658428; c=relaxed/simple;
	bh=RMeGTOEbM8dieI8j+EDh5WMW8HN23IZPs2MVxpaGdhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kPfqrFPdODPUqSdbqAUqKYh29SkYSeOL10J+Mkhwh/VIzV2xCudZqmEZ5T6433nQLffeoGwRTUlYr3bKbmO68bKHRgjkD6fmVfFXRAmm97ZDvmCIaULExlqfo71liEFd/Yh4m6+WVp1COAem7ieW9RiMM/05j6juda09l8OhKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=dwBQc+xE; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="dwBQc+xE"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4960fb63c75so193512b6e.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658426; x=1787263226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPDr3ZJlS5GTxsyqliUMtwR1qFNPfxJRKflCt05bQVg=;
        b=YiT/w3SAJu0Tc1l86ypzYkcQew63ioetYhm2w5ubI6ZLGwCny/1HA8jaW7fH8j2qou
         k2RY1CO/FBJQtvMqLUtOzJsdhdvbNkZaOuQDQMxelD785FUxpaQjmNgqjQUbmMlw+ibx
         l9E7DeDEppoR7kckvZNgn1ioAF2rIVIknZCIfc86bQl5LVnRm2fNRYzVYDuiDjNInlCb
         9UKeccU36V/JjlrTCvMw/oq081D1L2YKVadpUsmQh8OPZSRhIUV42bIhZhOE+1pSkv2m
         qPNdt9eO2ZG6DkDFS72nwMEVheWQaU8hlEwagGiKW93btswp26fY6HpC+fizjZ+TEzwx
         FopQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUvTexDGjH2XJRRLemo+UqbnvHPhcsuBxhj4FnyU7IezwZXpRazUujaK5Z7TLsX8268tKxtyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzflWN/FTigPx/MoFNd+4EfHH7QsesiPe6C1X1xDoR8MC/In/kL
	nVgavesOn8qCZEe2jGS6GtTI8yPJ79zr5R4pKb4xFZoBP6uRIMFHdVQt
X-Gm-Gg: AR+sD13Im/sfqz1mZJdSDPxpN1NmYb9zMmznKZFHnpVId/f2uo0lFoEnxnn3DR7gZp7
	BhP3zbq/M+KGmlCflWQAYJlElGIMdXW4e4uwLcQK82AK630/UfDMRPcUzzhwJF034DJmWTx7fvx
	IxrFbH2iCI5RNwYh1hwDA/nQnc06hMbH85lSvTOnspqDUlOKZ51xDvEsR26YyBZ/Uhy3cm2Ll/w
	vx3GuNMFbIIeUa/c/laDWUW0mgFJV9gxL7+qq7pvTi7oxGj+7Hzuo96Ncsw75OzvAiZoHDffjbO
	h6kWTwgp06x8cBmY/oBRXOOXPfKKchZUX7VH9KqjbDDFtM0IQXsEhsIL33wrc3xtIVcQP1tlPJG
	1HlRuZLM8/BB/I5hYMrFb5EOhiJkZ1hrJuGF953W0akYjCSeL8alK50UJJfYi7Oz5+Z2MT/+bTP
	OsP0kYxpBK/E/DgOleJJ/vEXo5DKOW6ZG+LzdUSukl9Wh0rzGJsKyYS0GDOAR4LFy+hxV51Bww2
	DQx4UjgjA92Vw6w/FCdWfJN8BBVnif28TsMOTfG7TRRTTIqqlxwCtvBd9rwrd9M+g==
X-Received: by 2002:a05:6808:6808:b0:4a0:cf55:3cf0 with SMTP id 5614622812f47-4b24152d08fmr1116474b6e.9.1786658425531;
        Thu, 13 Aug 2026 15:00:25 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22cfb1ea5sm2686341b6e.16.2026.08.13.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:00:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D0C960B53;
	Thu, 13 Aug 2026 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786658424;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cPDr3ZJlS5GTxsyqliUMtwR1qFNPfxJRKflCt05bQVg=;
	b=dwBQc+xEEO8Lem0UqHc7a+xb1HKh8t1Mon7PDhApH2sdDGzQNN5EesIsU0WgzfFujf1Nky
	pnx5hVPZHEZgrrs3N7GJSbbA7gU75kXjCI7xUMVfauJS00bXrzQgG7dePjwTMzCIaTj7bp
	2dkv7FWVj4R1UTzaqB/4lPAaFWQHSvclGoYwwO+Vzuv97FnFjowZe0RL3ID4zePydq+yW1
	se69TfHUF7ruxldEqvJ+Sq6GhY7Lt+qXvNRUxLV7ByPMx2F+B40VpvIfOt9RiMvBE+ah0o
	mrIctsR13Ahd8VURzv8kx6L80B09idparmt53RzLXnz1yFlpl7oKDLQuisAJWA==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Thu, 13 Aug 2026 19:00:04 -0300
Subject: [PATCH 7.1.y 3/4] selftests/bpf: Ensure UDP sockets are bound
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-3-cd5c51e7dcec@marliere.net>
References: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net>
In-Reply-To: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1786658405; l=1781;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=e5SB35u/vSYta099gqNsW1ZXfGRvMi7KbdZiL0YQZvQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEyquNT6uZ2Fxa6C+zrowcs8rlT1fTP/cvbiH4TBJWGkEO3xPD/RHonB8/fso6lAWNK61MWpzww
 2AlGkAzKf/A8=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 65f46946e951373275d793b35129a7c3ebeaaf51 ]

Update sockmap_basic tests to bind sockets before they are used. This
accommodates the recent change in sockmap that rejects unbound UDP sockets.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20260707-sockmap-lookup-udp-leak-v4-1-f878346f27ab@rbox.co
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index d2846579285f..b4019d1a5575 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -807,7 +807,7 @@ static void test_sockmap_many_socket(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);
@@ -876,7 +876,7 @@ static void test_sockmap_many_maps(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);
@@ -947,7 +947,7 @@ static void test_sockmap_same_sock(void)
 		return;
 	}
 
-	udp = xsocket(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+	udp = socket_loopback(AF_INET, SOCK_DGRAM | SOCK_NONBLOCK);
 	if (udp < 0) {
 		close(dgram);
 		close(tcp);

-- 
2.55.0

