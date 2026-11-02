Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611005;
	b=raVf3D8xQyj9Cjkz1PrytLXgGoI+3bojOFw4BS4Vkn0IUK1cjs0zIna7z0OOFXU6yFXd
	 ITo1fcm1Yq6AAP8vkUwoTFgvXnKqThMuuzLZBA7etdWhEUhOEsGwF6v7+bAvxGFUyZEBK
	 bAc4kztZ7x1MoWRh0egKWFewcOJaxvfLSKANBBOzgttmk040ATtsgx7BV6MtAT46FGg6y
	 tdbku5LkLN6x1olApsj31GsNk7788v3iSKgTfkH+bG23Sypjb8LkwFP5ywUcbVHYR4q18
	 o6EY+VGSHLs8UeRmuzOd/ejtki9teRKcPKsNsEGWYc/4TIKIavzFHWnbigZOj6ZRCgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611005;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=p+woyHefhUJ+D1Y+JoQlWFFwwJpLXFkTN5Cudk0qVh0=;
	b=m7sfVcTNBYGEMi00ugAR1jgWz6QHNGr34ckPQWLDBIfV/PMyw789tRi4H1AjsEcVEsTr
	 ohxtZl08Z4Dzon8s/TyLi3x94cvrT+1OFWbsU9v7ZF2EkHCvzFe6cRBdrIOotyM0eUa27
	 xE6BMjP4eAVzPwnmREpfXlKJslkUlmknW7iExn8T+yt2AOZkI906s5xKCAv3VLEq3Xgd+
	 FkWOg+zBtXab3IFRQC2sej5MUc7y/N2RULrpEqKPdt27Skyay6mUI2gbpMA2YWl1kMZtY
	 VWPtzc+O1stpEqmFzDPBMNrk4N2xG5CcwAn4mT9cGaknuE6s2jpwQYQm31gcPSMZe6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeMdmEoJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64C606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeMdmEoJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22331F000C1
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611005;
	bh=p+woyHefhUJ+D1Y+JoQlWFFwwJpLXFkTN5Cudk0qVh0=;
	h=Date:From:To:Subject;
	b=YeMdmEoJXLnPUzWH6OC0A7h0l4QuPDYIFkte2PJ16SczXSE82HmD89b9+a5evrdBb
	 KufcMu0cIWAL21DFqgLH0iLemHAoQhZNvgW8s0e6Hl9RvFBWRNiFqCp2di4omfIWt/
	 qr/vukQJZTwrUNhfQgkIsDwnA4Zv2SfAcBDqLJAf30QePVI5orgzIfzckQyCyQj38N
	 VqbWOUwnkE2hYBUzi87dBLbP+73Q9GOmhMCcaIoMURikU0nezU7Kvcx06JLbBJJupY
	 kOUjfro/12mmECcx/LaCnus3CUDjRIGjFasENp4kDhp02UbfGAvBUJNtAYabMPLprC
	 7eD20adw2snYQ==
Date: Mon, 2 Nov 2026 10:16:42 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: stable@vger.kernel.org
Subject: Send two commits to stable kernels
Message-ID: <auhU-oxrjzFoFctB@lpieralisi>
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

Hi Greg, Sascha,

not sure whether autosel will pick them up so just in case please
apply these two commits in the mainline to stable kernels, going
back to the kernels including the respective Fixes: tags.

It includes a DT binding change - it is important that it goes back
to the original binding commit.

commit 1d77e79d62cf ("dt-bindings: interrupt-controller: gicv5: Relax IRS
properties constraints")
commit 64212d63193c ("irqchip/gic-v5: Fix standalone IRSes OF probe")

Thank you very much.

Lorenzo
