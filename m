Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604108;
	b=MFcG31UIgHRDRwSL1RbtNXaoW5+O4mNec5wAaUcqSUT012rIH8VhFSpmrZ5WlDP7iAgB
	 8RRBDm9hq7PsyZHYYswsTnilj7KuZxYPf8xGEISpvUEY3xVl0eHVCRWush2NnYvrI1ZDN
	 ZQ6rCle/PuXWkV/+u/IPb2bctZn/5MuOf/JNlLbLBcKp8H0/FYJVjvupOGd4NEq89pn4t
	 u4yannybdVb3VEBOOk+hYfJZkkKKYmQjPELtKJvTpwHkN/XOCCE4pKh7vYGvP1Jt3ZRfv
	 8zfdXQBR2EyFGjTFzsAsk+ayq3FUzK8csCipCRakIBiij6f6PqjoNfHioLP8tJwCIMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604108;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=otmMSTCuvsJ6UTk79RPkyL0EYsvw/uUkUKUkDiWOIok=;
	b=Ubox0jYPdpSKyqk67MBaFVeWHkBh5CREG3h/uOpi3AZTtlxRG7h+ERoGN25h0CaUwBUK
	 Wtv0IU7kJAXVo6V5dlD14WKDF1I3lOyv5Y4ZOCkDNBd7DrARi9vHRUUBee7nEqQiDIOf2
	 b500LqqoDUSkaSlG1DXLKPzbviNTj3v+dNZHoP9yY3U7SitOkEt7uHXcMTzsEZLgfrWxL
	 byQrIK45F0Q6qYltOV4XPumnN05Wy4z5HDu2pXX0Vz5DP2JgbBuD5Icay1EtbyTA7JP6+
	 YD62ao8rYSuU8RSNCeuECiqXaD7gU1lAWAWbbR5aFTTCWRVkcMMlMjaTEL+PVSssZMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=mqwTe0LQ;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DF606A327;
	Fri, 13 Nov 2026 21:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D61DF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=mqwTe0LQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=otmMSTCuvsJ6UTk79RPkyL0EYsvw/uUkUKUkDiWOIok=; b=mqwTe0LQY8+9MAO5MUFfilqs4I
	tkQhfewvA2M+CruVyyrxWrOxgtXl5MJ3oXt4un/vqbjGpvqhG8c3SkDlVHTzYmUC/Edy42PnenbPA
	g08EAC8SsSCulAs0ekNH8rPzNfs/2khzxuJ6mrc1db+QKteLo/PS0/q9UpUl5LQF27XQ1T9ARKUNj
	ZAz0cMIv7dtIvjpGQZ5ilnXQVDrsWqb+HYOLQXcqA5DrgQxv6QtXd7t7+43gaL9QjDzTRhkgady1n
	0F9WCnmAGE96ySQl2ItOYi1NER29TRsHoZHwGk0a26tKYilBQSJ0SPq/o8OP/WAlDnjXlVRVOvMFx
	FgMz5qAw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Jonathan Schmid <kernel@picomail.one>
Cc: Heiko Stuebner <heiko@sntech.de>,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-sound@vger.kernel.org,
	luca.ceresoli@bootlin.com,
	robh@kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Pull down the eMMC data strobe on RK3576
Date: Fri, 13 Nov 2026 22:08:05 +0100
Message-ID: <179460406456.1165597.1652547099683766610.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109145022.75261-1-kernel@picomail.one>
References: <20261109145022.75261-1-kernel@picomail.one>
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
Content-Transfer-Encoding: 8bit


On Mon, 09 Nov 2026 15:50:22 +0100, Jonathan Schmid wrote:
> The eMMC data strobe (DS) is only driven by the card while it sends data
> or the CRC status token; in between, the card releases the line. RK3576
> configures emmc_strb with pcfg_pull_none, so DS floats between
> transfers.
> 
> In HS400 the host samples the CRC status token that follows each written
> block with DS. With the floating line it misreads the token now and
> then: the write ends with a data CRC error and is retried. Nothing is
> logged and the data ends up intact, but the errors show up in the
> controller's err_stats in debugfs, and write throughput drops.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Pull down the eMMC data strobe on RK3576
      commit: 330f3d6b0bd5e8694c7b80791444f70d2535912a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
