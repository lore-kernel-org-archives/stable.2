Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312403;
	b=QoCvpPp2B8Q6eUjijVarlY3vS+VLpFnpCIlEUQ506pIVkYr+LslWuU3J7QQD4cErx5Il
	 RZf4PcyYYkZ7OiVuNxtuPR352G3OTIqMhoMc2B2m9l5snXv6Z3G6xvk59k4F06Egujyz5
	 URUAmVJl2dXUjtg3TYrDoVC9oMopLez9ASVbV3H+nlBGRxPOSNtv+QTLiX5AA2sxbLwwV
	 bgtmJfjGMJ+tq8qk0fJwX6CjJU5Tq7TOVYZRtKM9xqHp5scIwgYQd//AxWrDYS8SjMEWS
	 /bzC400NyJUfCpSTNlO60gLHPLVuEn14GuRuIXFSR3IlHnbtWki2+xRBRXORaUNWREw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312403;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=0Y3uJ0syuEB+M6JsDkOhH+hTZjk9QMarfG2dMbQOK9E=;
	b=CEnbYDD21T96Ijz2pijlIw3Gw38v/qntVmuAzkJpjgRtcTNbk/t3t1DcJLaw3HkUCa9T
	 Qxt47kqIBs8ZOO9BLajYoccISOnDwxs3It0jCaYYw4FMzNp+YG0fTuZ2W5LdZIhi+jkCu
	 zAJSg3fIVQ9h7sGP9Zv5oH0QaqvAZNVMj25fRCFM7dvG5Xjaevc19Yyufd5NJWAIB+k28
	 DIXop99YK4QhzzBf7Kks1Kq2daznqI6kmUKl65XpFPr1W1X6jJNU89iK4zfZe7DDsvBiF
	 H6znCWz8sMRnjMkO7zhhe+CbeD4Ah568OmYRCKw/KZM4w1DqoXAhFdXkABB/i+eUaNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIdBtlJo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA209606A321;
	Tue, 10 Nov 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIdBtlJo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2961F008A1;
	Tue, 10 Nov 2026 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312402;
	bh=0Y3uJ0syuEB+M6JsDkOhH+hTZjk9QMarfG2dMbQOK9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIdBtlJoSOGehU2ycNn7tJ7KGjJrUZtmC9Arkc7KARa3VY0je96bTmGNLPiBOwemZ
	 eXTQJH3GjGmbY9Umcka3FS7afVKxVLtZkTsBxgdK729NIEVytCjPi7ETxtmrwoqYk8
	 z5s1Q+efgzFs1z9gEFcyP0pPr3nxAL+PMRiUTYdwEat7k4ICPEJO2mur0MVlIoinip
	 jW4dOLacJj+glkmtmxrrywy77j53oOoeKlAdiHGC+BSLGxDJoA+4S2yD/ZQ/GY8E/+
	 LNMmoMYRXDBkVF3S+I5qExtiMW3fTq/b5lABSnorjHY1F6DnmJbGBNgVR7RF7wDX0y
	 SgfDHzh/wzIvQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Hyunjung Ko <hj351016@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] ata: libahci: delete the SW activity blink timer on port stop
Date: Tue, 10 Nov 2026 13:05:53 +0100
Message-ID: <179431233675.231492.2022512763173311216.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110105040.2483806-1-hj351016@gmail.com>
References: <20261110105040.2483806-1-hj351016@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=cassel@kernel.org; h=from:subject:message-id; bh=cL3XFvquJ8SBPm6BxcBI6grUqhwtLU9qFgskVPhWfK4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLI+c2yXc9kfcXGl47Tej6XTN6eq+W1u/R+qc0/Q6f7dq 5w9TG2FHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZgI03KG/7kPT0mE/uvKL5xe 5NB1VUmDJyt+Ue7k6zdVOz0ezxWwOMnIsP2Q4/uXx5v+1XAfOpOl8i5tncCr3U+qlshvao9NbN/ dwQAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Tue, 10 Nov 2026 19:50:40 +0900, Hyunjung Ko wrote:
> The software activity LED support arms a per-EM-port timer (emp->timer,
> ahci_sw_activity_blink) from ahci_sw_activity() on I/O, and the timer
> callback re-arms itself while the LED is blinking. The timer lives in
> struct ahci_em_priv inside the port's ahci_port_priv, which is allocated
> with devm_kzalloc() and freed when the port is torn down.
> 
> ahci_port_stop() never deletes this timer - nothing in libahci does - so
> when the SW activity LED is in use and the AHCI port is stopped (driver
> unbind / module unload) while the blink timer is still pending,
> ahci_sw_activity_blink() runs after ahci_port_priv has been freed and
> dereferences the freed ahci_em_priv (use-after-free).
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: libahci: delete the SW activity blink timer on port stop
      https://git.kernel.org/libata/linux/c/0c5f6cd1

Kind regards,
Niklas
