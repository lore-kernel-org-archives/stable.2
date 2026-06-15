Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1262E7BB6;
	Mon, 15 Jun 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523080; cv=none; b=O1iH/siq5KejWNhvrlMFNoPdet0NoyWAigz/mDmPuXBC/3KAXZKJ2vlmqXbeSt86Cu91oy2mGaaABRYlCa6eNTxtV96rQXkQuuKrY5WnGes0bkHHXiZinLeAAzzrSUmN+7lSzDMdiCKHQM+Hy+5AdrqgO7qYZNMNkkqK+gGWvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523080; c=relaxed/simple;
	bh=vGp9DeeFUhWXlnjhTHj/krKinCUvuD2zCvy7lDw0bp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeNj2SxGnNjhBmbKz1af37O5NUdVSipNfstXkeniswKIAQD9BzCz2+20BcnjalCzf5qZ7rQH28JHxdJZnL+AtqXbQfZcRGvIS38YLuz539jRiajjQGnpbRohka4TRoQdtQNvMN0awBLU8Hy5vTT5khwWTlX69EQtuzUlriMjlM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1HCsP8aM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1HCsP8aM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dYCpL2v7hA6/R1B/68TFnCiOpsxkYHbF6QRYAWthKL8=; b=1HCsP8aMou7VyueWI4ao4mnO+y
	ysEVx8CdjtiPjz4A1VktRS9OAo3ZY1ihF6KiZSLWzEwFL6RjVTBmPcXqJmaGVKi17szH0AeEwh0Hd
	M67LUPjzeINeLgmag66iHSQrtzeM/7DiaFo2vEf9dW7y9Ig5xsOUrGQxYRwCJ4duJ82M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ5Wq-007n0V-0c; Mon, 15 Jun 2026 13:30:56 +0200
Date: Mon, 15 Jun 2026 13:30:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com,
	fengxw06@126.com, horms@kernel.org, kees@kernel.org,
	kuba@kernel.org, linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, qli01@tsinghua.edu.cn, stable@vger.kernel.org,
	wangao@seu.edu.cn, xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn
Subject: Re: [PATCH net] atm: br2684: validate IP header length before
 filtering
Message-ID: <354fec7a-608e-45a3-ba62-a6d532d26e46@lunn.ch>
References: <e85fe7cc-05d1-4fb1-a919-baa170d08307@lunn.ch>
 <20260615061055.30419-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615061055.30419-1-zhaoyz24@mails.tsinghua.edu.cn>

On Mon, Jun 15, 2026 at 02:10:55PM +0800, Yizhou Zhao wrote:
> Hi Andrew,
> 
> On Sun, Jun 14, 2026 at 08:36:57PM +0800, Andrew Lunn wrote:
> > So did all these people find the problem at the same time in parallel?
> > Can you point to their reports?
> 
> No, they were not independent reports found in parallel. This came from
> one internal analysis/reproducer effort, and I do not have separate
> public reports to point to. Sorry for the confusion.

Please take a read of:

https://docs.kernel.org/process/submitting-patches.html

There is a section about Reported-by, and what it means.

>  > It is a long time since i worked with ATM. From what i remember,
> ATM > cells are 48 bytes in size. So can the packet actually be
> smaller than > 48? Would a 48 byte packet trigger this? Or is AAL5
> involved here? Can > AAL5 carry a frame smaller than 48 bytes?  On
> the cell-size question: yes, ATM cells carry 48 bytes of payload,
> but br2684_push() does not receive raw ATM cells.  It receives the
> reassembled AAL5 CPCS-SDU/PDU from the ATM layer.  AAL5 can carry a
> shorter user payload in one cell by padding the final cell, with the
> AAL5 trailer carrying the real payload length.  So an 8-byte
> LLC/SNAP BR2684 PDU can be carried in a single ATM cell with
> padding, while br2684 still sees skb->len == 8 after AAL5
> reassembly.  A reassembled 48-byte BR2684 PDU would not trigger the
> issue in the LLC case: after pulling the 8-byte LLC/SNAP header, 40
> bytes remain, so the IPv4 daddr access is in bounds. The problematic
> case is a reassembled AAL5 PDU shorter than the encapsulation header
> plus a minimum IPv4 header, for example an 8-byte LLC/SNAP IPv4 PDU
> with no IP payload. The VC-routed case is similar: the current code
> reads iph->version before checking that the reassembled PDU contains
> an IPv4 header.  > What hardware was used when finding this problem?
> I know DSL often > used ATM underneath, so was it a DSL modem?  I'm
> sorry that no physical ATM/DSL hardware was used. I verified this in
> QEMU/KVM with a small dummy ATM device that registers an atm_dev and
> injects reassembled AAL5 PDUs through the real VCC receive callback
> after BR2684 is attached.

So this is hypothetical and in real life not a real issue. Please drop
the Fixes tag, and submit to net next.

ATM is pretty much dead. If you do any further work, could you please
look at currently used hardware, and try to avoid wasting our time
with hypothetical problems.

    Andrew

---
pw-bot: cr
