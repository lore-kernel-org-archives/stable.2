Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665776;
	b=ZuVDOcIp0zN0hqLNZZ4BxP75GjG7TsplU8GRSInLCJDKNZT7x1ASMkSjCo6DolqU9jEb
	 gV2k6NZ2Ujfp2+Me4M8MD5uDN454oC9OHluPd4q0ulBOg1DFDXXGrgiDQDLR0XArSbY1Q
	 QbYI4JYW3i37H9WGKIwlQtUYVVQgkaTuNW/xG+m6fmAW/OjWQEJuv7L/Wy3mwShC2vWen
	 UsW3FDaS2gS96ozTLU96jV1Ra92qKiLrtjusiE28e0m0ZPe8xpG2Iv00WS+/5m+Z9SqDf
	 mSiiB+iSi0vJKy2Kv2PpHcUMlem3QuIIRFBMu6A8FCk30DxXY6se1GS7FYW11e97sZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665776;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nmHF6BVLS5/BINBS4MPOlp7yHZ2RnpxrvS+ZJFvO0rQ=;
	b=VA5f2s88850uscEhCxCAzOuU6RS+4NF4FPHi3RoSRRm8+5l1m+bOf4m55q4dRBQ1BkP5
	 1qC6UfAK+fmPVgQmPQeS+mq53AmMypaXCXEePuWqjBye/z9kENSclkwc9zXnyM13WbJ5g
	 /C5G3/2+TLB5DLv4EoHOXN4qd5zurnX+/J8dCEOa4vNbqbpew8LbUsbUDnxjcSZrWQ6QK
	 Cux7/jUgEZXSWQJCihE3u+CULDIIKfUXFLvpAR/YYOifsuHGIe4OuNXn3fHlw7TFruGzd
	 olAPRbUoBG1X4LvK17ueiOKAOXsERbMw+ewdGiIqRF0KAyjiVnaeSTpBHoEM4+Xl3NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAA606A321;
	Thu, 26 Nov 2026 04:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60FAA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jZjZ01gYJz1rs0Y;
	Thu, 26 Nov 2026 12:02:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A6A644056B;
	Thu, 26 Nov 2026 12:02:52 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.193])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAHOullrwdrepVXFw--.42150S10;
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
Subject: [PATCH stable/linux-6.6.y 8/9] perf/bpf: Mark perf_event_set_bpf_handler() and perf_event_free_bpf_handler() as inline too
Date: Thu, 26 Nov 2026 04:34:57 +0000
Message-Id: <20261126043458.2394658-9-luogengkun@huaweicloud.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHOullrwdrepVXFw--.42150S10
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyDGFW3Cr43XF1kGFWxJFb_yoW8WFyUpr
	WDGrn0y3yUK3Wqva98Jr1vk345C3y0grs8GF18K3yFqrn0q395XF4UWw15trW5tryv9Fy7
	Xw409r1Dt34UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

[ Upstream commit 854dd99b5ddc9d90e31e5f112462a5994dd31810 ]

They can be unused with certain Kconfig variations:

  kernel/events/core.c:9622:13: warning: ‘perf_event_free_bpf_handler’ defined but not used [-Wunused-function]
  kernel/events/core.c:9586:12: warning: ‘perf_event_set_bpf_handler’ defined but not used [-Wunused-function]

Since they are both single-use, mark them inline.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index edced196597c..c56c7ca511c1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9627,9 +9627,9 @@ static int bpf_overflow_handler(struct perf_event *event,
 	return ret;
 }
 
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
+static inline int perf_event_set_bpf_handler(struct perf_event *event,
+					     struct bpf_prog *prog,
+					     u64 bpf_cookie)
 {
 	if (event->overflow_handler_context)
 		/* hw breakpoint or kernel counter */
@@ -9663,7 +9663,7 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 	return 0;
 }
 
-static void perf_event_free_bpf_handler(struct perf_event *event)
+static inline void perf_event_free_bpf_handler(struct perf_event *event)
 {
 	struct bpf_prog *prog = event->prog;
 
-- 
2.34.1

