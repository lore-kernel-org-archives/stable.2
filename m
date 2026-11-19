Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077845;
	b=2z2noF2QXBlJdRkHC/ybFSIxoWoK+YrKF/iHxkzmH8arvsz5cPsJIHR08oiLg+sKpscD
	 KGSZFM+iOkCo5xD8jYU9eJL6Yw+7cy0ZGtG7YAJOwoBu7ho5YAaYqSKE3n67baNAr9ahW
	 Rcwhtcw6DK5waFpABbwW2FSog5yq//VhjBd11NqamjLbDaqZ5UHqMW+Bw6GuvEYw6Odgv
	 7UOeuABCgqD3lBhIKM+tILd65RWXwnl4U8E212Gtm5Q2kbW4Yh0iwKw8rqQIiB0mt2cVQ
	 snRFZql3a+YzYKtOVW+qmaiC7obJD8oEyL0/zSy331a29rGcAkPGLqjo91AuDISNxEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m3i+HRIGIUiqcgfax9l6q9GaA7Wh6NDEMTSkux3S4EM=;
	b=pNfRu+d1CUw0UPM6dc4xAvgyj2lmS355qa3gy4Q2IuD29mHVWeDr/lHHlFaiAbbxvAzS
	 fMk5/q3b/JlXmddEHXToMQavdYT+nPk+T0L01lUq0IgeTj6KsFe5lKDKwkZ+qu0DzCiL+
	 24KKxoBmsY3iKzCm1FxDUeoEODg5f1iIQBJ64hoAR2wm+WbzLfsoN0cPsWzvlxXhCHKJv
	 sJ8VeQ02CC8UAbnLBFmYaAVO3fMIx5ew0Vr1VzPN5+a9B1AZ4aXZo2FVCTlgT2h5Wui4n
	 0rSEY037vQT8TfIBM10+9r7vS0GqPvYAUfZhE74cR7GMnAD9fQSsLjioZkaBSFxAGFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slBPKnTY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AA606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E01AA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slBPKnTY
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b3a42a4bcdso1005822a91.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795077844; cv=none;
        d=google.com; s=arc-20260327;
        b=ThqTg60rE80ORthp/AWGK40TskgZWrxjFKtGiEq8jJcT/dxqOQIba8ua7qI4SFQkxF
         dN3Bx8rkL1HuDAd/EzsEaJThkwrpedWyHRpgu3Wy0e7Mne0etN51RrnpkITLa72N1R+u
         u56H3J1oAnncl95T/nwOJKKXuzA7DY3D9bhbesI9av9t+0ue8a3zRYWrwRyymCOj4XyT
         MdHp7yLvVxzUhKTZ42Tb+XNqGFzXEYj9zU8DR0f9hzpaej49HE8e8HIv4Ib2EMrw+LBR
         OakIhp4jS36oiF/nuoOgsyAhFdTw1Ma2lwXXaP1HLJ5AFfK1t6W7pBj8D0IKxitchTap
         GbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m3i+HRIGIUiqcgfax9l6q9GaA7Wh6NDEMTSkux3S4EM=;
        fh=S2L/LFjLOm4rrBD3llVaYpuwarbOZY4hOGpCe9oUF9s=;
        b=djZcGKeRzAUujYTd/gDTRcahc3Ma8aKRFVwfpX5PTGBiUJ1GpMSjc2DVp7ClT/c+t9
         /f+j7PXcbiqIxTZ76DGu2WN/1DDf1WebYRjZQ+/B6ck0EJpi7SVus4CsYcQA36HlGkKf
         Rcnq2n7HA6Yo3tE31zbkhZVCuat+PVEkF2oSSLdqo051+piL6c6itWR8yseeR3UGLRJ4
         Vb3XhONHVer7joZU3/l2NH+pLyOCt64ojHLM2Ft8WCzWTnWiQ1STEnd1furtKPZ5VX4N
         4hOvoNjOYE8YWxvorojLrH3p9cWRFKA1/se8GkK0296dKbeTzYWef78D/10/et0dxeYf
         zfGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795077844; x=1795682644; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3i+HRIGIUiqcgfax9l6q9GaA7Wh6NDEMTSkux3S4EM=;
        b=slBPKnTYaPqbmnDLJvwAQGK91gBcgN6CSXU7rKZQ1yh5W/cTJwQn3qoMuP4gxnvwDN
         gX3OBjMeJHJYN8XISPfWe/Y7RRfMCFX7CvRUFsmeJdkI701wO0REcJVcqSZX0JUU6aoz
         uklUbDz/QvKrOAon3wObPLz6DZIShtmyO3UuLyictFGRY3rdF7RkxjCTcWgazHXJyPAP
         fDMPDAlLtoru8MsG7loUvW6XyAJ1exZ5rRC7/ol8HWUnSYI1xXm5OBfHWDll7Qvua1eH
         swTfTi22sS8Xk3JszXt8iQOgwq478W74Z6zCAKZ6cXeCyckXuU8xBz4F1S6+T/slAUmC
         yTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795077844; x=1795682644;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m3i+HRIGIUiqcgfax9l6q9GaA7Wh6NDEMTSkux3S4EM=;
        b=GnCOTcG9RbDbad80egraMga6kWjbgM5KK181NLb4tUezeFvyUkK4irDW1SeMbB61si
         e/S7UEx3ESA95GnnCxwOSjYr2+U5SRAFnkUuB+I7sUKNAT6alMuYkLTc1ggJ64nWpiz4
         kulVcSz4GB/jw4FsSZ8AEkT6QTMhqS/mqInKMGpsZyXOPdmtV3V6dHFARXApq/SyI5bO
         YxzQ+QqWCDMv6f15fu2mdjznP5tPTP/xh6Ky6Qcgm6RjYWs4aQHs0xoZO1kLhb8MRox6
         j8gVCNxPqQaHl3c+JTOphdJkUNoIdcsjGC2N5LawJ5e+qUMqtZ/6V4NvIMwcfVJzoDKL
         poRg==
X-Forwarded-Encrypted: i=1; AL+hErGD/UYwhWg/WvoD3w+bx3TdmWC2FxALI3SXz6TLriI2epMxyEblNi6hf5W/zLApAxwcFcBazdE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VAcYiVIfgm0lgF7M3WI2Ma+LvZM9SnYo761zAKhKgmUf64Yoq
	aJclv+89jFtbCVLaZq8HnZpxCaUglo4oBU8c9+2FNBhTxhX8CMR+PSX9jj7Xym1agUppXF33i+7
	HKfH0YIih7o5RrsxjoLsKND0MNAxcdBs=
X-Gm-Gg: AZFdTZcpHlj5046GlLz/OMQ5MB5wtz82AohUt3x0qrU+04gkeXQnnSZtHntxuX++h3A
	3yA9FMqQOyr5L0vs+DmpVfNU38wLt5ltO3rG4OZwY0OLs3hsYRx8thVYJC87V+PysJpveuwSDeu
	wnp7cAH9Ku9hilSK+E2kzExEdjZ4ebCAnbjQfrgzCZBp6kPqy3Zxv1Zj39hWDXjTjwunRrYK6gM
	Y8gbs/QvFnAYQBiGbSSd4Ape4kI6oJBT4MKh/OFTHBxmX2y0h7aOOhi0mRlUv60/OLL86ZsJ9DP
	fpe+tYQmGmVv9kRC4lZsmuJIuYYKZdptrIwn2mC57urEORmBm6g28/WJFpIFhphUFEGs1FIQjRO
	btKmZwM7+lPvZuRxVrGZNNzxmSBZUwnXHi28YOOaJgwY4CEpR0ReSP0qmwa3UIB79tXyUMbRvKm
	ZIKJ7OcBd0KjvcDmBLnd8=
X-Received: by 2002:a17:90b:55c7:b0:3b0:ad59:7199 with SMTP id
 98e67ed59e1d1-3b3d07c653amr4418993a91.32.1795077844104; Thu, 19 Nov 2026
 00:44:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118150247.972732815@linuxfoundation.org> <20261118150355.645960710@linuxfoundation.org>
 <fd52d21a-34c3-4686-a9d1-099933e7cae2@kernel.org>
In-Reply-To: <fd52d21a-34c3-4686-a9d1-099933e7cae2@kernel.org>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 19 Nov 2026 11:43:52 +0300
X-Gm-Features: AclHuK8QPMFHYltRaH7S413ogSf_lQahbS4zUjRoVVdhquYP1vCMz_GsTwBswJw
Message-ID: <CAAsRjRmbj+f_v8d99EgGi_z_rfmw+0rnKN8Y2ZwuHarPKP4NEQ@mail.gmail.com>
Subject: Re: [PATCH 7.3 1913/2651] PCI: iproc: Use the EROM outbound window on BCMA
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 19, 2026 at 08:19:21AM +0100, Jiri Slaby wrote:
> On 18. 11. 26, 15:52, Greg Kroah-Hartman wrote:
[...]
>> +    ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
>> +                       bridge);
>
> This does not build on armv7hl:
> drivers/pci/controller/pcie-iproc-bcma.c:72:45: error:
> 'devm_pci_alloc_host_bridge_release' undeclared (first use in this
> function); did you mean 'devm_pci_alloc_host_bridge'?

This needs commit 39d1c645bb99 ("PCI: Expose
devm_pci_alloc_host_bridge_release()") from the same series. The two
apply cleanly on 7.3.5 in that order.

Best regards,
Semih
