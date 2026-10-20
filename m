Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512688;
	b=ZgTGBPZyG2xcGf3zcJTNVS0nbGAtEVRNK08Rd5gKbKHiQN29onOwq/kFKoMQ98dou3zQ
	 iSWOzPZyvzlCkWqcWGfE4rrdk2dvA4gnBdS19MEEsAMBdfunmEQXS7SWwuCnS+LrJ6oIe
	 xpDb4mNbrYGXKSAjMIjtpWO9omglHHQKA3gS8bGgGvrMijCjWL3Q9n+j9qG4WuY69gali
	 31MW3vAZJ+Jjm4JqIimjVm4IjkhhET/P6CQxp4mvkwPT4/CJhhxao/D+d7tyOKJTvot9o
	 jXfLskGlF+7sdTZXnYDYGhT5tSTzG2vesQshWvLJ3dYMaUWRznd8RdcXvhMPON3F1QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Message-ID:
	 Subject:In-Reply-To:References:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding;
	bh=FdKpeXgyqOVEtVxGXAfcleh4j7jtKB2IC4Gxgl29KOA=;
	b=M3T0AQmZlq7D4vC6I+5tcqf3S+UZxhoHbO0gmtyWwq1rzpaJPonIkGjgrPbWO6zUPbE/
	 eOFJH2VNiDTKJg5moZ/inGyHTWL/JSg8dY/S38ADIXkZqNaY7AZPh0oC8fhXObrz1ALzV
	 Gtg6aAKnAmMzkF0IEmYYvn+6sgeORqjwr9bwyzTnIM40dTrv0xv5kZSEX1pTIVqKqBYAF
	 H+oTS/zY3yz+YwFBTTCQ1YgqLpgfERV6P9oIUvVFZOsEicbYp8NItR7SDU9v6Z2dwKOFv
	 w5gYY1ntV9znJcJ1uUHEJ54XBrquMO61BMOXIwLaeGjdPQPigNd0dzTBmqli25X5+oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CuoxquBo;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61F606A323
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 16:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B61F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CuoxquBo
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3ac96ba6a4eso510517a91.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512683; x=1793117483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FdKpeXgyqOVEtVxGXAfcleh4j7jtKB2IC4Gxgl29KOA=;
        b=CuoxquBor9JijeH/KHLFj9U+Vm2XSz4NWdqU/UEtZjgpCp042Q+FKc9oHx5beK6lq1
         F+KUUtXSUbuywmeVZzCi0yNbz5gi8JlNgjS2O0aNWvURzdjmnVuATAaaAwq+6Kjaksml
         AkO1vHHkWEQTN6X3f92YpcaGjf9drKfVY6s4iCtH4vyEzUOpq9nk0T/VfZsIxsibvidE
         YpJA2Ei5PUqfCsQTsh8K309I8M5yEl96bwEX19Q5CvhXsbhaAgukW7JXAEUhOOb63lms
         C0nFzmcoYPivqysdbuEtoTRB4BDOA11gaNA4vkrMtArBxzfJjFOIZsgT3RoMGeo0VMVw
         rjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512683; x=1793117483;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:subject:message-id:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FdKpeXgyqOVEtVxGXAfcleh4j7jtKB2IC4Gxgl29KOA=;
        b=eCvHlB8mqrb/1AeXopjdccNValzUiFXGdUFFBByp7iYyYFCdwJVNk0X6h2Z0ORZZIK
         GX7+oETRSxIdPYACr0MzJM28JnfEijMIBUxPbAO4YlWV7+aeHxJrgtV/PWcrCzia4UeW
         tGIurYmbU5iMiSV0a2Bl24PD1lCgCfWuaGDRDolpr6tvq0Ql3ew4veMfgpmaNciePOrG
         7s7QsTpsRbCGSqcSzFdui8vOLjP7qdMUoYXqyw+UIMNe2jNGjlbNZtadKWGAeR0APbqZ
         iaZRISDRq5F/q5ycmdFDTbarbCW0BrYuobOeozM33WVksVBVE3yaLl+svNVtog39xMb2
         yOUg==
X-Gm-Message-State: AFq9FYI0EF/z10DpKIYX8uaiuMoeYnyfqkXx/QvNkZToisz1vYUQK9PK
	MnHDxCg8RjCLuAAJ2IyDhq6CE+rYJs5FbQUjOvmekosqtqZpUHPwv+TK
X-Gm-Gg: AYBFou3bCRVeEwdcl20Wp6PstZa6IC1GRY9a6U9H/a6K9u//MW0HpMVkSbyf5FUl6Rc
	gdCl630rP3Gj0AXPV9ez9omJuswVvGmEo+fyvnrYJk6gPh6RJsBbwdXkTr5dvjcT5nvY7PIeplC
	yxt/D0Hd3mI+A3LFAq0b2OK8i+ubNFUOjUy0SsrnQdbCLPbBl43lcALss82gEJa6hKP64MCDXnj
	gZLGu8SOIpOBzbImu0fQ8vGesfcpbmiDJ3LTa2koQ1S07kw2M0fmchErBesCupBcC0Lw1+qfdO/
	h57rFspCLVjCqBsT6z0TSVf9L9lxhnyV365iFnsp0IXuxTvqFOxtf0vaZ4tsPSqAnP8wZDCu1fa
	Fd6Xe00NxDAgOKg6CjDSMG4GgUB4ydZL1R0qbvTOhuLW6s/4L1vCXCy3Y3S+zrYQpcKobGjeKAV
	ybhetW3dxPiyhgqx3ZdI9lMztxa3tvrVy2lBjtfon760Nqr0sMFbn94Nt41i3/y8MuZv4EcTcsx
	t6jD4mm63tQbola0IWwzyS14qh8mmOTcK08UCjLBF54yb7UIMRfsFglxMjE0l2DgeWFCNde
X-Received: by 2002:a17:90b:5345:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3ad64bd668amr1739707a91.32.1792512682581;
        Tue, 20 Oct 2026 09:11:22 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9942956sm8903911a91.1.2026.10.20.09.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:11:22 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-ID: <179251032453.2.9019098760697634552.damon-quota@gmail.com>
Subject:
 Re: [PATCH] mm/damon/core: remove unreachable damos charge_{target,addr}_from
In-Reply-To: <20261020023958.108276-1-sj@kernel.org>
References: <20261020023958.108276-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 00:07:00 +0800
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi SJ,

> Catch the corner cases in damos_adjust_quota() and reset the pointers.


The patch looks good to me. I tested DAMON_RECLAIM stop/start after
filling the quota on x86-64 KVM and everything goes well :)

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
