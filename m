Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073F39E6D4
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392667; cv=none; b=quE/tHy3W/0eNPoSuZw/Acw0oNDYVr05YmTKVrRa/cUjVIpk7C3lWPtCzJ/0FDtUBAUd/YETpYMa010a5iTYTKi1Aj0lJkf6m3fjD07lpQ5UqBcWoqGryu0kIVPS/GnEBjvVErrvUdk1QlYIO9Riqmy7z79BXdpPnu3bDCjWCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392667; c=relaxed/simple;
	bh=egse+XxtkwVMphtjiNpwZsmQaS+mfRtWD/xgsG+WTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Puy2bjBPi7IJ8XtoEtd9cAy+WoDGWLSeDLOw9Zt9UQaQSFVJHbJu4oQjlFx6HzlbE5nCH3m6i2s0h2601o2IeUGKxESslRpLDM3X9DcNOqS/KdWMDeE3Br0ecdG8jdnWTvwk5MSLK7hlbjf21xRPNUjD2IryKO/GJOGmcF6IcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X56ajZpF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X56ajZpF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46019b190b6so507633f8f.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392660; x=1780997460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8hbcVLfhwfBVVN8TSYLuuPAl5pTHwJWuqQyoki3gYM=;
        b=X56ajZpFFE84I3e6qQvnrxBg6x8LNAo57tP7VNHyNfpzeRlIEcizGMPs1L2Igw+TbB
         vqzUSfYS3x8lEkydqz4poqEYEJ/9AIHTMHd2anUESEeh3orquOZnDR5MuIiKSFmp2F4K
         zVguoPPRRht5zVuCPf1cEJFx1QSEDw420g2BuVHaEhACY/Y6oPYcAXY4YiJRFIKVEbwo
         3QPSFWsiZLvld5hqEZDdR6Zg5b8U2S8xLZz6Y1OLeZohqoP3RjX74mEEkiTpIJUZEqnx
         zFd7Zmjhbhs0LAQ2bvqETXjcWHfP2ccOJ9PjlGT7HkURGEIldiGsbWvwlZvIODGygtNx
         kobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392660; x=1780997460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8hbcVLfhwfBVVN8TSYLuuPAl5pTHwJWuqQyoki3gYM=;
        b=rAfX9fRTTI6IVK96KFNnmHT/6Pga33VKoHdItMUq+v+gLiWaermDf8cUQxefp/+BAB
         wA2K4dkDemyFpRpUakpnSYmgphB3g4o58tf++fxCXWiw/XtsO7rkVz10hbm8YHjJpxpM
         EmhAox70CthYqrf3MyKYkUPiYTTOXQQMukAwChAM3rv23TgVCRO9rh8pfjIwJ9H5BjPL
         c8PHXDkU4qCnKftIVc8HV0rRjo4OkD4rsDC8sX4FUuFNGDwi1792ayXPh7SJ3bX8t3JG
         R07M7gbIIbR5JTD1kQXKX46d+nLC55x2ikY2vt94kL7VDv5AGivHR6dSE35F9KvXDBFF
         Symw==
X-Gm-Message-State: AOJu0YzfwHPB3WDMPUjMQWVB63RI+8EIqoxNMfe7Dt71MqpYxi4uP4Px
	+0X828zUNtcensv0xATINNR2RIUOJdFwuRbRyeUG6tXD+P9rr3CpEdfxIpYCjB10
X-Gm-Gg: Acq92OFWOqBvy9sleHJaEZ4kVj8RsZ/oEMcZle/8ljUtu4/L/VrZRO943qGDizSBN78
	3X2ZZtdrMLsxIjvXaaFr6tQirtVmrvKqUFYVkdxiPIkkZvYrAwyggnNKA8BHN6Lr0ueMYjZeb9p
	fwSyxFC1WrPSL0pNM1hR70xWMb5X/76SjxCfIzKrHkhzvL7pZXHUp9ZMsLqX/lGf77V2v0N25+g
	d0A1rwgbuxyjW5jYrcDRIFRQ4uinCQJpA6BTEOwUmnwqj9xCw0mcPWo1y72DvsFF5spNuCPtFzd
	qb4+za8ee7bhr7TAbJAvFSW25zJ88b3U8VJzxx1nAV2jaopFH+GnbVbZmEO6FEAN9aZ6AKCee5e
	48uR/wffW1PdTsbdRLVvELwLthWfnVKp55xkAlQ+rxcfht9ZaDKehI0r4+Fkwqmg6VNunAv0Nv+
	qJZSnnhvGd+Le0p2m/JWMoVIj7vZ+aDbWjO31AZiojemZJOnvw8cotLv6/Wsb0tfwwnfWNmiEfB
	SJ8RpgAQ6SlQ5c57wASdQ0NVwt73kDQueGx4jCoLCCOu1xDuchQw+5PMXF8+Xcfp5c5MGq9fF6Y
	EBrNlguX7ikqIeg0qZbtbOYLNz5Xx38tHCqOK5gkYHggBKMCMf7vLQ==
X-Received: by 2002:a05:600c:c108:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-490a290de68mr239464545e9.2.1780392659836;
        Tue, 02 Jun 2026 02:30:59 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e1410esm56157795e9.1.2026.06.02.02.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:30:59 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:30:57 +0200
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
Subject: [PATCH 6.1.y 10/11] selftests/bpf: Fix ARG_PTR_TO_LONG
 {half-,}uninitialized test
Message-ID: <e579582e2534b51f59617ff0d422a0969851a00a.1780392093.git.paul.chaignon@gmail.com>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit b8e188f023e07a733b47d5865311ade51878fe40 ]

The assumption of 'in privileged mode reads from uninitialized stack locations
are permitted' is not quite correct since the verifier was probing for read
access rather than write access. Both tests need to be annotated as __success
for privileged and unprivileged.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240913191754.13290-6-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Note: The format of logs completely changed since 6.1 so this change
  had to be reapplied to the old test file. This commit needs to be
  backported because it fixes a test broken by commit 32556ce93bc4
  ("bpf: Fix helper writes to read-only maps") from the same patchset. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/verifier/int_ptr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/verifier/int_ptr.c b/tools/testing/selftests/bpf/verifier/int_ptr.c
index 02d9e004260b..8c74cff20903 100644
--- a/tools/testing/selftests/bpf/verifier/int_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/int_ptr.c
@@ -25,9 +25,8 @@
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	},
-	.result = REJECT,
+	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect read from stack R4 off -16+0 size 8",
 },
 {
 	"ARG_PTR_TO_LONG half-uninitialized",
@@ -57,9 +56,6 @@
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	},
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "invalid indirect read from stack R4 off -16+4 size 8",
-	/* in privileged mode reads from uninitialized stack locations are permitted */
 	.result = ACCEPT,
 },
 {
-- 
2.43.0

