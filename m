Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275488;
	b=toURE4cDg+41IgmKoPQLNhc/oP7odcVWwF68o1+fKpdTGuUe9Z+881fDgZfZ26mL4gH3
	 LcxuWqNaF9bR+1qy9+6LjdZeYbAuE8LqcV7VRagmAklrVzKLIvIuAASb1oKtzHoMOxjHZ
	 kvlOXZwZndjIyzzE54mtwV3amptjkd4xylS9lpO20XqJI6gg9tZfrpgVAhAMRhrwCncE0
	 LV4/X22Qft0yoi6D5NU2ajBBEn3nG0hq/5DhCizhffH7V1lae2xcvkAFDgaim3hsFdRZ2
	 Ss4fthe8s2B6lNPlWrlLfnLzVm7YqVF+c7JsyNK3cdeu4pqpJRpIyFt7zg2qJRNsLkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BfoBaMoCCGI4vvuBFtM++JU7Un6qYx/YS0fsp6MCiU4=;
	b=hHQVdquaxpPWVgZTcfzgpmdDXEtUC/NJnS1qk0X3HI83v+c+cN/CT4JLm2fbD1shQ8zI
	 T8De22Yqfe3cpH6XjkwtVJWJd9e19TqHeXCLxSU/igI+yLRxezWzOZq8huQnZ7jMaOR07
	 Zzc3FIZFC09xcK44PphSvmwmNmgCUKqQh0mRRIR9XLxwok1gudj8UNmfEvdn8EOBsBCnE
	 vGmRNAX8za++/fvZsEn900DD6Ko3ZF8bBYuo6+JMqxikJsQYwMb9sjDE6jed6MojqW7lj
	 r3Mz/3YAHqlrOHtAJXR6TLLjt3W8D58RGOZv7cxmn/zvPl+8lXBfe0mGS7qRtdSIfWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bPNRWH8z;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE271606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE271606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bPNRWH8z
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so14010325e9.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795275486; x=1795880286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BfoBaMoCCGI4vvuBFtM++JU7Un6qYx/YS0fsp6MCiU4=;
        b=bPNRWH8zK+xOEHgrXNYQ24sc3PAeDN8U0e7ZvQhjFEvBu0m48vLA6XUGL/+HaRm0g+
         PY+058LPxgLgU5PtOsgCGD0BQUlC1gFmE2VJKX6ZQFOCuJaC7x4Bc+M2BR1JVnwsa31b
         aMs+q/fjKr4X+t9FwzeW5StO41dUyt99EHYWol56HC5l7E0xhtcSpfwfdpxEXWkUQ/4/
         37rYEOpInOLXuElWRGOed+SnSVyh0WNWc/e/Nv4s0T/e9cdWSto3jBim8SZL+KgrmnaL
         LJGXfK2TIYcnwNzVdr8wWDLlFftjCywDUEraXtz2KaafnNKBcjCgFODpPUZkxiDi7mXn
         Uafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795275486; x=1795880286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BfoBaMoCCGI4vvuBFtM++JU7Un6qYx/YS0fsp6MCiU4=;
        b=KZOW9vJCFRq0IXtJhQpo9DY5GdqWBaESynZCXvWMqPIkeVcnW/FFNYlh0rd9cpAcrO
         U7U0T6PmAQF0wrEXZ+F2cmUWIBK2/L9T+JDlclp9LakEQY2l//lvnKH/I8HjapUrRWq+
         eCPBS/QCNAW+MCyYzXTm1mz8Pu0+TtWNzgZrPHYIltD7mfQNCoSEMH7PHs0tVORJP9OV
         UsrSxiSszf8yNm/MsIcPHJyJxqbKNTManl3L5G02N5KKUuatpztEvzN4hrY2RlJPkk2N
         THWxEhDnblICKFQ3KAu6G+X/4ui5LcDq4zcx19DBtj1aM3Oz2JZjetUZYUHffC6Sh5oS
         X7VQ==
X-Forwarded-Encrypted: i=1; AL+hErFXPfOIF5Rj0T/nXbka85LpbZ+8WI8rRI5jEI3eCTkc5TcsFMJZgAR8P/YLMJGrV6pUA6sO0P0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/lXXCBAU2KRQWO3oXLhtA75A0KgARUgvQJ5NswkFPGYK0QzUAB
	Rs/uTRv0lJveMzrgOo9OUNvHdZqzuSUbHTWpkdHeyXkm1MCStKJDNgUE
X-Gm-Gg: AZFdTZcBQEzOBTKGvgwHFXsy2/iM/CfdzRosXqTAhvGCxVjCsne+HVnc+xU/IIVYf+A
	NPgLM56N32loTrKO/VkAFiqYVMtvxVVrolMlDpa9LT/whwvlM4M4NQysbKwhJ0siFxh6s//6/Po
	lUBTP9iMhkS4iXI/7KMnXb/hLzOrY12SwWGwtkcKxzvhDrGzVE1oMfNKifYy2OFySe0J1EaD+/N
	75rsFBtduxZCWhOmG47Y7hGorUMfOEFpn2WTXMkhGZcXXs7EZWNcvIpPOvh0IctGnPzoLNbVEvZ
	+kvbUf4r9+yEAKfuo7tRoISnT8nmIveo/0J5Lof1DkwT5MJTOfG27PpLD0hGmLqNnfvY0/zjrZ0
	qrJwefy5iXqfwyxuX3z6v/lZdv3uhKHnTpn39UQEC+9uuZ0YIesPn1tW6mutRZ7Qms71DGJ1rsH
	cVKeM5iN0NTji7ccfrq2EIFwEWojffFDJAfaaFznEYmxDD1os6HIDz04Kjw4Y4+rXEjZ2Iu4oxc
	RcBBbhmcMIScz1I4MRu4TjoPZdhj7MIkkn1BaFM/KLRRP/UcDXDzdseTGP+/w/eeEDNEvTWVkM+
	Y2y4WsDfp9e17U2hhnssYXsND8q1l2XNr9U2UxmEmkmliWIcr3DV7A0OuUYZuB+yC0rWaAOxnx7
	Uc2a5au3gXxpKYjq/gDU+ofIj6jGxbLYKiECCZElBU3zgXk0q8Fe2K0l2yXoKkMnulphGYSKVUG
	L0ttdNOjjaQirwYEFTEptq6z2vwICyB2qe
X-Received: by 2002:a05:600c:5309:b0:4bb:62d5:4ab1 with SMTP id 5b1f17b1804b1-4bb88924a5bmr152319025e9.33.1795275485728;
        Sat, 21 Nov 2026 07:38:05 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-aeb0-6801-ad74-bca0-dc5f-7242.310.pool.telefonica.de. [2a02:3100:aeb0:6801:ad74:bca0:dc5f:7242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm254688665e9.13.2026.11.21.07.38.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 07:38:05 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Xu Xin (vivo)" <xu.xin@linux.dev>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Donet Tom <donettom@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/ksm: do not inherit ksm_zero_pages counter or PTE markers on fork
Date: Sat, 21 Nov 2026 16:37:51 +0100
Message-Id: <20261121153751.90695-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261120074359.41019-1-xu.xin@linux.dev>
References: <20261120074230.40269-1-xu.xin@linux.dev> <20261120074359.41019-1-xu.xin@linux.dev>
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

On Fri, 20 Nov 2026 15:43:59 +0800, Xu Xin (vivo) wrote:
> With the marker cleared, ksm_might_unmap_zero_page() will not
> decrement the counters on child exit, MADV_UNMERGEABLE in the child
> will not unnecessarily unshare inherited zero pages, and the global
> counter remains untouched.

Confirmed on mm-everything 758802f13004 with the smart-scan v4 series.
A test merged 1024 zero pages with use_zero_pages=1 and forked. Without
this patch, the child started with ksm_zero_pages=1024, the global
counter doubled, and MADV_UNMERGEABLE in the child allocated new pages.
With it, none of this happens.

The new check from 3/3 fails without this patch and passes with it, at
the default ksmd settings. Both tests gave the same results on x86-64,
i386, arm64, arm, riscv64, s390x, ppc64le, ppc64, ppc32, mips64el,
mipsel, sparc64, alpha, parisc, m68k and sh4 in QEMU.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl
