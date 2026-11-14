Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686201;
	b=GMxVF18H7h6yN2a7MQoi6wX26R90EBOj9Nt7eQeO8hWTYJ4yJR0Y2QHnquI3iE3YVnK2
	 g8RQNzPf8tWWREDt1p1bvvFDgGjFdRYCBU9SYe6EQ+1POBssyg4guqeP8XhNHivzKynGF
	 QWFlSpjToRPam2/HiSDp5iXyvZRAD/9X3Q3oUGe+JcpJZX7oTrRA55vQmgNnkopakoc6R
	 +XV1lLlDSLYmcM7LbAjEFSUoJpZ2rSqhiLJ7SpnlmXue8Nt6qSg4QnyP4cuTglqDYSCZS
	 M25/mylsEBPHtDSvC2SGk3YyjAgwmTfBmfk9qPFwOl5q6Q0TGayLO28DZy15nLMHYiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=hrbRKPtAWBgGhGonvqRjGeinfUOoIFn0EQDX8I3HUjg=;
	b=PZRxWA3dKwXCFC6UyFzi5jTkDBifw3ghGbae9D+C7n5h301FMzcwgbjRmj/65Zc+cZWv
	 C9Dvt+sS8ptjrNyhgUw3wAU4qSeuZaDb4WmcYJ79uD0hNcEbBAkzxIGESz/azpGk7p7Dy
	 M6bk0+47PadCqMud9MI0NDIHHGVXukIATM9FuC7IMSYYMpT8c9W7UJXr0e4NkHCITQnb1
	 1rSzlTaR5Hk0avhz23loZWdxMG1QJkx/SLnTe5GAr+2uwK3c4NQyo4Wz945k/2/u+d2CN
	 mUJZnTQO4OfJ6hDl1inoHhkQbRKE1Hxc0EneCVzM9wfkK0g4RNMkeqBjjaPa6PUhDfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=lpcmlxvR;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B4606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3B4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=lpcmlxvR
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2eb18f4da15so10490225ad.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 11:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686201; x=1795291001; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrbRKPtAWBgGhGonvqRjGeinfUOoIFn0EQDX8I3HUjg=;
        b=lpcmlxvRCJv6hmodqT+/LEBuEuDWpXdlNC697E3qnM/e+bB7/yFvvagB8D+XlVUznC
         H9Gh+uMyZk6vMTFr9lj5LxMxT7Iqjk1a3TTjFBBxd7fRKm77L5p6ygoG6us+ZOCCcBDF
         xSpNSOo52o3wKLo3xPx0W/LZNB7yUHiEy3S2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686201; x=1795291001;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrbRKPtAWBgGhGonvqRjGeinfUOoIFn0EQDX8I3HUjg=;
        b=nKMu/6Dl4y+wZ/On1j8wC2VUJuJhrcaao84zloXg3X8BGwc8revW9vXhh+db4O0PHj
         U3grgZM3diL7VwHRmYQvz2Wt/nz47LE8pVOBkraYJdKNdrvt+WkhAfsEh9mBcLqgKaiX
         O0leLZ0jJ4DLpZEDAsX5hOtx39OCDCRaTEA7Q7MBc9fy9Tg6makiRin/MhQ66nsgwuxH
         PMj2OZ0EcQtBHtoTWpcdLSkTmva8a3tDzaW9BU1Mj2q0i4pF6mOr2iUwu3WVyf0DG//Z
         sJkDmGA+bLo9FTWeQZP9KmEZGSboygT44rG1kS5Dyy7IFKLLHoSQbYS/+eD3qC5VUdLs
         K/zw==
X-Forwarded-Encrypted: i=1; AL+hErHiZUM/W1az1mhESSAkcNTDwCXneFI862Iw0bcQIiBdwATgkU2hHhxMyT+hiNFjyVsDt/+tYTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VT3LO23W0YjRJJ+fhYMgub7tUqksCd9JEcrnCzpu9f7Wl5ZIj
	T1KkYVZFRErd5kscvTqLWZtXK47bw7lCohLasX0ltNeDtJMUzk8+IZhKoQZ81KDNz48=
X-Gm-Gg: AYBFou3xJWNVrr8lxcTqNyLAvjaSLkcEAUD6Cyjh17LI2GtnAflVHcfYN6ad1rTfZTe
	1UcSNEHK7st39IDi5b+G8gdUzgBA5bZeSaGxCFfTfFQsjSzYlCSYym16zU1Eb2hX3aeSK5dLWgq
	mSxfynGodA+IFO8g9/mX9RN1yz1Vcg3nsZGAi1aEsH21PRWhYCOg6TQkOWlm5S1Wau3sFeBzFvl
	aJHoEREiWM1iwLTJhSkWKKoy3iTiQ21Usa7R+sAi+q4ARtOy566ouQDvInGuZav0KslUgAfucJo
	CKLgTT1UahplhJLYiaRiQwNw9peZ3xyUeiRge3OI4lUeddgqWDWJlM0LZFd4hbwrkLWlHMnTYB7
	5DcX0gMHDoWyxrT+cLsDXa7Sez5QJvMwaCWrI/wfAnga1zB2jw8FOJ/ItogFRegCnLkq8NFHrTK
	dEnJUh3bgZmfffyTFRPnwYitPqGOopj2flFkJqYjbn9CeF3HTjch3JhSzE6g7qLA+umn+5V7PTy
	YAQHJ0Nah0IqHNZn1MU7q/er4Xy422UDeaDgDDXXznsO4dewb7RQ3cOTB1xjKf6avRLeYjHeW2i
	vRh3eBa9Ssc/yYO/UBbifd1WUCEGMqt/nL2cs6u/b+8oZi9H6DwqHcoqCR3YMnWHsvZ0jdhYmug
	smfag6nbT+tDmjEmPn22kVd7LeNkkU0tuuXkq27TkKAkCw3lz+JfmGKdnhZ2J3habmf4n5C8iTF
	qyKeGz3uKSqeoKZe+7JwG3Z+9g0KQs5ZCH7AaZgzetG7I5ABmFKNjiziaE
X-Received: by 2002:a17:90b:2e06:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3b1b07e1cd4mr5830748a91.6.1794686200819;
        Sat, 14 Nov 2026 11:56:40 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec63b9bsm10008894a91.12.2026.11.14.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:56:38 -0800 (PST)
Date: Sat, 14 Nov 2026 11:56:35 -0800
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
Subject: Re: [PATCH v2 02/13] mm: cachestat: count each page only once
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-2-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
	<20261113-mason-migrate-et-al-fixes-v2-2-50a2ed382b61@kernel.org>
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
Message-ID: <20261114115635.8346206195d50372@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Lorenzo,

Thanks! I've tested this with cachestat() racing against splits and
collapses of a tmpfs file, and the counts no longer come out too high.

Reviewed-by: Chris Down <chris@chrisdown.name>
Tested-by: Chris Down <chris@chrisdown.name>

Chris
