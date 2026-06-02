Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E621DF73C
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429282; cv=none; b=eZYhpjqD1xWIWW+Vvuyjte46P4C0TfTjd8/2zI1I2AOPebPMF2fYdi8ulplwHLiuGfGoKtNorsY0X1wAIM13PVpIsKDFOAOJq6fFpXluZAyekXMvFbTnx0nlkZWgsABbXXBhIQkf/0uWqZ1lHGw7/+lMmQNlJWi3brogEHQRpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429282; c=relaxed/simple;
	bh=3CKsCpPYLKBt9IOTeHJFFaEQ/dVy4crOuxSxjV/NGqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJXbd+g/W2+UgjfMhHAsU1S00Od/LLzLX65OiTc+JYmz/CqFK7e/4BZcw8dXukhbMgxDAa9iQtrwckfHWQsYc0eaYIrpK3pN8dvc1bGrBUT9pmAHk6T8UDc9hcHs3G9sut+WVKl9MsyeNe3Yiy7H6yQKbSH4oB7sAD6ybq1gfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5tvfSdQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5tvfSdQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso112507035e9.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429280; x=1781034080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4psAvbw/Xnq3ONvYKG+I2pbwgk+i0j9bD1HPj+4Ze4=;
        b=W5tvfSdQqqPizQ4CCOZu1csn516KwFDU6rPd9OdaYmL2ytD9JBZkpwxyW0QrgBfAXU
         m17jw3QSU0GsCm6YTAgaXlZS/Vp2wEI+Pksan9JLQWNidcWUtwrlvgymzZoFIIRN7OSV
         G9BjJe2WLas0YvGO91edqjU/fDRfrIzuKPK0PCGa49yA8tdQIkx9JKEVBMtjgzJ/AkAx
         3ZeR5nVguYRWB0XIq7FAW1Cj/6HuX7E9ZV0nSG4Gg9BFJ1RsXszbu8XwYJ/iz+NDI695
         41O8pAfsAvv1waznnCLKRJT49+LdJW5O9CDTKUZ1RCJ/mAG+CGpwqVf1z5tZ2MWRX0b1
         MUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429280; x=1781034080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4psAvbw/Xnq3ONvYKG+I2pbwgk+i0j9bD1HPj+4Ze4=;
        b=n9UC+PkvIcKDBm78R7kJOnYl77KnUn+U4EoBIln5O3j3e8S9XRPkq56QZJZlHajYc1
         VxSSz2if2vVT60DKcPTTRT7Yr1vYFUgjtsqg3QOZ+zq6pqauuSDu0VhiUPxCQDNae2vH
         FpQyr8yIWKtXcWid0Fk9ReOcwjkaCUWW5UEK/X0D02VUNEv82jTzXD89gSFNOkUieofK
         iscW4xNX6rLP5sNRp8iJczeEzluSbM9hN5xq62ezuLt5SF3B+wFvFdCzKFv8zSRE85sZ
         +awTuEuBbP2GVUVDaTNRzBQuXdjsn2QcssN0M+lRfKjF7dOJ8WlVy+FDLRy94W7fg9zt
         oMEQ==
X-Gm-Message-State: AOJu0Yz7rANnBWw93IzOM86sDfefSBC2UKqjPQGunOUn1MSS0eGBPHzD
	qvHeJamK8o5zpOxCh5MopYFBVO6+RPHqIppubtWhYiQf6BlpdAclnB58v7UH84FL
X-Gm-Gg: Acq92OEGeSk1Othq76tKnDh0yBT5soObpwTBW+L07Jxu8gK3JHnkVChhTWf/kCzHUki
	JRQxERw9ZlH1RsU3whJ2iIAgcJtfY/Oow749E7f8oI/mrt6qNwkPZlB3srFxB7l3dRjqxl8K3tl
	gjrmnO0d3MZZtHhHdZ77sGiwb/USjRGN/6Xs7kAMjgLEJSAKYBm4y/pgYQDBTMdSWCq2IOrbgL1
	7GXAJEsYNY27iBOdOmoo/lSWHE6nPm4c+fzeOLGyWnlQc70Hfanb2NhHITnt+3y1NH+ky6Keh9G
	WmclqdnywKJ6fi0zjX9whEKNkKVdolZofc3us3ZINEzRO2RdSYXzuniDplQa+7jq62x5L2uZA2s
	cmYM/9vVHLxGkrqKfqqHsVw3HFmAmsrsfKO34j0ZIZ30KTH5ohX4TD8/wRG4QuKZwWXslKN1HP1
	t5D5smnNyX3E5G6eVTYHDJv55Vie5wVc9hNLhcTcZu6olTLldr1ywMhfcyoyYnoYhrtAi0xUD5a
	gL95898gxPUPFkE3zqfl5sM1WlIZ0fmLC9ewggs+JcmzWpnq2Lj2DtXj5lf+eg3SE6O1RIpXoUV
	bjoUPevJX/cAOS7me3yfoCd/XHoumdvZJXyJ7Qm7L+sWX/3mBXKTvg==
X-Received: by 2002:a05:600c:4588:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-490b5ee02e3mr2966165e9.14.1780429279603;
        Tue, 02 Jun 2026 12:41:19 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm149935945e9.0.2026.06.02.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:41:19 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:41:17 +0200
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
Subject: [PATCH 6.1.y v2 06/11] bpf: Fix a few selftest failures due to
 llvm18 change
Message-ID: <de22001e84157b1ce784d76d259b3c017b506e21.1780427227.git.paul.chaignon@gmail.com>
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

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit b16904fd9f01b580db357ef2b1cc9e86d89576c2 ]

With latest upstream llvm18, the following test cases failed:

  $ ./test_progs -j
  #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
  #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
  #13      bpf_cookie:FAIL
  #77      fentry_fexit:FAIL
  #78/1    fentry_test/fentry:FAIL
  #78      fentry_test:FAIL
  #82/1    fexit_test/fexit:FAIL
  #82      fexit_test:FAIL
  #112/1   kprobe_multi_test/skel_api:FAIL
  #112/2   kprobe_multi_test/link_api_addrs:FAIL
  [...]
  #112     kprobe_multi_test:FAIL
  #356/17  test_global_funcs/global_func17:FAIL
  #356     test_global_funcs:FAIL

Further analysis shows llvm upstream patch [1] is responsible for the above
failures. For example, for function bpf_fentry_test7() in net/bpf/test_run.c,
without [1], the asm code is:

  0000000000000400 <bpf_fentry_test7>:
     400: f3 0f 1e fa                   endbr64
     404: e8 00 00 00 00                callq   0x409 <bpf_fentry_test7+0x9>
     409: 48 89 f8                      movq    %rdi, %rax
     40c: c3                            retq
     40d: 0f 1f 00                      nopl    (%rax)

... and with [1], the asm code is:

  0000000000005d20 <bpf_fentry_test7.specialized.1>:
    5d20: e8 00 00 00 00                callq   0x5d25 <bpf_fentry_test7.specialized.1+0x5>
    5d25: c3                            retq

... and <bpf_fentry_test7.specialized.1> is called instead of <bpf_fentry_test7>
and this caused test failures for #13/#77 etc. except #356.

For test case #356/17, with [1] (progs/test_global_func17.c)), the main prog
looks like:

  0000000000000000 <global_func17>:
       0:       b4 00 00 00 2a 00 00 00 w0 = 0x2a
       1:       95 00 00 00 00 00 00 00 exit

... which passed verification while the test itself expects a verification
failure.

Let us add 'barrier_var' style asm code in both places to prevent function
specialization which caused selftests failure.

  [1] https://github.com/llvm/llvm-project/pull/72903

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20231127050342.1945270-1-yonghong.song@linux.dev
[ Note: The change to test_run.c conflicted and was dropped. The related
  tests are not failing anyway. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/progs/test_global_func17.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/tools/testing/selftests/bpf/progs/test_global_func17.c
index a32e11c7d933..5de44b09e8ec 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func17.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
@@ -5,6 +5,7 @@
 
 __noinline int foo(int *p)
 {
+	barrier_var(p);
 	return p ? (*p = 42) : 0;
 }
 
-- 
2.43.0

