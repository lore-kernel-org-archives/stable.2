Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625626;
	b=teg1uX225oCZmKmzOVlcri3/w30p2V05mMNnEGr7MSBSU4rh9uxGRivmSnMFFLTh25vs
	 5w0aInXYdw5Wlvng2CErPUCBKf6Roepkuokrrm1JhThDCN9hp+P3RLFT3WnVlgWDnJocH
	 ggNNc3hHWgibf5MJzmuPuSFFb34TYf7OQdptWhRuWhupfiRwN58NUV8t5ffanL9RtSAjC
	 T5Kmwn5atjaObnp8rQMNb/6B9kILxNMULu18uge6TgbGRhyOnGvY+9aT/zE2FgWX1TGcV
	 8/EgQtQ9Bs5NCZLu/0MImZQK00bwh35z2uglzJYKLgpyxDUTkb6gDk0KfNhyGFWMt3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=y6I1kRVE3hYZ2coRRuOSxwgvieaP/RE0STxbOhAoLZo=;
	b=Aj2J2pxT/3CR6EEM+jcZn9MkRUJWa2ICVK5CS7BbJlW6SeM8ynUxl/N2WgWWozG5LGf4
	 czr/IdwAK2a+/XteDUffCvGPC870rt9JjpSo4XKYtm6hG6JUtiZIJVpfslqR0DCN/NUsf
	 0Ghg5B53hZeaUtfsQfb77qb9QwsdUwSTi+rF3JRi2pK0nr3tJRgJD1gIHwBEPQYEquVHq
	 ktyc/vov4OPKczsttHoyv+A1ztT5gAGn7DD4MX7xEINsqw8W8ee9IruK9x57SAkAwadO9
	 +spr9YTveKgOrxBVFKZXXMJ/A7TD2wubBhuBSRBQSW/3eUjorDKOmjGSe9l4XeoEbRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mvista.com;
	spf=pass smtp.mailfrom=mvista.com;
	dkim=pass header.d=mvista.com header.i=@mvista.com header.a=rsa-sha256 header.s=google header.b=hGvI464C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C99606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C99606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mvista.com header.i=@mvista.com header.a=rsa-sha256 header.s=google header.b=hGvI464C
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6df5e315bd1so4867613eaf.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:53:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795625625; cv=none;
        d=google.com; s=arc-20260327;
        b=I1mNtaUaChwFMMjTEEEfV3sY3h7mvQ/dT+dLlXXCxoYvqWQvjYHKxq0zzLLnKOgGsJ
         EFDFWytp5CILK8pHeblMmjZfeMVKaU9RGsVRp9PPFpUuLrPE9BYsEGMMiEl8d4kLAmXC
         /dfBfa7+V/8yK7EFrM6oO+WihZeQxRebczxwTTfgnxCIIr5CzkbqcpTXyfN3ga9RWrKy
         4RYQyIUC/s7qmiCjqZEh7emHWUQ5HUHI1KeN8gp+r+4NXkamF2ahPad9Ohe8zk2NuZTH
         iurY7Cw7AS0+V9LzL9w34FnS74aBdHlVydDyXim2DWC3WSX6z78LXkoJFpAWepP7JWmB
         w3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=y6I1kRVE3hYZ2coRRuOSxwgvieaP/RE0STxbOhAoLZo=;
        fh=mhiiaK9NNGhCN6GgfHLjkMjzBIV/oRn8D4kEi4Ivp2k=;
        b=OplGiv4VvMNnhPZwWtqywwz6VmjUjvvIeNBkUZLXZ5DDiuXKNssSw/2CBaslIHZAMR
         IyBNTDzkCVY+jd7fKXHmu88aMoPzYLY0AoLsqQvmGjXbrsw5uv5Zr44ohndW6gt9ZPaO
         BDqNEFxYn2l02Mimou98T0tpe6B8GPLksDsSl6pet9pCT5s7/Tl11dOeMngq1PlEz6Y8
         NCoVVvKTHHdjnTAXmJEFiRHg26q6eacYnQsjMIpJTNBqrzWuN931IEtus+IATjoE1lzn
         CLJlWFIBkDqBKJ2LSoLGndEe+nL99rsyw/qi0Kh8EbxNgJhYoeAU47KaqFufvSKLCkF4
         tynQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1795625625; x=1796230425; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y6I1kRVE3hYZ2coRRuOSxwgvieaP/RE0STxbOhAoLZo=;
        b=hGvI464C0AxMtsNwh8cLAAu4p3H7ClkR3ytZXc/mKpA0QzHvuG+GZYRVu3n8G951U1
         vG+vuM5by22tMC2Dm/jv/T03XUl9jPxItlYxccXA1IpAn02iOOM7ar0zIL7G3yeZlwdZ
         QRYPIYSAbQJwTRCMm6K+6KxmdjmwytHw8onhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625625; x=1796230425;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y6I1kRVE3hYZ2coRRuOSxwgvieaP/RE0STxbOhAoLZo=;
        b=qDTfV7nsVwWEGwqGlxIInOL+DEJMtyQwvVU2x+onHG2K/S9rwyq8ATpQxO7kVD5WN+
         uxNJHmB23IRYRw1bWD4Y+MpO9uQ5C794S1E4+LTfIpvJ/Dn3EvaKEQGfNuenBAAeJ/Hu
         VobG0SygPD5lJuV+gRtwuMyFH/cuUPC0XJ8qFH6NavMKPacjCeMi37mZu7knZQnrVEVI
         y98y0YXIPVYckhTFJm7aGitCvxc9Fn/bDYdJq4lqe+nCyX6V6T22/+j+usmTyDAbDkus
         pokXShACsiMPjZ+gxWavb9XGvdr/85eyhZbCS5dgbBO+xGwFYbGdmZCPpxIY4/N86jom
         cskw==
X-Gm-Message-State: APuU4Z9aIDzaVEAj4hA91otphnmHDP+2uy6RTA1UvxluNaJR5WM/pp8C
	j7x95pEhsgO83iWH+P+j35U2oSZJ0oMsJ/I1RcCt9dhJgQZ/q2ZcXD06RS32F/zoDYeXGovcAQB
	QvMAOWxEnAGA708+XxmJ3siM7DJq4kx9feD6rcHR5colupGmEMUBW5kc=
X-Gm-Gg: AZFdTZcDrNfhc6y7bKKGlpONMu1hJRrW4GjnZZLn4GDM1sjCdtD/h/+kACbB1IcubhD
	Ec5VL2ZnqCM3JvT1I93aa49t7320NlYDHGFvTC7xPGv2PO74L6hR+tOBdAIJSBmAykeQ6vb7bFi
	jV3U47CLgT2y4PT1/Ud02OkloRLTSmiSrFHb/nuuWfAK9wL9OC9Dv+l4GEG3gRD0fXp9BPyPXKn
	AHuI2B5vNGrYT1be6S941ejrrxYbOdl/ks+1lD+RqMUdpMhJU4QrP4U4hhGeHWGPrvP/g8+29m0
	b6xEctqRR/9ojOKsRWaKKJX/EYWbd4eSFU1KEudJ66GDsiDwAtCnKolm0tPalVr2GagHgFdSf36
	n8ctcNun988PtQxaEzkRCrqcdFKQnif3/rBzSIpwnBhq8Mix3+re4oz+vz9VkppWFuNXBrJalJX
	arTAbb2bgSi11KYuu+pzvk0F1/
X-Received: by 2002:a05:6820:618:b0:71b:5db3:f1d4 with SMTP id
 006d021491bc7-71b5db3f385mr9217242eaf.34.1795625625087; Wed, 25 Nov 2026
 08:53:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Hardik Gohil <hgohil@mvista.com>
Date: Wed, 25 Nov 2026 22:23:33 +0530
X-Gm-Features: Aa3M54rhm3iSfm_qbTVwPzeEG_EzKfrNYRNDVI6X7fgDH5zljBqKoB_sTfZt9v4
Message-ID: <CAH+zgeGo9V_DRG_2yRAEw82bk6SMsV_JRxSOM28p7q02oTKE9A@mail.gmail.com>
Subject: AI tools for CVE backporting/Fixing
To: stable@vger.kernel.org, cve@kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hello All,

I was wondering if anyone is currently using, or is aware of, AI tools
that can help with backporting kernel CVE patches or identifying and
fixing kernel vulnerabilities.

If you have experience with any such tools or recommendations, please share.

Regards,
Hardik
