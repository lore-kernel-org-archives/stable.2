Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9C1E520A
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392633; cv=none; b=AHGc+QSj5lHmHb7rZP647yM1NFIEgrVwp7HnDLsKvykSzTH5Joa0wmZ+Q4OMV9WJZVWzOOUKRhtczDfUJklqzPz07lxH6BGbyF8HuUHXokxrleniiq8og6fPDvzXebXPSUGmRWST/uiBUD31oRMuTJ0xWHnucZBjDHpZey2Cjec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392633; c=relaxed/simple;
	bh=3CKsCpPYLKBt9IOTeHJFFaEQ/dVy4crOuxSxjV/NGqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSbXD3EyBOMuPInlSWSEnWe3vr0JsL2Y42QpmSG/ZVv3R40GxV1Vcnca9XOfXgqE1s3Ys67hvfeBZHW5NmckALqjdrCFKRwXWOxWt/0jjO5ykGZxoe200HCDQ9fD8Rm/4UO4duUcBG2FI5OipX94+8epo0rjVFwVkCCgCbDOPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ/D46ew; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ/D46ew"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4909e3fa4b2so39828585e9.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392627; x=1780997427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4psAvbw/Xnq3ONvYKG+I2pbwgk+i0j9bD1HPj+4Ze4=;
        b=YZ/D46ewN//s/B+v2U5JGMExxUoVzMnur8qQ1eh88ez8nSQEDGkTi0Ja4j2PYWmxVl
         V6GZRTWqiTyKVsxJlNoodkBHy0XmE9xwAl+Hp6483w2eNtfhZE3yX7R9fdHH0eiCk0xZ
         e3UBEtOtqVB2b7uQs24sl6Y3gaN7MvQcYGisZZKbS2+mAubDiSqmqyS9NgxVTNOvu/CI
         I3y1aqgkrhXSHI3/cm6M1Q27TSXHAmuvWibhdLs75l5Af+64Dnizh+SuZ7IjEUIVssoK
         8WIu34+JEO5U7L728paAUDCR/ShinZSMATbEQ5qT93pWrEpbaETV1iRIVwEpiysvxos8
         3T/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392627; x=1780997427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4psAvbw/Xnq3ONvYKG+I2pbwgk+i0j9bD1HPj+4Ze4=;
        b=MoTwY1uj8oJ4cnjp+NQ0XtoLHaTl7HPPSxYs9aX6OctlAlSmCq2tc082q5fD16XcNy
         X4xnHmzLVtiko3jILjKaFU8+Tn013l61KwnOLMAa4mPvnwU03Y7Qo0l+SkJi6/dztmXQ
         jFY57P57HPPv7ekzxoI+0iNN4+ZtlEnMMhnJjyxf2K8HgDhNXL2wrEwUYUeO4xGalOTy
         CbwZFWLH0HtmlfnkYptk0tQpPQdCr/uoyllt2K+OzfNkr8XTIfM26gFlT36T04i98B1O
         yo4Vyn+qTgZc2M3EndLf2rfBQP18InZHBpJu3gPARcKmP8LGzXcS4odCAQDwY93vb+O/
         us9A==
X-Gm-Message-State: AOJu0YysCHkq9mr0o5zikvwMTSNqNn3oVAShzIy5Z7eIbg1eXjOEEW7W
	xjejYU6lpschKQTSD6TsMKTYZxZ/OsKpbDN1CxouGhnftUd64ZmiwaF2vRVM8Ol6
X-Gm-Gg: Acq92OGpP/e6S0KPigftLH669kZ8OFmujJiTDboBzOHCY91zW1y1OALycjy+gcuSGN/
	m9h+boRucwb99UFjxIchLafIPuc3LcyV+895eEE1A1VDxGrQI6gJjzS4ddT8KkSXb/O2AO3eVOw
	AF9YFVBiRaU5OY9d2d2c7yoxgov+pll43hcXpZ8ZspJ4hhKUBpfaY6q4hvJQ7CIKe2iug1gDjKf
	pxFyVYMS/HIpskCrrGem7C16gVhx71RI1NV5nCh57w/LQOI0uJlf7DOXW8eP003RGpEuMtkurdE
	GztVySG/obEijKjLiHaer3CzeDyQqZNX+nsbNZa0pyjj5WWox4JOdH3FErDM4+df4mgWJYhAsGY
	DVLaBJx4pv5H/CijD+HC/ZRh+y+9/PlXgwfMWYhMYgXstk85ZFr2oNU48bihXO74uP7qC574+C7
	2/Vxuw2li0ePFTUO7w+N/05+KKLIw1fb7f8klYgbsAEz/gt51ywHdjOpNK7EEf/YUW3K3HgGGmJ
	hplBAG7VCO021cF8LYJnC7h3w/xfRH9SAjB2FlQ1nHorwFsRv7aleD/nyZnWVKXYboN6mqR6Ai/
	iFGmZ/rYmSAAavtoerwrbPWnOOluV0LhICDveSAQoOboY0ztpXNRAA==
X-Received: by 2002:a05:600c:c494:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490a2915525mr279816545e9.9.1780392626977;
        Tue, 02 Jun 2026 02:30:26 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b7d6bsm33337633f8f.10.2026.06.02.02.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:30:26 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:30:24 +0200
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
Subject: [PATCH 6.1.y 06/11] bpf: Fix a few selftest failures due to llvm18
 change
Message-ID: <2be5f2f4b4b2b6c132774b55d82e99cdcec659a5.1780392093.git.paul.chaignon@gmail.com>
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

