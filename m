Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173869;
	b=Rbr1jpIWQqf6hO7/3RdksTCp21b1/70ejxsj5+JeQ3ciQQ1k9je230EHGaPdCAKNuSxF
	 FsEbUP/ybAUzwK8Gc+UnD2dkunnBpAmL8hoL9G243xO5lPWyjT3zH2R3UUaU/ad0MkpB4
	 Wq6BGfCRTMyMrmiMqBSj+jeU63BafAJmOIGpsXOcs2rLltFaFGDk7L72Yr1EdsvkNSViT
	 tAwDcrGRVjqpA4TX0oyMLLHL/HAACf555hfvgZAtpG6yr5rlw2CWfARsGgtOGHGdkz8kd
	 dn7HeG/TGE/IrS8KdW+1hFsRMjcWmCSqwihQ04qXk4FUzo04Pff0QI4gBnovAShpZzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173869;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e6Htv9LFeSLw+jD+wOsLXSXNdz2GUdPCK8J2LmStufU=;
	b=hiQf2O+9dOhjAAHYuB8MtxW7De24tuh9TJ1j9fhg5bKpjfpUKTRiFPuaeKyyWISgRzsS
	 iCEoQlCoqk2ltzxIQkSbRN+RWWlXuqLOELb5VVGhbF+Ioy8q/nihnx5UQYZb+dWGhsXN+
	 MbI2JtLh/Y4xLlcBlYp//qUuNRAaff+sCJrzsaNO+8VAFQHtSV9xT4cPSL6Aen7IYWaVr
	 1tHXN9BKwVuNmofL/du+EXeOoVdRznkMUhZTmpdv9Y9AY2Uri5GnT2wfr1MmU2P5YFOCJ
	 1EGrqLX25BQVoMwZKid2R2YxRFgJlNyBcTGwh4iNBQ9XDYv80XXqqG2x/KpBueVpF5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U3yRfJrB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71BE606A325;
	Fri, 20 Nov 2026 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=U3yRfJrB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71081F000C4;
	Fri, 20 Nov 2026 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795173869;
	bh=e6Htv9LFeSLw+jD+wOsLXSXNdz2GUdPCK8J2LmStufU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U3yRfJrBpx3oWJRtEqrvXe20VwuatH58XY9LrYJOHdjQNWdRf8/Pu0LlT3+5+/OPw
	 /7SMXklt6GXUcQGsKa7halMtP+PxFosUnXpbr6OKOvlLafNZQl9j9vOuqBmN3vxy8x
	 5IX3N6K8k2FPiiDVNgqGzoLRRCCjW0HPm/txvrk0=
Date: Fri, 20 Nov 2026 12:24:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <nico.pache@linux.dev>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmw_balloon: account 2 MiB pages in NR_BALLOON_PAGES
Message-ID: <2026112010-alabaster-correct-8594@gregkh>
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org>
 <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
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
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>

On Fri, Nov 20, 2026 at 11:34:43AM +0100, David Hildenbrand (Arm) wrote:
> vmw_balloon keeps 2 MiB balloon-inflated pages on its own list, not
> using balloon core that takes otherwise care of updating NR_BALLOON_PAGES
> for base pages.
> 
> So far we didn't account 2 MiB pages under the "Balloon" counters, so
> /proc/meminfo etc. would not reflect them.
> 
> Fix it by updating NR_BALLOON_PAGES when enqueuing and dequeuing for
> these pages manually.
> 
> This has low urgency.
> 
> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES state")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  drivers/misc/vmw_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
