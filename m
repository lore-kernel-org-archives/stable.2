Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504173;
	b=N15m4JosLuiNSHdeqbVPp36hLQ+w/PwpV0vwf5RZc7JhH4I1y6jqiYeCWFAIE8c3yGdn
	 b6jA+wgFlehvj9JdWl2SxKPOgw1h8GrWD2CozoNy6MAorfvfcTor4FljPw4YZbqKn4H/I
	 0/ajYwlKxbVdIqaCktw7Rhqh0gVbCZ/C8OW+Zi5zIhfGarfIcGHz5SkU6oUofY44Z6C0i
	 yZooBdENUCEapFuOnau8fGLxgAwX+OxAahOvCww+REvsCOEkL+6Ome7YoeUCVtdm1Egjf
	 tMSYObW+sR30/zPo/JL0ecd7Ha4m7XFTNyn4COmLuYkUSQRsAd/dnlK2LCAaNBA6o2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=a/JRN/xbf7qsdPvNLlS8GtXasJ+TiojxhhjDTwn3xLY=;
	b=w7jo59Er8tqTyGQtodkz8XQJvbi8kLZfhBEVnmLZ/U0F7MCzZEY7BRFZHm3wtkBWqzFH
	 R1NiPoR+Aq1zVQ1/6Juz99VbVfIdNdhVECDVyW/bDQnjLQ1NHkRzDwlYIHBxKwG1NdxCa
	 e03F5BHpFLuL9hFqxLUDIWHHUFKKeHp/ag8s/SLQQB65ItV50AV0vuGEv5Y7EjZfd0HeJ
	 2mKCBhi+r9JqlYSGMoZHDUBBhzRr8dewXOwgCS2pVzUJ6j4aXkP70cL12/mWpGt4zyUdQ
	 lrjizXpKyjt6p170LuI4N/rc2lSjdDhTBO1wmvoqo+F0exy2oUVEh2RuRiGdc54SHKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vEiLisOe;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7D606A32D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C7D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vEiLisOe
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-54f873cbe2aso45031671cf.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794504171; x=1795108971; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a/JRN/xbf7qsdPvNLlS8GtXasJ+TiojxhhjDTwn3xLY=;
        b=vEiLisOeATJcgaH8HupEr6TgVwYoVfRhOc5WUsJ97Fr/YmUk7miXmTYVniih//0XKg
         QHLJ2ZMK8tqd1Et7ZG+N4Jh0PE0NAP0DMFsTfjohOPnRbNbx5wCi9MJf7GlbX3zGC5bi
         aLUK0quGQJOUi6k1xd8x7SWJKtq9f5WXsAvqMv5Jofuab5LSwieefdRRSscAfGpRNImR
         sbdLr+gv9jGDWpKHzo1kNv1TRF4RDoecODqqKyKYyyViG6EOhcR5hf9KcsCEy5o/DAVl
         SjKv8MglBVhq4lTjIWfDKL+t0qDr6AR+DnZiNsQlHWG3G4GChP1hcSnl0JNtqLZQikII
         00Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504171; x=1795108971;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/JRN/xbf7qsdPvNLlS8GtXasJ+TiojxhhjDTwn3xLY=;
        b=QxUjuRKOesCzlhIRLuDJeUZ2vQTOldVx/ECeNA9f2G+jxgv4UvDEgaCBrQlSEFbXVp
         MTf1XERydXLzOjMRuVCC8cDgPKaTMXrFGqd6T8pe7JLMnnN5lJQvw0heyqE56cASkIR/
         tJm0vS5nOH0Tw955JxpxJOecPRudnvdF6/nR4J/Jc/SbSU1u/Jj7Z4AVrcBSbzDFfWBY
         8ESYghMpGoVWLTkfi5qoHyTexS3AO8Af5JYLbIdSf5LRJNNcA5Gk4DbFyRowoOwxkCtj
         390U5WQnO85OFKKYz5rGj1a/bFfkxfHs7keLYfLLrr37GCAHdbYyy5+oN0RLkrs4OwKT
         snZw==
X-Forwarded-Encrypted: i=1; AL+hErEIs4BZ8deLf9CKO4fav1owyHvcwqp6lqZfRcXhZtCM5lj/5IjEMJFTE/AXFRNqirrL/Ln5ATM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h/UVsk3N/Yg1oubkLKbYcJQBS4A3AwtVvjCoH6dUcr9nJCxVo
	13HS2OlwtKgRSiO6wAdlZjDDXk/itP347pBTknokJmxLse6848cSZFTGK+E2GBuH508lbNl4Y7G
	L9DqW
X-Gm-Gg: AYBFou2p+f6nZN7U4VgqS/2Eid8qa4evxfCnFm71NSfwibvDMWwR5CT1o1VM71bDEQL
	VZ1wtcwljrLD9VU3ZzXL34J9Z3fPjD/uOsWdRU8GH2Cflx3E0Ar86Daof7Bi5//4AJ4Wz4Ds7ys
	XbZxe/PWtcI2lPbC4vIxy5g6qD+QZTNR11facXOKfStWMZGRew3ivusFOTBz/OIWzSmAxrjaCe9
	BwAJyn2bDJ500tj38C16IZUblHhKzm3K4jqeBHNedWss3VXjTg/7DJ82Wug9txrac6f3oUwPzCV
	NlIasGN1nFJ75Ik95lhlko9mrxD4LryvX3zYcoQwnf+GBAzT+VXu+GlAkpuBmvyXBl5KHwP72cV
	mhqnXWTRg3gcro691mJ/GbBNKVLod4aXaesyPecl4lUrQVvBbqRuDuAB9Vg1W/ZwzTEKHJ8pQ7e
	T+Faj3ntmW1h8gIQIhj9xtqNsAB0ATjjBCduRx9p03yFVv7/+KSaG/BA6cfAjhvA98ZPj8UdHXc
	5/jPHqEYVXtr/0YAx2Ph85RHr56eLIgoiO+CQCGzZVt26OXWvEfk+oZPbbV0jCgmWsz88bhnUKy
	FC6Zx1m5VSDi54oZHZbsxQVuE3BKPWX0klTgvAlOc77ywveQ/nzPjGxPP4hdWuN8/FVjeB3V3n+
	9lFUvc9k=
X-Received: by 2002:a05:622a:180e:b0:536:64a3:aaca with SMTP id d75a77b69052e-55ac8e955b4mr521501cf.62.1794504171329;
        Thu, 12 Nov 2026 09:22:51 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d93f10sm542436d6.30.2026.11.12.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:22:50 -0800 (PST)
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
Subject: Re: [PATCH 08/13] mm/migrate_device: fix ksmd oops on a migrated
 KSM page
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
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-8-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-8-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:22:49 -0500
Message-Id: <179450416941.482102.7238369347030508170.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> After a KSM page is migrated to device private memory, ksmd can oops,
> and KSM then stops until reboot. A process that maps the page can also
> loop in page faults when it next accesses the page.
> 
> The problem arises because KSM doesn't know not to try to look at device
> private memory that does not exist in the direct map.
> 
> Disallow this from happening by explicitly testing for this scenario in
> __migrate_device_pages().
> 
> Fixes: a5430dda8a3a ("mm/migrate: support un-addressable ZONE_DEVICE page in migration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: tweak commit message, comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reproduced and tested the fix.  I validated in the base kernel that
a migration could succeed and after this patch it cannot.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

