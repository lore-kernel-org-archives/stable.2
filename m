Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0FA26159E;
	Fri, 17 Jul 2026 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279359; cv=none; b=Akahk2YiXMKjoj96ojoQH8QlbJYUeaTD/StkM8BkNm3CO6TORzHNBRcLz+KmVvx4Yv1Jjh24o6VosM9J2WibuaXa6XK8iWn+j9TlQQMreEJiIpZXufdpWCKbguDzZnS+bdqKv6i86YA3JgeIwkHkE9jtuVAsb2tKtWQ7Pu2xcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279359; c=relaxed/simple;
	bh=SdL7vaie1iVm0Uqsd+hSgCyngPIokN0XTUTmdLokKik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7MmKGDVbdIeMp/tNTQnI1SUNK7Fnl5Rn41wO2gixdk0JVbDPAG+DEG+lCy9/puQfcLnHGXihyTlXvQmTguA/jEfyPHS1S7bYjXFYdgtwMupUM7qxzawVtyOBKAEVkdn1/49M/c7TWpu8EBAdvZF5azzxxmxg0NRzZrvq2XAqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTNM/OUs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTNM/OUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AC11F00A3D;
	Fri, 17 Jul 2026 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279357;
	bh=8hDLGVnRCVJmvr3vYWUVHX9dK81AR2oabc5yMqDGpv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CTNM/OUs7WYBRthOa7sxeviy2ss9V2NMHXfSI40iKlYwStGfZv0236M7i1D/6DpA8
	 ddP50XPK2ArCklwcuxf1OYLH6bUJMcke39mX8yxQCat4gzUWtjtnES4a8MvewcXKwh
	 hiCevr25HkWNe8xZLPRv1oBaDbrGNn/OOsZuBJQlt5Nl5kfmkCLA4DyVpzvP8yPI/E
	 5qs+Ga4y1Ta+VG/wDzcG5KboczyH3trGbDDn0eGsx2jQYaEzfAx/6g69dlYTsRzG/U
	 0LgErA/GtRghM+ZJ5sjCvY2HR2nwWTzzKuqwQbPCfNWOg3C6LwbPmO5zq18Pvesop3
	 5qdpqxkusrsvQ==
Message-ID: <3f10acf9-5441-4f77-a93b-31552d7eb706@kernel.org>
Date: Fri, 17 Jul 2026 11:09:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/page_reporting: use system_freezable_wq to fix
 UAF during suspend
To: Link Lin <linkl@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com,
 duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com,
 ahwilkins@google.com, Greg Thelen <gthelen@google.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com,
 stable@vger.kernel.org
References: <20260717002311.681748-1-linkl@google.com>
 <20260717002311.681748-2-linkl@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260717002311.681748-2-linkl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/26 02:22, Link Lin wrote:
> During PM freeze (e.g. S3 suspend or S4 hibernation), device drivers like
> virtio_balloon reset their underlying virtio devices and delete their
> virtqueues via vdev->config->del_vqs().
> 
> However, page reporting work (page_reporting_process) was scheduled on
> the global system_wq. Because system_wq lacks the WQ_FREEZABLE flag, the
> PM freezer skips it, leaving page_reporting_process active during
> suspend. If pages are freed into the buddy allocator while suspending,
> page reporting invokes virtballoon_free_page_report() on deleted
> virtqueues:
> 
>     [  196.795226] general protection fault, probably for non-canonical address 0xaa1436fe70dae6df: 0000 [#1] SMP NOPTI
>     [  196.825967] Workqueue: events page_reporting_process
>     [  196.831038] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
>     [  196.927073] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
>     [  196.946943] page_reporting_process+0x370/0x4f0
> 
> Fix this by switching page reporting work to system_freezable_wq. This
> ensures that the PM freezer pauses page_reporting_process before device
> drivers destroy their reporting virtqueues.
> 
> This aligns with the driver's existing design. The comment in
> virtballoon_freeze() states:
>     /*
>      * The workqueue is already frozen by the PM core before this
>      * function is called.
>      */
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Link Lin <linkl@google.com>

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
