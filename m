Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980696;
	b=3ILlxdrHOIMBfvnpeNcZLFE7YOy8LZEG5eZgvHcJp+tI8fKN0gj8ChqUwkt9Vw7vch7P
	 umMta8nXsi1QJkeTjDyK/QWYZw+Ei7HF+WeBktgYhNhUtrqmMnvkE2/4DVdSNcqyqIn0N
	 6h99Ci1ZhZumUqNsGsPdnovGX9dbA31MijFPrkrOykWAPxPLw/k6Kr5MKdke5vBmzBxFz
	 7UQlPXklZnVzgVVu0BaoB1xVIUsAQBEIikto66Z3413vRQjd9yPimGyGwc7TXxcPCWR9F
	 pYuXh45AexfAl0NXqxPgs02p/OZWn6rpkfWbau38bfK2HcDK9J2pD42QCNrrqlYa10g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980696;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=t0uNok79xtcOaBj7hUV1cORn4nx2YFub6xhgV/RBq9I=;
	b=mqZ0ueaPp7j+yElHd8ZCw5FX95PsdGFY6o0Gapj2BmQ3jlnqw8j3NF/gYPgtKSZxNYY9
	 1AaTi1+TvozjL/hqsHCsTjUUOZ+fU8Dah1Rsuvgvp029X/Q35Ja8hWSvmq70UVLdHqXZI
	 WuQQtj1BH8F8SaGsENP0VuQepPVFYRqtyfarJPourFpURoQ3MHu85LECiOLItgIAPZ0BM
	 tJNu50dHZ7ZjvJyUeUB+MABTE8WrTTwmqeXR11hv8gM5qelJ6owBOYX+AhCARFBcTlqlp
	 rosIAyMJ10Xkk5SgA5JXx9odTY3AuF1oG7XZSnV9HrnUL4aYj8c87z2oZMJp0ZfP1NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gWMGJ00x;
	arc=none smtp.remote-ip=95.215.58.32
Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E749606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E749606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gWMGJ00x
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=t0uNok79xtcOaBj7hUV1cORn4nx2YFub6xhgV/RBq9I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793980693; v=1; x=1794585493;
 b=gWMGJ00xOrA8SD6jvGCgs9IL4eTlb8JgU8LPbLLOas31NmgLp3l027Snu1NzAx9tdUum6/6h
 XvXv33Dk8mzhkyPEoJXCu+2HsXlBOgNHO7j45UVK2Or9A+5CFxh2y26hNZSaKyq1F0xZ2fWMOzr
 +O4Tta4aWpOQE0AKfQzx4qaQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6c3043eeb63745dd;
	Fri, 06 Nov 2026 15:58:11 +0000
X-Mizu-Trace-ID: 6c3043eeb63745dd
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be58ad9600so1375e87.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 07:58:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzZRDjOwlkKEg2hvKaW168c6VKN+NcU5tYzZry3Pb5PXvoO4A6IuyOpGQMmYq19d1GOAlNVWuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GcVJo1qTM1dL/ayvDaiDwBIfPb5KU65w5wfMfCYkRA3c+3DTs
	QEUN3JF3KVnFVgCogOjJG4/OhCxM1zQVFbJuETQZGvmQM8yde3+WLibYSxxSlncsSomKv/sGzaC
	3RJ4vnrjh+mgZ2W5Hub+DWmBGZ2vlfHc5eBOpyfAF
X-Received: by 2002:a05:6512:10c8:b0:5bf:ff8d:111c with SMTP id
 2adb3069b0e04-5c00a301a4cmr13851e87.7.1793980688227; Fri, 06 Nov 2026
 07:58:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106120221.347309-1-fuad.tabba@linux.dev> <20261106120221.347309-2-fuad.tabba@linux.dev>
 <1312ec44-bc4a-427c-876e-1405e8c46e0f@arm.com>
In-Reply-To: <1312ec44-bc4a-427c-876e-1405e8c46e0f@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 6 Nov 2026 15:57:32 +0000
X-Gmail-Original-Message-ID: <CA+EHjTwGOWqhdQxC0p2LBupLjKdkNbZEzGzWjS+ZR-XSbTBt+A@mail.gmail.com>
X-Gm-Features: AclHuK8NtgOFZkr3lcGennwjJa6alIz28AdxX8kBirDq8O8OUlKzbOWacoeokzQ
Message-ID: <CA+EHjTwGOWqhdQxC0p2LBupLjKdkNbZEzGzWjS+ZR-XSbTBt+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] irqchip/gic-v3-its: Zero ITS pages before sharing
 them with the host
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: maz@kernel.org, tglx@kernel.org, radu@rendec.net, lpieralisi@kernel.org, 
	steven.price@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Fri, 06 Nov 2026 14:31:56 +0000, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> We hit a similar problem with CCA, but not from a security perspective,
> but a functionality perspective (crashing the Realm VM). There was a
> patch proposed here [0]. The general consensus was to fix this for
> all "shared allocations" and Aneesh has (had different attempts at this,
> but the latest) series is here [1]. Do you think something like this
> would be preferred than fixing every caller like this ?
>
> [0] https://lore.kernel.org/all/20260820150034.88729-2-steven.price@arm.com
> [1]
> https://lore.kernel.org/all/20261104164555.3555725-1-aneesh.kumar@kernel.org

For mainline, yes. Patch 2 of [1] zeroes the memory inside
set_memory_decrypted(), before the share on pKVM and after the
conversion on CCA, so every caller gets the order its platform
requires.

That said, [1] isn't stable material, so I'd still like this patch to
go in as the stable fix. Patch 4 of [1] would then replace it.

Cheers,
/fuad
