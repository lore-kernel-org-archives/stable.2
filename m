Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756682;
	b=LoxAHzvhiDL5IevLK3Td4KyNNyCBzWYBwV53Qx8pkWYHFJMLllz4LdrKhNbgnW3fXvKF
	 /EPmTbQM0vjmCnejy83iXPv4XmybrXEzBZhAcH+VttjJf2ARLhdMjw2h15s2A/4utzAcE
	 SazhvMfsASBrVE/lxGSwUMTiUIUGfnJQdIUeJvxUUDxTBfw5v7dLk84TDxa9JxLE8Hf/e
	 NVRGKF9EG4LvUXGuef+S/b/K2EKP3tZ8NR2ProLzAdMsn7M3Bgq0tnaUpQ/rJ49bjJK1L
	 KQMwYd199ZdkAh25WJ1LQvaMz1jsS03zIvNr2FyKMxouRt4WA6WMiarblNTP4OtyvpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756682;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ouHno9MQwl9g9I7VXxGGEQRMBGY89m3oWexuYnMaLYg=;
	b=n2vDZ4gKF0rQ3r20TPN7goIDuJMgeNsQcJfaRRw/mi3JPeYJ+th9TSue40v1MfIYUKOo
	 4HOjX5ayHBoG3yPRKX3KeNjLkOpBddDIcWIBqmz7vEOl2KIywdTjUQPGIxJ1RWuArFP3L
	 R9bSA8ldA42bqHLm5pYY3Ft7YNcmjH7YBg60pdH2W7KTkHUv7DgCGyzOzn8vWhZF7c4dX
	 unpkJMcrBxGI6h0so3cMc9QplPSd1pshguAM+z/TiaOvJLddxt3qWyPYUaZj6Yar6a+TV
	 4pjats9dlxzu4lk5gsyUAzPOI0GVB778j0uV2eJaDQT+PufLRBf+prJAtVU93ytsvAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NfrNZSom;
	arc=none smtp.remote-ip=95.215.58.124
Received: from mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2808606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2808606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NfrNZSom
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZidFtH1/LnObjsGNvMsrIN8j2jFRHd//7zJzoyuXcVg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792756678; v=1; x=1793361478;
 b=NfrNZSomapIGotMnzKQ141Ht8EqMJ7W3EZbPfPMNMiYjh/9bM26MPmLPaOm8MmwQClF71wJf
 MkBDifIoWcI80GYDyDYMxQYFiEBoNboJKcJBvTeZkfeKrkkQEpIKojg1R4Z+hS9N3OdZq3VqK2k
 ITnxZTYLpTFNFUlilk3r0uhU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8a40efd914636a4c;
	Fri, 23 Oct 2026 11:57:58 +0000
X-Mizu-Trace-ID: 8a40efd914636a4c
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: anup@brainfault.org,
	atish.patra@linux.dev,
	tjytimi@163.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@linux.dev,
	pbonzini@redhat.com,
	seanjc@google.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: riscv: Only fast-path dirty-log write faults on host-writable leaves
Date: Fri, 23 Oct 2026 19:57:47 +0800
Message-ID: <20261023115747.2545223-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017030927.345454-1-suunj1331@gmail.com>
References: <20261017030927.345454-1-suunj1331@gmail.com>
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

On Sat, Oct 17, 2026 at 12:09:26PM +0900, SeungJu Cheon wrote:
> +		/* Let the slow path handle host-side write protection and CoW. */
> +		if (!(pte_val(old_pte) & KVM_GSTAGE_PTE_HOST_WRITABLE)) {
> +			ret = false;
> +			break;
> +		}

Thanks for fixing this.
Tested on QEMU 10.2.1 with a private memfd mapping and dirty logging.
A guest read followed by a write corrupts the shared backing without
this fix; and with it, CoW occurs and the backing stays unchanged.

Reviewed-by: Jinyu Tang <jinyu.tang@linux.dev>

Thanks,
Jinyu
