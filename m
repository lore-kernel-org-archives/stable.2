Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D43CC9E4
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320373; cv=none; b=P7pIeJmttw3AZ4iM4gvdb4BjvLrllFNt+MB+H23owLg8u9tsaNtwF+DlEbDU0SjzchS2u9gTpZBJQHnGNk7q+Vp8rbzrbXeQsNzZ2bA8Zg8pyEDEkdgjcfYZbHf3N9NDT+5tD3G0YbWlKsKwub5U+f5N6sgoNosYrOJfteG9Fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320373; c=relaxed/simple;
	bh=4CKuR0iwi+H8PshN6kwfRRYO1F/bvS125kNTiXF5YZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtKa00XkrsnwQ4RM9BfzyB25oCPDVFCHoS65xnv8VzAJ3y6Z73t3+6Y0wYYWbWIK6XpJJxyaQ543XTe3TvcqGVzf+lANzmamkSSt5u9pa3WC3lSwjY2S4qnPwtaQv2YXBytSMvhYFhnGSayo2EfkhXHgQvym1/eWETqCMp3qpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qff3xW3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qff3xW3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6364E1F00A3A;
	Mon,  6 Jul 2026 06:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783320362;
	bh=4CKuR0iwi+H8PshN6kwfRRYO1F/bvS125kNTiXF5YZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qff3xW3n8i8+mNRpFDbkXtHYUyE+l1FLr87atwzlciriugA1jMAej21YnIzQvh8ts
	 FMKJgoF6qekkRtbab1YAE6WRwE3mM1f13jvEu8KYdKR+amCegpuOUtJ7PyQJ8L6Pbx
	 JBH27Yz+M3jG1++YkCoFRQjQP7m5uoriAHe233ZQ=
Date: Mon, 6 Jul 2026 08:44:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: maher azz <maherazz04@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
Message-ID: <2026070613-shirt-festival-f84f@gregkh>
References: <2026062933-storeroom-amusement-0b66@gregkh>
 <CAFQ-Uc9p7PhXp-FC4N3iYAtyeKgN6z4A_+L8YwKDAkXxZAvksg@mail.gmail.com>
 <2026070446-blank-duckbill-13ec@gregkh>
 <CAFQ-Uc8AAEGw90BPximQm3cLzB+KiH_PXr-UZEPK9nvueMGtSg@mail.gmail.com>
 <2026070406-squander-geography-213a@gregkh>
 <CAFQ-Uc8CDnGUH3xhjaVBd+Dr=+b7Lfu1SUrGGh2gQ17WW+gqxQ@mail.gmail.com>
 <2026070421-overflow-voyage-73b8@gregkh>
 <CAFQ-Uc9JvsHVCgj6ydVrg++hA4CCxw+FuQYfKzBC65HyuJNMoQ@mail.gmail.com>
 <2026070400-broadways-designer-ea0b@gregkh>
 <CAFQ-Uc_+TQutABrGb5+JvrBLUyq30KcfLURQHoJdCw_Uu9-MPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ-Uc_+TQutABrGb5+JvrBLUyq30KcfLURQHoJdCw_Uu9-MPg@mail.gmail.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Sun, Jul 05, 2026 at 04:19:07PM +0100, maher azz wrote:
> Yes i am sending to cve@kernel.org, i sent using another email just a
> few seconds ago, please re-check?

Taking everyone else except stable and Sasha off the cc: list as they
don't care about this...

No, I do not see anything from you sent to that address at all, sorry.
Sasha, are you seeing anything from your end?

thanks,

greg k-h
