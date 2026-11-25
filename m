Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795620941;
	b=lPAwgf1VddmZ5pf2h5EQD7pTNrTwcRY34YQATI3aa82Z0vU5Qmag3pNqUTjQqzCIACnB
	 RGUF4vU7a0Wo763oQFKrkJTsmgoHw0UnX3r8ga6rmpEzZwEDiz4E5D+xu0kV9Qh9bKiz8
	 MtSSZxAVoDFdRjSW4ZKJ/Mn1FNtAtR+eNGQMl/eBLUqnvhCqbf42q+nWp2Pmc0962b6/n
	 MDEwhPvtIeWgT95rZN7JEPXq5dQ401ZfDlScL65bMPi4qPLQgf9Qpjvbf0iBh4+T3hLC3
	 5Zo5EeFgjyIoF5C5m3gKWAl6K2oG4qolmAFe4U1slc2jwofZ8ABZr3t8tobwBQcDK+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:X-Google-Nh-Sender:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=oGmzIPeBX3tzs7DPmiwC0d3aA7TfOiCBq2btcn9vuRw=;
	b=r9KnavdnR+yn4qzbyOUrKR78RXa2LqSWK7N59XbRWdeAA92MEzyOK2RhpHU95egKTh54
	 poXJDbKXW1FIOk1/0s4KZ434VvTn5WGEsRXpu0y3/SKsPwOiRITVgvIw/XldFerZT0aZP
	 R1IPlSzvBaApFHlKXPjP2Vwop9nNGjhf794TAEaT+0tpp4WnRm/dLU6enIwmVK9qVDEn8
	 8GxFxBMqECWncTcQ5ggBcpA94ZexdkRPbZqchAzQk5t5Epp4JucEuVnTru+MQFiw/6Ud5
	 inpnngB7EIq7Ehq2dx6e962i3R/aKib7YziLc78VNf5h80wV9sFJ2fkWlx8Wf8V32nQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ime+ZXFT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8560A261E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBB8560A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ime+ZXFT
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-8629ff88e68so2220853a34.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:35:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795620940; cv=none;
        d=google.com; s=arc-20260327;
        b=c3sdv2V5/wr7Mgm6cnJ7o+ad8Cb02qXU3plHl7e4rgJc67RYETU+13jUYtCT9GdP/6
         dy4Sz44JyHwiwWG8CJeXJxVcxKx5bgo75wOahTg7HuprXC3w4Ed7JCotwBZKHyQwvku1
         yucP2BBpPtQJqcDg6VDggpesXJn8YTbOle9UKg+a+6K5bNMD6GH7VZha12I/+5Mkm97t
         jBNiU1L/58wUp34QYg1wCz9Rh4MILtr0MrwkJvAdSTyR1ALAV0w+j5qM4Gvi4mqolmvK
         0XDN9iE9c2j2Ms9mJHcOPLA5ZM7XL6nCGD4AbWPg3wwB5mudb+Q0A5M0933qSW7xO69T
         b8EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=oGmzIPeBX3tzs7DPmiwC0d3aA7TfOiCBq2btcn9vuRw=;
        fh=vu9SToLa5WvrQhDGib9qaEahbZjnPvT8sBHl/+1fggU=;
        b=TkQjM761hvFFTJhPj7/rAYUT/ji8oc052JtHhX9349OnOi5+a2JsCSjCpA3xfPpCCW
         VfKjVMxl+L44mwFWAWC6MQJAsjX54F8vBlP6ub0UvJFZ9Uglmxu77lZePOq9lV6hg9//
         1makINqM7+X7YBZOITo7XaZHojy+LhVmgthfTHT+5oXw17EF4setoJU0iatGo9DzHBcY
         kXAe7Xrm2HWIkFz4GHY+ZO4Mxr8Sl7TEp6+Nf+Sr/R2aCFT+xG4tYtbxD0AyGnn3EqYc
         0TWga5IScbBkI5fFTK2Q+qwUQL8KbxnSOzRgnx0+PQOjsh8tcGoF5Irn4hCRhwQQuC6Q
         6jiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620940; x=1796225740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oGmzIPeBX3tzs7DPmiwC0d3aA7TfOiCBq2btcn9vuRw=;
        b=ime+ZXFTF5PgkPa6Kg4hOGI9XnY1qgbL4vmSr2qA/nyu5DCYutevarWM67WvoiEK7W
         7Krpx4pXAhkj8EhRyS3hXug21++546s/zwWICtB2LSgQRSMTaGgziBLxq0EiVJVWRLlW
         ORxln/qu4d9z6i8ynDI6a3vWVRQTW6fpO4HPJeJoq95+HuY2SJ8KfSoMm4mBh21LsBRo
         JFbQyhwgbjVMsg9fJUFwjXy8PveRx4j0rDo80CoXB6hR0k0NhkHcBEd+4h6d2iOIg/6M
         E+KjZ34YeSA2O8oT3B5X7Re68KHy832iUnyETFeiXfVu+I+uB2UkzoDb2eXlkEk0Cann
         V2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620940; x=1796225740;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGmzIPeBX3tzs7DPmiwC0d3aA7TfOiCBq2btcn9vuRw=;
        b=F5pezM+ii5eIMf3dJ0UT05R7E2siyZMxp0u+ExoWLK1/1tplTRWIFq6C9ll0+UHQ7J
         WEs0OWFctKtfJ7YcamlF4Je9MZ2QJfB9cLHl8DP5dX7yz1kBGZ0R+RLLRKUCedVRnQxC
         ufMpiUEpUWZtIE85aZTkYSaVPwqjhvJlQSiKkNfudXi5g6fG7ELWdj/s3zWN5o1deo8Q
         y//VdTpatwwkbIonLKJzOLGM0fcW+RTMb8dXAIt24yCUB0NqSyp3LvwZ43ktzD3qbAQf
         9kWuak3RdQXMAp0jIuDrJdJryCXrHOUp4ioCbi8hCLFy4yyFqtKjXANhW24lZ8YIDj9E
         pBrQ==
X-Forwarded-Encrypted: i=1; AL+hErFx/QfbonlFQ9Bu0//tGniZ9N9eGPFMdyXt1ZUXR3bdU/QoX0RWj/r9T983N0lhl7iHQCP0muI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pKF+qejyZ3g75S1l1cDb0HcCAjK7Tkb0kpBh59PpgnWwDhaG1
	3ezgN+0lnWlZ/uDM14Pu02J+sYs4UJ2ipE356IYTOJF3UXdhBYvU0u7W/K3AM55RSqUCZQZfbDH
	IrQqbA+VyLH0NMYelwX8ripDw/nfRCDw=
X-Gm-Gg: AZFdTZfEpJh5C1vLNbrte0sI2GTYZlem8LwvrAWzz2pYpuFYpL3w3ivVyxPBa+otPmI
	wscTAfLsrfeP+McGzU3JHonl1s+tox6K+lz8lQkQvsorfY6ru28pNJOYTU+e0nw7wozXU0WdZWn
	hGujmbILikIhuK04gTzxvECppyjYtEI8bfEbCG31HDH3cXHW6oeGV+zXddmmACOZhr9hWsrN8oH
	tEwahjCdtPJvQWntTfs/+6XQkUPjxEoXwJTrUusv6R0yIAQi1l07nTDvO1uO+W74VUH8xxyF97G
	VuqKxX4na19WyT9twBNcEEXtpnBaoitntZnb8FVxSOxp9fp1QfIo6yMvkRkKPS29wxpsfaFtyzy
	pC7VZaz97t8ygk7E2dwvrGFBJO6yZusHRs9VaKOGl7IG3AX2oT1kTlqb3aznFyyDFADkf4xDca9
	8TCYvmJY6aLD+Eexrmda3ArVDRRog8MNOR5Ob9ePAL+pDBESF8
X-Received: by 2002:a05:6808:4f46:b0:578:c3ab:6abc with SMTP id
 5614622812f47-57a0ae27349mr22158101b6e.32.1795620939681; Wed, 25 Nov 2026
 07:35:39 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 07:35:38 -0800
In-Reply-To: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
References: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
X-Google-Nh-Sender: AW_J_UrQlBOqZOnyypQRms-WIzPNUGKKuKcZIXC42gjnUzfco8roWTACR7VkJYgNn81PckhccX2Z8o9Xn-0mFO9N1yJeBDi52RWHfEVs6AQK1KyDvZcPuRuGciBbXoKEiPmPExoAhR6UK3T86QnwEMvvHIIeKfltaGMxWLdqDdSc_vySTNgGsv5ucv_IP-VKkwWkEap3At57Bz8KSbGkZHGs4m8Sry-pvp1CnC-jYAx8dEkFExzf1JTTMq_XNtcsa29E2p7K
Date: Wed, 25 Nov 2026 07:35:38 -0800
X-Gm-Features: Aa3M54r7k5hNoC4v85ROE9NyxSX5pkWj_j_Ql2QLsZwf6aRX8G_gyLmwg1pMzSw
Message-ID: <nh-8c393f29-d063-491a-aef6-9d95b6714638@google.com>
Subject: [PATCH] lib/test_hmm: invalidate all mirrors on device-private migration
To: akpm@linux-foundation.org
Cc: mpenttil@redhat.com, linux-mm@kvack.org, rcampbell@nvidia.com, 
	jgg@ziepe.ca, leon@kernel.org, shuah@kernel.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>

On Tue, 24 Nov 2026 22:53:38 -0800, Andrew Morton
<akpm@linux-foundation.org> wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: lib/test_hmm: invalidate all mirrors on device-private migration
> Date: Sun, 22 Nov 2026 08:53:12 -0800
>
> When one open of the fake HMM device migrates a folio to device-private
> memory, a second open can fault the same address into its mirror page
> table. The second mirror then stores the inaccessible device page, which
> can oops the kernel when dmirror_do_read() copies from it. Store the
> corresponding RAM backing subpage instead.
>
> That conversion also makes the backing page's lifetime significant to
> the second mirror. migrate_vma_setup() notifies all mirrors before CPU
> faultback, but dmirror_interval_invalidate() skips the notification for
> every open on the same device. The faulting open clears only its own
> XArray entry. The other open can read or write the backing page after
> migrate_vma_finalize() frees it. Aveline reported a KASAN use-after-free
> and stale data through the second open.
>
> Handle migration invalidation for every mirror under its mutex. This
> clears pointers before faultback can free the backing pages and waits
> for an active mirror read or write. During system-to-device migration,
> the migrating open installs new entries after migration; other opens
> refault on their next access. Remove the now redundant XArray erase
> from the faultback copy loop.
>
> Extend the PMD migration selftest to read its last device-private
> subpage through a second open, then fault it back to RAM, change it,
> and read the new value through that open. The trigger is available to
> a process permitted to open /dev/hmm_dmirror* when CONFIG_TEST_HMM is
> enabled; it does not depend on physical GPU hardware.
>
> [akpm@linux-foundation.org: fix device-private backing subpage selection]
> Link: https://lore.kernel.org/r/20261122015246.d8b6b98ff5a8157168156339@l=
inux-foundation.org
> Link: https://lore.kernel.org/r/179535872126.34.4789080961796247940.b4-re=
ply@b4
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Aveline Noir <jm5905938@gmail.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Mika Penttil=C3=A4 <mpenttil@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: <stable@vger.kernel.org>
>
> lib/test_hmm.c | 20 +++++++-----------
> tools/testing/selftests/mm/hmm-tests.c | 25 +++++++++++++++++++++++
> 2 files changed, 33 insertions(+), 12 deletions(-)
>
> --- a/lib/test_hmm.c~lib-test_hmm-invalidate-all-mirrors-on-device-privat=
e-migration
> +++ a/lib/test_hmm.c
> @@ -292,6 +292,12 @@ static int dmirror_do_fault(struct dmirr
> page =3D hmm_pfn_to_page(*pfns);
> WARN_ON(!page);
>
> + if (is_device_private_page(page)) {
> + struct folio *folio =3D page_folio(page);
> + struct page *backing =3D BACKING_PAGE(&folio->page);
> +
> + page =3D backing + folio_page_idx(folio, page);
> + }
> entry =3D page;
> if (*pfns & HMM_PFN_WRITE)
> entry =3D xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
> @@ -327,14 +333,6 @@ static bool dmirror_interval_invalidate(
> {
> struct dmirror *dmirror =3D container_of(mni, struct dmirror, notifier);
>
> - /*
> - * Ignore invalidation callbacks for device private pages since
> - * the invalidation is handled as part of the migration process.
> - */
> - if (range->event =3D=3D MMU_NOTIFY_MIGRATE &&
> - range->owner =3D=3D dmirror->mdevice)
> - return true;
> -
> if (mmu_notifier_range_blockable(range))
> mutex_lock(&dmirror->mutex);
> else if (!mutex_trylock(&dmirror->mutex))
> @@ -1198,7 +1196,6 @@ static vm_fault_t dmirror_devmem_fault_a
>
> src_page =3D pfn_to_page(page_to_pfn(spage) + i);
>
> - xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
> addr +=3D PAGE_SIZE;
> copy_highpage(dst_page, src_page);
> }
> @@ -1822,9 +1819,8 @@ static vm_fault_t dmirror_devmem_fault(s
> }
> migrate_vma_pages(&args);
> /*
> - * No device finalize step is needed since
> - * dmirror_devmem_fault_alloc_and_copy() will have already
> - * invalidated the device page table.
> + * The migration notifier has invalidated all mirror page tables
> + * before the backing pages can be freed.
> */
> migrate_vma_finalize(&args);
> err:
> --- a/tools/testing/selftests/mm/hmm-tests.c~lib-test_hmm-invalidate-all-=
mirrors-on-device-private-migration
> +++ a/tools/testing/selftests/mm/hmm-tests.c
> @@ -2087,6 +2087,7 @@ TEST_F(hmm, migrate_anon_huge_fault)
> void *old_ptr;
> void *map;
> int pagemap_fd;
> + int fd2 =3D -1;
> int *ptr;
> int ret;
>
> @@ -2143,12 +2144,36 @@ TEST_F(hmm, migrate_anon_huge_fault)
> }
>
> close(pagemap_fd);
> +
> + /* Read a device-private subpage through another open. */
> + fd2 =3D hmm_open(variant->device_number);
> + ASSERT_GE(fd2, 0);
> + buffer->ptr =3D (char *)map + (npages - 1) * self->page_size;
> + ret =3D hmm_dmirror_cmd(fd2, HMM_DMIRROR_READ, buffer, 1);
> + buffer->ptr =3D map;
> + ASSERT_EQ(ret, 0);
> + ASSERT_EQ(buffer->cpages, 1);
> + ASSERT_EQ(*(int *)buffer->mirror,
> + (npages - 1) * self->page_size / sizeof(int));
> }
>
> /* Fault pages back to system memory and check them. */
> for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> ASSERT_EQ(ptr[i], i);
>
> + if (fd2 >=3D 0) {
> + /* This open must not retain the freed device backing page. */
> + ptr[(npages - 1) * self->page_size / sizeof(*ptr)] =3D -1;
> + buffer->ptr =3D (char *)map + (npages - 1) * self->page_size;
> + ret =3D hmm_dmirror_cmd(fd2, HMM_DMIRROR_READ, buffer, 1);
> + buffer->ptr =3D map;
> + ASSERT_EQ(ret, 0);
> + ASSERT_EQ(buffer->cpages, 1);
> + ASSERT_EQ(buffer->faults, 1);
> + ASSERT_EQ(*(int *)buffer->mirror, -1);
> + ASSERT_EQ(close(fd2), 0);
> + }
> +
> buffer->ptr =3D old_ptr;
> hmm_buffer_free(buffer);
> }
> _
