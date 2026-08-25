Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A32E1722;
	Tue, 25 Aug 2026 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637125; cv=none; b=P8a9CHl7NR+bcH4azHPpCRGKqTg2fhZOX3r1YoWxoPsqY6MCTOBtIeKFp3tF0LfO7qDhAje62Wg7YFeygIce7krGbNSxBggGxRvUH7NFHPPGNs5cHHzCxPPvTnParILUoOc5O3akwgftgEDt8VYOwUyb87oBo45T6OWNiY98KgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637125; c=relaxed/simple;
	bh=hEQkmiH4zmU7A+Yve3Tu++VQ4RDvGz9Izj+3UxGsEO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVrJkQjU3VttaF6YYQdTJ4m4tSBf+DDXprQykOld73VRMEOZhSJnaUQa8HXdqIDQZU193zKIHbNmQpHt61wpSmqkSsl9CSqZ7tJC8STm85ohQqy/I7eh9+raAEY7grbTHkwBJ0Iv3BmJZyhHksxNDt2muyRTvHR6KqwOEC2Sei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qmExPsQ6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qmExPsQ6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IwFfFQzYATfTzlVnI086pzx9zs4RW37/vGSH5neV+zc=; b=qmExPsQ6UFsapLZWpJ1igv+Rxa
	fw3FjmmCcgXToD0Q/m23vFcAFsoXkNRII1R0VVMOyxw3ReOlrkJhZ/QQsPsC535VzwuXqQIrHlUO1
	Z89CkEOpJfb/t0pZm4j57a9islE4ieHJ86HpQAbmTDwXd6Z0O1S76s5iFzjJA3RA0+zYJPsXMnCWp
	tnzZe90BT8sI2xAw/7bCDW08bvbR2qdvXqYaYjAIhyskFNCahfWW2GxqQ1GE26FS+21y+dPILfbdl
	tb8intP2vM97qCmPSSeFuqUzW6IIeJrZZRTVRaCy5iz8AQPtTOveISKLZ/CeIqMakLg5yDnZLplFu
	iJTjSjqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyk4o-00000000Ck8-1ISV;
	Tue, 25 Aug 2026 05:52:02 +0000
Date: Mon, 24 Aug 2026 22:52:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Moritz Tanner <moritz.tanner@linbit.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: don't return -EINVAL for successful nested thaw
Message-ID: <ao0tghVJQVIjfuDq@infradead.org>
References: <20260821085451.65206-1-moritz.tanner@linbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821085451.65206-1-moritz.tanner@linbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 21, 2026 at 10:54:51AM +0200, Moritz Tanner wrote:
> Reproducer (any kernel since v6.8):
> 
>     dmsetup create dut --table "0 $(blockdev --getsz "$DEV") linear $DEV 0"
>     mkfs.ext4 /dev/mapper/dut
>     mount /dev/mapper/dut /mnt
>     fsfreeze --freeze /mnt      # freeze_ucount == 1
>     dmsetup suspend dut         # bd_fsfreeze_count == 1, ucount == 2
>     dmsetup resume dut          # ucount 2 -> 1, but thaw_super()
>                                 # returns -EINVAL, so bdev_thaw()
>                                 # keeps bd_fsfreeze_count at 1
>     fsfreeze --unfreeze /mnt    # filesystem thaws fine
>     umount /mnt
>     mount /dev/mapper/dut /mnt  # EBUSY, forever

Can you wire this up in xfstests or blktests?

