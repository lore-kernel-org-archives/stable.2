Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98D3CC327
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392645; cv=none; b=ckMIHLSlusJAG8G0qM+QkA0xRvdOQ+8PeuUVu67IEIhJWKxFR1JxV+8CyClQ1BiUpNpK4QF69OyXMhiD6cNJ6uJdTvxPhsBdkEO6CgqcyNcWYqeOIpMuiOMPBNeHtYVN9VxiLWzz1U5AievPdDdUNts1tHEeKtKt+PA0qOC1uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392645; c=relaxed/simple;
	bh=bidSqh67CoFWfSLkkc7VeY/inuRLEO/hHqCdniyYvA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKpVAEdC8GUtrKef12xqQnJmMn40h9PqI3JSLSDBuHza6yi4mHFRl6iwcUBZYGny5VYu6b+XvnsS1YX+AunVlIwfhhCrchmK/HP49awCjPoL3J5/jvSQR2YwObmsNLKrgsxQeejzN3ozy6UQYVXywpdRZOi9c0KfM/S28ejL9/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiajDK13; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiajDK13"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a762db7aso17628395e9.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392636; x=1780997436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkXd3nmo5CBvdGTqC1FOVg/E2CSmPcKZQdc0jf42Ebk=;
        b=qiajDK13FU4DfUuMYkLPSySsPOPiRJJRH1Wsi9GJJLbwsuc38O9BteoZtBJiLptz8p
         OV5DAhoH/+wXjVuWo/mqxsjqE9Fu0SxTNT+IqCm1zI0pBksnMmDmK/nL2835TM89r86a
         UyMFl355YaP71LPLrXZw+NtasrgGJW9biEsfXC2tVO8vXeOoTnPlpAWV6jwTPupAG+wT
         1sr/OJMmS+4Wb2IHLglub7ADBd4wSSQ154HLEXbsfwo+NIB1I1EF/gInWvP4ULsYXBbf
         CRg5R6Xt2vDh1mMdEDIx7rTVlva5E0XVndZwkvW//E3UeRCkqDd1IBv0JjeTMkm+i9oJ
         vb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392636; x=1780997436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkXd3nmo5CBvdGTqC1FOVg/E2CSmPcKZQdc0jf42Ebk=;
        b=SgJA3NxJeZ3fBTGVH0+ugPYNKAPz4tezLiEP8cYMlVZQ2myQ6QtHzKWEyeqi7jYeTh
         SpEJRUNMsyndzDsruYX8oxuQl2O5+9zIkFWQwD9GN7SqlzrEs1a2+nGcYZ4q3OoWMztR
         ZtgrEvxk8w5cNjzw+w1YeJ0VwxafkkBVcdNjnOWQXCwOUWxJVfCdFPTdUnsVdHWytnYw
         N6sgJRpwxMM/I3UKpsoS7U6x+zrnUtmlTftXhbcu+6/uIOWp4PNp0XKxFRIodZO6OM/V
         qSh+agutKHHtoosRWvxlJN1nbhjowpRHBM3Oh277GoUdcrPzFLZwByLqXRtrfB5IB00R
         /blA==
X-Gm-Message-State: AOJu0YwGsrGlydb4PgTuRWZvSLv7MfPj4c2AmBsnmpGKTCs/b8oChx6Y
	teDXdx8/pe9tt396WUMjMTm2Cjt/rwRY7E50geMPxoEj9jRyyySCLWu0mbDglnQi
X-Gm-Gg: Acq92OF79HRwHTUl+PzNgds+iQ2M2J8qOn3PYEfaGXcQC4FdH8NH56jHH0l4G1grsoQ
	+6eXSWf3xyTpiLQNPItBlFq2zUkXgP0jzf5l7rF1xDn3cmCiV3eGrwPQNcPw07IUFxM8FPIK0cP
	elPrOjzecANdkZJyCU5DQ0TmvV5jmIm6JmzPNPGXdWPu5dMbvEhoGX0fruV5AXgp5YApxL5N0vA
	sbK5I1Bba8o8emHi4bDQr+IXiHCjyEqOlWMyF4knWvM6ElBifxmWskIK0+7wvWH0OoGnwaN0gx2
	lzXRpGg3q2YUH10OaK+mH836Dm3dGsk6ZgHwIkof5RxLwf71g4MCqsGckrOrc0CqGqrkVeaYOJg
	qaTkH6VEizepaCGdPfO3Xzf0+1RmBzJGBLUyuhr4DoOz0PoeqNxwCQ0knT7rdN8jX/eXWJl3Ck2
	chM2Txsv9eIk7WDJqiCOqzjtXIEYDyaZJsuqencXU1Tma22bLa+P66AjwdmgYZuUS7aKJ8FFvFv
	2WNyc8wBH7plL3iu0RKWJhqtr9geWO20rHG51d/bYM/ZdxVt0RWvvruOUPTTi84QCnkWBUusyDJ
	a+0G3JVcFBN04g8td/7aLC9g7FPmvG25gae5CDqHxYqKQ+JMrq+RDg==
X-Received: by 2002:a05:600c:458f:b0:490:b202:4772 with SMTP id 5b1f17b1804b1-490b20248cbmr35527225e9.2.1780392635441;
        Tue, 02 Jun 2026 02:30:35 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b00d02afsm27930435e9.8.2026.06.02.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:30:34 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:30:33 +0200
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
Subject: [PATCH 6.1.y 07/11] selftests/bpf: Update bpf_clone_redirect
 expected return code
Message-ID: <2606575598c94a9dec5ba23c63802333c557a82e.1780392093.git.paul.chaignon@gmail.com>
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

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit b772b70b69046c5b76e3f2eda680f692dee5e6d5 ]

Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
packets") started propagating proper NET_XMIT_DROP error to the caller
which means it's now possible to get positive error code when calling
bpf_clone_redirect() in this particular test. Update the test to reflect
that.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230911194731.286342-2-sdf@google.com
[ Note: Commit 151e887d8ff9 was backported to 6.1 so this fix should be
  as well. ]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/empty_skb.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index 0613f3bb8b5e..329e34e5226e 100644
--- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -29,6 +29,7 @@ void serial_test_empty_skb(void)
 		int *ifindex;
 		int err;
 		int ret;
+		int lwt_egress_ret; /* expected retval at lwt/egress */
 		bool success_on_tc;
 	} tests[] = {
 		/* Empty packets are always rejected. */
@@ -62,6 +63,7 @@ void serial_test_empty_skb(void)
 			.data_size_in = sizeof(eth_hlen),
 			.ifindex = &veth_ifindex,
 			.ret = -ERANGE,
+			.lwt_egress_ret = -ERANGE,
 			.success_on_tc = true,
 		},
 		{
@@ -75,6 +77,7 @@ void serial_test_empty_skb(void)
 			.data_size_in = sizeof(eth_hlen),
 			.ifindex = &ipip_ifindex,
 			.ret = -ERANGE,
+			.lwt_egress_ret = -ERANGE,
 		},
 
 		/* ETH_HLEN+1-sized packet should be redirected. */
@@ -84,6 +87,7 @@ void serial_test_empty_skb(void)
 			.data_in = eth_hlen_pp,
 			.data_size_in = sizeof(eth_hlen_pp),
 			.ifindex = &veth_ifindex,
+			.lwt_egress_ret = 1, /* veth_xmit NET_XMIT_DROP */
 		},
 		{
 			.msg = "ipip ETH_HLEN+1 packet ingress",
@@ -113,8 +117,12 @@ void serial_test_empty_skb(void)
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		bpf_object__for_each_program(prog, bpf_obj->obj) {
-			char buf[128];
+			bool at_egress = strstr(bpf_program__name(prog), "egress") != NULL;
 			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
+			int expected_ret;
+			char buf[128];
+
+			expected_ret = at_egress && !at_tc ? tests[i].lwt_egress_ret : tests[i].ret;
 
 			tattr.data_in = tests[i].data_in;
 			tattr.data_size_in = tests[i].data_size_in;
@@ -133,7 +141,7 @@ void serial_test_empty_skb(void)
 			if (at_tc && tests[i].success_on_tc)
 				ASSERT_GE(bpf_obj->bss->ret, 0, buf);
 			else
-				ASSERT_EQ(bpf_obj->bss->ret, tests[i].ret, buf);
+				ASSERT_EQ(bpf_obj->bss->ret, expected_ret, buf);
 		}
 	}
 
-- 
2.43.0

