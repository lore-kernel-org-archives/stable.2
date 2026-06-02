Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF8284883
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429291; cv=none; b=Xg9wpBnxVOu5YXLDqI6aUAdKT1JE9zQZQXLtSEuwG3XwZky5PzamQcJsJ8jIrXdJC/LoAx/3dxCjzT1p3eeg/22lsZAAJZYQ/Ufy4ji7s34kx3h9U5vCYR3yAWsj67hpqmwbdtRjkDVrCGkDIZ0jbSe+MUl+BZuHf+TEIlFe7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429291; c=relaxed/simple;
	bh=bidSqh67CoFWfSLkkc7VeY/inuRLEO/hHqCdniyYvA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqemZvLzIzG7Gka8zm871V7Mm3XlTnv9h7K6J1O0AWyDpAEpWf+6oTk4yD8EIAIPlDSJmSEv8oiTbUKARbzmpLlxPD2NIQfM433qt0u0tHseEdYuZrzCe+w60XHEP/WBI/cV8Egi60A/rxZ1zaeIZTktwVxfl9iFxTMzkXkw93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea+B7YdT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea+B7YdT"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eedc94d37so2935160f8f.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429288; x=1781034088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkXd3nmo5CBvdGTqC1FOVg/E2CSmPcKZQdc0jf42Ebk=;
        b=Ea+B7YdTUBgsTXj2cvPpd1YIP8a1KEEpYucap3O9jxtIdCiv6UL8TMBWEz8JShRbtn
         bDNBjGhEbyGygB+kF+Wo30L4Uu8pqcG/JbXaIhkhHjxPchvhB0y9cskLmSZhUbLVMIcB
         tjh0EVUNTBFYTAeOIttsjbDcr2B5A3bWAOs8FFt6OJO/zQzpY2SRaGhVsVZE+iWIfHFt
         /b79CH9WSJL0MkfLvlEOMhoCmG/z1MdyjyqqV3Mm/pXNnXg5WV1BYJ+31VGxQ9ENnvCB
         3oBuiSQETJqDQ88VxYmCsj3eLM6bSGESzguVMg+I6aV+K3yZz6SHNHcPnAlQhf70y5Yq
         kHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429288; x=1781034088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkXd3nmo5CBvdGTqC1FOVg/E2CSmPcKZQdc0jf42Ebk=;
        b=o9R25H7Q2KVmMJhwfZgen/p2lWaG5nM4y+6Da58bMOXdEcRfnqiYIU2NyJ9WF8KQ0L
         LipLsGZrgn1/pCLSznY5ZpHe593wduCMgVveew81AyvSIRhyTzUL00mWPh5+Cn4m2PnX
         xGNTnfU3EvMDvAkVZxmUGmBu8g3X0JQdynWZ7VxHCrhe7f5AJXM9J2nUsv+hJo9H2H24
         /A9bh0o7Kgdo0FjIYhZm+/nV8RLNze0fd8ciROKspHQQoHKAIEh25Ra0jsVXGRcXLygk
         OyeOp6OTvZ4vs+75pbNzM1EIDT5DzOd8024e6NuSg86FyurpQBFuWTuN0dw661PERUfZ
         89KQ==
X-Gm-Message-State: AOJu0YwX/ifLuKEnGfUu6M2A9m0ORPoYa4glEvxjX29dpsqwdT8jXjW2
	1iAjWNABN2bJ3r2OJ9vVKEr1I6V4Zss5r1tSZ+hxZgOcutk08xaFbb71sKEnrMBG
X-Gm-Gg: Acq92OG3/E5J04mCXgLXAf4YJx6SF0lEmEf1R+dMq4xCY2Zse7R9J0kE/s3//fh0lwM
	X4oP80MaNVxZv13hHiv05K1ac1jV9kBAXt6IHml43mVstlIYK4Z5pXn0Oki76NERLY939s96yEQ
	n742kvO+SF8ybbqjfJfFpPDih3WqJMBRSB17bRNhp82W+CcM9MngrK1KbD0q+DKoBOGsmvi1VsP
	BoCf2XFKJSaMj7/lmRkVKEuc0to1Q5hCG4xHUUNWVTn1wF1cFYWyh+zvD7me5BIPbIofC0YtdMS
	twguNTTLar1kUmAzDEzegNmbV5wcMxBlN58cZ8dzoE7HfxM7Aw1uvv99QboH4tuy3IQ/UWmCXMp
	VzDD0JctAjzqbx22TwWqX3OfJ/ZOzdnkyMj1SI9ASqDPiS91Nmuy5pP7uZFW1M6z7wsQQjfClHo
	r1a45teU/1MkkUSmrXWxMRswytz3g6B85jX8xMYTIJGRRmTwRaq3GX8Wikw1NS3cKNdcy/Rr3jF
	tpj6CScOdeG4s1DA2bSj0M3MTH7U1tVSWkS+N4C0SeB3ARItUqVTuctIBy95dzmug7Qcx9V7UbJ
	W0Xrgz1kTV5XWuQyOhrkmpvCrNxmh5fF9IsdhKMqhP+3RMUgF5VUjA==
X-Received: by 2002:a05:6000:bc3:b0:44f:9b70:2996 with SMTP id ffacd0b85a97d-4601f64980amr728020f8f.21.1780429287961;
        Tue, 02 Jun 2026 12:41:27 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm1524542f8f.33.2026.06.02.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:41:27 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:41:25 +0200
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
Subject: [PATCH 6.1.y v2 07/11] selftests/bpf: Update bpf_clone_redirect
 expected return code
Message-ID: <0852466ac4c1544b52b34ce6a609022ee8939735.1780427227.git.paul.chaignon@gmail.com>
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

