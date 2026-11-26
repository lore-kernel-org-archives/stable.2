Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722572;
	b=KFa2XJo9oy5QC5fbJG4dAUlqB2DLIP1Y0G1zKgFA8tWlTeSFRCbLkNySraq3SdAuKv/2
	 n1MGBN1H1vygA7WlhMmV2LRlYIhgQmJxOrlCEQL8K++SPcklcO7kbVOo1cBfQdOAYQFTT
	 3+Us7vMxivetyGXgECxJ4qiyL+Q9KjEAYj+Nm6W72p0YEKDnSftOFH90o7Wjco/TAIv9U
	 5R+vdA3uqF+OSJ9padBAsr/A5cr2K4ASoDZ+uTz/CdCNKkjOEXflxymjVhW0zy+Pgy9y1
	 0RQC4P7bfyMWeuaxHdGMELfbHH8Z/5TyBTLgb57uFdI5b0NVxn57YtZZ7YegTX/BF0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722572;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=aYGmoMTmJkngVzqtbH0SNV5TQrEpwmgyD+vEmY6KUTI=;
	b=JKfxWapycraebvtqJJEhGo0Ys1pm6R4I3yHcGKNxxQQbneCf37xhu7BvBhqMa7ADksgd
	 crOiN4dJL/uwX5c1mbay6od/uUagvv23Mby5NfnQC2QhF9IZovtKDZATt9BJZj3LPBZ57
	 74jZPdFlYHwWg86x+g1XSCIQtXP5vLsm+5296ZqRJJkCCjfGufrt7YB+qoZPj/Hy/RizK
	 QxDr7zCWxT6V2VJRTglhRvkLkP4jjxtezjcWCgjbqlxXOaRYwHAVEOeZDEA3qGx3HOfbb
	 ZxCav3CT8AgaiMGF241HSP9Qc/c+vC+CnNwlJAVW2KMfp9z6wT0weBT2jdTqu1my7WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=GWqNYzM+;
	arc=none smtp.remote-ip=109.224.244.123
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF6606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EF6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=GWqNYzM+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795722569; x=1795981769;
	bh=aYGmoMTmJkngVzqtbH0SNV5TQrEpwmgyD+vEmY6KUTI=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GWqNYzM+2LZDGeBHBXAZCBpjE7/M74qW6Q3IfNOxPTXP2ciR6pHw9UCs12FXhXBB3
	 NnZWnBAe82BvjhP4MC7OGA5fDtuXpB6pgq3VBgZn9HhR+vJhcKLD2vtPFi2Kiyc0Hp
	 C8cp9o7iTni4TpVnjVVwG0VZ87degWAtbzpfco0MkXvehXlPiwlUeNgwvCA6FIAp7Q
	 Gzq4TkPPVpLZYdP96SuMyifd+JHZm/5EdWSZyscXNnBzqR23ERANETaekohNlF8k3W
	 rc64J4eieUS7r8KUTVtAT/wt+jmc+Vk/G8OCsP0gbxI/ycV7pl4v3m5KToriAGNerO
	 Xs9TtRIgMXxTg==
Date: Thu, 26 Nov 2026 19:49:25 +0000
To: moritz.froehlich@student.uni-tuebingen.de, stable@vger.kernel.org
From: Max Brandtner <maximilian.immanuel.brandtner@protonmail.com>
Subject: Please ignore the prior mail
Message-ID: <f3ed188950461779341e5f58df784f424ce616aa.camel@protonmail.com>
In-Reply-To: <20261126183149.3123386-1-maximilian.immanuel.brandtner@protonmail.com>
References: <20261126183149.3123386-1-maximilian.immanuel.brandtner@protonmail.com>
Feedback-ID: 42508046:user:proton
X-Pm-Message-ID: b1f4952cf81881944bf10d93bd254d47d1da7d57
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

Please ignore the prior mail. git send-email added lkml to CC
accidentally.

I was helping someone to debug an issue they experienced on their
thinkpad and an LLM that was used throughout the process suggested the
issue might lie with a kernel bug. I sent it to him to validate the
patch, understand what the patch does, and if he so chooses send a
finalized version of this fix. I don't have the resources to validate
this issue myself (I lack the hardware), don't understand the subsystem
and would prefer if he took things up from here instead.

Kind regards,

Max Brandtner

