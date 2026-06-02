Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0A36657C
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396983; cv=none; b=GILNYB3o8Mu6ftQLKIMRv/lJ1T5Xniy6pqyoaozWftieFCualXaws8+sFeQNs+ywjdSQPM9LXrzLY5YaGSgxjWIt3mOcmCw5r2nLNBOLzkRVbJv7JrbWKrOudiwPbJ3MbTFO5+/cyrjcuSHxh7FQ9kG78Tc8Mjg9wF7DXXiegg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396983; c=relaxed/simple;
	bh=RtvHospS3Wp5cPDvduQUj3YHzTIC5fGzFo7nXYRGWSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsQc7Yb/hvgoHiCCP4w7F0N29kFhdDTajOpmjN7iJImlsTDK8IG90tId+SnrZ4OxThgXgWIQj7Mep/GWSr5yCxX2SBzahDIEPgXX0eUqtYTout1uIQgMLyh/aDfq9NaBBjKp8pS5guwAo4vTQxJK6YyKRd1pQhC1JHt4CXns1+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcV/x2Ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcV/x2Ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CF21F00898;
	Tue,  2 Jun 2026 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780396982;
	bh=dBN7+LCKUuURwXu2/RKNcqi0MvqbJNp++LcpFA1slnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XcV/x2VeYtkg5UrNU9uOcrK0TMbijwcJJ4toN0W6+5548cpZqaaR9NWLhSGy+8oSF
	 K8t7EzxcQklb1nFS1xNxnXyhDXU7bH9dg0DcEjHhR29y7dfK4CwHKrkmXRMbAzMdrB
	 3sJ6AxcHv7PPkZXo0gC0ydXyYczOb8q8Ot5u5cAYekMudp+Nu8C746mJlC4qJDvP2H
	 G43vGNSNW4CAV7HJdoo6xt1N4tWd6xjWye96QYgKX/u9PTShz/wNHSJGQF7CG/9PF9
	 xU4abwF2FgkIsIyqQMLNgvhcK9/zb8jTEVFu4tu3kKhOMVWCS3JxeAi5qLxKk4F0/Q
	 RQ0y8kxELSXuQ==
Date: Tue, 2 Jun 2026 11:42:56 +0100
From: Keith Busch <kbusch@kernel.org>
To: hexlabsecurity@proton.me
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Greg KH <gregkh@linuxfoundation.org>, sagi@grimberg.me,
	kch@nvidia.com, "bvanassche@acm.org" <bvanassche@acm.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in
 Discovery Get Log Page
Message-ID: <ah6zr4-8hLlY-Gzn@kbusch-mbp>
References: <Q8CVAA098pa1LIPOSNGvR2qrzqdOBQqRTLK54O4KsGMzSh4IOT2Ucrlv87C0ULvpILYim-FotD-OumzPcjFauZM2iyjJ4tjzaMRsXE7G_3Q=@proton.me>
 <20260527132353.GB11071@lst.de>
 <QQhn1zPqAyjwS7XXM_jeFtjpyW7pXcVTGMP38boMl6zWR5ehel-nsdJdksZf0ASO03qt5pX1B5UAnlANuO7KZISSgggAjnjLruly7nAjJ2A=@proton.me>
 <20260528083537.GA7590@lst.de>
 <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>

On Thu, May 28, 2026 at 04:02:17PM +0000, hexlabsecurity@proton.me wrote:
> From 6710e68439c458d691a4fe5c7fa354404745dd0a Mon Sep 17 00:00:00 2001
> From: Bryam Vargas <hexlabsecurity@proton.me>
> Date: Wed, 27 May 2026 15:00:00 -0500
> Subject: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in Discovery
>  Get Log Page
> 
> nvmet_execute_disc_get_log_page() validates only the dword alignment
> of the host-supplied Log Page Offset (lpo).  The 64-bit offset is then
> added to a small kzalloc'd buffer that holds the discovery log page
> and the result is passed straight to nvmet_copy_to_sgl(), which
> memcpy()s data_len bytes out to the host with no source-side bound
> check:

I've manaully applied this one, but next time, could you please just
send a proper patch instead? This whole thing is badly formatted. Have a
look at the raw message:

  https://lore.kernel.org/linux-nvme/39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me/raw

Just use 'git send-email' on a 'git format-patch' created patch.
