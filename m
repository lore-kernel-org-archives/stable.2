Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EE42BE8F;
	Mon, 27 Jul 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192911; cv=none; b=pH80hgHncEdh3UgrMvhMaRvBxjLpNH6HoVVh1ZS0hqipHawYycdpWpYNeKYA5ZxoGQCxe0gWRFv7fDt7AoRdoSw47rAORbpOe7Udtkg7FlYCePx0c0Z17kQ38+s6DdyQm3fdnpMppzL6Ct6W8zhebY8xyBpuYZnZeGht5cpXBds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192911; c=relaxed/simple;
	bh=oZc3mbiekSiQQrzXlKaDqNIrvJKT52/osdzDvEbKrbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Got6LLk+rnmRMAMKlQ2FSJ3pfesFc+teKe8MqFadNl3RGL88mJJY5ikueCvRbhkGYaQdTh1SN7bITJP6KCZabcx0QJQVV/K/uKonu8hSoXdhoqfEal+INNKkPbgZktO8NeTAqWeC/Woepbcp8rj+jFLqjZhf6A20FRZAVKwhlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkpMFY5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkpMFY5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4D41F000E9;
	Mon, 27 Jul 2026 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192910;
	bh=swBgvLc8Y1Ves6RR6bfNykw7S5qr+ZXoAhTFMoI1I8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SkpMFY5JZgjvxcHxrAE4sGqLhlChvkpdDJ6jOjj/Jb/b+ctweACZQ3yUD0HWXnF3S
	 h7YXrNt9mMI2mNYZp/QNnilyRN8+6Sj5WAKj/napa1lX8yuvmkOjdBQMNdrs3NWwvO
	 SrTUklfSdKgupGmUgyuRLbS7ZjMGdHhaDRNMsNJg4/8SwppgHHQxHEcG9kQjfUfh4h
	 7wbCJxudannjGRBuoZ5jXoIeSxTHC4LWAhPC5fG9/b25HcpmV8nwb0DyDNw4/66OHe
	 MOR4ovNd5po5WmkHq9OsP/EGI/RKFoMYRDCC1ldphM8Wn7s189yR6n4fvxZ1eLQwHq
	 qIO5tR1Gt39YA==
Date: Mon, 27 Jul 2026 15:55:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, ms@dev.tdt.de, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 federico.kirschbaum@xbow.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
Message-ID: <20260727155509.1c5235ee@kernel.org>
In-Reply-To: <20260726053330.41736-1-baul.lee@xbow.com>
References: <20260726053330.41736-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 14:33:30 +0900 Baul Lee wrote:
> x25_kill_by_neigh() walks x25_list under x25_list_lock and, for every
> socket bound to the dying neighbour, drops the lock to call lock_sock() /
> x25_disconnect() / release_sock() before re-acquiring it and continuing
> the iteration.  It holds no reference on the socket across this window.

already fixed.
