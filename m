Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2E30F540
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429300; cv=none; b=WIGPbUgb8/L7qrk4YRQNPh4M7lIfUUdOgT7ZghQxuEtln8xnqPeI8uokqVMlfOc1ny92wJ6J362augNrscvguPAwBcdMZoQSWX1vUcyAV/5zvW/IvKvOO6kwryaiHf5AwwHDj7DnYQjMlaTcPVmyPAn+KBWt8gVcVMhNu5qQaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429300; c=relaxed/simple;
	bh=S5exdh8BM0H90H1AQvXrVMGQZdVIhBQ29YJMKHAW4JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsIeglnpOR/meLCPeY110+lQgku/2SAwRAv2BU0dkq9itfW0x6PRoq0Da+PhPEUeYJgjRPPRn8SxhK+aXpamiLgJr3d6miCOBuaDFGWzqUb4d4kJnN/vuMvfNfwjkHT6MkaH5TY/GkrmUHsXQO4MGwyNsYBKxvZ/Myl3CaH506g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPKZbMmr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPKZbMmr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so89762975e9.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429297; x=1781034097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=quilzseUCn8mqoSDrJ9qac3e7WH/JiMoRGU5H57V/E8=;
        b=XPKZbMmrHmiPifHfRTgXK7dSQffb7EiGo0e/zKTeiMkqpzPGdy95m75HpUSx3+dBNG
         IpVPNVuoZ6qBlu+4O7dvGRT48rBxkZ7I2mmu69kuRB5IAnTjO71v/4YSDmI7YhOhFmSw
         1WZUnfcKU/6zTd3LiLk/UWYxBC2Xm5W1g+bbW7BHkWPhKdjU98VuTs/uTNTGeKsSw/Ar
         LF8dwLArnJTxoAIgZNgW3V4hTULaEJU9ReVyncQb5482O/Aawz2h4VS1MQLKT4+83f+k
         yROjTafXnY+egoa4jgXSP87bhBg71yVov/c2yQvg8HRedPoz4taUTTqpEQ6Rifd285Ix
         VnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429297; x=1781034097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quilzseUCn8mqoSDrJ9qac3e7WH/JiMoRGU5H57V/E8=;
        b=KlnnxYUctEG8m5A7jRFydi1+TYN9m2pbVUx80svb2eXz8h/9q3NilBJGvvDE2WGTbr
         IRQnYKOqfx01sxPhyKkxYli7YNMgbQupF9jFe+q00oGgHAvl/tXRspgcfh5gX7FNn/ZJ
         SwtfXtrfsIuCvru8AUeyZ6ctV43mPDjLneJHavosXC3iJgmtdb3wiNX/SPxZh9Enz4Zq
         gpjcVUceYuL+YfUhH0iUdJ3Qx/tMuE3MdZgEqIQxDZ8NqWkx25Vj0+9Qb0xY8SK8dHD5
         33fKmuecmihwZGklgveQQtAHz2+b1LPLYa6LpXMOsLCG+rC6M+iU7RTNCw7sAFI8NhAb
         xFGw==
X-Gm-Message-State: AOJu0YxBitycbNd8LECm/n5D0QPtnmbrbTCJIODi905V6FLnYwJBc+0n
	Z06El5miZUGrP2IaTbQ7lgijfPkf+b4QaeHLqQ3pa+o812f5RNtEhgAMLAbF+sgz
X-Gm-Gg: Acq92OGQw8HtRKY/CpFcN9of2/YSuAJTN9oxLH2iha4NdzzyOcKtJrAa7P3xDuu5812
	vLIUvtMvWAZ4rXYETomzonN3fx7vH152yTfveeYCdbfhEcmXq1iJbx/5ERRZauEJh5xeM5c4zq6
	EQKXWFfyGu3gpm16kQoIRbEIOBebUF8wxTUHmukLgCKU8QzhofjMWrbujRqtA56FdjzfIDrF2Lc
	C1jwJhtztHS3d6uriCnQbpval/3AqXpVkHwsa1JlOvwG+X4BlPyrt2rPnsCqHYUUPyf2IgNTJbi
	nQZvwfDQBKF/IWrw2R/j+JCZDEVSt9DXHg0ICdObkXgsqI9WBO9/etIMPMUBJis60G9j+Br0VMP
	2YCwoKdYE2F4KNKliD1FCIAIkCQv5+aUre8BLSxPkQGdYk/NrZsVutOvTgGb9EIfm1kcwcince+
	loW6awTDoo/BQuOu0T3C8niHcEYqXtuVUlTlOkT18q/ztXqXIIDJo9qtBGC2qibrNez6rsRUUvI
	i4KyhlHQlDMi8wuYAcLUaqxhm6OcKurudmXMZf932Z8tf1fH1rjzpdjhXt/x/7UrKbyoBu1xPyY
	87OyL+BGA7gYTIJbEMkZ1ngiu5cIGlXSv4iSIWkphYFbR83mdf39uw==
X-Received: by 2002:a05:600c:630f:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-490b60e41a8mr2895115e9.32.1780429297174;
        Tue, 02 Jun 2026 12:41:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35f2e6sm1452662f8f.32.2026.06.02.12.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:41:36 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:41:34 +0200
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y v2 08/11] selftests/bpf: enhance align selftest's
 expected log matching
Message-ID: <d3ad8c4ad266f4d0d7eb8583bc67685e9621ca48.1780427227.git.paul.chaignon@gmail.com>
References: <cover.1780427227.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780427227.git.paul.chaignon@gmail.com>

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

