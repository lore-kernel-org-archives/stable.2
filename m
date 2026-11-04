Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802740;
	b=ag4rKIi/7eLaYvqOl+rn27tY/HsTt7q1xSWxw6sAGz+L5FE8UCOlwtt0jp4jQX2DB6Ht
	 WxxiGJq3g2/Z/4K2rKBuf1LugSyHjImuiwtV8KXC2SfpHWm8RRmgJ8rnvI1jKZgnjIb7/
	 jnFpE6QvvkGWf34rs2Gj9KzWncNPtoFZAesRraKFTg7xXr/Zs5dcxVBCWDL7ULG+sGG4y
	 ZHuXr1ZxRyAlcBfPLOj5VRRaOiIqGjHrlzPwv+TWDTpDDnRXNjXmFmBXX28mSXIxUJgul
	 fMeZKKCUA5ahO0O6Exy+UbfxxDkBl9+M1WGgfgAFAQ0j515EoqQ3gm0B2pbF/KADtyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802740;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ruu8JrnBwogLTne/D6uuGsufWUgVImMj+eWmulfcz+E=;
	b=RMSW4ogePJdt5aLCe+UwtRS41mxUGyMLbKxcDXmzs8G+IHkyPcwovnTHm+w8OCl2nxoE
	 WDR5pAfZV1HwhNw/SjCeVCRRb+t7aB4G7iF8CO/noN0ncZ8CHMM6IWLWT0h05G1Ld49mH
	 ARmJJAFaAJu8aSBPRbWDbzQqXJms+q4oPQKbgITdZhWl7z42wUJw6W/C3Mp5GZV+3BI7T
	 wXwMVmzbohl984L2acAZP6/tKnHV2vYn6aUZtTqxKcGNDn31FXFPH+N0ZQwPFS8RfdPfM
	 NQYytYa3YUnXmiwhyh5sEkDvQSBvE31Zn8/6R5pij1bMWmQazkhifq/JvenlZqaDzYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WPShMz71;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16746606A31B;
	Wed,  4 Nov 2026 14:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16746606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WPShMz71
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ruu8JrnBwogLTne/D6uuGsufWUgVImMj+eWmulfcz+E=; b=WPShMz71Ub0ru03Q+/16XtsIp3
	hFwUkwg6C46KgyjigFTJ3sWDX+t8VOtxv9XebZasMzS/SEqjE5XsuSQHHqOo+SVtNX7qrmmNd1D44
	w0HDiJiRJUKPqPXx3LYdBvWmk+tJfvWU0L1DmaJbPdiQQGpm11EWCRDRo6dz4WdfEcKaV8kLvD3Ib
	s78Yn32GD37QQrlisZD4u+EHy629/zWbdwVy8IlFBOgeF6u0/eUl4gHkAjbWRUoS1+iLt0ebNvuv/
	E+0MDABf8vf5iLPZfw7+vpeSTCghHpivz48qTgyV9lwHZbh4CPQUHe2XtlYS01Wll2Qjmgji8JMZ3
	5DAPZMsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOc2C-00000009glu-2ihC;
	Wed, 04 Nov 2026 14:32:16 +0000
Date: Wed, 4 Nov 2026 14:32:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: me@bobcopeland.com, akpm@linux-foundation.org,
	linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] omfs: reject writes starting beyond EOF
Message-ID: <autB8H-rCbbeTdF0@casper.infradead.org>
References: <20261104112052.5604-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261104112052.5604-1-dennylin0707@gmail.com>

On Wed, Nov 04, 2026 at 11:20:52AM +0000, Hungyu Lin wrote:
> OMFS does not initialize gaps between EOF and a buffered write. When the
> requested block lies beyond the allocated extents, omfs_get_block() grows
> the last extent and maps the write to the newly allocated block without
> accounting for the skipped logical blocks.
> 
> A one-byte pwrite() at offset 8192 into an empty file returns success, as
> does fsync(), but after remounting the byte is at offset 0 and offset 8192
> reads as zero.
> 
> Reject writes starting beyond i_size before block_write_begin() can
> allocate or map buffers. Overwrites, appends and writes crossing EOF
> remain allowed. Gap initialization can be implemented separately.

Why don't we just delete omfs?

          This is the proprietary file system used by the Rio Karma music
          player and ReplayTV DVR

Rio Karma and ReplayTV were both EOL in 2005.  Let's just delete this
filesystem.
