Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686235;
	b=qRdPIVW2pncYaE/kq6mnqjiJB4hZ0IPgCRI8WjhhoDwGj304f8B46be1rv1eIko4isjr
	 +jKHrCtb6rFxFog2OTBOHMSUdQDe0XzP/negYCCShr5SsYMm+epk4e0pHF9uUdslm8zLj
	 IQ/P6AbEM8KWl7SB8d5bgwHt4y1ruWUVeTHrbUcl8hnkZ1Mts8Ax7ilL3EAb+xIjTX8L1
	 QSNbx7cJ6P+/6K8HhBRxlJz0+vITuwRl3nGInrtTnr8CDDNVf/kZ/1eOQvaMMjAAdLNRr
	 MWe5866MWRWNJb8rxbIihk0rhmrPevjk1BjBEs1Qo5Ix876QpTSVzmWhOT/Ry3VDtaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
	b=SkMBF7B+Y6+xBVJ4pt9wn7Ib8hRUdRvL/NIiF654352kddvPrSF+KkN1YNUqDQ/KBeXi
	 p7nYxs7abKlHNWSnCXbS4lWBZuyVcf75C/e+etsPDia1Xdsx37f/NpcQCCLhKl9xlcD2z
	 mu4wx4rBgzDMrFiZ7h2BJnmWLbI1W24u3yHTOF3UU18RzkRW4vm6prsyhlgpZ3OQg/urw
	 7CopRcMAadfDVDfUBG+BwPtO82hXV/Gu+cmFeTolDZEfpiWPaWgDkPu1H+YwA+C/VaXKM
	 a8419A3Ha4lhCTRcFXewtIHFwq7HRwj49egK++GBq6iJ5gxwoSldIJ/XCvrNEJ+muDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="R5QF/Lzq";
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76088606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76088606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=R5QF/Lzq
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso1698161a12.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686235; x=1795291035; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=R5QF/LzqmNh8H6DW/Tp6D2khmH13F8jS02Au3NAC8yj4TjGWX4bwF6qk5IoNwQrE/3
         Xh1yK0KBPfJuPjRAwYHbzV6XosfNY0tKGMjje9vACiDnt1BKTLgjbIxr9zzZeHHSoySX
         0usB5I5Lay+SCNbYz0Ix38KonSjLyFaPrl1JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686235; x=1795291035;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+UcsNuMg4Yueaqy8xslzDAXYJR5HIy/+gngqmLcoZw=;
        b=aRLu70+AQ85XvADnNmUtE8YEAAL2aCk6mg+3EhVOgEDlIDIDbGTQyxNB94llf6jgba
         dztdeAby+lOIkBkG4bkSuRimPiT3LVP19swbnjDdq8+mJLJGdGphezx6Be6VeUZYrFyu
         POTqWMMwFv1HqfdbOruozFY9JShvV73x35kvbiEJggeZgSFeAORPp7cem9Nlt6yG72LO
         NqCj8Uj/+cCnXEyZ7ARRRYrG4pUuPaUwLGmT66UEZ4gd22GK7ExZpxWC3+UHz+WqHSUE
         oQdUMKOEB1JNVM9EtjRLqWwsIiP6azPW+gNgw9V6zg7Pow6BQJ1iLjvOm9ugKSP7+bN9
         rYqw==
X-Forwarded-Encrypted: i=1; AL+hErEyutPLvbEREDMFh6VGZOAMBBmglY1gRubfgm04kKQPSc5wFuwODVEMEUJFiKZZMwXPxQkj8iU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B4xsO9F3yZClkPIVD5ZDQmDaxR2mwIxHlYEOB1bT6EysbmU7p
	Fzh3T4kb7O1Se1JZgOQaFJjq5ctssTTnuiyABBBu6/BmFP/27Mhew+H3nv1BWGSTFM0=
X-Gm-Gg: AYBFou0iVSV3Cp0OKZz78MC7g9lvRu4gSFX2jibYrr47O7wy2l5RXchqEdRXEyHciop
	t6CkwyJcXafjYpw8s+aWW+GuNBPkwKjTYOUPhoUGt40RAmM2wkua76WTX9caJaafX4eMY9U1Lb7
	sOai6oMkYuV8tfliAVLQOTlywW5n6IiYcsh7hNoz/CqkkHGBvKXw9rB0PCFAxSYczN6mRtAqXlT
	Q8p424x3ymXO1MRGdGEu+ls4Gff9Z6PuB+/UDBUwW675583VcCd1vfpN/NP8tllDZgwmnPlVMYh
	0HWdhkl7UAcC04PMISh7mfoWn6GnTZHvfLIVYz9YwgjQDjwp0FBNOYM2d7vLm9OtgG60hnoMiVk
	cZvJ2AhY5XZ2Jw6j0gk3bwSUaSEblqHeC9DkTLH9gA19akV+Aw19gRZYAhAWuiJPBECjXkcO8wB
	nE2SVnK05cSmYwugQsR+P84j0HVZGHiCSU7cQT6Q1Yjb4AvsS7gj35F6y+Mi/mE+IlAT87HOBpw
	YJs+k55AJc2kgADZlOBTxwgOMiTEMp5vNuAkENgQgY/1oiNIiKT6z/9jZmDfefKA3WVpORFyPSV
	gIe3aX5HhWwnQ6B278egOKkTMIxr+knP2x2+eUQAj8es3peovgWX/DpULMiZSVKtv6hBEINt9fs
	Lel01T64AKnACOqb3N2QWyYqTdRqLsPlAwA4vi+7zkCcVjIBRYIYyiuA1ihm0FCVNda5G1kZwhJ
	iyiGmzynS29tXlyle87vonherh+vAMc7qNVPR8+nClkMB2sJxP23hnMA==
X-Received: by 2002:a17:90b:586c:b0:3b0:ab34:afc8 with SMTP id 98e67ed59e1d1-3b1b0b67f13mr5551950a91.20.1794686234917;
        Sat, 14 Nov 2026 11:57:14 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35ac2sm15010379a91.17.2026.11.14.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:14 -0800 (PST)
Date: Sat, 14 Nov 2026 11:57:12 -0800
From: Chris Down <chris@chrisdown.name>
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
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>,
	=?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
	Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>,
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 12/13] percpu: search the whole reserved chunk
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-12-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-12-50a2ed382b61@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114115712.a6d31c964942e1db@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Reviewed-by: Chris Down <chris@chrisdown.name>
