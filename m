Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AE30C158
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791047124; cv=none; b=cV0Zbo0YvZp+vI5ZjFgqMYR+XcXwbM4bSSkqn7SBWTA1VE9LeGbph2lndy6tyn75KWpSgOx7xIppT4dIRiCPi/FqFs7MPWhMsgpyAKSlDgD14XP9Q9g5yeQEcH6b5i1hbCtQvDXDuO0sYUupa/ANQeL0HapunWKOUkDay/EY2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791047124; c=relaxed/simple;
	bh=GkuLv8sohC6Q/26XJMwu4gBJyw5znkiBZUe3IXWF3xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyiFieYlSuDeekIHKX6kC414oE9cAUCFioXeQXwXihCmX8s0z9E+BymbckpFsTleiQpDfaZ9Ykb2EFgVQmAsGV5ED807wId+kbTIR3Xlrd9oXCLDa8OioSQej1uFGpxLvLR1Z5xOcu73zW4fkO2xZ8RkQ3jbQaD8cXz4loB5e5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com; spf=pass smtp.mailfrom=truenas.com; dkim=pass (2048-bit key) header.d=truenas.com header.i=@truenas.com header.b=REb6kq1h; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truenas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=truenas.com header.i=@truenas.com header.b="REb6kq1h"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so6443965e9.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=truenas.com; s=google; t=1791047120; x=1791651920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V9/myqvD+Wu7dUPpez/fB+sxDbuYQxQUAR18f1smsBQ=;
        b=REb6kq1hDsn4cMgNteCzo1UW9/EGSRhPGWyShhvrwvgyrzfs+yzUoCStKb4B8YSnXA
         o6J5tkm+9EvkrQ9du/Ykrvk4wdMiDjX7FIbMAd7TvJ3GgJAB+CpTA/2ooaTqkOC4efJO
         pLSeCtLFXpSJgldghAGPFWQAHOiBXbrtbzNWUsNlb4CWvMmSYmOuM7Ya4ct7hG59Bs54
         2rcq0o1Gf6HNxYpgG1DQwwGjmVVA9feQ76X3UZWEqwgmFf1Av0qcVLDZbayFRsmTTfzJ
         mNx4gh5Adnh8biM2KwgTNp/ryZ9LOVZXJ5Wt1sruRhQC5DFFt6fWqdhnOhcfk+kLCudY
         FJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791047120; x=1791651920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V9/myqvD+Wu7dUPpez/fB+sxDbuYQxQUAR18f1smsBQ=;
        b=isA4OULzcVjaPmALlgDw4Qo4vv2jMwpBxCIWiNwq5sBTygooG7WhkTHVYfGa4P2RY6
         EFcRYdJ+w2fNh8fAo2hL6fcw0gUbo9icA2ZQYwjs9YSbgefy5gM8N/CRozA/QPcUbXd9
         nYxcmBqEwZyyehX5ajgbaNheniBl6aQLsAkTPUcTnJDGuFy2untFI6UyPVpVC8CYJYn9
         ffdPgWDcrz5xRlZNTNDzarUq4F6v3QZgb+Q1+E4MdkWQ173vYc445V0AUEFs95j09hY0
         26M0LynfdANT0GTHs86TX/5ruDHF8sXqbIi+dxMdMep1yETFTXBO68dZ5QXjS1Fr8LG/
         9uKw==
X-Forwarded-Encrypted: i=1; AKwUvByZ4KI8KdwuVcKzxsceV3clM4ElRQYZ2VuiltfEwgBaRSUem/WuOEdlFq30h1VwQmcJaLGAj/0=@vger.kernel.org
X-Gm-Message-State: AFuF++nPc7wTB+5htBpbq1FtDZ07uyIjDo9qma2xnMOEOrG3ZO4/jfc8
	cusqFgVqx5+aC84HegXZPq5t+q7dQD3r8CV/s3Jp+7rzFQfXHkBuXWv/wXtI2NMTww==
X-Gm-Gg: AYBFou1VogndoeoZ2f2RtGlaPis5NM1EdexMw7jaN1kWrWI67XKJ+YwY9nztnVeuwgJ
	VAPGqOxXOBL4BLbsbyCQ+ei1FD8rveD+xcsnq2u2BmhtKlw/fD6NiilcSWZ3ixR2WuzI+N9/axT
	ZQSfrp3JEINsLIIrJNoevW5p66UrjYKbkaw98I50bwhM5XtZw8ybtPXnqDMUdW4Oy35m+7bes0X
	NdKy0Mf/wdEPHO9Lga9uXfjI2AHeS8L3GFV9qqYq1+TBL3l6ck7mngCp7wHUM5rhW1eX0LtWt7W
	zacaSyREP9s2fbEeRi9ETl9Dwdx6Lpo4EDaTgU79BVqtR/udVyZoSCrJEt4ZTITlHqpZglSms3e
	lSsRq/wa63jfqeHeYmDMri/Ax3xRXEHAGaPebLjLD4cs6stlKAVRivImSEUI05wC2FrPE+xd+73
	ry9qKVzKkdWzy06rOx5h+UQtl3pJGOYb/WxYMkhNXVyGo1QcgKcw==
X-Received: by 2002:a05:600c:c16f:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-4a027594557mr93542555e9.19.1791047119916;
        Sat, 03 Oct 2026 10:05:19 -0700 (PDT)
Received: from hamza-PC ([2400:adc1:158:c700::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm177013365e9.4.2026.10.03.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 10:05:19 -0700 (PDT)
Date: Sat, 3 Oct 2026 22:05:11 +0500
From: Ameer Hamza <ameer.hamza@truenas.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: ljs@kernel.org, rppt@kernel.org, peterz@infradead.org, 
	akpm@linux-foundation.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 4ncienth@gmail.com, sashal@kernel.org, 
	alexander.motin@truenas.com, caleb.stjohn@truenas.com
Subject: Re: [REGRESSION] secretmem: SIGBUS on memfd_secret() pages while
 perf record runs
Message-ID: <asE0ctESLO306qYs@hamza-PC>
References: <20261002175651.811343-1-ameer.hamza@truenas.com>
 <3c5b9d1e-5ed4-4bd1-b532-39f2d4612965@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5b9d1e-5ed4-4bd1-b532-39f2d4612965@kernel.org>

On Sat, Oct 03, 2026 at 04:14:49PM +0200, David Hildenbrand (Arm) wrote:
> May I know whether this problem was found by
> 
> (a) A real workload
> 
> (b) A test case
> 
> (c) Complains by some tooling

(a). A root userspace process that keeps secrets in memfd_secret()
failed while perf record ran on the same machine. I reduced it to the
snippet in the report.

Thanks,
Ameer Hamza
