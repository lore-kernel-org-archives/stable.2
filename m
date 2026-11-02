Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635516;
	b=mkXPJ1PKKT2ca7QXu3VWod4llmBpefbGGnSk9DamTkN9FGnho4yBX4EtD+U3wIhDgkGB
	 TgQ9J1urxG3wboIxH7o+L9OYhh4Dsnto6cGFmz+gftNH/1m/sFaXVnBJJlKJx3S8uRWHg
	 wW9noTyfYmsW4vQggBUREg06XiG1iXtCGugWaVsPQiTU3djsc8aL18WX5m2ZRon0PWsmM
	 tvAzyRVWDN9jyXKoor9ot99+EcPflpwuAAJa4aKRaBfpiaAz4y/p89jkov+37PcHbwOMq
	 keT4i3wmTSszk+GVd0FPLkbWlS8sHrQC/QJwLL3kt5Sd+Pn0k3F+JRkHyKiFkAcWpvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635516;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fn+IGS1PWUzGRxUFhc8drAIGJIJiidkNwwEu0xN1YZk=;
	b=b2uRoZHuf5x9lKwj3vXvdxmiXxV15vbbYCtNpzwm5UGoxqsbWn27dWFANVH8l1pU7rJU
	 ur9phHSrXwjnkRQIctx7TwCswZN1OmKWFWtimFR7ny46ff+CytYcILrM1ad4PaYTy+U9t
	 A/1kW325wlhBaDESqmwP3CtAuruumR1/5lzKEsFVAEK3hhvbXMmpXZ1Zr5Dp+4Pk/pux4
	 clajyntyP8OYyRUtkL5zhF0dWErDRb4A08TY7fx4bFtnpwx53JUN/5Dklzg9Ub2HcSjfb
	 jZ5daWlAQ+WyRcMTJUx5hZRntwIN8l6azeRIUyYe54LZUfqh25LJJBrkzOaTWl5AvdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIymGJ+d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5B60703B9;
	Mon,  2 Nov 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIymGJ+d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CDD1F00A16;
	Mon,  2 Nov 2026 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635516;
	bh=Fn+IGS1PWUzGRxUFhc8drAIGJIJiidkNwwEu0xN1YZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LIymGJ+dwkOT80Gm0Pallq2aTR6KoqaDGB2ntqY9ZXdgx+DybRYhOU14H52N1aAtv
	 B1jgegT0ySUnBfO2LDSnJGrzUF0LSDps4ryEGxlh+HVB85igwoIbyo0vCZ46BhCM3M
	 zISvkJ8AXHj5Yv8owNDqonNKYzekZtyB+gqOMNNQdyNDdLkZiiE1EYW6fMF6KCCSFx
	 +8C0KXPjuRWdrfy1RWAr0ZG2O020U+mJ0mgNaxZfAt87SiJ9CbPZi/JnZutpnnfVnD
	 gONWmHIUFCBdcht6g9uxy7aoknF9xPZ9aHl9hM8ve+0DLcbnsEAhifcQuXj5gYO8MG
	 UHjarX8TgY8dw==
Date: Mon, 2 Nov 2026 17:05:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Marco Ziliani <rylos78@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Kyrylo Biryuk <illofspeed@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell
 88SM9705
Message-ID: <aui0uB-EkF7MKOGb@ryzen>
References: <20261028-pmp-88sm9705-v1-1-cf951fe74573@gmail.com>
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
In-Reply-To: <20261028-pmp-88sm9705-v1-1-cf951fe74573@gmail.com>

On Wed, Oct 28, 2026 at 08:50:18PM +0100, Marco Ziliani wrote:
> I don't have this hardware myself: the problem was found and measured
> on a DX1215 by a user of synodeb (Debian on Synology NAS units), who
> preferred not to send the patch. It is carried in the synodeb kernels.
> 
> Kyrylo, your DX1222 has the same 88SE9235 + 88SM9705 chain: if it shows
> the same port 5 retry loop, a Tested-by would be very welcome.

A Tested-by would be nice here :)


Kind regards,
Niklas
