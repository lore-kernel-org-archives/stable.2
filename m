Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618017;
	b=RBl8qa68RwF/8YUY/n073MwxgGoKIo7AcnRJC4d4bMFORQQWKnZErVOLRgK5YLtVrNtA
	 89cMi1LWBj8bvmhg9EUDfeVhE1o1lYfvhKk/29XzRGzhJdTcvDhnXfzKV1ir6TyuiHfFh
	 +rI7bTlBJH/YithqmpcmBD21GHLcjsr8y+t5WaiiZUV7HJW2NchyIhej40vRrHm6uQwPQ
	 HeUDksbSq7yyxzGY24H9V27vktwLYx7Sjsc1N4tGdYb/m4O5gDX7LgGyvJLe8nsPbhUQD
	 rm8UBqpKH+vBFwbjy93JzFEzzbgeL5TXPaZnFNpMmWI8xrsGfDvM3FlOuoHYkQp8kzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
	b=Qwd6DVnBpaqFHA9/sLwKGVHwg+iNwOojdyH85kvsFkjvkCgGOKhRP+ctm6vm+BLR745N
	 Z8nNNfDE+OjkXtu4tKl28jRGGTt3I4KvxdGazyvB8OW5PZrODBRIBQDETXZPcOfwwIxTj
	 BFBVFqPsK5qwC1Ox1BWA0HVKNsH1WjRiMcufupFkPjgiItRE0jssrgzCx/vc4AWgnmVdE
	 Rb109XAV4OyZQRE7pehrnKEY3KQWKSdfz/WXsigOptogXzWAGMuKOw85eGKK4wEs9kT1s
	 Rn/p7g3VImDU7rd93F2RwApgSEY0mdj9c2udtDj8WJajJ0a/kkzTDLxWCrg9kHDgN2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NrH6aB6V;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20252606A32F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 11:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20252606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NrH6aB6V
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a1947498bso1070854eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618016; x=1794222816; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
        b=NrH6aB6V18WdvAaTOTYu2ib/o3fJ3G04pmguQH+yPdqTn82Eo9//qh9iYqXbBLisDx
         CMU3fG0f7a1PTXKTWI1ryI+9KqeGmtILbHEzpfk9PGQ8M4k7bgMvRWiglac5kEgNrizu
         ITizSUknar3bqCMxA15U+b3wAE7H1E8/6mh6Zd186ILeujGUFTzblfL8010uYcnAq5gQ
         FYwmkTxWmZrsUXvjH/0JvXCyLvWITeNPWjt3vBl1zd7RzaA+KgtM9R2nH+JIgxWsg7VJ
         U+ymX5bkZDPRoUYS/kpqj/lNx+XVzqlWvJo/RTKNKWgXYCFeIhSx+EysUSeT/MXSiLHf
         XuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618016; x=1794222816;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
        b=iNxbwwy9vdyejTUWrVQ9UbbvS8b6AP9Sw7lPuvvAsokDSuEmwb+8QlZ/TKIe3dlYx3
         ZZLzhuBAh+J5p4ilmzuYiHdpDPPLy/2B762LOc8yRI6/BVSd8ZPotwv/7S4M7hLr92Yf
         dwmy8yPSjupGn+4/mBfynNIgh7wn1gwFNXpWav+tvTSUd2yRN8inGY6vaxHuvxqw+PRa
         C8WhZtyzU/Lu31+cJUmvIs2vp05FCG2jtL8fIffRxuOVxVw5tak9SwRcTIsl27/qjuKl
         RFyJBFyNuaeWMTcjPfzDHUxnf8Pw94/ZjhqJvs3wQUFKwsIfraaSXLP8v1zRnPSz4bOS
         iQdQ==
X-Forwarded-Encrypted: i=1; AKwUvBydWjHI6WX0tT45pFJ/h6+GDGlE7VWGBmwZVpAiarFLn/4QWLnFBIEnHtGwebcLXPiIm6OhUg0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hnaAW5rRf3Gm60XgS2B9lubslxbIWJb7jL4AsXhrMuR5+45wj
	kqW3srS91nmIKrSQufL8j4uroWy6hWB/gyKw+S+kstwndQpLu9vHnDbz
X-Gm-Gg: AYBFou0LfSBsHaxU6q9kx+w1uTVPfkwtXNnsaTB+XsAiWVjlfTHZbMRlZz8XJeF0Ex6
	f7nAkgNV/xudICDb3bxh6RFhtr9yt2JW0ZEv479cPWgUKu1EZ5a7NjcxstA3sVX/u88CE2PD8jo
	o1oQleQlM3IyCuiuS2dxEnR7iNK6as+v2QPWY0kvkopB3/NRl5FJ9nC9C71C3ZXg7NCWcxb2ETl
	ZJvtaRC1ujQs0Tx1eh3TXP50zQJ4budDi6fFeqwc/YwznRmhK5wNjuo6pb30Pxf96CwGrQckpqb
	om2aUeGVwvymSIVFsaxgGsft+eknZQZVP+xXwR43+lduBfW3AynAyYN0SHkLHbv6BziItjqtD2m
	c4DmseKqHY7O8uVUu20gjn2n1T4lOOLZtnPBFeDEJVhq83XEaFufqmOyXYuPufcuCe9dfMEa8iz
	6zrNcPlMO0ya4Q2NEAD2y0hlYFxj8XuxUJlhSYlV37Eh0rxkyVBRaqdbD2cAAi/nKHbDDMx0cu8
	72X1+Tj+AsVlfxf27n6Ryn9cE5mKJscrYmLgxKEDghYi87PmzgAr09olN7gDS3JHjJfNzEBbi2x
	YzofZe3gmCZnrH9q9JURnfyBCdk=
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id 5a478bee46e88-36a423f04b7mr23743030eec.28.1793618015928;
        Mon, 02 Nov 2026 03:13:35 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm42099651eec.11.2026.11.02.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:13:35 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v5] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
In-Reply-To: <20261102091700.253381-1-gautam@linux.ibm.com>
Date: Mon, 02 Nov 2026 16:42:12 +0530
Message-ID: <y0bb5vxv.ritesh.list@gmail.com>
References: <20261102091700.253381-1-gautam@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Gautam Menghani <gautam@linux.ibm.com> writes:

> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
>
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
>
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that once LPCR_MER bit is set, it is supposed to be reset by
> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> not exit back to the host until the decrementer expires or there is an
> hcall, etc. This is because KVM on PowerNV guests have support for
> native XIVE, so they are not dependent on host for interrupt emulation.
> Due to this behaviour, a huge number of spurious interrupts are seen
> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> vCPU exits to the host.
>
> Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> available (currently in case of KVM on PowerNV only), as the XIVE hardware
> can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> functionality is not required. This reduces the number of spurious
> interrupts drastically.
>
> Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> Cc: stable@vger.kernel.org # 6.8+
> Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v5:
> 1. Drop the redundant check for the presence of the native XIVE
> device. (Ritesh)
>

Thanks Gautam for confirming that.

The patch looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

