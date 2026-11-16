Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825423;
	b=luNbf3UxQIr3C02jknKds1vGMYwGmmCgee659RdeUtCgu+WS9bskchUrj3vnIJeT1S4T
	 DEnveLeWCduss2KUW+EN+hCPiyc448QHQIaj4b0up/coBf+FwD4tNLFHTCXAtnwygesV+
	 BXNkkB+wqIWTog+j0hOg6GNTSr395P5yhxMfjieq8eHse5b3PpcRaHu82IrPXGjC+ebbp
	 kQ6couzPz7Zg9ui2aGN9nlFhI06luYAnkAR33yDoi0Ba2cUCa6Vae0k7QudOy0hWWmdZT
	 k8FNzPXxH+6EvrYMsxEagf1v7fM3Y/ixcglienQhGHMddKSp/gWU5MSYtNawkA9mkIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=j7rA6Xl71xYXKV83hCBQM26oVzIZlY/G9Jtv6N99/NM=;
	b=AE6OpNvjMc5sw1KC/Dzo2lU8g4G5flejtFkFC7c1U4HncOOwmjesOZD0hdQpDRYqn564
	 qP65aVEm/Jli95iadc7/wrTUX6//Da84uY1XJdSHm61t1GczddHGHDSQ2vMYtsA8iQdDJ
	 9KQrmv8QYdjlvQsdCA1ZO5zuDrrc+T0tWks2SfPfH7+4tz5iAHpg2dS45ONMrJy9SoPHn
	 78b4C65m7+QKBacb/P9Zwa1PtixVVAGrOyE3WCcUApeOcxxXUUFE4gflLD95UdWmsTXSV
	 6JykrsRCF05VTRJOjNN1T1MfLYKdFftVY69vIsBhRoE7wqgPbrU/sQyVDc00HUA2v6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CYjpqhem;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842FC606A333
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 842FC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CYjpqhem
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso21513015e9.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825422; x=1795430222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7rA6Xl71xYXKV83hCBQM26oVzIZlY/G9Jtv6N99/NM=;
        b=CYjpqhemh3mP5y+Xnc7PPARwBfwvseC3AsgJ40oTnEQhLKs78Yays0/ohg4NCCoOQT
         3Z9FE5k0yXuYxk7qk5Oe64I2JRJNsqEEucSuvb8XZs1EYAdOZ/9JuhF/JoEQpoJvGjR7
         yq/IozEtyuNQJgmrP4IKMvOdj/LbgvZ0vGg0ioa3vqLooeuLwvP8rrmt9IYQxW39jRmX
         4hiaMbLFAoJj3c/s7Z/RH0pt1PtK7G2tPd1C+OA8xws5pAdhN4/ViuHS1k1hQ9T7jvqH
         b4aVaGHlc7HBDuWc+0lt7jCNEnXITSpRaJLXobpNAp/2SnPIjbZxWlh1yey2BWVgj+fp
         vOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825422; x=1795430222;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j7rA6Xl71xYXKV83hCBQM26oVzIZlY/G9Jtv6N99/NM=;
        b=dV9CySYSbRaMaDRrbrOoxkOWaeEB2d1WwoC6VGXBam3U5eseJVGqhinIlCRQEUTNIE
         1yUbHmrHzk7CQtCydKrEDAZlSVPeejlQkLvCIzPZjfFwosi5baS34MGSt/40mecCZ6f/
         VJSO4mT6IaXzkFSDbZSkNBVJycWrmGJ5tSg+rgLUagJB7w3Szg/+T/jlBzYVxHY1kJM+
         inz+U5GAqkbVCadlgCyovpnoQ7lthRED6E+Ul7L8FPcIE7SjG2oZSSVyTtibuQyE8vdW
         Ym4qgdh15ltGecdN7VFlr/8g8BkKOoXOj8SBrlQCbVYS5mArfEd9WK8Obt/nL+hidAaU
         5gnw==
X-Forwarded-Encrypted: i=1; AL+hErE6HalnugqF3tYCzyCfZu4c3g2laWlRFmSWJC3p7DvUO3grpl/Zi436Gj0mAPeXRPXa3+wdKjM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YHHxLl2PzNAnX5G7ViGubWWT2rsbY0Cs18RmxwBUh/ZhS5A+/
	mK/AKgowbipgmSebQe3pYzrsNgmRupkZA0kaiiZ76Wd2Kmz6MmPqkwLR
X-Gm-Gg: AYBFou3G3pn4ofX+ADsxGmTpBKM/8xIDsxskxLO2NWNTlVaoOPGnXDYJtULsr3GCauJ
	qnpk3k+fLE4R8NCLMnYqzH2PcSveTuIf0Icd0VT6b15KJHNSeKxvcj1HhehKQtEZE3BnopjEqgn
	PLBoXkXskGQI5Sil6GKNsJVfCnsm3fszjlz+d8eCl5L9Gx4CtcS6nLzbF2FsykKfd71iIvgOeL8
	ptHzfg2jY1+8nBFz7v2ZaOFc3iZHWfBMnZsqIlSWGBY/xqjVvb6t1VYkyEcpVeHOfcCB0AAg8hS
	5aIl+N5sGIrcdS3OEjFXD6NVnMEmnayAiGpLl3tAfp5VYDJH+UqBJ2+U0HpwVtll5xgwZAOx0IK
	hZNqoSLvOlIggsdSnwXu3D+t69F8FFh71aAwQB46lAjYDall2LFei+s+TMmpYenkwD0ADmctbv8
	RiB5kw8+aNDeE4VRAaHq1i1lcsMDtRYZmkqA9CEkSbFqxsOyfFZ+cAQcXfRGK64Nxv+W8LIeKcS
	VOtzI/O28MBSoPxGtZNNvlnNIELzLxstEMm8uAgDMc+I4p5+osgLHfs//hG5Us+RTNehOmIa1g/
	HjGnD4+Yy3zrzS69/8GRAQoc
X-Received: by 2002:a05:600c:4e56:b0:4bb:7292:b871 with SMTP id 5b1f17b1804b1-4bb7292bf16mr53530855e9.14.1794825421700;
        Mon, 16 Nov 2026 02:37:01 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb62d5ec30sm294131895e9.15.2026.11.16.02.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 02:37:01 -0800 (PST)
Message-ID: <fea564eb-eafc-454a-a6ea-877d5285ef0d@gmail.com>
Date: Mon, 16 Nov 2026 11:36:59 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/memory: do not report OOM if insert_pfn() races a
 huge fault
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>,
 Roman Kisel <romank@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org
References: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
 <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261115-huge-pfnmap-fault-races-v1-2-537605643f6f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 9:58 PM, Lorenzo Stoakes (ARM) wrote:
> From: Eliav Farber <farbere@amazon.com>
> 
> A driver that implements both ->fault and ->huge_fault must anticipate
> concurrent use of both.
> 
> This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
> concurrent with faulting, as that only holds the mmap write lock and thus
> does not exclude faulting threads stabilised by VMA lock.
> 
> This is not currently safely handled by insert_pfn(), however, which
> obtains its PTE entry via get_locked_pte(), and treats a NULL return value
> as an allocation failure, returning VM_FAULT_OOM.
> 
> The issue is that get_locked_pte() also returns NULL if the PMD entry is
> not a page table which can happen if a concurrent huge fault installs a
> huge PMD entry between __handle_mm_fault() observing the PMD entry to be
> empty and insert_pfn() being invoked.
> 
> This can result in VM_FAULT_OOM being reported incorrectly.
> 
> Address this by proactively checking whether a page table allocation
> actually failed, and returning VM_FAULT_NOPAGE if the NULL indicates that
> we were raced instead.
> 
> The same assumption is made in insert_page(), however only DAX implements
> ->huge_fault and can reach it, and it serialises faults of different orders
> with its own mapping entry lock, so it does not require a change.
> 
> Target the commit introducing the first driver able to do this.
> 
> Link: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> [ ljs: rewrote commit message, trimmed comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
