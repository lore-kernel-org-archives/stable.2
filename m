Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8044AB6C;
	Tue, 13 Oct 2026 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857352; cv=none; b=KPftz5LY+GXtM5qcDk3iEf/4iuej/2Goc6Xyz/IPVhy6dJAJ+CPwZRJdUodYs7g2MSHk2+yCQtxfaniYay3HBi1f3Ny1GjNd/nV/PGYwrPzsowtcmoIOEczmlspmr1c7UAfk9XzB62jf9XunxvTA0J7fj5/68b4lOlarsykvvjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857352; c=relaxed/simple;
	bh=sDfy9Z5QAMrwsYeCouvZ8Ptc0ebIS8iYhvWWC7F2jsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hJrtjnq2pO4FhVNq9Zi9vlyIcWPfSp2X3HB0QftU9B6++yHZSSZXO65bWqXu4gwzIvs3XC5/SXlyFhYyXKu7yn1jADmVQSsPGTUcBqfgdfXGrG0+5cK+rkaPZoAFLfbuv36qXyxnBYA29ZccSv4+GHVkmP6CjN2HyquwXeOKcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FFMga55F; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FFMga55F"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=B6gv9uUY5MOvyVWJ/IrxGRZFdVkZuQ0mQIaGycRX9XU=;
	b=FFMga55FkQcJsg4DK5rabS536AIz3glLytZciLu6YaM2a+SiQ3iieef3Aw866E7BSgezf50hC
	5TI0eii/yPzYoOyCwKsA39e7TM4mF+k/yAub9FZ5j0hvK8dCW0vIUT5HOl4Q6FDjznKWS+RXApO
	W7/EFkQc5mzL53W2IoWyqDA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j3cs12qVrzRhVS;
	Tue, 13 Oct 2026 09:56:53 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C59E20333;
	Tue, 13 Oct 2026 10:09:07 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 13 Oct 2026 10:09:06 +0800
Message-ID: <a8343e1f-92c5-4d20-bc07-1b32f72d8109@huawei.com>
Date: Tue, 13 Oct 2026 10:09:06 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/dma: fix building from the top level with O=
To: Sasha Levin <sashal@kernel.org>, Barry Song <baohua@kernel.org>, Marek
 Szyprowski <m.szyprowski@samsung.com>
CC: <stable@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20261011223358.2327625-4-sashal@kernel.org>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20261011223358.2327625-4-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500007.china.huawei.com (7.202.195.114)



On 2026/10/12 06:33:32, Sasha Levin <sashal@kernel.org> wrote:
> "make O=<dir> tools/dma" fails:
> 
>    Makefile:27: /tools/build/Makefile.include: No such file or directory
> 
> tools/Makefile clears srctree, and the dma Makefile only works it out
> again when building_out_of_srctree is not set, which the top-level
> Makefile sets for O= builds.
> 
> Also work out srctree when it is empty, as tools/bpf/Makefile does
> since commit a89b2cbf71d64 ("tools, bpf: Fix build for 'make -s
> tools/bpf O=<dir>'").
> 
> Fixes: f74ee32963f1b ("tools/dma: move dma_map_benchmark from selftests to tools/dma")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/dma/Makefile | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/dma/Makefile b/tools/dma/Makefile
> index 0c239a6b9eae5..20ae7f09cd206 100644
> --- a/tools/dma/Makefile
> +++ b/tools/dma/Makefile
> @@ -7,7 +7,13 @@ bindir ?= /usr/bin
>   # isn't set and when invoked from selftests build, where srctree
>   # is set to ".". building_out_of_srctree is undefined for in srctree
>   # builds
> +ifeq ($(srctree),)
> +update_srctree := 1
> +endif
>   ifndef building_out_of_srctree
> +update_srctree := 1
> +endif
> +ifeq ($(update_srctree),1)
>   srctree := $(patsubst %/,%,$(dir $(CURDIR)))
>   srctree := $(patsubst %/,%,$(dir $(srctree)))
>   endif

Acked-by: Qinxin Xia <xiaqinxin@huawei.com>
-- 
Thanks,
Qinxin

