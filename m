Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102074;
	b=eePtmSe+1RI2I6gL33l5origGKKAHNpotTABJqaWFRflIdQBX64fzsBAMcU2Ox+abwVr
	 Dn1c7niumFEdAT/sE3LBBKQYoHSkNt/amXIhBB1ZSFNxKi1+gvTPmXHmn6Z5ZzWyiNSkR
	 KVFz3l+dehN8gkdeNWjE9bvo+qP/H1KSWPfaY49MoqwAclKv6/VSS5+t33jbkUR5mJDek
	 Fs61AgC77e7KviJi74Q+mnd2H1HHK2Kg0YUJ6uqsM8l++fhbEL00B2M39beqVPQ3EOhsk
	 /cm7KcfG2PEPRahSPzAgWLVZjL45awiy820zhVZYGRUPOhGQpx6Sp5qlItdQpd9J+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102074;
	h=DMARC-Filter:Received:Received:Message-Id:Received:Received:
	 X-Zmail-TransId:X-Mailer:Date:Mime-Version:From:To:Cc:Subject:
	 Content-Type:X-MAIL:X-MSS:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=FqxKvNg4kJimCwQ4aj4TQkIJ9sNptxO95CCUSsHG0XA=;
	b=Qo606jBrY9dG+q84bQ5M8wtnCGSR/w9esaHexKXJm4fVb5pCdZaNtb0dQHQiYmIg7Sta
	 idNiB0E+kyeqmgWuVxqtUiidfo1WKK7WZRdU8dkKxGJ2n5F6vVR4fY9U78JDrPhP9G5GW
	 VGMKFFw66yE/K4H4DiFIWgXKZkYZ8L2dZi2LIR6UyhFjcezuCUKQoEv+IY1A4FTV1gmuk
	 NceaUK7+W1Ex85NKqS6HW2rJvFPGh8z0E+e724SyY55/AR86Z9VppdNkNhEQXk76HBvzI
	 L2m1sF/tsNOWF721cOKzLWuJTtIjIg7+XhZpxZ2QqeON17NnQbc7wLYkjPkr7Dr9zAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B6606A31A;
	Tue, 27 Oct 2026 11:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA4B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jDTS040CLz5B13b;
	Tue, 27 Oct 2026 19:54:24 +0800 (CST)
Received: (from root@localhost)
	by mse-fl2.zte.com.cn id 69RBsOlq045164;
	Tue, 27 Oct 2026 19:54:24 +0800 (+08)
	(envelope-from lv.yating@zte.com.cn)
Message-Id: <202610271154.69RBsOlq045164@mse-fl2.zte.com.cn>
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 69RBlTX0050550;
	Tue, 27 Oct 2026 19:47:29 +0800 (+08)
	(envelope-from lv.yating@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
	by mapi (Zmail) with MAPI id mid16;
	Tue, 27 Oct 2026 19:47:32 +0800 (CST)
X-Zmail-TransId: 2b046ae08f547b2-3f5fc
X-Mailer: Zmail v1.0
Date: Tue, 27 Oct 2026 19:47:32 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <lv.yating@zte.com.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <james.clark@linaro.org>
Cc: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liu.qingtao2@zte.com.cn>, <he.yilin@zte.com.cn>,
        <zhang.cheng35@zte.com.cn>, <ye.zhihao1@zte.com.cn>,
        <shen.lin1@zte.com.cn>, <dai.hualiang@zte.com.cn>,
        <stable@vger.kernel.org>, <hu.shengming@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBwZXJmIG1hY2hpbmU6IEZpeCBOVUxMIGRlcmVmIGluIHRocmVhZF9fcmVzb2x2ZV9jYWxsY2hhaW5fc2FtcGxlKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69RBsOlq045164
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: lv.yating@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 27 Oct 2026 19:54:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE090F0.000/4jDTS040CLz5B13b

From: lvyating <lv.yating@zte.com.cn>

When recording with -j stack, resolve_lbr_callchain_sample() can
dereference a NULL 'chain' pointer while resolving the branch
stack.

$ perf record -j stack -e branches:u uname
perf: Segmentation fault

Fix it by checking 'chain' for NULL before dereferencing it.

Fixes: 29be60c93d2d ("perf build-id: Mark DSO in sample callchains")
Signed-off-by: lvyating <lv.yating@zte.com.cn>
Cc: stable@vger.kernel.org
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f86b3b7df742..10a88c070814 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2858,7 +2858,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	if (chain)
 		chain_nr = chain->nr;

-	if (evsel__has_branch_callstack(evsel)) {
+	if (chain && evsel__has_branch_callstack(evsel)) {
 		struct perf_env *env = evsel__env(evsel);

 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
-- 
2.27.0
