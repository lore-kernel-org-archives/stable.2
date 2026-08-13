Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0064361976
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658422; cv=none; b=M3fn3wWa/Wk2rN59eYmKSIjodxyAPOhXKXj6WQlLbKHrScV9lL8EmKblijWYG2qBYIHKVDlHR46YbSM9KMc2oMuhOE3HVEDHG6qqfgaZM+UNjWEfkUe2xL8GLnuAjPF543otoCeyWFd7+IrnFiQYkCoqxW+8rqJVhhf6rCtWbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658422; c=relaxed/simple;
	bh=9/sQZpI1gQNflmGl2+wtCghsABNs0cTgc4HTGo/59bA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fVsXwQJOLjc4rbDrcLE28DwfEOSs8e2ll+j3u/McyaeKPc+Eg+r/8+5cYH//Rp02hxbCaR5+SYdf/TInOFA8iYGTin6dqT8JOQ+GH01QdHash8wFsIi+ejCwhWpNo4wlGwYfqkQgQjok6vpsbae9opF28cjU2ZkfugEHZFODSo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=JpdbzHlc; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="JpdbzHlc"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448cf99c133so1292744fac.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658418; x=1787263218;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZLDjUMvBFdgbs8ZTJktZdHjUGj8/OSXLCcY4tmjsIM=;
        b=Xm82D8C2ljACWPx5RotnY13OHiCqIklhyPklsIft645IzGBP8UNfTpvCZAaot/c/fv
         bwveEB4gGcTUJgbY+sAfDP2Y5sMGIYKcd1raLTEeGfQ/iuDMTqrcDYwYZfUCbGtFt7/2
         QQXw8+Y31pPAUAgJhv/xKGsFuyds02mw85cTmRatzEj33Y65e5IwcRgjkA6nKmFGbNCr
         nYSpIk7vif4RxCvTMJ8SEEuCMdqsklSjIIHmvZbmyLej/OrTjJuclJyysz1mjwaks3X6
         3E7os61Q1bHIOOzXMZxoPjzjQGgosjtHUmLDrbkO7lPOenOUTkXasuALzmmjKsKdNknB
         nSnw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/Cix61ago6Si37A02OdnkbK3YsFPCXcTFCni1MBRqINLhb73UamqxIwy5QnioHHbgl0GBoDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdN//RLmQFWsSo9PUf7XyaLQQpk+ZI4ebzmS0ldeDfjIA0t/a
	7a4s8TzSqSUzgOu1S4lcqwf2ypsTjRf0k/LJwwArvg0tm6PkRODFZ9nY
X-Gm-Gg: AR+sD12FVQliFBP/sCd39fOTGWar9rxWr7kfaVZBg1pq+QsJXgcWbELlyNmzf+NRLYE
	YDILPOlWDu+r6MN6L9e4WLDnU8GL0YLjziMhw5Ubx9EGeMsVwv40VCCTgulpw3cw0WwMfn+swXB
	xT122l5HWjO8kaX4d86WATAD7YCM68cQ6DmUaQ8ENF7/GUjEOKcWZvlqTIpXtC8Pf5JcqoN71eU
	oJ+6yxKk9TBIvifXE0Z/uSLFv5S33FfXGu+pqhmSw+72QbYW3uAZS4rK4MhMqBYhW1pJ84OrsEQ
	snosN39ZoHXen1yZN0CLbJKDP1ToSNjXUCpirIK0BpBHeGCKbBSsIV2r6guV2xrb0qx6Hh3/p0G
	As4XM0Nv7ewoxY5SRWaA+319bywItosCHItqygb9rNU/tCP/gt8EnqXg5lxEyI8XetizILbk2/R
	9ZVkWYdOPGwPRsO6FQMdtTmIqZnzXKUtEKowkQBE4fr3mfjym0JLWan7CMy1iAr2+sCMK9uswwn
	qG9grsQYw2ObdzvHMlkTykgP34eQhioTDUvjgkyDlKv8OqioYFdMGv+opnx87OvwQ==
X-Received: by 2002:a05:6870:8a0f:b0:424:801:49fe with SMTP id 586e51a60fabf-45e91f35ed3mr729847fac.8.1786658418555;
        Thu, 13 Aug 2026 15:00:18 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e8f8f23acsm761611fac.2.2026.08.13.15.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:00:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD26360CF1;
	Thu, 13 Aug 2026 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1786658414;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=WZLDjUMvBFdgbs8ZTJktZdHjUGj8/OSXLCcY4tmjsIM=;
	b=JpdbzHlcKwbLkHojBUzzeFmBtNAUjIxJO8KauGl8gUUHNRbijKCR1ZgSqrfSeSVbF0u/GP
	vcttUaAuBwrzNQr5GsWIxKdDfr2HQDxOgQwpiMhXISY8S3xglgUhJ/UYdlDK9/ygPlqedx
	hq5ZbMRN9IJiQRidJKNw2Gjt02mIOr/0/KeX0Eq8sizfkN1ewevaNeZHxibV0VIY3i3x9T
	6Fxfl9JgoBsH5gGpp0aJOuGZCho7BLzy3l8Tvjj6SxGUqFThlMTT0cnngPHH9T6IVNjN7Y
	pvV9wDmkfztlh6bp9Uj72DAHQiC4QeRp0AT9p3kQzqLRpACcsopcG1mrKf7wMw==
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_=28SUSE=29?= <ricardo@marliere.net>
Subject: [PATCH 7.1.y 0/4] selftests: Fixes for BPF
Date: Thu, 13 Aug 2026 19:00:01 -0300
Message-Id: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGE+fmoC/yWMUQ6CMBAFr0L220WKCsSrGGPaskC1KU23GAjh7
 hb5ezN5mRWYgiGGe7ZCoK9hM7oE4pSBHqTrCU2bGMqirIpGXLBGgQsy2S4SR0blO5xa/5r5g8V
 V1424VUKSglTwgToz/+sPqHORL/A8NE/qTTru5f2oJBOqIJ0edsVRKktna9w0YxhtGj0eErbtB
 8H+M1a0AAAA
X-Change-ID: 20260813-7-1-y-selftests-bpf-udp_xsk-04c781561aeb
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
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jason Xing <kerneljasonxing@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1786658405; l=1422;
 i=ricardo@marliere.net; h=from:subject:message-id;
 bh=9/sQZpI1gQNflmGl2+wtCghsABNs0cTgc4HTGo/59bA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPBW41qmmEFf8qVQY8Nn5MQdGg3RdJsb2RcsgWh3OX1bTHQBhNFAoIkVu3V3wTnrAvyqG7UCybE
 wzyZMy+wc8Ag=
X-Developer-Key: i=ricardo@marliere.net; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Please consider merging the following patches, found through openSUSE CI.

[1/4] and [2/4] are for test_xsk.sh:

https://openqa.opensuse.org/tests/6159071/logfile?filename=test_xsk_sh.tap.txt

and also test_progs (subtest ns_xsk_skb):

https://openqa.opensuse.org/tests/6159071/logfile?filename=test_progs.tap.txt#line-3186

[3/4] and [4/4] are for test_progs (subtests sockmap_basic and
sockmap_listen):

https://openqa.opensuse.org/tests/6159071/logfile?filename=test_progs.tap.txt#line-4034
https://openqa.opensuse.org/tests/6159071/logfile?filename=test_progs.tap.txt#line-4212

Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>
---
Maciej Fijalkowski (2):
      selftests/xsk: fix too-many-frags multi-buffer Tx test
      selftests/xsk: account reclaimed invalid Tx descriptors

Michal Luczaj (2):
      selftests/bpf: Ensure UDP sockets are bound
      selftests/bpf: Adapt sockmap update error handling

 .../selftests/bpf/prog_tests/sockmap_basic.c       |  6 +--
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 21 ++++-----
 tools/testing/selftests/bpf/prog_tests/test_xsk.c  | 50 +++++++++++++---------
 3 files changed, 43 insertions(+), 34 deletions(-)
---
base-commit: e2466b32e02a49318b99520c40b397062c65c84c
change-id: 20260813-7-1-y-selftests-bpf-udp_xsk-04c781561aeb

Best regards,
--  
Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

