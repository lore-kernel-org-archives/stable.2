Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686222;
	b=kp50JrJgAGdY/swkEA8Lr2FR9zqeOP3zGEld1+B/TJ9Fh7OOhEciaEgVEwUHVm+Ygui0
	 7R0GCH8fzxP9psEEBWxdHTC0Qvdp/nwpGmzat+4B84WOovzy0xe1b1Rr49Egz/gvt1V8D
	 9lVo0JEp0cLQkeZv6Jr3r4e88O/6QCsygQeVdeBfmyRn49WNDFdq9HTIMWdckmrsRnQ04
	 stCL0fy6BCwmbmjjValOse163opHNL5+tSpAW37Zok0cm1YQilUPvcWzjvgAYHewtLieq
	 4pwzGkuOAdGd8Ka+gH/fmiSrwciRcciYX5/a1YACCWPekrleHDuLCvCmO5996RPTB/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=ZCi4ttrWWQASeF1sPChkoEBldIkxl44ii+iYdI68IA8=;
	b=L8RmDwHy2dLBgO5QjJWKLpb/Q5XC1TKoeQVTYzp9UDcL5ULs0idV8SRl+6bYrlA/GIWT
	 8ybJXx57I+qITAo5c3yf6xTnwkryB68xMDWQsZ/94/mzB1oKhe1k4MwyTijrQG4j0Accw
	 D8mHKM1iLxupJlph3IbonVGprGhmMQNtpxTr3jAXbla99wXm1r586A3lngzO4cvuAJeaZ
	 AFzZ8SWhDNdUNc5Rb5S/zvCvnJC2u6XC/3xYtu0ZQdUKkjhEYmUwFw6eX8eXkP5eSc3Rm
	 fU40jIZRBywnhau3sUHIcIr/5c5/YLIFzMCiOVJXo8yYbOymhhuA4iS01yx4gKYLL6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=M5pSj2rL;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEF60A381C
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96DEF60A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=M5pSj2rL
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso1124573a91.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686222; x=1795291022; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZCi4ttrWWQASeF1sPChkoEBldIkxl44ii+iYdI68IA8=;
        b=M5pSj2rL7/XmHVxGodQIkRrkhyJGom7e+lrSa8Tc4r65/JOyvj2hfEOUFEVsxY2zkR
         y3Bm64q+qYfbc1jkOgXAN5XLm4oTPYuS/f8qLvwJ28JiuN4OvREKsD4VRCBE9X+SQMWT
         EDC676u3b689aBT9Gyyg239YFPDYLCEsgeU1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686222; x=1795291022;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCi4ttrWWQASeF1sPChkoEBldIkxl44ii+iYdI68IA8=;
        b=FF3Hq9WeTWw/nshlyEKFBG7TLAsn8Jf9UMD4SvZNXTb1m1tJdgZJbNoTflqul1WquW
         cBPVF0L6E4K92TqE3Bo9N9xc65ZvQf0L8hnHfZKVUFVbbpOZz/31aQUJA6/BrrcIYh2r
         RA3r/o21edM2eHtK317sAjcfZ/2Ufk9uxn49Ya8tcsDlY0UzLeMBKmaYcXVltXvpxkw4
         /527sREdaa/+Y1XkcWyvpqi25jEvaBLHOXAfVqGjDxM9SzXEZUfrDALNuRiWYKTpGQf4
         OW+6Yzexig0wVtL2+EtP228pWi6HtpKEljDvhdiZJyEigDe2CJcSNE3lOcghSUd5Nan3
         sFOw==
X-Forwarded-Encrypted: i=1; AL+hErFTWHBhl296ifQ2uWAxxweULsndsplDr1UnhKKApn2NqeQsrBDMsEHptrwMjEpFMYs+wYD+zdc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iEMH1ioEgVFyZ6yqp+AwvGG8VyrRSlJXXGjRLqgax3MrhvfQc
	mOlDHXDGwUS7rF40fiGKiWG4+w8yWfbg/TZg67qRk3Ujzxa+2KIJBksrumtWlw/EEXw=
X-Gm-Gg: AYBFou3XSqI2XCKXuRC9x5QmTzUkcQOtFFkzXZ+pqxnEDd0odmy3mfbQ/4LgNpMJkqi
	vssEzgHmSo8gbX396/lxXd7Bz/IPsBdYwEXK5Bn4M+yD1iaFjVrK+Ixao8hEZDAJbh5/Y+M1uUI
	8MUXYZqkW8EKPTljJ7yb7HrZmCSpdCms3IMcm7Qtz6/wzpnQwCGKIwdinnSEle8zyqx8QKsQSZB
	a5rMKTqLdC2fEySdfrBX5M5KRL79tX7e9tDmVmXuGi90B0K22xq6iXxHZjZGGC3yemewThOw2A2
	fvyqZM2HXLZenUttrs75tcd6ENEUGuucxSJsc3ITR7uTbQEDCFwEYT1Dae9i7Pw0eGgMUD7ArFZ
	/CkmnyXm1IZwBCkF4V9XiUG63NndJxye3Mij3lIaHM+ZEzNR0ci78vorF4JpCpgCcIPSsTFASKa
	uimJHkUFlxqR+vZm/GC5QeAx0kxiP/TneRhAAFBH88Pa0i+68RNfizzEzCPT0dNXuRglxHCmxhg
	PSnalPdOu2E+7YlWSolILogNS6D+M8rKYoSUOOtkstvSWK1SM07Syqvig6vmktcpsFUDy+FdIey
	/QlFuDVW9buhfX8b27kNQPk2lCYp+NycAI8N6IjLRPdVie21qnvjDT8GHh68/zvxLhN9mWDcuUu
	rAVEg95CBnfTALStKHC+HEJGsKzWxOAGfEhHRNvtN6Vq3yUQ4zni0iEvoHVvRUNwYI14UIK8NuY
	w2cssfdvAI6rTnniF4mMnVnkI7EoMB7ANlSnBbex6ww+brp6oeUbwoEg==
X-Received: by 2002:a17:90b:2642:b0:3ab:2737:3396 with SMTP id 98e67ed59e1d1-3b1b0b9cb54mr5682263a91.65.1794686221931;
        Sat, 14 Nov 2026 11:57:01 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce460csm14709280a91.5.2026.11.14.11.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:57:00 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:57 -0800
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
Subject: Re: [PATCH v2 08/13] mm/migrate_device: fix ksmd oops on a migrated
	KSM page
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-8-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-8-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115657.f63de4714929f7af@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Lorenzo Stoakes (ARM) writes:
>[ ljs: tweak commit message, comment, also refuse device coherent ]

Alistair's Reviewed-by on v1 came with the argument that KSM pages should
still be able to go to device coherent memory [1], which is the opposite of
what this does now, so it's probably worth checking that he's happy for it
to be carried over. Going by what ksmd does with zone device pages, the
change itself looks right to me.

I've tested the device private case. Without this the process hangs the
next time it touches one of the pages, and with it the migration is
refused and the pages stay merged.

[1] https://lore.kernel.org/r/avTu3LmscsttRVRp@nvdebian.thelocal

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
