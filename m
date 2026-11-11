Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408791;
	b=o99rJULOpg2NMltSd2ZS+UuGvagwQjigsoa2saYQKrunMH82ZUijHagwj63ybBW3PJgY
	 0QK/X9yBCLlOnQ1Ks1fkhpIkvc7E45sq6v26KvgPYs6VHAc1R3CFqX+wzqu/77SuN3YB0
	 j+nsDbdrG1gSjUWaCvo+4WdDOwOzydrSuO5UZvw9Aj6eGyQCFMXogTU4iY2dUvY/9oisF
	 EGCCf/TDBuNgA4is4Y4OnDUEODg90lIWVm/2WlkBeN4h/w9CpbNFa4tDqRextVyrLup9u
	 GruvBLyAGELn9V4UivPqtPWhYLtD6+c74yuZtbUSbvAuukAY2nkplQRjNQ4wLtExgIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408791;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=B7dfgiqd1v8DFEq6Rs/JxaKvpkJdAGEZ2VRzjcBXpBk=;
	b=x2Kd6wQr5LAjOR7rQIqXeDfMeCG5wTFumyRHDTOe9Le/slRwgsapURMYyrA0eZzmX+M9
	 CYuUHs1edcTO+qUS6fbELM20atCr+R9763m8bbxW4CU9W+lpNRL/5n0hy5+bwtgUmsW5/
	 UGtOWy5IKwkDa12WaZeObEWwQf5O67V6QOozpZHJjuBlIx+xiMqxUGjs8vxoJAAfUpRww
	 VkWJbAJKt7XX9uugmprV4H5sY1pRT6N8LmB4jVX9sVRGzMtRJeXiCjwvk0Js5qAprAp9R
	 QaiKeJtUl3tFrDuU38aDyY+JZrrwHjQ0KsE6R4tS7E9b/Fel3D2o9xx4lkweGMw/J8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfAUAZ54;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666F606A32D;
	Wed, 11 Nov 2026 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfAUAZ54
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861961F00A0A;
	Wed, 11 Nov 2026 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408790;
	bh=B7dfgiqd1v8DFEq6Rs/JxaKvpkJdAGEZ2VRzjcBXpBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZfAUAZ54wbf82txvZXS9zxFhBX6LRTKjtHbh6I720LDh2KdMnLJ5RNJkNvF9PCvD4
	 a62bw6Gtc7Bu+/EjmU5W6/3gvdsgDMPXUzI0Dhlvhb5NsRMAyV2HI49BI3LvpdfOvh
	 vfUiUNix8kJ0VsQBGHFM9jvwZi1LPEo/Zm5MSI804ZIbUKvTfF3uOASggWcdf/rzck
	 YhTHplZn7YcRC7FXBYwzBzZa8aICe/mQBTbdNYvu5ful9jhyg7sVHyLMxYoP50RykT
	 XqAOMohncfAYuZgfPfY5j+DpTNUbyrlH8qSCBEkvt5vJ4Gaen74tXdqsPSQQGudOdB
	 /PDzEdbl86+fw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xR9hE-00000000Ve8-1pjO;
	Wed, 11 Nov 2026 15:53:08 +0100
Date: Wed, 11 Nov 2026 15:53:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: core: do not touch the port after dropping
 the last reference
Message-ID: <avSBVPw75Kyx9zUd@hovoldconsulting.com>
References: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
 <20261104-serial-core-remove-deadlock-v1-2-6a30597adcbf@vaisala.com>
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
In-Reply-To: <20261104-serial-core-remove-deadlock-v1-2-6a30597adcbf@vaisala.com>

On Wed, Nov 04, 2026 at 10:27:16AM +0000, Tapio Reijonen wrote:
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
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Also unlikely to ever be an issue, but looks correct nonetheless:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
