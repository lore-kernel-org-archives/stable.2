Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914041;
	b=oksKaYgQ+4UYUfrVFq5o9XQatYSlahkNx9P6IGLWdKGSGYEKfkspHmx39lIlT1liIF/M
	 s2CyyZcgVkMC3bsvfHzFbe1C82j7IpVt8jBGf1HosvBOshY697mT1FvLVOK0tyO7DalpW
	 aO66v+Gfly4mgI3ZOx07WzrxoXUCldqWlIQToFfl7oKyvhAIKs7cmtlU3/pMKpPZETXY/
	 f/94EveGmE0p9fLm4dHf0ac+GRXcy8QgctFtCJoNM4muVPSf9sry+T2CoeCvLFQ5eO/Ff
	 8BYiOc1egKoXJq7zNGKi/gKNQz4SsX+FZwRtnm7EqeywChRIQyWXGrJ/drDnJGtXr3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914041;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9H04yuSe4iuUyFfUm6ir/Pk1kCN7uCCpIfbwJZv1Sk4=;
	b=OWTqPA7Oi5qPqa7kwSY6efpqBkNGHEryPHRKF6p2sUk2FojafSkSB5/tCDSS9u7Fxjy4
	 //ZkRgSMfNVuciKGfkeM77mLa1S3ko7K5qTqK1Y56leK+IGFwkbSmnX5MqoOfyn/ozikA
	 bYRjq1564aB39u2ZNNX80rtjxdi7Q4VeNeFbkV+yTHRHlbk6SvLlVM5IOAr5/wubarENh
	 0FxNVRoJOVWojudRm29IGe9pTpI+WelugbQdzEoS/MZfgGD9IMBSpDAtXwUwsKsjVPxNE
	 QMrneNR0e+46y3bBq+rKQMsAqR8KqQuC42rQ9Pf70GKlyclcdrop4JuOMy0ZHnhbMXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXNF7jBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CC606A31C;
	Tue, 17 Nov 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXNF7jBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5AD1F000C4;
	Tue, 17 Nov 2026 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914041;
	bh=9H04yuSe4iuUyFfUm6ir/Pk1kCN7uCCpIfbwJZv1Sk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BXNF7jBCq6IBVRs8bcHuIiy4SYdEAvQD/1BqOxedgS0k4U9/MY0woGeDk7tyVGRsb
	 FMbI970Ye+uivMM5rFr1bwBtQO+xoRBStGQUVguX6XRveP7A7ATuvrrtj0ECW4pecf
	 waO/ybGcfsxuMq4WZ5Lj6G4Z+j2MMn0YlWxGxc0hjXe9NX3++Jslu1B2CQbvas8KVE
	 HbAXjVHCSWCxr6EkbfYcE7vVuQOqZ5olMfFjKaBJ5XTc8KzjOVablmlbZwcDVPjLVA
	 J1kscR14K0bMYVpcn3Ws/IHtY0XLhQ3RxJH3Y4k7GJwjCPGgdSy9phLftR/LBrQffJ
	 BE6z7J0XKMftQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 6D2AC198004A;
	Tue, 17 Nov 2026 06:13:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Nov 2026 06:13:58 -0500
X-ME-Sender: <xms:8Db8av7h_UOsysMwvcP86csyLI0_L-Y0fG1zP_Y696MEVpVoGSo6pA>
    <xme:8Db8ag_C-YcksC8UEt5JqwVrNrFqw7N4ayelai8n5bDdR44rqlcW-oj-dq30kswsm
    TurKg_DLy8QPcQC18_IVy7cAgSuPNo0ucUTMY8f6Nf3JrRhjkCyWZux>
X-ME-Received: <xmr:8Db8ajJpxWRgU6AnCZfhG1HOiM4eiQeGdPrQuQmTXehknwhbVc9wyuTJqDc>
X-ME-Proxy-Cause: dmFkZTF+JKJTFhO7l5xRceP24AuGfujUQYiZxnoeyK5tA83zfmMRcw5/8FhiWDYeqCSpC6
    T6IC9ySjUHbOB+fpES9ocjUyQ76AHREBXteYhc/tTYbmY+NhXgoz5EC9qWmtA/bgfx1HcQ
    G3d0KvtgMZf8Ub9RJZlly0ltGkym3kClsfEB1T7YifuIlnuXXZdlnKkViCO3FwoDnOOoNU
    fnC07yqnaRgq+GBlBbKihyppy/cbRRiQR+t3z+FOPNU+/WP4gEOzuHSdR4pA8vgm07oi2g
    D3/E4LFSDXcLeLK/W8zOGBJMyubGd8PdT3AVGSvP39vq5QvTlAf9/kSmgnbhnuaJbtvetr
    QZIlkZrx7vANum40gg4v0gwpBxHKHqEL+fAh/bqzhJNG0FBXdi9gYVPQv7BV+zxuXkiHFx
    P9td+ZlRXFYdDU4DOehwuQZzkfrT5O4hw9eNghGseaPrMxtOOlyqszK/SsGikF0QYZdFuI
    ULcq/QuFEs6cf00KI/A6/Bvr+f1CfBwzCXierY4ahyW6eSdqVyCzpz6dFMaQV/LqCuPMtd
    k5OGuumM1Gv1yTxagC6J7H7NVrKyRWfZxMOGd5YwkFsimiV5aStmtxkyBAyFahfVVFV+Uv
    VHwuJSGk7buXeLxgT9ESlFGJXKATIALexZo+JJBnJbrq7qBblldkdK45j4MQ
X-ME-Proxy: <xmx:8Db8amfk0bunvDgiA6VEpYeOjqUloHypf2omjhvAtlcxCPmRt6ku3w>
    <xmx:8Db8aiqEz6AHO-G1dIo6Cxt0yxpSiwmh59qHZ_AOWG-Fbk10sRnv5Q>
    <xmx:8Db8anvHdUtnZwFV0GXcOVB8a_cROsYdtUX45OOlP2nTmQ2wKh4j-A>
    <xmx:8Db8arci-RC-UdiaB5yKwSiLiY2Db1UCTL5QN-r_ic6fok36Lv83IA>
    <xmx:8Db8akoOfVKWmLDdEFAHbFQrDXgCaRW25TF24W6hN7Ryn2vZzkFQ0TXE>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 06:13:52 -0500 (EST)
Date: Tue, 17 Nov 2026 11:13:51 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com, 
	mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com, 
	vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] fs/proc/task_mmu: account device-private PMDs as
 present in smaps
Message-ID: <avw25cL2uCsbuPpC@shutemov.name>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
 <20261116063624.1382944-5-usama.arif@linux.dev>
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
In-Reply-To: <20261116063624.1382944-5-usama.arif@linux.dev>

On Sun, Nov 15, 2026 at 10:34:58PM -0800, Usama Arif wrote:
> Device-private PMDs represent mapped pages, but smaps_pmd_entry()
> passes present=false to smaps_account(). That treats them like migration
> entries: mapcounts are ignored, PSS is charged in full, and exclusive
> mappings are accounted as shared.
> 
> Match smaps_pte_entry() and mark device-private PMDs as present so
> smaps_account() uses mapcounts for PSS and private/shared accounting.
> 
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
