Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32A33C187
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429322; cv=none; b=BG1KOd7cCs7oT3SIZ3yEIcgkIpZW7uFCZOZAUoLHdBT2g/9BndO5tk1d42dx+qznSc4so6cZ+B6R7kCj6rX7NQ8I5L6E54XKgf66fkUipGw5Ujq4tu2iDS+WqwOFrVJ4kmPxZVrhDG2FGjKsVqqHOeeV0MWnwMm1xRXytoNccow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429322; c=relaxed/simple;
	bh=egse+XxtkwVMphtjiNpwZsmQaS+mfRtWD/xgsG+WTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDTu8DLyIJ8k0EbEeC5Cc5SqVDF64zcIN5+eKiZ4mAkfLMvCs0W6P4o5vq0Nri3ir2ztfqnYZ/5cXtjzObVFMowDDFCyr4syM2kC7+wskKqQNnr7eQtdSDGfdDpVQcpU8dzO9/kDwPMPDeP3bGp2sCYIeTAmhLNOUgI+6pjCWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1fUyaLB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1fUyaLB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso107185175e9.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429318; x=1781034118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8hbcVLfhwfBVVN8TSYLuuPAl5pTHwJWuqQyoki3gYM=;
        b=K1fUyaLB8o6ts2oEy88yfL4Lt2dxiDkW/FazsYmiZDNEWNjkrDCfYEu4keOt21qQtv
         NfO9zKeeSdMZNbYwOY05bVJqxNEmjjOfALVFuFneCevS1oa2djW4fN1orCGsOQOqAi29
         YK/1H5qP4Sr9Ep91ppYpXS4VtA5zEmSMZfk53z+Mp2ptPwzkoMq69htnDGw5wojgBKSt
         GgA1ZhX5RBL4Sr95cBS8skfuEDMtYmkWhgvGR98h0zx465h8MheMYe4nCH2EWlEFrTWu
         OPg/L3JYtSENkarqpLrLEmuZXLfjAySzywCTp/oUKMTzDqzJnWzJrHQ3jxFyt5Y/qec4
         FwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429318; x=1781034118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8hbcVLfhwfBVVN8TSYLuuPAl5pTHwJWuqQyoki3gYM=;
        b=oNCDMXCq76p5NphdFovpuLhxORP55IfZ8z08hvASN5HXUee3RvT0+ut8mhM7sYqP8o
         PFCr2RIE+rV2AzIdUbp11JaMr0RVx1bgXFiQ8V45iR3mQOcDWeEbgBiB7LwUk24eyDoO
         UcbxGBYKIrd6oyK4/XI9yY6GwGbSPbDKa5Ln8+2l9cQjGaCA/gZcPvB9pbmX4sIkd1br
         5wDqeOrC7tizqMlXyBxUavPBLskzEuWgoF647NJtXkUrixUoRel19myavy+C+AHi97P2
         +fz3NGw6/8Hej2Nwtuti1CvalLRygN+UFWJ56ry8jbymxPO9Q2xKRpbYGX+SWV4lgMet
         1/FA==
X-Gm-Message-State: AOJu0YxklyDBfaBfSUY6b4OxYiIVHl7OdT/EAOnAeEE0hWvXXgnt6H51
	cguo5oNqcYhp8Z0xlXwOAFwrbSFDiIxglhr2VixcYLlmo/iUBCeszYu2qxRGwSn8
X-Gm-Gg: Acq92OGw108OBoyQ6PAneGimhHA8pd7UCsfy0s3JFQF4sMU35QIe6DVYat4CE9N/j+K
	e/yGyUWao6bB3+3laVA5lyGaonyWTg5Euaz+SPMbTJrEVOHWUM99lpqvxFNvlMnvawghROTyCTx
	IR1G738ooTY3+cL4onK9UPXApgokYcAAPatLi8iKoLWan5hYEhV9ct8iYObVQ3FdG/Xp0fj/e4p
	FrN3cfVl4DgrhYOUIh499zKVhFVH1ZZAlQG4UF9OKKmm/3FoCeOOSAuO1GryhqVNFLt/W4eqndI
	gP0WlTjJ+rsYOTkj+ACABf0zm5ZYEZguEVI+VgZbDp0uvBM3jrx+OqWeMIwTj2X/6VP0K/y3u/+
	Tpn8aCGrr0rlIZ3/BIVhvPkLT934TzrsQH2glVbMSOIdDFd+tYp6AOZ1uosgpMCHPYS2BDJptXh
	M5EOunjLu4SFvgCSTUgGCgRYWC7JCvISSoZKCnO1YyBvHwMIxirLXoTiD27Pr07yJSOI0m6h3Sj
	1WercRtjJittf0hLg/ORyaHZMMnjlPkYujzE5prraSa5Hoov7O5S4QMPShJFs4P06s/j7Pp4k6s
	HkBUYsdQp4EqixGL+QOe0Cldmko2jHWTKU/eMNJ+nox7sNHfeVrU2A==
X-Received: by 2002:a05:600c:6385:b0:490:46df:a87a with SMTP id 5b1f17b1804b1-490b5e73e7dmr4526535e9.1.1780429317784;
        Tue, 02 Jun 2026 12:41:57 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b61511c4sm2758285e9.1.2026.06.02.12.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:41:57 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:41:55 +0200
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
Subject: [PATCH 6.1.y v2 10/11] selftests/bpf: Fix ARG_PTR_TO_LONG
 {half-,}uninitialized test
Message-ID: <c835cdfab6691e37b71f773a6001d7e2311fea0b.1780427227.git.paul.chaignon@gmail.com>
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

