Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778873;
	b=3f15OaNmQslTa7FHsFNuSpq1pe5LpI2mEe3iFfJaNDZwkO1dw6HlijSQLrh5YJ86mmLP
	 jV5sn2XyCB5rVvgvQm4bAFVyD4fJOxGLKrsP+yHyjECRhutIx9rtyx+TmOS9pkPVBFbpJ
	 9CJGuNW4d9QJXXO9KZF9hkFR245F69HfzL9p8bv7m3Mp14e99PJH8MkW8/aDx1RgOFagP
	 eeEvtVG+I3GUBjN7RqUguUHTeNyKo1ETYD5nVwjNbNV2IvD2ZMFvwA5lMA3m7+DhIu3nn
	 ws9/zTA3HRL8WrSa6uz3J/Z5plmyHjkBiNB2wqGfiNXTSORHlmiO6hrcj4lehMwpDwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778873;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=N3nFkOyWEZUrBywjXvTS/ShHOyqMLlaqIfDDq1MDiSU=;
	b=QIJVbdcAf8ay13OVI3jcift/lTuO9Mc0tgruD8ZE1op8ssBHxDS1uU9XBlTM3zplR+bW
	 wpBQIvtdNmAgfEXlHJj4qx6R33kLcAmXuTpdg6wTCo85uffY3nfxNqKf7+0ZdzXS7SWaT
	 tJ59wW/hNKh2bdTX74ATqhpjyvOmych9bu2GE5QN5OtmIVJ6PBtp7k4IVjVcXyyEnmXOs
	 2rYwKL24lfwLnpwl/hTuDLi2HrkRx5HhOumgUqcZnIHm16pvLIZTrb+zbqDS/v9b1YOOM
	 G6H5EjSfeNwWhTIE81mXDylwaK3uMACCUUnE+FJPygzoubzvRwLKRfws1t03r6CG9bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UUb3Rzex;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uy7OQGPk;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11606606A323;
	Sun, 15 Nov 2026 21:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11606606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UUb3Rzex;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=uy7OQGPk
Date: Sun, 15 Nov 2026 22:41:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794778870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3nFkOyWEZUrBywjXvTS/ShHOyqMLlaqIfDDq1MDiSU=;
	b=UUb3RzexVl+5dLWsvCL26n1beDhzGqP32LQfYs/xr7BrKDRnrxzxS3M6RmBTbb3al1EEU+
	u/XnPtA+liiMl7REVQvLng51apRKpDEXesM6D2PdHy0DgDrLx1323hh4oG2yWL6LF+yFHw
	+3OTk/o4sVppu5xhb+OyK6S4rmXcciggyy8gnY/irpMMj9uXqDCs3VhHlcNZWJLGXisPoG
	rVDHX85AzqpJZxDTJu1j8JoxSQysZU2irDJdAzqjjw3ysgeHMh4dbMaFyums60+R4+THkm
	3W++9rlly9CO6fEg6WqlSXfZwtDDFRNlmVw79NtaG78zNUTggTVoOyQi+SE6Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794778870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3nFkOyWEZUrBywjXvTS/ShHOyqMLlaqIfDDq1MDiSU=;
	b=uy7OQGPkNrSCUEgyT+RyGaqm9OcvTYlCAH190cmyNf9CvWK99nZmfd34MbjmK2ENuN9GGd
	7llutqTwQW/P/wDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Xie <xiexinet@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, shuah@kernel.org,
	kees@kernel.org, petr.wozniak@gmail.com, qingfang.deng@linux.dev,
	fmaurer@redhat.com, luka.gejak@linux.dev, xiaoliang.yang_1@nxp.com,
	skhawaja@google.com, liuhangbin@gmail.com, stable@vger.kernel.org,
	sdf.kernel@gmail.com, lukma@denx.de, fmancera@suse.de,
	danishanwar@ti.com, richardcochran@gmail.com
Subject: Re: [PATCH net v9 3/4] net: hsr: segment GSO before per-frame
 forwarding
Message-ID: <20261115214108.UmIyEJ8I@linutronix.de>
References: <20261112153333.20-1-xiexinet@gmail.com>
 <20261112153333.20-4-xiexinet@gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261112153333.20-4-xiexinet@gmail.com>

On 2026-11-12 16:33:32 [+0100], Xin Xie wrote:
> @@ -794,3 +797,158 @@ void hsr_forward_skb(struct sk_buff *skb, struct hs=
r_port *port)
=E2=80=A6
> +void hsr_forward_input(struct sk_buff *skb, struct hsr_port *port)
> +{
=E2=80=A6
> +	consume_skb(skb);
> +	while (segs) {
> +		next =3D segs->next;
> +		segs->next =3D NULL;
> +		hsr_forward_frame(segs, port);
> +		segs =3D next;
> +	}

Should you repost:

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 9aefc5f0249f6..5e49f2bb9e39b 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -940,11 +940,9 @@ void hsr_forward_input(struct sk_buff *skb, struct hsr=
_port *port)
 		goto drop;
=20
 	consume_skb(skb);
-	while (segs) {
-		next =3D segs->next;
-		segs->next =3D NULL;
+	skb_list_walk_safe(segs, segs, next) {
+		skb_mark_not_on_list(segs);
 		hsr_forward_frame(segs, port);
-		segs =3D next;
 	}
 	return;
=20

Sebastian
