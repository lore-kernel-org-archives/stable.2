Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493957;
	b=KH0bbso/FgAYbE2f0RVZcnuy48H6YBYlDcjwF5sKvwLLEd9IwVh0shuwzatp3oCkl3rH
	 24GmefonAkdper1OB073Qt+0fJoxX0eDKbPQFvu/jn/SKHoZKauJg6URlWfvOsn1JVHf8
	 YHY2O+Migm+koTfXc9QQfae0Bbn/FTorNgKpgbmV5Mqja6Uw1UR62bnFZcvQHEERjotCA
	 9LK6rResdHN0K2q0p0ckpw59zEDBtE2l/xcJLJ/WL/LEf5nn9SqcC39dcm8ckJl6flqYl
	 Y8OU8ZD3n6A1OlX3STxn6aEdOEL78wWHirSLNYY7qdXh6MOS+cOG4Tqf/NahvUrPXcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493957;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iRwwpU8G95mLImzBLZy0798VWpmUKkbtdFn9gHMapls=;
	b=G12xjlfxWNI8A7IwXbR+5A2U2pomqhIUfduHaTjkOUKf8EhCE/I10Qy5YE4c4clD3aHr
	 m0dgYtoR/zQaz1+SBV4KGYwi+l67+aHy2UvB4uG31ZhVDPepTwqxk1Vo4TEYGuJLd9DGr
	 y1+5uRQmhFDyr/lS2VFo8Of3wJYZgHGWB2ZmzVhoMvXbn0pFyrShm3hHI7nvksgEVj2rf
	 wc9y+VQSAfGW8JYYvm5yTn98hVIPCHguJvkc8EVnPwCIEdzcmPafPxaqwMrfyLP2DL+E+
	 qKYNDSd1/6wIdC2y0xhE1abhpICkqG3ppPrKbR7Dwi8/WJ7rPTLVMNIqBkiPvsLjZaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/QwmmrK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109B606A884;
	Thu, 12 Nov 2026 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/QwmmrK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD22C1F00A07;
	Thu, 12 Nov 2026 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493956;
	bh=iRwwpU8G95mLImzBLZy0798VWpmUKkbtdFn9gHMapls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h/QwmmrK6fJ0r1XsRuabyiQWfMb0bqw8KT0/RJNmS/wVmC9WKykPoKbm9GeU350Kb
	 5BUG4LOJE+TBssZhywA+uSy2tnegQ4gS5NFIMdJGqo1Agm9od7KBt79zxeV288VfKL
	 AXSjklhbaIY7+g/RbRlR3mEN5J5ynfRzMZV2m+dfh/hs1YixqYWgUbM+WqG9G6yF1Q
	 H6UMpRl/ZlU1OTjMglA+yYNGyg5bQN26lYkV2UZ745SsJmrRUyq0bWt/8LYdsixoiF
	 Nw6IC3XN/QsFu1cYrRP8QAhdMyMk6hQQ0pfeBYDuLgw5HPUbaIsGrymEDEniqxe9c1
	 SCIvN731qXOHA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xRVqs-00000001uMT-2tY7;
	Thu, 12 Nov 2026 15:32:34 +0100
Date: Thu, 12 Nov 2026 15:32:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: core: do not touch the port after
 dropping the last reference
Message-ID: <avXOArIk9Cep-rCI@hovoldconsulting.com>
References: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
 <20261112-serial-core-remove-deadlock-v2-2-d3ee4ccec37a@vaisala.com>
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
In-Reply-To: <20261112-serial-core-remove-deadlock-v2-2-d3ee4ccec37a@vaisala.com>

On Thu, Nov 12, 2026 at 04:37:28AM +0000, Tapio Reijonen wrote:
> uart_port_deref() decrements the reference count through uport->state
> and then reads uport->state again for the wake_up(). The last
> decrement is what lets serial_core_remove_one_port() return, and the
> driver may free its struct uart_port right after that. A reference
> holder that drops the last reference can therefore read the freed port
> on its way to the wake_up().
> 
> Read the state pointer once, before the decrement. The uart_state
> belongs to the uart_driver and lives until uart_unregister_driver(),
> so the wake_up() target outlives the port. Drivers that unregister the
> uart_driver in the same remove() are a separate matter and not changed
> here.
> 
> Found by review of the removal path while fixing the deadlock between
> port removal and a blocked tcdrain(); not reproduced.
> 
> Fixes: 9ed19428a51d ("serial: core: Prevent unsafe uart port access, part 2")
> Cc: stable@vger.kernel.org
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
 
>  static inline void uart_port_deref(struct uart_port *uport)
>  {
> -	if (atomic_dec_and_test(&uport->state->refcount))
> -		wake_up(&uport->state->remove_wait);
> +	struct uart_state *state = uport->state;

Hmm. Don't we also need a READ_ONCE() here to prevent the compiler from
doing something silly?

> +
> +	if (atomic_dec_and_test(&state->refcount))
> +		wake_up(&state->remove_wait);
>  }

Johan
