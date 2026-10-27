Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116332;
	b=FolJUGf3Yfj/uY00aiawAiH7U3K4CstfCZcKsFp5wRtEv6DA+CgIytuL08SZqJbJcBks
	 YWff6l9Ej2brLPf34TlE+96Q+lt90pmYyWyFYajb6le+k1j1Dhmd5HfB8o/jLNsBWULZB
	 ga+6Fdi6rO6w+iSxiVPfs10FEpA88rmzq1lGBXOCbSE+LcdWEuecFJN3eX5B4sWP6D8Iw
	 2cxbtqB0DWcmku6suGUAjwLcJOCNbf/N8t4CqmTrgYvhKwY33pWCsdMyriVhJ1QsvyY+v
	 fCDhs+kzrEGYQgO24UudcRN/SlNJmIFXbCTXd/nw5vB1XZho6h/FDRioRGDE/8TOW0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116332;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=jKpLRHkmcKldCCW4L2cmLxefzvN2OhCXfoHGwpR3yvA=;
	b=vGuXHgYEgUjIK6DuDLMFHG7/rqOfcEs4DX6UR4ASbYEpLvyHjMN8wJ9EDBM+09t5e1uh
	 ZNk7odsi1Yle377hQA7dGO8kQ7j4l3W6CNdDlIDXocPhYa5jTtRxgDzI4NqbQxFpdyN2w
	 cYsExPiNDJwA5N4wJYMgMVKtk3ePVGB2RDaZBd7odyc86Swl+aSaBV/eY+DOJubVkVBdP
	 zXOGOJs+h4Cd4TE4P6hGSHAlKvkHS7bHkhiViFDjq6UVCYbmrqV3zoni4iWAanERvpby+
	 wSElagJ1NFbFOvqaNJpgmFiT5S1dgVfl0GDcBB3JlTjqvHfNvFSu4xaaxw/No/rELLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F7606A31F;
	Tue, 27 Oct 2026 15:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 209F7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jDZkB6YD4z8Xrrc;
	Tue, 27 Oct 2026 23:52:02 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 69RFpsud015645;
	Tue, 27 Oct 2026 23:51:54 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 27 Oct 2026 23:51:58 +0800 (CST)
X-Zmail-TransId: 2afc6ae0c89e36d-542b0
X-Mailer: Zmail v1.0
Message-ID: <20261027235158456IYooqMRrdlV-tMROKicoN@zte.com.cn>
In-Reply-To: <2026102719473296875zO7s1T904dguHCkN5vy@zte.com.cn>
References: 2026102719473296875zO7s1T904dguHCkN5vy@zte.com.cn
Date: Tue, 27 Oct 2026 23:51:58 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <lv.yating@zte.com.cn>
Cc: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <james.clark@linaro.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liu.qingtao2@zte.com.cn>,
        <he.yilin@zte.com.cn>, <zhang.cheng35@zte.com.cn>,
        <ye.zhihao1@zte.com.cn>, <shen.lin1@zte.com.cn>,
        <dai.hualiang@zte.com.cn>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gcGVyZiBtYWNoaW5lOiBGaXggTlVMTCBkZXJlZiBpbiB0aHJlYWRfX3Jlc29sdmVfY2FsbGNoYWluX3NhbXBsZSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69RFpsud015645
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 27 Oct 2026 23:52:02 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE0C8A2.001/4jDZkB6YD4z8Xrrc

lv.yating@zte.com.cn wrote:

> From: lvyating <lv.yating@zte.com.cn>
> 
> When recording with -j stack, resolve_lbr_callchain_sample() can
> dereference a NULL 'chain' pointer while resolving the branch
> stack.
> 
> $ perf record -j stack -e branches:u uname
> perf: Segmentation fault
> 
> Fix it by checking 'chain' for NULL before dereferencing it.
> 
> Fixes: 29be60c93d2d ("perf build-id: Mark DSO in sample callchains")
> Signed-off-by: lvyating <lv.yating@zte.com.cn>
> Cc: stable@vger.kernel.org

LGTM!
Reviewed-by: Shengming Hu <hu.shengming@zte.com.cn>

--
With Best Regards,
Shengming

> ---
> tools/perf/util/machine.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index f86b3b7df742..10a88c070814 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2858,7 +2858,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
> if (chain)
> chain_nr = chain->nr;
> 
> - if (evsel__has_branch_callstack(evsel)) {
> + if (chain && evsel__has_branch_callstack(evsel)) {
> struct perf_env *env = evsel__env(evsel);
> 
> err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
> --
> 2.27.0
