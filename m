Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793320991;
	b=I5FEN1PGXynmM653ZDK22CJBABVN3Ux7P4iBlkkYdWN4+bCu8LCUuhKpttGdsBk3q2yc
	 lu+GPnVKbC4nThegCt1I0UORCk7/3KKduzcBaBvhiFxXZs/EbDbt45IOFBZTvZFpdNYia
	 d4vZu3UF2+LFecLxwXc6pOyEDwNihDWm+6j6NOKTiXK5yHDE88JC1W9PrgGBORTLG5wje
	 x4uKTEYJZeXTErduWTSY6ZXD7zhkzO9C8FKj8zXLlIuXL01GpxrT+PeOh8d40LR+BmC1+
	 8o2a6354QNTtkZ7Qtnw4Y1zmTkspJTssQsc3esVXHUYFtPtKnOW878pb0blAfxwesug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793320991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:Date:Message-ID:References;
	bh=A1dnHGd/ojY9RvLwvT0//fyZZl5qZJVT0RGCrdHRWvM=;
	b=KHQuJ5e9za0DcyJoyAbBV+CTxtIcGakNgWbA4JLtPjGd7aAoqzKa6YBRGMuKt01zPnJA
	 OSkwayYNUYd1/AgEF2xf1Kvzdzb7wbCz0c7xhx6bhfhmE9qJLbIFDYPRFpYCM7Wd7WHwM
	 9PxnLC5o/wLcWnUNZ2IiHauo+e49TS9q0BEymt0E8UMsgkWnQ8hlw/eQsfQ7phIiSiUxX
	 32bv/FetUbY00kzXhsjmCRPViAGComdHgoJpzVs6yZ9NzivVWGQ6y+N6YA3um8FuNo4uz
	 V8TSSFcqTheQ6PT8pLmABp4dHvcJ5OVyYiGjZ+E7ht2dntxGRjoZDIZup8IOOmkB/ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Aedb/NaB";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED6606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 00:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82ED6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Aedb/NaB
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15ea896ddc8so248810c88.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 17:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793320990; x=1793925790; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A1dnHGd/ojY9RvLwvT0//fyZZl5qZJVT0RGCrdHRWvM=;
        b=Aedb/NaBqs5TBd2NJHwP+yg1sFNUs4wHhPLWHezguaykBdn41/TV21W73NMixslw5m
         2Y3Cz47Gx8xmYjbMoMqw0MYfKhzWnTrJQiKn2T/zUhhIIcsQDfIUOtaiAA+mvI5DYJGA
         k4L1LVvbEOAWq3NxH5K2OgSYOZ6oy0MvLmNLOqYOsjfZFXEWqII8qHVQtHZGhaYtuhtz
         FU6rv3/IGHoHgP4h2Byn9Ai/oTcZXv209zimXpLsdCZ4P5eaR4w23v5pUGCzbWuQ+dRv
         7kMRorBeHbvpoGaYGvrN9SIfGkXNVXeq8KNQ+MYUfZhV5q3cPdfDv/cHZJnxtc+7PcbZ
         mSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320990; x=1793925790;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A1dnHGd/ojY9RvLwvT0//fyZZl5qZJVT0RGCrdHRWvM=;
        b=LiyQASWH0QEwukwJtNeGPpgeZkhGv/GokNtoOd5TlF16EjS68AAPZ0nN0J0psMHzPR
         yUP01j72zK6XV1lOOjv+ClzNZ1NvXe/hBq8XGGsSEn8pgKAWQXrc16eq1ORCPW+Pcy/L
         ivFAUi2gH5tW++JIZQ6ToR2Qnx1epW/h5xpBYeUHgTeFCZCDVEXPYzs8BAxVNqHDD/6Y
         A1J5RkN9VAjP1kbYngLUwYJlFCJ/AmO1mY9cO5I4D4M82IMfrFm4OrfZj0G1SfAy2q9c
         exP0JeC2X8asyI1BrTU4PP2MhFXIx4kQ1Z1MPidkJKnp+XQj4H8JpI79JHPPGU+RRnYJ
         SvJw==
X-Gm-Message-State: AFq9FYLzYSftg6BCo7K+gjHF8Q+GSJVmxLSbXjsmwuH23hGEn6GuDOjj
	6OomIdCilngx1321izfpmnv0F9PqO1fjbeOqe64MKyk8TMmdNs0S1FvajuKAKg==
X-Gm-Gg: AYBFou0MN73+0Kr25yLNEEKB9wHMYrzOMRMjPdtFwWE+RY12jOCyMJGclicRM7Du37e
	V6A8wqAHGifVgHQX8HADRN0t8qlb0hWeh3zPZ9vf/dLUpO2EBprVIdQ9cauqQ2dabaM7C/nvcxu
	2Nz/w8v8m+XgLui2oIQqZpeeVbYlr/mlc7D0AVhbPLJCw0Pu3n14/1jh0EpXgi37uXFa2oeCmmS
	WoGhmX8jdOskcw4xuGFBX5LxZghkzqZaAWQ+NSJmF6FYqg74iXN7IK0LdmSPJCc2kkcJc0AzvMO
	FtL+GDqepI4M82xFSLNIyvYc87/H2Lcp9yl98PejRZLYjVJiehCVjftIfPDBt/2Zwpv9onGudlx
	Z+mWWLdIknc3/FDsa478mhN2igxgw+LPvzW+xXIGK1GMfHcymOHwEujEhJkIry4AaRA7tpJgTTj
	GFS3G/0tXdrCSUlfMSsZquGAoCJYeEXnIDmOWIVoPS7h7gzk/2fgdnU0B2UA9zsXAgAAXlKOS50
	Ajrx+QtVkMLbBr3p6nfwel2soG7MLIkU+TYlU/gOP/qJNKazcjPGq0v0IRoQze33P+6y8hWI0zs
	SwbyOeyHNHTazomKpKQizIfwooKIbbV3nNkfreRVtUCl/rv1
X-Received: by 2002:a05:701b:240f:b0:15e:6541:3099 with SMTP id a92af1059eb24-1ac5a0b8b3amr917862c88.7.1793320990113;
        Thu, 29 Oct 2026 17:43:10 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm2097351c88.8.2026.10.29.17.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:43:09 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jiale Yao <yaojiale02@163.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/eeh: NUL-terminate force recovery input
In-Reply-To: <20261029052948.2525048-1-yaojiale02@163.com>
Date: Fri, 30 Oct 2026 06:11:38 +0530
Message-ID: <ecd8vx31.ritesh.list@gmail.com>
References: <20261029052948.2525048-1-yaojiale02@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Jiale Yao <yaojiale02@163.com> writes:

> eeh_force_recover_write() can fill its entire stack buffer from userspace
> and then pass the unterminated data to strncmp() and sscanf(). This can
> make the string helpers read beyond the buffer.
>
> Reserve the last byte and initialize the buffer so every accepted input is
> NUL-terminated. Propagate copy errors before parsing as well.
>
> Fixes: 954bd99435b8 ("powerpc/eeh: Add eeh_force_recover to debugfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  arch/powerpc/kernel/eeh.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Nice catch! Thanks for fixing it.

LGTM, so please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

