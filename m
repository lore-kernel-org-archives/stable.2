Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B637AA8A
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392652; cv=none; b=BKGnHkVegppyHCNPDAOfwqOaliskTU2D3A110QLdmZKAxrsHXO7Zley1feGYh9cgpaY2tqoc8aILy1pwHK91+ktp3DTTHLbYOBQvDYorm76EMav2U9DLZqaGWjKVa+MJqIKn68DhADoMAX8gLj6EWLeri6tnF9QeSkqsLtUlCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392652; c=relaxed/simple;
	bh=S5exdh8BM0H90H1AQvXrVMGQZdVIhBQ29YJMKHAW4JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePQn1xEVm1rRvR7vc7/3HYVBjwnPmgnXyTe3ei2o24xpit2dJgW50W+36k40PBD2DBtoH2OR9RVCbkgX1qSoYnUizuxFyFYJu1NmrIiO1OpzWSmLE1V12WPJ5CBj90oBp9F04S9fV0/n6GUJvMG3udoY7eOEyskgotLkOnTBM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsOMreo+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsOMreo+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490686877a1so66591285e9.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392643; x=1780997443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=quilzseUCn8mqoSDrJ9qac3e7WH/JiMoRGU5H57V/E8=;
        b=lsOMreo+CTLs9uyLvDegS+7lF0jms+EIMDk5qxZs3RUGcIFaooPCD66xDc3mzFUamw
         Ij7r+1pZyNaQYGPpf3JDH5CLdApfthPjEi4jBknpTcYFAkyuF5myXm3aiKzzrjHgkrQN
         vq6T02yN1chgXgggefQAt4T00jyZkTqkrOli+uoVNXVj9aTytr7fmtih0Kj9Qnd7lwQZ
         4mS0PqYsuU0SZI/n7aRGnscXJJNv631utsOoO8FkLLVJ9g3AFJHhNf4Lfg0AqaPgJSPs
         JOfqqh6L4qMKhsLfYAmR0NkHW7N/X5RvuzFBsZDX9NG0YOx7bMCfvwCAIj5B694nRsEd
         gvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392643; x=1780997443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quilzseUCn8mqoSDrJ9qac3e7WH/JiMoRGU5H57V/E8=;
        b=k+biqV6/Tr9rMTtBc9r3fZMMnU6MYpU08uNjR8lCKBL6wkk4yvR6tUyE37vz6VD/go
         lI/5udcDziZRAQGX81Z9hHeSFqENZaY3aeQkpIlUgMQelY8AQMB+mewDLWye0xfc2iRR
         eBUUiRd6DSULLOmTWevmY7fTwXoLwWd0kANhQ0mWKUbv9wrJBYAVgcMAUcm5qH/QZyNG
         JiCeG6IgbYxLU+XPuf9cs74wvvh/8j8dYTF09k/JQcJz1822AqR+TA1kB8qMFqnJF0Ex
         kBrTiGU/xP55iWmAspgFih2TUtf4HoA9ZOxK91+Of7AyXPVOxS6zLp9OSMTqm/owT19A
         C8/g==
X-Gm-Message-State: AOJu0Ywy2R/Qwe2ANo0txfLki3IlvZsju60y4Ij5v1KUFE48xH/LTN9O
	W+lYwGwgbiuMQKu2vXeyhfJ06SQacAyXcG6rdEw/hNdKYWt1ndXBjnqNn/M+cx5P
X-Gm-Gg: Acq92OHXan/O9agp2CFEaaHwDoe+gcAmYE65eSjdaP+gF4ZLnPoxt3zsFFGR2vXPYNV
	apDSoKERaGQmALoMwd8uZrfEOy/vw9se0Rp9pNamxcX2AJZRt48q3rkL3532+r/i4GK9ZMtvs6j
	QgLOCs8QvxKe2Brgej6Bql4R6tYb/iUVqZLlxs36W8g8KUHp9v8EUWiA4R3sYg2Xs0Wm9cw/Sbd
	ahafnQPa6+yOrtItV18MkIltx/9+vNQMYnbtYZ/E6KNmPfO8dOa4GLuwLf4dwwvEaV/2w8WA4qj
	JeQTFmYxCdd/J+zX94bYJPCi1mMI0rjDNnFhiHC0eHUocHm+9/aHUyU1cKmR/M2dnQ2+A+m7b4X
	7zAzgS8WifoG9oZlA50RrBVyll7dGEKXyjR1/2kF9XShchiKVqbrj+lESJ+OfbIZ5QbTQD8YBaG
	nW95Uws9Q2fePqa0WQ17hQ+b/F1UzPC08Rbd+qQNJxd/XB0XZ2D+EX78nD2cTRpmsmT1jKMCLUd
	izU0E12mwt3s+pvDHk7uLQ+uYzZfJ8jvhfLNlzoobu30U2pGqA1JJi4IY/tvhWwzg1EzRlnNHpX
	VxuQDYPWClP9lZ7oU4mLCbzHTe2CHoArU+5guUeMIBJYBbp/vid8WYiii7WnqB2c
X-Received: by 2002:a05:600d:6447:10b0:490:5000:917 with SMTP id 5b1f17b1804b1-490b0e373acmr35661725e9.1.1780392643498;
        Tue, 02 Jun 2026 02:30:43 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b29f49b8sm25405665e9.15.2026.06.02.02.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:30:42 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:30:41 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y 08/11] selftests/bpf: enhance align selftest's expected
 log matching
Message-ID: <4d2566d3464b0adfc998d1a6622bd192b0e80232.1780392093.git.paul.chaignon@gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780392092.git.paul.chaignon@gmail.com>

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 6f876e75d316a75957f3d43c3a8c2a6fe9bc18b2 ]

Allow to search for expected register state in all the verifier log
output that's related to specified instruction number.

See added comment for an example of possible situation that is happening
due to a simple enhancement done in the next patch, which fixes handling
of env->test_state_freq flag in state checkpointing logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230302235015.2044271-4-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Note: Backport needed to fix the align selftest where some of the
  expected log messages can't be found. This is happening because
  commit 1a8a315f008a ("bpf: Ensure proper register state printing for
  cond jumps") was also backported to 6.1. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/align.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 8baebb41541d..b92770592563 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -660,16 +660,22 @@ static int do_test_single(struct bpf_align_test *test)
 			 * func#0 @0
 			 * 0: R1=ctx(off=0,imm=0) R10=fp0
 			 * 0: (b7) r3 = 2                 ; R3_w=2
+			 *
+			 * Sometimes it's actually two lines below, e.g. when
+			 * searching for "6: R3_w=scalar(umax=255,var_off=(0x0; 0xff))":
+			 *   from 4 to 6: R0_w=pkt(off=8,r=8,imm=0) R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=8,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
+			 *   6: R0_w=pkt(off=8,r=8,imm=0) R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=8,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
+			 *   6: (71) r3 = *(u8 *)(r2 +0)           ; R2_w=pkt(off=0,r=8,imm=0) R3_w=scalar(umax=255,var_off=(0x0; 0xff))
 			 */
-			if (!strstr(line_ptr, m.match)) {
+			while (!strstr(line_ptr, m.match)) {
 				cur_line = -1;
 				line_ptr = strtok(NULL, "\n");
-				sscanf(line_ptr, "%u: ", &cur_line);
+				sscanf(line_ptr ?: "", "%u: ", &cur_line);
+				if (!line_ptr || cur_line != m.line)
+					break;
 			}
-			if (cur_line != m.line || !line_ptr ||
-			    !strstr(line_ptr, m.match)) {
-				printf("Failed to find match %u: %s\n",
-				       m.line, m.match);
+			if (cur_line != m.line || !line_ptr || !strstr(line_ptr, m.match)) {
+				printf("Failed to find match %u: %s\n", m.line, m.match);
 				ret = 1;
 				printf("%s", bpf_vlog);
 				break;
-- 
2.43.0

