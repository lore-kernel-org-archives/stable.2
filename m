Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122776;
	b=G5KnnL6iz2iOGYhW/cTd6chP1dx3UxRkpQLMHYBHctRD50LRJf5YsueZoRmiUmHYNrxQ
	 Om51nNznrr1GoomaS5yewi9dmFquki+W77jtTgSbb2FmQ4ZI36mk5SNOC4yMgCgg1MeOO
	 RiB8JxUklExF/EYehNZU4fgT4nb1aOJc7MHNAFkrPIiqkqKwLrEDuAAwD3Q0vZ2o8mwDq
	 wIQmSLSX4FGDEP2G5fQrfvlvaNaP9lJtsV4UBYeRlj9SXE0aKwOo07NOuOpqoWb/+r1nO
	 CuZ5Kwp/kSQpGSWGKw4EKQRa473SfcIkLp3eeI6EBB/CVZR3oBzJyhBuJYLOPt57sDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122776;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0rj8aNlRTuSxfRGPYit8bnUu7xqxVCkNmfnsVMROY7k=;
	b=BHSyFtICIbMwq3LCF3KdJozlIdNwW1eJqAOEuWL+ywoF0I0/Ih751Fh6PI8xGGej/EIj
	 AtLRx6THYF8gunzJk23nupAtIlQ0O+ZeSJCEUjrRx5hHGUZq+2C4MZ2X+AXe3KpiGi9oh
	 StNlY9JhCTxPKcVOsWiQU+Sr72AN/BWi3B46vRUDT7E3MxiHy7LA7M7sM4ORmTa5TAAfF
	 6DKwoEMV02TpMo1lk5ekRv7PY0zy1U4PCbQeCW1fAIiEYSabG2IuJK4nDrdK6A1xSUm7U
	 NLvI/Rdr8lQ6rzxKdbGX9R8U9sHUJgO4p7m7oY+LrYg2L+/eBMLWT1s0qJS/IW7EiyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c7QnrtHM;
	arc=none smtp.remote-ip=91.218.175.179
Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DF60A261E
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 21:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D45DF60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c7QnrtHM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KJ8Xuzkuur/Mtlz2jvvLp3177Z50iWSACGW1WctvTBo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795122774; v=1; x=1795727574;
 b=c7QnrtHM/UPNO1wJ8NOHqAxKxhIl5yV/Ps/c+qQs+NfF28BH/udzCt2v4oo/yeURR7rPRGef
 FzmFwCELLmWIp1uDY4zwl3rdIU9JnWdOrbOFwjrnypyXQAJttsfiqdZmWanusC3vWcdYkFYGqGx
 ppOa+gfo+rifIu7u/ycOhWuM=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ca55b60b1c17543b;
	Thu, 19 Nov 2026 21:12:54 +0000
X-Mizu-Trace-ID: ca55b60b1c17543b
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rkeilty@meta.com,
	atish.patra@linux.dev,
	dgreid@meta.com,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] perf/core: Don't let BPF programs read an uninitialized sample address
Date: Thu, 19 Nov 2026 13:10:45 -0800
Message-ID: <20261119211235.99805-3-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119211235.99805-1-usama.arif@linux.dev>
References: <20261119211235.99805-1-usama.arif@linux.dev>
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

A BPF program attached to a perf event gets a struct
bpf_perf_event_data, and reading its addr field turns into a load from
the perf_sample_data the sample is being assembled in. The verifier
allows that load no matter which fields the event samples.

perf_sample_data_init() used to store the address unconditionally, so
the program read 0 when there was none. To touch fewer cachelines, it
now stores the address only when it is non-zero, and
perf_prepare_sample() fills it in only when the event samples it
(PERF_SAMPLE_ADDR, PHYS_ADDR or DATA_PAGE_SIZE). For all other events,
including context switches, cpu-clock and hardware counters like
cycles, the program reads whatever was left in that stack slot, often a
kernel pointer.

Kernels built with CONFIG_INIT_STACK_ALL_ZERO, the default when the
compiler supports it, mostly hide this by clearing the struct on
function entry. With INIT_STACK_ALL_PATTERN the program reads the fill
pattern instead.

Clear the address before running the program if nobody filled it in,
the same way the SIGTRAP path already checks PERF_SAMPLE_ADDR before
using it. Events without a BPF program are not affected.

Fixes: 7b0846301531 ("perf: Use sample_flags for addr")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1c1ffd103c74a0..57ea7e3c01a025 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10819,6 +10819,9 @@ static int bpf_overflow_handler(struct perf_event *event,
 	prog = READ_ONCE(event->prog);
 	if (prog) {
 		perf_prepare_sample(data, event, regs);
+		/* bpf_perf_event_data::addr is readable without PERF_SAMPLE_ADDR */
+		if (!(data->sample_flags & PERF_SAMPLE_ADDR))
+			data->addr = 0;
 		ret = bpf_prog_run(prog, &ctx);
 	}
 	rcu_read_unlock();
-- 
2.53.1-Meta

