Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363001;
	b=0IrQRhRCf2FzAWfhcFU14U+cp9Oc4YLdRYfPOgI7oM55FLSyiWvIzy38bse38k2WQC+G
	 BAuycIpRir0DqkPCmk/BmFztWzS+DOVR6a2/gIVrfg8zZjTjb9ey8z5I444VOYylkDL0d
	 s6fmgIRPA/jlXo0s8QIfF29GDyMCVHk1tBzLapF63Lbw6Y/y5tQv00PXznyF6bZagsoGG
	 RSvZT8VaaSukQpYjXobbUJv6FffgeO0v5Dk+VSf0r8jRxKv6ggq5gZJ3UXfcbvYqS3vZJ
	 DQxPmHvpnXJ99bgj+Ej9a67ZucY8z2fbN3pQlzGzoL6LntRbO/qA/Y94cKCgU2GJ81w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=VgqznfLD+AEq24VzpD10ISeNufFGoggr8PryRgVLhYc=;
	b=n9etCZdGIASgCw5zO2FMeFPdaKLlnq/E9nItzMPWhtJs0T28y0U97ZkzfXYWt2imsAMg
	 mF60nI2tk4nAN/NMPm0SPCgzVGzVLEVsggM/5n9XalmCPijQWUipVBGwDtErQQcVbdXry
	 R31hOiOW9h8+oQIfQ2Ia2BKkRtOoMtC+stCyQn0Zgp7kJIWvb5q7QhnLkrkl2PuPwIFPk
	 YLraz38Id5qtfb4zWgv2LGfTrj031MzFHGDgwcfij4yxA03B8oSrcH9RByFKu2idPjovb
	 jbsGxARJj9xFLhZXONFf/SEDRp26wBEE+afZpk7f1EBTphgeYg/z31KaN0dD4ecd41w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GzyEyjma;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DFC606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74DFC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GzyEyjma
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-94962d80d34so157106985a.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795362999; x=1795967799; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VgqznfLD+AEq24VzpD10ISeNufFGoggr8PryRgVLhYc=;
        b=GzyEyjma0K5BYbS86/HAgSYWYH50zuGg2h5MKfaBUXyvKqWz2b7AdJtZ9Uh1iU3FxV
         WIQR2ANul3qmCvQwSpbD75URwAbq1WQJhZfQ1fIRHRXGyQftU55KmR/Kjl+QieNohSCR
         9ssVFXaAN39tkoWQaD/cCBcjSwzj0GOr9X1FuVDuB1vRU5Hme+p/p7A/ww1PiZ3kk7Za
         dMwEC1C+jFZy7TXI+9Gbs+JtDMgzEY5jfdk5y44ZEn4K79SE1yQnBZKvxTfTr74IRDc5
         OTM5tkQAppVMsUxUPPRE/f7gYKXNV8JLIf7w0/VJtjhXN2Vq1Gfnrjch4h4VZhM0z4BE
         Porw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362999; x=1795967799;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgqznfLD+AEq24VzpD10ISeNufFGoggr8PryRgVLhYc=;
        b=Vlyl7dG65ZJEx9mkVEn2KWyqHHvFE0+RyAd2s95yhsYlmo6wBapWhQDdxLhzRfE+Dh
         ALnUVTQ8YVauUTvRnxDFKHaun1NErFrSlW0ZLk3XR4CDZcyuAm8nwabY3Mub/n1MiAKm
         camZCjSMZWJlpbUCB4M/LbMRQbdCn7yG9Kt7qXQdsIGdsPL+7TviCBm2fVMb7A43qkLh
         8v7WWMRrxP0iF+NBI+eZU78OZ8+448HOG5ZZGRF5QuTREIKWfgDJ1DrqI2T7z21/tiCb
         DVhKXRBCJ3aMH68z39/Ke+yyCq4ME5pL7T3qpy7mda1nZEY+FPH6mcKig7ken2tuq/JD
         iFLA==
X-Forwarded-Encrypted: i=1; AL+hErGfAnDEcDFcaqr/RbQpSdwLau6RCnMOc9AkbkYX+cwFSOe+rSduNCHq/8mePXWQ4Xow18PsgGA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f1zQiQ7I1UOBhXly5NxikyiHp5ua6hOBZNTDfrIoe2x/NgmeS
	0o+3cB0m/RYmsAGEXUMkfJykVKB9qkNx7SGtuyxtuMcnn+tCbzHg3ETFLAQrZbnIJLQ=
X-Gm-Gg: AZFdTZcGjTGHNzHy0seThetldKn08BwAk5j7BOvV5tlBa7DqSokznuazAPQ3xS+D/DI
	J2lleArFUYAL871kg7SKvf7uXCI+WLBcOSRPKuyNh+PJGXHbddo4CwVRvyINZubusxqZD6n8TOE
	HqvQsVSTMdqVcc/lonU7JvV81ZsmPLMsgiXM6xf20qAR+wHfv/x934MSlTpqAdvlZmrxk+zQrUS
	bpyt5VSO5VK4cU0mR3sq+aNNDjzbgpQtWlhH9vwmYaMOozhdJ0hDcaXxVuv9ZgQlhWJePaZNz3y
	qRE+DxRUunMgo+DakUgI3k1s8zZolErLLY4VhcXRqDgXvwqKS03VX/ndiftziUykSZYo0EpgHK/
	B4XIGQlKnXFnL/77kY94+Pr+LQRDGhWaQEtBlR88IiQj8bJY3rEq+RiwXTGzPH+2Lrm6aXiVx02
	BZKdJYjzQkyojqdHSoX+4l2EuRpj/AT2AYZiwacCxCvFkQfyFw/JBX3Y7G+64I4UZcsFa8LoRBc
	pXwN+RcfgZElwxvWk8akI6ORPvyRfznb4VMEuf6SH5WSoKfEtGvh065YihDgwzf/Y/4DPvWIVF7
	AFLVZtnYMNbxYg/jwM5lZCoHA3O8uMWGgHtIj9wpwRqo6GODiyXNCz4ABdsYax3GMqfZkDF+Rdo
	RrMtUNhM=
X-Received: by 2002:a05:620a:45a3:b0:949:6e15:e1d3 with SMTP id af79cd13be357-949ba8246f8mr1442513185a.3.1795362999210;
        Sun, 22 Nov 2026 07:56:39 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f2de5sm619042185a.29.2026.11.22.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:56:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/7] mm/ksm: only interrupt unmerging on a fatal signal
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261121-some-more-ai-fixes-v1-3-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
 <20261121-some-more-ai-fixes-v1-3-236e925d9b64@kernel.org>
Date: Sun, 22 Nov 2026 10:56:38 -0500
Message-Id: <179536299808.412063.10679914509257827963.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-21 16:02 +0000, Lorenzo Stoakes (ARM) wrote:
> Commit d952b79136a6 ("ksm: fix endless loop on oom") added a check for
> pending signals on KSM break, so that a lengthy unmerge could be
> interrupted, with the system call then restarted via -ERESTARTSYS.
> 
> However, it assumes that the callers can always restart whatever system
> call started it in the first place (the commit message questions whether
> this was wise).
> 
> Well, it turns out that it was not wise, as this baked in an implicit
> assumption about system call restartability, and it was and is not safe for
> mremap().
> 
> mremap() holds an mmap write lock over the operation, which an -ERESTARTSYS
> drops, meaning that the restart is not in a consistent state.
> 
> This was made considerably worse with commit d23cb648e365 ("mm/mremap:
> permit mremap() move of multiple VMAs"), which can result in data loss if
> you encounter this issue.
> 
> Consider an mremap() specifying MREMAP_FIXED | MREMAP_DONTUNMAP of two
> KSM-mergeable VMAs, where a signal becomes pending part way through:
> 
>     first pass                          restart
>     ==========                          =======
>     unmap tgt1 range
>     copy src1 to tgt1, move page tables
>     unmap tgt2 range
>     break_ksm(src2) = -ERESTARTSYS
>                                         unmap tgt1 range, which now
>                                           holds the data from src1
>                                         copy the now-empty src1 to tgt1
> 
> This results in the user observing a successful mremap() but with src1's
> data missing.
> 
> Without MREMAP_DONTUNMAP, remap_move() would find a gap at the start of the
> range on restart and fail with -EFAULT there instead.
> 
> Fix the issue by only breaking out of an unmerge if a fatal signal is
> pending, returning -EINTR when we do. This makes KSM unmerging consistent
> with many other signal checks in mm.
> 
> Target commit d23cb648e365 ("mm/mremap: permit mremap() move of multiple
> VMAs") for the fix as this made the issue significantly more impactful.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: d23cb648e365 ("mm/mremap: permit mremap() move of multiple VMAs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

