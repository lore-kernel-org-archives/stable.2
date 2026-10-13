Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96473523791;
	Tue, 13 Oct 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906035; cv=none; b=drxKHbVd9fqy382MpNs7jZvXJa5fPDIQtVlifmU1h/il59bcNqFAO1cWkvnjrn5IIQrxp/AndohDHV4GziJGV2iV5nqCkswPsUadYhu7T4QVioNjyTEih3FBkY8UpfeuKTzHPycr+0/UqZYeeP5pr7U+zk04ghicdjC8B5lZQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906035; c=relaxed/simple;
	bh=OHQboQ/++ttZo9KKDbgvfJ5sBJoNqvZ/O2jWbfsO3VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3A91bL+ozECERqIS/Os9TrYj6WJvtY+DW8iN7KaRx1oJ9HwgkXHb/HEj7T9NrKsLfpBgNi/uqC8VmwigurvZDVDBmfK0SYZ0Jup7b6vGiJi0Z0irEUOeQ+ETsaCIkevCqDvV3kbVBNVj9R+8VJwq4wDx2o7xm7wl3XEeBYYJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcK7ZvNO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcK7ZvNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE971F000FF;
	Tue, 13 Oct 2026 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906034;
	bh=BkAT0YkwoNVuPrBgY3GgZbtc10yS7c69UrEAnRmjKFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XcK7ZvNOCZCc596UYCqg5W7wGCvjX0Xb9J3QhuXIPCujKxQqgVMvEuW4fNB3uNcSF
	 ARnpYPPLHMtsn8w3Ls6RS3Mcy/STuksbjiXr3/hYpuh18dl0kP6jU9juV+6xoBwbV4
	 RBsvWaFHvvin100+ooG68ZCoboSGWK7aTR0H2SPQBFVD/BNqdM12U3XhPnOd86pNwh
	 ydqlz9qWUr+zsMFGyoYRrcFdtXQmyEBbDSLUJonJwsiSDtbqktBAVdoKVL+btSZfMg
	 TXFcxYYCe9RAHLaE6dgnTE0C1H6rxGHX53Y1+4fseBS2DmeVAOHIdf9CPJodj64Y9n
	 zlIP98XbTYcSQ==
Date: Tue, 13 Oct 2026 09:40:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: free the bvec on file namespace range errors
Message-ID: <as5Q8AqFMkRydVre@kbusch-mbp>
References: <20261007192745.160060-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007192745.160060-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Wed, Oct 07, 2026 at 07:27:46PM +0000, Jérémy Jean wrote:
> nvmet_file_execute_rw() allocates the bvec before
> nvmet_file_execute_io() checks whether the request fits in the backing
> file. If the request extends beyond the file, nvmet_file_execute_io()
> calls nvmet_req_complete() to return an error. This skips
> nvmet_file_io_done(), so the allocated memory is never freed. Repeated
> requests can exhaust memory.
> 
> Use nvmet_file_io_done() to free the bvec before returning the range
> error to the client.

Thanks, applied to nvme-7.4.
