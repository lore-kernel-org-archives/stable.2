Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059050AC0D;
	Wed, 30 Sep 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784287; cv=none; b=TdidGVLfO5vYDCEqF7CymKwZ+dNgC/aNygjC5QamCiPXhtTfpPnYSrLAaKsqpZSbzisfxsxxeYIm5fiB9WLLQXLUWVA+4KxiYUQEqdrdDvz5/2/6lQXQ3uMw2zpvJledTVFnMBfjYSfl5hcqawi1SqBcQ+v6Z3hKz5ZkTVUOB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784287; c=relaxed/simple;
	bh=sf7JkiBrlIFrbpSAB5jWBphc8IXCwEYLYqWnamke+MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYYJiqJ3qkkV0fpJnuDZ6ADVebeqSZnXnY0Ue4DCsDFjffvK3jCiIP2eSNi3H9OjghaZyI1iHmfGWRiWl2nzOxX20kN68AXhvD1n2IlyF6J8+NUPontgPuhl7saA23fSYNberzoN5NEwaeImzp9VzZAQePh2VbhSWWg+XBKEabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz4HZ+iO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz4HZ+iO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E811F1F000FF;
	Wed, 30 Sep 2026 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790784284;
	bh=xsjJ24tQ5ljmlVOO2mMMeo31KPYZe+omuEvM50E0/m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lz4HZ+iOkiVr5Au/6X2Mo17Q9HAJmzL7pxvLZmt8HEeXd+Z9M8/qIXkT/P+Ns6+2E
	 JDjFBNsAyUOFmpRRwxYmSQbEYiXcf5xdpuTTcjn8ivc7tipt1xq3YsIPa9tPD9r0hj
	 /bgtiFlQieMYRiqSfrRXUVy/3U5kQgTRV2iUOVXYKJbo7p/3PMcJOJf0xnBNaw+K0d
	 7GjLJFMwJ/XI1+XbUGrnrqKCwmoc1F0YhhXG9wZ1ArbLMW5I01xvS6dyKUrA3/ppIy
	 lt6A0kln3CgAjcM1gzHI9LJPjvPx1b1Dn1Z/75PbC3WLCA7gka1AVow9iv0BDKF4hQ
	 bxJaEtq2tiDcQ==
Date: Wed, 30 Sep 2026 17:04:38 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
Message-ID: <ar0y2odPFkCLMKk6@gremlin>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
 <ux7od2uydetgsu3dpy6mmilhqm5phhnk2ioxn54w3nb3feohxf@2jqovoqzfs4n>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ux7od2uydetgsu3dpy6mmilhqm5phhnk2ioxn54w3nb3feohxf@2jqovoqzfs4n>

On Wed, Sep 30, 2026 at 10:59:50AM -0500, Anirudh Srinivasan wrote:
> On Sun, Sep 20, 2026 at 03:13:09PM +0100, Lorenzo Stoakes (ARM) wrote:

> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> > Lorenzo Stoakes (ARM) (2):
> >       mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
> >       mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
>
> Hello,
>
> Apologies for the double mail. I did not hit reply all first time.
>
> I am seeing some failures in the proc_maps_race kselftests after
> this patch was added to linux-next. The failures are in
> test_maps_tearing_from_remap and test_maps_tearing_from_resize. I have
> attached some logs below

Ack thanks for the report. I'll dig into this and get back to you!

Instinctively I suspect the tests are making assumptions they shouldn't be,
given this series has the MREMAP_DONTUNMAP case split in advance.

--
Cheers, Lorenzo
