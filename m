Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC65233932
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860064; cv=none; b=BBYFXeo/nlfL7l1N+KroZyPQ9MiNyBXlh8H2sipACUNk8nh6ZrdO48XKIisSdmCYpqfrmAH7pWs8gfn9cRWiAp+/KYTcPmAN6AP0xBq5ZkVWDatFdIOCYY+ZIYu9FYnm6ZBRT34iGt2pxpwunU3VIOq6htxMaglm4gAptdxXUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860064; c=relaxed/simple;
	bh=Fe1dBK0K0IJe1P5zn7VWDd2lteT1kusgC4yEBjsNCxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb87hCUv86u0yUU9FFVNUm/OCkzbvl+566/Ks8nqygd2UnDVqxezbpE7jvA29ukxIU0IrCV4vvGiSvKKH0Io6+ftfpd7mLNPzHDIg71VSE2tIuZZN+cb7eD06W36fKVPN/RGVOt3F0s489WKthz5I3d9hNjgzzAqFr1QzJY95yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Xn+wCSmT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Xn+wCSmT"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e512a9a6bso109115085a.2
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 05:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783860062; x=1784464862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R//0yPDdMSUye02M0KhsD4bBos+saG3+i2478K3plUg=;
        b=Xn+wCSmTiHrd8a6j4QB7neXrfzupLXqyep1/OO6T1ySYLVq5/xlLLdwL6PiIV/WLNG
         GEOgZl4BGo56u7kAimMgR4FuwPQ12Rf6hbe3FsNSdjkQo/A0DF778ZZCEj/YmN2ZBRQg
         dzn4J0fn3efY8DqJviSWVWc7qy3Ju4sP9jBS7K2yxwyff9IRAy1W8QRXDQkPNPwDQfS1
         2xmVaSCs46BiM0PYy3yONhdjBXcKZyGcuIclxvPoZteTboS/OQjyRagdqj/6wbbYjjtm
         iFOPtMry/6NiO7qdxY8ch/LQ/46z7qPccEwWgXdioAMhVo4ti3PtY/vH9lTiraVTkHzP
         +z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783860062; x=1784464862;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R//0yPDdMSUye02M0KhsD4bBos+saG3+i2478K3plUg=;
        b=bycTSJX6EdAsC5YXZoL3dj5oiD2boB+awcOYOwpx5/A1fdN8TpLwfmvhNyRQI//jD+
         yeVjvKLgSuR/5cgOloWUWcH2jvbIcSzBM4Dn5XdzDjaZufrcg0osT6h6HISc2vJKvbVa
         6Ealq/Jelde5mxGpfhVAf7gYuq5VMKvvQV4xbgunVS6H+8pKIAkf6z0RfnHjnP9fFm+w
         IE9KHraOl4Mn8SJxqM2mYuFK7F0fcIDtGgAatJV96hLQk3uAyz2/ViIqiVP71O6rWOIr
         2fiepnio5m0ytW7ED2vMlbWMN351HvOckN0zlmQ8dDqMO9IGH5RX+5W3pbs75iLYN0jo
         gAdw==
X-Forwarded-Encrypted: i=1; AHgh+RoVS9+PN5l4+H79du9UUjoJ013jQfRPTGisAoCAerC+7Nfptj0xpcfcwGi8x6wDI70Op0Mnzns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTogiE9ylB33QNIDCdrS/fSbCiZcEMbIVJGhJwrZu15e/KoYT
	HgQJcSrKmOVo4+MaQ1DSFGH8mqSwkwf6aKa/xOP40hnoMOMxw+LI+zFXCWcTDoH5CGs=
X-Gm-Gg: AfdE7clIWBBWU6iNZc+gEsMCemy1tnh5Ywr+QbXU5ehCC/CZTv370D2TyfpoFso5BtR
	Ru2Bg1kpt7yxKHKvEpEcv4Z77MlOXg2otAUsv8LW8+Kv9EG+9q9FYCjjZBXy6eB32LXmQwwbld2
	xsOYpciJliPEgRsBrEBJHe1nb19ehLrG6jx2SKHtoMdJujEIXMMNm05S6obNh09wD9UOaLQeYr0
	0pLcnxKCl2jWP8treVcVIma6QccJmlWWTWzVrSTkwLbIEheJjhIHwy04RLVL0e/o8qEV80sVhzL
	2m4nZUxGQ7M2uMhVPfQa85Ajk0Bsp8UmohCNjXK97NG1arcBnjMa/OwYgL4gwuilBCHlv/HaTgQ
	mEeAUD708cVb55b8kdOwQObs10Znr2YkrRzbE37tAPRSkTgZIIvwl31DZyBJqFmBnVrFD8YWgiy
	SQm4YP95r2aidJJ7wDF//Idw9sCY9ahgLE7/kzHXiBmOZBl+ce5bP22hIKcWmCTZ0QfvAREJdvp
	txMoc8=
X-Received: by 2002:a05:620a:45a4:b0:92e:4927:2002 with SMTP id af79cd13be357-92ef2bd531bmr625812485a.39.1783860061909;
        Sun, 12 Jul 2026 05:41:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d375fesm815846285a.37.2026.07.12.05.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 05:41:01 -0700 (PDT)
Date: Sun, 12 Jul 2026 08:40:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
	balbirs@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, byungchul@sk.com, david@kernel.org,
	dev.jain@arm.com, jannh@google.com, joshua.hahnjy@gmail.com,
	lance.yang@linux.dev, liam@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
	matthew.brost@intel.com, npache@redhat.com, rakie.kim@sk.com,
	ryan.roberts@arm.com, vbabka@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org,
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm/madvise: skip device-private PMDs in cold and
 pageout walks
Message-ID: <alOLWNIs4jA0NmAo@gourry-fedora-PF4VCD3F>
References: <20260710105557.1987433-1-usama.arif@linux.dev>
 <20260710105557.1987433-3-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710105557.1987433-3-usama.arif@linux.dev>

On Fri, Jul 10, 2026 at 03:55:22AM -0700, Usama Arif wrote:
> madvise_cold_or_pageout_pte_range() takes pmd_trans_huge_lock(), whose
> pmd_is_huge() check returns true for a device-private PMD. The subsequent
> !pmd_present() branch has a VM_BUG_ON() asserting migration is the only
> allowed non-present case; a device-private PMD trips it.
> 
> Skip device-private PMDs in that non-present branch and continue to
> huge_unlock before calling pmd_folio(). Downgrade the check to
> VM_WARN_ON_ONCE() so an unexpected PMD softleaf logs a warning rather
> than panicking. Drop the thp_migration_supported() guard: it expands to
> IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_SOFTLEAF), and both
> pmd_is_migration_entry() and pmd_is_device_private_entry() already
> return false when that config is not selected, so the guard suppresses
> only the case where the warning would already be silent.
> 
> Potential trigger: an HMM-based GPU driver races with
> madvise(MADV_COLD)/MADV_PAGEOUT: pmd_trans_huge(*pmd) reads true, then
> migrate_vma_pages() flips the PMD to a device-private entry before the
> PMD lock is acquired.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=6
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Balbir Singh <balbirs@nvidia.com>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Gregory Price <gourry@gourry.net>

