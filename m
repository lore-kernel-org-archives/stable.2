Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503323;
	b=fr+QAxBdnZuIbQ+V7fL1cLX/d0Ps1KGbuS/Ohhio8HpoY0Isw5dQFvees/yrpsHsTUW4
	 grPa3tXAWcRZwXSZs8WUPf8qt7zHpvXwzPslKhM4UbNgCqlTlyvDZahuS5/t9r5LTU0wm
	 AfBRT8ZF0M8+OSw9YuHL5+ZZXq8o3Lk2NoJueE78ouQxOMeQ5LB5yeFH278Alj5kFn2h+
	 gCBVa/JIit7Emfmfh2q4elseBHYsHLgt52385+RqIGQDQNjLBdZ5yv61pB7/dnqA2zfzh
	 m+DsmIuRMfs4MNhX57U/o6Nmi6UCePBYFaJzjHI4EFiNRx8Vs90xQ9LSKL9NihA3pYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503323;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TgMg8cnKeGaOn1fh1GwgmxkFpMpIpPJnVBjPPAyDeV4=;
	b=EbwkjCyqOTtKy0UJQWLmuMZ0m8T979kWnhn/rmfGEf6fD6UK8IAdDkk/A8Qt5j1vlLUA
	 nO5y0xU3odt+QwG/93Kl5nM+zEkF60KZ8j2rbiDkgErpj7iXvLQFLFvr0c8yr6BOwg07G
	 P3KVMhK/vEBg7H+MDJSPFa5yZzB81Wu+SY48/aHLcYSRfe0tk05Hg8Z09oFSPAOs0bsfD
	 cjSU+GM/HdEJV8TzvZnddlMr2qJsm8J6LdGHrj3M1aeEkCV87Yu2eU9j3zieZmjVTzVK0
	 3vrrRP95cB6rPzZVeOfSVkVgyYyA8AB0d3G6YbYYVyURBkBQx+xnEya7eZW0UWmcPBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqH+Z9Jh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB578606A327;
	Tue, 24 Nov 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqH+Z9Jh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048251F000C6;
	Tue, 24 Nov 2026 06:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795503322;
	bh=TgMg8cnKeGaOn1fh1GwgmxkFpMpIpPJnVBjPPAyDeV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lqH+Z9JhrLkNuswKiOV3R+y4DNBmImUp/NHnyP7CrYx0LY+PLwPNQpb+CPMt6e1KS
	 NB2brULf1cVw9zXR2DzuqJzrZPZDBtrJrIZzdj8ndEagseHmPa0Pk706n3nNQgS9F2
	 sNAfOO5QjbbaKms8t6eqyldkcuqiZUaE0zurQmj+1fUeHDVF9rbE/qQteK4W1/u4VM
	 tVq4gCPscfxZ91M+/EzYOj/bo/511KMteFmKLjd1tgE4SBTd0iqCrwjStKxSD70jJL
	 FPwO3UiLx3d52UtPrHjOr0MqvG3OgHIJFWtixUOaUn8mHYjZM7PGqpwBqLmjEum1NK
	 ogWB8B//8wVNw==
Subject: Re: [PATCH v3 2/2] nfc: preserve NCI data status error codes
From: netdev-bot+sashiko@kernel.org
To: luob87709@gmail.com
Cc: oe-linux-nfc@lists.linux.dev, johan@kernel.org, david@ixit.cz,
 kuba@kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 06:55:21 +0000
Message-ID: <179550332158.3135.4466298540445819272@kernel.org>
In-Reply-To: <20261123063310.1267-3-luob87709@gmail.com>
References: <20261123063310.1267-3-luob87709@gmail.com>
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

- [Low] The commit message leaves out the user-visible effect of the bug,
  even though the patch is tagged Cc: stable.

--

nfc: preserve NCI data status error codes

This commit changes the status parameter of nci_add_rx_data_frag() from
__u8 to int. The negative errno returned by nci_to_errno() then reaches
the data exchange completion path without being truncated.

> nci_to_errno() returns negative errno values for nonzero data-status
> bytes. Passing that value to nci_add_rx_data_frag() through a __u8
> parameter truncates the errno and changes it to an unrelated positive
> value before the completion callback receives it.

[Severity: Low]
This isn't a bug in the code change. Since the patch is tagged for stable,
though, could the commit message say what userspace actually sees?

For frame-interface targets, nci_rx_data_packet() makes this call:

    nci_add_rx_data_frag(ndev, skb, pbf, conn_id, nci_to_errno(status));

With the old __u8 parameter, -EPROTO (-71) became 185 and -ETIMEDOUT (-110)
became 146.

On raw NFC sockets, that positive err takes this path:

    nci_data_exchange_complete()
      rawsock_data_exchange_complete()
        rawsock_report_error()

rawsock_report_error() then does this:

    sk->sk_err = -err;

As a result, sk_err ends up negative (-185).

In __skb_try_recv_datagram(), sock_error() returns -sk_err, which is +185.
__skb_recv_datagram() stops retrying because the value is not -EAGAIN.
rawsock_recvmsg() then returns the value unchanged:

    skb = skb_recv_datagram(sk, flags, &rc);
    if (!skb)
        return rc;

So before this patch, recvmsg() returns 185 and copies nothing, instead
of returning an error. With the patch applied it returns -EPROTO.

Would it help stable reviewers to add a sentence like this? "For example,
for raw NFC sockets this sets a negative sk_err, so recvmsg() returns a
bogus positive byte count with no data instead of an error."

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123063310.1267-1-luob87709%40gmail.com
