Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659929;
	b=MNyBFDhYP+eqC/COlv1GuQFjn2QLVa0x7U7TghHdACcOL3+yVm3wXN3QFLK5GaMQlJUF
	 puEyVdotXR3m6WAmvfxrnHlstj5PsklDEhWKhpNWDEekBogEtVmqn0kHDP16zOuul8IAg
	 VR+AvtMd+W223kUJwM+684WKjp97Us4t0fBL9vi2JG/2ig6jmYl7/h8HaIuwmkW8bwktw
	 EGhBzsP61biYKa8A2jrcHqJIUjTesD63AvDomE9kcNeqjALsjXwbf+0urGx6eQ1J98hGh
	 UWu3WDDcINaB5pfo8jpMOdQ1sP3cwrR2bmdcHq6zRhXqwycsRmOgdodSTTOA5CGGPWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659929;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bq5K8Z87IavuvaaKNiqMth7LGJ8zdX5mtp1Bwcp67Uc=;
	b=xGBPBfRn8hLgW6bDnJHRpGOKqqoTjY1DYFcVnOkblsVAZ5wSNQ6JZPtwblYfSOiRpzm5
	 SujA4HU+ZdHp3VgjytxKU4e7AQK9DomdtUTXAj9MHdAzIV/Qa4whn2TQwU3+Uayn2igrU
	 3mdybs1YfV2H6HmemGU2EqRWE83WBlRQizXoI2RtGEYvKZP5Prvq0y3o7OXKTxcZz1wse
	 pRLnO6ySfbejs7lmDhAsuvWvuMQy5P7ccBSp1NudmSmZtkMg0elddnECxYKKnzAG00F8H
	 8z25GM+r/XJ0rvwUJf2SYbNkUc8L+IChhpVYS3arT/vOe//KUoERkj85TtKdBGgYuLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=azAUGPgc;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Ki+KHe6M;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D2606A32D
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A7D2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=azAUGPgc;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Ki+KHe6M
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ1YpOZ2792175
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=bq5K
	8Z87IavuvaaKNiqMth7LGJ8zdX5mtp1Bwcp67Uc=; b=azAUGPgcRU1jSI5UcEdk
	lX/Oam7hV0qSGuaoRoZ76iTO+yUv1p2TSRxSWqw/GV116U6mifykV1LTK1RDVF4I
	iKOPSY3PSz8vfny7Ha9obUkbMW6zmIsYItSxjLycctsWrDJ2rP2Qa4yaT+QQ9KqU
	+4dz298p9gibceQ5lCgFjd5gQzpe1qreD1yq7bVWWajVHsF3DL8u2w+MyeG6JCax
	6uARcxrpY97cBRd9pD/9MBjtHydvImyxeSEwdpM3USUiXBCQARMKKoJ4GgI1FvmR
	xUwASOZFEFsMGQAO+s7arILwa8QlmuqSFhjk/ZCiUMSZ1ZhwWwfuQrgDVwgAtLqi
	3w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j66jhhunh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:25:22 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94960131befso938703185a.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795659921; x=1796264721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bq5K8Z87IavuvaaKNiqMth7LGJ8zdX5mtp1Bwcp67Uc=;
        b=Ki+KHe6MDEgfProqRIGk0un22f7ITJdGDVR8RFLPbBwg0ny1Bmym8YPhpeZ5n8UlJd
         uG7LtT0XBxXgDmmNj5VuE8pkpIlTsmrOYMww30ypNhH3jQGBmDe/EyrlIGJ7jfYGlEL4
         7qYCGuERLyRh2UNAj2kvUeVApVok7C9JRl8404UQg3FXcsPs+CyLH4KFqOWFLRL3Ll7q
         ARh/AYUGKeJJuaXrpWt34OkALRiyTeYrlsd84E/N4Fe1r6aiLKwda5YULwMZWtlFQtI/
         bCN5U4LkQ4Tf7erCDpoVEO1+B3yiqWYQ7ntypEgKTJuWN2IyZs1VtR/yv8W48b1FM+wm
         eTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795659921; x=1796264721;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bq5K8Z87IavuvaaKNiqMth7LGJ8zdX5mtp1Bwcp67Uc=;
        b=xIObbIuVwV8kVxX7IAMhn+YTHOrKKx95rmfYmwigjyA6lgSXw387n+eaXYpbKTWZ7o
         Qm8djih/Hc5AT5oi2rCCGjktUI45qX9dkQ5+vryY6UJ8tPyRLNCZkZbQ7J/v1Jgu3Q6O
         /YJEKXl15B4HyNds05SSFaxb7eAS7wazTYZM8diUQY5dKX4HlP9fh861ST93d9nGbpQt
         ULoTLsgzYab7zPoT6S1ig0LF4FAaaaZF1NhlHNaj9hFo8id3jdiKaQiEEaZvOJ0T9IWT
         q+qlkLuWb6IzLyKcUxtLNOZOZ9zmAIrjWg8w2QMWX+dbh3UP1jTZVd6/hQYXMciClhVA
         Faog==
X-Forwarded-Encrypted: i=1; AL+hErFzhyWh1zIm+FE6nlC52F8o8+gY1rnSNLTGY/rmy8N8eiJWh9fFLkJpMzTWjCgMesNseMLtKyE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/G4t1MbVsQuerEBWYL98mtjZUnouo0vny1I4PKLRRiU7WtsgjG
	QAQKWtmabq8ZbCD+KFkrAhJ2Wh5du3jjdfChKc0/ZgOT316lCnYVddVlJoAuFMd6mS2eB0NF8Xh
	liovnnvokJZAzRNqJf9VfKoP0BAKaLnbY/YV6ULlntAm7efke2Z7xaQ==
X-Gm-Gg: AZFdTZe1h1cpQPEv9tSWDbSXqVU/I3QrzqknAMnf88EFj4v3x9PHsY34OHerHRWrx2S
	sY8mStFtZF8Gd0IorkKHIqZpHLOafriVVdnwjfvVvvt0uF6rjxIK9tS8/26a+u8PBd0f+65mHhS
	E93XRpjUNnivi6iVGFeOZbH01a79ZW4tYG6FsEJE/Q7hoHqKqXgNOg0EuS/P4I8rbPJYu3NSC4e
	kanjBA62G/1hHOeTR3He7JdvrpdAuWscGuw533pGjGCn2r/cpG3YrDY6+pPYpVaDLn/xnGZrWZn
	nGVkxR8nFA1rpqMIlM7K78yQlkb2HKHOYivF/qJlBqLaO+kvDqaqNPOg2WDM9bueysd2Xo/ZjRH
	3wYq8dbNtUxmtskn17D1PD0yIt721x0ZjzsBVIG+DQ4Egyq1zGDVaghD/ElhrVGiCCRAGpcpQs7
	5RH8asnraGn7YzGUQwImc80YT+0EcjtjM=
X-Received: by 2002:a05:620a:1b8c:b0:949:7920:9d09 with SMTP id af79cd13be357-949ba99fdd3mr3499403685a.35.1795659921395;
        Wed, 25 Nov 2026 18:25:21 -0800 (PST)
X-Received: by 2002:a05:620a:1b8c:b0:949:7920:9d09 with SMTP id af79cd13be357-949ba99fdd3mr3499401185a.35.1795659920987;
        Wed, 25 Nov 2026 18:25:20 -0800 (PST)
Received: from localhost.localdomain (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ae74sm1452063385a.8.2026.11.25.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 18:25:20 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
        Pedro Falcato <pfalcato@suse.de>, John Hubbard <jhubbard@nvidia.com>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
        Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Baoquan He <baoquan.he@linux.dev>, Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] mm: GUP dirty + ->release_folio() fixes
Date: Wed, 25 Nov 2026 21:24:18 -0500
Message-Id: <20261126022418.3620783-1-tz2294@columbia.edu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <d088452f-1118-4a06-bc16-1942e523e0fc@kernel.org>
References: <20261119-gup-dirty-what-v1-0-236d69f25c24@suse.de> <4f096d70-6f94-4148-8f47-242b8551e5f9@nvidia.com> <awWNyDZT2SVu2Zp9@pedro-suse.tail5790ac.ts.net> <55114986-0ba1-4a80-8498-bf674d64e01b@kernel.org> <away88BuU8ibcTA5@infradead.org> <d088452f-1118-4a06-bc16-1942e523e0fc@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VxMEZ2P9zYSUeixQSjWiS698t3ojBZze
X-Authority-Analysis: v=2.4 cv=HvjjiETS c=1 sm=1 tr=0 ts=6b079892 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=X-ZpGw2H3ZcMOUJhEmsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOCBTYWx0ZWRfX9MNK5zHN0Vlq
 sS/eOS3jBLh+qk+o3q7GM89q1aNj5niOgtuwrbsx9qbRqr5iIX3hv527NjC4wqvzFZgM+p14m5F
 RCnDJ+ENnySwvNy7D/4ZKfp7Okn9R4T0CgRYMdazak/dO0b/fySUI0vEjhX2qDyMKSVD3EWua6O
 Oz/Wk6Dh5L6rgzanG2qRuAt5LDgu4a0FpiY66PfhsJvAiChlKychEoN7Nx9WGQQ3s73hTQM0+3q
 X/hZxkaHO6kYzEdBQPBvqDkpC8R65RVuWLCyn4pMZ6rAdrEmDgi2OlY7synEtCgJsrZZI2LRnVd
 cYumpMX39uAuZaCHN0YfP0cre6M6bbCDE2QTpud33uGIHK9WzPkXnu6Mzl2Bq6URgrRGCW3MEys
 mPBHM+KhvLLpE1OlNSQJ204jlmjIPIUEGVnwBE0jbZnP5JeqIR3EursPSST6/ZWYdUO30xOmHl0
 0uo6vODecBBXSgET8qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOCBTYWx0ZWRfX3kmXyi45Xj6E
 aB5uCV1zMWRpyE7Now0KH/WnT8kPvBz28Ze//a0M3OyYDx8d/3yn7Wz1gIoR7rDZoifPNPoYsIT
 HwyMGDfr7OFWA6nM03R0fCL8JyPt5NnTqKLrIL3Xrm2eLivgOm8n
X-Proofpoint-GUID: VxMEZ2P9zYSUeixQSjWiS698t3ojBZze
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11977
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=10 spamscore=0
 adultscore=0 phishscore=0 impostorscore=10 bulkscore=10 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260008

+CC Miklos

On 11/25/26 5:19 AM, David Hildenbrand (Arm) wrote:
> On 11/25/26 11:05, Christoph Hellwig wrote:
>> On Wed, Nov 25, 2026 at 10:50:42AM +0100, David Hildenbrand (Arm) wrote:
>>> 1) We fix all such cases now where unprivileged users can trigger this,
>>>    converting to FOLL_PIN.
>>
>> We need to, if not for this series then for all the other outstanding
>> issues with GUP writes.
>
> Cool, and I agree (that's why I placed it at 1).
>
> But who is "we"? Because I recall that "we" wanted to do that a while ago.
>
> (I won't be "we" ;) Pedro, can you take a look? I'm afraid the fuse thing might
> be the harder nut to crack)

Coincidentally, I sent out a patch to convert fuse_copy_fill() to use
iov_iter_extract_pages() a few days ago in order to remove its usage of
set_page_dirty_lock() and address a different race. I think it should
address the fuse side of this issue as well.

https://lore.kernel.org/all/20261120-fuse-copy-fill-pin-v1-1-72a0d888f140@columbia.edu/

Thanks,
Tal
