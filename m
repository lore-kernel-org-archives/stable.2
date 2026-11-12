Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503704;
	b=FycpPiPoISAmB1fGuzs5D65/M1sBoC07U+U8fuW0jZ6siUsN/jb7dqTmWIQZM011hS4X
	 Cx3Zez/R5n/QH7XAStWNGWYfDbhTSAzhXaMJCDS5Y5NcR/E91gDSqx7tiB+0+rITMHuQL
	 L5gkCBbIh9nUXw12Xdx4OkngWaVMbsP68c8bfh1sXbITtOYjapxB8TLH76sI67XqoP1im
	 a5PkW5MEKE+U1r7Mfi5a7+RHgziLkuunqL2oewA4rDjwDS6ehE+SiXi2byHfb7CkqvpN+
	 jCLz8ITh8XAcy3Xn+7qw5HBzqxKhRZlYL0+jHbCRcOQ4FIlfruURceIrZyZNjX6p8HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=pkUNJy/G/i2yr1NWN9oiSB6swWvpLvuFtnABa0SM57s=;
	b=kIo2aBGVre7pVl0aBIQHRAJeIb07NCR5zkBVNUbdIaeRYjTDv5bAZ4ezfVotwfstqNVE
	 iAih6/rwL81UVR/OzgGDVgcncPP+b3pOKEKyC2+NxjaRmTQFHZYbsaXzPvXWrxkhMHOMt
	 MyTb8YEaE5G5EOu+bNUUmc7VBfBv0072Rc/qnT0ojabK9e9nThgTHUe19LFkKrp7dONM7
	 x7T9jqDRrgUXMfE7pxPnAGWTX2QpfhYbflztZSMyQmMJW7ANfwSYnh738G2YgJjkYaWb/
	 N21iW317JJ2lGJ8036E0oDgHpDr5b3sLOHTkHcMLA/Jcrvmkrti6o84QU/P1MxHtOyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=pmyoi0DA;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BDB606A886
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08BDB606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=pmyoi0DA
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53634b8328eso37785651cf.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794503703; x=1795108503; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pkUNJy/G/i2yr1NWN9oiSB6swWvpLvuFtnABa0SM57s=;
        b=pmyoi0DAQQlNFzltCnW5ORgDwnPgssF9tc5Yb41egpqJgqO1bCD46e5CH1aNeekBwW
         zNHDZbnO+IlIj94erHAXPMOAM++MXQqoXuZCMU4A5rLvl3ueWGShLAmTxgxlGbCB3/gG
         ZHjvXlyYIqd6r+/SuPQvrTTCMPGpgZUnR+AgV5/jt45EQ2tyGvJM+kMslERvdjYJbMT1
         9TMAzYgSYsdtz2+/xGf4uEOHM3MHtE71s0/etNjpd1b+uuTHQYTAfstQQM6azn5B8XfM
         Jrp4nZhrib4IHL3HIQOCPoXU85VZDXpBpYjP8UIEY8bs1f3sG0zr3OlkX5wrMUEsI0qf
         ujQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503703; x=1795108503;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkUNJy/G/i2yr1NWN9oiSB6swWvpLvuFtnABa0SM57s=;
        b=HGYfsH+i0wCn5LZe4AJKCX4ji7pBaUTExe8dRYZ3t0hkq3Ryt4Am4fTHkQBzy8dBGb
         xQPrvKbSuY/sLblfiWfq271J2a3L0V33DnRk+YAssJIHLiY8SV49YMGKFGfYwaidUKOk
         W8dEVKUYEv3wwRqHtn5yRZRBEsrVs5BDKMto4h9XCDWiXSw1L/hYHw9w2AwglxFk6qJw
         XHJQeUSgkEzvYKLa3/j8Kg0xzIzRVC5pwCA6ukQJpcZju1SffApAzk5M4Y3lcM4yCARk
         DpIDZQeRmsX+Ffrws8KaN+cGLNZG8PyheAc0DwHFRnGMAlbei46VepVLN74UfDztPZ8M
         LoVA==
X-Forwarded-Encrypted: i=1; AL+hErETI9IQpPfaV8nw0i2PqiiwZxWmqXhYoUMqSrXw/WBUXbpHuaB9Rn6E5bcL+77uWlNeRTJvlGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DsQ17n01inSzq/e2zl2WM74bxrNpH+K5cll++ieCVR6WsxSAB
	8n9khzxavs+qBxJdonhaGebyIt6vaQeIg6SoMLexdjqo7UWoprDFT6cLywuI2SQbrdM=
X-Gm-Gg: AYBFou1yuCl1mW0CXkzMiIKp48SuEHj6gX8uwB1rUjLYuULA2C8d/w2Fqv+Q3/eXxw+
	HbH2VVd9fqk/4JPWPzJBGBD+Ek1yHyGxhkm37v5zIDuwUnnIsYf/IdCMeTBud9ZvrmDIoGCpQ7n
	9bXYdzz0wNDo0a76DJHWr7sPekqe+mXYy3pVaITvqq04tE182HM6wt9iBj4cY1p0f1XCXvLFyll
	dDzTPDi4ulX2fVy614rCvJCpJlebyybqPe8zvdOxGFj0y6HjvjmYtJRcK4ccSRCuTgwm54F/L7B
	VcxDP/JD2JpKC7pe7JO9wnLuLjm0dEBKNm2fGnpj635a7y4JYtY+ytFnwKwkwTNpU3flHA6H3+Z
	WMn2KXfcnyMbmDN7Ogk0z0H4Zss1cfkdmNALTbmotPoz26wtgcYSEQmOU43i35WmRphoIXtu1iZ
	ti72fgWkCEoW/yL00lTeJCVV7j9ylJ4YPxQq4Zj9kP9M6Ql1HA3Vc2dOOCqahXIjMX6K4yxnLPA
	4SOfiZwZSs5dqdm6SLXq8dgSGDCs6TK1PPnK5ElUrqaP6wCBol0/KZ7xRfjGY0pDZ1QhKR7XDyE
	sWCjqUsVPdfo38pZhiHu/HgjIWE7JA8we+G5ZE3UeZk/z5W1KRzvxSxdPRdMJhTp3ZwmS8/150t
	Pb39L2Bs=
X-Received: by 2002:a05:622a:5793:b0:54f:863d:92c7 with SMTP id d75a77b69052e-55ac786019emr462181cf.41.1794503702764;
        Thu, 12 Nov 2026 09:15:02 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af5f339sm78250641cf.9.2026.11.12.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:15:02 -0800 (PST)
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
Subject: Re: [PATCH 05/13] mm/migrate_device: don't collect a range twice
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
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-5-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-5-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:15:01 -0500
Message-Id: <179450370120.482102.8019443935242743968.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> migrate_vma_collect_pmd() drops the page table lock to split a large folio
> which it finds in the middle of a page table, and then starts over at the
> "again" label. The entries for [start, addr) are in migrate->src[] and
> migrate->dst[] by then.
> 
> While the page table lock is dropped the page table can go away, in which
> case the restarted walk invokes migrate_vma_collect_huge_pmd(). However
> this is passed start rather than addr, so [start, addr) is collected a
> second time.
> 
> This can result in migrate->npages exceeding the number of pages the
> caller asked for, and therefore in writes past the end of the
> migrate->src[] and migrate->dst[] arrays.
> 
> Fix this by only handing over what has not yet been collected,
> page-by-page, and flush the TLB for those entries which have been
> previously replaced, similar to the other returns in the function.
> 
> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: cleanup commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reproduced and observed the out of bounds condition with a KASAN kernel.

Fix looks reasonable to me.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

