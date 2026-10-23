Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766778;
	b=Xa76Hw9lBB6CoLBaHqcvOn2jqZV2Jp90OleYLgkYpNlzM2JxSPM/gpf68ZP9XjwxxlDn
	 GLdc7uu8AclUBMUH2nMjbWrxgIx833T0iXOwXJZI9sbjr6LIMdXX9mJSk15oeU77/F0xW
	 kdwaHNEtUEWEZs58v5xDR1HTmoFctHBU0nx5Ia2WOSwlq8oPCsVjiFw4DLe2A/+iG+mkB
	 il7D85Kn85x/qc2TO2uUHbMUw+QB94R28xq+Mrj0XGMgzeX4z7mY+N8fKxAqUIwNAbIOx
	 np2iedJcWb2lcALl+PldWQ3BPmN4oqdGxyoMUUdUteAlVmbU7FBpdYDyvlO+uRopPQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766778;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lqGtpWRMUHozarHKXyqBee5uJfZddr1rf+OxSwhQcQY=;
	b=dXnl3daywhz6JdeQR7alfCuaUuJMfEf6neExgT7ErSnm8ecpi9nG69XuwzFwThGU0/x7
	 Wkx1gnXCe6awFM5trsWG6gqK8woI9TjS6YIWTq9I6gSOwkURriGQwuO4eNTNixqJyYeso
	 /BhCh3SHMHRdXFx+fK/37wIc/oHoyG7eyV97Y+YCLnTnmifZnDLHEMYGCoDQSwj5r+js0
	 RXRdlJ3SeNKauWG1HeWLNG3IV11j2JaazlRARcQFCdu7SZNWAd6doIwEcHyq49Oxb8qsC
	 wwJVdZB0I2foPO5W7AQZQaA0UmecLmZ5VrOsnHGJVZMmAfvcbxLJMtOH3NTSVso4gZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcErSQ9T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83224606A325
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcErSQ9T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878171F01828;
	Fri, 23 Oct 2026 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792766778;
	bh=lqGtpWRMUHozarHKXyqBee5uJfZddr1rf+OxSwhQcQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JcErSQ9TuliGlGZxkzOepRIlxxK5HiIRT8we8KsFU71OvmBN/ibjVFPXcSg/HflJN
	 kTLNHHCLpjxyXrsbHml7H2KaJL4tc9uTquWA8q8XGUJmxatuYnSEJhLDc2tI1NPqFe
	 Uu2r0WBMORQ4bbrUKycyppkd6uoCrFRnrSIV1BfN5HlzyEWXlX2+aO/s7Z0k3BhWCY
	 v8ZbTTiNooLJXOtqe1M+vgZL0nXrcVC2CVNBYI10LGecEAGJtwg+RT8DAVJCuZU6SP
	 cAPeVty2DeCh+QMQNzN52jFe4gQ5b5hect0Vz8p4V2QgBYXjpighiU4TNq2VBA21TS
	 py8YucAC1UEYQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id ADC06198004A;
	Fri, 23 Oct 2026 10:46:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 10:46:15 -0400
X-ME-Sender: <xms:NHPbaodxIwfmERKVMjO3emuC-DmCiY3_wsg_1clj_OjlSJ4QcopNZQ>
    <xme:NHPbaj6DF3rY_8J2h4I3gpAc7Dgb1qW5r22W6entvNGUtZsQKI-pL8WkYi2aqDWcX
    kIoIJEtvoTpCP5FLEUh8x0yyqUbWNSzsJ7LpsUZW_Ih_OXfbk9xLWk>
X-ME-Received: <xmr:NHPbao3WddwwbxsCpGRLyfnGMn-oEOOo-xSQsrvLJUsLOPp5ELRM6ZuXcVU>
X-ME-Proxy-Cause: dmFkZTGWzcuTEmWQLzfWqLZ4TItB4My1D1r9DQkczQVudo2y/CBinrz6rqIzv2fdTJmQit
    MWJwEuqXf9cP1nnF52BUgbU7yUcs+aIKR0NY8tHKyUAivJTQMueCYpQn8ziVleohN2asNT
    tGiSIb/MnF0vPL0n8KcVeHWwb9xD6DTByHfWnkc+E9lBZUsMWiAGWDml2tJ4AoFQ4qmqUq
    klzQi7HiNDGq/ym69P3GPHlzA0NXkSTJL0DBnmmdXKgajw/9OG+7sspwLXuaVqp9sQ+R2u
    vUgM0+L9lfRB0WiRaKnp8iETDuUJ7ldQdWNvFo8/07kNi01NTiuWZMMGjzKp3oJnYQ1kMe
    aZmc1+hS843Xgoa+at+eHcthqrFTNsIASPbVgVkQdLBcwgNLu7f47IV84EwluPtPFk7HHj
    1+OOrN5ppjcVEBedXqBYX28mBxEESempkNBsvPR/9gv+U656dlQkJ6Hy0PbhEtYHkYfRGn
    emwXRBdrGi/52+YAD/MDJ1luUrBPlH3HdqF0uC79YL+SljSesdSUh0kBE5jzBGKa18s1fo
    L2nyo7hZ8GmQH2Sp65qRN0u4GS2G4gUK83dT0rZiG9HsflYpRKpvrHv/ZxkI+8xU2yvc/1
    2U770t5dX5AZkR/YSRK4lyW4+zSO3qlgebWsbxvTefu8FgM9L8ZrPx3JNQTA
X-ME-Proxy: <xmx:NHPbamAm7NyUBz06IvsKkX4ExFTeotqYnXDVWnh28bi7qJBm-q1gVg>
    <xmx:NHPbapHrTjiOSJmluRQ3UdYqxMxueCquFcSMHWzCsOVwKAV3RqU0lQ>
    <xmx:NHPbago35GXJXdHH4AychpbXg6n8uSJ4cq75y25cdS1rRJCnNPx5Vg>
    <xmx:NHPbap3IqfFmICatC8MF6w5rAe0H8G1201YtKl2IMScodEvb6MI-sg>
    <xmx:NHPbasCOcP9XXZMfbA85AOiwEouDFFnDBy3EsIC-u_P8YgKgy91TwKAF>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 10:46:11 -0400 (EDT)
Date: Fri, 23 Oct 2026 15:46:10 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <atty0n4UzTfI46eN@thinkstation>
References: <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
 <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
 <atDMN5MoGrwJNpAj@thinkstation>
 <4aa14b41-9b89-494c-8825-55fffd5a541c@arm.com>
 <atiCG2iPrHwDznSZ@thinkstation>
 <d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com>
 <ats7oFM-fsYdUS8y@thinkstation>
 <attOFXch_TchIfEv@thinkstation>
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
In-Reply-To: <attOFXch_TchIfEv@thinkstation>

On Fri, Oct 23, 2026 at 01:12:02PM +0100, Kiryl Shutsemau wrote:
> The diff below replaces the previous one. It needs cleanup and splitting
> before it goes upstream.

Proper patchset:

https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git page_alloc/nofrag-watermark-v1

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
