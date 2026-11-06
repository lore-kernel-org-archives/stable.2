Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973799;
	b=QQNsl2g/p0QJnTs1h+dvt+Wx+FgXjStSGG5QE/lIqo7Xki6JkFH6BTWG1rcea9mMdmYn
	 HtoAAgw5WRwjJkNrHiaEIjews3grnAmh4/5i/Dk8SrXo9VkAOLpniJnwLItMtqvnyI8YB
	 5jyJQhur5Ydfn4bBjhy2kQxSf3liyyCW3zL88JP+1Fxni8a08SGLqC9Mz6F+TAWj/4pIg
	 Fxo0mw1TRcWdaT/w2EcoQsAiTVXkXkZQqll7weZG/F100iFlIIFqzQb/rjHTEMsAS53jM
	 kdrpZErMXhJC11e2IBijM6ilwt62HJgz378gD1dZRUx0QE9hXve9IPt33P3psHlHwkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973799;
	h=DMARC-Filter:Received:Received:Message-Id:Received:Received:
	 X-Zmail-TransId:X-Mailer:In-Reply-To:References:Date:Mime-Version:
	 From:To:Cc:Subject:Content-Type:X-MAIL:X-MSS:X-TLS:X-ENVELOPE-SENDER:
	 X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=NB0Y4V8K19KZ9Mjs/nRDJQF2F1aefmQ654/1qRnC28w=;
	b=UphIAx+DtZImjOA3LbFVp/v0DTzZP6LL96wrkX6QoT4dXRa/8aw/g87mt4YAcqRzSJ5g
	 J6VkjWtGNHFQmiTPPirfnylv2up+F1DKtWG0w2wSxB3nD8V6xkA9v11sKEzj7/o2Uowas
	 xaATxBKZeLcuLvT1APnRIO01mqTthyDg+7NqIYHffq6F1LEcnfOyIxoFnp90R/CJmdQE7
	 LsX63tw55nsg7NrJlN4iRnULx1H1eCQYR+W7zYI5jDHQCwjq5ar6POddzqds3An/1Kv3n
	 j32OCNApAKZtEBBV96KE2ToyaBiUvPM0KQ7W/8N8TKLS4Jq8tyPMJAu/b8zpGPRfGGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7B606D83A;
	Fri,  6 Nov 2026 14:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E7B606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-db.zte.com.cn (unknown [10.5.228.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jLgqs3cckz501Rl;
	Fri, 06 Nov 2026 22:03:05 +0800 (CST)
Received: (from root@localhost)
	by mse-db.zte.com.cn id 6A6E35HY078932;
	Fri, 6 Nov 2026 22:03:05 +0800 (+08)
	(envelope-from lv.yating@zte.com.cn)
Message-Id: <202611061403.6A6E35HY078932@mse-db.zte.com.cn>
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 6A67xGYT042489;
	Fri, 6 Nov 2026 15:59:16 +0800 (+08)
	(envelope-from lv.yating@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid16;
	Fri, 6 Nov 2026 15:59:18 +0800 (CST)
X-Zmail-TransId: 2b066aed88d64a0-a3646
X-Mailer: Zmail v1.0
In-Reply-To: <CAP-5=fUbpxz9HQV+BRd62Yk+mQ5Bq-G3XvcK8ea3W8E3BqM6jg@mail.gmail.com>
References: 202610271154.69RBsOlq045164@mse-fl2.zte.com.cn,CAP-5=fUbpxz9HQV+BRd62Yk+mQ5Bq-G3XvcK8ea3W8E3BqM6jg@mail.gmail.com
Date: Fri, 6 Nov 2026 15:59:18 +0800 (CST)
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
To: <irogers@google.com>
Cc: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <adrian.hunter@intel.com>, <james.clark@linaro.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liu.qingtao2@zte.com.cn>, <he.yilin@zte.com.cn>,
        <zhang.cheng35@zte.com.cn>, <ye.zhihao1@zte.com.cn>,
        <shen.lin1@zte.com.cn>, <dai.hualiang@zte.com.cn>,
        <stable@vger.kernel.org>, <hu.shengming@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gcGVyZiBtYWNoaW5lOiBGaXggTlVMTCBkZXJlZiBpbiB0aHJlYWRfX3Jlc29sdmVfY2FsbGNoYWluX3NhbXBsZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-db.zte.com.cn 6A6E35HY078932
X-MSS: AUDITRELEASE@mse-db.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: lv.yating@zte.com.cn
X-SOURCE-IP: 10.5.228.131 unknown Fri, 06 Nov 2026 22:03:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDDE19.000/4jLgqs3cckz501Rl

Thanks for applying the fix. 
I've sent a follow-up patch adding the LBR test coverage to record_lbr.sh

Thanks,
Lv yating
