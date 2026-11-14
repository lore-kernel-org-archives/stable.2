Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686219;
	b=HZqs45qqsx+C2t7tQgC8ZT7LnGgrtEz+5EE8uXK+nvBBhQNi1o8khcZE9dlaiaa0U0CZ
	 EZrxv7AcZvvGV+NsiJwXORzr380h57d20EKl74Xei3ms4m4xpavQLuUF/YU6a83QgNJMH
	 DT1PoIXiZ48ZlsqGP0cXl5RvuaycNkIPOpmoSiSXq2L7Tk/YjfYOFHIh2dIMb3osNFJ6Q
	 aFACtgnU9/S//vb1pg2Lx2wjyy8B3kRU6pfxrrvJmO3fylCLynPev8ctS/gsa6Ray476Z
	 qsN/FuoaCGXq3jTL3vppyYk7npn6HNMydLkRx0ISXTALToZ5ARs8RGUoa6J1SWzEZZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=YJV/kOno9dtsXAkcAOQfE/oQzfJxocwLJi3WPYE6qNI=;
	b=QN726/V1pF9u6MIc0uAKi1gN/ngtM4FKdcn0fn8/kaUD6cMei+emCI2cqjOo/e+jZWj/
	 BkXAupQzhXQuAsx9ilVMFqAbH+GCjnakx7+Olbt3yZALcwQEEWGt2sv3g3eYVND3pbvW5
	 pwZdNBgm01NSDD2H3fx+WV9IlG9AmB7nrER8nm63cs4SKhLuntr9o27VUoDlxx/W+8r+8
	 nT96rOAv7eHmPlJFtFDSGUztirYq0FR8+tvAV5Z2SigINuvWSeYmmRAttN0NoiplqHg0O
	 NHArHI/QaNUFeYlgho27A6wrFbBBt1vWpdsadJcdYxhoA6WHhFVm0uaoM9QSGP0KD5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=vCIej0PX;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EA606A893
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95EA606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=vCIej0PX
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e987a2ba0cso11747295ad.3
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686218; x=1795291018; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YJV/kOno9dtsXAkcAOQfE/oQzfJxocwLJi3WPYE6qNI=;
        b=vCIej0PX9dOhvVI1XQrPg3zB8HDYKWUKJUfIIUezj8rzlKXOq0OMq3pe4wQ6XpdOmS
         NYBcf2KVLtwBMAKAy6dCSHE3G6Ij1MQMaxPUZxuqz0NduffBv7xLdt4vIZKfYghEMKCw
         nsMry00kZ+7KCUIo2gRoP8PU2opDqLwVR/xnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686218; x=1795291018;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YJV/kOno9dtsXAkcAOQfE/oQzfJxocwLJi3WPYE6qNI=;
        b=zZxlpzFcYbfA9fMTl8/8gsTAZ7TZ2kNwAbcW98OKlNSteuRfXHVXws8unDuJcN/e+C
         jgKnBnWWTRo2vL0Kb1CCooZcbIp45Y83F3BjaGLgfPqtlRjPpaJfSwEz3d9k2LNWA6Y/
         vkPNSyXG3PW8bSL6+dOP3tL2m3KWDni4rU4J8TAFtDwWmZaB7Iy27cTKETH4HNKZ8JiU
         /ec65leiGspS8ESgE/ZBh/QuASTsaoAcrmziwAK4t/FTiDnEwgq8rhdnFyn7WkniWP9V
         Mi2/1rP4Qak8D+G9T4/eJckWlgLlnItzh5RDN95ytiHVyTLf681i5/3e82hfvD6kbB7L
         58SA==
X-Forwarded-Encrypted: i=1; AL+hErEx+Nm1HZAZ/LiYoAkXWFnV8CE6a2QGjW7XNgEqTENMCormpTowcyHfhtRNYWsFS2yb1lfLwvc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OvlC+iF+Nc8q499kzR04qSAXRQITYNCKde32QRQbuGtE8e+n0
	eXkffDXGq5cEVJEovGIny0hCklp7iMN/30aHf/kBk4Xusd8ZVA0ZqvvWnSVqM7pehtE=
X-Gm-Gg: AYBFou1oP/t7fAsVVw9n3ENue5zlJZIx77D7gY3tThzC/rwiXobUwcE7orSvy1sWpzY
	4/paRd0zsyRVmnN9aoEhBdIrNapHhFQtN0QWTVk7GokgCPsT9nflRjEBrLdpf1fEMiWisOeMoyf
	wO4al0MSDoyOO0Rq67O+mZENFSThkJ0LJvtc/l8donoDyPIrseRussaHWNRMYnzX12V190BvBxv
	F4yWfhVAK6DLP2rzCZqbS23W4QS405vpN8P9aAhlkJFB4lovoECTkoRRsaY435N4vjCwJmRBNTa
	juePlFJyrrXTJ+yXbzu0PB44QrFlbOWAALuCgfXSQ9VMj94Xcv7HOo5LI99MEg6gzxtz8HjhbIm
	7Ho635XOYq+fwBwXpYsaERGDcJmJD+VGZA9mH4cTQN/3dc7KurjMh3uImdNacyK32T65Tn/Vklm
	Rj3Wr9yxKG/eIttpyM24SWZcJuKViL9+f3QMW8C70m7MvgwiZbDSV5/EmZHQRXZvemwRoeX4dns
	fSHRo27SGzd8rZoeyTexhMg3MYIbPWVIEkN6kyiG0n9eMpQmsZzDossW8v7iUmv7gMn43BcXSEj
	KivRjB6VUSGQnyn7Kmyh45+QCftNjO+KPTqmFpYT1hRb8AAuYA0FdJiimSbb5c5BjHDW9IJ2k1V
	gX4F8qSHY7SZFU/mLDmwNtBTgh26gotQVHetDFnQ26NYBV2dD03/mzOo1YcdDJHorH18s6CN5ex
	fE9CQxy923gwGD0j5Tm5+FADW4zYOtshOdtMrWgmO0vAP27U/ONaR33A==
X-Received: by 2002:a17:903:2b04:b0:2e9:4d43:d58a with SMTP id d9443c01a7336-2ee0d65fb59mr62764435ad.1.1794686218088;
        Sat, 14 Nov 2026 11:56:58 -0800 (PST)
Received: from [172.22.0.2] ([4.16.0.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8dc955sm22202275ad.62.2026.11.14.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:57 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:51 -0800
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 07/13] mm/migrate_device: look up fault folio after a
	split
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-7-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-7-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115651.2b3100f5d9444151@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this along with 06/13 with the HMM selftests that
split the fault folio, and it works well.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
