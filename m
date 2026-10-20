Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535052;
	b=vXZMeA/ljaXwxg8uLz1cseoYVFcOfwXR2sIVMkodV/18SfEZhGBVg1+S679fAns5BA9d
	 mzP9TvNOz5g/LeyxiElyKRKjSMhs/tb0Hy6yaCJJXTgVVzTzIHZaTzfqKlyfnHQ53jl/i
	 0wSWK21cmYh4umLzzHuaZA1IFkmECrd2NjX7GX4+Z/UNIRkw+JATYjDfgNGmFiI/sPD0a
	 +rc1yBGJjTCSBHsKjb6nlROm2L/3MCNJkKftT+tXz48Zen8Rgo2WOmbGwZ3P7G3EsUqKR
	 iIfHSmU9y1n9U8Z1oMXq9IhPgEaA+D/AUxx4IndbY1fIaoSwNFnd3BZteLK9Vlr2H3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=JbcL9UJUoZzm8h4f8WZ8/x3EwYH3/2Tgl62Z2dUn4XM=;
	b=g0vtzibh66M6Gq6ulSmUBGru7Y0z4fRw47B+BMeLHmCxY7XQ+4Kx/uk0olPD4sX+L0yJ
	 4H+llzjpXdXxqCXEw6Do299cbA/guRpzlFhLW2rKggPpHP0RnNy54uhnQnSMoyAu8Q31X
	 YLKYLwu/XK6tBDLPWWCqX+q0Jy+5Onc8Atc9xtVf7y2GQ149c++5wm/pCXYn6uRPp08Nz
	 qDe49mrZpxeaNoo1N1pCccheXfZBadTtZL1XDNcX3v3bC26EHjLN2+NZ8wfo5s68jStqy
	 53cJVrzFokOk63r8FGiojskyuC25gX82uhRvSobc1oMV5ZRHwxUSAy4XrdHHaQ1sD3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jfZJtsJI;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE0606A32D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 22:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8BE0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jfZJtsJI
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53665358476so1479491cf.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792535051; x=1793139851; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JbcL9UJUoZzm8h4f8WZ8/x3EwYH3/2Tgl62Z2dUn4XM=;
        b=jfZJtsJI6UhFNm9iP7XMEQEkC+wJp1pcrSXNbvNCSvALB4MBx/uozTLKdXC+8vCqSV
         DllU8XTLalvH8fkVTnS1YFrC5zG1eYfsjmTKYAW54vZK/grwPTVLBO/Y9vEJVe/8JfzX
         vx/mZsWnZBox19CU4Jn2qvM7auDsN6dTh43F/AthhFEK1xGjmOkj+yR/cROzwZpgPZDZ
         JXSUOZ+SN3oCbKqPY14/XFPRg2x6dBnSYGPbvCTf5TY1O40Ks7QoCtKjUfKplo3eT+l9
         unLwzh3mfWRbg9DerLkUfWYQpnvmT63m51dCZtgYcW+W60oBIPK5rXc2W4ZuwtDRhyEC
         /LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792535051; x=1793139851;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbcL9UJUoZzm8h4f8WZ8/x3EwYH3/2Tgl62Z2dUn4XM=;
        b=LuE65VgpvQJU5XTHw6wg8Rr7oFslOXtxXg7rqriKzv2mrVDoqEDurp20vHkSHrrjFr
         p79vX8wpSlnzZpYlVmwOwd6osG4fB7ovHUd+dgi5l9dW75T/ZJ1JS3nhCIaA6Oik9ZGY
         gMsL6ecFPNmkEuVZnyf7yHeyz11CuHAH0uoezOaSTynsJgJjHN4lOxQ9yZu1EwiW5vx8
         ghicNZBWmNvsRgI1HEj9k8pHwLY69s/lM/ShknphrYWb0eGg+plII1yaADvbPcQjRV1Z
         CuyqiaUGptK0PbMfa9KFSBELlaR/OrushbxRGw4ZJrEyZRXGwr3DhiL9Py9QmjZ1gk1Q
         wtfg==
X-Forwarded-Encrypted: i=1; AKwUvByNrUxAdF/H/xVe6kcQWB1hEX9Mxe0fr3O3T/UDUFiDt2NRvgRx8W/ngjJ8KI+gOg2N9C1BImo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5iWw8KOifUp/f3iXRTFMGOXvrp4NzDzKklpELdd3UeIEfBmDw
	C7IrDjKP1xKBwqkiGnViO6A4h7FvA3A2wBAEDwZsLAdZ+dbhzml09bLkfVGEVKUOKY0=
X-Gm-Gg: AYBFou2VH0cYU6NycE0bNaI9W+Bj57wvgSTKKVvTTMq6KGqktPC7dM9YCikkvken6a6
	11u7ETFF2EbuBVGEI3oz0mkNXojJpF8xb8t3BLgjMOYdhx9O/08dtqYLQ/fTQcPgxA1KaK9jZxZ
	kJSPObMmqfZXPjWH/CH6FPC89PDxkvUFADMB6XybpoDGmDz60EoMoEnlCa4HfirCRJnQoqDqX0e
	UTTlTTXeBAgt1KGceA2iQ7+FdXbKwbJpUQRq9CaEBzwY32d2ZG/ldP2qpHLMl8thXLcJdhHKRvB
	0qUYxU3ASYSzjZmQ+p0laBwsSCWDiSfD5vjNUC8YTJ+u2U7leOPVq4BiGqDxWiD7/pOs3yYZkwH
	8UXSfgVuHtnvmfGp0kWRCvkyaEQgJd53MZFyOiLvn/kPonRYQOCW5yTW7/y0dR52SJ5IqxLuQla
	uA4qlfGZKI6Wj81VOLm6rOcwps5K2+OceJ4biIaikwUppKr7T79iUCuHCuaulsMR/JBfeaavpFA
	U9cWTx+6vEoQQOFw6eNIuQN9m0NERbNvZoi3GxFSxyU+GQ=
X-Received: by 2002:ac8:5cc1:0:b0:535:f9dd:ce3b with SMTP id d75a77b69052e-5369bb816b4mr3355061cf.69.1792535050831;
        Tue, 20 Oct 2026 15:24:10 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698b3d2c9sm6239981cf.14.2026.10.20.15.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 15:24:09 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/5] mm/page_alloc: validate zonelist slots against
 concurrent rebuilds
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
 liam@infradead.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
 brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, 
 mgorman@techsingularity.net, jiang.liu@huawei.com, Bessel.Wang@huawei.com, 
 stable@vger.kernel.org
In-Reply-To: <45ef34c7-eea5-4813-b54f-3e34675697b5@kernel.org>
References: <20261019172346.3344005-1-gourry@gourry.net>
 <20261019172346.3344005-3-gourry@gourry.net>
 <45ef34c7-eea5-4813-b54f-3e34675697b5@kernel.org>
Date: Tue, 20 Oct 2026 18:24:07 -0400
Message-Id: <179253504789.1514232.10853151353341082033.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-20 17:22 +0200, Vlastimil Babka (SUSE) wrote:
> On 10/19/26 19:23, Gregory Price (Meta) wrote:
> > Onlining the first block of a zone rebuilds every zonelist in place,
> > shifting the slots after the new zone. An in-flight walk can use a
> > zone it previously filtered. e.g.:
> >   - a GFP_KERNEL request can land in ZONE_MOVABLE,
> >   - a node not in the nodemask can have its zones selected.
> > 
> > With kprobes holding the walk across the online, I was able to get this
> > zone/node misplacement to happen consistently across hotplug events.
> > 
> > The iterator approves a slot by its zone index and node, and the
> > allocator then loads the zone pointer from the slot again:
> > 
> >   CPU 0                             CPU 1
> >   first_zones_zonelist(nodemask {1})
> >     slot 0 (NORMAL1) approved
> >                                     online_pages()
> >                                       build_all_zonelists()
> >                                         [NORMAL1, NORMAL2, ...]
> >                                         -> [MOVABLE1, NORMAL1, ...]
> >   get_page_from_freelist()
> >     zone = zonelist_zone(slot 0)    /* MOVABLE1 */
> 
> Since the zonelist_zone_valid() checks you're adding happen before the
> "zone = zonelist_zone(slot 0)" part, I don't understand how they can be
> helping here. Aren't we just reapproving slot 0 when CPU 1 can mess it up
> between that reapproval and load? Am I missing something?
> 
> Furthermore, since we have the zonelist_update_seq anyway, wouldn't it be
> better to use it to avoid these kinds of races rather than the more tricky
> way of relying on what exact updates in what order can derail the allocator
> side and trying to protect against those specifically?
> 

This does end up cleaner.  I'm going to reorder the series a bit and use
the zonelist seq count to make it a bit cleaner.

I also just noticed that the same issue is present in hugetlb (because
of course it is) so i'll probably append it there.

~Gregory

-- 
Gregory Price (Meta) <gourry@gourry.net>
