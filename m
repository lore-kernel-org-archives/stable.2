Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA241A508
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786798264; cv=none; b=SaKQUhpk5MszCbO2bzxl/xifyHh9xg8L7dRR3bkjZfBuj7La+e7bewAmKJJyLRDpPfFk1bNkuPznnmefAiJBq+K4ctfBkPuWT+WTm5xXUExMaqxMbruMXnegnJcPX21IjUnTAaZScV+6stPAN1ZskYvuxqf93lqRPmFCshc5v34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786798264; c=relaxed/simple;
	bh=T8L9myqLCbmafmVDMKPx7Vbsuh0v9IopeQ01K1Xli54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QfWxJnmu3uCHwlBsq9iMl0JhprV3uvP9E2R4jV7XNbuZEinPxOb5An5xz7dVJrTMEBPqKPLZG4N0A5qgbvwwt8D6XRGJ5BLtjV/3G4UdAc9qg2C9MHiYHk+QyGFpJ3o+mVkcyJOih/5Vo+ZgK1yfpC3k8CIU/IDqdCesR9wd4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ZjfT4ObY; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ZjfT4ObY"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ec49608332so1164274a34.3
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 05:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786798261; x=1787403061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FgKVBrWkybUlNRGwgMsoJMUl4wNB/sV32q39f/BXyjo=;
        b=s2LfUOTYQ+EH/QhSZulf06IlutLjVBKr9vnZTc0bWzr1wpDB7c+iTHnmyQ3DD9EEHs
         JTNlVYY++DPnYUOz1VVqmKrJ+cC5W7lenkYdXuQ56SsVQQxXCn2rXKgkQKB4Fmj4+tnz
         3/xcT9bzOCcvuNk1C7AgP17UtsJsHAMxlo3Usyj1WBk7EOqN/4AvZgVwuWyx+hCvM/Y3
         zzPKwPBlGe2+FPeDwXnb3gvrD1QcfR2vPRwmAvOP6TBmos+d7M/MU+Yo9RmYEFxPu29V
         YBYRxzbhzeeSwcSlJhevrPXlcD7Q3gAHn6JTAmwzS+Iwr1kQLb6B3yGtQRZ75hRRN1nt
         LRyw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9vD2kGeEFcqhz4Fl87WtM6nyACh6yG264fCXRYrJTCWDsGY5Kw04CzJCTIixSgVY5+alDPVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz293iGVXAiJ1n25tR1TfixmWtmIigVq44vlKiDwgOBRGHGVtew
	VeWD+dNNIRV4/p2T4yAfOVBG56m3dk3BPIZIr6H3f9GBLCK8TxQ2THbP
X-Gm-Gg: AR+sD12YwqYUj5ELtLrNjcsDY6uaECirLSe1rHuaSMrkfCgfaReHnnp5p5d9be71h3+
	Lks0lvqK+Von7gmMt35L0QP+A+bAfXY4yUQARPe5gx2hYMtGBq8O/XdsVMjQSVOLvKY+J5OIWY6
	FUyovtDCBpk4CGkrQLE0XMeq7fcTfKts5Cmzbb738ytSTFt91CH7axiXf/RruE7iMuLsxOoYqWC
	Xb/Ycj8pEhxIP03vtZIoCcIWPaeZCmEEv5Xn6nUAgM2n6QOi0OYtzj0FWqXS87Ur2WbROryLZr9
	vKFG06rXyHThjC/AdxjkbzxHUI0evLsoQfWLcTSsoUr1xqIP38zPQMtMlXm6ScQ99k8XEmeDEmP
	qCHVG/Ggy8BSD/mHr7TEBXhxWgKb51uc2ldYJeeCFXnehLbZPNmz1NNYkfT6kglgdgRmGpbbzJ9
	hIS8iKYKZrD7aLwjb8b66p+hZOpIbgsi+9LyzRYA/uZJu0oWxHXhcG5eM9wyYZbl9K73/O89OZS
	wU1qAy+KMFvBM5s92BOWkKMVXKRURn3kE3Qpi9U5yYRMPUkPxfppFM5Mt4m3E0Alw==
X-Received: by 2002:a05:6830:2106:b0:7e9:d277:6e2e with SMTP id 46e09a7af769-7f3de4dc011mr11851338a34.7.1786798261295;
        Sat, 15 Aug 2026 05:51:01 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e86a2271sm3958392a34.27.2026.08.15.05.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 05:51:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E6D16132E;
	Sat, 15 Aug 2026 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786798259;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FgKVBrWkybUlNRGwgMsoJMUl4wNB/sV32q39f/BXyjo=;
	b=ZjfT4ObYmNSBqzr44xNiYecAh48ZzZ5ZbQWieKjXVGTciQp0McJ/2AHJVbuRdVoXkRJ7ap
	vBX8qNdPHKay4BOORgfLZL4O07Ssc7fBejLS1atNZSJNfaN/oUUy780Eqf1+JGMq7mZizz
	RRUnV0XGqm0r0r+wgoNhiWyWCiIOyJQVgZKAnMxQ9y/sH2yy0zVfQsllHxKtSQ/i5oSsA1
	WCJXT18EvJkiv13JQyVhpuMH8hPf6/1sPpuxtUDBZELJrxdKuONCAk8hr9ZaVStNYUICwQ
	rMnnuwJcued3tzpACqfFmohWJ8y7JTQb9K1eE3Wq4l3S+30wsFsN+dXeAP5xNQ==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Sat, 15 Aug 2026 09:50:38 -0300
Subject: [PATCH 7.1.y v2 1/2] selftests/bpf: Ensure UDP sockets are bound
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260815-7-1-y-selftests-bpf-udp_xsk-v2-1-c227473a2300@marliere.net>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1786798251; l=1781;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=GsJ6X/Uo1KEuhlD2ah/RZhTfW7ZY6s1IuXyLQAeSIF0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNX6cy7X/C9MB+XeNhQOg/LuOOmDrLvOGvRdbh9iN5DlRhSsQzOPkibhcDIG3cu01q2Sdwo47Pm
 knvwGCeYtMgg=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit fe3ff273767ef22fe8a7cb3816f264927c190e50 ]

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

