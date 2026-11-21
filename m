Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795237797;
	b=C2cQ+JgKXCt4ubkDMpvi/Gjk7ZxdE+celOaYet66WL3M3lBFXW0r+gjq4iNRWlWjAru+
	 QVDJ4o4h3QCJV+Dnh9Bybbt+VEQ1db3G/4QUpKyNJB1m++NU7AulvdFZ/G64aLXMD1Nuf
	 CMKlB84YgRpt4eZTpVBmUlNFMcZp0noN9CdJJBsZP9VfKbT4ZqY+Linzou9vslaPXvEXe
	 EL3XPa7EVUMI2SJSKb2B8SaVqr2B/ZJuJr8atNWw425aGmaXjboeOQpE6FmmLlQeZkymP
	 OylmnNnCREivkh6IfEjDMKEx2ZQ5BssvBpNsQq1oPHeyvBeijJKRrD2Rj73IQCwzeSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795237797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=S7WcCb4GXIdQwz10dJ96xm9gKSchZu1/vzbqi9dXqMg=;
	b=1pbvMYDACXefLanRTEIVbPqm0/9ytJ3BKcXd1GfYsxJLBRRC3nSSDg3qCJje3/fWsmma
	 Tf3U/sJudz56kNBvpYY5Q2FT/cIgCyXNB0MeAnoLlFatwRvGrNhSEWHGqlDr3p4uH3R0d
	 yk4/CthZ6XIH43dDcO+dUGfqBC1ymLMN/1jHyQZ+7dtknXTeCqRPocCEb+ZGC0owCItvC
	 YRzz4fMAE85eN+fNCAXLeDr0Cewq0fYVx6Fmdwcre28LYVaLBbwfnEOlLj5lwr7abmn5O
	 QUBRytoHcdZuVlJB/jgRoVL7+yJGhSOIf2uWBzS0pNNp6cbP0Nkf41Xb3yepOE1c0sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDIEs0yq;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B264606A6A3
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 05:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B264606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDIEs0yq
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5ee3e658c70so438812e0c.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795237789; x=1795842589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7WcCb4GXIdQwz10dJ96xm9gKSchZu1/vzbqi9dXqMg=;
        b=XDIEs0yqjH15ucrcoBreDFlgrftYsHcm1IITjL8fn+lBTce2BsUSYt0EPgtbxWjlGW
         dMx5SPAg1BNOuyJVlY1fugyvq79MuATYL9iyWpxfpnpRTNuYLEqUAFv0oGo1+KrkaPfS
         LqzDAwfr4/M4t8la6iVlnN1bEVrHbh2+dPqsB06CEisJEAzU6PI5im1jng6jayDT96SS
         g0NAMuLWZ3r/esbGQ4SvsXpTS+fYV/7XHH6LBVcL0QNcj3OOgSiUkikVzWizj7GgIhyO
         AJ5Xv6OzbJ9ke+ntVjseRIlx5jl71mf8m91gLSkOrToUgRFdKDftV58EeKCUYplntrc8
         2rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795237789; x=1795842589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7WcCb4GXIdQwz10dJ96xm9gKSchZu1/vzbqi9dXqMg=;
        b=rzFbgcHQSUNPIjMw3X5tyBFCTGSbYbUZje32GBbaUUaa5L5QAVKfYzrtfjc7tA3eQ8
         fb3B+yqiyNsYRWl4tR5W2tSvZLvScBMrbvbAvbX1KlYNRQJAtRK3uaGX0IKQu4P7LJZA
         R9le8PHZbJNAvUlqqJsgQsb8ZuI25MuHaz6Ntwt7ngupW2qntiH4cRLALhZyn88Gu5ml
         nzY7bur0lHCi+jr/7uaMphJKByyP1js56FQT/YX40MWuFbrqnusAK1NWZ7FQAhs1CU37
         AGox8Que23sXpCZLufL6UOlO6GOXW/6+/dwpmhiVJxSy4+paDvQpTpZtKP1WE32zFf21
         vzEA==
X-Gm-Message-State: APuU4Z8TQB1QMnHwxpyd7BAix0FxAZkg+rtyvxf+xGhoZb/kZ0AdZe6S
	HGTCVRep8OEIz6zlVBeEBqXO8NN1XSAveavWKHgn09PoAyVWiO6qRDwh8H4yLTMO
X-Gm-Gg: AZFdTZfrmUBjwWRfQ+ngSKAtAjvc2oWL3cti/Ckd4aKd/cULxQE7r+hbmppIYlcldhB
	0yOEo5KJnYklEUzGRV+vquZKDGcxiZjofzbmBfCZA8GH8B3agKpWxRim5UIUSOuwk6qtHbHlxdR
	+u9ARjf11Hu9HpxZzJpElkJK0zPEM7G7cafEoNkAOsTy7+8oQngpq/iHW7adBODxj0ZlM2njUGJ
	DN0KO5br/XUc1FfRGznxwlJUWpzN6f2Wj4uj4SRNxl8v2ec57UwnMdVas5hr1sMc4ol/Y2x4g/O
	wJUjLCzMSxDjwHvaeuEwW/wSMJ797UX6pw2qY6gWQFFxhmxyIO9tV0Jo0sN2uEx16rVqfZPyZBs
	AJsZosU1Q6vpVhMlCqbd9mTJqdIifefzKKn4luiwse4PTfJP7YOZxJRVsNIvjcAEWHGZuoWD9/o
	R/kxkZpcDN5m3MLcFVtvY5Hu3zKOXIAUqquwPosgERqP2bowq3AKAKNakV+sHGf0CjM7uqQizRY
	/8pf5MbfoGI18QMfepcmZ8OC0bUSN5nesTjwjOj02zke9X+4kjom4iA5L/XEQ/1kEHIV91otcpC
	E8nVcCRdo2fvigQ+Bt/cXufvJQlQfLFHspPi2jsTiIlKdDzSfPQ5KRDru5AsP989mIAWRWgjDP4
	yEe3biHOjFD9NtI94h344v44pco4XgLe/PDnHokhw5aU=
X-Received: by 2002:a05:6122:130a:b0:5d4:1193:73d3 with SMTP id 71dfb90a1353d-5ee8af25ffdmr2358738e0c.14.1795237789069;
        Fri, 20 Nov 2026 21:09:49 -0800 (PST)
Received: from localhost.localdomain ([207.174.22.68])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b556db7sm4451930e0c.4.2026.11.20.21.09.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 21:09:48 -0800 (PST)
From: Yingke Xiao <inkxiao12@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	kpsingh@kernel.org,
	Xianrui Dong <dongxianrui1@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Song Liu <song@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yingke Xiao <inkxiao12@gmail.com>
Subject: [PATCH 6.12.y v3] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
Date: Sat, 21 Nov 2026 13:09:24 +0800
Message-ID: <20261121050924.97828-1-inkxiao12@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: KP Singh <kpsingh@kernel.org>

[ Upstream commit 49b18315be4eecfc36b75f4aecb4d40a87d68a20 ]

__bpf_dynptr_data() can return NULL (FILE dynptrs, any non-contiguous
backing). bpf_verify_pkcs7_signature() forwards the pointer to
verify_pkcs7_signature() unchecked, causing a NULL deref in
asn1_ber_decoder() reachable from a sleepable BPF LSM at lsm.s/bpf.

NULL-check both pointers and reject with -EINVAL. Mirrors the guards
already in kernel/bpf/crypto.c.

Fixes: 865b0566d8f1 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
Reported-by: Xianrui Dong <dongxianrui1@gmail.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20260520024059.313468-1-kpsingh@kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
[ In 6.12.y, bpf_verify_pkcs7_signature() lives in kernel/trace/bpf_trace.c
  instead of kernel/bpf/helpers.c. Adapt to kernel/trace/bpf_trace.c. ]
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
 kernel/trace/bpf_trace.c                                    | 5 +++++
 tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bac2db7..41e237d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1384,8 +1384,13 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 
 	data_len = __bpf_dynptr_size(data_ptr);
 	data = __bpf_dynptr_data(data_ptr, data_len);
+	if (!data)
+		return -EINVAL;
+
 	sig_len = __bpf_dynptr_size(sig_ptr);
 	sig = __bpf_dynptr_data(sig_ptr, sig_len);
+	if (!sig)
+		return -EINVAL;
 
 	return verify_pkcs7_signature(data, data_len, sig, sig_len,
 				      trusted_keyring->key,
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
index 8cd298b..04aaf4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -14,7 +14,7 @@ static struct {
 	const char *prog_name;
 	int expected_runtime_err;
 } kfunc_dynptr_tests[] = {
-	{"dynptr_data_null", -EBADMSG},
+	{"dynptr_data_null", -EINVAL},
 };
 
 static bool kfunc_not_supported;
-- 
2.56.1

