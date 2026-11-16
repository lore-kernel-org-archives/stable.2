Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815594;
	b=ImqB1geIT1JSxzwykUpVdWZAHrhLXXRFVdbKL/U/ozmK9BqfpLARv/TIuxb37GO2vmBB
	 qNSQow5fRJhTVroawotFkF0caYRE7XSsCgInZSBGwfnn87drBy8/eFzv4/2EVsPUSyCLw
	 JMOH3Ph1EU6Vy33r4wYxfJfDQX4kHAxqaO2Ysf3YxlhsrJWND5c6QQ6V5CLGeB54qgP/1
	 S/bsoe3UkCGC5xfPRSM+ZuUgqqMpE+8T1njExJeCjMabPpF8vRu5c5wBKHQVv8oa3RA1P
	 FfyDN/D7jfxGkmUT728BQOT5IwMYQxNQTrCcYFp9xWsDZlqv5XwM8Z3VPsnfDo9Ox0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815594;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fl5iC6pchP1Kkes+KClTPwOINjWYNKh+57Nqy5+FYYE=;
	b=tH0+3ZQJ4P1tHqagsP+ZXZt7hJhr/KdSEshTaqD/1uzugJjKQNKstx14Y50ZExnY5hnK
	 UPQLhvJySPvWpfyKWEqLmO/HQXvLimPMg60ukQAukAi72mYBggCxw/ojDb1WsLz5daSPB
	 CGGD5StEmatPW7l7g17iZMi44NiHd2JOX+2/WXVAZ1TQkCsiYhooYwQGyyBknne1kFKyq
	 i+cPHTM6TvFdM435k53ZPfqUZOqce/UoOdvnP/NW6NQA2W9G38eQR73/VZuTIwU+P78HR
	 RbbpiMIg3z5euOSDXCkjIhjz7HhXAtxO0bBhONzTmzppRszENjOER3eTOBNPde/6IxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/uJkzcn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEF606A32A;
	Mon, 16 Nov 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/uJkzcn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02C21F000C4;
	Mon, 16 Nov 2026 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794815593;
	bh=Fl5iC6pchP1Kkes+KClTPwOINjWYNKh+57Nqy5+FYYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b/uJkzcnv39u4y+r0I3opyokiYyVqc8t9hr0aubWxr2iAt479dfkuPpcVx566qYq5
	 /KwWyN3QDedZR2gWAKeW/MpN8Oe99r/fzx78lmb1wfoGPNmk8a0wM9ediFrsVQkFA2
	 0ghSdBRa0rPHT55BjxDji6zGS6KkTn2X4laBQckei8uRyLsxD76EsHkowVe0vVhUzH
	 P7XxVzil6kSQc42T8x1J2qAcFDS3cgqk73HhRUSJnHS9gWsKQ5i4an2jKXP2SpmNhh
	 wlAbtVmGartgoEPcLkmjDu51K20v7Bk+G8NoXP7WLhaUc9DT+rpiGY50/+MRnaPnN4
	 QKhPG2DC7ADyA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xSrWZ-000000032Vu-1709;
	Mon, 16 Nov 2026 08:53:11 +0100
Date: Mon, 16 Nov 2026 08:53:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: core: do not touch the port after
 dropping the last reference
Message-ID: <avq2Z-eLXc-F5KxA@hovoldconsulting.com>
References: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
 <20261112-serial-core-remove-deadlock-v2-2-d3ee4ccec37a@vaisala.com>
 <avXOArIk9Cep-rCI@hovoldconsulting.com>
 <4038c504-0f04-49a5-a9ef-2dd881b7d653@vaisala.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4038c504-0f04-49a5-a9ef-2dd881b7d653@vaisala.com>

On Mon, Nov 16, 2026 at 09:49:45AM +0200, Tapio Reijonen wrote:
> On Thu, Nov 12, 2026 at 03:32:34PM +0100, Johan Hovold wrote:
> > On Thu, Nov 12, 2026 at 04:37:28AM +0000, Tapio Reijonen wrote:
> > >  static inline void uart_port_deref(struct uart_port *uport)
> > >  {
> > > -	if (atomic_dec_and_test(&uport->state->refcount))
> > > -		wake_up(&uport->state->remove_wait);
> > > +	struct uart_state *state = uport->state;
> >
> > Hmm. Don't we also need a READ_ONCE() here to prevent the compiler
> > from doing something silly?
> 
> Yes. Nothing writes uport->state once the port has been added, so I
> wrote it as a plain load. But the point of the patch is that the load
> must not happen after the decrement, and only READ_ONCE() rules out a
> reload there. I'll send a v3 with
> 
> 	struct uart_state *state = READ_ONCE(uport->state);
> 
> and keep your Reviewed-by unless you object.

Sounds good.

Johan
