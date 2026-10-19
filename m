Received: from mail.discnull.de (mail.discnull.de [46.224.56.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6914071DE;
	Mon, 19 Oct 2026 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.224.56.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397324; cv=none; b=B+tnzbQB4z3oFVIwsy/fd/ufUxrXEadYo7jh/l8GA0g4ucOiViYT4b13H38yWdH2kpxvj8fBwDTDV8nDGnrGAYnuJ2/eSwpudnf2wBBrT0OnMtZAYLSDtTS1OjZDECvs2P+wZM8z0AwlHWeRN3fyhc7FL/lrjsb0bU1BbybazVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397324; c=relaxed/simple;
	bh=QdGs9eOZTeo9kNuN5aHlRn1yz1gBPphpUCB7CWq3S+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGJWzvDoJ7PuXU3CviS6pEKjEwiseqBYfQXd+/pZ9ENo0916tHUN78ubzYmjtTH+5LJH/JGkUiTFakvwL9DXmmA8/NTEX3xdO+zMx/2j5v33Uw1WydnF0UGKT8pkfuDMXg8vqD4oyfNECHpKMtaWahds6jVrEkkfSe64/aa5t1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de; spf=pass smtp.mailfrom=discnull.de; dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b=Muf3sYJJ; arc=none smtp.client-ip=46.224.56.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=discnull.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b="Muf3sYJJ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BAAB57D78A;
	Mon, 19 Oct 2026 10:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=discnull.de; s=dkim;
	t=1792397314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0k++ip/yGwOdTK9AOQcIPgBr0GblbGXZvumtiB3VkCE=;
	b=Muf3sYJJiRc3OyOaItgBFHy7f9YG+yorajnC4zLUvrURBuNRNWU+b00PTXudJSXmU3zHyY
	Ubx8qp71S/mI7xDwm1MO4gles8ifpZsRyWhnzLL8eYE3g5SiM69/zDpeFpWAImTkYZUhL4
	zNeoP8y3r/lesRcEfVXpe08blSjk/Cb6KqLl1OOtKzSLhkrzy+mnwTZJlPNnx2prG1uAq2
	N1fE/qui9QQcqLYX5htd6rk+V1uvQs9lpdi3HT8MQNKcw68TbTeFQjyfKaBTzHyAJJE85x
	odmEJC49kTi7cTBakx0SKQ2fomMCzaeBEgK9FKlV9P2PQoBoFy42aiZ9r72zKA==
Date: Mon, 19 Oct 2026 10:08:31 +0200
From: Alexander Sarmanow <as@discnull.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Parthiban Nallathambi <pn@denx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4035: Fix reversed ALS mode bit
Message-ID: <atXP_09kp_z2Qc-y@machine>
References: <20261012144315.1678195-1-as@discnull.de>
 <as0B1EnPqfwRO1D-@nsa>
 <20261018002822.5a5f2102@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018002822.5a5f2102@jic23-hlaptop>
X-Last-TLS-Session-Version: TLSv1.3

On Sun, Oct 18, 2026 at 12:28:22AM +0100, Jonathan Cameron wrote:
> Mystifying how this worked for original contributor.  Maybe it's one of
> those last minute edits that went wrong.

I can imagine that during the time the system powers the ALS down, the
actual sensor keeps measuring and writing to their internal buffer. The
moment of a drivers read it will get the recent sample with "just" a
delay resulting from runtime pm settings. That delay is probably not very
noticeable in practice. I think that way nobody noticed it.

Thank you,
Alexander
