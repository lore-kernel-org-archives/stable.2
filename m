Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505009;
	b=zKSoON677uNq3AYCRbaDCmIpoapY6KWZ9yZKW1D7gABmPc/W5+syzPOAM9039fMPWe/E
	 LedSD8MWWwJF/UB08TnG9ylZeFczj5O7sL818QK1L4g9LrDgIdYK/e337XMCNkHkOuYs8
	 Mr125tAEy99VgnPpewy6rwWxFDzwMux2KMnDkbo6TwPxVJ1zlCLX9FcvJQ7/SnZ34xk/O
	 bxrAh9dOzwqDLbRMNueAl052WSvDEhOY4oLNteeKPAu1o9pGx5jovjwf3IShapd7cBYmP
	 ksuylcX7/l0jHuYV2wujhp4ha04sYnH3rHlphzbh2V8zsmm/r6yZG8kiuu0lhKXUR5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
	b=Jy6ND0njuVLPoUAloK/CWfMYulp1w5+9bOQjli7PgbTa3zh2fLd3LtpIJdlTk4Xe0Uvn
	 e7G3TJsg6fLM+fD2505bZtuRVPsnwDRfKaFzuz7h0FLf/9TUJqj/jDIykNxwesjpeh3h3
	 VeOxWOFSNYzLw9N8QE/FQv6D/5XLdzeeTaokk3Wm87AZVhGJriWmQhmk3upAv4ipviwD8
	 qDGMF3NcFlji/f9/iIOn0CWJO6O7IB9LBGpG4hzneOB8G8Pyhzffp1Bf2yGZVFdEHMyjr
	 vXYKWKU4Dr4YsOR1kWEeALlWBzjTXpAeBEJ1Nqan1r3AmH/7KrBwOAYwVUPGDmwLgwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aVgaSaWb;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A4606A200
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D98A4606A200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aVgaSaWb
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c15ccd7fb5so64128e87.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794505007; x=1795109807; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=aVgaSaWbtoguMx6XpuQaFBCO9JEUDWcmY+QkcrqX0G9hcVt3qnILE2C6mAN5I9qIiN
         Kwp1BWY3+7xTtY746uinxMHzlMYDL+Ppz7NrWjcxNbGiPCitqY2j6icbFY46GJj9GmHr
         a6bb6EaQ5TOf68JwcFw459ijxzTWqdNtO7Lxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505007; x=1795109807;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=Es/6k6fhFMbRwG2GTHgWjJCTE6t0po6SxhuvhCx+nfRGxjUwKepIkHaILTIavork3t
         ftea33I7w6g3JaghaFRQCsXx39lJxyl8WoO70o0Z8xGUuQA2Ybr6lsSdLLLRW0tQBC4P
         HJhy2jdJ0RPmKHFXr6YLtxbdFXLunQlKMTP3r/yIHvmx7N51O3oUtpJ/au2OlXh+JYH9
         GUNKcQ7M0749x0WIjXkJTaxU/dZc6JBuId4W5HzEQxjlOfmp14ShaA+LVo1K7tNCzwkf
         93CIwIDOUodRnmB8IQpuxelhMq4ft0dj+k+J7O2Hs7bnxXed46m/oK8MDnF/myYIRnUf
         OakA==
X-Forwarded-Encrypted: i=1; AL+hErHJvHGCAbN1ekdPYHGUkbPhE2tocGh4BVW2u6vxbgR+X5AhVR+BjsW7QItcCdQnD6k8ehs+OA8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Pfs3+OjSilvc01CN3WFynF2SxOmzHNMdEoq84hnRormV0kQWO
	9oXlagW2blZF/0OMDdzG3IgukE3GTf979zYljTuUxciRatEAcJ1AQ2LA/W5AvC0gk0L7tKmPhPP
	UqgZa3abKQw==
X-Gm-Gg: AYBFou13IT1aqZjgKX+z96LoKAjpUBc8z4Oy7mkAUiacTnYL1OVNxFJnoxK4IEc8pBT
	Z32+epGjuBvVRJsezVS2awMnqKKMFgrWITfu5XwZnopad2tWqmD2z4YExtJDpg70Lf6cLJUqyCG
	U3Ag6KyTE/t65nKHyzeErIxHb3FJqCgqhkpnn8aiWlTpp7/buITApcvn7uGvLA4qK2FyHM1Cu0k
	WFbtsvQu416OdPA34IfFLRF85VH1YzC4yQi6bT0Xeg93gN3HydHLE6ME/Y7rS++HVlQp3teIUH2
	nYWZ4ew2F6GLzKcgIzZyfq30qHwAwUqRRniotDZZGkAL56nCziuvK3fkhdM7C2to4lbGt4QX8/p
	wdeNnfx9bHa6RLuRK8golvwJOuP4zgW3xt0ZVG8o9xkKqtIQwbQLDkt/RDp4w4uA/G0eRma7nQY
	y8A9QaSATQg6CK3M5msBa0Rvisuutp75G6SmWfmR8oyUjBwNlGA0KUS8BSan0L9P4EJsmqyAQj4
	yZNXHMUW82HlUUKsu5or3zD3J65zBbWPAPshZxQMpptJWgOSOyp/pEDnIWOx5BnMNEZSllsy+t2
	guF1anKu+T0nSBJmXKYmfEn59JnajWNvgBw47cJFUe8Coc1kK114bQ2wDl0ED0WaQCZHZwRXOmw
	6w/8=
X-Received: by 2002:ac2:51cc:0:b0:5bf:d93d:77b9 with SMTP id 2adb3069b0e04-5c1709b9cc9mr35830e87.30.1794505006956;
        Thu, 12 Nov 2026 09:36:46 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bab0bdsm1823770e87.34.2026.11.12.09.36.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:36:46 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c148d4dbfbso81250e87.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:36:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGPWRqp1Foi2E+sRa7+EQp2Z5nN0toP+UIHRSxTUvU74EKRqEZX0axBA7+0QaJRULp+4fIoOV8=@vger.kernel.org
X-Received: by 2002:a17:907:3ea7:b0:c4c:e344:ece7 with SMTP id
 a640c23a62f3a-c5066afe5dbmr615605366b.10.1794504534261; Thu, 12 Nov 2026
 09:28:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
 <avW3v-oLxcHXXNQD@pedro-suse.tail5790ac.ts.net> <4ae22b7a-c160-4003-a029-8a20381d196f@kernel.org>
 <avXFlI_5fhUvFyct@pedro-suse.tail5790ac.ts.net> <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
In-Reply-To: <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Nov 2026 09:28:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
X-Gm-Features: AclHuK90rViBZMbITCUjh4KTAKhE7_4EYJcdTbdgYzXWPc1JsLWFSAsYMdn-r7I
Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
	Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 06:31, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> On 11/12/26 15:00, Pedro Falcato wrote:
> >
> > ETOOMANYREFS I think is good, also EBUSY, EMLINK (though this would be weird)
> > or even a generic -EIO.
>
> So I used EFAULT because that's also what we currently return when
> generic_pipe_buf_get() fails through pipe_buf_get() in splice_pipe_to_pipe() and
> link_pipe().

Yes. It's not a very intuitive error code, I admit, but:

 (a) it *is* the error code we already use

 (b) it is a fairly unique error code that isn't normal (ie EINVAL etc
that can happen for multiple reasons)

 (c) this is  something that nobody should EVER EVER test for anyway

IOW, the actual error code doesn't matter. Nobody sane will ever care.
Some of them may be entirely unreachable due to resource allocation
issues. And we already use EFAULT for random historical reasons.

                Linus
