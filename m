Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488EE49E5EC;
	Fri, 25 Sep 2026 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341345; cv=none; b=gBp/VMyMPDpEP4jAKyjWm26HV6DUdDp4sGj57+w0IQiVnUgSqy2qvTOHdLaGacmvs2z7R0w8XurmTAgbQgD1MTwzAUaNSBAEJO7dMblYOfX9kT1MzXn5VljM1fnXifGKJrR7OQFznt9dtWATuLe9oWhECZZ9MohkXeqpOx1A5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341345; c=relaxed/simple;
	bh=86Q+kpbqK2XH21ICkgcfMbjN4TX75IoXzLw3Y/VHbbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElETE/I57OaCDuvAtHBtFLrZfK5oLk8z1fqTwj8q1jZ6vjF15SDUFjo0aQ8bJ7oW6oEqzUOMgJKBb0kDcSYWCf/3AeZK3Gk+XahiX33dgccf4mZcuJJJXkVr2hXu+uBAvStFvbKs46z4z2oGvXVqwLybpZh7SV7U8XPmLUHj9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBzZFawt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBzZFawt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640B91F000FF;
	Fri, 25 Sep 2026 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790341343;
	bh=86Q+kpbqK2XH21ICkgcfMbjN4TX75IoXzLw3Y/VHbbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vBzZFawtvRBxTtz6sPKGRj8LZRvwccv2nhkTlfeqJZ+VGYpBvrDkrUGRhVvLf9piI
	 PEO1OIqEM1FDpEo2N5dKbHbDqMU4jNael1eLTNQ/0dLP+TQVzp0ftPpDcPFbX3SrpM
	 5I8OHMtV+x+pHUk6kgoUmWPBxV235+GGj0go7wC4=
Date: Fri, 25 Sep 2026 15:02:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, hugo@hugovil.com,
	tobias.gannert@ziehl-abegg.de, joachim.knorr@ziehl-abegg.de,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Message-ID: <2026092506-harmony-moonwalk-2d2b@gregkh>
References: <418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.9bfc333b-cb48-4556-bb8b-6dc939087693@emailsignatures365.codetwo.com>
 <20260925125443.168134-1-paultyson.mbewe@ziehl-abegg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925125443.168134-1-paultyson.mbewe@ziehl-abegg.de>

On Fri, Sep 25, 2026 at 02:54:43PM +0200, Paul Mbewe wrote:
> The content of this e-mail and/or attachments may contain confidential
> information and is intended solely for the named recipient.
> If you are not the intended recipient of this e-mail or on its distribution
> list, please note that any type of disclosure, publication,
> copying or distribution of the content of this e-mail including attachments is
> strictly forbidden.
> In this case, we would kindly ask you to notify the sender of the e-mail.

Now deleted.
