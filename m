Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112735;
	b=r75ilak/jNBnnQyJUYmYgJuuffwRhBssqUZJL+5x25Ef9IX93TMHNVAC7eudwG/pH9zL
	 JfraarP3bp8/jmEiKOe4Ppi64ylAH9/tCHwd8MH3Kj7IBDi0ePtkFzXp8AADisz4YNFue
	 n8TOunjgjfR08pLCuXwMaB/ZcdUIagSR0iHapxsUSp7k6sFd2mL7OmdC3n98WLqMXDS89
	 4pqhmdOeDth5r7RY16NSW+D66OVnOjB6/caHvhZykWTNUfQJuXPNlxczR6Cteil+69uct
	 TQGB6af/NlVaNN5Y58vqIDXM1O9JMeCxyc3fkchYFnbVdaUkYdUY1j71I4QaHFa1/9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112735;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=P6tANbXVc93T7yW6YA2N4Glo5t3dM5+cQLoI/r0aaGY=;
	b=F+NmT9iDIsBUpATYjw6hyVRLAVjt/B4xYQQccx8Cmlay1afBcvBHfifg+GdErpvP2j3P
	 BqZhNHZdTiPe4xpE0VKeH+jI53G8Gn4nzR3Di/lh3pAw3KMMLutfwGU3EGqAuj8AATYpD
	 hWPxfevZoTP3FLoCXBdBiJ5/a3aAGbLfNWslRBLV+unQxnk6YMyg1jAcPF88CvRhyHq5t
	 4VZiyGFRUKzs/FhfBiQefwHLztvLsloUKK7ua5qyIa+QuuQ5mny7HyVCkOPv5dF404i/s
	 yKf6GzawsF2aCz0z7RNaOAtE7OSj6rBH/RTXPATnK9Bql+Fq/QXurCgdhPS3YS3WjcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rLs6rqyh;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25936606A31F;
	Tue, 27 Oct 2026 14:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25936606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rLs6rqyh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P6tANbXVc93T7yW6YA2N4Glo5t3dM5+cQLoI/r0aaGY=; b=rLs6rqyhDOw/NXKF/SP8+CTSZH
	qbTYw9VIim7fajpTfrXF3sqd+fF8H4LtqmnAg88jHEqT0vuXQH2H94KKptegoPDQGeWtlIk4H4GpR
	A/r/yWyXtXeptvCA9vBFzUz6+Wi5/bso9y/RoTXSo39dN5hEmVYR9G8FfOOlWrDqbn/9co0Tlne9f
	J6cudkigt6aLVvIw/bRFeTibUUX9rzQ0EY/xNJ0RCKDS0dkcMsMySK+U+RNTFhnceuDuKRrte3jKZ
	8EyxijgDf5M2GXI+AucqdNG3ls4oDzx+UaB+6mMbi8oM5lpaVUV+q5K9ukeIZC3KKpR5SGTp6fs4f
	BZmMWIzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLiX6-0000000553s-448k;
	Tue, 27 Oct 2026 14:52:12 +0000
Date: Tue, 27 Oct 2026 07:52:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Jiale Yao <yaojiale02@163.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] filemap: drain in-flight DIO before buffered writes
Message-ID: <auC6nG2jSfRhyaMM@infradead.org>
References: <20261025124115.3178287-1-yaojiale02@163.com>
 <20261025124115.3178287-2-yaojiale02@163.com>
 <ddkjou5djippzkzf4euqg4wvsnjsc23fw4qldwi3hru5cxg4ul@eyts4mtzasxt>
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
In-Reply-To: <ddkjou5djippzkzf4euqg4wvsnjsc23fw4qldwi3hru5cxg4ul@eyts4mtzasxt>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 26, 2026 at 02:31:31PM +0100, Jan Kara wrote:
> > An asynchronous direct write can remain in flight after its submitting
> > thread releases the inode lock. A buffered write can then dirty page
> > cache before the direct write completes its post-I/O invalidation. The
> > invalidation finds dirty pages, reports a possible data corruption, and
> > records -EIO in the mapping error sequence.
> 
> Well, when you do stupid things, you get stupid results. We were always
> saying mixing buffered and direct IO in the same file isn't a good idea and
> we try to not screw users too badly but give no promises. This falls into
> that cathegory... So I don't think there's much to fix here.

We have declared it stupid, but people do it anyway.  See all the nfsd
patches floating around for in-kernel consumers doing this heavy
and fine grained mixing.  So I think we should get this right, and we
should also have test in xfstests to verify the beavior instead of just
shooting into the sky.  (related: I only see patches 1 and 5 in my
fsdevel inbox, something is messed up with the series)

> The only
> sensible exception here are simple filesystems which have only simple
> support for direct IO and fallback to buffered IO for the rest. But I think
> we should handle these on a case-by-case basis and either drop the support
> for direct IO altogether or convert them to iomap and properly handle the
> waiting in their .write_iter methods (like e.g. ext2 does it).

That's a bit too easy.  There actually is a much better option, which
unfortunately is much more invasive:  kill i_dio_wait and move to
non-owner unlocking of i_rwsem from the asynchronous completion handler.
That gets us sane locking behavior without any footguns.  I really
regret adding i_dio_wait in hindsight - yes, the PREEMPT_RT folks
hat locks that aren't bound to tasks, but we ended up with a few of
those anyway and thus have the primitives, and file read/write is a
case where they really fit.

