Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665776;
	b=sJrnMRGhrALd32K1d8xBIYwm9T/HVUlRAuHFbF66SYs2+0bUTRuN1/mIAgEOiw6E2zPP
	 CZ4fOId7SdxqMoMyp08JVyzM+raoxXeMBPXWU/Yow1AZrbOI9byVEj5z+4DBchjTDMM19
	 30ryfm7Hyuuxk7liEHv0MQCoHoAlX7OBO72B3fdaTTMAGR1dKaumLJjrcWj6sVihKA6uJ
	 DpWHxH31fWXw4Zx4CkJFCoMmIL6nqQOPwtfKFAo8rdTI9QdXg8NvhSlFRIKDvNGKmDkT+
	 cXr5QBsZzGtl8AyTgJn90BXIQ9sDIJ+2HrYgMeQ9p39+imrvepTHCmefGHaHEPN2+4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665776;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=CqkX50TWd87UiNMb/G7h/MJtsKRrgzbFQl/rc+cZH70=;
	b=DoqHHA5rCczINI87hw2d0bjFJMRStSVtpknqAtPENPJ9rzmAXrKM/YUfVJEp+N12jMWo
	 2lljilHwOmer+NH1UqhKGXWAgRQlOpeSAtXqYuNtZq6IMby5dldyHrM4RHDV7p9BCps2I
	 z62IHdQepALiZjHKP1+MzapYiHaDH0McvpRSKXgXkOaH0gMHV3OGUYPhc5OK5h9w7G1Om
	 /UjdRiQ7mnGhGJFjMlF61GoadsPgH6DM22QxFZDFPo5mCo0+D7CrAm8MxMzlsyqs+nHmJ
	 bFhWuHsCusllAHHC/E+/Yd9tzoDGiF5NJjnKVAd9FTpm2XyC/Vi9ragUPPVbuH9VCkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4C6606A326;
	Thu, 26 Nov 2026 04:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D4C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jZjZ00ssGz1rs0M;
	Thu, 26 Nov 2026 12:02:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 868B240C97;
	Thu, 26 Nov 2026 12:02:52 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.193])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAHOullrwdrepVXFw--.42150S9;
	Thu, 26 Nov 2026 12:02:52 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Song Liu <song@kernel.org>,
	Kyle Huey <me@kylehuey.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	alexander.shishkin@linux.intel.com
Subject: [PATCH stable/linux-6.6.y 7/9] perf/bpf: Change the !CONFIG_BPF_SYSCALL stubs to static inlines
Date: Thu, 26 Nov 2026 04:34:56 +0000
Message-Id: <20261126043458.2394658-8-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126043458.2394658-1-luogengkun@huaweicloud.com>
References: <20261126043458.2394658-1-luogengkun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAHOullrwdrepVXFw--.42150S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4fuw1fuFy7tFyktry7Jrb_yoW8XF4xpF
	WDCwnIyr4UKFnFg3y5Jr4vk345A340gws8JF1xK3ySvr4jq395JF4UWr1YvrWrtr92kFyx
	Jw4qqrnrt3y7JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0sqXPUUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

From: Ingo Molnar <mingo@kernel.org>

[ Upstream commit 93d3fde7fd19c2e2cde7220e7986f9a75e9c5680 ]

Otherwise the compiler will be unhappy if they go unused,
which they do on allnoconfigs.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kyle Huey <me@kylehuey.com>
Link: https://lore.kernel.org/r/ZhkE9F4dyfR2dH2D@gmail.com
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6d7fc2a9ab2..edced196597c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9674,21 +9674,21 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	bpf_prog_put(prog);
 }
 #else
-static int bpf_overflow_handler(struct perf_event *event,
-				struct perf_sample_data *data,
-				struct pt_regs *regs)
+static inline int bpf_overflow_handler(struct perf_event *event,
+				       struct perf_sample_data *data,
+				       struct pt_regs *regs)
 {
 	return 1;
 }
 
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
+static inline int perf_event_set_bpf_handler(struct perf_event *event,
+					     struct bpf_prog *prog,
+					     u64 bpf_cookie)
 {
 	return -EOPNOTSUPP;
 }
 
-static void perf_event_free_bpf_handler(struct perf_event *event)
+static inline void perf_event_free_bpf_handler(struct perf_event *event)
 {
 }
 #endif
-- 
2.34.1

