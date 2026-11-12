Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504929;
	b=xggAfjjS6ypUCWF2urub2gjXq6PaDrQ6m+usXsBXPh4yhe1SjAZPEYQKU68sZgOYc3N/
	 ZlzpsKD+iz4DkLgcbhX6GC6GctizKqmz9PtsP4BO8W7KyovIIgAg8l/0NgynMLKoynCjU
	 dDW3pI+d1ZKe7PETHrjYjjkRuld1qZtR46rTpU3XuPe3hBAa+vYXK0yFT8m3bbKJK5m0Y
	 XRXTqOd/WJGRqzXl6OZTfZJrB2JdF1D+ZL1UQRVF7NWTmGXJx7b2lvCAK5xkoD/SPX7RW
	 2rLRPP5lD/KV5FbUfWrhisbGIlqpnN/p/7TFU24BPH6a/mgJ0lVnvkHzovLTgnusLNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=wY/udgzoTMSU7LblXILhhflOgeGfM9mMJ7q98JCWr+4=;
	b=2drcb2WPPxwOo4Wbw5fW6bvwqKrOcrPMalmwkNEZP625uf0t0X8b5oH55wbSA1qmkXta
	 XaXFi5+QyMhIgN5fkgnOddPQE0I+aURcZfYgAc335AwpKHMMGU2Y9TGOoWBUsYzkRH+85
	 3jpA5vHNvikAieQTzVTORtfJd2qaPiqvE/yudeyYrxN6aFRXxDWCy00hETtWznahigc0X
	 zW9LOZ10okB8qRy0drdFl7YK9b3EFe1eLLc9w8RRbD1e9KS3mQX+4UNtjYwNBq4jZpeUu
	 W1yrMCbZgVSomDz29/d4um8V0ueDpuqej4DbipZa3sXvuea/2bLkYYGObSWoS7JFdRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=oEs3dmHr;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F756606A33B
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F756606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=oEs3dmHr
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53664b4860bso44105281cf.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794504927; x=1795109727; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wY/udgzoTMSU7LblXILhhflOgeGfM9mMJ7q98JCWr+4=;
        b=oEs3dmHrtbo3BJbfZOVEDyiKo84vSz7vME9GeiDQFoQ1j5oKIGWHaLXsA6of593DNi
         LSHuyxe114XTXGNJ1/Y5jCpkW7+pNUmCsJP3ME/2E1iS7aiNUDAMlZgu5frzBx4YzlN7
         LGU9QrbJB4CDwX/JJQi4yBuDTXoPz+0pNuVnbBxJS3Y+zSavZNYfRzlE+02u6FSxVCfG
         5AiyrOfkTxftBPH1gDgLAc4621TOLHFN0EDyYtoQh9nuWdC5b80BG3E4rlAu0JFVdD6S
         Ac+AVCNswFwIvFTGkOL2F1V2xffk16MtyAElYxcTnz4eLh5PrNNOOrZ9e4Pi0Z2PEMrd
         fzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504927; x=1795109727;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wY/udgzoTMSU7LblXILhhflOgeGfM9mMJ7q98JCWr+4=;
        b=SCC7MuiXz313geOg0QvTbGshF3omRXCqL1GSIxQkXkJKOVQ2VYmrjGZckGmm5lsSC6
         59+YSjT8pxat57ugtc54bhOmWWatVHYlADaEZYaxf+EckBjRYMM9ekoaM20h2aR48PrG
         vOCP1VbLB88vwsbvAHR/zMaJmxD35P4/YtqXWwymbkc7YCvh8yJDFqCe60GWqkUvyn6e
         TCmnvewpjpx6JCP15CP48CRXRDC2GlVIgEELSW3xC+vQ15qZULwERRxqhfCVK+nD2fsr
         +TpgwdzJ/iRKMAi1J2y/Y/3Giz9EgvU/i5niNuei1QzHIfOgddOhsUIi2u5EZ3hvw9gh
         iFrg==
X-Forwarded-Encrypted: i=1; AL+hErFEUhyKxcJKROXClorvMgjuXyPh0zOQ+Z5D2Tvdl8F6yUTPlLpkXNMygdOLoe8mRYzGJxbh00k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xkzApHGsHYelWr7UiYfptuFp+94m45MmLyG5MjFPxVLOg2q4J
	4D3VXJwgGdSF5pmxrH0XbBDIIaSXD5xdXwV9zpALDHOUdwdhPP5uK8vwtO9TC/O9Nrw=
X-Gm-Gg: AYBFou3TekBCRY2o4vxrsMbDv6hST47n4W+T49Nt982lZ60ADyv5h0Sh+Ih0sLbZ/EL
	m7CN/fRo7dT1TlrjC3lP7ZT7s+w4jDJyfqzMAS2obwu5P5Lw5ICZsOFIhbNr3gUTfi/0mXAdpmC
	WNuiD2Ir3FEUclI+MPQ48h7R9p9qDf/A3UO9L2VR2w1Vj0KS/VPyMHb0Tp5ET3ZusMWahzT8EdS
	QKtM1c4onATpTqksXwOpRRJPksvgm+bZLuEY20T7wnECpR1lkt69L106nDluq6ODOLfVgLKHNpG
	wVZ3UtE6XiJrCkTC/5q1LkvCAthq2ieo7JiJK/XZd1Vr4OA+48q784per9k4VslnMWChQE5oGqI
	HIBCaJ1vmPQB88Ut3EkVHiiFoxqpyBftlnT2SSgztI7D1JW3akk5kxUMBJ+cE+HOu/NyruxfXLC
	k/5xmcU9/q4gs43d5cKooltiOgA/Q3/naJXZo0yly/rmXDma/uXvy3CfZFtVU0MQBfXucVowyH7
	RLrvB3Ah86/f9pS2Pn0rzeTtkxVl8q9GxZNqapp6mpHMnGvKodVlpwGtP2MRwnCM+oc4fh5EZGO
	J04QpretOoCKQcGioZ/A/kGotrAdjICX6QlwyCnanMMLIKu5qeEtBWPRyL38eryuEWJQDE/KLAk
	qMSMwAL4=
X-Received: by 2002:ac8:5a0f:0:b0:535:a5f9:752c with SMTP id d75a77b69052e-55ac95894d0mr1164321cf.75.1794504927563;
        Thu, 12 Nov 2026 09:35:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d5e579sm847456d6.17.2026.11.12.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:35:25 -0800 (PST)
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
Subject: Re: [PATCH 07/13] mm/migrate_device: look up fault folio after a
 split
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
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-7-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-7-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:35:23 -0500
Message-Id: <179450492332.482102.8905567682196853763.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> migrate_vma_collect_pmd() looks up the folio of migrate->fault_page once,
> when it is entered, at which point the folio is locked.
> 
> The fault folio is assumed not to change after this, however if
> migrate_vma_split_folio() splits a PTE-mapped large folio which contains
> the fault page, the fault page ends up in a different folio.
> 
> Resolve the issue by looking up fault_folio again after each restart of the
> walk.
> 
> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: pared down commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Was able to reproduce this, and i think this also reveals (and fixes)
another bug in Nouveau (memory leak).  I think the Nouveau driver still
needs a patch, but this otherwise looks correct.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

