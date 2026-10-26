Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030133;
	b=HquZgswjNs4tHcpv+EpuxjghcygqFYzcOCXN3MjR4Y18YQ0SSRTzxtFeS6QgXGcqbT/d
	 KDa/W4GwwJjjYSPf5/Zw85KA3qWq0Jxinn2rrHj2GDSAzkqP6daPVPBb1X21Kbf+/ZRJJ
	 2LFcdeayxjEATM7YPejy807DU6qDrLvgWsZurA3u8jvoxuC56XCY1JtiqQtZ3hhIiMFnW
	 iMflG998ghev173z0Oy5RW/s1OrRvF9zeX6ROgQCpJGv4z6uVG12+/uKvv0pPRYSq6Mb3
	 xl3NQxCjxiJgEHXrri83GUXs2S+uN+AReqdcnwNEIVZ+xfrtUJpoln3X8u6YuHKPjVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030133;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gwsaXezjQkHlotcamhKkbr7xlpj223QdzbPDUGHbv60=;
	b=T8cVDlD6WKinYFgqXbA8jayxOGiMoeXTC2O/HxCLjrWLdFc3odVn9gO2cui8B6Gmcbjd
	 FrQMHvPZPmXej5Odv1F2+GmvdzjiyBzK24fknLnc95HDalYtI7k9UJxddDcBWV0cSjGvU
	 Cj2nsssRUiWd1HU0gSUwzVl9ykJnDm+ZG6G7zIvYiSGeQCz3xMhQHDc+dwPns00cllBRi
	 xqi3Rna6dsTx1em5cmZ1FLARPgJjsi/McDSDeRVnxgrmvs0gx8bmRt7w8F7KYx74QpJTA
	 dA/0tpJv5Pc+pAigmWx9/N2Tj+WATFVAp08H7IOw8aXj9MK+SXtP8qI3f5pCFuFNbTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=W+D+hRJd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="yna/zWeB";
	arc=none smtp.remote-ip=103.168.172.138
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F427606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F427606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=W+D+hRJd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yna/zWeB
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 6144F13801C7
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:55:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 26 Oct 2026 11:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793030131; x=
	1793037331; bh=gwsaXezjQkHlotcamhKkbr7xlpj223QdzbPDUGHbv60=; b=W
	+D+hRJdFMYpMlx3Fd2AMqmbxbtAw2y13mHvqkoQZTzqo+8gJLMS8fuQnevLJ7Y5Z
	t6YOApdnFVCRiNf+AomNhvz5SacOv/Qx/3cmCA14pcGV/c2nONeYp504hTUcPJ2X
	OgXSM7oCtcNpnoFiDEV8/4x5dj9Cpgi5+ZEYsGaLznmKEmkLgWOKPtlCmJDnnl/l
	aSD7AOy+vMDV9rHpFbmu9RjFjiRN7Voxtd7VgBjwtZ/ITG4/9cSFKS/vQqpWwtJh
	uQk9gjiZqjihjJEVuR6xoQTd3yhrovVouJpZUfiKJLNrNkXbuT6DLJGHLh8ATWV7
	7P7sor5/plg4S5in5u2FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793030131; x=1793037331; bh=gwsaXezjQkHlotcamhKkbr7xlpj223QdzbP
	DUGHbv60=; b=yna/zWeBlX+TfC73yH6+vZpijUWYtS9CWkRy4pO0UhGcsVEJ1Lf
	lQ4cf+a4v1H6a6uw45aH4uuTxyxMXhDh0rax8IqONb6HSTGfOvDtr3rixn1h6waD
	xHSBhMksSDSRG9kGkjYNBWB1Qcbb0hJH/LzavdjkmCvWhoqLfzRnk6kXJwHmBTt+
	5qDyPSTtds9P9ZEWgRw6/etRFfsIZxq7LS9KRngEzT3147Drtcq4kVzdFFxBzL0c
	CDNA3ZT4f8C5AX6u7LW5vzbFeLw3dTdikqxuXxjfnZxIHdRiVKmUhvXEw0RlZtG0
	aCgRqinhQeNltYV5xxmXsL7kqpOnqHviOfg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793030131; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aBjiKhxWmzk/O4wLrVzkGg4ksqD5Mbo4QuLVyXBabaotxPN
	umA0HbrzPsP5LGMozblXlLkms5ZJXfFF54tr7xfo2PcxYAoThL8STB+qmtmVd8Sk
	dMMPaXY7tC2BgPWH+6QfFwDuMV/MHXWb9MdFuFi7JRraVsgRzrda9LDGw1SUR0Ek
	ijOGYRUV7i1URzgsw+bWuvbHkYU6UW2Ke4F8g98Q68gV11ZD0C/vH7yxLylP/4Zt
	QPCBaDK1fFHh0SDCeYIHsLjyY7ig7rkPKCGgPMvMfocVLJNs/2QfVpnPE/bJfjnx
	TCyW45b/wMCJuSdlGiEMKLR5qgzToeYgKiuCq3Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EDgvaTUJlaS/UoKv7LEg4UiURKcq+3R47PQSNS/IiC4=:XSAakn5RcOVFPexf8/wrEz3tPUgSykAlyFSmQjGytzM=;
X-ME-Sender: <xms:8XffalhyFqZKXsAjcdIBmlCBfLeeJ1dX1nJj6hCwJVYth1NlswSOOQ>
    <xme:8XffakLdbrJKzM4ADy4kgffLHuxzoNnmj1l5eCvjKauUgMJhajEGwsLryNgCRWk0M
    aVY00JBUuFR2rCF0JyQPSS26kug7J0VpzC22XobYUfV22lM7spBXOAp>
X-ME-Received: <xmr:8XffamwKr5w_ykyjt0CE5dwR160epvaRodUlS8Csm5Z7QQ6lGAuPQhzQz2I>
X-ME-Proxy-Cause: dmFkZTEF7EYutanou3ZZN7Aj7xG19q/4w7NFN6S68aRyR0PLTX/e/LvcDG5UTf9uwfTbbp
    Ey64ehGpmBhIUVubBkWTS0IW3Bw5/2GFpDXtmN2WfdQhZt2dZ3IWvFfzrrMFLJ6nbzLgZI
    OBEfIjaY/oIzb1ehpTT49sLAWtlBh8EfIhzg/NFxn0kaW1tEE1IM0N+pveIAmY0dipbBbo
    QTPKLqn6muiyhUM58Ams6E+prY9p1fIVnHLELmwpWEtfvjhamITLyN7ACKMd81Z2ZPqRxf
    6wKOUAIL6S+2u3h7GPhN5XLvduzq7J1NUIWZVSX+y2gTiGurd1dF8cJSscTs5knV75Z8ie
    vDeWaEZiqbkk4jmKqNYAW5HTT6B7CVGtU1fYUG4vK8fbSeg3NVXLeAzy2HkkXSN23JPz0q
    fhBz1ftZ2hk4t0iWWIQHTsXbF91ngKVC3M3QItNY9t3VNelJ7+qqym0ByCrXOme32148SV
    Fq3dr0HSSdqVNyiU25AA+pCudxPJ7UuGu/SenIq5nDEc2UEcurF1Yj7yNr4pee7yYPiCQ0
    fe7ATZakfTdRUMPI3QU++2K8bkeuT9JvmLCTWipQyloGTFrQI9CGhx5q9aEwpLDcElXRK+
    smbckVXSRx1WDXYLNDaBL6xtomPu7i7KJn6dHG0jMUb2NBLQMvTKxedgfgEA
X-ME-Proxy: <xmx:8Xffao9JsL9gujocvrZa6VvrTBfWPyvYIuur8J_m3AnQjYlr2_TCBQ>
    <xmx:8nffaswgqLP-6wnfjYX3Uwp_JmN0Rn5WfuLaC7gS-1zBKVMyW7nPqg>
    <xmx:8nffaquNXeNS3W0s7E5AnKdC4wC03Y1RDTYHOvuC_wmvzrQ7MZ4T2g>
    <xmx:8nffauwh6uAS1bz9-78fVqvw_ldz8c2hU_22bEVTMoGDqOF6QDwXxQ>
    <xmx:83ffaqJDSYndWmXpRMH-MUu6NbxSCMXP2-tX224XWLdl-26ucf_4Qwc2>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:55:28 -0400 (EDT)
Date: Mon, 26 Oct 2026 15:55:28 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vladimir Davydov <vdavydov.dev@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>, 
	Carlos Maiolino <cmaiolino@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Stevens <stevensd@chromium.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eva Kurchatova <eva.kurchatova@virtuozzo.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 05/16] hugetlbfs: enforce F_SEAL_EXEC in setattr
Message-ID: <at93S_z8-MF6UnE2@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org>
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
In-Reply-To: <20261026-fixes_shmem-v1-5-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:38AM +0100, David Hildenbrand (Arm) wrote:
> From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> 
> F_SEAL_EXEC is enforced by shmem_setattr(), but hugetlbfs_setattr() does
> not check it. As a result, fchmod() can change the execute bits of a
> sealed hugetlbfs memfd.
> 
> Use memfd_check_seals_mode() in hugetlbfs_setattr() to reject changes
> to execute bits when F_SEAL_EXEC is set.
> 
> This also fixes the memfd_test hugetlbfs SEAL-EXEC subtest, where
> fchmod() incorrectly succeeded after applying F_SEAL_EXEC.
> 
> LLM assistance was used to reuse the helper and revise the description.
> 
> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> Link: https://patch.msgid.link/20260629180247.2343229-1-eva.kurchatova@virtuozzo.com
> [ david: use common helper; fixup Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
