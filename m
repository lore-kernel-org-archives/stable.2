Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F0643B6C9;
	Wed, 12 Aug 2026 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541588; cv=none; b=GUo/Pm3cJ33jncXWsxMzG48fwYCmKVe4AIDd0cblDkeeibdA8z2leTYHwetyj9Q/MNnEAPhFJ7doOjzQtTREoUPaxswBAp7phdys9ZhYHcRoRgJBlOLQ2dCUFyW15jAWMr0+zJ9ciHqtVrJLE2oummFHPJGGaShCA4JCdeI/sYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541588; c=relaxed/simple;
	bh=kRoRJQ+IGguc0HhnCPLy4TKL4cGexl0K8AemFs893Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPv5LsFewzVzP9Ol+md+rI5qojeF87XIMbFBl7EL2ghjcI6PtxQghgNe4W+5o6RsyYypHOWgz4dPH9TLXTlYl29e+zVeBEqHpLDunWay6m1gIaxqvV7LlQXu56qDJ3Rzgk8aFB0M/bgdbT0rTMyE6MJ6hCOvNBSYmqLcldfpIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cW4fAlIv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cW4fAlIv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h/KmvoZ0lRrykrW0KLoJkNEj044LYLs2cPvpssvMke4=; b=cW4fAlIvQyBCio/KDXtjcIx35m
	9ONQWFz+RfjDrpILXQsg0g1m+aJDw6ftLS3AwVcQTelYGUaLUPmTKc7w5t+Puhx8ixe53bAZBeRRj
	Xb3pem1CcN1DHWd+dWfHsCQNqQ2ws8WBkDkm/WXb5MqkyQWM+BHA//zfmjfz5kozeweUYgGvQVMAL
	I7X9uEFW9ky1qJ4vdHRvhaYHNLZeAMb8Pm6zssX8vmAtxvKvigMGjxMM/FuIrS0dGeLD+y/GEwXCH
	puALNddwcGCGQQb/wS+tX7giqfqdtDmfxWr3amSrP273IuH0cdd57miDcpuKbey+zquBSwIPE8Hza
	cPNP05Sg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu94r-0000000GIZd-0wBs;
	Wed, 12 Aug 2026 13:33:05 +0000
Date: Wed, 12 Aug 2026 06:33:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: daan@amutable.com
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, nbd@other.debian.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: drop stale partitions on LOOP_CHANGE_FD
Message-ID: <anx2EYhwW1kBos6D@infradead.org>
References: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
 <20260806-b4-loop-nbd-stale-partitions-v1-1-67bb75a8d7be@amutable.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-b4-loop-nbd-stale-partitions-v1-1-67bb75a8d7be@amutable.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 06, 2026 at 12:36:57PM +0200, Daan De Meyer via B4 Relay wrote:
> +	/*
> +	 * Rescan or, without LO_FLAGS_PARTSCAN, just drop the partitions of the
> +	 * old backing file. They can exist without LO_FLAGS_PARTSCAN as they may

Overly long line here.

