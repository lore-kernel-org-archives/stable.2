Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793988213;
	b=FHo6+MkSyNS84GfiKVUAVc34tr3PwOxmjG0Q6H6HqlOWHhVbiesqzhr47b1wdUWdyTGa
	 7mTTm9JWur0cwT8Eh65NUsKlfkFeT4slqjCQYbK3C0eh5AYMJGwnOvk9roWPTIQEBRdOG
	 GAvwKcuSkXPZqtY2no4/wrVTWLnF6QemTrNqbacxNu0Ig4NfArwcOe4Kd1XbGQ46W+YIV
	 QpigNcB/9Zt3QpUPSNsXMvhXwyOwC1ox7YqepBmQPs7JNOVD5AZx959uKvRYNxFIvQwU/
	 Uw5zNj6Gdli84sGVUO90vIJBdm0YSMBXZzZRIVUf3AMQOudLZ6e7sWUNjFr0UQ2YPgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988213;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=SiS3p1Pdfw5SumEsCCsXq+4z7US+NPjbCfUp1+4kB04=;
	b=imwOqwCciCWwXEFJ+ccGPZaQn0kpcG4PZxIMID/9ebWODgXDVw34M6HdJ5MS3wwCNAvi
	 ph3CoQ3QBZreS7qAFKj2ZgQPJUVY9Bt9pruH+JyKkA7SaGJ3+Q3QBCS+JSuY2UIFOjiVr
	 TCop0diMZX5Gwwo13vqbzXs51N6PVE1QWSgufjb5Rdkm5bcnow3uJd7mO0AxlBRFtCTHX
	 VIhR77JLhBLFFGk4oeGUdr6Ag35TWjNJbukoDim5K9eQiDHLdj8dhvdOj16I3IghEWcDI
	 TO6DJfiKABFXitD7Ybvfyus/BBZmhA4MYVZbMqUx2MP8xeplNCq52UOmfxlhHeDzzOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=SCJ3yZca;
	arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.171
Received: from mail-107171.simplelogin.co (mail-107171.simplelogin.co [79.135.107.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F7606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 145F7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=SCJ3yZca
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793988211;
	cv=none; b=TnL1jVtSQDg9t4tNi2XEcs1buOQeg4an7YvtMUvXf6nlfjSZN8nYNWX3V5BhkJevk5zn0RW8Ja539uEZacN/xnHJiuyyaQwxJp3f5lrD8stG0/42x66cGX3VrLsmsrFt9vPaVQPMFuDV3L83UnDTfA2Ph6KDYhOtpi0vdlf7zhfyAgi4G1VEC0mnrLfNKS9Vn1o07Mr2ZGHQaqsAg+BoN/IBj3XcfdgAryhOqL+S49s9tRt8POL9hrw85unGDuX2LKvybKnlgPL9YGSzvxbHnioFHYXKqfYXu20LamY9PyvkDW944jed1aINMoL+OpwZ75VQLHbBGRf+kPrAX2dhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793988211; c=relaxed/simple;
	bh=TkX1EUPzM5jpig3x/0OdpL9Rw6sv05DAS7uiaOgULNc=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=YDuIBsEZd4MM40MhEuyuML2OCJayxxhnz7lnTJoN0IpUmKSHKcnuXpHd5h4egnSL+pxbWkVtjMwxa/cos8whk/ak9Y3NHu/fuy2Apqnj0qHj1U6MVJ8kQ7ghAmW2leVs/jAvkan8hPUxxhnA7kfVP63m45xIqE11llYtb6/fFfd6PkHVK445mzri5PU9O+JefMLpvfXIwaepfqpEeLrlHl8o+vUqGGeNjaWugC75h/7l/nlMj9VmyBAduDbkhUZjvgr7Ukr4Pp0kk8JM3vcTXVvs/YOSAZofcfeGfJgasdY1sgHNlYdsv6zU6OI6MRLbaDb3Z2+aF1qjBYRbOSy0eg==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793988211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SiS3p1Pdfw5SumEsCCsXq+4z7US+NPjbCfUp1+4kB04=;
	b=SCJ3yZcaAZOrUb/mfp9+Y66EWkaIeofok5zYSLGGsp8LJVwAJEbog283DH2zAxWzc4+ipB
	/uy4sQgYFvh5mhkX9b4+QlY+BYQBhJI+nn8mLEkcan/7rvW9AIlqebWUeFBgK8GDH7wxDy
	HkjrC5Vm4zqxCP77c8WCziIVYWWJfiY=
Date: Fri, 06 Nov 2026 18:03:21 +0000
Subject: Re: [PATCH net v3] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
In-Reply-To: <auxVKMavkOw3Ia-6@sgarzare-redhat>
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
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,Bobby Eshleman
 <bobbyeshleman@meta.com>,"Michael S. Tsirkin" <mst@redhat.com>,Jason Wang
 <jasowangio@gmail.com>,=?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,Xuan Zhuo <xuanzhuo@linux.alibaba.com>,"David S.
 Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub
 Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,virtualization@lists.linux.dev,kvm@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179398820999.8.18191536850628408290.1752255756@eldare.de>
References: <20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de>
 <auxVKMavkOw3Ia-6@sgarzare-redhat>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1752255871
X-SimpleLogin-Want-Signing: yes

On Thu, Nov 05, 2026 at 11:19:23AM +0100, Stefano Garzarella wrote:
>On Wed, Nov 04, 2026 at 05:26:43PM +0100, Jerome Mohm via B4 Relay wrote:
>>Clear vqs[] after del_vqs() and when virtio_find_vqs() fails. Return
>>early from virtio_vsock_vqs_del() when vqs[] is empty: a second
>>del_vqs() would free virtio-mmio's IRQ again ("Trying to free
>>already-free IRQ").
>
>Is this an issue or just a warning?

Just a warning: free_irq() finds no action for the IRQ, WARNs and
returns without freeing anything. That taints the kernel, and panics
only with panic_on_warn or at kernel.warn_limit. v4 says WARN in the
message.

>>+    virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>
>I'd prefer to move this before the virtio_reset_device(), because the
>comment on top of that is related also to the next steps (detach unused
>buffers), so having this in the middle is not really readable.

Sure, v4 moves it right before virtio_reset_device().

>>+    /* After a failed restore no virtqueues are live, and a second
>>+     * del_vqs() would free virtio-mmio's IRQ again.
>
>What will be the issue of freeing virtio-mmio's IRQ again?

Only that WARN. The early return is needed anyway: with vqs[] cleared,
the detach loops below would pass NULL to
virtqueue_detach_unused_buf(). I'll say that in the v4 message too.

Thanks,
Jerome

