Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572957;
	b=veNAyKIUHZzT5QS/MA6rFUeK8IuRoiGT41ddtzlA/9E2aY9sCzHNhtwBx1BrAjrRdDlj
	 sOSJ60vHVhLtFGQNJQ6ByLsSXwcP+ROZO6S/JJlW1w1WvPffPxvuSBWKTJqoWjQb6Jjq1
	 V5bFCaDWuCsVJf7DloXywwsU6XrmSOyieKT3zve08xNY9lKx12EK7AfIVR2H4E04yxsqB
	 jidzCvpOGehfI5RrT/2vlh1kfmnMoc0tfRLc73OxGRkp92YFNrXrGUnoWK0oXzn9DJmCN
	 6+dEEyz7CKh+wtk+CAunEh+Yej60Y5DMMyxxI0/oScDyuPt1Oumc+KGBnZQo3Mcko9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572957;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kBfmRD+HTUM5tLd6gOgOmsCqpMWEseYJOLoe2SuJ4F0=;
	b=FRgBY4nCueoxO92aPYFnr6UKdIvzOBfnC2amsTde5HYdiryba4dAj3r5FSIP0ua3dtMm
	 zgAuU4QcBgK6h3rmvHiXLBtddGtyXBlKJcqZrtOku5TDsYv7qbSVLVHEN/zR+8EqZgtl0
	 n7PqCn4P5mrdfSPpRJiinO5TBrt3O3MU8QS6RYWiCvcKHZKqO7WbIkwgUPCTPhMT+7F6b
	 FSg/OnJ1XyRTdIhjjgz2OFVbDvKAW3AYG/anY+9p6M/zidvW0gvS0XT6R+Uw01KKM7rzk
	 jyQE0k2YGJbqoqyt4lghbazK+9EL0jcxb2wQZiC2qgsdEhA3kP4MxJwJ1svHRKrFBtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bc2Z88ul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D98606A319;
	Wed, 21 Oct 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bc2Z88ul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971571F000CB;
	Wed, 21 Oct 2026 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792572956;
	bh=kBfmRD+HTUM5tLd6gOgOmsCqpMWEseYJOLoe2SuJ4F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bc2Z88ul+Wdi6ex8pvF8klzjJkZsyRycNpC+fqEvZwhpSTog+Ws2CFQaP7yf81qtW
	 MlF5pKgAruT5Om3ovBjx44c0A70egnsrKIO5PXmJriv5wruyxcu1ATvCF4uo7MVz46
	 Dy+zxHutfuPBzrqPb0FoGLtDlaOcoUyHjJskAGpEDsJ5UJznKmNWRagAV4Jv0O2yWl
	 7ppdJbz9WyJH42i9yzbxnzJ5mGb9feE5OT1f8UZC+Un/U2hU9fL8BfMjSAtVpw6d3P
	 rZqVPie6kTOAcEB0CN+suPI8nN6r1XWueiS4WFG8NI50i35KImYKUN3ykMhzYnGVoI
	 DmmVcaxMgVkKg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 7613E1980050;
	Wed, 21 Oct 2026 04:55:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 04:55:54 -0400
X-ME-Sender: <xms:F37YaojVWrsR83031gVvpnRvGNk3M7OQ1i3nUtjEzGX-YPIOqn8LaQ>
    <xme:F37YahfiUUY-rLQahuAvVVp5w7RN08Az6vZm-EFeLqSvV14sox0ci1ARP_Jboml1W
    _bYBoANT1M0V4wDtgzP51clRTAyk2pt91gpFeuQvhxg01ryFCp_FWnw>
X-ME-Received: <xmr:F37Yalgx8LUjo11qIaCHCUxkODdZMuxBbjSrKJdpCTGR_Gisu8Eoo1tNlsE>
X-ME-Proxy-Cause: dmFkZTEBD829IPSJldAEeV8g8TjtY4+wpWNFDE0//6V1zbMXwfqkzjCBJM7vp2VnYyE6BQ
    cTG8ugeY95ZXs8su3YTJNRFD11qFtvPEio1QgBsUIQ5MzQ5NIRzzqPV+LhiBOZzB0IJOEv
    Is/kA+k7tTRpZsr4rhd2iYJlPa0vuel/YvFTzqFS7o8miy9srjNIAq5rA5ZhmXr1sADhki
    1PTJLYfs7YUNH9EZd0xT8DRRkGoeaROyYcl+3dMeasHllZRtdvYyk4Fbo+movVzd29ywrI
    xYfvHgmBtENvnnIcfdcD+ZXF33LQbfElVQbTvW9VoPNNtmzzsLfi0bbZ0ZnXfMF5I+C0VP
    VHCICwVqm0BmTISx2nQVYmvAVLhuJk0im+xr9PddCYXwiSGbxyjonOBq7evO49Rso05MmK
    IrT+nF21YP9Qm3+s1G4YASJaEqnQnpvRSA44fptB+MZOkV+hoA5xekZKOtzWHBSKt89pOT
    Qel+zTlMzKw0gcXBBOJC6YO8g+Al53ByXP+SV2kmUk3aaJdE4eVFmc541llE/QOdi7ESlN
    hc+SFGehm1l6OTHDB1JFCrOkD1oiOGIdkZhPHZovdo5EhMGShA+pfe3bb5sKVkGSl6/wYm
    CJNmydURXKNowlpHRLaTOldiFULdXb8VwADQNQ2bUihguy531D770kU++SPw
X-ME-Proxy: <xmx:F37YanNp8iZN7MgTJnXmEO6YgONTNgwcdzR7Lu91iWqMbktXcr4HRA>
    <xmx:F37Yapmwr0fJV5Ayegmk3VllttZe5TyWEKW3_tzsUHCVOlnjFKFOgA>
    <xmx:F37YameuTO_lVWqrg6KFFAbgZKzU66sgfRSXVk7jlI8Gy_qS0o9ctg>
    <xmx:F37YajuxDEhv9S9oaw20FiWHqZQrDhGlZJbJspcnqW7M3Mqn-JmyAw>
    <xmx:GH7YagAfGGfDD_kD5-HU6L1DbNvJxou9v2XGXi5OXt9Ou0SkxkuroWhh>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:55:51 -0400 (EDT)
Date: Wed, 21 Oct 2026 09:55:50 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, samarth.colleges@gmail.com, 
	akpm@linux-foundation.org, xu.xin@linux.dev, chengming.zhou@linux.dev, peterx@redhat.com, 
	rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/ksm: keep soft-dirty and uffd-wp when merging a
 page
Message-ID: <ath8JTlITYcXsyLg@thinkstation>
References: <efa6a28c-f0f9-4d1e-9cce-fec2c08e7d9f@kernel.org>
 <20261020055518.36087-1-lance.yang@linux.dev>
 <3da45e6d-2b46-4fff-9ff3-241f70d68296@kernel.org>
 <f6bdf823-be42-4184-87d2-fc7c128f4786@linux.dev>
 <68f17ee7-d272-4475-8a59-645442e2c210@kernel.org>
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
In-Reply-To: <68f17ee7-d272-4475-8a59-645442e2c210@kernel.org>

On Wed, Oct 21, 2026 at 10:21:53AM +0200, David Hildenbrand (Arm) wrote:
> > +1. Did it ever actually work there :) Why not just skip them and
> > call it a day :D
> 
> I think QEMU just always sets MADV_MERGABLE and later activates uffd. So that
> needs some care to not disable them. So let's rather try to get it fixed properly.
> 
> Can you send out proper patches? Thanks!

+1.

Lance's direction is right. Unsharing is not an access: do_wp_page()
already skips the uffd-wp fault on FAULT_FLAG_UNSHARE, and RWP should do
the same.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
