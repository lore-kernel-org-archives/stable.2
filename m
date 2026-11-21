Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274875;
	b=t/S4K6rqykdrxiGAR8Sn00dcmj0ESrq8w0+wXii/BZrNWv5lX/iBe0FXsrNO853QnXXE
	 5GT6wilO+PO3rVhAJaeYtyqujuT7wNKOuM0YNSpDRYO9v1iY5ljgeadPbpRxZJNg16RPU
	 QQp+HtlZfGl8K3Yw8YXavDbbyQrd9eytqyrS5rFyosM6aiZqdB9r0KAmRvqQbKKlobLlV
	 7yBlLubjdzkoMe0/VXHPOxQjNU/lECGham0vNDNZlpz+wjEMJ0+sqkf+/m69WfwAjGIMs
	 0H54sKsHFyxXPZZ+I3T67SNjWTxceO0E4PL3dq/buz0SnAyJcGOXyskLDbB0bohlr6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ThWtfOsW8Ll8Oo+5oZsSvl5xz+7q6y9qiHMRLbQpMxc=;
	b=zdulh8HX5GX1Hz02zinHK6Opb6TrGhQ1yfrA1sddmfMf00RSTiirXtyWwcO/wWtznYKg
	 oOmaTP91TEDmIBBsfW+/hTDVpSgjAs2kGwilbMJ1q6TwMF0JSBjXeD4+MB8J5As2iD8oI
	 Kml+2zd7vj9iNN3wYPKY5dns3iQDlZomMHUEIaqYyb8uhFieFVSKOcmnZ9ep4Vxj//SDa
	 sYKNtvlYUCpXir2n8yYv6PH5KTZbSW7c0TtA/QanJu1yS3SF0YSHP4OTEM/VPIIHOkSZc
	 u3IA2wLt+3cnNIehNY+8grBPypIcUoY5QdZP6WJHHypbVyTqbIW7tMjcLQfiW9l5uTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrPb2QpM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E2606A330
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrPb2QpM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB341F000C4;
	Sat, 21 Nov 2026 15:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274875;
	bh=ThWtfOsW8Ll8Oo+5oZsSvl5xz+7q6y9qiHMRLbQpMxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OrPb2QpMNR8tbzIhr7bAPAk2LDW+CJLAymWEjI7DYbCGd6SpDx2SCv8c0EfBepSPB
	 KbvguCeReuYNf9/5VJxlSnn+KhIFPBpmXLOVI6PNx90Y8WVTwYUHW1s8X4Xu/4f1FG
	 GGjCOSyy0DRCZk3GPOeJTdtPcbp9YcI+wnl9YXAwh+ChUOgY8J790E8JaJfMcIaW9i
	 mW7oSCHmKsHJGQUGoHUsU0QO+h4KID5ZKfcMoRYvgfIMeYeRtqHxgTC7gEli/AFATt
	 sbzn9Mx7cPUwarDxpE+vvLz9rONxrHfz4zOGghzMKzs6Y7IDn6AeXMNoJc4Ota048J
	 ehnGrHZvn4dJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kpsingh@kernel.org,
	Xianrui Dong <dongxianrui1@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Song Liu <song@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yingke Xiao <inkxiao12@gmail.com>
Subject: Re: [PATCH 6.12.y v3] bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
Date: Sat, 21 Nov 2026 10:27:35 -0500
Message-ID: <2026-11-21-1-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121050924.97828-1-inkxiao12@gmail.com>
References: <20261121050924.97828-1-inkxiao12@gmail.com>
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

> [ In 6.12.y, bpf_verify_pkcs7_signature() lives in kernel/trace/bpf_trace.c
>   instead of kernel/bpf/helpers.c. Adapt to kernel/trace/bpf_trace.c. ]

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
