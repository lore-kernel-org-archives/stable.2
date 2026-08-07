Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959623EAA0
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110356; cv=none; b=tc8qNTUlNTPTzUCKqiAsdw6IcbTY7VBCbZD8RWm+MyTFcmXctjJ+2bhjX9YRsXlBxNdpXAneJvlqImP5frNgQkXgnxXTuFdXSNP9CiT1jG62V4nE7EdRQxijx+WqIa58jLBOWCbDG/BPT0rfcXk3b7YVzyRbQQinoCNuOBN8ssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110356; c=relaxed/simple;
	bh=Wofetp5Z3P4R5mpun6SHZso3XMYSZwee2HG1xFyV7Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dAzAkCknhRaov9EDqOmbRmLOS0h4wWRT/Kv3qfTLaquzitput11hmJ6uVtbF512z69MMzq+XXxIA24/pcpm3d9NYt86V7z+3G+9l1B6/Is6Zqw5B5Cno94+Ls/EoMHUeZ135D3t0gBulYZUUdeM1N5oDfMCny8uHBSjjDCskjIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=uOCa7ZdF; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="uOCa7ZdF"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b01b862525so966534eaf.2
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 06:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110348; x=1786715148;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NYHzpticqacgoFvvmKPg0LdzFqxuqRmFxl8tGbCVxoQ=;
        b=hZ7YSX3toTJ0L7Yge0zxCzpdNZ2c5PQnlaxtXoxttsyZ9QK5mnV8sfSIaB4y5cIwPN
         0hkccRDlf1r3R5ErVtgi/ULjlu+0V4AVb9eueOfEnb0Iq0UCW80GyIqg7KcMhYOUJVS2
         oe3Wyw73vEkpDAdRDhHow/AZgzegtnlrPcyFZgwrdlp2Yd9n5yFAFCgQuP5k04Mj4QAb
         165zbAwKf3A1tOuzswayGP1T6RsIX8r3B3WaApdAPnUqf0RFZgn88Wnf8cU6nvzudHMy
         k21yD2dMCdqr1bd6+ZZ960w14sVW80o2uQvEZ2xTdpfdTQkxsHjwNiTezc7Y8bd+Q6OR
         QxCg==
X-Forwarded-Encrypted: i=1; AHgh+RpGGmpjgloyDBFqNDTKZXDUUFNyRBWKAEPGnUsvEbslIMT9oTsKSPIe5XGSbboCqkNWNpWwPZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyILMVPJRiTcY1vRtSPipakgibef0LUORIogeOxs1pz7KHdWuz7
	rnCLtdRSo8EUkuaXEqq/WmaUFuYwN5NqSvrF1n2wq8toaYTW6WAs5bOR
X-Gm-Gg: AR+sD13EzP+qm41gzRyTgVdMHDoLZ2fNlobQbcL3oYCkNp1AlPydy6dJuP2XAqc7ZqZ
	kCo5ASkcSIINO2lhocI22/RxK38m73ykXaUVm99N9tbs4rLwyYAi6YULzw0xkqg0hP7zoUHaT1s
	nFWCvVxMIpTVrLYxztBu5hcRjDMVguP8XeiwBg+FdoARWN0f2FzoFfilMK7OzzEUVG7dSMb8oUF
	Tx5o8AgX0B3vUMs7h99eNysKUe3c7H4l4LMAV3JNB7V2b4D1mYSaMOQEx7LK3pjPYr4RTSMIyJZ
	afWUgV1gtCK6TobDlBe9XcBGeVpdmaRkdk/oDStQjqxHr8BrSi+OcljHQvqK8VQmd3FUHnc+sC/
	slLRMphYaFGeQz+YOqtnmvUVBQVoobqGYjTlfk2akHGhX6bmeINnbLJKOxlreNHoAYJw9i+uWex
	E+Ggea4JfxIaUUbIS+uXY2a466kKbOU4tBFetTcN8G3OF4H5DcjxgCHD7RNAl+I2q0aMjvsj1Gh
	BFr0KcUIAXQ+F2yLVw/M4zuCwnceIs6JexeX4+8oW6pVEpdPj6ieeiQM7fVn5PpJvE=
X-Received: by 2002:a05:6820:625:b0:6a3:7af2:90ef with SMTP id 006d021491bc7-6b03505ccebmr1978913eaf.6.1786110347530;
        Fri, 07 Aug 2026 06:45:47 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm2333477eaf.11.2026.08.07.06.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:45:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 165D060A63;
	Fri,  7 Aug 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786110344;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=NYHzpticqacgoFvvmKPg0LdzFqxuqRmFxl8tGbCVxoQ=;
	b=uOCa7ZdFZyOvwZGap1qpbPMuVcmmLLPoNrMffIIb0u6nv1YTNAfvJTCpuDyNAd18HpZ+UW
	vv78CXtGT6PwjyoBDQFyNpy+Cjk0BRGDlyGnfCINvcrG6TlVg+zBu3n3k/dljeP0HKo6Bt
	CVHGspSRtubnmNexUly8pgJyr9O/Sq3s5FO7Hb6yB6aAv+eNEaK1nWBNH/VDS4zEu1iTUd
	eYqQJrDN4VKATmQMjTmXDf//n4EKE+ma+aVCbARDazZnft/XrBqSJrz0vtUEMTPS00lHyA
	0YGriyzAihC4SUYHixgc8u7pygJhmkmm/gJPi5DkLf1PiLrd40vJdM8cXZOWaA==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Date: Fri, 07 Aug 2026 10:45:27 -0300
Subject: [PATCH] selftests/bpf: Fail unbound UDP on sockmap update
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260807-selftests-bpf-sockmap-v1-1-8c4936fa03cd@marliere.net>
X-B4-Tracking: v=1; b=H4sIAHbhdWoC/yWMQQ6CMBBFr0Jm7SSlIQJexbjolKlUsTSdYkwId
 7fV5fv57+0gnDwLXJodEr+9+DUUaE8N2NmEO6OfCoNW+qwG1aPw4jJLFqToUFb7fJmI/dBOpEf
 bubGD4sbEzn9+3evtz7LRg22usfogI4yUTLBznSQbWhiO4wshFRNtkgAAAA==
X-Change-ID: 20260807-selftests-bpf-sockmap-781db29c4f94
To: Shuah Khan <shuah@kernel.org>, sashal@kernel.org, 
 gregkh@linuxfoundation.org, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1786110339; l=2195;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=k0iKUTHaUwJH+lfQYJ0uFk2Hw3GHTUfbUqkLQYeb3Xc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLapkuTD1Pc2A9FxSADnN+MRQOVf6Y2X2KjShkDjUiDef/GSlF7Dxthz9YVZ2GWhKNqY1uiG9U5
 6dfX4A+U/lwU=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 203b06932777b9ad5085319389dea566f5c2ca63 ]

sockmap now rejects unbound UDP sockets. Adjust test_maps. While at it,
check socket()'s return value.

This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
test_maps now that sockmap supports UDP").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20260707-sockmap-lookup-udp-leak-v4-4-f878346f27ab@rbox.co
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
Hi, backporting commit 66efd3368ae1 ("bpf, sockmap: Reject unhashed UDP
sockets on sockmap update") without this one broke the selftest in openSUSE
CI:

https://openqa.opensuse.org/tests/6147940/logfile?filename=test_maps.tap.txt
---
 tools/testing/selftests/bpf/test_maps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index ccc5acd55ff9..d194b44ff8be 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -748,16 +748,15 @@ static void test_sockmap(unsigned int tasks, void *data)
 		goto out_sockmap;
 	}
 
-	/* Test update with unsupported UDP socket */
+	/* Test update with unsupported unbound UDP socket */
 	udp = socket(AF_INET, SOCK_DGRAM, 0);
-	i = 0;
-	err = bpf_map_update_elem(fd, &i, &udp, BPF_ANY);
-	if (err) {
-		printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
-		       i, udp);
+	CHECK(udp < 0, "socket(AF_INET, SOCK_DGRAM)", "errno:%d\n", errno);
+	err = bpf_map_update_elem(fd, &(int){0}, &udp, BPF_ANY);
+	close(udp);
+	if (!err) {
+		printf("Unexpectedly succeeded unbound UDP update '0:%i'\n", udp);
 		goto out_sockmap;
 	}
-	close(udp);
 
 	/* Test update without programs */
 	for (i = 0; i < 6; i++) {

---
base-commit: 74b69060ba6e44e20c2e4dc1847eca21db6e4a7c
change-id: 20260807-selftests-bpf-sockmap-781db29c4f94

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

