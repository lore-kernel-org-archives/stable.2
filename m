Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607973;
	b=11rB6OI888d6gJLbAbxD7yiH1LlVfgaETslw9UjnIt+CFB82Cn0Q5HjffVSkYBXuOHpE
	 q5E8FCEDYhZ3Aa72JonFmNCVj+XF40nsIbxa70sDGEdOfnUXExbg1pYITX8N0ymHBEOMZ
	 CDf6UikMZAmrvVt4GNz5ZducGvxI+vZMZvG2h/CJTScvSfOUlGmrk0vV4x6GgH/GB2VSX
	 UdjYHhiqFBZyQNZJZlDKg+hLPmWUMUHPmPqg0jxdprwYip3zpHXR7mmossBeAywbCeggJ
	 K9Gy05hc5XounZLevCVm4+dzTC6BlXJde+PQx8sGSQQmKJ1E48T704RDpz+2SkWYI/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607973;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=bIbjncsqO/4pvbgKTGgg9uQBds+FvcX31Fd72Ll9c/g=;
	b=bf79O+BiST75flt0izdapojg6hyKskG1Fsv/3oVR+9NH9E9A51lnCkDgShm8Fq2awEbe
	 0vCT3FpabBoJLWrYHp4qvo9HMnOTOW3G0sQ3hZsYRr5H8j7Mby4c24U9M0KPBja/bRXtN
	 A0M5qP/hD/AAviqRXSQ2GjSILjkQxwfoH1J6pjpDLQKOiRhBzoprp/ZZT+5VRsCuPOTDr
	 NUbnq2cRqccviNGCdvT//09H77t6oGuTWjPa6oMNO41C6CgyoYKRjX2dDZZT8AzQ3G/MD
	 fdYwscjbsLau+z5XUlrjMTr2LhAnk1jf0Al7e3IFMnSPCGZXOTJG7EPJaTT81SuKUKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=f3lix.dev@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=lbNhEsb3;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AF606A339
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 361AF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=lbNhEsb3
DKIM2-Signature:  i=1; m=1; t=1794607970;
 mf=PGYzbGl4LmRldkBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:DQQRm2Z7QN9G92r9Gkze+8AdqEyL
   MdFJ6nY7RJeIiGzKJbuqFWPS44N1xY1xVEw1LGPWJRJT9vNnKC/C4aw/A5Ty6wMJ7kfWLLOJU0n
   wLn1OfFVZTqlx72dsHhTZ4YHXSTqtVq20a82JDQNvvXsA/s4MnNCl2+xUDIaBQSt+/Ea80FSq/W
   zjezh7wO9G52p19Yovcp0i7P7OSMoa9jwxLVknV7gbsvpk6lXEPiRZVk3lDHbSQg1X+DbsKtma9
   DUiKpv2KERgtE5Nj+DuQONU4upIVQDENy0LO538Ai6XmEDcl3BWPcCrWfdOLOaG3MSWoVRZ9HuQ
   YvM23tDSLVohoA==;
Message-Instance:  m=1;
 h=sha256:
   a7+q3gKxZCuWENP4aUNwZ2r84GFElUqI4Z+SEsMKYnI=:
   7j+GxF8kRqQPdwxWg0x21hzpQno63uZ1HAcP7K/63Sg=,
  sha512:
   yarEuFoUG73Ww0NXDi3f9g4xvqcoi1Nl7KvK2GouGX6CsqVRcmbokOc1WYpgu10WtodlLPLcw7vWMs1WkJgiYQ==:
   vDRf4iAdpMorThC3ozUPnlIykk8PbYOAUGjzik9nP0qPTIGaP3WVTMwOhZ4N1m06jERjq2q6MJoRcBzWrjIy5g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794607953; x=1795212753; i=f3lix.dev@gmx.de;
	bh=bIbjncsqO/4pvbgKTGgg9uQBds+FvcX31Fd72Ll9c/g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lbNhEsb33ZGf/CJquxg9smV5wFpgMFqIDvbSPY7o8LqTQXjz/+lAmZDDW3cCTMf7
	 dGZZWukGvYPl/Ot1cvdoThdVlvEhxk/H4tMJpGp98cUeSqcTMRfuRQhKkxMmTTOVK
	 LA5vtpG49BSMjHJIiAV6ko6u2HtX6D/WqTDOLbbY01541QU5tY+g0qEEXvOiW/bFj
	 MoyGovK+IGj40HgdNbDZmB4ib9QhsltggC0ZLLKPCedLZQLiiuhHjnbjyjiWbZjTu
	 sOM6+D5EDEchVODpEOI9k23L3iMjqDr1af16QPKkF2rgpHp3e6qocjSnNGDx10C8J
	 zBNpFVuGj8aBWvz7Ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1x8XLi0u9v-00INGg; Fri, 13
 Nov 2026 23:12:33 +0100
From: Felix Hoffmann <f3lix.dev@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-perf-users@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] perf: Hold exec lock until owner-list publication
Date: Fri, 13 Nov 2026 23:12:20 +0100
Message-ID: <20261113221220.162338-1-f3lix.dev@gmx.de>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gfi6xHa+n0OvIvo97DzBHqBW6kyEB1Vsdn/83c2R/teVa2aou9H
 NI5Mzqdu0Vu0flD/h+WI4Hv5u487P7wqcCU/lCkNvGxQaX837x1P4JrEzD+b2xH35RhqzKG
 bvbQM4MaFcPiqHy6QUsjjSCehg7oI9jcebSfaarkUcwF8lRlNIIfQA51Gi2CWSfbGc5PMf2
 +d6BU0Q7iLMAMj7ti8Dew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W7egKwAczKE=;rdOReuTFot09TvfnIFb2qfJWUHj
 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
 j3vHFPGgafDWkCrkIg==

perf_event_open() installs a remove-on-exec event in the target context
while holding the target task's exec_update_lock. It then drops that lock
before linking the event into the opener's perf_event_list.

A concurrent target exec can therefore find the installed event and call
perf_remove_from_owner() before owner_entry has been initialized as a list
node. The resulting list_del() on the zeroed node triggers list corruption
and can panic the kernel.

Keep exec_update_lock held until the event has been published in its
owner's list. This closes the visibility gap while retaining the existing
lock ordering.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
=2D--
Tested on x86-64 with KASAN enabled:

  - on the unmodified current kernel, the unprivileged reproducer triggere=
d
    list_del() corruption in perf_remove_from_owner() and panicked at roun=
d
    4,400 as UID 1000
  - with this change, the identical reproducer completed 10,000 rounds and
    8,395,975 successful perf_event_open() calls without a BUG, warning,
    KASAN report or panic
  - kernel/events/core.o builds with W=3D1 and the KASAN-enabled x86-64 ke=
rnel
    builds successfully

The reproducer and complete console logs are available privately on reques=
t.
 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f5f2261f1fe6f..f4f292f7b47e2 100644
=2D-- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14414,15 +14414,15 @@ SYSCALL_DEFINE5(perf_event_open,
=20
 	mutex_unlock(&ctx->mutex);
=20
+	mutex_lock(&current->perf_event_mutex);
+	list_add_tail(&event->owner_entry, &current->perf_event_list);
+	mutex_unlock(&current->perf_event_mutex);
+
 	if (task) {
 		up_read(&task->signal->exec_update_lock);
 		put_task_struct(task);
 	}
=20
-	mutex_lock(&current->perf_event_mutex);
-	list_add_tail(&event->owner_entry, &current->perf_event_list);
-	mutex_unlock(&current->perf_event_mutex);
-
 	/*
 	 * File reference in group guarantees that group_leader has been
 	 * kept alive until we place the new event on the sibling_list.
=2D-=20
2.43.0

