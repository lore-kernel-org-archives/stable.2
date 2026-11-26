Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665776;
	b=Rsx1lnW3D55IQ+dL4XDmjSpRlk/TAfblD9WvxlPmMu4RAkSu1e21VeMZAu8e5guKnZGd
	 03u+Lb9jIv/cri/BvFvaqwunTDxSfHTbvgMoW+sEBPzp+2NLboVrMp64BQpHCelob5PgS
	 U5pQmd56apKJa19qkJCGy/JgU/4hacvCctSsJHabyi/XE/eswg7/7ryZDsQhi9JF8pXOK
	 o889pYoWjl5v2IihUwkpvb6jYtE4HKDRsX7gFR5mfttGacQkUGLS+KjRo1T3LR2Qd3jwi
	 KNwbgum+EYdp1ULPCvFnhI2ZGQxj9gpA/flzTDfMoK7M78qlZvTpbzZGaX4jTfh8sbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665776;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=862rMJaZd1C5jCAn+b58mUtjbJIOt9qGh++2oec8QZU=;
	b=HQfUiOCgey4Fy1uOPA/UF7nAW5B/QkjIsqHE0M9InnbgHapxIA74xtkv6DYxxPXsc/jc
	 mH7f0ko6oous9Gm7SkSfPW3Dlg265cHSmRhEyH/mQdP6ikN2sVvmhE8dV9MODX6adHs8V
	 t4V/djJ9RtPeKLjik0ldGZfPLyKNVGt6gmjI/KiGukBfXtcyajf5EtDslQtvUwWG/mWci
	 NNCAkbSaG2WnI4qJQYegG1lvwvfhar94S0T5SAfSd2LMQ1TSi4OI2WCpBNqL72PS4gFmf
	 jCBfJTRwfHaHvwzHtMg8KPw1iHBfZhP1b4S6u/mkKlij7qqltqLXLXN8tbvFJmN61zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BC606A31E;
	Thu, 26 Nov 2026 04:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 338BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jZjYz3MvNz1rqXq;
	Thu, 26 Nov 2026 12:02:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DDBAE40561;
	Thu, 26 Nov 2026 12:02:51 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.193])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAHOullrwdrepVXFw--.42150S5;
	Thu, 26 Nov 2026 12:02:51 +0800 (CST)
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
Subject: [PATCH stable/linux-6.6.y 3/9] perf/bpf: Remove #ifdef CONFIG_BPF_SYSCALL from struct perf_event members
Date: Thu, 26 Nov 2026 04:34:52 +0000
Message-Id: <20261126043458.2394658-4-luogengkun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAHOullrwdrepVXFw--.42150S5
X-Coremail-Antispam: 1UD129KBjvJXoWrZFW5Aw48tr4UJr1kur1fCrg_yoW8Jr1rpF
	WkGwn0krWDGr47W3s8AF1jy3ZrWr1kurZrXw4jyws5ArWjq397WF4qgw1YqrykZ3yj9FW7
	Jws7KFy2kryUua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jx
	CztUUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

From: Kyle Huey <me@kylehuey.com>

[ Upstream commit 14e40a9578b70cc5323e55f61292a7e021f6037c ]

This will allow __perf_event_overflow() (which is independent of
CONFIG_BPF_SYSCALL) to use struct perf_event's prog to decide whether to
call bpf_overflow_handler().

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-4-khuey@kylehuey.com
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 include/linux/perf_event.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a0df11dddc1..b504d7eec86f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -809,11 +809,9 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
-#ifdef CONFIG_BPF_SYSCALL
 	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
-#endif
 
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call		*tp_event;
-- 
2.34.1

