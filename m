Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502794;
	b=1Lh1bx2m7X1s+SBEajbOLntz7rXrFMJqoVwjxF2ZG5ehtE6vAhg94P37J4A2mkSNovR6
	 FndrsHszzi7ltXK/8oO0KSa2I77t2GO7fv+7ntm8rrsPPfFz96GRIdKMnTbXwYSUbHn8x
	 Z6CE1r0NDfxiFl6KVd0PCUwng7vdlYGBNccQ7ic9fyqkBwlIPVnwTD/7yKu4ZWC0IhdwB
	 DO5HRYlz7XpPQXVIQetSCrsygXUFdS3qXoX6TVYtJfLbb3RdntTKJGo6KCkF83GPy6gfg
	 74JKWjHAa82iLd2mUU0zdUDGIolADLz6Rj3NgWxQpQroMVmSqsZ8VsWMTZ8IRftBh7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=b7AojsWQdmnu8z7CsRmtwQ/iZVkZjTk5+I2/AfHY1s0=;
	b=MyphEe/FdeGvPA+hTnwSiUG9T5LfVEPnB/I6oaTcoAgeN9Dfa+F4vw0eiqHbhai169O1
	 VQsGzdJfLonUFd33KQIAEKBT0qzm03Nd8bAowXf4m7llXkZP/gjI9F+tEjGidQFZJhTc3
	 edFwgI2HH6nrLIDdfcrJqeLpMH5OFdwZfCFp62EJPK8Vk3AxZ/711FEs1d95Ly2b79GcZ
	 L4D1tpoYKJqTq43Bute8xitAf+sGIE0cAgXTaqEJLOlMZJxOFtcyVqpF/FmgpVw+w7cK7
	 Dk2OmGSAkyvjs+4lbBODOmrXsW5mvgrQgQAEx8RsINDmF1w6+njub6D1nHcbkTReZKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZU30IxzG;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926D606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3926D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=ZU30IxzG
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93a40a9a01aso142304285a.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794502793; x=1795107593; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b7AojsWQdmnu8z7CsRmtwQ/iZVkZjTk5+I2/AfHY1s0=;
        b=ZU30IxzGF8dTAnKh0hg/WW7t2ylFe3MYJYBXubmCf1/k0kqtiBJ0BHFnlPIecHUaEU
         +IOyPQjcJanpVIfwQEyjiCo6R8ZX6eRq5qe/70rgSGI7XTTUsHeaJdEJ+rt86dO3O4QG
         IEUiGAj+qbzlD2oBfD0mzrQlpkwUxvBln1wYn9oA8cukVPeDq7dpLvSUXGYb6dXLyEFE
         vRplzbwFbfz1dfysSc4/vI7lT75Et/sbZuEzEjHfpQS+gx9dYciD/G51J8TE2ue/slis
         bnZQPk0+xQgbm/k2K/jwW5N5aOs1hrfOWqwRb16xam3/PsiW/U5odSFtLBlksi86RNx9
         J0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502793; x=1795107593;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7AojsWQdmnu8z7CsRmtwQ/iZVkZjTk5+I2/AfHY1s0=;
        b=AC73xEfTc+aEjPxaPyf4FUdwz98vk0nDAZq4JsDTWZpHghIrW+f8xaZd4sWeL8kUoj
         6mJUqM/jJjID5qzs+JyevDPpcSuG+pR1eGQKvtzjwEW8m3wYELP3fLotxjq8QK2FEA3Z
         DW4QQmxQMpdLhA/9aIMZVItrhEK31tX0GnvvYXmEn1KFrguYP6J/CaAAWxY/Ml8JHRtK
         9MN3nBtm63Au7QeC4dWJyL5cNxhWJSPYvXbSfKWVoLEEGp7/XWT/RhlF7BV4iXgwW3Cs
         47zbZfONAE3es3znRACzVmsaNI9wzHxbJrAty0/C2KA6YeBh2b7xfvNCjyadJhHnEHdz
         GIRg==
X-Forwarded-Encrypted: i=1; AL+hErHTftFCgCwVu7n3WYUODsePOETaoFA7CYLLATw+fXugCXCAT6A/TOLnmhlVbWQdL48uLU+G85M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ew6QZtQipoVS0RiOzzGSO2rQhVICvFnGhOf6YXt076jnkqngt
	WSTZA+WfJg+4JzaCuoAo8xS8Tr+Dbc2I6tw4vrKI6OD6/pmSRGPpL3RjpZZXfrHz+9c=
X-Gm-Gg: AYBFou3NPEEqSiu+n1PQIP2bYBFTipQKpii3B5maWyBJ++KILUKr1/5FjmcawuSro1U
	pryIxplR2IZH2uyKUkOUdIROD3oSrqgNBEUxfgraW1YwuWCFgrz0RRusJftwJphCSJhjzZ47RNx
	tGKJOyWfIOjyZS3LAbg08j1Tn9bT9HGorJ3qZWUBPJeZIWMFztyMRD8BCSpOpwClWXWDb+rlwK4
	PX/i4x0wx1eX5HbtniRdZPm5xrYY/K3rMNKE+Nwenq1jjL+wyDiexmULtNPsIryrubtVYTO+egv
	oodnfrdtgpttJfxXJaPOcEy9athe+qi4Ba79lTYNkJTZ1NrgpAgEW/GrvWSqWtMwLC4pUFDT8eh
	PwNvULlRPK2b1lBut73qVGM9kUWaeWreqvfys0BtXDDPU/IMmK4EIPL8+XXrVUoJeiuKNDnCvT8
	GbaFKGOFNAsOHxzfz7+I5vkLg3x9wzGLljU+tp0S8G0F6B1EkYpouse8IIcZR/rYjKvmW2zH5g8
	Kmyn0hhiZeOsGdJQ4eSRQN7A4sBauKKD9kSRIKO/5KZRmAP9d8Tu8DGgzyBAb69xKBB8lDIO+dk
	BTcR028Bo62N7FW8ZdpeR8vzewDEhAki3VdRteOYmuufvKo7pOxgA8mf6llQb9sH8pFz/24gYSi
	Pbtz0yAE=
X-Received: by 2002:a05:620a:6088:b0:945:f5c0:a630 with SMTP id af79cd13be357-94932e8795amr549937885a.40.1794502793241;
        Thu, 12 Nov 2026 08:59:53 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94935073633sm220651485a.37.2026.11.12.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:59:52 -0800 (PST)
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
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 11:59:50 -0500
Message-Id: <179450279073.482102.1691484916250559829.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> The OOM killer can quickly trigger again after having selected a
> victim. That victim might not have freed its memory yet, but its mm will
> be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> 
> This can cause the OOM killer to kill an innocent process when the first
> might have freed enough memory to relieve the memory pressure.
> 
> Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> 
> Note that the task which calls mmput() might not be the victim - if it
> took a reference on the mm (e.g. ptrace), it may hold the last reference
> and release it when it calls mmput().
> 
> Therefore we cannot rely on current to tell whether the mm belongs to an
> OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
> unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
> mark_oom_victim() sets on the victim's mm, and check that.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

I was able to reproduce/observe the unfreed batch and the second victim
issue.  In the base series i could kill a second victim with the
in-flight oom in about 26/512 attempts, and 0/512 attempts with this
patch.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

