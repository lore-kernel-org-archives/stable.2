Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A313B2FDC;
	Mon,  8 Jun 2026 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907796; cv=none; b=G2+DGRd5fVwxxURuGT9y8zLdNUXR5Nn8sNrmBR4h7ZDbYULueObFe3P+zL1a5Gt0UQYShJ3kDalbG/NZWwHm69xdl+LQvzREImhlV1i1ArhzfqQDlRQARmS5H8ccB3WE/NH7NHwAhsliUvn2MpizwgO6WHGMHk4IHCgJ8WBmVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907796; c=relaxed/simple;
	bh=e9+oLfn5z/kAdf4TxC3GBFLbvp5XlU010/ZPdc6vqdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYZUhA9i2M220xwoDNf5zzpb0sc4ohn8Tx+9kpsx9Z8qf/CfNCqB6HFvRIfsomKGcl8pmiOZd48oo1hOeH70MDGLcq+CAxyiME43ByLyk3fhaG4wa9nHEv8tq8vpdL+7nuS8fojyeZTY65vbEPAQQHlQ7Avfed9ZzaiqETEbkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy0a94ae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy0a94ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FEC1F00893;
	Mon,  8 Jun 2026 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907790;
	bh=ObnGfCch9w6TCOHl+yVipVQyNyIiReIde3OW5t4g1tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dy0a94aeRApwkpLO+ZK5VJoH38UT11Yet3iYJyFvMprgIEXZcCgzU8pRWQBrYCiR7
	 FcHx4TbtN+aSRx2/Acj9ANoJS68I4u0/UdDsy6kqCSD8JOdiBcLS6F1bco2qXdZa3o
	 EgE1XpTaMoOtY7LOINs+KP453nEa4A4Io48KXNRf9L+DxYzH7OmqbfoiXrZewcYS8u
	 OuxWI0hAIG2OFrw0sQFqt9WAh4/YubdxP4wh9yUP/98Aq8UGptZ3Vv3zXj4iMBe4+N
	 7pKpTa8OGliXZz67I39LSTD2CRINgEj8tn1Px6+4A3YAf64ZFu9HJze7uOvK1+fZ9J
	 l/TxN6YKt6cPQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wWVTA-00000000N8b-3Q4N;
	Mon, 08 Jun 2026 10:36:28 +0200
Date: Mon, 8 Jun 2026 10:36:28 +0200
From: Johan Hovold <johan@kernel.org>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: kl5kusb105: fix bulk-out buffer overflow
Message-ID: <aiZ_DJGvrmotkM3J@hovoldconsulting.com>
References: <aiZiZy8a0al7xVXe@hovoldconsulting.com>
 <20260608074931.5911-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608074931.5911-1-sammiee5311@gmail.com>

On Mon, Jun 08, 2026 at 04:49:30PM +0900, HyeongJun An wrote:

> Yes, I used an LLM to compare the custom prepare_write_buffer()
> handlers in drivers/usb/serial/.  kl5kusb105 passes the full "size"
> to the fifo copy, while the ones with a header or trailer, like
> safe_serial, reserve that space first.

Thanks for confirming. This needs to be documented in the commit
message, see:

	Documentation/process/submitting-patches.rst ["Using Assisted-by"]
	Documentation/process/coding-assistants.rst

Can you send a v2 with the missing tag?

Johan
