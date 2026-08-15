Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3B3F4126
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786777187; cv=none; b=pI1lBlwhyS/xsr/QFoqq03WlfazXVLCOu+g4AOIiieMNqgFEMrwN6MC3s3HqGLWadeIF4dVE9x3iJxekqd7xBiTqpcc45UJwJ3E05r8entm9tQ7fnEPyyrMwXNF1MlrkYPCvTieuYn3CDNpe1DBOqmMtmcqd6fjWFL5r6it9aFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786777187; c=relaxed/simple;
	bh=2XRsYUoPzYnatPTvcy6y5W3t3RWQ5s0KpPGVdws+DbY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVY7dDXUkRXF2q3y+Xni3OSgKyOPqG3ehouNsNtHS2F3s/H8PTGY1fPnGxOwMbmR5AZgC+z5Ol7TDdCQ9gf6x1iQN+HEmUkefHhpSEMYLkpFwQ2HDM889eOXwcAEVzwcLjod+kEsUX63ZrEkq50NIWra1dcoHpiNw197GyfIYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMH8arRH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMH8arRH"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e0688b859so146231b3a.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786777184; x=1787381984; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2XRsYUoPzYnatPTvcy6y5W3t3RWQ5s0KpPGVdws+DbY=;
        b=MMH8arRHM2OKYrulo38TBgFRWRLrUcul/k/ue8uqtA/JKxBxUqcCi7X9dDRc67gT6C
         UNEZc18VB0of86YVRTcJ05Gkplon0I2Mzke/yQSkxInnFxt/Vxcdl7RCYr+eSZKJe+KF
         Jaq82eKNmfJSznGatBnoQli/5bsfUzn4WtXu6Shu1yadikfY5oGUaZ5TeUV+NRr/xfmC
         i2IWDaZPPUgUH9qyMO6ZARCBE1PvQocoE0HTurDIO2vFK8yoV1ABt1hgCuQ2g5LUr4qf
         VytaAaJ+THPXpU1l5YV5eW1/hWS3jkYSz2EdnGevZa+3XPe8nQcf+jkobwPU7CEKZ11L
         kwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786777184; x=1787381984;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2XRsYUoPzYnatPTvcy6y5W3t3RWQ5s0KpPGVdws+DbY=;
        b=OAfN/ObpGHTxlEIhMMiImGJYCp6rET2TWHA2FBJypy20qA939KDSBu79w5pXbhewmp
         4YNP3GoLvbHMHVVfdVEqAun/Rqh2PiBv8RL3H+dNsR6Q9GUut0qmqvadvyT/7JffJftU
         jddAIZhqxyADT8me0vcMJCRjPNtBXYxo60NjK8M/81wbSzl831pzNWBHO3JGC8CKEbN2
         5ta+HcuWNC560ZVIH1rgTV0aq+AMWnT75iMUpIcOKWItfmkx3ws4cxCojQ3Ye8FwyL0g
         W64jRgTaTbD5ZFmsLGvdDR7AM3TgLPk4++2oYWkiQ6JUvAaUZ4AOg+qaIrjOKHfjcaxp
         FDiw==
X-Forwarded-Encrypted: i=1; AHgh+RqCB9MDWgynaSr3B/DhV5MHw2j8XXBhOLP7eVo67MqEMpEG05v/TrcWnSgw1XJXspRLZMi6cEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAhl88Y7lyafDekjWyCbAcgHY5Evs9pE9JHg3o+GkmiylOYMF
	3FWWvWZuYVKI9Xt2DOV7amoSVrp1gtzroErOaby3BmAPk6uDCREz7nW3
X-Gm-Gg: AR+sD13XBO0u6r9ISITWTyBD0b5jUyKvBBK7X/+3y4dxFfDR50L75Bm8ySL1+kSDplu
	08snJX+kTgyLfBn2HxeMcIKsz0Jtpqxm8V4aJ2my1Od3SwKCHI1xxiCqjDkv4h/X1+Swdr8RyZY
	hKhnpewXnZEVVRiJdGaoPchqAywfisRo4T67t9H/Hvs9dlFUrTadgE/VIv5jummt+6AxLFZfIG+
	pR6t3Z65SBnndzndogfl8Hm14edy/G9Qw2qRBfpL0B7Y6WTzQtNdW5f0ZcB6ckrVkcVlxmRBVGG
	uqig2gK+2ChrKrXWnt2I3yhGEPXvHbcyVN8teMHRVWaSnW781I6yojjkDJR7oFyTPiiQlm099Tr
	kBkdZwjzkFrf734U3lh+MX4KiQYMJQwbY28y06HDIysyH3GXYeE4zhWdROt5K2HVR2x4DJ8TeMq
	e4AUKi8E4m0TP0f63ErqizL19rcFZhmFSo4CLHV+agMIHi5z8rrIkwbRpbVCKcRK1dAjDiBbUst
	JBqb4i8ksim7ZBq
X-Received: by 2002:a05:6a00:418a:b0:847:99a7:c751 with SMTP id d2e1a72fcca58-84fde75b0cemr10999018b3a.25.1786777183910;
        Fri, 14 Aug 2026 23:59:43 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223f8csm1223558b3a.35.2026.08.14.23.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:59:43 -0700 (PDT)
Message-ID: <2d19f707f3c70c3e170acd3fc79fb70e7a27d5b5.camel@gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf, x86: fix per-CPU address resolution
 into an extended register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 	stable@vger.kernel.org
Date: Fri, 14 Aug 2026 23:59:39 -0700
In-Reply-To: <20260814220254.3797467-1-vineet.gupta@linux.dev>
References: <20260814220254.3797467-1-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 15:02 -0700, Vineet Gupta wrote:

Triggered bpf-next CI manually [1] and pushed to bpf-next.
(Since it would be sent to Linus on Monday).
Thank you for the fix!

[1] https://github.com/kernel-patches/bpf/pull/13314

...
