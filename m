Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541302;
	b=PakrmNSWXcJDNbFiVaf2RC9YYHd7v7QajiIuVhm0Bf1tEK9cK6szbloAqltvtg+Sbbkc
	 ntpnmzbZLO1gYFSmMveG4FpR6iuenqz3c188J3U0K6EJrkJt4nu1Diq1XC7WdHEujU79W
	 wTuCCWG4R+gGAVehIR9SbxwjOd3gXeqlwMmOgwMNhqGudj4srJuKKHwcoL5+yudPsr1jB
	 8HFHXSLA1aBdgE27ydhMkg13zBtg8nkU1Afdw6usXmGb7mv+8fbA5YQC/sRTWjF7jy6KL
	 5RLSey0S4xDwVL8WNwQCt/syqLWRv8w/lNC3V+wXZsiiFkO1UAKHfopH2bFbch8kBfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541302;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=w86GXJKk57CWbsK1o2/pIiyaV2WJY8p2m7MJiTZdj8g=;
	b=4kogEqXtp9VXo92ItUEMaiw32JX3Cyzzbr58B6pVl9glYSXY9fUVqDAUOb388vCryh9q
	 B2AIsx13/idvKBK6u1V/8FSP5W8RI/6BOD0VgVuYjwF4x2qOyUAAWxZ8hEC+0F+QOIPfS
	 xPaoUuL4m5+bBJsG4pd9NoYcRqnJrPPWZwRDcf9DChkG88ro7HHQF75yYb9OIIOwbUm+d
	 ddtUvCZdBxDy7qsJKJgf98Y6sqcK1lTgQSo92cgcT04N+DN4q4bpWjDpoHQb3mnbY1Mb9
	 wcla4Qh09wqdbsKt2/YdTa+xTCLFZNTGR5ZWW58ocnBG41Vk9NyX0CClCIwCK10MyEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=bRzx2sb3;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=LfjEF+nE;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17F606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 13:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC17F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=bRzx2sb3;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=LfjEF+nE
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1DVZ2b751471
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 08:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=w86G
	XJKk57CWbsK1o2/pIiyaV2WJY8p2m7MJiTZdj8g=; b=bRzx2sb3xvz2LXbC8aay
	FqwNt2HJCwFUZvpm68hsS7dNZ4ezMyXOTmz4Vr0bm0/LEa5qcQe+pekBSl+atzvv
	3IzjboNn25thdp6Tpt7fgV3Y/XmXQl+QuKsUtcJHTnjMasH9hqmDvYmI8br6C88e
	R9cYaBdxPWhb7+Unjy7Gr719pSW4Q/MHdCZQQCoDNtvjcJXMWrI+pHk2uSj5WHvt
	rSvOx9dUmvru27x2tvHAKFtFzlQbz5Myh3LSycHW2Xzvpytn1VeXJr6ZHFczUFEg
	cemnB2towM9yWivuq5OYRXXmWI1UPDtXo8+2m1dPZc2+lBuX6j03oFdkLIpU0okr
	bw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hnw6nsr8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 08:54:54 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93909014c85so460083185a.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 05:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793541293; x=1794146093; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w86GXJKk57CWbsK1o2/pIiyaV2WJY8p2m7MJiTZdj8g=;
        b=LfjEF+nEl44m3pkxy+lpFSJqz3LusfsM5Ame+CJasvbuf4Fhy39yGS5cgpXwe1ZwSD
         hWmd4aUNBYvum/dpklfeOVKaNLixEcb2VH6VD6TeyOLydxt8GlzkijiJ+b8nnQChTEbh
         TT9k3FRXCf6Ns3C2zc/JYYLa3d5RS+gXN5w55HgR+IDq/4P/FHql/3VpsUAE1xNPP/7w
         AD1gxEUkw5a/p9EraozWXJGzkzGx+LOUPk9KUusYgp9YhHpan18hj4Hn3cgKLcgT87xR
         IjZHE1nmONpvb5WXehxz2/n5r2jFaiB3S2gz0qzZ6the+4jSrNsBTxgZLCjZayLRRUZh
         FrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793541293; x=1794146093;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w86GXJKk57CWbsK1o2/pIiyaV2WJY8p2m7MJiTZdj8g=;
        b=jTNmbs8pVEabItoo7AjrMosj6M03M1nkWf/RjjV+4eSd5p+AzEJ5uHbq8Iszr3A+kg
         g6gG2rcbySVeT3FpjpAyF5ql6ZBjKAWp6H7f3WSxleSbWV6VQZ79WnEgem3wRjlrEp/x
         VzOiZN7uD5uWnsC46Z7sFVU5TkVwLcTcQ1R++Lg0bRQ/CvFWjQxbkeFaznXiYttU0beg
         dM5MIP/YPFWZxMnqj5VIJnbTX1YJxWt+tLyA4JPwSVXFEKz0W4jgmnhaMfj9Wf/+itGS
         aaEjdwAtP9YIRSYvcdyavzTxx48tyk9tR/GmeIA07BcdTWexKpcwOiHdOLI/mhEc2iGD
         ebnA==
X-Forwarded-Encrypted: i=1; AKwUvBzgNogZFy4vE8bJO58x6+KE1kL+qKaxEJ5GtZtF+DMHuSk1BRWRprg7OddyMNnnunpkrgChIBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKST35UzN0z7h0jI2RL6H6mdR7rFTNuwGDXzjVk8IeYDoJisy/M
	KiDG8k/zyZUv+KNGhjVnp0pBALndkc/PNgjSN9Zei1G0hrDx0fhjqrY2YiKOq82G6bK/aqLdXXm
	NGinlCdYt9SWKuYfY1S9mpf8iuiYxFbAyUnstdiksI4mZIrJFJJIIhg==
X-Gm-Gg: AYBFou3JNFlghNMDi4x4Btql5g7ZhuDNz+0ZYSFvRs49fML6lA6zuxByxhzek9tF7BS
	DTLCKnnB+VIBIeXIKutTpRS6cBNOzm/MH3+dN5fZXt6QCPDdJ0ZnwvWTuznSUwG1RbsdPsoofwE
	eNwvloh+1Jv0OcTwfqC1V/069CjFO7I/0rhZ59aMt7RiuCNKJdrb70tkdoKlReiAjcKhptE023J
	scHJ7LBENbyCRDba7VKUx/+YUXRuXgJFgEwAPhfhLGmdjqRaiUPtViuQm19luxwuH//8AQ2DL18
	DZrbdXVjYAQef7gs46Y11m75E7Q6Q5cdZ0IqFKS3LaUFtD7c9gFnMmfeFvtDnvQNsITEr2XgWQG
	rSUrPgSZiUSwof4nEQ4s4rJ1beVoZFZJL/SCOKnfQqpxaSXTQsvhLm+NLa7c=
X-Received: by 2002:a05:620a:2710:b0:93f:3cb0:4639 with SMTP id af79cd13be357-9442184df35mr1241527185a.72.1793541293553;
        Sun, 01 Nov 2026 05:54:53 -0800 (PST)
X-Received: by 2002:a05:620a:2710:b0:93f:3cb0:4639 with SMTP id af79cd13be357-9442184df35mr1241524785a.72.1793541293056;
        Sun, 01 Nov 2026 05:54:53 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba2415sm14680787f8f.50.2026.11.01.05.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:54:52 -0800 (PST)
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
Subject: Re: [PATCH] mm/vma: undo userfaultfd unmap preparation when
 unmapping fails
From: Tal Zussman <tz2294@columbia.edu>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, David Hildenbrand <david@kernel.org>,
        Jann Horn <jannh@google.com>,
        Noah Weinberger <NoahWeinberger2003@proton.me>,
        Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
In-Reply-To: <20261101-uffd-unmap-abort-v1-1-1588d7a7c61a@kernel.org>
References: <20261101-uffd-unmap-abort-v1-1-1588d7a7c61a@kernel.org>
Date: Sun, 01 Nov 2026 08:54:12 -0500
Message-Id: <179354125206.1160833.15685446781372913857.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793541289; l=699;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=KVDlIBGZ8sUNXJ5Zqe2o9W5vfay33kUNx6yzDVUOXWA=;
 b=A2fDt8WEiG/978sXfzb8nnpP99XqNHXnaLMw8FlmnzNdVAZqbqVW+oTIku2Zvx1VhqejjXGFx
 FAFeojSy/6jCPd2awvm8clmxE3ND/NxTsXdMTEICuQHLp2+OOZNnpHW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA1NSBTYWx0ZWRfX0gddb2Leeb5O
 MkeZejbK+T20Z0gnzYhH3urlJBMZhpEnQ7j1uwnqiuWk+1ckgvbUzvnaQqZIw4CuBDLwKnws86K
 wEdhU7KxP9LGU4xcLIvarVjf/Ty3jKdEBZy28F1AA2XF1iOVkRmE
X-Proofpoint-GUID: kjYqnLvJHhZP0BvZtDHTDkKtZ4jGFJvQ
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae744ae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=d_C_vffKwV36uL0hTwoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: kjYqnLvJHhZP0BvZtDHTDkKtZ4jGFJvQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA1NSBTYWx0ZWRfX7HnUDiDkHuCO
 ksKQwmoqMr6xGETO4MTHMwKW5mJhDcWyOXYCbisdXJgTZPHUDwFkSHa8Ejkt88dL35HnNgbp/m3
 JcxE2ZsZraN+aMDl7ZfP621DvHia9ZeBs0JoRtKnBsrjro9joAgP+QJ6n2lX9GA4eI6zhygHw2W
 Z2iqfkVH1MTbLkB+26GZwxiBrJkuj3KBuHbHgcTKnzW26N92tTIVSKboHIcic7qEbmScPaLb5W5
 zyGy70Cl+i70nVE6GcP9ZMv4UZcF31zYWDqT1EmKE2VRGaSMvc5a3HMBWGkllkkfcB0LnMJ+MM6
 NCQW19GlNOsCVGP3lP8V1385I0dbEh55670vBakJYSmulVxHWF4l5HryoG+W+QWHlhMT3hle4No
 bLjGRitrNvqH3u60r2VPuYAxT88M6YlvlkNpqm/rcqzBEwTlHNXJruwlHeQal1YUBuZgM44+qsC
 H0WFU9iE4D7+jNoxa4Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=10 lowpriorityscore=10 bulkscore=10
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010055

On Sun, 01 Nov 2026 10:24:02 +0200, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> vms_gather_munmap_vmas() collects VMAs to unmap and calls
> userfaultfd_unmap_prep() for each of these VMAs. This takes a reference
> to the userfaultfd context, raises ctx->mmap_changing and queues an
> UFFD_EVENT_UNMAP on the caller's list.
> 
> If gathering fails half way, e.g. because one of the VMAs is sealed, or
> the operation fails after the VMAs were gathered, the original mappings
> stay intact but the queued events remain on the list.
> 
> [...]

Reviewed-by: Tal Zussman <tz2294@columbia.edu>
Tested-by: Tal Zussman <tz2294@columbia.edu>

-- 
Tal Zussman <tz2294@columbia.edu>
