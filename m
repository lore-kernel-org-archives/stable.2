Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638563;
	b=oZSrXiuVSjoTNnU+I5cgwSVRmbLDWuZpwjEKsKzpwcjksAXwfuXN8hFUWPXUiGe0kvwn
	 0Dtucde6eSTvvTQNcF/WNjjGt90nm1ih98esRcH33hOqPDQAU8s7Pj1p/sFfg+hmH4XUT
	 dmzdLJSmz7nlQnhcieNPoyZfNmOcWjYWiGpPdHEMGU5Xy60SDAsOEKG8Oe1wHR+bBBWbM
	 Z17ehWdZnAo8sF9Vmk1Z/dO9QvRJjfhvIQJ7RYFgWFyQFxAebjDpsCr/rY6QzoLCZs5ZL
	 NO4Lpe4bOtVECctpJYAnRTOXfIidxOJtE4jNjNJBC2VHemMjEz3DxTOroyoZ4b+S3Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=l8Vm7b6mvicOGbNITWz8S9UqTwj9675iuxlFyNmsQcY=;
	b=UQTSnjbaKdOxGTx+/Ef1kTjAlXXfLPJuJffYE6lb9j21SpNCIeZHeGwJtaB/ilIULSPe
	 7eZWYcRKSsXmHHl4JjFmpAv+6cpkX9MCVT5xoBws4sfNZTHPjYplRfoQ44OY4ZZT/Qfnq
	 emcMfw1AfbpPxnTE95QwMJmHLsSKOEPXIUOrQxksYvoUee3dueSOkmO9Z/qUsokN2rkog
	 4NY/z1kVcJxOVNCeizk4aLLkxHaUaJMSZ02d7s3bWcAe8qtWd6hShkhdCg8W0Vymj2y0r
	 NshRhN1aZoobawRK/ldZAdxAbgoWEx7Ecp7dTJtPG+TxqNj1p1nuMIugvWPCxOvoDYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=faYLAvB1;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46394606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46394606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=faYLAvB1
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso4222663a91.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795638562; x=1796243362; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l8Vm7b6mvicOGbNITWz8S9UqTwj9675iuxlFyNmsQcY=;
        b=faYLAvB18L/VuJp3Y4kep9bswU0Is/J4eU3X+N6HKQ1Y6d/r0+JYs0W0pr2VhNogDa
         +ZuaoOV9m3L/8kPFTqT84PiZwSeNtYbLMmuK3j+JqzLJ+dbwiKMjzKbW6pthM1brzavP
         H4nwCnPlkkZ4dyHU/XQAy0qN5NS6UateiHim6uO+08KJdx38PdN212mRCiMbXc+mYQjW
         CeC17Lf2lHqQonUSHkYxxXa4BbV5ZrswAz03uYbFEO0YBKHnTlDQvf6eyQzDy1LBpYm4
         JIly3sSK9m66gwWCcH5HEspTuV+HNFuwt14CLXr9uZvYNscBYHn3nfEmwS+941Sga6Mt
         70vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638562; x=1796243362;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l8Vm7b6mvicOGbNITWz8S9UqTwj9675iuxlFyNmsQcY=;
        b=sugZ3rfR2L0m4g+XsNp9ZNLy/1cKh0cXA7xDCgey8IuYbUZjemD5wckQKG5rQdlcAQ
         cczYotlh7Co2Cu10aNQNSXbApRpR9M+JMX2yuE9luRIQX4HzMdWdV5npO6g+Tq5inaIB
         Qy0Qyy8KYjm9NqISxzOr/pm6YkRjDz6j6C/ZYI9OtXPN4DSjjcndsWdRkbVrcsS2uBja
         fYKAFmBuN/bBpAhaOztomjYt/3OJeBmfE2ZDAoHqkVARmN7q+A0N7qmFpDurOSa7CrpS
         90Ibf04L6LDYKqPxSKxhxBYH7LLsCl1wMH+/GeP1q32nJdBm+cKy6u3z2dDVx5vVlLkc
         n93A==
X-Forwarded-Encrypted: i=1; AL+hErGnLFsNYDu/6oKpuUl0pZC8DwTOQjBhonn79LaI0JdZqUz6jbl9aWHCc3UK/+WzTbaAIe6Bzcc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L87a/267Nvjm6GSR+BFsIKFvHCA5SFcqbz7iVIz6sUaIXz7S4
	X1vdk0U5G1qcPhR1YpB2dlBOixk2n/RDw2T78ABkIIPxAywaROwkW6LqLykdhHYkELvKiQoihlF
	rq1FREKgEDSIm24UE+v37TIuJ3beWcyMPz9DDhIPBMqPVXe1u8ZJS+uO1ZzXLAz4147/fSofHaR
	DLLd84wfMjjJLB4YfmpNbgaE+1BltK0N2u2VARL6+fZ4wgWc05ouyuSbvtJUjdfFDeqMUIjXik8
	wooL4+dqBRv6qrsJYQDXqA=
X-Gm-Gg: AZFdTZfhLPUEkRQcrYCUMNqFMmxuAduWxN6Qk82yHGSgfBAyVX51AzzpbZVgK5aT0bR
	csSWkoeXzMzKvsUOx78mAMnK57ONbA0BnYzG30Pqf8nioXSbgSjf2/6MspTwbCFWYDz+lSGtMmM
	kXf23IrfkVmFskawodkFCshtbsIdye57gQrCgVovNsPtJCKqDFepHRKEmGhy+od+MCOaPCnvzoM
	wmEYKzjOS7UArYmvfHqBFa30TJrzuUiqCVmzl6/l3VgWV4U31I1naM6qt1uzmYBZhjm5WkZwx95
	vKPc84TzO54kX86Stuh+ntgqK1auSYzdg99dnKojdmSFCbQtKmGfq18jC9zuR9W4cb6Eqt/xaiI
	iLnW4Nq4uU9G3GgWrpoHRQjkzrk3fOa5FcMGiUQ==
X-Received: by 2002:a17:90a:ec86:b0:3b4:889:883a with SMTP id 98e67ed59e1d1-3b41c9bacbbmr19118124a91.66.1795638561597;
        Wed, 25 Nov 2026 12:29:21 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41ffad038sm6179778a91.3.2026.11.25.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:29:21 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id A45EC3400BB;
	Wed, 25 Nov 2026 12:29:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] rpcrdma: Serialize notification registration
 with device removal
From: tmenninger@purestorage.com
To: Li Xiasong <lixiasong1@huawei.com>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 stable@vger.kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
 weiyongjun1@huawei.com
In-Reply-To: <20261124021842.130141-2-lixiasong1@huawei.com>
References: <20261124021842.130141-1-lixiasong1@huawei.com>
 <20261124021842.130141-2-lixiasong1@huawei.com>
Date: Wed, 25 Nov 2026 20:29:19 +0000
Message-Id: <179563855914.3954750.1491302687768867001.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795638560; l=523;
 i=tmenninger@everpuredata.com; s=20261125; h=from:subject:message-id;
 bh=K/W7Ttia59kCaqhW00kObD6UYvl0Cy15KvgQbFPRCIA=;
 b=K3KNfLNZW+MlbKg74QBHj05k2lRDd141UEooqOB2WaXr5NbI41rEq9YGVr/e2MQ8pyMpgsa08
 4c/z4AJoO9ABaP2mrNVrAEwbDZbx926CtRckrQhyMUoC7Oo+j0qU8il
X-Developer-Key: i=tmenninger@everpuredata.com; a=ed25519;
 pk=nZPlfTnkwWNTqraxDCv+eNh7JBZRFxAoLY1xeLR6zXI=

> @@ -187,8 +209,11 @@ static void rpcrdma_remove_one(struct ib_device *device,
>  	}
>  
>  	trace_rpcrdma_client_remove_one_done(device);
> +	mutex_lock(&rpcrdma_device_mutex);
> +	ib_set_client_data(device, &rpcrdma_ib_client, NULL);
>  	xa_destroy(&rd->rd_xa);
>  	kfree(rd);
> +	mutex_unlock(&rpcrdma_device_mutex);

Seconding Chuck's nit that you can mutex_unlock before xa_destroy and
kfree.

Reviewed-by: Tim Menninger <tmenninger@everpuredata.com>

-- 
Tim Menninger <tmenninger@everpuredata.com>
