Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940080;
	b=sbvRE9YTI5sDmEQfmcM6xu1XtlSNLTx/TLQBa3ePhCV0OAtxvptVeBdT98gAc2ZI1HNQ
	 G8qxVwvLzFtbKDPaIvG68bbCqog9UNO18NrxSlwCSy2mrhgqbchmij1IDaMCj/CyWMZuk
	 OL7O+pQZNkYhCsX8ZHwuf7/VhmaxIa6mufmS6XDqBh2oeopVuVHZNlDzdBuQYl10n5uUv
	 NV96viZ1YROSN5kY6kujU/I1Z9RZ2CAD/Xuc2ogaqDX3lKpVhpW5fyltpe6eXg61o4L7j
	 m9IJFjsF6j3ejmpvqTxenqkiva+JOT6qkjOowXc4XQiQ2FkgprLd+y5vHZxEUXzAupA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4HIDElfk1fUBR+g3gRBqfDseCIheuM9kcM5hnFH2Y+g=;
	b=aWhnsiI/IIsMyTUA/ZEqctlXEt5RtcaJ5azkfuRCXycz8c3yBIpZ75A/xqRzDH3HyqKC
	 1MgeyQ9k4rhuIb4N7h3DJF+KFQNlFL60dzkLRh9Bu4jOqf/vUVS4KQHqmwRcgF4mHEFjL
	 tg33XK9YMkaK/cBJArumFEwpHYQSai4FQgatJiN2ou4DZKOPjP10t31Y/Mt4ajC5POZr1
	 BvbnbJ8Ot5si0R8SozOpngJRjQfxZIQiB68zluJpXHnIzszTNsIf0VDV7r5wQxM6GkEax
	 38JVz6bPJGG+FZ/ywjwO1FEZFeug8L9s8bb6bl42EfNkTH6M7NYYNX7njJB3Zb3bR/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=everpuredata.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=uOs3Ahgj;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B0606A331
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208B0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=uOs3Ahgj
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso127603a12.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794940078; x=1795544878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HIDElfk1fUBR+g3gRBqfDseCIheuM9kcM5hnFH2Y+g=;
        b=uOs3Ahgj9+nx34cROVVGq20lgcXGJt2vVPpnszE6xPya+N5tpyTvWqV2gfQ0r597kQ
         u7OsHsx+A7t/z+rXxrCwGza0CSjZD6bMOgOUg0n+rqq3U3M40TIKsaC2vgg1HqbNkSLM
         sRvpK2gq1/qjHMc/LU6b4IQKPPTsHsqL/nITdkzcL0HOh/kDRXL75jTdDQ8s3dEkGWGm
         CRnGH/pPh0XydxUFACuGxsOn/gdkqSXeTToq/fctuyImgwYaE+OkDZR8gLb36ux8ELL9
         sZiUpJDnJwu+QOgjCUagnIkqaS4xu2BIg/6ufW608Ooyjt0mYI1+38OhK2vxwyEMhCr2
         AysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794940078; x=1795544878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4HIDElfk1fUBR+g3gRBqfDseCIheuM9kcM5hnFH2Y+g=;
        b=RDLGfi5/qULpkidmxXS6BO4wVLW2Ms6oF0bRCQO6az8lGimhMF42xok5RKIvb9q5PW
         DW5XtJlDT6Y/xZxRE+BxfRHH1/VcRcQCVBZRiCT1+na13pa7jizDWzyC80HUJuI44eiK
         eN7R5t0K7eitNxZkg+J9KFBED4zXn5V6ujDAa13166QySk5ug1eG1uglfboMcmzjEEbY
         wwPE/uF0NSbgr/KFsfpA4iTftx2aI+tbh/+EHXnj/TMs7gdg9eO5cPuVn7T+f1UdzHcI
         Nv1NHImK5q8o9gOQuvI0hVP+iluxImGOD9cdGoURJtj0kTnLp/m/9djxY6alrJh5R0qP
         jxxA==
X-Forwarded-Encrypted: i=1; AL+hErHkXGAfqTeYeeeBUKTu9438ZsO1WJNbOCj55IT1u2hzJTV/z6zHIlqN9eDfc2o3LabFK6kAGVw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+95RvITm6RH+W5jK6c/CRv8PTJOtiXskk50C9uM84npHbXIngt
	OFPGF2k2+qVCQ5tQqCNYilDXmb0cigCPTGIube97b0Cr73K5dqYk7pL60NTpgcDUoF6g+5EbeHB
	e2h4/jyvSvG/V+d1w2r2eOPyEw3bAgPhmCjMxNrsq2fUQOvF5Qmp7PKPqtLb3WN9Me3De5umqkz
	C/tz9uxkUqaDmNkGtv2tVZAQQAFKKjtFsbPUj9iJ9oIF66dDqV4xf5kJ1ntVdE2zSk7DjYUklj5
	OzOQwfMBSCaYkoWh50I4i0=
X-Gm-Gg: AZFdTZcEmq9V89sr/uQDDWuWOoQiTMWibFsDXIT0DoLWxiElxiSt1VJRW7tMR5ZhF1O
	Z2mX6xXeV9MCfZwKnyOHzoJ+YMgbX3XFGmwZDaPJvnJjUvgBuX59EkpTEOLLBHPErwm6AQpGa/i
	nJlfZiy+x/v6xB05p7fEd84cGFxPOuTgKL6nvzVuDnnX7MXrGNZgQQNDu8rzMpKpBPtn51cWyD+
	mPryGJSd+1LCZcB8TRFK5JkzUzVkT0K/6KVa3vrl532F/wPP9tAYlYRW5kDrMXFQgY2UodzccEQ
	nHdwlEKPls76h7bp5IV6K2PqIHfmc8N84uO4S3bi3NqzzJ1jYnRP9KENsANAfkOKTbyv+QlA3Zn
	cqKU5PMsSwGP6V1PICRYibLnhcirAk3B/edai0zg=
X-Received: by 2002:a17:90b:4c0a:b0:3b0:934c:5e41 with SMTP id 98e67ed59e1d1-3b3d07aa71bmr289902a91.29.1794940078336;
        Tue, 17 Nov 2026 10:27:58 -0800 (PST)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3d0987ac9sm136956a91.0.2026.11.17.10.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:27:58 -0800 (PST)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 1C2BE34052C;
	Tue, 17 Nov 2026 10:27:27 -0800 (PST)
From: Tim Menninger <tmenninger@everpuredata.com>
To: lixiasong1@huawei.com
Cc: Dai.Ngo@oracle.com,
	anna@kernel.org,
	cel@kernel.org,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	stable@vger.kernel.org,
	tom@talpey.com,
	trondmy@kernel.org,
	weiyongjun1@huawei.com,
	yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH v2 3/3] xprtrdma: Wake connect worker on device removal
Date: Tue, 17 Nov 2026 18:27:27 +0000
Message-ID: <20261117182727.104697-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103032758.1302493-4-lixiasong1@huawei.com>
References: <20261103032758.1302493-4-lixiasong1@huawei.com>
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

I encountered a refcount_t underflow warning in rpcrdma_ep_put() on
7.4.0-rc3 during a pNFS flexfiles read workload with one MDS and one DS.
The trigger was restarting the NFS engine on the DS while reads were
in flight. The warning came from xprt_rdma_connect_worker via
rpcrdma_xprt_disconnect() -> rpcrdma_ep_put().

With all three patches from this v2 series applied to 7.4-rc3, the
warning no longer occurred under the same test. This test did not
involve removing the RDMA device.

Tested-by: Tim Menninger <tmenninger@everpuredata.com>
