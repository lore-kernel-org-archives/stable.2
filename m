Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794543932;
	b=05QAwuZHt8pp10V3Sw95ut3Whb8+FomD29lYzwCr16YZEOB42+KIZsJQe7Hz70i4QKzn
	 PT/SigluRgI+LunGORER00z9GSATHAbNvNOu9qkn/bol8Xx4sMhYYyE0s6Cl+xDBuqR9+
	 Od/HOYjS7l4qW7DmKRuL/XyH9RLvHHbTOsWllJwT3DqbJ++GLUlNKb8yGoPZfOkVNbems
	 UzaJqK+IPTC8bpXI/PZu8YaPoLeCbhkYibSPNQHti4eLNJGBWysGrp/YpI8pyqG3Bpk0N
	 OkYenlvgnfyCTg3DpYwLTuQbF2D8BRMF0wRit5orPWlQRErfe7unqEvdcD1e0GasOJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794543932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=IkIvwF8HYTYAvXNQ1Vf3vJhW/UWoUX7BTMENFsGTE9A=;
	b=CN3wyknn4k+Ur7BqT6A7XFkKiQC0xVdqn8runZxzE0TgcUU+LkJYk7hcHYAR5+YViz+H
	 C6ge/8V9PEvwP4ogbUqHVeiC1yECQbP7X7IVoboOthcRo8PI+EWSjp0BbOCQA/rvxgban
	 Q8tVmYGWqxH2Hh8NCXCftNIilzpuSQk/MPNs9nSSQd0l7PTdSbfPLd2Js7FD4lC6LekM3
	 Pni0sPh3k8etRNVblg+yv2gga+cFhaQtuRPOplofMGIhoyV04psbYGgcAnuUc+OhYIpzw
	 ts0qnTUc0qhjpWZ2leJ8UKJ6MLudA474CoGXTFCNSbf1q0ozFDeddKJaDEDI7m5p/+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=B1OG4Hxl;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34C606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A34C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=B1OG4Hxl
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91befbcad6dso11139136d6.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794543931; x=1795148731; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IkIvwF8HYTYAvXNQ1Vf3vJhW/UWoUX7BTMENFsGTE9A=;
        b=B1OG4Hxl38/BpIuzCGtNlDw2GD8mt487C5mv8lJQX4OTX2am2+Kkp3gfikdgAb9+Y/
         1ZKgPsiJivd+Mba4vOf3m0igPUUMTO9YSAf+1VyppPpn8UV7aBmsZIq3W4kAW8gz3K7/
         5Mr7o9YZnWVNQygQQz84uL2CrfsS90hiLVrtWRpFy2JFFR+NjpM+SJ+5EaWwydv8oM5b
         ZNFPctnZSkYg5hOeV7uqrbFp9XhRVKpyZRLM7m11rvzFi8eXGfOI/h+0ipyI0SyEFkvR
         LBqQAeJnZOg0CRLQx952LGQyQImcTolSqD9OoZTTcrVpdr55SSk2Y836a5aWfgqgM5KE
         wUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794543931; x=1795148731;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkIvwF8HYTYAvXNQ1Vf3vJhW/UWoUX7BTMENFsGTE9A=;
        b=eK6I/Rw5+UVisJYPslpCIjX6CtiNW8IeQ4wV+TVoa5p0bHuj8XGfH8IteuUYmvaZJA
         ivG79K5pLRn/zDIxzDg84fkCq8rbYvPsETG18F0ke/oku8VyzqURYJ3DQpwgQ4rpvF5s
         yDwKPasAWM2NZW0Duy94cvvdoRoCxrMXogbMpezlZbmJRxCKrkBNFYZPP5tSjKpeSX3Z
         Pl8apQYGZw7vi77x+0NDqkzj1CjUuNScPx7QKRXEURHgl/qDBcvkCfXfqGbmwuCPFaJp
         /N5cZ76j/6vLfs9u+z30Gb2BsB1AcIL8E9rhJ/HMeE5myyYjyQZYW6DgkIYjZOueXZG4
         VzTg==
X-Forwarded-Encrypted: i=1; AL+hErHcEtS4BywpcSKgYVw5xM6O4AVTqOl41czrV65W9OILmIDDpJlSNavfxedNo0DOzFW9+fimHGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Sq81zCcVpad7ofaBaozusuxBsUvDDI5qcMY0iW7o2+9PI9Jdv
	rGwKRlOzEDIv8xjWIWM0gu2C0u+yiTjTvnzNK+6NpZqfVeY144WUFnDMmli4nXVf45g=
X-Gm-Gg: AYBFou2apJ45m2HxSQot9M94CI8T2brdVoqHC7ICA9WL4A/g5pMhTDKUyWoRbk6LjkZ
	dSZupao4o5HvkxZ1smANzIMwpWlnLnFDu41ZlELts6fBbuCQADRNAcOHDL/a9x5Uxv2+xu7+Wyr
	1CQTghq8v/pzoW9m093QdDnzbFVZZDyP4j8K1tMR6wLgXBgG7SGbwD3FXXrQw5S/11ZrvCZgGs2
	CMlwAaRNMuy4VJ5znqZpCk/WtJhCsHpE10gLRuttqIswTvq27HMK8DeFj0jZNA6WoY0v4lvuq0g
	59m3gpThDeUnUlSGjN2p7STyR+7fgbJDSuWqu5GwvZXdtWWQcy69IuwlG14AsVcXPl3IFrZUu6U
	v2gys4fQaLzy73/szpcZyseUUliy1zCD8Hfh/QU3B7dlwnKd2YmUd8xmSNThWF74+1lgJRa9lbq
	6ozZVQ9P4U+PIG9Jxdp2yUzcFPSZMu3TQhBqlqodxRTSYgJ6q86oeIgnfkuhj25XUvmMzsP4Z+f
	CgI3EOrhKHOaWxFrpLel1+B3tkiv2yPWKId9ei6Y4qpnx3Eyx96Cs/SXX7iYiOohVH1FtjubiJ/
	ckhRijSY1fGh6RylnLA1sgxZ2FBXmWjRDzRKev8yRgfATFiY37+podX8yztFxHzo1xRq8wgqOJl
	gErKPbxk=
X-Received: by 2002:a05:6214:2f03:b0:91c:aadc:5725 with SMTP id 6a1803df08f44-91f241e0e43mr23498046d6.34.1794543930772;
        Thu, 12 Nov 2026 20:25:30 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d458fdsm11668876d6.9.2026.11.12.20.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:25:30 -0800 (PST)
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
Subject: Re: [PATCH 02/12] userfaultfd: refuse UFFDIO_MOVE into a
 non-present huge destination PMD
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
 James Houghton <jthoughton@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Andrei Vagin <avagin@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Arnd Bergmann <arnd@arndb.de>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>, 
 Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261111-uffd-state-fixes-v1-2-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-2-00713d368976@columbia.edu>
Date: Thu, 12 Nov 2026 23:25:28 -0500
Message-Id: <179454392848.482102.8479698323718468757.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 12:55 -0500, Tal Zussman wrote:
> move_pages() refuses to move into a destination PMD that already maps a
> THP, but checks for that with pmd_trans_huge(), which is only true for a
> present THP. A device-private THP or a THP under migration is a
> non-present huge PMD leaf and is not refused.
> 
> The destination PMD is then treated as if it pointed to a PTE table. It
> is not empty, so pte_alloc() leaves it alone, and move_pages_ptes()
> fails to map a PTE table from it and returns -EAGAIN. move_pages()
> retries on -EAGAIN, with both VMA read locks held. If the source is a
> THP, it is split first for nothing.
> 
> For a THP under migration, the loop ends once the migration finishes.
> A device-private THP can remain in device memory indefinitely, so the
> caller of UFFDIO_MOVE hangs until it receives a fatal signal, and
> anything in the mm that needs to write-lock one of the VMAs blocks along
> with it. This requires a driver that migrates THPs to device memory.
> 
> To fix it, check the destination with pmd_is_huge(), which is true for
> any huge leaf, present or not. UFFDIO_MOVE now fails with -EEXIST in
> these cases, as it already does for a present THP.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

