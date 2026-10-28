Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793211123;
	b=4iKzyOxZ3QxzwyMDKettGId0c0KlmNFdqT4Lb/c9HQOppUpOSyUrE87jN6nmNvL4dHnT
	 40UN84v5+sODE0KUkp/6E8g7+PvHGEp3R8Lh97G3CYb0vNWOipJtSrR/exT6W1Y5CF8hD
	 hwnIMYjKqKelzJcV9JJL6O3Z3Yb+B7YA/SzMUoSqrQqC6jqfIflkCgbfTQyU2oiIetHgG
	 Y195NtILHUjqMl1zhZen5D6qA4rxzd1g2Vv+a5YjgJeVZJmQnVFNzHFUO6SbuPsj1KlmU
	 qVvTETvg75Ip5ynbN1FfmjvS7oMhJNS6PfMUkuD/9nYFczzu433DmIKtvkUQ+UuvtDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211123;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=gcTBoDoZodNeEIG1NJv/Cf9hQ2tDZQXR8IELFFZ5LJg=;
	b=vnR/ina+B8BLKTww2iHwO5FZKfk7f90bxC2vvl0JnFWQEMWb6VpFIFlozq83ccO333a5
	 QFFwtueH0YDMvIHCsdbBf53lWQyIR2e+s59e5vpqXkPuZlsvvGPjO0iMB23c+X3xaZGVy
	 K+2lmHfaSEcs9zWLO/023q7HNH+8hO8EcQ66uoSDnUMLo7Gd1WYKOYTkXmOSwAEXBg1sR
	 7qQfQ2WNlUM7kWK5zswc8RUOnBNOFf4AxhUgiCAe4/qC2cj1FO4K3KIGEmJGq9yVKMvDH
	 h1I1EojwuIqvDQdx1izOv4V2TyDPyLz77rU1rrLeL2Tz2L9+AjCpKa8WZai48/JAFgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=nMYwWowe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.169
Received: from mail-107169.simplelogin.co (mail-107169.simplelogin.co [79.135.107.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C760A6F55
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA6C760A6F55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=nMYwWowe
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793211121;
	cv=none; b=BzG0lB8P4zva5dAFDcBP+oC74Bj5FI4S0vz8Exbm9fognNCIp0i44ovzsAMrbyegfCjprDKnWYcG2OgEYb+ipD8ITje4d+lktTWXMZJGozgnXfIV6HBtBg2/DA35FDyz5c8ZQDpgirojpgtGlvWtZzG15JD6fYO6cpYILhsL+96CpfaJUpSyQhM10ZNx+Fg4paMchKrTh2c5GVuH14Y4xpWZHI5p/vww7xuG0l9Pw8DSPeMkFpZLwCOnucTM3S+EPlFsbuO0vxVMWCUc3lXgJCH7zWe46539gN0ym8BWgqBgxm9isE6i/OqWbOaWaC0VgQImbSqIzFHnqsbwY2AnDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793211121; c=relaxed/simple;
	bh=gcTBoDoZodNeEIG1NJv/Cf9hQ2tDZQXR8IELFFZ5LJg=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=2EiSOJHJF7wPWN19/b2/NO73fwlhIlaarJDH7BZKyCThGF92u+rV6qjDWW69mgiU8FMMUy7xR4QpMDBe0rI66getPwTvVHhe5MBO0qGrSUgWlQCrX5ci9u18mDBPM3p5ejBqMDsbT9uIwNvChoCtIdeIK/Tw1B+sEHQqY+Zgd1Pf6LV2af9A7UQW/aFub2HfoNpdwmc/McDm7YoRnErHm6vzVZucvRCl9ArqPkBpa7LQTuvycQgNtrTonghocu0FJJAvyCAXi5fzamvvDB80+8f2XNxUp1KD2YCMBIB+1agnTcBdE0FQs5VCkkbhopUNNRLiIvAR18/VYicvsJ/RaA==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793211121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gcTBoDoZodNeEIG1NJv/Cf9hQ2tDZQXR8IELFFZ5LJg=;
	b=nMYwWoweV5C8iF5Ujdap//+3tlKAtTL3Ld/Aor3RClh5/JuBn9vLAlyJvlRwRakfL8F7lu
	Gjal9LiExFhPSVT3KwMngG5iyA1JXh9tt+5OuQq10b+0wzV9sVMcJuzWdpw7f62Jsw6sgl
	goPdLFeotMzo+1OkshnM8VriX+aYAxw=
Date: Wed, 28 Oct 2026 18:11:53 +0000
Subject: Re: [PATCH net] vsock/virtio: clear vqs[] to avoid a UAF on a failed
 PM restore
In-Reply-To: <179122121054.434549.15763347362425052652@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: netdev-bot+sashiko@kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,Jason Wang
 <jasowangio@gmail.com>,=?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,Xuan Zhuo <xuanzhuo@linux.alibaba.com>,Stefan Hajnoczi
 <stefanha@redhat.com>,Stefano Garzarella <sgarzare@redhat.com>,"David S.
 Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub
 Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,kvm@vger.kernel.org,virtualization@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179321112009.7.11441275993569600318.1728181970@eldare.de>
References: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>
 <179122121054.434549.15763347362425052652@kernel.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1728182020
X-SimpleLogin-Want-Signing: yes

On Mon, 05 Oct 2026 17:26:50 +0000, netdev-bot+sashiko@kernel.org wrote:
> The detach loops now handle NULL vqs, but del_vqs() still runs
> unconditionally. Is a second del_vqs() safe on every transport?
[...]
> Won't __free_irq() hit WARN(1, "Trying to free already-free IRQ %d") here=
?

Yes. I reproduced it with a virtio-mmio vsock device (QEMU microvm): after
the failed restore, both an unbind and a second freeze warn "Trying to free
already-free IRQ" from vm_del_vqs(). v2 treats an empty vqs[] as "no
virtqueues are live" and then skips the detach loops and del_vqs(), while
still resetting the device.

> Are the virtio_rtc and virtio_console references accurate?

They are not, thanks. v2 cites only the virtio_blk commit and keeps the
commit ID out of the code comment.

I'll send v2 as a new thread.

pw-bot: cr

