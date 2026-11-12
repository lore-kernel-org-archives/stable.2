Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487735;
	b=J63VtQCBp37inztjt+hp1PZ/u6fH958vzX4fW3LuICLkIsTz2cmJdqIsTJwvmUQs87sN
	 nivAEFPzHJPv8HyXnpqO22fwSWyhBwMvzSC01N0WdtDzYnjdDNi83h+QDXfYUkJI5tico
	 MZ73qN9RNhfuPSzJ9oPQszOhPhSnunWopIH37H9hIc9w87Y/+YNB6QT6eVP3vY2PnHgzE
	 xHjMmnYKg4tb0zZu322EZsbcSVmpcKnmaSfY5Zn4KjalJXte56WbNIXr64V8XoufCrp0l
	 zGABPaaai4/UiY04RlDbWLD+Dt5kK2Qee27mEH2Jr/T85QH2r5lG6R8XiS6YXmW4P/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fpPYP3LwQ7UH65N0IOsMYcszMsGFfM1KkS0iQ4klOAA=;
	b=s2YxMnG38aduCi6nz7jZMpkBPI7ixl/CxEPVUh53THYlm821KtVnr/Uqjh0XSIWeQoBI
	 m0QbpY+2h0Gbn20OvL0/LETFO2dz4pEmumj8h3P2vdQULcjjPHy3BigIScsVQfCcSzzw1
	 ft34rza1xyy+wi9upgOQklGRZhsWAKf8my0VKFnHDfXO9Y1fmGWhNpNT2mM4/7DuYVrEy
	 HIz3c6Xp3tiJsxxeheKgvq8QrAWDx2y0Wf5J5RlWfAv9WISpxM3uOiUMdkXiGbnaAUfQy
	 3nJaNeb+ABW0WjVVDvXPSHNdDlJl9A7pko3q02lC1Up1gj73cWW8P6ycFQZ7tZEjvbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IFFBVctA;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94905606A339
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94905606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=IFFBVctA
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso37214385e9.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794487733; x=1795092533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fpPYP3LwQ7UH65N0IOsMYcszMsGFfM1KkS0iQ4klOAA=;
        b=IFFBVctA9vvTAyP/0s3JWanNwy1/EcxnDhkd8zecNe2Zf+clmKb89wyzJ05R1YSHXV
         LGyoa0dx5KRbjIqfPaeosKW4FG/S/TZ/bOzWAK3XQumO0htQZJfFTt/F2klbSUyWCNaQ
         UF3hx3dzAKtUu0xqzCsfpxy72op0flc9e0fgdTlwX5B2PNNljnzfTa0/Pt/1WbbZVmge
         r8OGw1wv49O1zcCNCHah1dBqI4xROCfQEeTbiMp5bcSXoRt6mPDtJAQRrwLu1ozcKZ/P
         qVAa+0BOCYHl6xriwV51z631YJ8BDLYVDO+Y6ZTTfdCoWZSV4i63QxofQ/Bzjzx/XaHi
         LCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487733; x=1795092533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fpPYP3LwQ7UH65N0IOsMYcszMsGFfM1KkS0iQ4klOAA=;
        b=hH7nwVBe9vX6vwKVXndHww48pkOhPNyXJszF+t4pPlam5tS8Ai98o3Gu22Kj74RAgr
         FUId9Mwo5+NGHk63KkeBewx5jX/2oQMrs3hFjaQh1vCZfGu26VuuL5hFV7i70PinQqgj
         wIB1xLnjevGLb4B7L3nLSmGth+cpabrvh412H9b1ytRQMMLj+6wzVUQWtiqmiwz1Lb9A
         wX0050ox/UIqQLMCnWgfJ8y49PkFHtUQpAdU4sSjdwi9i/e1XX+lo2CwIDFE1bj8WMQ8
         Gs8yFBI1p131OVQE3IqcV/Fy13lKM8mwhZodvT2QeuRYioMii8zGAQGdCikYb7eji74H
         KePg==
X-Forwarded-Encrypted: i=1; AL+hErGt3FKHtWEBRxEQTJV4EsLQtGQ2ctQuRjMwqDhT+DlaP+k5l0fsT1kFq7JldkNfS4HsuNocv4o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/c62waLSBw+vXUXpBZQ1Vq+mXCccuGy0B2hd6aTiA+wzJlPezD
	pdJp/SOEtNLlKYLDDo2Trk22Ab3+Iv5ox2JHzhVQFGbya19H7yKk34Z1FtPxx+jMrl0=
X-Gm-Gg: AYBFou2mWHfel/vVs8symo+ZDSLgnTxQPGen3PuNjYUWRE+JpjXxHq5sCcACHXa7h04
	Fujudq8ig/aeuIRxwjOKqhAApaPz0r5a+aDE+F0++TLejedy74J5k94Wvq4CX5sDxmAxxN6De9x
	urm8FxxJ/+kzg5a0CZJ7TgHLJ/XgEragOYc5MWnP40+JHro/kNSLgSZBVEvs1hZri3i1y8VDtBJ
	2BpQmMKIR9kWtvrPvUxxjlL5Q1xZU5TgGWlY/96lqj2dV9KtHGOu29G9zZ/9JlLBpHbHh/BA83D
	p6vTVD9XaxnkD8UxXjsOLgpvZYNJhbDzIPClylhpAerRdV3yA5fuJi9DD4f7R9HIaAsV1L9KQN1
	PGuYy0DB/+rxkVG4wW+VuO1cqz3awaSUErlq8a2EY4az8PX5D+kdto3/YfL7Ul7Glo3tRKl/GoP
	36/Eu0gcvrUcN/W3WxLjXxKvyBRuhkg6IigttlPRp5ymu/3RsmOX+izBVMCV/mx2fcBMOmrnAYk
	oaKJrsb66VIV7mz4Vt6Oa7wSzR7k0Ax/8OR+fapUufWHsG1f8qpPM9IxUTVrd+hS4UrOmTYdFjY
	QVVeNg5bXzbzZVBRB6gHonErG1mkxwZzNbjBmTveROk=
X-Received: by 2002:a05:600c:190a:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4ba0936c8bfmr102512485e9.7.1794487732984;
        Thu, 12 Nov 2026 04:48:52 -0800 (PST)
Received: from localhost (109-81-94-245.rct.o2.cz. [109.81.94.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e251491sm71286495e9.2.2026.11.12.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:48:52 -0800 (PST)
Date: Thu, 12 Nov 2026 13:48:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>,
	Balbir Singh <balbirs@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>,
	Josef Bacik <jbacik@fb.com>, Chris Mason <mason@kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
Message-ID: <avW1s2wvz1PB0-Ln@tiehlicka>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
 <avWmfXu39vtp0DM9@tiehlicka>
 <avWsG-zmuniUFio7@gremlin>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avWsG-zmuniUFio7@gremlin>

On Thu 12-11-26 12:14:32, Lorenzo Stoakes (ARM) wrote:
> On Thu, Nov 12, 2026 at 12:43:57PM +0100, Michal Hocko wrote:
> > On Wed 11-11-26 18:13:15, Lorenzo Stoakes (ARM) wrote:
> > > The OOM killer can quickly trigger again after having selected a
> > > victim. That victim might not have freed its memory yet, but its mm will
> > > be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.
> > >
> > > This can cause the OOM killer to kill an innocent process when the first
> > > might have freed enough memory to relieve the memory pressure.
> > >
> > > Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.
> > >
> > > Note that the task which calls mmput() might not be the victim - if it
> > > took a reference on the mm (e.g. ptrace), it may hold the last reference
> > > and release it when it calls mmput().
> >
> > I do not follow the reasoning here. MMF_OOM_SKIP is called after the
> > address space has been unmapped either by the last mmput or the
> > oom_reaper (or both when they are racing). Now all your patch does is to
> > call tlb_flush_mmu which I suspect is to release batched pages. But why
> > is that needed only for the oom victim and why there was no final flush
> > in unmap_vmas?
> 
> Sorry maybe commit message isn't clear enough. I did have to pare these down
> from really massive ones.
> 
> And yeah tlb_flush_mmu() is about freeing the batches.
> 
> unmap_vmas() doesn't have a final flush, it relies on the caller to figure that
> out, and just batches up.
> 
> And currently tlb_finish_mmu() comes after MMF_OOM_SKIP is set (in
> exit_mmap()), so at that point the memory is unmapped but whatever the last
> batch is isn't freed yet, and the batch can be large (PMDs are single
> entries if I recall correctly for e.g.).

OK, this makes more sense.

> This only matters for the OOM victim, hence reinstating MMF_OOM_VICTIM, which
> made the patch _way_ smaller than the one proposed :)

Should we simply do that flushing unconditionally before setting MMF_OOM_VICTIM
then?
-- 
Michal Hocko
SUSE Labs
