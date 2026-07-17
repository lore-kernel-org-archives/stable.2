Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723713644A0
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257739; cv=pass; b=kwnutgAvP0Wdi93EOy0H16jub3e+rfrlVhxx2SToy79fcVhkkSPCeff13WGpEyK9kxjVUT5C1ZnKX/tZdhX6aOP827rs2zSRi68uC9iA9kAyE/wz4+FkjIkMkESVrD/GCZmoUIxq4tF6TE5H0VascebF3JvYOsJcOzUxEsVrl50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257739; c=relaxed/simple;
	bh=xkE7Fo4sqZ/86+n7TYPmzgcfuvqX35lIQ9Nzu1Gipdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVtKkClBiubCw2nq+lcVJILm3AWTOvUX13PHBFvOOZsc0Zz7SjsJsDETC6NclR0M6HM1L2Q3cymUGtPamcziFLtSPLMgrnN0KoaORgvCvbKXaDc/wbUBfhwSctqJA/3r9N8RF8It6SA6VciW9qbFzgWrtrH71xp6YzL7wyuhyvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNNfHiPR; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNNfHiPR"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c10e86e52so239261cf.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784257735; cv=none;
        d=google.com; s=arc-20260327;
        b=X4Ncb2jkVvMNRE/WxJD5XkcrNT5IcEtIDFSjd1OUQuxWy/elrVWnQ/92cweTuVbkLb
         Jif5AznfyaY8HDkUtyns8BclncmumDLVbuDb6mIDqbKpmI8sTBAjXKRxVNha47Ih3hGg
         MCp1lj+3EeL8H5DoGW8ZDQVJmcPouFlTA7MQYSm2Ld/rIG8Xftcjhp4+k0ojgRD+sLsU
         D5TKd0KQF0sE9ERNxgW5I9pM/TUUT5qS8WfLxaXJXZMinOlIxAcyFPkrmwAjwCp6dyOJ
         Om69mbQAh/IufpkL3w9P9oDGZJFbPp8gSLUTwPYQ5DOm9KNt5U3Ehl2vAEUXJExW3XHy
         27zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xkE7Fo4sqZ/86+n7TYPmzgcfuvqX35lIQ9Nzu1Gipdo=;
        fh=vdXH6MjY00slE0xf/rt5RZS+xqVjZwAcuGFdsjS9qF0=;
        b=atE3aIqks7yqFrJubuu6S5kHIbfnSS6JGIRqiqVTGM5/QJrfI1s/+dcJkFIfNpnbAP
         jJV2SGy+Z9ratiLavQuxwYG7DkBiqlhFjZw09b+10KGiXLiRpTqhI8ixxUWQ6ZyxK1VV
         Ga8wE6DXkofikk8NksHZsZaGZ0jk7S51RQ+EOFEJtDyORICcpK6rryBr00+eu0jY8VZK
         5PxtwUGdM+UcmCJzQjkqFlpNUb7pl75dl2Ck8fOToAq3lKzbkApSL9KphfJcDNRwKh74
         ibblQARu+WxaAs6zXnB1P9UrDfDsh739By/QgqQ4VWOn7YXc41uiA8chN/pba/EgEmzt
         v/xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784257735; x=1784862535; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkE7Fo4sqZ/86+n7TYPmzgcfuvqX35lIQ9Nzu1Gipdo=;
        b=eNNfHiPRxoW7oWLATG5R/8FjNu30c+MVqH8BwFX/AKeEXQVXNA70ORclYYZeNICp+N
         CAc0iGrn1WgUghTy33Z1qWSAtEU6Nk/y+HJj6T2UgUCVcvZArEXu92qei/HWwOx4wsgH
         dMYQM7AzKw70A2i/wx3S74byukxX14Gn/+d4kVgI8h3/OaWPlLBEwrQ0FgexpNGOjiDK
         1ge4tVXiLvmfxucuFM35lzbSWz9OVcfQBbqUpeU8OJpkkB07jTnFhH4gwKqOfbOA1M1y
         VLt69Rj9pFL3F0scEl6iKhlDIF606LwUpSFOu1SruBJJsorSdWNhHBnqITxiI2A0iCkx
         o9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784257735; x=1784862535;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xkE7Fo4sqZ/86+n7TYPmzgcfuvqX35lIQ9Nzu1Gipdo=;
        b=XEouR5xFJu1+fnXu/+D/2FbbDAcGOlNSfHMq2hZBu6p62gKhADSDVEC3p7aDua3h2B
         xHowXYTvHVvtinf7mrRE5xUxWC/T6mlZ1Tx3VDqCwDYdtURPjgflzqCSLoMCzo9sdGrR
         XU6d+AWMUQk/ZjWKTBqhVSy4G/bXzvoNb65OmN/WUOnhouUXFCiMQgpdUT4EJhSPmH3C
         8qT5R1QtaduNjHeuB7exhJEmLEFCikMhkbEIPELwr83jYEq2UPBzWxfROipDogh9CTAn
         g+HkBan+KaWgpC3IvQXjO1zhFBplw+W/sdM0qozaY9OFjrBRDXHUqiG6esZH2Y1PQYyM
         QmOA==
X-Forwarded-Encrypted: i=1; AHgh+RrS3RaBZvEgTg9oUc7RSZLP9IgkpifEtfnCMBuyf6TITmu7p1tRWrbe76sltLEIxt6o0HUnHdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbR2rJ2fR0TW5FuboeoBUs1ifsaI/1ZT5UnHV+H7USPR6TkgBk
	WF8NqLXJNnGqroKXlVjun5pJxbdp5mrYWQQuuC9jCmuEC8IUNRhMMiblUVrJzWm/MB/elPXBTjK
	SXUl5t3wH3/PT6a0KUHQj632NrtAHMkgR+au4iHXP
X-Gm-Gg: AfdE7cmRidWKiqEmTT2S3HQK9Vieir6bHS5ueAzZE/nnzhwWaa+8WkdwkEhlEHyaYV2
	1oiYvGkJvOvSmkIkV3ev+lzWVJUYBIprJ0tIye+wVvq0nh2o9Ez0JOtDpwhxJxe8CLNNmDbn2IP
	8P/ToW6MmEzxW6tWogGdKwLh6FVZ6F42wjRCcwWwJI/Xz0QeyoIxoDx78mA0L6qcb+sYXjCLpTl
	jMEfcma1+oxz9ASigAtEbUoWXweFJrsMWB98DOfwsw9tioZkQctbPUfnSIreBEj252m/rVfds8N
	xWrzwCoF4u1gHb1A
X-Received: by 2002:a05:622a:a908:b0:516:d570:82c0 with SMTP id
 d75a77b69052e-520fee19f7fmr3120471cf.15.1784257734125; Thu, 16 Jul 2026
 20:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717002311.681748-1-linkl@google.com> <20260717002311.681748-3-linkl@google.com>
In-Reply-To: <20260717002311.681748-3-linkl@google.com>
From: Link Lin <linkl@google.com>
Date: Thu, 16 Jul 2026 20:08:42 -0700
X-Gm-Features: AUfX_mxICqJHmAVK8TinFxnPQuIwu8KNDwpqoJsVqWM4NDLatLe37O_LMt6bETw
Message-ID: <CALUx4KTH4-D9ZpTrEikHajp=R2VxXqLACsJC1aOhX_W8+TApAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio_balloon: avoid shrinker execution during PM suspend
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 16, 2026 at 5:24 PM Link Lin <linkl@google.com> wrote:
>
> During PM freeze (e.g. S4 hibernation), virtballoon_freeze() calls
> remove_common() which resets the virtio device and deletes all virtqueues.
> However, the balloon shrinker remains registered with core MM.
>
> If memory pressure occurs during S4 hibernation image creation/saving, MM
> invokes virtio_balloon_shrinker_scan(), which attempts to reclaim free
> pages. Although return_free_pages_to_mm() only frees pages back to MM,
> reclaiming free pages under memory pressure can trigger page reporting
> which might access the deleted reporting virtqueue if it is not yet
> frozen, or interact with other parts of the driver in a teardown state.
>
> Avoid this by adding a `suspended` flag to `struct virtio_balloon`. Set
> this flag to true in virtballoon_freeze() and false in
> virtballoon_restore(). Check this flag in both shrinker callbacks (scan
> and count) and return 0 if the device is suspended, preventing any
> shrinker execution while virtqueues are deleted. Wrap the lockless reads
> in READ_ONCE() and writes in WRITE_ONCE() to prevent compiler
> optimization issues and KCSAN data race warnings.
>
> Fixes: 71019de8219b ("virtio_balloon: Add free page hinting support")
> Cc: stable@vger.kernel.org
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Link Lin <linkl@google.com>

Apologies, I missed adding a tag for the feedback that led to the
TOCTOU locking fix in this patch.

Maintainers, if this series is applied, could you please add the following?
Suggested-by: James Houghton <jthoughton@google.com>

(I will be sure to include it if a v3 is otherwise required).
