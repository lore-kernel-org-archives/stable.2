Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875222;
	b=LRQ2f6xUQf/IyiE2ZbFTcny2v6CuihwdOXgTrTb/eE8PBTfg2ktE77hncL7ispkADJVT
	 QSAUhPa6fNJ6JCH/NPvZK1uuOxpazSt1NVi1ndwL1vxnt8ekiXiaxBq09oZTltp+fA7SH
	 Jrx9l40PpiAkUa+a2WX7UbJ5N8Cb/DaaVHSn/IGLsBUyUR3PGynhTtH+JP/GC2w72Za5H
	 jKgqquefIbwC9d6zdx+RjXkJPGg+8yq1Zh6IF7fvIeDrKznflpC9TyRRvpyn/6/Lq8AeL
	 d5CQGjEeQr4T9z8+uk8L/N2LJWS8ZkOYWxjgSnX/187QejGbgo+jCSjAURM2h35u29A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875222;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LsodqXcZa0UHB181ZZOcveL5yhIK0evm2ZkAitBAPEI=;
	b=2i/sgJZ28lDvzKTngs6w15jskmvwvd6qRApm34ST2RH6jzDyVn7n93LqgHXNElej/MW+
	 /TsmEDfHkVJHQPwIdzKmVErCqTLwJrPoUZdUFZn6p45ZxiQpFSjhpkQn1BazyHbHzXYCt
	 4Fj7ensOX7/jtbUP7ypbKdp8ToY4CdIS8rCfWVIR8OlAD4zwsn8/5tkQb6LjabtnSF8d7
	 OtZNfCEsLhfjAbBq/E4yuxRS0jgYO+m7hcmXN2iCdL6UExNIoY+NuMhCCYHiPsYD/CB28
	 ZhPlr7hs46rH57stgr6dhgIDL47b89J0dSxpirpuXBxdTQl+RCCcT0OMztXpX5QhC7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nW0MJA8y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542B606A325;
	Sat, 28 Nov 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nW0MJA8y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08D11F00898;
	Sat, 28 Nov 2026 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795875222;
	bh=LsodqXcZa0UHB181ZZOcveL5yhIK0evm2ZkAitBAPEI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nW0MJA8yt2Oq/PvWfW02oRhwcCr6slMH2qkxLs/c87z+kZ+VbtNIirAJlaOfj24uG
	 ySvqjy76mfruqnOA8TEusfSXVVf6ekSBzkgXHLAF/PUx6MzOYe6COsCkVFz3kX3EBi
	 l2ZPZkVJW7Xrk4YQIn0qJ4JHVqIvSSuZ513tsgWCHtC5KMeWk8SoWcJZ2dLFCSSSah
	 T62Twp37bPzs3jQg7l68tuR0AFSPaHiJvlP8xJZQmLDe+PqAj33T25t5pwssUzZbeU
	 CZW49Nk9FNCrT8xDwCcJDgzYUyZooc0K9jb5/vIdBsjOQA7UStUU0/aISYJS7tW1Ht
	 4w1CsJ0Du6Ecw==
Subject: Re: [PATCH v5 5/5] nfc: preserve NCI data status error codes
From: netdev-bot+sashiko@kernel.org
To: luob87709@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, johan@kernel.org, david@ixit.cz,
 kuba@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Sat, 28 Nov 2026 14:13:41 +0000
Message-ID: <179587522130.3135.16484405009456028236@kernel.org>
In-Reply-To: <20261127134029.1813-6-luob87709@gmail.com>
References: <20261127134029.1813-6-luob87709@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message understates how userspace sees the bug.
- [Low] In nci_nfcc_loopback_cb() (net/nfc/nci/core.c), the `else
  nci_req_complete(ndev, NCI_STATUS_FAILED);` branch for err > 0 is dead…

--

nfc: preserve NCI data status error codes

The patch changes the status parameter of nci_add_rx_data_frag() from __u8
to int. Before, the negative errno from nci_to_errno() was truncated into
an unrelated positive value. With the change, the original errno reaches
nci_data_exchange_complete() and the AF_NFC raw socket.

> For userspace AF_NFC raw sockets, this corrupts the reported error: for
> example, an NCI status error mapped to -EBUSY (-16) is truncated to
> 240 and negated to SO_ERROR=-240 instead of reporting EBUSY (16).

[Severity: Low]
Should this paragraph also describe what recv() returns on the raw socket
before this patch? The wrong SO_ERROR value doesn't seem to be the only
symptom userspace sees.

With the old __u8 parameter, -EBUSY arrives as 240 and gets passed down
this path:

nci_add_rx_data_frag()->nci_data_exchange_complete()->
  rawsock_data_exchange_complete()->rawsock_report_error()

net/nfc/rawsock.c:rawsock_report_error() {
    ...
	sk->sk_err = -err;
    ...
}

That stores -240 in sk_err. On the next recv(), sock_error() returns
-xchg(&sk->sk_err, 0), which is +240.

__skb_recv_datagram() only retries on -EAGAIN, so it returns NULL with
*err = 240. rawsock_recvmsg() then returns that value as is:

net/nfc/rawsock.c:rawsock_recvmsg() {
    ...
	skb = skb_recv_datagram(sk, flags, &rc);
	if (!skb)
		return rc;
    ...
}

So userspace sees a successful read of 240 bytes with nothing copied into
its buffer, and 240 can be larger than the buffer it passed in. The other
mapped statuses behave the same way: -EBADMSG gives 182, -EPROTO 185,
-ETIMEDOUT 146, -ECOMM 186 and -ENOSYS 218.

The code change fixes this path as well. Could the commit message mention
the phantom read so stable maintainers can see the full impact?

> diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
> index 3bbebb9505545..4a2326a337649 100644
> --- a/net/nfc/nci/data.c
> +++ b/net/nfc/nci/data.c
> @@ -213,13 +213,11 @@ EXPORT_SYMBOL(nci_send_data);
>  
>  static void nci_add_rx_data_frag(struct nci_dev *ndev,
>  				 struct sk_buff *skb,
> -				 __u8 pbf, __u8 conn_id, __u8 status)
> +				 __u8 pbf, __u8 conn_id, int err)

[Severity: Low]
This isn't a bug, but with this change the err > 0 branch in
nci_nfcc_loopback_cb() can no longer run:

net/nfc/nci/core.c:nci_nfcc_loopback_cb() {
    ...
	if (err) {
		kfree_skb(skb);
		if (err < 0)
			nci_req_cancel(ndev, -err);
		else
			nci_req_complete(ndev, NCI_STATUS_FAILED);
		return;
	}
    ...
}

The else branch was added in the earlier commit "net/nfc: fix skb
ownership on data exchange errors". At that point, the truncated status
coming out of this __u8 parameter was the only source of positive err
values.

After this patch, nci_add_rx_data_frag() passes only 0, a negative
nci_to_errno() value, or -ENOMEM. The other callers of
nci_data_exchange_complete() pass -ENODEV, -ETIMEDOUT or -EIO.

Could nci_nfcc_loopback_cb() be simplified to always call
nci_req_cancel(ndev, -err) when err is nonzero? Leaving the positive
branch in suggests that positive NCI status values can still arrive there.

>  {
>  	int reassembly_len;
> -	int err = 0;
>  
> -	if (status) {
> -		err = status;
> +	if (err) {
>  		kfree_skb(ndev->rx_data_reassembly);
>  		ndev->rx_data_reassembly = NULL;
>  		goto exit;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127134029.1813-1-luob87709%40gmail.com
