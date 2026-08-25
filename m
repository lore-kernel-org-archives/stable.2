Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59F3A4F50;
	Tue, 25 Aug 2026 05:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635715; cv=none; b=E5QVoPKfWZ3udHNHYmx61/hA9+c3bdOvhcZxIAgAOBtUEBEe0e/IcQjSxGh1h5YrODsubwx+G+Flo47JNdhfQmOWTC7E/njzzU6e2obQGCSjrwC49+9KLoqqlMo7Or9RqsoG8duvgY8M7XIq36G+LSx6slQyCxQRuFqTR7ydAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635715; c=relaxed/simple;
	bh=cE8B1E3WUZf5IEnZHWmkidhn4OymyKdzz/G+c+ZGFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiBZSmjlWJ225uGYR5MYNK4CmNJW9aEtVW34syUBfacZLG2weKClOM5U6dXmYZ/PjARrCAouF9heUcxBeOWJRc990q4T+yFGcLi1h1Q4yLh7Cir1ibapbj7d+o6Z/S0I2fB+mxghccl+ID3vGfr7U23k9+mo6zkQAr6qr54gXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KjXimhYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KjXimhYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3277E1F000E9;
	Tue, 25 Aug 2026 05:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787635713;
	bh=cE8B1E3WUZf5IEnZHWmkidhn4OymyKdzz/G+c+ZGFes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KjXimhYijdnoTUTX+Ye67ntsYUMitjn2JFoJjBe7VQ5dsR2mVd5yoXfPlPic3yn9e
	 5gnYp6k8On28QoaC3eY6ZIj0NdlLHUJmk5fq/9iKDbAvCGXyF5gcUr0Bls9jK/Vlcg
	 XzzVMCtQaZzgXUYYN1rA8yS0H1YUiTWUc7D8aC3s=
Date: Tue, 25 Aug 2026 07:26:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] staging: rtl8723bs: fix multiple OOB reads in IE
 and frame parsing
Message-ID: <2026082538-divided-raving-3346@gregkh>
References: <20260728125456.32359-1-meatuni001@gmail.com>
 <CADqcGB=j8cSE-CW8dLC8My0rk70RC-Qidmvr-dZvzCUFE5wadA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqcGB=j8cSE-CW8dLC8My0rk70RC-Qidmvr-dZvzCUFE5wadA@mail.gmail.com>

On Tue, Aug 25, 2026 at 04:10:36AM +0500, Muhammad Bilal wrote:
> ping.

Context-less pings are not really helpful :(
