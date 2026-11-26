Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665781;
	b=LkTJe3aV1YGBhv+Lz5nqJKJa5l9Tk4C9tiDV+YWcUzJZxTBFQaXt71CDJa/stpv85pAN
	 L0DIZx5XozPzLVfDJyT6SESjuWuAwyKH+ie75xEt7NTFfJ97rOHPK0Z3n98xXKAQqNSDa
	 RG5LVHgS65CXoxH/yeXt8dAuPKzyNCKBPEr+PW/NtlpKj9N1Br+oDjiA28eojIw+KUsQc
	 pZmoXi00fKn9je0tr7nFd4iF4otp3tk2qAmJ4IhkgKU5bjofcD+ErOYERbVwGUWtTtmJW
	 t68kj6mIU0xTQb6pt8XcpmlXdTMBuVNvEOKQ+ETSis23XcosC5cDaISpVCrBvb2wGqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665781;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=u8a+JmUNTQKadV14JX7bLRj0bKHwOADjmyLB7mBg+Pk=;
	b=oiTizCKRXXpFyfAtEo5Wkga0MS6NOWaiRHaHSgrwjx30t6GnG+KiatQtA1eJPVX8+KWo
	 MhKiDg8yMOybbrVsTJlRVgbxf7A3LWvNS6GP7HwoiMBPFEeieU6eZDLwH+tTsuCTpox2z
	 bLmwZ5WU7sxH3pgqw5azv8eJ8jKFOCPPtL6z0qAHCLzrprRiVxa0rqZ6q6cBKCi/hzqvR
	 3ntccwKCo/6qz2H2U5KJTUPMMtqZLwDg8HMS6DoiYiATFvzTInST/zcoHKAxiP8N0Ihia
	 a0oevOZgy7mbTlpR22kxQc0chhzMzQo9bcE4sltVspFTkTBuf7xJ4RRtyoFW5PQy9zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C2606A684;
	Thu, 26 Nov 2026 04:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 260C2606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jZjYz4jCnz20ff;
	Thu, 26 Nov 2026 12:02:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F1A740576;
	Thu, 26 Nov 2026 12:02:52 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.193])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAHOullrwdrepVXFw--.42150S8;
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
Subject: [PATCH stable/linux-6.6.y 6/9] perf/bpf: Allow a BPF program to suppress all sample side effects
Date: Thu, 26 Nov 2026 04:34:55 +0000
Message-Id: <20261126043458.2394658-7-luogengkun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAHOullrwdrepVXFw--.42150S8
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW8CFy3trW5ArWUXF43ZFb_yoW8AFW7pF
	Z7Crs8Kw4jgrnFvw15Jrn7Za4UWw4rZwsxXw4kKw4fAryYq3sxXF4DW34aqrn0yF9Fka4f
	tw1IvFyjv34UGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

From: Kyle Huey <me@kylehuey.com>

[ Upstream commit c4fcc7d1f41532e878087c7c43f4cf247604d68b ]

Returning zero from a BPF program attached to a perf event already
suppresses any data output. Return early from __perf_event_overflow() in
this case so it will also suppress event_limit accounting, SIGTRAP
generation, and F_ASYNC signalling.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-7-khuey@kylehuey.com
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba9cbf50773e..a6d7fc2a9ab2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9713,6 +9713,9 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+	if (event->prog && !bpf_overflow_handler(event, data, regs))
+		return ret;
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -9762,8 +9765,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
-		READ_ONCE(event->overflow_handler)(event, data, regs);
+	READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
-- 
2.34.1

