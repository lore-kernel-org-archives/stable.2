Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970018;
	b=lZub6BTvN+do5Yye+T9xvNbjJKPkPqsu+zMab096bgz3mT7tSIs3rDqkGb6VZKXsHbU7
	 IT+tV4dNdbjeyuYf/wnGK67cjPmJzqwNh4IvAIfisZAQsFCYKzKHiqDQ6nSrkyDbueIaY
	 2kvo4RPs1hv4XPoQ6/YQxDEYUC540wPDsKypkiy1sksknarRa252Y35wqGHr9lXBiVd6A
	 oDg0eADnMtpJC9cbml6VLCCN1rPT0sp15PzswwJT17ad2Oa9aELP+KhMZ8R2R0sX7+nXm
	 2khPWH4UrrOM+mQdWKWwNhkqtzQqugN2rnzm3cZmj9BTuD3ciOma7+xL9H9HvCPj3tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970018;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=CmVIaM3M0lQoS5Gw+xCsHIl1GWfVDNYrrM5ZXpTz810=;
	b=ZgoNJqLhOS+WqdfxMlhFnVdWNGM1wDEy/dSlqNawVbbM5eB+Q3mk2otbakc+eHNZZSx1
	 aEQjwAdW9bvwr3lez8uOUm5KVQrx4jj+ajDTyHSVEBCEI1aUrwUMlwttcc9E0dlAZ0N5z
	 r/aU7QfoTtF6KhLfKMehXlO2Ia/T4gtFq33naYg0Nzn+6jL/SMIt1E9gaAFdU3EONRsZv
	 LQSK6dGivKEB7dvxyeJudqiOh0nyj96QS9fk9CXIPuiP/jtD/P8m0/6nB5Qq3FxkIA/mv
	 uEVq7zBrRbQuDhEG8SvPn3K+mtXS/SAIzlBpo5NhTEuOiScGhVdkvc661M/2CUXLm5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ha0p8K1y;
	arc=none smtp.remote-ip=95.215.58.240
Received: from mta1.migadu.com (out-240.mta1.migadu.com [95.215.58.240])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C3606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E12C3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ha0p8K1y
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CmVIaM3M0lQoS5Gw+xCsHIl1GWfVDNYrrM5ZXpTz810=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793970015; v=1; x=1794574815;
 b=Ha0p8K1yHuybAEvJv8yQwMRBnFlRC4vfJvXdkuyzkn51lASZ6NcpUx+xyRi6kivVS1tdg3LQ
 TJ5tizkWw/SajFV0hqsU3Qo9Jb+weUWH8CDF25GrToblMbFd/v79ajADBJYF6dlVmDeX/mtJGUA
 eF+gBBL0AGQuaTVA9I0L6Grk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a4767ebe6dc839f;
	Fri, 06 Nov 2026 13:00:14 +0000
X-Mizu-Trace-ID: 8a4767ebe6dc839f
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bff701efa5so3743e87.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:00:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzq96TnIUeIMPxW9AGhgTtJ2yRXeT9u78nOZwoz7g+nopkBYe/Saer/3UJsr9TApheuxz0/uCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8H5o/lcbiEIzXt1h9FiNJbZWuu33+3etiS3yKVgeYjczaqty7h
	qWQGFho1Jwa4zjptwyXmA49/dXuIIO03MpT97JEAfNXOmHnxmf+GW/aqIexuECJiBhIaXZzEvFZ
	bRjhvp6f8yQ2NfcM4DivZVgt67oICEPe1scdaLnHM
X-Received: by 2002:a05:6512:2509:b0:5bf:c9c6:ae92 with SMTP id
 2adb3069b0e04-5c0071b526dmr56719e87.7.1793970013173; Fri, 06 Nov 2026
 05:00:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-pin-barrier-v1-1-04ebf118175a@cs.columbia.edu>
In-Reply-To: <20261105-pin-barrier-v1-1-04ebf118175a@cs.columbia.edu>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 6 Nov 2026 12:59:36 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxoNcx4s4L2DRXLu6VydiG2N3OqRYr+kscghp0jVVwg5g@mail.gmail.com>
X-Gm-Features: AclHuK-w8IPMfkMD2ik_GPs_KpCTf31_7nutwDTH3Csiea4URVFMI1--f_NjCec
Message-ID: <CA+EHjTxoNcx4s4L2DRXLu6VydiG2N3OqRYr+kscghp0jVVwg5g@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Order a later pinner's accesses after the hyp mapping
To: xuheng@cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Could you also give a case in the message that a well-behaved host can
hit? Since 7.4, two vCPUs of one VM can pin struct kvm at the same
time from the __kvm_adjust_pc hypercall (cf533b4d3630), which then
reads it on a CPU with MTE.

Either way:
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
